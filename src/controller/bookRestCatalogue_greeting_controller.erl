%% Copyright
-module(bookRestCatalogue_greeting_controller, [Req]).
-author("jasonoriordan").
-compile(export_all).

hello('GET', []) ->
  {output, "<strong>hello!</strong>"}.