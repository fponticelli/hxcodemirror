package codemirror;

import js.html.Element;
import js.html.Event;
import js.html.TextAreaElement;
import haxe.extern.EitherType as E;
import codemirror.Pos;

@:native("CodeMirror")
extern class CodeMirror extends BasicDoc {
  static var version(default, null) : String;
  /**
  An object containing default values for all options. You can assign to its properties to modify defaults (though this won't affect editors that have already been created).
  */
  static var defaults(default, null) : Options;

  /**
  Commands are parameter-less actions that can be performed on an editor. Their main use is for key bindings. Commands are defined by adding properties to the CodeMirror.commands object. A number of common commands are defined by the library itself, most of them used by the default key bindings. The value of a command property must be a function of one argument (an editor instance).

  Some of the commands below are referenced in the default key map, but not defined by the core library. These are intended to be defined by user code or addons.

  Commands can also be run with the execCommand method.
  */
  static var commands(default, null) : Commands;

  /**
  If you want to define extra methods in terms of the CodeMirror API, it is possible to use defineExtension. This will cause the given value (usually a method) to be added to all CodeMirror instances created from then on.
  */
  static function defineExtension(name : String, value : Dynamic) : Void;
  /**
  Like defineExtension, but the method will be added to the interface for Doc objects instead.
  */
  static function defineDocExtension(name : String, value : Dynamic) : Void;
  /**
  Similarly, defineOption can be used to define new options for CodeMirror. The updateFunc will be called with the editor instance and the new value when an editor is initialized, and whenever the option is modified through setOption.
  */
  static function defineOption<T>(name: String, defaultValue: T, updateFunc: CodeMirror -> T -> Void) : Void;
  /**
  If your extention just needs to run some code whenever a CodeMirror instance is initialized, use CodeMirror.defineInitHook. Give it a function as its only argument, and from then on, that function will be called (with the instance as argument) whenever a new CodeMirror instance is initialized.
  */
  static function defineInitHook(func: CodeMirror -> Void) : Void;
  /**
  Registers a helper value with the given name in the given namespace (type). This is used to define functionality that may be looked up by mode. Will create (if it doesn't already exist) a property on the CodeMirror object for the given type, pointing to an object that maps names to values. I.e. after doing CodeMirror.registerHelper("hint", "foo", myFoo), the value CodeMirror.hint.foo will point to myFoo.
  */
  static function registerHelper(type: String, name: String, value: Dynamic) : Void;
  /**
  Acts like registerHelper, but also registers this helper as 'global', meaning that it will be included by getHelpers whenever the given predicate returns true when called with the local mode and editor.
  */
  static function registerGlobalHelper(type: String, name: String, predicate: String -> CodeMirror -> Dynamic -> Bool) : Void;
  /**
  Utility function that computes an end position from a change (an object with from, to, and text properties, as passed to various event handlers). The returned position will be the end of the changed range, after the change is applied.
  */
  static function changeEnd(change: { from : Pos, to : Pos, text : String }) : Pos;

  /**
  The method provides another way to initialize an editor. It takes a textarea DOM node as first argument and an optional configuration object as second. It will replace the textarea with a CodeMirror instance, and wire up the form of that textarea (if any) to make sure the editor contents are put into the textarea when the form is submitted. The text in the textarea will provide the content for the editor.
  */
  static function fromTextArea(el : TextAreaElement, ?options : Options) : TextAreaCodeMirror;

  @:override(function(callback : Element -> Void) : Void {})
  @:override(function(callback : Element -> Void, options : Options) : Void {})
  @:override(function(el : Element) : Void {})
  function new(el : Element, options : Options) : Void;

  // CURSOR AND SELECTION METHODS
  /**
  Tells you whether the editor currently has focus.
  */
  function hasFocus() : Bool;
  /**
  Used to find the target position for horizontal cursor motion. start is a Pos object, amount an Int (may be negative), and unit one of the String "char", "column", or "word". Will return a position that is produced by moving amount times the distance specified by unit. When visually is true, motion in right-to-left text will be visual rather than logical. When the motion was clipped by hitting the end or start of the document, the returned value will have a hitSide property set to true.
  */
  function findPosH(start: Pos, amount: Int, unit: String, visually: Bool) : PosHit;
  /**
  Similar to findPosH, but used for vertical motion. unit may be "line" or "page". The other arguments and the returned value have the same interpretation as they have in findPosH.
  */
  function findPosV(start: Pos, amount: Int, unit: String) : PosHit;
  /**
  Returns the start and end of the 'word' (the stretch of letters, whitespace, or punctuation) at the given position.
  */
  function findWordAt(pos: Pos) : Range;

  // CONFIGURATION METHODS
  /**
  Change the configuration of the editor. option should the name of an option, and value should be a valid value for that option.
  */
  function setOption(option: String, value: Dynamic) : Void;
  /**
  Retrieves the current value of the given option for this editor instance.
  */
  function getOption(option: String) : Dynamic;
  /**
  Attach an additional key map to the editor. This is mostly useful for addons that need to register some key handlers without trampling on the extraKeys option. Maps added in this way have a higher precedence than the extraKeys and keyMap options, and between them, the maps added earlier have a lower precedence than those added later, unless the bottom argument was passed, in which case they end up below other key maps added with this method.
  */
  function addKeyMap(map: {}, bottom: Bool) : Void;
  /**
  Disable a keymap added with addKeyMap. Either pass in the key map object itself, or a String, which will be compared against the name property of the active key maps.
  */
  function removeKeyMap(map: E<String, {}>) : Void;
  /**
  Enable a highlighting overlay. This is a stateless mini-mode that can be used to add extra highlighting. For example, the search addon uses it to highlight the term that's currently being searched. mode can be a mode spec or a mode object (an object with a token method). The options parameter is optional. If given, it should be an object. Currently, only the opaque option is recognized. This defaults to off, but can be given to allow the overlay styling, when not null, to override the styling of the base mode entirely, instead of the two being applied together.
  */
  function addOverlay(mode: E<String,{}>, ?options: {}) : Void;
  /**
  Pass this the exact value passed for the mode parameter to addOverlay, or a String that corresponds to the name propery of that value, to remove an overlay again.
  */
  function removeOverlay(mode: E<String,{}>) : Void;

  // DOCUMENT MANAGEMENT METHODS
  /**
  Retrieve the currently active document from an editor.
  */
  function getDoc() : Doc;
  /**
  Attach a new document to the editor. Returns the old document, which is now no longer associated with an editor.
  */
  function swapDoc(doc: Doc) : Doc;

  // WIDGET, GUTTER, AND DECORATION METHODS
  /**
  Sets the gutter marker for the given gutter (identified by its CSS class, see the gutters option) to the given value. Value can be either null, to clear the marker, or a DOM element, to set it. The DOM element will be shown in the specified gutter next to the specified line.
  */
  function setGutterMarker(line: E<Int, LineHandle>, gutterID: String, value: Element) : LineHandle;
  /**
  Remove all gutter markers in the gutter with the given ID.
  */
  function clearGutter(gutterID: String) : Void;
  /**
  Returns the line number, text content, and marker status of the given line, which can be either a number or a line handle. The returned object has the structure {line, handle, text, gutterMarkers, textClass, bgClass, wrapClass, widgets}, where gutterMarkers is an object mapping gutter IDs to marker elements, and widgets is an array of line widgets attached to this line, and the various class properties refer to classes added with addLineClass.
  */
  function lineInfo(line: E<Int, LineHandle>) : LineInfo;
  /**
  Puts node, which should be an absolutely positioned DOM node, into the editor, positioned right below the given Pos position. When scrollIntoView is true, the editor will ensure that the entire node is visible (if possible). To remove the widget again, simply use DOM methods (move it somewhere else, or call removeChild on its parent).
  */
  function addWidget(pos: Pos, node: Element, scrollIntoView: Bool) : Void;

  // SIZING, SCROLLING AND POSITIONING METHODS
  /**
  Programatically set the size of the editor (overriding the applicable CSS rules). width and height can be either numbers (interpreted as pixels) or CSS units ("100%", for example). You can pass null for either of them to indicate that that dimension should not be changed.
  */
  function setSize(width: E<Float, String>, height: E<Float, String>) : Void;
  /**
  Scroll the editor to a given (pixel) position. Both arguments may be left as null or undefined to have no effect.
  */
  function scrollTo(x: Float, y: Float) : Void;
  /**
  Get an {left, top, width, height, clientWidth, clientHeight} object that represents the current scroll position, the size of the scrollable area, and the size of the visible area (minus scrollbars).
  */
  function getScrollInfo() : ScrollInfo;
  /**
  Scrolls the given position into view. what may be null to scroll the cursor into view, a Pos position to scroll a character into view, a {left, top, right, bottom} pixel range (in editor-local coordinates), or a range {from, to} containing either two character positions or two pixel squares. The margin parameter is optional. When given, it indicates the amount of vertical pixels around the given area that should be made visible as well.
  */
  function scrollIntoView(what: E<Pos,E<{left : Float, top : Float, right : Float, bottom : Float}, {from : Float, to : Float}>>, ?margin: Float) : Void;
  /**
  Returns an {left, top, bottom} object containing the coordinates of the cursor position. If mode is "local", they will be relative to the top-left corner of the editable document. If it is "page" or not given, they are relative to the top-left corner of the page. If mode is "window", the coordinates are relative to the top-left corner of the currently visible (scrolled) window. where can be a Bool indicating whether you want the start (true) or the end (false) of the selection, or, if a Pos object is given, it specifies the precise position at which you want to measure.
  */
  function cursorCoords(where: E<Bool, Pos>, mode: String) : {left : Float, top : Float, bottom : Float};
  /**
  Returns the position and dimensions of an arbitrary character. pos should be a Pos object. This differs from cursorCoords in that it'll give the size of the whole character, rather than just the position that the cursor would have when it would sit at that position.
  */
  function charCoords(pos: Pos, ?mode: String) : {left : Float, right : Float, top : Float, bottom : Float};
  /**
  Given an {left, top} object, returns the Pos position that corresponds to it. The optional mode parameter determines relative to what the coordinates are interpreted. It may be "window", "page" (the default), or "local".
  */
  function coordsChar(object: {left : Float, top : Float}, ?mode: String) : Pos;
  /**
  Computes the line at the given pixel height. mode can be one of the same Strings that coordsChar accepts.
  */
  function lineAtHeight(height: Float, ?mode: String) : Float;
  /**
  Computes the height of the top of a line, in the coordinate system specified by mode (see coordsChar), which defaults to "page". When a line below the bottom of the document is specified, the returned value is the bottom of the last line in the document.
  */
  function heightAtLine(line: E<Int, LineHandle>, ?mode: String) : Float;
  /**
  Returns the line height of the default font for the editor.
  */
  function defaultTextHeight() : Float;
  /**
  Returns the pixel width of an 'x' in the default font for the editor. (Note that for non-monospace fonts, this is mostly useless, and even for monospace fonts, non-ascii characters might have a different width).
  */
  function defaultCharWidth() : Float;
  /**
  Returns a {from, to} object indicating the start (inclusive) and end (exclusive) of the currently rendered part of the document. In big documents, when most content is scrolled out of view, CodeMirror will only render the visible part, and a margin around it. See also the viewportChange event.
  */
  function getViewport() : {from: Float, to: Float};
  /**
  If your code does something to change the size of the editor element (window resizes are already listened for), or unhides it, you should probably follow up by calling this method to ensure CodeMirror is still looking as intended. See also the autorefresh addon.
  */
  function refresh() : Void;

  // MODE, STATE, AND TOKEN-RELATED METHODS
  /**
  Gets the inner mode at a given position. This will return the same as getMode for simple modes, but will return an inner mode for nesting modes (such as htmlmixed).
  */
  function getModeAt(pos: Pos) : {}; // TODO ?
  function getTokenAt(pos: Pos, ?precise: Bool) : {}; // TODO ?
  /**
  This is similar to getTokenAt, but collects all tokens for a given line into an array. It is much cheaper than repeatedly calling getTokenAt, which re-parses the part of the line before the token for every call.
  */
  function getLineTokens(line: Int, ?precise: Bool) : Array<{start : Int, end : Int, string : String, type : String, state : String}>;
  /**
  This is a (much) cheaper version of getTokenAt useful for when you just need the type of the token at a given position, and no other information. Will return null for unstyled tokens, and a String, potentially containing multiple space-separated style names, otherwise.
  */
  function getTokenTypeAt(pos: Pos) : String;
  /**
  Fetch the set of applicable helper values for the given position. Helpers provide a way to look up functionality appropriate for a mode. The type argument provides the helper namespace (see registerHelper), in which the values will be looked up. When the mode itself has a property that corresponds to the type, that directly determines the keys that are used to look up the helper values (it may be either a single String, or an array of Strings). Failing that, the mode's helperType property and finally the mode's name are used.
  For example, the JavaScript mode has a property fold containing "brace". When the brace-fold addon is loaded, that defines a helper named brace in the fold namespace. This is then used by the foldcode addon to figure out that it can use that folding function to fold JavaScript code.
  When any 'global' helpers are defined for the given namespace, their predicates are called on the current mode and editor, and all those that declare they are applicable will also be added to the array that is returned.
  */
  function getHelpers(pos: Pos, type: String) : Array<{}>; // TODO ?
  /**
  Returns the first applicable helper value. See getHelpers.
  */
  function getHelper(pos: Pos, type: String) : {}; // TODO ?
  /**
  Returns the mode's parser state, if any, at the end of the given line number. If no line number is given, the state at the end of the document is returned. This can be useful for storing parsing errors in the state, or getting other kinds of contextual information for a line. precise is defined as in getTokenAt().
  */
  function getStateAfter(?line: Int, ?precise: Bool) : {}; // TODO ?

  // MISCELLANEOUS METHODS
  /**
  CodeMirror internally buffers changes and only updates its DOM structure after it has finished performing some operation. If you need to perform a lot of operations on a CodeMirror instance, you can call this method with a function argument. It will call the function, buffering up all changes, and only doing the expensive update after the function returns. This can be a lot faster. The return value from this method will be the return value of your function.
  */
  function operation(func: Void -> Dynamic) : Dynamic;
  function indentLine(line: Int, ?dir: E<String, Int>) : Void;
  /**
  Switches between overwrite and normal insert mode (when not given an argument), or sets the overwrite mode to a specific state (when given an argument).
  */
  function toggleOverwrite(?value: Bool) : Void;
  /**
  Tells you whether the editor's content can be edited by the user.
  */
  function isReadOnly() : Bool;
  /**
  Runs the command with the given name on the editor.
  */
  function execCommand(name: String) : Void;


  /**
  Select the whole content of the editor.
  ```
  Ctrl-A (PC), Cmd-A (Mac)
  ```
  */
  inline function execSelectAll() : Void
    this.execCommand("selectAll");
  /**
  When multiple selections are present, this deselects all but the primary selection.
  ```
  Esc
  ```
  */
  inline function execSingleSelection() : Void
    this.execCommand("singleSelection");
  /**
  Emacs-style line killing. Deletes the part of the line after the cursor. If that consists only of whitespace, the newline at the end of the line is also deleted.
  ```
  Ctrl-K (Mac)
  ```
  */
  inline function execKillLine() : Void
    this.execCommand("killLine");
  /**
  Deletes the whole line under the cursor, including newline at the end.
  ```
  Ctrl-D (PC), Cmd-D (Mac)
  ```
  */
  inline function execDeleteLine() : Void
    this.execCommand("deleteLine");
  /**
  Delete the part of the line before the cursor.
  */
  inline function execDelLineLeft() : Void
    this.execCommand("delLineLeft");
  /**
  Delete the part of the line from the left side of the visual line the cursor is on to the cursor.
  ```
  Cmd-Backspace (Mac)
  ```
  */
  inline function execDelWrappedLineLeft() : Void
    this.execCommand("delWrappedLineLeft");
  /**
  Delete the part of the line from the cursor to the right side of the visual line the cursor is on.
  ```
  Cmd-Delete (Mac)
  ```
  */
  inline function execDelWrappedLineRight() : Void
    this.execCommand("delWrappedLineRight");
  /**
  Undo the last change.
  ```
  Ctrl-Z (PC), Cmd-Z (Mac)
  ```
  */
  inline function execUndo() : Void
    this.execCommand("undo");
  /**
  Redo the last undone change.
  ```
  Ctrl-Y (PC), Shift-Cmd-Z (Mac), Cmd-Y (Mac)
  ```
  */
  inline function execRedo() : Void
    this.execCommand("redo");
  /**
  Undo the last change to the selection, or if there are no selection-only changes at the top of the history, undo the last change.
  ```
  Ctrl-U (PC), Cmd-U (Mac)
  ```
  */
  inline function execUndoSelection() : Void
    this.execCommand("undoSelection");
  /**
  Redo the last change to the selection, or the last text change if no selection changes remain.
  ```
  Alt-U (PC), Shift-Cmd-U (Mac)
  ```
  */
  inline function execRedoSelection() : Void
    this.execCommand("redoSelection");
  /**
  Move the cursor to the start of the document.
  ```
  Ctrl-Home (PC), Cmd-Up (Mac), Cmd-Home (Mac)
  ```
  */
  inline function execGoDocStart() : Void
    this.execCommand("goDocStart");
  /**
  Move the cursor to the end of the document.
  ```
  Ctrl-End (PC), Cmd-End (Mac), Cmd-Down (Mac)
  ```
  */
  inline function execGoDocEnd() : Void
    this.execCommand("goDocEnd");
  /**
  Move the cursor to the start of the line.
  ```
  Alt-Left (PC), Ctrl-A (Mac)
  ```
  */
  inline function execGoLineStart() : Void
    this.execCommand("goLineStart");
  /**
  Move to the start of the text on the line, or if we are already there, to the actual start of the line (including whitespace).
  ```
  Home
  ```
  */
  inline function execGoLineStartSmart() : Void
    this.execCommand("goLineStartSmart");
  /**
  Move the cursor to the end of the line.
  ```
  Alt-Right (PC), Ctrl-E (Mac)
  ```
  */
  inline function execGoLineEnd() : Void
    this.execCommand("goLineEnd");
  /**
  Move the cursor to the right side of the visual line it is on.
  ```
  Cmd-Right (Mac)
  ```
  */
  inline function execGoLineRight() : Void
    this.execCommand("goLineRight");
  /**
  Move the cursor to the left side of the visual line it is on. If this line is wrapped, that may not be the start of the line.
  ```
  Cmd-Left (Mac)
  ```
  */
  inline function execGoLineLeft() : Void
    this.execCommand("goLineLeft");
  /**
  Move the cursor to the left side of the visual line it is on. If that takes it to the start of the line, behave like goLineStartSmart.
  */
  inline function execGoLineLeftSmart() : Void
    this.execCommand("goLineLeftSmart");
  /**
  Move the cursor up one line.
  ```
  Up, Ctrl-P (Mac)
  ```
  */
  inline function execGoLineUp() : Void
    this.execCommand("goLineUp");
  /**
  Move down one line.
  ```
  Down, Ctrl-N (Mac)
  ```
  */
  inline function execGoLineDown() : Void
    this.execCommand("goLineDown");
  /**
  Move the cursor up one screen, and scroll up by the same distance.
  ```
  PageUp, Shift-Ctrl-V (Mac)
  ```
  */
  inline function execGoPageUp() : Void
    this.execCommand("goPageUp");
  /**
  Move the cursor down one screen, and scroll down by the same distance.
  ```
  PageDown, Ctrl-V (Mac)
  ```
  */
  inline function execGoPageDown() : Void
    this.execCommand("goPageDown");
  /**
  Move the cursor one character left, going to the previous line when hitting the start of line.
  ```
  Left, Ctrl-B (Mac)
  ```
  */
  inline function execGoCharLeft() : Void
    this.execCommand("goCharLeft");
  /**
  Move the cursor one character right, going to the next line when hitting the end of line.
  ```
  Right, Ctrl-F (Mac)
  ```
  */
  inline function execGoCharRight() : Void
    this.execCommand("goCharRight");
  /**
  Move the cursor one character left, but don't cross line boundaries.
  */
  inline function execGoColumnLeft() : Void
    this.execCommand("goColumnLeft");
  /**
  Move the cursor one character right, don't cross line boundaries.
  */
  inline function execGoColumnRight() : Void
    this.execCommand("goColumnRight");
  /**
  Move the cursor to the start of the previous word.
  ```
  Alt-B (Mac)
  ```
  */
  inline function execGoWordLeft() : Void
    this.execCommand("goWordLeft");
  /**
  Move the cursor to the end of the next word.
  ```
  Alt-F (Mac)
  ```
  */
  inline function execGoWordRight() : Void
    this.execCommand("goWordRight");
  /**
  Move to the left of the group before the cursor. A group is a stretch of word characters, a stretch of punctuation characters, a newline, or a stretch of more than one whitespace character.
  ```
  Ctrl-Left (PC), Alt-Left (Mac)
  ```
  */
  inline function execGoGroupLeft() : Void
    this.execCommand("goGroupLeft");
  /**
  Move to the right of the group after the cursor (see above).
  ```
  Ctrl-Right (PC), Alt-Right (Mac)
  ```
  */
  inline function execGoGroupRight() : Void
    this.execCommand("goGroupRight");
  /**
  Delete the character before the cursor.
  ```
  Shift-Backspace, Ctrl-H (Mac)
  ```
  */
  inline function execDelCharBefore() : Void
    this.execCommand("delCharBefore");
  /**
  Delete the character after the cursor.
  ```
  Delete, Ctrl-D (Mac)
  ```
  */
  inline function execDelCharAfter() : Void
    this.execCommand("delCharAfter");
  /**
  Delete up to the start of the word before the cursor.
  ```
  Alt-Backspace (Mac)
  ```
  */
  inline function execDelWordBefore() : Void
    this.execCommand("delWordBefore");
  /**
  Delete up to the end of the word after the cursor.
  ```
  Alt-D (Mac)
  ```
  */
  inline function execDelWordAfter() : Void
    this.execCommand("delWordAfter");
  /**
  Delete to the left of the group before the cursor.
  ```
  Ctrl-Backspace (PC), Alt-Backspace (Mac)
  ```
  */
  inline function execDelGroupBefore() : Void
    this.execCommand("delGroupBefore");
  /**
  Delete to the start of the group after the cursor.
  ```
  Ctrl-Delete (PC), Ctrl-Alt-Backspace (Mac), Alt-Delete (Mac)
  ```
  */
  inline function execDelGroupAfter() : Void
    this.execCommand("delGroupAfter");
  /**
  Auto-indent the current line or selection.
  ```
  Shift-Tab
  ```
  */
  inline function execIndentAuto() : Void
    this.execCommand("indentAuto");
  /**
  Indent the current line or selection by one indent unit.
  ```
  Ctrl-] (PC), Cmd-] (Mac)
  ```
  */
  inline function execIndentMore() : Void
    this.execCommand("indentMore");
  /**
  Dedent the current line or selection by one indent unit.
  ```
  Ctrl-[ (PC), Cmd-[ (Mac)
  ```
  */
  inline function execIndentLess() : Void
    this.execCommand("indentLess");
  /**
  Insert a tab character at the cursor.
  */
  inline function execInsertTab() : Void
    this.execCommand("insertTab");
  /**
  Insert the amount of spaces that match the width a tab at the cursor position would have.
  */
  inline function execInsertSoftTab() : Void
    this.execCommand("insertSoftTab");
  /**
  If something is selected, indent it by one indent unit. If nothing is selected, insert a tab character.
  ```
  Tab
  ```
  */
  inline function execDefaultTab() : Void
    this.execCommand("defaultTab");
  /**
  Swap the characters before and after the cursor.
  ```
  Ctrl-T (Mac)
  ```
  */
  inline function execTransposeChars() : Void
    this.execCommand("transposeChars");
  /**
  Insert a newline and auto-indent the new line.
  ```
  Enter
  ```
  */
  inline function execNewlineAndIndent() : Void
    this.execCommand("newlineAndIndent");
  /**
  Flip the overwrite flag.
  ```
  Insert
  ```
  */
  inline function execToggleOverwrite() : Void
    this.execCommand("toggleOverwrite");
  /**
  Not defined by the core library, only referred to in key maps. Intended to provide an easy way for user code to define a save command.
  ```
  Ctrl-S (PC), Cmd-S (Mac)
  ```
  */
  inline function execSave() : Void
    this.execCommand("save");
  /**
  ```
  Ctrl-F (PC), Cmd-F (Mac)
  ```
  */
  inline function execFind() : Void
    this.execCommand("find");
  /**
  ```
  Ctrl-G (PC), Cmd-G (Mac)
  ```
  */
  inline function execFindNext() : Void
    this.execCommand("findNext");
  /**
  ```
  Shift-Ctrl-G (PC), Shift-Cmd-G (Mac)
  ```
  */
  inline function execFindPrev() : Void
    this.execCommand("findPrev");
  /**
  ```
  Shift-Ctrl-F (PC), Cmd-Alt-F (Mac)
  ```
  */
  inline function execReplace() : Void
    this.execCommand("replace");
  /**
  ```
  Shift-Ctrl-R (PC), Shift-Cmd-Alt-F (Mac)
  ```
  */
  inline function execReplaceAll() : Void
    this.execCommand("replaceAll");

  /**
  Give the editor focus.
  */
  function focus() : Void;
  /**
  Returns the input field for the editor. Will be a textarea or an editable div, depending on the value of the inputStyle option.
  */
  function getInputField() : Element;
  /**
  Returns the DOM node that represents the editor, and controls its size. Remove this from your tree to delete an editor instance.
  */
  function getWrapperElement() : Element;
  /**
  Returns the DOM node that is responsible for the scrolling of the editor.
  */
  function getScrollerElement() : Element;
  /**
  Fetches the DOM node that contains the editor gutters.
  */
  function getGutterElement() : Element;

  // EVENTS
  /**
  Like the "change" event, but batched per operation, passing an array containing all the changes that happened in the operation. This event is fired after the operation finished, and display changes it makes will trigger a new operation.
  */
  inline function onChanges(handler : CodeMirror -> Array<ChangeObject>) : Void
    this.on("changes", handler);
  inline function offChanges(handler : CodeMirror -> Array<ChangeObject>) : Void
    this.off("changes", handler);
  /**
  Fired after a key is handled through a key map. name is the name of the handled key (for example "Ctrl-X" or "'q'"), and event is the DOM keydown or keypress event.
  */
  inline function onKeyHandled(handler : CodeMirror -> String -> Event -> Void) : Void
    this.on("keyHandled", handler);
  inline function offKeyHandled(handler : CodeMirror -> String -> Event -> Void) : Void
    this.off("keyHandled", handler);
  /**
  Fired whenever new input is read from the hidden textarea (typed or pasted by the user).
  */
  inline function onInputRead(handler : CodeMirror -> ChangeObject -> Void) : Void
    this.on("inputRead", handler);
  inline function offInputRead(handler : CodeMirror -> ChangeObject -> Void) : Void
    this.off("inputRead", handler);
  /**
  Fired if text input matched the mode's electric patterns, and this caused the line's indentation to change.
  */
  inline function onElectrictInput(handler : CodeMirror -> Int -> Void) : Void
    this.on("electrictInput", handler);
  inline function offElectrictInput(handler : CodeMirror -> Int -> Void) : Void
    this.off("electrictInput", handler);
  /**
  Fires whenever the view port of the editor changes (due to scrolling, editing, or any other factor). The from and to arguments give the new start and end of the viewport.
  */
  inline function onViewportChange(handler : CodeMirror -> Float -> Float -> Void) : Void
    this.on("viewportChange", handler);
  inline function offViewportChange(handler : CodeMirror -> Float -> Float -> Void) : Void
    this.off("viewportChange", handler);
  /**
  This is signalled when the editor's document is replaced using the swapDoc method.
  */
  inline function onSwapDoc(handler : CodeMirror -> Doc -> Void) : Void
    this.on("swapDoc", handler);
  inline function offSwapDoc(handler : CodeMirror -> Doc -> Void) : Void
    this.off("swapDoc", handler);
  /**
  Fires when the editor gutter (the line-number area) is clicked. Will pass the editor instance as first argument, the (zero-based) number of the line that was clicked as second argument, the CSS class of the gutter that was clicked as third argument, and the raw mousedown event object as fourth argument.
  */
  inline function onGutterClick(handler : CodeMirror -> Int -> String -> Event -> Void) : Void
    this.on("gutterClick", handler);
  inline function offGutterClick(handler : CodeMirror -> Int -> String -> Event -> Void) : Void
    this.off("gutterClick", handler);
  /**
  Fires when the editor gutter (the line-number area) receives a contextmenu event. Will pass the editor instance as first argument, the (zero-based) number of the line that was clicked as second argument, the CSS class of the gutter that was clicked as third argument, and the raw contextmenu mouse event object as fourth argument. You can preventDefault the event, to signal that CodeMirror should do no further handling.
  */
  inline function onGutterContextMenu(handler : CodeMirror -> Int -> String -> Event -> Void) : Void
    this.on("gutterContextMenu", handler);
  inline function offGutterContextMenu(handler : CodeMirror -> Int -> String -> Event -> Void) : Void
    this.off("gutterContextMenu", handler);
  /**
  Fires whenever the editor is focused.
  */
  inline function onFocus(handler : CodeMirror -> Void) : Void
    this.on("focus", handler);
  inline function offFocus(handler : CodeMirror -> Void) : Void
    this.off("focus", handler);
  /**
  Fires whenever the editor is unfocused.
  */
  inline function onBlur(handler : CodeMirror -> Void) : Void
    this.on("blur", handler);
  inline function offBlur(handler : CodeMirror -> Void) : Void
    this.off("blur", handler);
  /**
  Fires when the editor is scrolled.
  */
  inline function onScroll(handler : CodeMirror -> Void) : Void
    this.on("scroll", handler);
  inline function offScroll(handler : CodeMirror -> Void) : Void
    this.off("scroll", handler);
  /**
  Fires when the editor tries to scroll its cursor into view. Can be hooked into to take care of additional scrollable containers around the editor. When the event object has its preventDefault method called, CodeMirror will not itself try to scroll the window.
  */
  inline function onScrollCursorIntoView(handler : CodeMirror -> Event -> Void) : Void
    this.on("scrollCursorIntoView", handler);
  inline function offScrollCursorIntoView(handler : CodeMirror -> Event -> Void) : Void
    this.off("scrollCursorIntoView", handler);
  /**
  Will be fired whenever CodeMirror updates its DOM display.
  */
  inline function onUpdate(handler : CodeMirror -> Void) : Void
    this.on("update", handler);
  inline function offUpdate(handler : CodeMirror -> Void) : Void
    this.off("update", handler);
  /**
  Fired whenever a line is (re-)rendered to the DOM. Fired right after the DOM element is built, before it is added to the document. The handler may mess with the style of the resulting element, or add event handlers, but should not try to change the state of the editor.
  */
  inline function onRenderLine(handler : CodeMirror -> LineHandle -> Element -> Void) : Void
    this.on("renderLine", handler);
  inline function offRenderLine(handler : CodeMirror -> LineHandle -> Element -> Void) : Void
    this.off("renderLine", handler);
  /**
  Fired when CodeMirror is handling a DOM event of this type. You can preventDefault the event, or give it a truthy codemirrorIgnore property, to signal that CodeMirror should do no further handling.
  */
  inline function onMousedown(handler : CodeMirror -> Event -> Void) : Void
    this.on("mousedown", handler);
  inline function offMousedown(handler : CodeMirror -> Event -> Void) : Void
    this.off("mousedown", handler);
  inline function onDblclick(handler : CodeMirror -> Event -> Void) : Void
    this.on("dblclick", handler);
  inline function offDblclick(handler : CodeMirror -> Event -> Void) : Void
    this.off("dblclick", handler);
  inline function onContextmenu(handler : CodeMirror -> Event -> Void) : Void
    this.on("contextmenu", handler);
  inline function offContextmenu(handler : CodeMirror -> Event -> Void) : Void
    this.off("contextmenu", handler);
  inline function onKeydown(handler : CodeMirror -> Event -> Void) : Void
    this.on("keydown", handler);
  inline function offKeydown(handler : CodeMirror -> Event -> Void) : Void
    this.off("keydown", handler);
  inline function onKeypress(handler : CodeMirror -> Event -> Void) : Void
    this.on("keypress", handler);
  inline function offKeypress(handler : CodeMirror -> Event -> Void) : Void
    this.off("keypress", handler);
  inline function onKeyup(handler : CodeMirror -> Event -> Void) : Void
    this.on("keyup", handler);
  inline function offKeyup(handler : CodeMirror -> Event -> Void) : Void
    this.off("keyup", handler);
  inline function onCut(handler : CodeMirror -> Event -> Void) : Void
    this.on("cut", handler);
  inline function offCut(handler : CodeMirror -> Event -> Void) : Void
    this.off("cut", handler);
  inline function onCopy(handler : CodeMirror -> Event -> Void) : Void
    this.on("copy", handler);
  inline function offCopy(handler : CodeMirror -> Event -> Void) : Void
    this.off("copy", handler);
  inline function onPaste(handler : CodeMirror -> Event -> Void) : Void
    this.on("paste", handler);
  inline function offPaste(handler : CodeMirror -> Event -> Void) : Void
    this.off("paste", handler);
  inline function onDragstart(handler : CodeMirror -> Event -> Void) : Void
    this.on("dragstart", handler);
  inline function offDragstart(handler : CodeMirror -> Event -> Void) : Void
    this.off("dragstart", handler);
  inline function onDragenter(handler : CodeMirror -> Event -> Void) : Void
    this.on("dragenter", handler);
  inline function offDragenter(handler : CodeMirror -> Event -> Void) : Void
    this.off("dragenter", handler);
  inline function onDragover(handler : CodeMirror -> Event -> Void) : Void
    this.on("dragover", handler);
  inline function offDragover(handler : CodeMirror -> Event -> Void) : Void
    this.off("dragover", handler);
  inline function onDrop(handler : CodeMirror -> Event -> Void) : Void
    this.on("drop", handler);
  inline function offDrop(handler : CodeMirror -> Event -> Void) : Void
    this.off("drop", handler);
}
