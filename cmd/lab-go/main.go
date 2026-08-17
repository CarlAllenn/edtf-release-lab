// Command lab-go is the go-binary class's fixture binary: one line of
// output, built on four native legs and proved bit-for-bit reproducible
// by the release's repro gate.
package main

import (
	"os"

	"github.com/monumental-archive/release-lab/internal/labgo"
)

func main() { os.Exit(labgo.Main(os.Stdout, os.Stderr)) }
