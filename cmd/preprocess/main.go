package main

import (
	"flag"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"time"

	"github.com/kaisawind/cobol-go/document"
	"github.com/kaisawind/cobol-go/format"
	"github.com/kaisawind/cobol-go/options"
)

var (
	formatFlag   = flag.String("format", "FIXED", "cobol file format, FIXED, TANDEM, VARIABLE")
	pathFlag     = flag.String("path", ".", "cobol files path")
	suffixFlag   = flag.String("suffix", ".CBL,src,COB", "cobol cbl, separated by commas")
	copyPathFlag = flag.String("copy-path", "", "cobol copy book directory")
)

var (
	begin = time.Now() // 开始时间
	count = 0          // 开始计数
)

func main() {
	flag.Parse()

	f := format.FIXED
	switch strings.ToUpper(*formatFlag) {
	case "FIXED":
		f = format.FIXED
	case "TANDEM":
		f = format.TANDEM
	case "VARIABLE":
		f = format.VARIABLE
	}
	rootPath := *pathFlag
	fi, err := os.Stat(rootPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%s\n", err)
		return
	}
	if !fi.IsDir() {
		Process(rootPath, f)
	} else {
		filepath.WalkDir(rootPath, func(path string, d fs.DirEntry, err error) error {
			if !d.IsDir() {
				Process(path, f)
			}
			return err
		})
	}
	fmt.Fprintf(os.Stdout, "%d takes %s\n", count, time.Since(begin))
}

func Process(path string, f format.Format) {
	if strings.HasSuffix(path, ".preprocessed") {
		return
	}
	suffixes := strings.Split(*suffixFlag, ",")
	has := false
	for _, v := range suffixes {
		trimed := strings.TrimSpace(v)
		r := regexp.MustCompile(fmt.Sprintf(`(?i)%s$`, trimed))
		if r.MatchString(path) {
			has = true
			break
		}
	}
	if !has {
		return
	}

	start := time.Now()
	buff, err := os.ReadFile(path)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%s\n", err)
		return
	}

	copyPath := *copyPathFlag
	if copyPath == "" {
		copyPath = filepath.Dir(path)
	}
	opts := options.NewOptions().SetFormat(f).AddCopyBookDirectory(copyPath)
	processed := document.Parse(string(buff), opts)

	os.WriteFile(path+".preprocessed", []byte(processed), os.ModePerm)
	fmt.Fprintf(os.Stdout, "%s %s\n", path, time.Since(start))
	count++
	if count%10 == 0 {
		fmt.Fprintf(os.Stdout, "%d takes %s\n", count, time.Since(begin))
	}
}
