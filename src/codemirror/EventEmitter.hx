package codemirror;

import haxe.Constraints;
import haxe.extern.Rest;

extern class EventEmitter {
  /**
  Register an event handler for the given event type (a String) on the editor instance. There is also a CodeMirror.on(object, type, func) version that allows registering of events on any object.
  */
  public function on(event : String, callback : Function) : Void;
  /**
  Remove an event handler on the editor instance. An equivalent CodeMirror.off(object, type, func) also exists.
  */
  public function off(event : String, callback : Function) : Void;
  public function signal(target : Dynamic, name : String, args : Rest<Dynamic>) : Void;
}
