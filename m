Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA428B1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgJLJpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgJLJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602495929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZ/TGq5ldmWSAlRVzQNLCfGYzRK8Qwe7aw7zlLxUn5s=;
        b=SjMuymgxmfeojtYhQW5UPjUp59dMnNkQKw5BDL+/vFm580tpg6YVlQwJChtN5bpy3G3UDw
        fItI3z3ACa9hBtchcMVrE8fgAmoesgoA9duTGVffc2aRtdpkyw4kCkZNis6LwIV/ZmhQU0
        O4wpHarYbSPmRRrBudo44uxl2kM17to=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-z20msJTrMemPNI1_KWLd7Q-1; Mon, 12 Oct 2020 05:45:26 -0400
X-MC-Unique: z20msJTrMemPNI1_KWLd7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51669835B8C;
        Mon, 12 Oct 2020 09:45:24 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4C0B5C225;
        Mon, 12 Oct 2020 09:45:21 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:45:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peng Fan <fanpeng@loongson.cn>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bench: Use condition variables in numa.
Message-ID: <20201012094520.GE1099489@krava>
References: <20201010064056.3489559-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201010064056.3489559-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:40:56PM -0700, Ian Rogers wrote:
> The existing approach to synchronization between threads in the numa
> benchmark is unbalanced mutexes. This synchronization causes thread
> sanitizer to warn of locks being taken twice on a thread without an
> unlock, as well as unlocks with no corresponding locks.
> This change replaces the synchronization with more regular condition
> variables. While this fixes one class of thread sanitizer warnings,
> there still remain warnings of data races due to threads reading and
> writing shared memory without any atomics.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

hi,
I'm getting:

  BUILD:   Doing 'make -j8' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  CC       bench/numa.o
bench/numa.c: In function ‘init’:
bench/numa.c:1461:24: error: ‘struct global_info’ has no member named ‘startup_done_mutex’; did you mean ‘startup_mutex’?
 1461 |  init_global_mutex(&g->startup_done_mutex);
      |                        ^~~~~~~~~~~~~~~~~~
      |                        startup_mutex
bench/numa.c:1462:23: error: ‘struct global_info’ has no member named ‘startup_done_cond’; did you mean ‘startup_cond’?
 1462 |  init_global_cond(&g->startup_done_cond);
      |                       ^~~~~~~~~~~~~~~~~
      |                       startup_cond

jirka


