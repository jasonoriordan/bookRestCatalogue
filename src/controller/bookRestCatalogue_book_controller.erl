%%%-------------------------------------------------------------------
%%% @author jasonoriordan
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%          REST Service providing full CRUD actions on <em>Book</em>.
%%% Contract:
%%%         book/view/<book_id>
%%%         book/view_all/
%%%         book/save?bookname=Ullyses&authorname=joyce
%%%         book/update?bookid=myid&bookname=exiles&authorname=joyce
%%%         book/delete/<book_id>
%%% @end
%%% Created : 15. Oct 2013 10:40 AM
%%%-------------------------------------------------------------------
-module(bookRestCatalogue_book_controller, [Req]).
-author("jasonoriordan").

%% API
-compile(export_all).


%% BOOK Read ALL
%%
%% Return all eg. book/view_all
view_all('GET', []) ->
  error_logger:info_msg("GET-book/view_all request revieved~n"),
  Books = boss_db:find(book, []),

  case Books of
    [] ->
      {output,<<"[]">>,[{"Content-Type","application/json"}]};
    _Else ->
      {json, Books}
  end.

%% BOOK Read
%%
%% Read the bookId from the url eg. book/view/book-7
view('GET', [BookId]) ->
  error_logger:info_msg("GET-book/view/~p request recieved~n",[BookId]),
  Book = boss_db:find(BookId),

  case Book of
    [] ->
      {output,<<"[]">>,[{"Content-Type","application/json"}]};
    _Else ->
      {json, Book}
  end.

%%  Book CREATE
%%
%% Create a new carrier based on the passed params eg. book/save?authorname=jk&bookname=hp
save('POST', []) ->
 AuthorName = Req:post_param("authorname"),
 BookName = Req:post_param("bookname"),
  %% TODO fix logging
  % error_logger:info_msg("POST-carrier/save/~s ~s request recieved~n",[CarrierName,CarrierType]),
 NewBook = carrier:new(id,AuthorName, BookName, calendar:universal_time(),calendar:universal_time()),
  % have record and return the newly created if ok or errors otherwise, in json format
 case NewBook:save() of
   {ok, SavedBook} ->
     {json, SavedBook};
   {error, Errors} ->
     {json, Errors}
 end.

%% Carrier Update
%%
%% Note: can also update by populating id with an actual value and calling 'new'
%%       UpdatedBook = book:new(BookName,AuthorName, calendar:universal_time(),calendar:universal_time()),
%%   Updates the book based on the passed params eg. book/update?bookid=myid&bookname=cuckoo&authorname=jk
%-update('PUT', []) ->
%- BookId = Req:post_param("bookid"),
%- BookName = Req:post_param("bookname"),
%- AuthorName = Req:post_param("authorname"),


  % TODO verify record was found
%-Book = boss_db:find(BookId),

  % update via attribute setting (as we don't want to update create_timestamp)
%-BookWithUpdatedName = Book:set(book_name,BookName),
%-BookWithUpdatedAuthor = BookWithUpdatedName:set(author_name,AuthorName),
%-BookWithUpdateTS = BookWithUpdatedAuthor:set(update_timestamp,calendar:universal_time()),

%-case BookWithUpdateTS:save() of
%-  {ok, UpdatedBook} ->
%-    {json, UpdatedBook};
%-  {error, Errors} ->
%-    {json, Errors}
%-end.

%%  Book DELETE
%%
%%   Delete the specified book from the system eg. book/delete/book-7
%-delete('DELETE', [BookId]) ->

%-boss_db:delete(BookId),

%-case boss_db:counter(BookId) of
%-  0 ->
%-    {output,<<"{ \"Deleted Status\": \"Book Deleted\" }">>,[{"Content-Type","application/json"}]};
%-  _Else ->
%-    {output,<<"error">>,[{"Content-Type","application/json"}]}
%-end.