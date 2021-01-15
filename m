Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458B32F8593
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbhAOTdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbhAOTdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:33:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BD6E23A6C;
        Fri, 15 Jan 2021 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610739179;
        bh=gScAWWsN0B1quqVQiE30mgPDdRq7TktH/lThBD3RjwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFRUycWSVXqVsku7Sim1aAi4N1ql2RxH6opRdTR7GScraWHKDliu1QqQw9MHy0t8c
         ZYqqy/Omnun9NIdhXHC8+ECkNMlR/lBPI/SO4WxoUFNj0mA+D8wKynF6zBb7pgnJ6q
         /81YhjE9E12f6+2NCyxaRHZOe9lPllR6PcF6h0UaDtSKc2LsNOVmbKm1qa2kgpfW6a
         Uv+ZLxHIu2vxk8HNzoL0nUaUF+0lT1VHospGFwvqi9YGIkNsZRAI9CwJmcx/goBjTs
         IQBqoHgm+dKri+hNjgftyRnbbCTCY5nN4VhZ6/E8mRafpoJicaLhG8Kn9l7ctylt9q
         RTFLQOL4OKIMw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B74D840522; Fri, 15 Jan 2021 16:33:32 -0300 (-03)
Date:   Fri, 15 Jan 2021 16:33:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix 'CPU too large' error
Message-ID: <20210115193332.GI457607@kernel.org>
References: <20210107174159.24897-1-adrian.hunter@intel.com>
 <225955df-f11f-d627-0690-6864f46151f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225955df-f11f-d627-0690-6864f46151f5@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 07, 2021 at 03:46:03PM -0500, Liang, Kan escreveu:
> 
> 
> On 1/7/2021 12:41 PM, Adrian Hunter wrote:
> > In some cases, the number of cpus (nr_cpus_online) is confused with the
> > maximum cpu number (nr_cpus_avail), which results in the error in the
> > example below:
> > 
> > Example on system with 8 cpus:
> > 
> >   Before:
> >     # echo 0 > /sys/devices/system/cpu/cpu2/online
> >     # ./perf record --kcore -e intel_pt// taskset --cpu-list 7 uname
> >     Linux
> >     [ perf record: Woken up 1 times to write data ]
> >     [ perf record: Captured and wrote 0.147 MB perf.data ]
> >     # ./perf script --itrace=e
> >     Requested CPU 7 too large. Consider raising MAX_NR_CPUS
> >     0x25908 [0x8]: failed to process type: 68 [Invalid argument]
> > 
> >   After:
> >     # ./perf script --itrace=e
> >     #
> > 
> > Fixes: 8c7274691f0d ("perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online")
> > Fixes: 7df4e36a4785 ("perf session: Replace MAX_NR_CPUS with perf_env::nr_cpus_online")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Kan
> 
> > ---
> >   tools/perf/util/machine.c | 4 ++--
> >   tools/perf/util/session.c | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 1ae32a81639c..46844599d25d 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2977,7 +2977,7 @@ int machines__for_each_thread(struct machines *machines,
> >   pid_t machine__get_current_tid(struct machine *machine, int cpu)
> >   {
> > -	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
> > +	int nr_cpus = min(machine->env->nr_cpus_avail, MAX_NR_CPUS);
> >   	if (cpu < 0 || cpu >= nr_cpus || !machine->current_tid)
> >   		return -1;
> > @@ -2989,7 +2989,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
> >   			     pid_t tid)
> >   {
> >   	struct thread *thread;
> > -	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
> > +	int nr_cpus = min(machine->env->nr_cpus_avail, MAX_NR_CPUS);
> >   	if (cpu < 0)
> >   		return -EINVAL;
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 3b3c50b12791..2777c2df7d87 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -2391,7 +2391,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
> >   {
> >   	int i, err = -1;
> >   	struct perf_cpu_map *map;
> > -	int nr_cpus = min(session->header.env.nr_cpus_online, MAX_NR_CPUS);
> > +	int nr_cpus = min(session->header.env.nr_cpus_avail, MAX_NR_CPUS);
> >   	for (i = 0; i < PERF_TYPE_MAX; ++i) {
> >   		struct evsel *evsel;
> > 

-- 

- Arnaldo
