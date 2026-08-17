package labgo_test

import (
	"bytes"
	"errors"
	"runtime"
	"strings"
	"testing"

	"github.com/monumental-archive/release-lab/internal/labgo"
)

// errWriter fails every write, which is the only way the command's
// non-zero exit is reachable — and an exit code no test can reach is an
// exit code nobody has checked.
type errWriter struct{}

var errRefused = errors.New("refused")

func (errWriter) Write([]byte) (int, error) { return 0, errRefused }

// Every guard branch gets a table row (the org repo law): both early
// returns and the split are each a row, so a branch deleted in a
// refactor takes a named failure with it.
func TestDescribe(t *testing.T) {
	t.Parallel()

	for _, tc := range []struct {
		name   string
		target string
		want   string
	}{
		{name: "canon target", target: "linux-amd64", want: "linux/amd64"},
		{name: "darwin arm", target: "darwin-arm64", want: "darwin/arm64"},
		{name: "empty", target: "", want: "unknown target"},
		{name: "no separator", target: "linuxamd64", want: "malformed target linuxamd64"},
		{name: "trailing separator", target: "linux-", want: "linux/"},
	} {
		t.Run(tc.name, func(t *testing.T) {
			t.Parallel()

			if got := labgo.Describe(tc.target); got != tc.want {
				t.Errorf("Describe(%q) = %q, want %q", tc.target, got, tc.want)
			}
		})
	}
}

func TestPlatformIsThisMachine(t *testing.T) {
	t.Parallel()

	want := runtime.GOOS + "/" + runtime.GOARCH
	if got := labgo.Platform(); got != want {
		t.Errorf("Platform() = %q, want %q", got, want)
	}
}

// Run's output is the smoke test's contract, so this asserts the same
// shape scripts/go-binary-smoke.sh greps for.
func TestRunWritesTheSmokeLine(t *testing.T) {
	t.Parallel()

	var buf bytes.Buffer
	if err := labgo.Run(&buf); err != nil {
		t.Fatalf("Run to a buffer failed: %v", err)
	}

	got := buf.String()
	if !strings.HasPrefix(got, "lab-go ") {
		t.Errorf("output %q does not start with the binary name", got)
	}

	if !strings.Contains(got, "answer: 42") {
		t.Errorf("output %q does not carry the answer the smoke test asserts", got)
	}

	if !strings.Contains(got, labgo.Platform()) {
		t.Errorf("output %q does not name the platform it ran on", got)
	}
}

func TestMainReportsSuccess(t *testing.T) {
	t.Parallel()

	var out, errOut bytes.Buffer
	if code := labgo.Main(&out, &errOut); code != labgo.ExitOK {
		t.Errorf("Main returned %d on a working writer, want 0", code)
	}

	if errOut.Len() != 0 {
		t.Errorf("Main wrote %q to stderr on success", errOut.String())
	}
}

func TestMainReportsAFailedWrite(t *testing.T) {
	t.Parallel()

	var errOut bytes.Buffer

	code := labgo.Main(errWriter{}, &errOut)
	if code != labgo.ExitWriteFailed {
		t.Errorf("Main returned %d on a refused write, want 1", code)
	}

	if !strings.Contains(errOut.String(), errRefused.Error()) {
		t.Errorf("stderr %q does not name the underlying failure", errOut.String())
	}
}

// The third code: the write failed AND the report of it failed. Reachable
// only because Main checks that write too, which is the point.
func TestMainCannotEvenReport(t *testing.T) {
	t.Parallel()

	if code := labgo.Main(errWriter{}, errWriter{}); code != labgo.ExitUnreportable {
		t.Errorf("Main returned %d when even stderr refused, want 2", code)
	}
}
