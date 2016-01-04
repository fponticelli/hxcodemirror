package codemirror;

typedef Commands = {
  /**
  Select the whole content of the editor.
  ```
  Ctrl-A (PC), Cmd-A (Mac)
  ```
  */
  selectAll : CodeMirror -> Void,
  /**
  When multiple selections are present, this deselects all but the primary selection.
  ```
  Esc
  ```
  */
  singleSelection : CodeMirror -> Void,
  /**
  Emacs-style line killing. Deletes the part of the line after the cursor. If that consists only of whitespace, the newline at the end of the line is also deleted.
  ```
  Ctrl-K (Mac)
  ```
  */
  killLine : CodeMirror -> Void,
  /**
  Deletes the whole line under the cursor, including newline at the end.
  ```
  Ctrl-D (PC), Cmd-D (Mac)
  ```
  */
  deleteLine : CodeMirror -> Void,
  /**
  Delete the part of the line before the cursor.
  */
  delLineLeft : CodeMirror -> Void,
  /**
  Delete the part of the line from the left side of the visual line the cursor is on to the cursor.
  ```
  Cmd-Backspace (Mac)
  ```
  */
  delWrappedLineLeft : CodeMirror -> Void,
  /**
  Delete the part of the line from the cursor to the right side of the visual line the cursor is on.
  ```
  Cmd-Delete (Mac)
  ```
  */
  delWrappedLineRight : CodeMirror -> Void,
  /**
  Undo the last change.
  ```
  Ctrl-Z (PC), Cmd-Z (Mac)
  ```
  */
  undo : CodeMirror -> Void,
  /**
  Redo the last undone change.
  ```
  Ctrl-Y (PC), Shift-Cmd-Z (Mac), Cmd-Y (Mac)
  ```
  */
  redo : CodeMirror -> Void,
  /**
  Undo the last change to the selection, or if there are no selection-only changes at the top of the history, undo the last change.
  ```
  Ctrl-U (PC), Cmd-U (Mac)
  ```
  */
  undoSelection : CodeMirror -> Void,
  /**
  Redo the last change to the selection, or the last text change if no selection changes remain.
  ```
  Alt-U (PC), Shift-Cmd-U (Mac)
  ```
  */
  redoSelection : CodeMirror -> Void,
  /**
  Move the cursor to the start of the document.
  ```
  Ctrl-Home (PC), Cmd-Up (Mac), Cmd-Home (Mac)
  ```
  */
  goDocStart : CodeMirror -> Void,
  /**
  Move the cursor to the end of the document.
  ```
  Ctrl-End (PC), Cmd-End (Mac), Cmd-Down (Mac)
  ```
  */
  goDocEnd : CodeMirror -> Void,
  /**
  Move the cursor to the start of the line.
  ```
  Alt-Left (PC), Ctrl-A (Mac)
  ```
  */
  goLineStart : CodeMirror -> Void,
  /**
  Move to the start of the text on the line, or if we are already there, to the actual start of the line (including whitespace).
  ```
  Home
  ```
  */
  goLineStartSmart : CodeMirror -> Void,
  /**
  Move the cursor to the end of the line.
  ```
  Alt-Right (PC), Ctrl-E (Mac)
  ```
  */
  goLineEnd : CodeMirror -> Void,
  /**
  Move the cursor to the right side of the visual line it is on.
  ```
  Cmd-Right (Mac)
  ```
  */
  goLineRight : CodeMirror -> Void,
  /**
  Move the cursor to the left side of the visual line it is on. If this line is wrapped, that may not be the start of the line.
  ```
  Cmd-Left (Mac)
  ```
  */
  goLineLeft : CodeMirror -> Void,
  /**
  Move the cursor to the left side of the visual line it is on. If that takes it to the start of the line, behave like goLineStartSmart.
  */
  goLineLeftSmart : CodeMirror -> Void,
  /**
  Move the cursor up one line.
  ```
  Up, Ctrl-P (Mac)
  ```
  */
  goLineUp : CodeMirror -> Void,
  /**
  Move down one line.
  ```
  Down, Ctrl-N (Mac)
  ```
  */
  goLineDown : CodeMirror -> Void,
  /**
  Move the cursor up one screen, and scroll up by the same distance.
  ```
  PageUp, Shift-Ctrl-V (Mac)
  ```
  */
  goPageUp : CodeMirror -> Void,
  /**
  Move the cursor down one screen, and scroll down by the same distance.
  ```
  PageDown, Ctrl-V (Mac)
  ```
  */
  goPageDown : CodeMirror -> Void,
  /**
  Move the cursor one character left, going to the previous line when hitting the start of line.
  ```
  Left, Ctrl-B (Mac)
  ```
  */
  goCharLeft : CodeMirror -> Void,
  /**
  Move the cursor one character right, going to the next line when hitting the end of line.
  ```
  Right, Ctrl-F (Mac)
  ```
  */
  goCharRight : CodeMirror -> Void,
  /**
  Move the cursor one character left, but don't cross line boundaries.
  */
  goColumnLeft : CodeMirror -> Void,
  /**
  Move the cursor one character right, don't cross line boundaries.
  */
  goColumnRight : CodeMirror -> Void,
  /**
  Move the cursor to the start of the previous word.
  ```
  Alt-B (Mac)
  ```
  */
  goWordLeft : CodeMirror -> Void,
  /**
  Move the cursor to the end of the next word.
  ```
  Alt-F (Mac)
  ```
  */
  goWordRight : CodeMirror -> Void,
  /**
  Move to the left of the group before the cursor. A group is a stretch of word characters, a stretch of punctuation characters, a newline, or a stretch of more than one whitespace character.
  ```
  Ctrl-Left (PC), Alt-Left (Mac)
  ```
  */
  goGroupLeft : CodeMirror -> Void,
  /**
  Move to the right of the group after the cursor (see above).
  ```
  Ctrl-Right (PC), Alt-Right (Mac)
  ```
  */
  goGroupRight : CodeMirror -> Void,
  /**
  Delete the character before the cursor.
  ```
  Shift-Backspace, Ctrl-H (Mac)
  ```
  */
  delCharBefore : CodeMirror -> Void,
  /**
  Delete the character after the cursor.
  ```
  Delete, Ctrl-D (Mac)
  ```
  */
  delCharAfter : CodeMirror -> Void,
  /**
  Delete up to the start of the word before the cursor.
  ```
  Alt-Backspace (Mac)
  ```
  */
  delWordBefore : CodeMirror -> Void,
  /**
  Delete up to the end of the word after the cursor.
  ```
  Alt-D (Mac)
  ```
  */
  delWordAfter : CodeMirror -> Void,
  /**
  Delete to the left of the group before the cursor.
  ```
  Ctrl-Backspace (PC), Alt-Backspace (Mac)
  ```
  */
  delGroupBefore : CodeMirror -> Void,
  /**
  Delete to the start of the group after the cursor.
  ```
  Ctrl-Delete (PC), Ctrl-Alt-Backspace (Mac), Alt-Delete (Mac)
  ```
  */
  delGroupAfter : CodeMirror -> Void,
  /**
  Auto-indent the current line or selection.
  ```
  Shift-Tab
  ```
  */
  indentAuto : CodeMirror -> Void,
  /**
  Indent the current line or selection by one indent unit.
  ```
  Ctrl-] (PC), Cmd-] (Mac)
  ```
  */
  indentMore : CodeMirror -> Void,
  /**
  Dedent the current line or selection by one indent unit.
  ```
  Ctrl-[ (PC), Cmd-[ (Mac)
  ```
  */
  indentLess : CodeMirror -> Void,
  /**
  Insert a tab character at the cursor.
  */
  insertTab : CodeMirror -> Void,
  /**
  Insert the amount of spaces that match the width a tab at the cursor position would have.
  */
  insertSoftTab : CodeMirror -> Void,
  /**
  If something is selected, indent it by one indent unit. If nothing is selected, insert a tab character.
  ```
  Tab
  ```
  */
defaultTab : CodeMirror -> Void,
  /**
  Swap the characters before and after the cursor.
  ```
  Ctrl-T (Mac)
  ```
  */
  transposeChars : CodeMirror -> Void,
  /**
  Insert a newline and auto-indent the new line.
  ```
  Enter
  ```
  */
  newlineAndIndent : CodeMirror -> Void,
  /**
  Flip the overwrite flag.
  ```
  Insert
  ```
  */
  toggleOverwrite : CodeMirror -> Void,
  /**
  Not defined by the core library, only referred to in key maps. Intended to provide an easy way for user code to define a save command.
  ```
  Ctrl-S (PC), Cmd-S (Mac)
  ```
  */
  save : CodeMirror -> Void,
  /**
  ```
  Ctrl-F (PC), Cmd-F (Mac)
  ```
  */
  find : CodeMirror -> Void,
  /**
  ```
  Ctrl-G (PC), Cmd-G (Mac)
  ```
  */
  findNext : CodeMirror -> Void,
  /**
  ```
  Shift-Ctrl-G (PC), Shift-Cmd-G (Mac)
  ```
  */
  findPrev : CodeMirror -> Void,
  /**
  ```
  Shift-Ctrl-F (PC), Cmd-Alt-F (Mac)
  ```
  */
  replace : CodeMirror -> Void,
  /**
  ```
  Shift-Ctrl-R (PC), Shift-Cmd-Alt-F (Mac)
  ```
  */
  replaceAll : CodeMirror -> Void
}
