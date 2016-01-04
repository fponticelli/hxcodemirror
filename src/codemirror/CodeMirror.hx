package codemirror;

import js.html.Element;
import js.html.Event;
import js.html.TextAreaElement;

@:native("CodeMirror")
extern class CodeMirror extends EventEmitter {
  public static function fromTextArea(el : TextAreaElement, ?options : Options) : CodeMirror;

  @:override(function(callback : Element -> Void, ?options : Options) : Void {})
  public function new(el : Element, ?options : Options) : Void;

  // EVENTS
  /**
  Fires every time the content of the editor is changed. The changeObj is a {from, to, text, removed, origin} object containing information about the changes that occurred as second argument. from and to are the positions (in the pre-change coordinate system) where the change started and ended (for example, it might be {ch:0, line:18} if the position is at the beginning of line #19). text is an array of strings representing the text that replaced the changed range (split by line). removed is the text that used to be between from and to, which is overwritten by this change. This event is fired before the end of an operation, before the DOM updates happen.
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
  This event is fired before the selection is moved. Its handler may inspect the set of selection ranges, present as an array of {anchor, head} objects in the ranges property of the obj argument, and optionally change them by calling the update method on this object, passing an array of ranges in the same format. The object also contains an origin property holding the origin string passed to the selection-changing method, if any. Handlers for this event have the same restriction as "beforeChange" handlers — they should not do anything to directly update the state of the editor.
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
