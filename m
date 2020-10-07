Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC63285FA6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgJGNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgJGNAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:00:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B4B20789;
        Wed,  7 Oct 2020 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602075637;
        bh=p0NpfMg5qGpHMPRsTfjjz4dYZN7gugSrRA8G3P7VURI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vj0jJojacTKdt2e4kGLbeQ9DHQt6JNO8rcK7N4I3kd0DDtxHNIbnPOcZK96674/zo
         +aXVEmOiE8BWUvUDOjEJIwzPWVH8VSPqFON4V+GZojJ2ErtcUaLvkt9889wqt7/8/1
         PO2N3tAEMYl8tZMQwdPsuwJABcjdz1dPpSGYWN00=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EDD92403AC; Wed,  7 Oct 2020 10:00:34 -0300 (-03)
Date:   Wed, 7 Oct 2020 10:00:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Wei Li <liwei391@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] perf stat: Fix segfault on armv8_pmu events
Message-ID: <20201007130034.GA244810@kernel.org>
References: <20201007081311.1831003-1-namhyung@kernel.org>
 <20201007114219.GD249615@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007114219.GD249615@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 07, 2020 at 01:42:19PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 07, 2020 at 05:13:11PM +0900, Namhyung Kim wrote:
> > It was reported that perf stat crashed when using with armv8_pmu (cpu)
> > events with the task mode.  As perf stat uses an empty cpu map for
> > task mode but armv8_pmu has its own cpu mask, it confused which map
> > should use when accessing file descriptors and caused segfaults:
> > 
> >   (gdb) bt
> >   #0  0x0000000000603fc8 in perf_evsel__close_fd_cpu (evsel=<optimized out>,
> >       cpu=<optimized out>) at evsel.c:122
> >   #1  perf_evsel__close_cpu (evsel=evsel@entry=0x716e950, cpu=7) at evsel.c:156
> >   #2  0x00000000004d4718 in evlist__close (evlist=0x70a7cb0) at util/evlist.c:1242
> >   #3  0x0000000000453404 in __run_perf_stat (argc=3, argc@entry=1, argv=0x30,
> >       argv@entry=0xfffffaea2f90, run_idx=119, run_idx@entry=1701998435)
> >       at builtin-stat.c:929
> >   #4  0x0000000000455058 in run_perf_stat (run_idx=1701998435, argv=0xfffffaea2f90,
> >       argc=1) at builtin-stat.c:947
> >   #5  cmd_stat (argc=1, argv=0xfffffaea2f90) at builtin-stat.c:2357
> >   #6  0x00000000004bb888 in run_builtin (p=p@entry=0x9764b8 <commands+288>,
> >       argc=argc@entry=4, argv=argv@entry=0xfffffaea2f90) at perf.c:312
> >   #7  0x00000000004bbb54 in handle_internal_command (argc=argc@entry=4,
> >       argv=argv@entry=0xfffffaea2f90) at perf.c:364
> >   #8  0x0000000000435378 in run_argv (argcp=<synthetic pointer>,
> >       argv=<synthetic pointer>) at perf.c:408
> >   #9  main (argc=4, argv=0xfffffaea2f90) at perf.c:538
> > 
> > To fix this, I simply used the given cpu map unless the evsel actually
> > is not a system-wide event (like uncore events).
> > 
> > Reported-by: Wei Li <liwei391@huawei.com>
> > Tested-by: Barry Song <song.bao.hua@hisilicon.com>
> > Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/lib/perf/evlist.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 2208444ecb44..cfcdbd7be066 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >  	if (!evsel->own_cpus || evlist->has_user_cpus) {
> >  		perf_cpu_map__put(evsel->cpus);
> >  		evsel->cpus = perf_cpu_map__get(evlist->cpus);
> > +	} else if (!evsel->system_wide && perf_cpu_map__empty(evlist->cpus)) {
> > +		perf_cpu_map__put(evsel->cpus);
> > +		evsel->cpus = perf_cpu_map__get(evlist->cpus);
> >  	} else if (evsel->cpus != evsel->own_cpus) {
> >  		perf_cpu_map__put(evsel->cpus);
> >  		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> > -- 
> > 2.28.0.806.g8561365e88-goog
> > 
> 

-- 

- Arnaldo
