Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5A42FC470
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbhASXHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390101AbhASORm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:17:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEF7A2312B;
        Tue, 19 Jan 2021 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611065801;
        bh=WdALA20uLKCngqo4AGEBJL8UiufT7fdSLEHPoC1nJI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaqhy972klok16Vy1jZDUt4pwXHyGBztZ2wnW7ly53V423OMaaV+vo/LOKe2h+6bS
         kHiuOAVJOx1GBwZhIEebBaU578BPCANWxHHoWnvgRRrWnHeBMHZb1C+lyIQa+8kb/9
         51ni8/6hTJrl80L/xyd9LBTFxKrcN8E4JrzuxPwKEgR2McTN8+W/0yKmWr5uEyLVv+
         IRot5LPy8XNYDy/wzyVmhffvyAHbsyKZ4soNRPLL0vaT03Mq/i3DyflrE9ICxw7ocn
         YbHd/VlFF0GytEJy0oUTuAz5uipfnlDAAMsT0lgijrp0vDqMz8zbrnpBbZwsXc/+XY
         62Yy9uSmC034Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4171340CE2; Tue, 19 Jan 2021 11:16:37 -0300 (-03)
Date:   Tue, 19 Jan 2021 11:16:37 -0300
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
Subject: Re: [PATCH 1/4] perf tools: Allow to enable/disable events via
 control file
Message-ID: <20210119141637.GH12699@kernel.org>
References: <20201226232038.390883-1-jolsa@kernel.org>
 <20201226232038.390883-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226232038.390883-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 27, 2020 at 12:20:35AM +0100, Jiri Olsa escreveu:
> Adding new control events to enable/disable specific event.
> The interface string for control file are:
> 
>   'enable <EVENT NAME>'
>   'disable <EVENT NAME>'
> 
> when received the command, perf will scan the current evlist
> for <EVENT NAME> and if found it's enabled/disabled.
> 
> Example session:
> 
>   terminal 1:
>     # mkfifo control ack perf.pipe
>     # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
> 
>   terminal 2:
>     # cat perf.pipe | perf --no-pager script -i -
> 
>   terminal 1:
>     Events disabled
> 
>   NOTE Above message will show only after read side of the pipe ('>')
>   is started on 'terminal 2'. The 'terminal 1's bash does not execute
>   perf before that, hence the delyaed perf record message.
> 
>   terminal 3:
>     # echo 'enable sched:sched_process_fork' > control
> 
>   terminal 1:
>     event sched:sched_process_fork enabled
> 
>   terminal 2:
>     bash 33349 [034] 149587.674295: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34056
>     bash 33349 [034] 149588.239521: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34057
> 
>   terminal 3:
>     # echo 'enable sched:sched_wakeup_new' > control
> 
>   terminal 1:
>     event sched:sched_wakeup_new enabled
> 
>   terminal 2:
>     bash 33349 [034] 149632.228023: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34059
>     bash 33349 [034] 149632.228050:   sched:sched_wakeup_new: bash:34059 [120] success=1 CPU:036
>     bash 33349 [034] 149633.950005: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34060
>     bash 33349 [034] 149633.950030:   sched:sched_wakeup_new: bash:34060 [120] success=1 CPU:036

'disable' doesn't seem to be working:

Terminal 3:

[root@five ~]# echo 'enable sched:sched_process_fork' > control
[root@five ~]# echo 'disable sched:sched_process_fork' > control
[root@five ~]# echo 'disable' > control
[root@five ~]# echo 'disable sched:sched_process_fork' > control
[root@five ~]# echo 'disable sched:sched_process_fork' > control
[root@five ~]# echo 'enable sched:sched_process_fork' > control
[root@five ~]# echo 'disable sched:sched_process_fork' > control
[root@five ~]# echo 'enable sched:sched_process_fork' > control
[root@five ~]# echo 'disable sched:sched_process_fork' > control
[root@five ~]# echo 'enable' > control
[root@five ~]# echo 'disable' > control
[root@five ~]# echo 'disable' > control
[root@five ~]# echo 'disable' > control
[root@five ~]#

Terminal 1:

[root@five ~]# perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' > perf.pipe
Events disabled
Event sched:sched_process_fork enabled
Event sched:sched_process_fork disabled
Event sched:sched_process_fork enabled
Event sched:sched_process_fork disabled
Events enabled

I tried also with '-o -', made no difference and:

[root@five ~]# perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
Events disabled
Event sched:sched_process_fork enabled
Event sched:sched_process_fork disabled
Event sched:sched_process_fork disabled

The second probably should be more clear stating that that event was
already disabled.

Probably your example with all the sched tracepoints make 'perf record'
just process the stream of events and not look at the commands?

If I try with:

[root@five ~]# perf list sched:sched_process_* 2> /dev/null

List of pre-defined events (to be used in -e):

  sched:sched_process_exec                           [Tracepoint event]
  sched:sched_process_exit                           [Tracepoint event]
  sched:sched_process_fork                           [Tracepoint event]
  sched:sched_process_free                           [Tracepoint event]
  sched:sched_process_wait                           [Tracepoint event]

[root@five ~]#