> ---
>  tools/perf/bench/numa.c | 67 ++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index f85bceccc459..d8c5a674203e 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -137,12 +137,13 @@ struct global_info {
>  	u8			*data;
>  
>  	pthread_mutex_t		startup_mutex;
> +	pthread_cond_t		startup_cond;
>  	int			nr_tasks_started;
>  
> -	pthread_mutex_t		startup_done_mutex;
> -
>  	pthread_mutex_t		start_work_mutex;
> +	pthread_cond_t		start_work_cond;
>  	int			nr_tasks_working;
> +	bool			start_work;
>  
>  	pthread_mutex_t		stop_work_mutex;
>  	u64			bytes_done;
> @@ -483,6 +484,18 @@ static void init_global_mutex(pthread_mutex_t *mutex)
>  	pthread_mutex_init(mutex, &attr);
>  }
>  
> +/*
> + * Return a process-shared (global) condition variable:
> + */
> +static void init_global_cond(pthread_cond_t *cond)
> +{
> +	pthread_condattr_t attr;
> +
> +	pthread_condattr_init(&attr);
> +	pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> +	pthread_cond_init(cond, &attr);
> +}
> +
>  static int parse_cpu_list(const char *arg)
>  {
>  	p0.cpu_list_str = strdup(arg);
> @@ -1136,15 +1149,18 @@ static void *worker_thread(void *__tdata)
>  	if (g->p.serialize_startup) {
>  		pthread_mutex_lock(&g->startup_mutex);
>  		g->nr_tasks_started++;
> +		/* The last thread wakes the main process. */
> +		if (g->nr_tasks_started == g->p.nr_tasks)
> +			pthread_cond_signal(&g->startup_cond);
> +
>  		pthread_mutex_unlock(&g->startup_mutex);
>  
>  		/* Here we will wait for the main process to start us all at once: */
>  		pthread_mutex_lock(&g->start_work_mutex);
> +		g->start_work = false;
>  		g->nr_tasks_working++;
> -
> -		/* Last one wake the main process: */
> -		if (g->nr_tasks_working == g->p.nr_tasks)
> -			pthread_mutex_unlock(&g->startup_done_mutex);
> +		while (!g->start_work)
> +			pthread_cond_wait(&g->start_work_cond, &g->start_work_mutex);
>  
>  		pthread_mutex_unlock(&g->start_work_mutex);
>  	}
> @@ -1441,8 +1457,9 @@ static int init(void)
>  
>  	/* Startup serialization: */
>  	init_global_mutex(&g->start_work_mutex);
> -	init_global_mutex(&g->startup_mutex);
> +	init_global_cond(&g->start_work_cond);
>  	init_global_mutex(&g->startup_done_mutex);
> +	init_global_cond(&g->startup_done_cond);
>  	init_global_mutex(&g->stop_work_mutex);
>  
>  	init_thread_data();
> @@ -1502,9 +1519,6 @@ static int __bench_numa(const char *name)
>  	pids = zalloc(g->p.nr_proc * sizeof(*pids));
>  	pid = -1;
>  
> -	/* All threads try to acquire it, this way we can wait for them to start up: */
> -	pthread_mutex_lock(&g->start_work_mutex);
> -
>  	if (g->p.serialize_startup) {
>  		tprintf(" #\n");
>  		tprintf(" # Startup synchronization: ..."); fflush(stdout);
> @@ -1526,22 +1540,29 @@ static int __bench_numa(const char *name)
>  		pids[i] = pid;
>  
>  	}
> -	/* Wait for all the threads to start up: */
> -	while (g->nr_tasks_started != g->p.nr_tasks)
> -		usleep(USEC_PER_MSEC);
> -
> -	BUG_ON(g->nr_tasks_started != g->p.nr_tasks);
>  
>  	if (g->p.serialize_startup) {
> +		bool threads_ready = false;
>  		double startup_sec;
>  
> -		pthread_mutex_lock(&g->startup_done_mutex);
> +		/*
> +		 * Wait for all the threads to start up. The last thread will
> +		 * signal this process.
> +		 */
> +		pthread_mutex_lock(&g->startup_mutex);
> +		while (g->nr_tasks_started != g->p.nr_tasks)
> +			pthread_cond_wait(&g->startup_cond, &g->startup_mutex);
>  
> -		/* This will start all threads: */
> -		pthread_mutex_unlock(&g->start_work_mutex);
> +		pthread_mutex_unlock(&g->startup_mutex);
>  
> -		/* This mutex is locked - the last started thread will wake us: */
> -		pthread_mutex_lock(&g->startup_done_mutex);
> +		/* Wait for all threads to be at the start_work_cond. */
> +		while (!threads_ready) {
> +			pthread_mutex_lock(&g->start_work_mutex);
> +			threads_ready = (g->nr_tasks_working == g->p.nr_tasks);
> +			pthread_mutex_unlock(&g->start_work_mutex);
> +			if (!threads_ready)
> +				usleep(1);
> +		}
>  
>  		gettimeofday(&stop, NULL);
>  
> @@ -1555,7 +1576,11 @@ static int __bench_numa(const char *name)
>  		tprintf(" #\n");
>  
>  		start = stop;
> -		pthread_mutex_unlock(&g->startup_done_mutex);
> +		/* Start all threads running. */
> +		pthread_mutex_lock(&g->start_work_mutex);
> +		g->start_work = true;
> +		pthread_mutex_unlock(&g->start_work_mutex);
> +		pthread_cond_broadcast(&g->start_work_cond);
>  	} else {
>  		gettimeofday(&start, NULL);
>  	}
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 

