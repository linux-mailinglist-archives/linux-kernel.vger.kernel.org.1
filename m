Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB18289EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 08:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgJJGlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 02:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgJJGlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 02:41:04 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 23:41:01 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z12so5175102qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=EgPJ0BrgSTXhpNd3U4Eu5sxRcBQs+DWYJthybOS8sCY=;
        b=UjdIM3vdiC2mmNSFPRiE/zUkaTjedFa6QobYRZRqbQdGZYq87q1Doh2akshLYqFkco
         yq9HNzd1hwtEMhqUO1MBMuZgf9ggC7lsH1D1f1gIPii+DoPj+xfwXCUM2Fhxkz7Y86c4
         Jy8R3Vdtbh0OCi1mH5BSH9IbvCwahHP2C4qq5m3eHx4tej1dU7Sv1iaZxAlEafLfZO8p
         IFXKs9iKuopkMNEtrPD83qZIrkL3H5bsBraXSkTLpGx01lwVa/+Mc3Aw71dWaE96MY+z
         es31PvtPDnGzlGNHUPxI5FsqiPDXe4wgNHsOvO4HK5OwrVBmOtcYlKlEM1EZ0TQ5VKbf
         PRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=EgPJ0BrgSTXhpNd3U4Eu5sxRcBQs+DWYJthybOS8sCY=;
        b=du9t2yP7HgQOm9FkeijR0if2ZuxQHUdgS+X/7XtT4fUgYMXqfDglZPw5xc4I5Y8JGR
         ytpsepYKO9MD0MXql2DqGgypJ327zZQWuFBP+L2YAgNASMBhd8nQuF6+GTb75BpmOh/7
         zhn4ftVghi5jgUwfkEOyp/oM+l2yqCcw5SHhGhWjAli3NGCza7q/2TjWOQkqTPnoFUU8
         iktdyHIs+2egN04O0lmHIzl0fKlQscdVWPLN4JPHYXOmdtD3EJZGTpfwCWXObQhIGYOr
         tPrcmlkpmj9rJrqtBzUnYWJwJO/QHz3afSYBvV2Vw+2G5ilq3vdsKsUc+q9644VDwh3B
         4WJg==
X-Gm-Message-State: AOAM531YbMUXDHREklqPDwBaXNiYPOoUzC80Ca4nAwm0Sda4kvDSLTbx
        Zro6z2ovMm5FXzupEKBFTfEBqfa0Ow/s
X-Google-Smtp-Source: ABdhPJwN1L2YBSrrAxircNhX5RtuQnmrxY6W58NtTkOYGJaf2vQ4otPW5ztqRRbWnXToU/Xeoofxug3+qC7C
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:8ec6:: with SMTP id
 y6mr15654222qvb.24.1602312060722; Fri, 09 Oct 2020 23:41:00 -0700 (PDT)
Date:   Fri,  9 Oct 2020 23:40:56 -0700
Message-Id: <20201010064056.3489559-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH] perf bench: Use condition variables in numa.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peng Fan <fanpeng@loongson.cn>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing approach to synchronization between threads in the numa
benchmark is unbalanced mutexes. This synchronization causes thread
sanitizer to warn of locks being taken twice on a thread without an
unlock, as well as unlocks with no corresponding locks.
This change replaces the synchronization with more regular condition
variables. While this fixes one class of thread sanitizer warnings,
there still remain warnings of data races due to threads reading and
writing shared memory without any atomics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/numa.c | 67 ++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index f85bceccc459..d8c5a674203e 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -137,12 +137,13 @@ struct global_info {
 	u8			*data;
 
 	pthread_mutex_t		startup_mutex;
+	pthread_cond_t		startup_cond;
 	int			nr_tasks_started;
 
-	pthread_mutex_t		startup_done_mutex;
-
 	pthread_mutex_t		start_work_mutex;
+	pthread_cond_t		start_work_cond;
 	int			nr_tasks_working;
+	bool			start_work;
 
 	pthread_mutex_t		stop_work_mutex;
 	u64			bytes_done;
@@ -483,6 +484,18 @@ static void init_global_mutex(pthread_mutex_t *mutex)
 	pthread_mutex_init(mutex, &attr);
 }
 
