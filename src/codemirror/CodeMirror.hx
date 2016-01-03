package codemirror;

import js.html.Element;

@:native("CodeMirror")
extern class CodeMirror {
  @:override(function(callback : Element -> Void, ?options : Options) : Void {})
  public function new(el : Element, ?options : Options) : Void;
}
