Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48252DB0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgLOQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbgLOQKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:10:03 -0500
Date:   Tue, 15 Dec 2020 13:09:33 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608048562;
        bh=G8LauUBDTHOQ67ExcgtNj04kVKPB3Yunn3AUUi+zP98=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJjLsEBMwHUelWhtzSm6XNEsUkVhAN0mgGb+E9tXSu7y+SVEyOZrZukTiQvYELuna
         8obEnLQfJ8FZZwTfjiFKPL8OKpTwxmO6uJDUwkvz0t5ViO847XXVBwPq3hzjxQLTrR
         /vN7SUDt14cKT5SPBmB9A0ZsDxVdOBxUK+iQ581NvP6QQIBSd72UJtmMBZXn4mTuvs
         gZIgLylRpKqWfhkDN+NlLyJ4oq92jvPDyM99bf1wMJ2NvTr44l/AwRkCw6SuvE23bt
         uDajBt37N/JGQCeauaYy4FP8UfJX/fzjH1aM2EE/D1id/7D5yaWw4O9hVME/oKMb9V
         rp9FvvGWwBm/g==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20201215160933.GO258566@kernel.org>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-4-jolsa@kernel.org>
 <20201215152343.GG252952@kernel.org>
 <20201215155911.GD658008@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215155911.GD658008@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 15, 2020 at 04:59:11PM +0100, Jiri Olsa escreveu:
> On Tue, Dec 15, 2020 at 12:23:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Dec 10, 2020 at 09:43:30PM +0100, Jiri Olsa escreveu:
> > > Adding new control events to display all evlist events.
> > > 
> > > The interface string for control file is 'evlist' and
> > > 'evlist-verbose'.
> > 
> > Can't we pass args to such commands?
> > 
> > Then its just one event, i.e. "evlist", and -v can be passed to it.
> 
> it's possible but it adds another processing to the single record thread
> where we want to be fast

> but I agree it could be helpful to get the other output that evsel__fprintf
> can print, and we already call evsel__fprintf, so it's just a matter of
> setting 'struct perf_attr_details' properly
 
> I need to check, but perhaps we could use ' ' instead of '-' and have:
> 
>   echo 'evlist -v' > control
>   echo 'evlist -g' > control
>   echo 'evlist -F' > control
 
> and have:
 
>   echo 'enable cycles' > control
 
> instead of:
 
>   echo 'enable-cycles' > control
 
> I'd like to avoid any elaborate parsing logic..
 
> how about that?

Use space to separate command from its arguments, keep the same
experience as:

[acme@quaco ~]$ perf evlist -h

 Usage: perf evlist [<options>]

    -f, --force           don't complain, do it
    -F, --freq            Show the sample frequency
    -g, --group           Show event group information
    -i, --input <file>    Input file name
    -v, --verbose         Show all event attr details
        --trace-fields    Show tracepoint fields

[acme@quaco ~]$

and:

echo "evlist arguments"

?

Fits the bill :-)

The experience users have on existing commands, the same arguments, etc.

Even -h can have its uses, i.e. has this daemon support for some option
or is it an old version?

- Arnaldo
 
> > 
> > i.e.:
> > 
> > The commands would be:
> > 
> > evlist
> > 
> > That produces:
> > 
> >  
> >    terminal 2:
> >      # echo evlist > control
> >  
> >    terminal 1:
> >      # perf record --control=fifo:control,ack -e 'sched:*'
> >      ...
> >      sched:sched_kthread_stop
> >      sched:sched_kthread_stop_ret
> >      sched:sched_waking
> > 
> > And 'evlist -v', that produces:
> > 
> >    terminal 2:
> >      # echo "evlist -v" > control
> >  
> >    terminal 1:
> >      ...
> >      sched:sched_kthread_stop: type: 2, size: 120, config: 0x145,      \
> >      { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU   \
> >      |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit:    \
> >      1, sample_id_all: 1, exclude_guest: 1
> >      sched:sched_kthread_stop_ret: type: 2, size: 120, config: 0x144   \
> >      , { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU \
> >      |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, \
> >      sample_id_all: 1, exclude_guest: 1
> >      ...
> > 
> > I think we could even change things such that we pass a file descriptor
> > for cmd_evlist to use, passing the argv received from the control file,
> > etc.
> 
> hum, so perf evlist opens/reads perf.data, which we do not have ready
> at that point in perf record
> 
> > 
> > With this in place we could reuse more stuff and allow using this
> > control file to obtain information such as 'perf report --header-only',
> > etc.
> > 
> > echo "report --header-only" > control would get us the same thing as
> > 'perf report --header-only' for an existing perf.data file:
> 
> all those header data are written when record is exiting or dumped
> for switch output, so we don't have that data at that moment control
> command is received
> 
> > 
> > 
> > # perf report --header-only
> > # ========
> > # captured on    : Tue Dec 15 12:21:23 2020
> > # header version : 1
> > # data offset    : 432
> > # data size      : 1648
> > # feat offset    : 2080
> > # hostname : five
> > # os release : 5.10.0-rc7+
> > # perf version : 5.10.rc6.gc56d2601b5d0
> > # arch : x86_64
> > # nrcpus online : 24
> > # nrcpus avail : 24
> > # cpudesc : AMD Ryzen 9 3900X 12-Core Processor
> > # cpuid : AuthenticAMD,23,113,0
> > # total memory : 32884432 kB
> > # cmdline : /home/acme/bin/perf record ls 
> > # event : name = cycles:u, , id = { 85540, 85541, 85542, 85543, 85544, 85545, 85546, 85547, 85548, 85549, 85550, 85551, 85552, 85553, 85554, 85555, 85556, 85557, 85558, 85559, 85560, 85561, 85562, 85563 }, size = 120, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, read_format = ID, disabled = 1, inherit = 1, exclude_kernel = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
> > # CPU_TOPOLOGY info available, use -I to display
> > # NUMA_TOPOLOGY info available, use -I to display
> > # pmu mappings: amd_df = 8, software = 1, ibs_op = 11, power = 14, ibs_fetch = 10, uprobe = 7, cpu = 4, amd_iommu_0 = 12, breakpoint = 5, amd_l3 = 9, tracepoint = 2, kprobe = 6, msr = 13
> > # CACHE info available, use -I to display
> > # time of first sample : 12184.494971
> > # time of last sample : 12184.495496
> > # sample duration :      0.525 ms
> > # MEM_TOPOLOGY info available, use -I to display
> > # cpu pmu capabilities: max_precise=0
> > # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA 
> > # ========
> > #
> > 
> > I.e. users would discover that using this control file is as easy as
> > working with perf.data files or with the pipe mode, all the three ways
> > of interacting with perf would use the same command interface arguments.
> 
> yep, I agree we can mimic the similar arguments, but I doubt we
> can easily reuse the same code for that
> 
> jirka
> 

-- 

- Arnaldo
