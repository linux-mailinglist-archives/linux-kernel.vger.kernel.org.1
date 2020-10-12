Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAC28AEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgJLHDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgJLHCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:02:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB3C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 1so2229228ple.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yk0QOk6H5np+MiDRWtj9bNoIkJMyYk6ejzTpATnxulw=;
        b=ui2K2ovHTOnI8eToAEg9Cu1wzK9/78I1SesmomC1qt92eHcslxfWmZu5uv0uZMx694
         FYsfkuAedBxmHxEyjDwE4T7NenQBWGYVG5tvFjNlRf4/mrrFfxsLQTHzdYXAjcggASfJ
         qlENd1YVT6LGGcwFcEXlWAlMgFQGBpMxz4CKplnxPzdWkvahRZsD0jgLm6zn9Zb1r0TA
         B9jI3ZAenwx3wyLvwgUMvUV25bvOdgb68il3CnRrf9mBWyEolFEDuW4V+CmPOj86PM/P
         Yce1qRzutIQJkRxWjD4DSEKkZgRUySgu4AQc/TmBLG0ZlRIqy2Y1TGdPkMr9E/NIYTqy
         J2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Yk0QOk6H5np+MiDRWtj9bNoIkJMyYk6ejzTpATnxulw=;
        b=uEzGm6DZqBwz87BYNEHuNuWSY62nm9WUZML5WccYo7eUPTxpMBBs4jUTIYjzGUfSRt
         HYsHH7j90o2IXztGWP3mfQWA93UdOfUR8yc3XC/lFrr4MWrfRoUXJKPWM3TizZGDRQk3
         QKkRu3I8viLZOQiGc7s/OcQY7EeFi73t0ALVdbBZLPqGI4MKCZ6q58ezW7RY3hmcoDWy
         u1cdkxnigTvxOMVQo2BxLOOixZloc0T5EaF7i+S3WkCOPG8BK3PrrHPpA9pINlETQoDh
         Nmpi9tvQnF8zXMOHkziyspll9XjCH4vNiFbpxoK7J15kRxKExsM0OJUGnPuKxVdhlmjE
         YHng==
X-Gm-Message-State: AOAM53358c4LibqWHmrhpvOriy79lbQuxkyN4pShHrnPHcbN0hYQK1cL
        HGmH0P5ha9Jae7jPDwv0kNY=
X-Google-Smtp-Source: ABdhPJxmrvDEofuNBukUqC2/08n3OWSCwdX4u/PTAEshwl/LQzT3pEzbBFNAu8SKyZo68fjmTw2PNw==
X-Received: by 2002:a17:902:24d:b029:d2:564c:654b with SMTP id 71-20020a170902024db02900d2564c654bmr21334592plc.8.1602486160079;
        Mon, 12 Oct 2020 00:02:40 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id n12sm18082556pgk.20.2020.10.12.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:02:39 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 6/6] perf bench: Run inject-build-id with --buildid-all option too
Date:   Mon, 12 Oct 2020 16:02:14 +0900
Message-Id: <20201012070214.2074921-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201012070214.2074921-1-namhyung@kernel.org>
References: <20201012070214.2074921-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For comparison, it now runs the benchmark twice - one if regular -b
and another for --buildid-all.

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 21.002 msec (+- 0.172 msec)
    Average time per event: 2.059 usec (+- 0.017 usec)
    Average memory usage: 8169 KB (+- 0 KB)
    Average build-id-all injection took: 19.543 msec (+- 0.124 msec)
    Average time per event: 1.916 usec (+- 0.012 usec)
    Average memory usage: 7348 KB (+- 0 KB)

Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/inject-buildid.c | 54 ++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 0fccf2a9e95b..e9a11f4a1109 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -271,7 +271,7 @@ static void *data_reader(void *arg)
 	return NULL;
 }
 
