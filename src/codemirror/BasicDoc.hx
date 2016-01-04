package codemirror;

import haxe.extern.EitherType as E;
import js.html.Element;

extern class BasicDoc extends EventEmitter {
  /**
  Each editor is associated with an instance of Doc, its document. A document represents the editor content, plus a selection, an undo history, and a mode. A document can only be associated with a single editor at a time. You can create new documents by calling the Doc(text, mode, firstLineNumber) constructor. The last two arguments are optional and can be used to set a mode for the document and make it start at a line number other than 0, respectively.
  */
  function new(text : String, ?mode : String, ?firstLineNumber : Int) : Void;

  // CONTENT MANIPULATION METHODS
  /**
  Get the current editor content. You can pass it an optional argument to specify the String to be used to separate lines (defaults to "\n").
  */
  function getValue(?separator: String) : String;
  /**
  Set the editor content.
  */
  function setValue(content: String) : Void;
  /**
  Get the text between the given points in the editor, which should be Pos objects. An optional third argument can be given to indicate the line separator String to use (defaults to "\n").
  */
  function getRange(from: Pos, to: Pos, ?separator: String) : String;
  /**
  Replace the part of the document between from and to with the given String. from and to must be Pos objects. to can be left off to simply insert the String at position from. When origin is given, it will be passed on to "change" events, and its first letter will be used to determine whether this change can be merged with previous history events, in the way described for selection origins.
  */
  function replaceRange(replacement: String, from: Pos, to: Pos, ?origin: String) : Void;
  /**
  Get the content of line n.
  */
  function getLine(n: Int) : String;
  /**
  Get the number of lines in the editor.
  */
  function lineCount() : Int;
  /**
  Get the first line of the editor. This will usually be zero but for linked sub-views, or documents instantiated with a non-zero first line, it might return other values.
  */
  function firstLine() : Int;
  /**
  Get the last line of the editor. This will usually be function lineCount() - 1, but for linked sub-views, it might return other values.
  */
  function lastLine() : Int;
  /**
  Fetches the line handle for the given line number.
  */
  function getLineHandle(num: Int) : LineHandle;
  /**
  Given a line handle, returns the current position of that line (or null when it is no longer in the document).
  */
  function getLineNumber(handle: LineHandle) : Int;
  /**
  Iterate over the whole document, or if start and end line numbers are given, the range from start up to (not including) end, and call f for each line, passing the line handle. This is a faster way to visit a range of line handlers than calling getLineHandle for each of them. Note that line handles have a text property containing the line's content (as a String).
  */
  @:override(function (start: Int, end: Int, f: LineHandle -> Void) : Void {})
  function eachLine(f: LineHandle -> Void) : Void;
  /**
  Set the editor content as 'clean', a flag that it will retain until it is edited, and which will be set again when such an edit is undone again. Useful to track whether the content needs to be saved. This function is deprecated in favor of changeGeneration, which allows multiple subsystems to track different notions of cleanness without interfering.
  */
  function markClean() : Void;
  /**
  Returns a number that can later be passed to isClean to test whether any edits were made (and not undone) in the meantime. If closeEvent is true, the current history event will be ‘closed’, meaning it can't be combined with further changes (rapid typing or deleting events are typically combined).
  */
  function changeGeneration(?closeEvent: Bool) : Int;
  /**
  Returns whether the document is currently clean — not modified since initialization or the last call to markClean if no argument is passed, or since the matching call to changeGeneration if a generation value is given.
  */
  function isClean(?generation: Int) : Bool;

  // CURSOR AND SELECTION METHODS
  /**
  Get the currently selected code. Optionally pass a line separator to put between the lines in the output. When multiple selections are present, they are concatenated with instances of lineSep in between.
  */
  function getSelection(?lineSep: String) : String;
  /**
  Returns an Array containing a String for each selection, representing the content of the selections.
  */
  function getSelections(?lineSep: String) : String;
  /**
  Replace the selection(s) with the given String. By default, the new selection ends up after the inserted text. The optional select argument can be used to change this—passing "around" will cause the new text to be selected, passing "start" will collapse the selection to the start of the inserted text.
  */
  function replaceSelection(replacement: String, ?select: String) : Void;
  /**
  The length of the given Array should be the same as the number of active selections. Replaces the content of the selections with the Strings in the Array. The select argument works the same as in replaceSelection.
  */
  function replaceSelections(replacements: Array<String>, ?select: String) : Void;
  /**
  Retrieve one end of the primary selection. start is a an optional String indicating which end of the selection to return. It may be "from", "to", "head" (the side of the selection that moves when you press shift+arrow), or "anchor" (the fixed side of the selection). Omitting the argument is the same as passing "head". A Pos object will be returned.
  */
  function getCursor(?start: String) : Pos;
  /**
  Retrieves a list of all current selections. These will always be sorted, and never overlap (overlapping selections are merged). Each object in the Array contains anchor and head properties referring to Pos objects.
  */
  function listSelections() : Array<Range>;
  /**
  Return true if any text is selected.
  */
  function somethingSelected() : Bool;
  /**
  Set the cursor position. You can either pass a single Pos object, or the line and the character as two separate parameters. Will replace all selections with a single, empty selection at the given position. The supported options are the same as for setSelection.
  */
  function setCursor(pos: E<Pos, Float>, ?ch: Float, ?options: {}) : Void; // TODO ?
  function setSelection(anchor: Pos, ?head: Pos, ?options: {}) : Void; // TODO ?
  /**
  Sets a new set of selections. There must be at least one selection in the given Array. When primary is a number, it determines which selection is the primary one. When it is not given, the primary index is taken from the previous selection, or set to the last range if the previous selection had less ranges than the new one. Supports the same options as setSelection.
  */
  function setSelections(ranges: Array<Range>, ?primary: Int, ?options: {}) : Void; // TODO ?
  /**
  Adds a new selection to the existing set of selections, and makes it the primary selection.
  */
  function addSelection(anchor: Pos, ?head: Pos) : Void;
  /**
  Similar to setSelection, but will, if shift is held or the extending flag is set, move the head of the selection while leaving the anchor at its current place. to is optional, and can be passed to ensure a region (for example a word or paragraph) will end up selected (in addition to whatever lies between that region and the current anchor). When multiple selections are present, all but the primary selection will be dropped by this method. Supports the same options as setSelection.
  */
  function extendSelection(from: Pos, ?to: Pos, ?options: {}) : Void; // TODO ?
  /**
  An equivalent of extendSelection that acts on all selections at once.
  */
  function extendSelections(heads: Array<Pos>, ?options: {}) : Void; // TODO ?
  /**
  Applies the given function to all existing selections, and calls extendSelections on the result.
  */
  function extendSelectionsBy(f: Range -> Pos, ?options: {}) : Void; // TODO ?
  /**
  Sets or clears the 'extending' flag, which acts similar to the shift key, in that it will cause cursor movement and calls to extendSelection to leave the selection anchor in place.
  */
  function setExtending(value: Bool) : Void;
  /**
  Get the value of the 'extending' flag.
  */
  function getExtending() : Bool;

  // DOCUMENT MANAGEMENT METHODS
  /**
  Create an identical copy of the given function  When copyHistory is true, the history will also be copied. Can not be called directly on an editor.
  */
  function copy(copyHistory: Bool) : Doc;
  function linkedDoc(options: {}) : Doc; // TODO ?
  /**
  Break the link between two documents. After calling this, changes will no longer propagate between the documents, and, if they had a shared history, the history will become separate.
  */
  function unlinkDoc(doc: Doc) : Void;
  /**
  Will call the given function for all documents linked to the target document. It will be passed two arguments, the linked document and a Bool indicating whether that document shares history with the target.
  */
  function iterLinkedDocs(fun : Doc -> Bool -> Void) : Void;

  // HISTORY-RELATED METHODS
  /**
  Undo one edit (if any undo events are stored).
  */
  function undo() : Void;
  /**
  Redo one undone edit.
  */
  function redo() : Void;
  /**
  Undo one edit or selection change.
  */
  function undoSelection() : Void;
  /**
  Redo one undone edit or selection change.
  */
  function redoSelection() : Void;
  /**
  Returns an object with {undo, redo} properties, both of which hold Ints, indicating the amount of stored undo and redo operations.
  */
  function historySize() : {undo: Int, redo: Int};
  /**
  Clears the editor's undo history.
  */
  function clearHistory() : Void;
  /**
  Get a (JSON-serializeable) representation of the undo history.
  */
  function getHistory() : {};
  /**
  Replace the editor's undo history with the one provided, which must be a value as returned by getHistory. Note that this will have entirely undefined results if the editor content isn't also the same as it was when getHistory was called.
  */
  function setHistory(history: {}) : Void; // TODO ?

  // TEXT-MARKING METHODS
  function markText(from: Pos, to: Pos, ?options: {}) : TextMarker; // TODO ?
  function setBookmark(pos: Pos, ?options: {}) : TextMarker; // TODO ?
  /**
  Returns an Array of all the bookmarks and marked ranges found between the given positions.
  */
  function findMarks(from: Pos, to: Pos) : Array<TextMarker>;
  /**
  Returns an Array of all the bookmarks and marked ranges present at the given position.
  */
  function findMarksAt(pos: Pos) : Array<TextMarker>;
  /**
  Returns an Array containing all marked ranges in the document.
  */
  function getAllMarks() : Array<TextMarker>;

  // WIDGET, GUTTER, AND DECORATION METHODS
  /**
  Set a CSS class name for the given line. line can be a number or a line handle. where determines to which element this class should be applied, can can be one of "text" (the text element, which lies in front of the selection), "background" (a background element that will be behind the selection), "gutter" (the line's gutter space), or "wrap" (the wrapper node that wraps all of the line's elements, including gutter elements). class should be the name of the class to apply.
  */
  function addLineClass(line: E<Int, LineHandle>, where: String, cls: String) : LineHandle;
  /**
  Remove a CSS class from a line. line can be a line handle or number. where should be one of "text", "background", or "wrap" (see addLineClass). class can be left off to remove all classes for the specified node, or be a String to remove only a specific class.
  */
  function removeLineClass(line: E<Int, LineHandle>, where: String, cls: String) : LineHandle;
  function addLineWidget(line: E<Int, LineHandle>, node: Element, ?options: {}) : LineWidget; // TODO ?

  // MODE, STATE, AND TOKEN-RELATED METHODS
  /**
  Gets the (outer) mode object for the editor. Note that this is distinct from getOption("mode"), which gives you the mode specification, rather than the resolved, instantiated mode object.
  */
  function getMode() : {}; // TODO ?

  // MISCELLANEOUS METHODS
  /**
  Returns the preferred line separator String for this document, as per the option by the same name. When that option is null, the String "\n" is returned.
  */
  function lineSeparator() : Void;
  /**
  Calculates and returns a Pos object for a zero-based index who's value is relative to the start of the editor's text. If the index is out of range of the text then the returned object is clipped to start or end of the text respectively.
  */
  function posFromIndex(index: Int) : Pos;
  /**
  The reverse of posFromIndex.
  */
  function indexFromPos(object: Pos) : Int;

  // EVENTS
  /**
  Fired whenever a change occurs to the document. changeObj has a similar type as the object passed to the editor's "change" event.
  */
  inline function onChange(handler : Doc -> ChangeObject -> Void) : Void
    this.on("change", handler);
  inline function offChange(handler : Doc -> ChangeObject -> Void) : Void
    this.off("change", handler);
  /**
  See the description of the same event on editor instances.
  */
  inline function onBeforeChange(handler : Doc -> ChangeObject -> Void) : Void
    this.on("beforeChange", handler);
  inline function offBeforeChange(handler : Doc -> ChangeObject -> Void) : Void
    this.off("beforeChange", handler);
  /**
  Fired whenever the cursor or selection in this document changes.
  */
  inline function onCursorActivity(handler : Doc -> Void) : Void
    this.on("cursorActivity", handler);
  inline function offCursorActivity(handler : Doc -> Void) : Void
    this.off("cursorActivity", handler);
  /**
  Equivalent to the event by the same name as fired on editor instances.
  */
  inline function onBeforeSelectionChange(handler : Doc -> SelectionChange -> Void) : Void
    this.on("beforeSelectionChange", handler);
  inline function offBeforeSelectionChange(handler : Doc -> SelectionChange -> Void) : Void
    this.off("beforeSelectionChange", handler);
}
