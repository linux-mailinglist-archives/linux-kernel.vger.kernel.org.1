Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DEB28BD5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403764AbgJLQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390043AbgJLQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:16:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2697CC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:16:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c196so6885332ybf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=graV3pGKh1wSZY3RtXTrko5CERBJDFLNGxisxbtlJMw=;
        b=hmJR1R1dur4ua18it34enqX+n5x5y0EvwVfbAsgm7qP5x7BTZjWf5sof12NZA2T5RD
         hl+KP6bE7+CmAlsYlsaooToVv2MgT+Yg/hiqGkwd+CZEnqYF+FNw39yo8Q2OJSXnMtQH
         DdRW3eqRNy+SY3BTeZnrBznxMYMI1w8UNE/Xrig049cP/BzVV1XzK2LMlO5YJl4YBFZg
         Zq3bV+1UQ+3yZ+pBrMn0godTadJh5178YuNSE/omP0Ixg7XwNc3AjfyUeUH1tigKmxyu
         toWL9HRsbd7UJH0t+Y0XAvFuoFWgWEoFeZO2UZ825AOOgPOVcJ4isHhC3XDDXySppTm5
         yQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=graV3pGKh1wSZY3RtXTrko5CERBJDFLNGxisxbtlJMw=;
        b=hSGVuCsS9rwx5H0FdePAi2Ed6VT/8Su/IAhtSCKuGKQX95SRfoXfTgi25gvwbybF4+
         lKdgdPaAz4Fal32QI9UsBsT78hQp3Rpcv0B/zqKyI9XV5PoZLxUpi9DiFoEbUbBnqKQc
         BalTCWLe4UYjJiH8FkfciLg9Oo8jPWqufa0K1bpCrXkfVdSMTVUPCZLrSJjpJSYpRpzD
         FLdMD184G33jDArlyJD/LU0qLHc0JrFj9+OvOYUV22amquoItcOycqSs9Lp2KqVEoIPO
         LAnXww6qgUnphbWxmCSgsINIO/Ut9iDfo4v+40uAAo6n4sTt5xJD/t3fvfz10LoWkoqh
         8Ptg==
X-Gm-Message-State: AOAM532PjeZey0Lde9fU9W3XtquH1Iq7sS2DuiOQGR0+SUlQJwH74d9C
        NodyUelmyqkK4mr9Rz0hgHhlJXlatloX
X-Google-Smtp-Source: ABdhPJzEx7g8DCF4p6ZkuOEX6HEuWobfi3/dLtAPZ6S90xvqI15QiEGD9YiX1NqaGpXJRe3xSgw0GB+se8Pr
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:e649:: with SMTP id
 d70mr13241751ybh.127.1602519379310; Mon, 12 Oct 2020 09:16:19 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:16:11 -0700
Message-Id: <20201012161611.366482-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2] perf bench: Use condition variables in numa.
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
index f85bceccc459..11726ec6285f 100644
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
+	init_global_cond(&g->start_work_cond);
 	init_global_mutex(&g->startup_mutex);
-	init_global_mutex(&g->startup_done_mutex);
+	init_global_cond(&g->startup_cond);
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

