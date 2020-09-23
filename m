Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B83B2752DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIWIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgIWIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:06:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD13C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:06:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f2so13906735pgd.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJBasXocpUU+Bz9vZdJA+fWHz/licg1h7bfEG9sfx1U=;
        b=hPD7Z1bbI5H+SvZ8ZYU2LNL7mkCZb7juSnG7gi6sn2naVjMoIW+T7TTh+89l+XNCBs
         3tRHKTpU3/W6QSr2hE6ThIImOvFOPo6LBDLK1RsHtSrUCUcV0BziguOw1TDWFaYAd0HQ
         pInhA8FzhAMRXpMExAnmr36I/0V4N8N7kPxafFGV7DaBX55Rw37lMtDILfHFdD0NJsG2
         gr+Djj0ZoWI/PY0Pu9BCY/hnLm4UZwBEV94pA1xIKYTb4QHjb+CGRP+EtSSToy2N3w6H
         1SV18VDLQHF+pEfelY3DnP9j3pQXIY/Z0cDggI+demDZpMVT8lNq3HntRRciIcv9ytQ7
         908w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fJBasXocpUU+Bz9vZdJA+fWHz/licg1h7bfEG9sfx1U=;
        b=ngrh3utr4uY/yXwEQJBlNdkGx3+ioY726ZT7RR77w/D2+7+nXY8JsUrJpJj+jaTPs4
         biCSjHAJDPVXGhuGfeHhXEoTLZbj5UVA+U80YJiN+o/vMJVJejLDsNPXvc/Ps3UqS4qF
         ZAIcrUY0nEXWsQSDQAiM/h9c/uBq0W3J8+OoFP3wBKWiurazlL2iqRG+iFznhjI3VNt7
         3GrL9z6MF+2T4nAwVS1ShVgaAjr+bEgaE1ZNRLhAgJpGgi5pCxQZACI5ao9c469xmXsg
         honqkfonxaO7/e9+70w9SO9GwOVguMevyjCrKjGwIl6fk5aamJE2ztZLQuwZ6WJMe0jZ
         4DJw==
X-Gm-Message-State: AOAM531bKBG2CxYrYRZeIPe7gzV809zE+R0D/3mplG3JCWvsFrJUyCEb
        rGsxVrFFCkqQRygSxXHtPSZozRV/VFo=
X-Google-Smtp-Source: ABdhPJzluwpUt/gxCex7cVWE49xH2eevvcm1Tro5+hfVE498OsWagB7pL6xikf1WQyAO4r7Q/xfPZA==
X-Received: by 2002:a05:6a00:1343:b029:142:2501:35e6 with SMTP id k3-20020a056a001343b0290142250135e6mr2393114pfu.70.1600848365925;
        Wed, 23 Sep 2020 01:06:05 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a27sm17568441pfk.52.2020.09.23.01.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 01:06:05 -0700 (PDT)
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
Subject: [PATCH 6/7] perf bench: Run inject-build-id with --buildid-all option too
Date:   Wed, 23 Sep 2020 17:05:36 +0900
Message-Id: <20200923080537.155264-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923080537.155264-1-namhyung@kernel.org>
References: <20200923080537.155264-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For comparison, it now runs the benchmark twice - one if regular -b
and another for --buildid-all.

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 18.441 msec (+- 0.106 msec)
    Average time per event: 1.808 usec (+- 0.010 usec)
    Average build-id-all injection took: 13.451 msec (+- 0.132 msec)
    Average time per event: 1.319 usec (+- 0.013 usec)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/inject-buildid.c | 47 ++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index e5144a85d689..7c9f2baecef2 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -220,7 +220,7 @@ static void sigpipe_handler(int sig __maybe_unused)
 	/* child exited */
 }
 
-static int setup_injection(struct bench_data *data)
+static int setup_injection(struct bench_data *data, bool build_id_all)
 {
 	int ready_pipe[2];
 	int dev_null_fd;
@@ -241,6 +241,7 @@ static int setup_injection(struct bench_data *data)
 
 	if (data->pid == 0) {
 		const char **inject_argv;
+		int inject_argc = 2;
 
 		close(data->input_pipe[1]);
 		close(data->output_pipe[0]);
@@ -257,17 +258,22 @@ static int setup_injection(struct bench_data *data)
 
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
@@ -348,21 +354,14 @@ static int inject_build_id(struct bench_data *data)
 	return 0;
 }
 
-static int do_inject_loop(struct bench_data *data)
+static void do_inject_loop(struct bench_data *data, bool build_id_all)
 {
 	unsigned int i;
 	struct stats time_stats;
 	double time_average, time_stddev;
 
-	srand(time(NULL));
 	init_stats(&time_stats);
-	symbol__init(NULL);
-
-	collect_dso();
-	if (nr_dsos == 0) {
-		printf("  Cannot collect DSOs for injection\n");
-		return -1;
-	}
+	pr_debug("  Build-id%s injection benchmark\n", build_id_all ? "-all" : "");
 
 	for (i = 0; i < iterations; i++) {
 		struct timeval start, end, diff;
@@ -370,7 +369,7 @@ static int do_inject_loop(struct bench_data *data)
 
 		pr_debug("  Iteration #%d\n", i+1);
 
-		if (setup_injection(data) < 0) {
+		if (setup_injection(data, build_id_all) < 0) {
 			printf("  Build-id injection setup failed\n");
 			break;
 		}
@@ -389,14 +388,30 @@ static int do_inject_loop(struct bench_data *data)
 
 	time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
 	time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
-	printf("  Average build-id injection took: %.3f msec (+- %.3f msec)\n",
-		time_average, time_stddev);
+	printf("  Average build-id%s injection took: %.3f msec (+- %.3f msec)\n",
+	       build_id_all ? "-all" : "", time_average, time_stddev);
 
 	/* each iteration, it processes MMAP2 + BUILD_ID + nr_samples * SAMPLE */
 	time_average = avg_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
 	time_stddev = stddev_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
 	printf("  Average time per event: %.3f usec (+- %.3f usec)\n",
 		time_average, time_stddev);
+}
+
+static int do_inject_loops(struct bench_data *data)
+{
+
+	srand(time(NULL));
+	symbol__init(NULL);
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
@@ -412,6 +427,6 @@ int bench_inject_build_id(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	return do_inject_loop(&data);
+	return do_inject_loops(&data);
 }
 
-- 
2.28.0.681.g6f77f65b4e-goog

