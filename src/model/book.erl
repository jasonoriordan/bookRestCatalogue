%%  %%
%%  @title book.erl
%%  @author jasonoriordan
%%  Created on 07. Oct 2013 9:48 AM
%%  %%
%%  @doc book.erl is a module that represents book model
%%  @end

%%%-------------------------------------------------------------------
%%% @author jasonoriordan
%%% @doc
%%%
%%% @end
%%% Created : 15. Oct 2013 9:48 AM
%%%-------------------------------------------------------------------
-module(book,[Id, BookName, AuthorName, InsertTimestamp::datetime(), UpdateTimestamp::datetime()]).
-author("jasonoriordan").
-compile(export_all).

%%
%%  @doc Validate input, no empty fields are allowed in system
%%  @end
validation_tests() ->
  [
    %% BookName Required
    {fun() ->
      BookName =/= undefined andalso
        length(BookName) =/= 0
    end, {book_name, "Book Name required"}},
    %% AuthorName Required
    {fun() ->
      AuthorName =/= undefined andalso
        length(AuthorName) =/= 0
    end, {author_name, "Author Name required"}}
  ].