+/*
+ * Return a process-shared (global) condition variable:
+ */
+static void init_global_cond(pthread_cond_t *cond)
+{
+	pthread_condattr_t attr;
+
+	pthread_condattr_init(&attr);
+	pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_cond_init(cond, &attr);
+}
+
 static int parse_cpu_list(const char *arg)
 {
 	p0.cpu_list_str = strdup(arg);
@@ -1136,15 +1149,18 @@ static void *worker_thread(void *__tdata)
 	if (g->p.serialize_startup) {
 		pthread_mutex_lock(&g->startup_mutex);
 		g->nr_tasks_started++;
+		/* The last thread wakes the main process. */
+		if (g->nr_tasks_started == g->p.nr_tasks)
+			pthread_cond_signal(&g->startup_cond);
+
 		pthread_mutex_unlock(&g->startup_mutex);
 
 		/* Here we will wait for the main process to start us all at once: */
 		pthread_mutex_lock(&g->start_work_mutex);
+		g->start_work = false;
 		g->nr_tasks_working++;
-
-		/* Last one wake the main process: */
-		if (g->nr_tasks_working == g->p.nr_tasks)
-			pthread_mutex_unlock(&g->startup_done_mutex);
+		while (!g->start_work)
+			pthread_cond_wait(&g->start_work_cond, &g->start_work_mutex);
 
 		pthread_mutex_unlock(&g->start_work_mutex);
 	}
@@ -1441,8 +1457,9 @@ static int init(void)
 
 	/* Startup serialization: */
 	init_global_mutex(&g->start_work_mutex);
-	init_global_mutex(&g->startup_mutex);
+	init_global_cond(&g->start_work_cond);
 	init_global_mutex(&g->startup_done_mutex);
+	init_global_cond(&g->startup_done_cond);
 	init_global_mutex(&g->stop_work_mutex);
 
 	init_thread_data();
@@ -1502,9 +1519,6 @@ static int __bench_numa(const char *name)
 	pids = zalloc(g->p.nr_proc * sizeof(*pids));
 	pid = -1;
 
-	/* All threads try to acquire it, this way we can wait for them to start up: */
-	pthread_mutex_lock(&g->start_work_mutex);
-
 	if (g->p.serialize_startup) {
 		tprintf(" #\n");
 		tprintf(" # Startup synchronization: ..."); fflush(stdout);
@@ -1526,22 +1540,29 @@ static int __bench_numa(const char *name)
 		pids[i] = pid;
 
 	}
-	/* Wait for all the threads to start up: */
-	while (g->nr_tasks_started != g->p.nr_tasks)
-		usleep(USEC_PER_MSEC);
-
-	BUG_ON(g->nr_tasks_started != g->p.nr_tasks);
 
 	if (g->p.serialize_startup) {
+		bool threads_ready = false;
 		double startup_sec;
 
-		pthread_mutex_lock(&g->startup_done_mutex);
+		/*
+		 * Wait for all the threads to start up. The last thread will
+		 * signal this process.
+		 */
+		pthread_mutex_lock(&g->startup_mutex);
+		while (g->nr_tasks_started != g->p.nr_tasks)
+			pthread_cond_wait(&g->startup_cond, &g->startup_mutex);
 
-		/* This will start all threads: */
-		pthread_mutex_unlock(&g->start_work_mutex);
+		pthread_mutex_unlock(&g->startup_mutex);
 
-		/* This mutex is locked - the last started thread will wake us: */
-		pthread_mutex_lock(&g->startup_done_mutex);
+		/* Wait for all threads to be at the start_work_cond. */
+		while (!threads_ready) {
+			pthread_mutex_lock(&g->start_work_mutex);
+			threads_ready = (g->nr_tasks_working == g->p.nr_tasks);
+			pthread_mutex_unlock(&g->start_work_mutex);
+			if (!threads_ready)
+				usleep(1);
+		}
 
 		gettimeofday(&stop, NULL);
 
@@ -1555,7 +1576,11 @@ static int __bench_numa(const char *name)
 		tprintf(" #\n");
 
 		start = stop;
-		pthread_mutex_unlock(&g->startup_done_mutex);
+		/* Start all threads running. */
+		pthread_mutex_lock(&g->start_work_mutex);
+		g->start_work = true;
+		pthread_mutex_unlock(&g->start_work_mutex);
+		pthread_cond_broadcast(&g->start_work_cond);
 	} else {
 		gettimeofday(&start, NULL);
 	}
-- 
2.28.0.1011.ga647a8990f-goog

