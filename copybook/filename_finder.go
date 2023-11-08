package copybook

import (
	"io/fs"
	"path"
	fp "path/filepath"
	"strings"

	"github.com/kaisawind/cobol-go/gen/preprocessor"
	"github.com/kaisawind/cobol-go/options"
)

type FilenameFinder struct {
}

func NewFilenameFinder() *FilenameFinder {
	return &FilenameFinder{}
}

func (f *FilenameFinder) GetCopyBook(ctx preprocessor.IFilenameContext, opts *options.Options) string {
	for _, v := range opts.CopyBookFiles {
		if f.isMatching(ctx, v, "", opts) {
			return v
		}
	}

	for _, v := range opts.CopyBookDirectories {
		filepath := f.GetCopyBookFromDirectory(ctx, v, opts)
		if filepath != "" {
			return filepath
		}
	}
	return ""
}

func (f *FilenameFinder) GetCopyBookFromDirectory(ctx preprocessor.IFilenameContext, dir string, opts *options.Options) (ret string) {
	infos := map[string]bool{}
	fp.WalkDir(dir, func(path string, d fs.DirEntry, err error) error {
		if !d.IsDir() {
			infos[path] = d.IsDir()
		}
		return err
	})
	for filepath := range infos {
		if f.isMatching(ctx, filepath, dir, opts) {
			return filepath
		}
	}
	return
}

func (f *FilenameFinder) isMatching(ctx preprocessor.IFilenameContext, filepath, dir string, opts *options.Options) bool {
	identifier := ctx.GetText()
	if dir != "" {
		return f.isMatchingWithAbsolute(filepath, identifier, dir)
	} else {
		return f.isMatchingWithRelative(filepath, identifier)
	}
}

func (f *FilenameFinder) isMatchingWithAbsolute(filepath, identifier, dir string) bool {
	abspath, err := fp.Abs(filepath)
	if err != nil {
		return false
	}
	identifierPath, err := fp.Abs(path.Join(dir, identifier))
	if err != nil {
		return false
	}
	return strings.EqualFold(abspath, identifierPath)
}

func (f *FilenameFinder) isMatchingWithRelative(filepath, identifier string) bool {
	abspath, err := fp.Abs(filepath)
	if err != nil {
		return false
	}
	abspath = strings.ToLower(abspath)
	relativePath := strings.ToLower(identifier)
	return strings.HasSuffix(abspath, relativePath)
}
