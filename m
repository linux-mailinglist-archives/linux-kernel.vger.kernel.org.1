Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9600A285E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgJGLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJGLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602070949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q0aMpdtHmjtiVuvPnkusn1q5PI8l4NX+s9BFMDv7+0A=;
        b=AiwgXf+BO+qK4m6GR0XwukGme9u+hOui4F23Z9ytXS/8yYQG02z/TbmaO4K5hqZMj631k+
        9XLD8DeQkr9VkruGTcSKGyguzY35zcdkrD2b0QPcYpS0C8Ug/r2hQe6C1iccNKpebcxGJH
        bIeglpPyjCwJ52YETrRkJZv1/jbVYl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-0tlkMBAAO4eOAVGZCJbuJg-1; Wed, 07 Oct 2020 07:42:25 -0400
X-MC-Unique: 0tlkMBAAO4eOAVGZCJbuJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20527100746D;
        Wed,  7 Oct 2020 11:42:23 +0000 (UTC)
Received: from krava (unknown [10.40.195.148])
        by smtp.corp.redhat.com (Postfix) with SMTP id 570A25C1C4;
        Wed,  7 Oct 2020 11:42:20 +0000 (UTC)
Date:   Wed, 7 Oct 2020 13:42:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Wei Li <liwei391@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] perf stat: Fix segfault on armv8_pmu events
Message-ID: <20201007114219.GD249615@krava>
References: <20201007081311.1831003-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007081311.1831003-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 05:13:11PM +0900, Namhyung Kim wrote:
> It was reported that perf stat crashed when using with armv8_pmu (cpu)
> events with the task mode.  As perf stat uses an empty cpu map for
> task mode but armv8_pmu has its own cpu mask, it confused which map
> should use when accessing file descriptors and caused segfaults:
> 
>   (gdb) bt
>   #0  0x0000000000603fc8 in perf_evsel__close_fd_cpu (evsel=<optimized out>,
>       cpu=<optimized out>) at evsel.c:122
>   #1  perf_evsel__close_cpu (evsel=evsel@entry=0x716e950, cpu=7) at evsel.c:156
>   #2  0x00000000004d4718 in evlist__close (evlist=0x70a7cb0) at util/evlist.c:1242
>   #3  0x0000000000453404 in __run_perf_stat (argc=3, argc@entry=1, argv=0x30,
>       argv@entry=0xfffffaea2f90, run_idx=119, run_idx@entry=1701998435)
>       at builtin-stat.c:929
>   #4  0x0000000000455058 in run_perf_stat (run_idx=1701998435, argv=0xfffffaea2f90,
>       argc=1) at builtin-stat.c:947
>   #5  cmd_stat (argc=1, argv=0xfffffaea2f90) at builtin-stat.c:2357
>   #6  0x00000000004bb888 in run_builtin (p=p@entry=0x9764b8 <commands+288>,
>       argc=argc@entry=4, argv=argv@entry=0xfffffaea2f90) at perf.c:312
>   #7  0x00000000004bbb54 in handle_internal_command (argc=argc@entry=4,
>       argv=argv@entry=0xfffffaea2f90) at perf.c:364
>   #8  0x0000000000435378 in run_argv (argcp=<synthetic pointer>,
>       argv=<synthetic pointer>) at perf.c:408
>   #9  main (argc=4, argv=0xfffffaea2f90) at perf.c:538
> 
> To fix this, I simply used the given cpu map unless the evsel actually
> is not a system-wide event (like uncore events).
> 
> Reported-by: Wei Li <liwei391@huawei.com>
> Tested-by: Barry Song <song.bao.hua@hisilicon.com>
> Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/evlist.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 2208444ecb44..cfcdbd7be066 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  	if (!evsel->own_cpus || evlist->has_user_cpus) {
>  		perf_cpu_map__put(evsel->cpus);
>  		evsel->cpus = perf_cpu_map__get(evlist->cpus);
> +	} else if (!evsel->system_wide && perf_cpu_map__empty(evlist->cpus)) {
> +		perf_cpu_map__put(evsel->cpus);
> +		evsel->cpus = perf_cpu_map__get(evlist->cpus);
>  	} else if (evsel->cpus != evsel->own_cpus) {
>  		perf_cpu_map__put(evsel->cpus);
>  		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> -- 
> 2.28.0.806.g8561365e88-goog
> 

