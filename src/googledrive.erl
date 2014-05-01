%%%----------------------------------------------------------------------------
%%% @author Jason Clark <mithereal@gmail.com>
%%% @doc
%%% Erlang library for Google Drive v2 API
%%% @end
%%%----------------------------------------------------------------------------

-module(googledrive).

%% API
-export([
		 request_token/3,
         request_token/4,
         authorize_token/4,
         refresh_token/3,
         revoke_token/1,
         scope/1,
  ]).

-define(DEPS, [crypto, asn1, public_key, ssl, inets, jiffy]).
-define(URL_OAUTH, "https://accounts.google.com/o/oauth2/").

request_token(ClientKey, RedirectUri, Redirect) ->
    request_token(ClientKey, RedirectUri, scope(readonly), Redirect).

request_token(ClientKey, RedirectUri, Scope, Redirect) ->
    Params = [{client_id, ClientKey},
              {redirect_uri, RedirectUri},
              {response_type, code},
              {scope, Scope}],
    BaseUrl = get_url(request_token),
    case Redirect of
        true  -> http_request(get, BaseUrl, Params);
        false -> create_url(BaseUrl, Params)
    end.

authorize_token(ClientKey, ClientSecret, RedirectUri, Code) ->
    Params = [{code, Code},
              {client_id, ClientKey},
              {client_secret, ClientSecret},
              {redirect_uri, RedirectUri},
              {grant_type, authorization_code}],
    http_request(post, get_url(authorize_token), Params).

refresh_token(ClientKey, ClientSecret, RefreshToken) ->
    Params = [{client_id, ClientKey},
              {client_secret, ClientSecret},
              {refresh_token, RefreshToken},
              {grant_type, refresh_token}],
    http_request(post, get_url(authorize_token), Params).

revoke_token(Token) ->
    http_request(get, get_url(revoke_token), [{token, Token}]).

scope(readonly) ->
    "https://www.googleapis.com/auth/youtube.readonly";
scope(audit) ->
    "https://www.googleapis.com/auth/youtubepartner-channel-audit".
