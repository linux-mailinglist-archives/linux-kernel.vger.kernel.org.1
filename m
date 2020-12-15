Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028B52DB068
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgLOPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbgLOPqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:46:14 -0500
Date:   Tue, 15 Dec 2020 12:45:46 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047133;
        bh=/NofofITGR9fSTQ0qpGr+6v4fzgf491DpFUoiBT/IIw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7MbQg0wNYzEH16hPsCideeheltrB9EAnz1QHt+colGaytBTFBE6+e85l9fm1fF9C
         gJ0jkU3+F4Nsjj6bP7IuR/NjtKcXsFNFL/pi04xMAgfaXacBxjiaXgAkC1iSi2ctDi
         G6YSrgBhvNZVsFfDleMJFUVQAgo8UTrJLnVzldatR8ccBrZq0rcK/Ts4MrZA4bI6gM
         y9z1ajMnU+kX/GsAGUP+9iHNDKscq1gDUmawAoXHQrj3y/oMHU2Fe0YyQyrtIcBh7d
         6YnQrwwGRF+f+BFTCWZXUQnCgWsNtF2fCno6PLjY6NNYwjt5pTFgBaATXziu54/PwL
         1HNW4tXA6mlIg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 6/8] perf daemon: Add stop command
Message-ID: <20201215154546.GG258566@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212104358.412065-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 12, 2020 at 11:43:56AM +0100, Jiri Olsa escreveu:
> Allow 'perf daemon' to stop daemon process:
> 
>   # perf daemon --stop
>   perf daemon is exciting

It looks exciting, yes, a nice functionality! ;-)

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-daemon.txt |  8 ++++++++
>  tools/perf/builtin-daemon.c              | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
> index 203ec4bf704c..87de2c77e4c7 100644
> --- a/tools/perf/Documentation/perf-daemon.txt
> +++ b/tools/perf/Documentation/perf-daemon.txt
> @@ -35,6 +35,9 @@ OPTIONS
>  	Send SIGUSR2 to specific session, if session is not specified,
>  	send SIGUSR2 to all sessions.
>  
> +--stop::
> +	Stop daemon.
> +
>  -v::
>  --verbose::
>  	Be more verbose.
> @@ -116,6 +119,11 @@ And check that the perf data dump was trigered:
>    [ perf record: Dump /opt/perfdata/2/perf.data.2020120715220385 ]
>  
>  
> +Stop daemon:
> +
> +  # perf daemon --stop
> +  perf daemon is exciting
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-config[1]
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index c53d4ddc2b49..855fed2fe364 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -451,6 +451,7 @@ enum cmd {
>  	CMD_LIST         = 0,
>  	CMD_LIST_VERBOSE = 1,
>  	CMD_SIGNAL       = 2,
> +	CMD_STOP         = 3,
>  	CMD_MAX,
>  };
>  
> @@ -528,6 +529,10 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
>  	case CMD_SIGNAL:
>  		ret = cmd_session_kill(daemon, out, fd);
>  		break;
> +	case CMD_STOP:
> +		done = 1;
> +		pr_debug("perf daemon is exciting\n");
> +		break;
>  	default:
>  		break;
>  	}
> @@ -811,6 +816,7 @@ int cmd_daemon(int argc, const char **argv)
>  {
>  	bool foreground = false;
>  	bool signal = false;
> +	bool stop = false;
>  	const char *config = NULL;
>  	const char *signal_str = NULL;
>  	struct daemon daemon = {
> @@ -821,6 +827,7 @@ int cmd_daemon(int argc, const char **argv)
>  		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  		OPT_STRING(0, "config", &config,
>  			   "config file", "config file path"),
> +		OPT_BOOLEAN(0, "stop", &stop, "stop daemon"),
>  		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),
>  		OPT_STRING_OPTARG_SET('s', "signal", &signal_str, &signal,
>  				      "signal", "send signal to session", "all"),
> @@ -837,5 +844,8 @@ int cmd_daemon(int argc, const char **argv)
>  	if (signal)
>  		return send_cmd(&daemon, CMD_SIGNAL, signal_str);
>  
> +	if (stop)
> +		return send_cmd(&daemon, CMD_STOP, NULL);
> +
>  	return send_cmd(&daemon, verbose ? CMD_LIST_VERBOSE : CMD_LIST, NULL);
>  }
> -- 
> 2.26.2
> 

-- 

- Arnaldo
