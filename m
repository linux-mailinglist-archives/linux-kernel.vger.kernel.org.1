Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F82DAFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgLOPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:24:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgLOPYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:24:12 -0500
Date:   Tue, 15 Dec 2020 12:23:43 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608045810;
        bh=Zn30Kj6lieu/m+TmuMKs6jU4G27N8gVd119f6G7fIsw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ff/yq/dRsRPS3TNWpKiz8Fkx6WBGAeu4Kis4smmrh4BC8QfBe6p3DhqmTRIQKy52D
         DwbjIelMLw4ypmACFzmENCG8LZ0s1uCh0ZAE5vF73gy03JIkf3Rjh11GKbSgst4Q8i
         Hhdzu9vjYCHPkLbxm8a5qb+1PavIkd6469XQM79gIXojYAbRVbvUIWJHDCceuXzD6z
         oD1e3hdg6NGA4P0TACUSpTVhg2fiml78ChrviWzTIkYSVjXe8J7zLqkeL4Wj1PNOSn
         DHpGgGVE6P7OJTUrZ0JmfSdCKgqMyDh6xlczmRsId8nhaWvLWM9akiynz/oEFJrVCr
         26WmLYzHpw9/w==
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
Subject: Re: [PATCH 3/3] perf tools: Add evlist/evlist-verbose control
 commands
Message-ID: <20201215152343.GG252952@kernel.org>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210204330.233864-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 10, 2020 at 09:43:30PM +0100, Jiri Olsa escreveu:
> Adding new control events to display all evlist events.
> 
> The interface string for control file is 'evlist' and
> 'evlist-verbose'.

Can't we pass args to such commands?

Then its just one event, i.e. "evlist", and -v can be passed to it.

i.e.:

The commands would be:

evlist

That produces:

 
   terminal 2:
     # echo evlist > control
 
   terminal 1:
     # perf record --control=fifo:control,ack -e 'sched:*'
     ...
     sched:sched_kthread_stop
     sched:sched_kthread_stop_ret
     sched:sched_waking

