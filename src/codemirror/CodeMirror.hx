package codemirror;

import js.html.Element;
import js.html.Event;
import js.html.TextAreaElement;
import haxe.extern.EitherType as E;

@:native("CodeMirror")
extern class CodeMirror extends EventEmitter {
  public static function fromTextArea(el : TextAreaElement, ?options : Options) : CodeMirror;
  public static var version(default, null) : String;

  @:override(function(callback : Element -> Void, ?options : Options) : Void {})
  public function new(el : Element, ?options : Options) : Void;

  // CURSOR AND SELECTION METHODS
  /**
  Tells you whether the editor currently has focus.
  */
  function hasFocus() : Bool;
  /**
  Used to find the target position for horizontal cursor motion. start is a Pos object, amount an Int (may be negative), and unit one of the String "char", "column", or "word". Will return a position that is produced by moving amount times the distance specified by unit. When visually is true, motion in right-to-left text will be visual rather than logical. When the motion was clipped by hitting the end or start of the document, the returned value will have a hitSide property set to true.
  */
  function findPosH(start: Pos, amount: Int, unit: String, visually: Bool) : {>Pos, ?hitSide: Bool};
  /**
  Similar to findPosH, but used for vertical motion. unit may be "line" or "page". The other arguments and the returned value have the same interpretation as they have in findPosH.
  */
  function findPosV(start: Pos, amount: Int, unit: String) : {>Pos, ?hitSide: Bool};
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
  Fires every time the content of the editor is changed. The changeObj is a {from, to, text, removed, origin} object containing information about the changes that occurred as second argument. from and to are the positions (in the pre-change coordinate system) where the change started and ended (for example, it might be {ch:0, line:18} if the position is at the beginning of line #19). text is an array of Strings representing the text that replaced the changed range (split by line). removed is the text that used to be between from and to, which is overwritten by this change. This event is fired before the end of an operation, before the DOM updates happen.
  */
  inline function onChange(handler : CodeMirror -> ChangeObject -> Void) : Void
    this.on("change", handler);
  inline function offChange(handler : CodeMirror -> ChangeObject -> Void) : Void
    this.off("change", handler);
  /**
  Like the "change" event, but batched per operation, passing an array containing all the changes that happened in the operation. This event is fired after the operation finished, and display changes it makes will trigger a new operation.
  */
  inline function onChanges(handler : CodeMirror -> Array<ChangeObject>) : Void
    this.on("changes", handler);
  inline function offChanges(handler : CodeMirror -> Array<ChangeObject>) : Void
    this.off("changes", handler);
  /**
  This event is fired before a change is applied, and its handler may choose to modify or cancel the change. The changeObj object has from, to, and text properties, as with the "change" event. It also has a cancel() method, which can be called to cancel the change, and, if the change isn't coming from an undo or redo event, an update(from, to, text) method, which may be used to modify the change. Undo or redo changes can't be modified, because they hold some metainformation for restoring old marked ranges that is only valid for that specific change. All three arguments to update are optional, and can be left off to leave the existing value for that field intact. Note: you may not do anything from a "beforeChange" handler that would cause changes to the document or its visualization. Doing so will, since this handler is called directly from the bowels of the CodeMirror implementation, probably cause the editor to become corrupted.
  */
  inline function onBeforeChange(handler : CodeMirror -> ChangeObject -> Void) : Void
    this.on("beforeChange", handler);
  inline function offBeforeChange(handler : CodeMirror -> ChangeObject -> Void) : Void
    this.off("beforeChange", handler);
  /**
  Will be fired when the cursor or selection moves, or any change is made to the editor content.
  */
  inline function onCursorActivity(handler : CodeMirror -> Void) : Void
    this.on("cursorActivity", handler);
  inline function offCursorActivity(handler : CodeMirror -> Void) : Void
    this.off("cursorActivity", handler);
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
  This event is fired before the selection is moved. Its handler may inspect the set of selection ranges, present as an array of {anchor, head} objects in the ranges property of the obj argument, and optionally change them by calling the update method on this object, passing an array of ranges in the same format. The object also contains an origin property holding the origin String passed to the selection-changing method, if any. Handlers for this event have the same restriction as "beforeChange" handlers — they should not do anything to directly update the state of the editor.
  */
  inline function onBeforeSelectionChange(handler : CodeMirror -> SelectionChange -> Void) : Void
    this.on("beforeSelectionChange", handler);
  inline function offBeforeSelectionChange(handler : CodeMirror -> SelectionChange -> Void) : Void
    this.off("beforeSelectionChange", handler);
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
  inline function dblclick(handler : CodeMirror -> Event -> Void) : Void
    this.on("dblclick", handler);
  inline function dfflclick(handler : CodeMirror -> Event -> Void) : Void
    this.off("dblclick", handler);
  inline function contextmenu(handler : CodeMirror -> Event -> Void) : Void
    this.on("contextmenu", handler);
  inline function cffntextmenu(handler : CodeMirror -> Event -> Void) : Void
    this.off("contextmenu", handler);
  inline function keydown(handler : CodeMirror -> Event -> Void) : Void
    this.on("keydown", handler);
  inline function kffydown(handler : CodeMirror -> Event -> Void) : Void
    this.off("keydown", handler);
  inline function keypress(handler : CodeMirror -> Event -> Void) : Void
    this.on("keypress", handler);
  inline function kffypress(handler : CodeMirror -> Event -> Void) : Void
    this.off("keypress", handler);
  inline function keyup(handler : CodeMirror -> Event -> Void) : Void
    this.on("keyup", handler);
  inline function kffyup(handler : CodeMirror -> Event -> Void) : Void
    this.off("keyup", handler);
  inline function cut(handler : CodeMirror -> Event -> Void) : Void
    this.on("cut", handler);
  inline function cfft(handler : CodeMirror -> Event -> Void) : Void
    this.off("cut", handler);
  inline function copy(handler : CodeMirror -> Event -> Void) : Void
    this.on("copy", handler);
  inline function cffpy(handler : CodeMirror -> Event -> Void) : Void
    this.off("copy", handler);
  inline function paste(handler : CodeMirror -> Event -> Void) : Void
    this.on("paste", handler);
  inline function pffste(handler : CodeMirror -> Event -> Void) : Void
    this.off("paste", handler);
  inline function dragstart(handler : CodeMirror -> Event -> Void) : Void
    this.on("dragstart", handler);
  inline function dffagstart(handler : CodeMirror -> Event -> Void) : Void
    this.off("dragstart", handler);
  inline function dragenter(handler : CodeMirror -> Event -> Void) : Void
    this.on("dragenter", handler);
  inline function dffagenter(handler : CodeMirror -> Event -> Void) : Void
    this.off("dragenter", handler);
  inline function dragover(handler : CodeMirror -> Event -> Void) : Void
    this.on("dragover", handler);
  inline function dffagover(handler : CodeMirror -> Event -> Void) : Void
    this.off("dragover", handler);
  inline function drop(handler : CodeMirror -> Event -> Void) : Void
    this.on("drop", handler);
  inline function dffop(handler : CodeMirror -> Event -> Void) : Void
    this.off("drop", handler);
}
