%%
%% Autogenerated by Thrift
%%
%% DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
%%

-module(commandInterface_thrift).
-behaviour(thrift_service).


-include("commandInterface_thrift.hrl").

-export([struct_info/1, function_info/2]).

struct_info('i am a dummy struct') -> undefined.
%%% interface
% run_command(This, Cld, Command, Arglist)
function_info('run_command', params_type) ->
  {struct, [{1, {struct, {'poolparty_types', 'cloudQuery'}}},
  {2, string},
  {3, {list, string}}]}
;
function_info('run_command', reply_type) -> {struct, {'poolparty_types', 'cloudResponse'}};
function_info('run_command', exceptions) -> {struct, []};

% cast_command
function_info('cast_command', params_type) ->
  {struct, [{1, {struct, {'poolparty_types', 'cloudQuery'}}},
  {2, string},
  {3, {list, string}}]}
;
function_info('cast_command', reply_type) -> {struct, {'poolparty_types', 'cloudResponse'}};
function_info('cast_command', exceptions) -> {struct, []};

function_info(xxx, dummy) -> dummy.