[root@five ~]# perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:sched_process_*' -o - > perf.pipe
Events disabled
Events enabled
Events disabled

It works.

So it is a pre-existing problem, I'll continue processing your patches
and make a note about this...

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-record.txt |  8 +--
>  tools/perf/builtin-record.c              |  8 +--
>  tools/perf/builtin-stat.c                |  2 -
>  tools/perf/util/evlist.c                 | 63 ++++++++++++++++++++++--
>  4 files changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 34cf651ee237..05a85da0f7c5 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -640,9 +640,11 @@ ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
>  Listen on ctl-fd descriptor for command to control measurement.
>  
>  Available commands:
> -  'enable'  : enable events
> -  'disable' : disable events
> -  'snapshot': AUX area tracing snapshot).
> +  'enable'       : enable events
> +  'disable'      : disable events
> +  'enable name'  : enable event 'name'
> +  'disable name' : disable event 'name'
> +  'snapshot'     : AUX area tracing snapshot).
>  
>  Measurements can be started with events disabled using --delay=-1 option. Optionally
>  send control command completion ('ack\n') to ack-fd descriptor to synchronize with the
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index fd3911650612..7302e7527d40 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1937,18 +1937,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
>  			switch (cmd) {
> -			case EVLIST_CTL_CMD_ENABLE:
> -				pr_info(EVLIST_ENABLED_MSG);
> -				break;
> -			case EVLIST_CTL_CMD_DISABLE:
> -				pr_info(EVLIST_DISABLED_MSG);
> -				break;
>  			case EVLIST_CTL_CMD_SNAPSHOT:
>  				hit_auxtrace_snapshot_trigger(rec);
>  				evlist__ctlfd_ack(rec->evlist);
>  				break;
>  			case EVLIST_CTL_CMD_ACK:
>  			case EVLIST_CTL_CMD_UNSUPPORTED:
> +			case EVLIST_CTL_CMD_ENABLE:
> +			case EVLIST_CTL_CMD_DISABLE:
>  			default:
>  				break;
>  			}
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 8cc24967bc27..3c6712ed5af7 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -578,14 +578,12 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
>  	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
>  		switch (cmd) {
>  		case EVLIST_CTL_CMD_ENABLE:
> -			pr_info(EVLIST_ENABLED_MSG);
>  			if (interval)
>  				process_interval();
>  			break;
>  		case EVLIST_CTL_CMD_DISABLE:
>  			if (interval)
>  				process_interval();
> -			pr_info(EVLIST_DISABLED_MSG);
>  			break;
>  		case EVLIST_CTL_CMD_SNAPSHOT:
>  		case EVLIST_CTL_CMD_ACK:
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 05363a7247c4..c71c7e035641 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1957,6 +1957,64 @@ int evlist__ctlfd_ack(struct evlist *evlist)
>  	return err;
>  }
>  
> +static int get_cmd_arg(char *cmd_data, size_t cmd_size, char **arg)
> +{
> +	char *data = cmd_data + cmd_size;
> +
> +	/* no argument */
> +	if (!*data)
> +		return 0;
> +
> +	/* there's argument */
> +	if (*data == ' ') {
> +		*arg = data + 1;
> +		return 1;
> +	}
> +
> +	/* malformed */
> +	return -1;
> +}
> +
> +static int evlist__ctlfd_enable(struct evlist *evlist, char *cmd_data, bool enable)
> +{
> +	struct evsel *evsel;
> +	char *name;
> +	int err;
> +
> +	err = get_cmd_arg(cmd_data,
> +			  enable ? sizeof(EVLIST_CTL_CMD_ENABLE_TAG) - 1 :
> +				   sizeof(EVLIST_CTL_CMD_DISABLE_TAG) - 1,
> +			  &name);
> +	if (err < 0) {
> +		pr_info("failed: wrong command\n");
> +		return -1;
> +	}
> +
> +	if (err) {
> +		evsel = evlist__find_evsel_by_str(evlist, name);
> +		if (evsel) {
> +			if (enable)
> +				evlist__enable_evsel(evlist, name);
> +			else
> +				evlist__disable_evsel(evlist, name);
> +			pr_info("Event %s %s\n", evsel->name,
> +				enable ? "enabled" : "disabled");
> +		} else {
> +			pr_info("failed: can't find '%s' event\n", name);
> +		}
> +	} else {
> +		if (enable) {
> +			evlist__enable(evlist);
> +			pr_info(EVLIST_ENABLED_MSG);
> +		} else {
> +			evlist__disable(evlist);
> +			pr_info(EVLIST_DISABLED_MSG);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  {
>  	int err = 0;
> @@ -1973,10 +2031,9 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  		if (err > 0) {
>  			switch (*cmd) {
>  			case EVLIST_CTL_CMD_ENABLE:
> -				evlist__enable(evlist);
> -				break;
>  			case EVLIST_CTL_CMD_DISABLE:
> -				evlist__disable(evlist);
> +				err = evlist__ctlfd_enable(evlist, cmd_data,
> +							   *cmd == EVLIST_CTL_CMD_ENABLE);
>  				break;
>  			case EVLIST_CTL_CMD_SNAPSHOT:
>  				break;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
