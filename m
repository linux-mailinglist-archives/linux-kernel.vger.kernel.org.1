Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B42DAFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgLOPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgLOPOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:14:42 -0500
Date:   Tue, 15 Dec 2020 12:14:13 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608045241;
        bh=iMFOdnRzrnuIAvjgZ5mCkX2hD/Jc1MpHI3wlawSYZac=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqQwKUKVBZiH//UFkaKnWoLTeV/YIrb12zg4BsWaRf31Im6BFMIP2k4P1BjfsMT2+
         GvWTlxjCzD6PJAp3ao5BxecQpzFUQoWmCjm4w6eMO5lLLCZ+rjJ1JdysGpvS4YMqDZ
         PEGbaw+LiTkvjLP/Uj/tExAdmIGtEKECkE6HYWA7qIuK+M8WTYR0FEMF7kIzGOg5YA
         fN/3c/9YQ+mfuYd46yTQaVnuQRfAPlhCHxkabrRnmZR0j/tku1hpEA26jHwjU/zMMR
         xPcAoNtFf51dPQ3kctKZLSGkJjfcE1syPFS3lzgIZRn67E31nAs6fTkUbwGnCZqvFx
         IuwZKXy4VJXrQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 2/3] perf tools: Allow to enable/disable events via
 control file
Message-ID: <20201215151413.GE252952@kernel.org>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210204330.233864-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 10, 2020 at 09:43:29PM +0100, Jiri Olsa escreveu:
> Adding new control events to enable/disable specific event.
> The interface string for control file are:
> 
>   'enable-<EVENT NAME>'
>   'disable-<EVENT NAME>'

Wwy do we have "enable-" as the "tag" for this?

Also is it possible to use "enable sched:*" and have that match what is
in the evlist and enable (or disable, if using "disable sched:*") what
matches?

This second suggestion can be done on top of this, i.e. as an
enhancement, but mixing up the command (enable, disable) with its
arguments looks strange.

- Arnaldo
 
> when received the command, perf will scan the current evlist
> for <EVENT NAME> and if found it's enabled/disabled.
> 
> Example session:
> 
>   terminal 1:
>     # mkfifo control ack perf.pipe
>     # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
>     Events disabled
> 
>   terminal 2:
>     # cat perf.pipe | ./perf --no-pager script -i -
> 
>   terminal 3:
>     # echo enable-sched:sched_process_fork > control
> 
>   terminal 1:
>     # mkfifo control ack perf.pipe
>     # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
>     ...
>     event sched:sched_process_fork enabled
> 
>   terminal 2:
>     # cat perf.pipe | ./perf --no-pager script -i -
>     bash 33349 [034] 149587.674295: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34056
>     bash 33349 [034] 149588.239521: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34057
> 
>   terminal 3:
>     # echo enable-sched:sched_wakeup_new > control
> 
>   terminal 1:
>     # mkfifo control ack perf.pipe
>     # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
>     ...
>     event sched:sched_wakeup_new enabled
> 
>   terminal 2:
>     # cat perf.pipe | ./perf --no-pager script -i -
>     ...
>     bash 33349 [034] 149632.228023: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34059
>     bash 33349 [034] 149632.228050:   sched:sched_wakeup_new: bash:34059 [120] success=1 CPU:036
>     bash 33349 [034] 149633.950005: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34060
>     bash 33349 [034] 149633.950030:   sched:sched_wakeup_new: bash:34060 [120] success=1 CPU:036
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c |  2 ++
>  tools/perf/builtin-stat.c   |  2 ++
>  tools/perf/util/evlist.c    | 30 +++++++++++++++++++++++++++++-
>  tools/perf/util/evlist.h    |  4 ++++
>  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d832c108a1ca..582b8fba012c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1949,6 +1949,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  				break;
>  			case EVLIST_CTL_CMD_ACK:
>  			case EVLIST_CTL_CMD_UNSUPPORTED:
> +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
> +			case EVLIST_CTL_CMD_DISABLE_EVSEL:
>  			default:
>  				break;
>  			}
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 89c32692f40c..6a21fb665008 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -590,6 +590,8 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
>  		case EVLIST_CTL_CMD_SNAPSHOT:
>  		case EVLIST_CTL_CMD_ACK:
>  		case EVLIST_CTL_CMD_UNSUPPORTED:
> +		case EVLIST_CTL_CMD_ENABLE_EVSEL:
> +		case EVLIST_CTL_CMD_DISABLE_EVSEL:
>  		default:
>  			break;
>  		}
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 70aff26612a9..729c98d10628 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1915,7 +1915,13 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>  		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
>  
>  	if (bytes_read > 0) {
> -		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_EVSEL_TAG,
> +			     (sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_ENABLE_EVSEL;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_EVSEL_TAG,
> +				    (sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_DISABLE_EVSEL;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
>  			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
>  			*cmd = EVLIST_CTL_CMD_ENABLE;
>  		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> @@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
>  	int ctlfd_pos = evlist->ctl_fd.pos;
>  	struct pollfd *entries = evlist->core.pollfd.entries;
> +	struct evsel *evsel;
> +	char *evsel_name;
>  
>  	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
>  		return 0;
> @@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  			case EVLIST_CTL_CMD_DISABLE:
>  				evlist__disable(evlist);
>  				break;
> +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
> +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
> +				evsel = evlist__find_evsel_by_str(evlist, evsel_name);
> +				if (evsel) {
> +					evlist__enable_evsel(evlist, evsel_name);
> +					pr_info("event %s enabled\n", evsel->name);
> +				} else {
> +					pr_info("failed: can't find '%s' event\n", evsel_name);
> +				}
> +				break;
> +			case EVLIST_CTL_CMD_DISABLE_EVSEL:
> +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG) - 1;
> +				evsel = evlist__find_evsel_by_str(evlist, evsel_name);
> +				if (evsel) {
> +					evlist__disable_evsel(evlist, evsel_name);
> +					pr_info("event %s disabled\n", evsel->name);
> +				} else {
> +					pr_info("failed: can't find '%s' event\n", evsel_name);
> +				}
> +				break;
>  			case EVLIST_CTL_CMD_SNAPSHOT:
>  				break;
>  			case EVLIST_CTL_CMD_ACK:
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 1aae75895dea..e4e8ff8831a3 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -330,6 +330,8 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
>  #define EVLIST_CTL_CMD_DISABLE_TAG "disable"
>  #define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
>  #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
> +#define EVLIST_CTL_CMD_ENABLE_EVSEL_TAG "enable-"
> +#define EVLIST_CTL_CMD_DISABLE_EVSEL_TAG "disable-"
>  
>  #define EVLIST_CTL_CMD_MAX_LEN 64
>  
> @@ -337,6 +339,8 @@ enum evlist_ctl_cmd {
>  	EVLIST_CTL_CMD_UNSUPPORTED = 0,
>  	EVLIST_CTL_CMD_ENABLE,
>  	EVLIST_CTL_CMD_DISABLE,
> +	EVLIST_CTL_CMD_ENABLE_EVSEL,
> +	EVLIST_CTL_CMD_DISABLE_EVSEL,
>  	EVLIST_CTL_CMD_ACK,
>  	EVLIST_CTL_CMD_SNAPSHOT,
>  };
> -- 
> 2.26.2
> 

-- 

- Arnaldo