-static int setup_injection(struct bench_data *data)
+static int setup_injection(struct bench_data *data, bool build_id_all)
 {
 	int ready_pipe[2];
 	int dev_null_fd;
@@ -292,6 +292,7 @@ static int setup_injection(struct bench_data *data)
 
 	if (data->pid == 0) {
 		const char **inject_argv;
+		int inject_argc = 2;
 
 		close(data->input_pipe[1]);
 		close(data->output_pipe[0]);
@@ -308,17 +309,22 @@ static int setup_injection(struct bench_data *data)
 
 		dup2(dev_null_fd, STDERR_FILENO);
 
-		inject_argv = calloc(3, sizeof(*inject_argv));
+		if (build_id_all)
+			inject_argc++;
+
+		inject_argv = calloc(inject_argc + 1, sizeof(*inject_argv));
 		if (inject_argv == NULL)
 			exit(1);
 
 		inject_argv[0] = strdup("inject");
 		inject_argv[1] = strdup("-b");
+		if (build_id_all)
+			inject_argv[2] = strdup("--buildid-all");
 
 		/* signal that we're ready to go */
 		close(ready_pipe[1]);
 
-		cmd_inject(2, inject_argv);
+		cmd_inject(inject_argc, inject_argv);
 
 		exit(0);
 	}
@@ -377,27 +383,17 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 	return 0;
 }
 
-static int do_inject_loop(struct bench_data *data)
+static void do_inject_loop(struct bench_data *data, bool build_id_all)
 {
 	unsigned int i;
 	struct stats time_stats, mem_stats;
 	double time_average, time_stddev;
 	double mem_average, mem_stddev;
 
-	srand(time(NULL));
 	init_stats(&time_stats);
 	init_stats(&mem_stats);
-	symbol__init(NULL);
 
-	bench_sample_type  = PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP;
-	bench_sample_type |= PERF_SAMPLE_TID | PERF_SAMPLE_TIME;
-	bench_id_hdr_size  = 32;
-
-	collect_dso();
-	if (nr_dsos == 0) {
-		printf("  Cannot collect DSOs for injection\n");
-		return -1;
-	}
+	pr_debug("  Build-id%s injection benchmark\n", build_id_all ? "-all" : "");
 
 	for (i = 0; i < iterations; i++) {
 		struct timeval start, end, diff;
@@ -405,7 +401,7 @@ static int do_inject_loop(struct bench_data *data)
 
 		pr_debug("  Iteration #%d\n", i+1);
 
-		if (setup_injection(data) < 0) {
+		if (setup_injection(data, build_id_all) < 0) {
 			printf("  Build-id injection setup failed\n");
 			break;
 		}
@@ -427,8 +423,8 @@ static int do_inject_loop(struct bench_data *data)
 
 	time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
 	time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
-	printf("  Average build-id injection took: %.3f msec (+- %.3f msec)\n",
-		time_average, time_stddev);
+	printf("  Average build-id%s injection took: %.3f msec (+- %.3f msec)\n",
+	       build_id_all ? "-all" : "", time_average, time_stddev);
 
 	/* each iteration, it processes MMAP2 + BUILD_ID + nr_samples * SAMPLE */
 	time_average = avg_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
@@ -440,6 +436,26 @@ static int do_inject_loop(struct bench_data *data)
 	mem_stddev = stddev_stats(&mem_stats);
 	printf("  Average memory usage: %.0f KB (+- %.0f KB)\n",
 		mem_average, mem_stddev);
+}
+
+static int do_inject_loops(struct bench_data *data)
+{
+
+	srand(time(NULL));
+	symbol__init(NULL);
+
+	bench_sample_type  = PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP;
+	bench_sample_type |= PERF_SAMPLE_TID | PERF_SAMPLE_TIME;
+	bench_id_hdr_size  = 32;
+
+	collect_dso();
+	if (nr_dsos == 0) {
+		printf("  Cannot collect DSOs for injection\n");
+		return -1;
+	}
+
+	do_inject_loop(data, false);
+	do_inject_loop(data, true);
 
 	release_dso();
 	return 0;
@@ -455,6 +471,6 @@ int bench_inject_build_id(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	return do_inject_loop(&data);
+	return do_inject_loops(&data);
 }
 
-- 
2.28.0.1011.ga647a8990f-goog

