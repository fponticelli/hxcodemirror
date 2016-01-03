package codemirror;

import haxe.Constraints;
import haxe.extern.Rest;

extern class EventEmitter {
  public function on(event : String, callback : Function) : Void;
  public function off(event : String, callback : Function) : Void;
  public function signal(target : Dynamic, name : String, args : Rest<Dynamic>) : Void;
}
