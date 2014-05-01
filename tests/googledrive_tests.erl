%%%----------------------------------------------------------------------------
%%% @author Jason Clark <mithereal@gmail.com>
%%% @doc
%%% Erlang library for Google Drive API 
%%% @end
%%%----------------------------------------------------------------------------
-module(googledrivetube_tests).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").


%% =============================================================================
erltube_test_() ->
    {setup,
     fun() -> googledrive:start() end,
     fun(_) -> googledrive:stop() end,
     [
      {timeout, 100, {"Test foobar", fun test_foobar/0}}
     ]
    }.

%% =============================================================================
test_foobar() ->
    ?assert(false).
