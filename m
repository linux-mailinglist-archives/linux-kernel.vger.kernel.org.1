Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7DC275069
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIWFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:44:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47592 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbgIWFok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600839878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2qXsZKd/vU/MWqzDTpOj4DQMbDJw22PgzhR9McWPMQ=;
        b=fgM9hLrTKr0LpBSerEMQeHIsC0eXkGncNPz70rlveJBjp75T6DsB3W/sTIeRqz7jjQOyYx
        WKQFn4cQBYn8ZWfqu1ZZKxodPvUwTP4/cpPhR/u2de10m2uLd83JN1wOpFf5GZ2T6/tiI8
        pC9OAPBIKYqyuQGL8YcTnn8IcXEAv2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-6PLyP5rtOqikfpmET_x8CA-1; Wed, 23 Sep 2020 01:44:33 -0400
X-MC-Unique: 6PLyP5rtOqikfpmET_x8CA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51DA31091061;
        Wed, 23 Sep 2020 05:44:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2C81C702E7;
        Wed, 23 Sep 2020 05:44:27 +0000 (UTC)
Date:   Wed, 23 Sep 2020 07:44:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Message-ID: <20200923054426.GG2893484@krava>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922031346.15051-2-liwei391@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:13:45AM +0800, Wei Li wrote:
> When executing perf stat with armv8_pmu events with a workload, it will
> report a segfault as result.

please share the perf stat command line you see that segfault for

thanks,
jirka

> 
> (gdb) bt
> #0  0x0000000000603fc8 in perf_evsel__close_fd_cpu (evsel=<optimized out>,
>     cpu=<optimized out>) at evsel.c:122
> #1  perf_evsel__close_cpu (evsel=evsel@entry=0x716e950, cpu=7) at evsel.c:156
> #2  0x00000000004d4718 in evlist__close (evlist=0x70a7cb0) at util/evlist.c:1242
> #3  0x0000000000453404 in __run_perf_stat (argc=3, argc@entry=1, argv=0x30,
>     argv@entry=0xfffffaea2f90, run_idx=119, run_idx@entry=1701998435)
>     at builtin-stat.c:929
> #4  0x0000000000455058 in run_perf_stat (run_idx=1701998435, argv=0xfffffaea2f90,
>     argc=1) at builtin-stat.c:947
> #5  cmd_stat (argc=1, argv=0xfffffaea2f90) at builtin-stat.c:2357
> #6  0x00000000004bb888 in run_builtin (p=p@entry=0x9764b8 <commands+288>,
>     argc=argc@entry=4, argv=argv@entry=0xfffffaea2f90) at perf.c:312
> #7  0x00000000004bbb54 in handle_internal_command (argc=argc@entry=4,
>     argv=argv@entry=0xfffffaea2f90) at perf.c:364
> #8  0x0000000000435378 in run_argv (argcp=<synthetic pointer>,
>     argv=<synthetic pointer>) at perf.c:408
> #9  main (argc=4, argv=0xfffffaea2f90) at perf.c:538
> 
> After debugging, i found the root reason is that the xyarray fd is created
> by evsel__open_per_thread() ignoring the cpu passed in
> create_perf_stat_counter(), while the evsel' cpumap is assigned as the
> corresponding PMU's cpumap in __add_event(). Thus, the xyarray fd is created
> with ncpus of dummy cpumap and an out of bounds 'cpu' index will be used in
> perf_evsel__close_fd_cpu().
> 
> To address this, add a flag to mark this situation and avoid using the
> affinity technique when closing/enabling/disabling events.
> 
> Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
> Fixes: 704e2f5b700d ("perf stat: Use affinity for enabling/disabling events")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/lib/perf/include/internal/evlist.h |  1 +
>  tools/perf/builtin-stat.c                |  3 +++
>  tools/perf/util/evlist.c                 | 23 ++++++++++++++++++++++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 2d0fa02b036f..c02d7e583846 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -17,6 +17,7 @@ struct perf_evlist {
>  	struct list_head	 entries;
>  	int			 nr_entries;
>  	bool			 has_user_cpus;
> +	bool			 open_per_thread;
>  	struct perf_cpu_map	*cpus;
>  	struct perf_cpu_map	*all_cpus;
>  	struct perf_thread_map	*threads;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index fddc97cac984..6e6ceacce634 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -725,6 +725,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	if (group)
>  		perf_evlist__set_leader(evsel_list);
>  
> +	if (!(target__has_cpu(&target) && !target__has_per_thread(&target)))
> +		evsel_list->core.open_per_thread = true;
> +
>  	if (affinity__setup(&affinity) < 0)
>  		return -1;
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index e3fa3bf7498a..bf8a3ccc599f 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -383,6 +383,15 @@ void evlist__disable(struct evlist *evlist)
>  	int cpu, i, imm = 0;
>  	bool has_imm = false;
>  
> +	if (evlist->core.open_per_thread) {
> +		evlist__for_each_entry(evlist, pos) {
> +			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
> +				continue;
> +			evsel__disable(pos);
> +		}
> +		goto out;
> +	}
> +
>  	if (affinity__setup(&affinity) < 0)
>  		return;
>  
> @@ -414,6 +423,7 @@ void evlist__disable(struct evlist *evlist)
>  		pos->disabled = true;
>  	}
>  
> +out:
>  	evlist->enabled = false;
>  }
>  
> @@ -423,6 +433,15 @@ void evlist__enable(struct evlist *evlist)
>  	struct affinity affinity;
>  	int cpu, i;
>  
> +	if (evlist->core.open_per_thread) {
> +		evlist__for_each_entry(evlist, pos) {
> +			if (!evsel__is_group_leader(pos) || !pos->core.fd)
> +				continue;
> +			evsel__enable(pos);
> +		}
> +		goto out;
> +	}
> +
>  	if (affinity__setup(&affinity) < 0)
>  		return;
>  
> @@ -444,6 +463,7 @@ void evlist__enable(struct evlist *evlist)
>  		pos->disabled = false;
>  	}
>  
> +out:
>  	evlist->enabled = true;
>  }
>  
> @@ -1223,9 +1243,10 @@ void evlist__close(struct evlist *evlist)
>  
>  	/*
>  	 * With perf record core.cpus is usually NULL.
> +	 * Or perf stat may open events per-thread.
>  	 * Use the old method to handle this for now.
>  	 */
> -	if (!evlist->core.cpus) {
> +	if (evlist->core.open_per_thread || !evlist->core.cpus) {
>  		evlist__for_each_entry_reverse(evlist, evsel)
>  			evsel__close(evsel);
>  		return;
> -- 
> 2.17.1
> 

