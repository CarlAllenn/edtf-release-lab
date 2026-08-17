// Package labgo is the release-lab's Go fixture: the smallest program
// that gives the go-binary class (.github#469, stele#7) something real
// to build, and gives the class's smoke test something to assert on
// every leg.
//
// It deliberately holds every statement worth covering — the command's
// exit-code decision included — leaving main a single line. The coverage
// floor applies to the module total, so a fixture whose logic lived in
// package main would fail its own gate for a reason that has nothing to
// do with the release path.
package labgo

import (
	"fmt"
	"io"
	"runtime"
	"strings"
)

// Answer is the fixture's one fact, matching lab-cli's so that a release
// shipping both binaries cannot disagree with itself.
const Answer = 42

// The command's exit codes, named because a bare `return 2` says nothing
// to the next reader (and the belt's mnd rule says so too).
const (
	ExitOK = 0
	// ExitWriteFailed: the line could not be written, and that was reported.
	ExitWriteFailed = 1
	// ExitUnreportable: the line could not be written and neither could the
	// report of it — the failure nobody would otherwise hear about.
	ExitUnreportable = 2
)

// Platform reports the target the binary was actually built for. The
// go-binary class builds every leg on its own hardware, so a smoke test
// comparing this against the target it was handed proves the leg holds
// the binary it thinks it does — the property emulation would break.
func Platform() string {
	return runtime.GOOS + "/" + runtime.GOARCH
}

// Describe renders a target named the way the class names it
// (<goos>-<goarch>) as the pair Go itself reports. An empty or separator-
// less target is reported as such rather than guessed at: the smoke test
// passes the class's own target string, so a disagreement here means the
// class and the binary disagree, which is what a fixture exists to catch.
func Describe(target string) string {
	if target == "" {
		return "unknown target"
	}

	goos, goarch, found := strings.Cut(target, "-")
	if !found {
		return "malformed target " + target
	}

	return goos + "/" + goarch
}

// Run writes the fixture's one line: what it is, where it runs, and the
// answer the smoke test greps for.
func Run(w io.Writer) error {
	if _, err := fmt.Fprintf(w, "lab-go %s answer: %d\n", Platform(), Answer); err != nil {
		return fmt.Errorf("write the lab-go line: %w", err)
	}

	return nil
}

// Main is the command, exit code and all, so that package main stays one
// line and every decision this binary makes is reachable from a test.
//
// Three codes rather than two, because the belt's errcheck counts a
// discarded error as an unchecked one and it is right to: a failure to
// report the failure is its own outcome, and a fixture that swallowed it
// would be modelling the habit this org refuses everywhere else.
func Main(out, errOut io.Writer) int {
	err := Run(out)
	if err == nil {
		return ExitOK
	}

	if _, werr := fmt.Fprintln(errOut, "lab-go:", err); werr != nil {
		return ExitUnreportable
	}

	return ExitWriteFailed
}
