package codemirror;

import js.html.Element;
import js.html.TextAreaElement;

@:native("CodeMirror")
extern class CodeMirror {
  public static function fromTextArea(el : TextAreaElement, ?options : Options) : CodeMirror;

  @:override(function(callback : Element -> Void, ?options : Options) : Void {})
  public function new(el : Element, ?options : Options) : Void;
}