And 'evlist -v', that produces:

   terminal 2:
     # echo "evlist -v" > control
 
   terminal 1:
     ...
     sched:sched_kthread_stop: type: 2, size: 120, config: 0x145,      \
     { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU   \
     |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit:    \
     1, sample_id_all: 1, exclude_guest: 1
     sched:sched_kthread_stop_ret: type: 2, size: 120, config: 0x144   \
     , { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU \
     |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, \
     sample_id_all: 1, exclude_guest: 1
     ...

I think we could even change things such that we pass a file descriptor
for cmd_evlist to use, passing the argv received from the control file,
etc.

With this in place we could reuse more stuff and allow using this
control file to obtain information such as 'perf report --header-only',
etc.

echo "report --header-only" > control would get us the same thing as
'perf report --header-only' for an existing perf.data file:


# perf report --header-only
# ========
# captured on    : Tue Dec 15 12:21:23 2020
# header version : 1
# data offset    : 432
# data size      : 1648
# feat offset    : 2080
# hostname : five
# os release : 5.10.0-rc7+
# perf version : 5.10.rc6.gc56d2601b5d0
# arch : x86_64
# nrcpus online : 24
# nrcpus avail : 24
# cpudesc : AMD Ryzen 9 3900X 12-Core Processor
# cpuid : AuthenticAMD,23,113,0
# total memory : 32884432 kB
# cmdline : /home/acme/bin/perf record ls 
# event : name = cycles:u, , id = { 85540, 85541, 85542, 85543, 85544, 85545, 85546, 85547, 85548, 85549, 85550, 85551, 85552, 85553, 85554, 85555, 85556, 85557, 85558, 85559, 85560, 85561, 85562, 85563 }, size = 120, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, read_format = ID, disabled = 1, inherit = 1, exclude_kernel = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: amd_df = 8, software = 1, ibs_op = 11, power = 14, ibs_fetch = 10, uprobe = 7, cpu = 4, amd_iommu_0 = 12, breakpoint = 5, amd_l3 = 9, tracepoint = 2, kprobe = 6, msr = 13
# CACHE info available, use -I to display
# time of first sample : 12184.494971
# time of last sample : 12184.495496
# sample duration :      0.525 ms
# MEM_TOPOLOGY info available, use -I to display
# cpu pmu capabilities: max_precise=0
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA 
# ========
#

I.e. users would discover that using this control file is as easy as
working with perf.data files or with the pipe mode, all the three ways
of interacting with perf would use the same command interface arguments.

- Arnaldo
 
> When evlist is received, perf will scan and print current
> evlist into perf record terminal.
> 
> When evlist-verbose is received perf will scan and print
> current evlist details (like perf evlist -v) into perf
> record terminal.
> 
> Example session:
> 
>   terminal 1:
>     # mkfifo control ack perf.pipe
>     # perf record --control=fifo:control,ack -e 'sched:*'
> 
>   terminal 2:
>     # echo evlist > control
> 
>   terminal 1:
>     # perf record --control=fifo:control,ack -e 'sched:*'
>     ...
>     sched:sched_kthread_stop
>     sched:sched_kthread_stop_ret
>     sched:sched_waking
>     sched:sched_wakeup
>     sched:sched_wakeup_new
>     sched:sched_switch
>     sched:sched_migrate_task
>     sched:sched_process_free
>     sched:sched_process_exit
>     ...
> 
>   terminal 2:
>     # echo evlist-vebose > control
> 
>   terminal 1:
>     ...
>     sched:sched_kthread_stop: type: 2, size: 120, config: 0x145,      \
>     { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU   \
>     |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit:    \
>     1, sample_id_all: 1, exclude_guest: 1
>     sched:sched_kthread_stop_ret: type: 2, size: 120, config: 0x144   \
>     , { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU \
>     |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, \
>     sample_id_all: 1, exclude_guest: 1
>     ...
> 
> This new evlist command is handy to get real event names when
> wildcards are used.
> 
> The evlist-verbose is handy to check on actually enabled perf_event_attr
> values.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c |  2 ++
>  tools/perf/builtin-stat.c   |  2 ++
>  tools/perf/util/evlist.c    | 15 +++++++++++++++
>  tools/perf/util/evlist.h    |  4 ++++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 582b8fba012c..d40406880722 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1951,6 +1951,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			case EVLIST_CTL_CMD_UNSUPPORTED:
>  			case EVLIST_CTL_CMD_ENABLE_EVSEL:
>  			case EVLIST_CTL_CMD_DISABLE_EVSEL:
> +			case EVLIST_CTL_CMD_EVLIST:
> +			case EVLIST_CTL_CMD_EVLIST_VERBOSE:
>  			default:
>  				break;
>  			}
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6a21fb665008..425e2a8ebde6 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -592,6 +592,8 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
>  		case EVLIST_CTL_CMD_UNSUPPORTED:
>  		case EVLIST_CTL_CMD_ENABLE_EVSEL:
>  		case EVLIST_CTL_CMD_DISABLE_EVSEL:
> +		case EVLIST_CTL_CMD_EVLIST:
> +		case EVLIST_CTL_CMD_EVLIST_VERBOSE:
>  		default:
>  			break;
>  		}
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 729c98d10628..571d2ad61f4a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -24,6 +24,7 @@
>  #include "bpf-event.h"
>  #include "util/string2.h"
>  #include "util/perf_api_probe.h"
> +#include "util/evsel_fprintf.h"
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sched.h>
> @@ -1931,6 +1932,12 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>  				    (sizeof(EVLIST_CTL_CMD_SNAPSHOT_TAG)-1))) {
>  			*cmd = EVLIST_CTL_CMD_SNAPSHOT;
>  			pr_debug("is snapshot\n");
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG,
> +				    (sizeof(EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_EVLIST_VERBOSE;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_TAG,
> +				    (sizeof(EVLIST_CTL_CMD_EVLIST_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_EVLIST;
>  		}
>  	}
>  
> @@ -1954,6 +1961,7 @@ int evlist__ctlfd_ack(struct evlist *evlist)
>  
>  int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  {
> +	struct perf_attr_details details = { .verbose = false, };
>  	int err = 0;
>  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
>  	int ctlfd_pos = evlist->ctl_fd.pos;
> @@ -1995,6 +2003,13 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  					pr_info("failed: can't find '%s' event\n", evsel_name);
>  				}
>  				break;
> +			case EVLIST_CTL_CMD_EVLIST_VERBOSE:
> +				details.verbose = true;
> +				__fallthrough;
> +			case EVLIST_CTL_CMD_EVLIST:
> +				evlist__for_each_entry(evlist, evsel)
> +					evsel__fprintf(evsel, &details, stderr);
> +				break;
>  			case EVLIST_CTL_CMD_SNAPSHOT:
>  				break;
>  			case EVLIST_CTL_CMD_ACK:
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e4e8ff8831a3..7892f084632d 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -332,6 +332,8 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
>  #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
>  #define EVLIST_CTL_CMD_ENABLE_EVSEL_TAG "enable-"
>  #define EVLIST_CTL_CMD_DISABLE_EVSEL_TAG "disable-"
> +#define EVLIST_CTL_CMD_EVLIST_TAG "evlist"
> +#define EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG "evlist-verbose"
>  
>  #define EVLIST_CTL_CMD_MAX_LEN 64
>  
> @@ -343,6 +345,8 @@ enum evlist_ctl_cmd {
>  	EVLIST_CTL_CMD_DISABLE_EVSEL,
>  	EVLIST_CTL_CMD_ACK,
>  	EVLIST_CTL_CMD_SNAPSHOT,
> +	EVLIST_CTL_CMD_EVLIST,
> +	EVLIST_CTL_CMD_EVLIST_VERBOSE,
>  };
>  
>  int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
