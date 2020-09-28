Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBC227A917
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgI1Hx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1HxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:53:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C66C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so154887pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5Rf3jk2q/YuMBPVNHtFY1iN90x3sfokHfnghmckc+w=;
        b=TzHXrhxW37kvEQ3eXFNB4s3IPdX79T9czkvJDyzoew14iZuXw6yEVzBBvOd2Lmf16+
         YMLe8Ba7/BTcPOZRI0tHhUjFjKaQ6VbCVW7Ta5XPdvURQpZgv66ajMRBRDx8FqJPDYeV
         a7uvrVIhIDAn5YZ1p9bJutFQgcomUUgqaz/gUj3cyaG9MB/fRL/dkOJIj9TVSfuQFgZK
         sLv8r/JhA71Rtj25h8Kaa1SDj2hldd2hMg4PpxXTidaw7cZpOKB+IYfiQ5OqaqXrfafE
         5HflsWHvtbB9qmN/lCh8yP/JBO97xpnIPkRESHypIB4AfVO9lMvQeQpMRJPvjWGTG/iR
         TDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z5Rf3jk2q/YuMBPVNHtFY1iN90x3sfokHfnghmckc+w=;
        b=ObJj5Uah3zslEoxTgrjJWMRqNSXM+NJWDG8GK6AX3yrVsW2xmhLIFQkJKDi4/oc2zQ
         Wu72P1dWJO2hXkEBjSXqviRK1gLXRvCbSOXtaoxAcQjXvw5v8xh01swWjGt0OVQIAyOQ
         ybDpTQd2Pc8ajokdXIDJOEESzMuHzkoeBNvKFe0kV3+q9tLWymYVorr1SV9iRebX1Rln
         uUZDCiA760kgsj5KmT5/QlZScYaT2tzmP6Ru+U7UxqpEyyCaOTCQdl3CxBv32IxeiFhE
         AlaCRf1R3hxvjD9DjPn3vIyDudOo/zPRrUHXJoRnqpQ0X9n8/JSIim+oShObA2NrbkZG
         pVFA==
X-Gm-Message-State: AOAM531FOZdXJcN3WKO5c/aQYemoCJtwwe4zf4qp/HSaLCidli6HtF3w
        YwHPilNXXL1NO8dqFsJmSgs=
X-Google-Smtp-Source: ABdhPJyPJBEPDUC0O8mKCTLD7tNxshtvEfQJeL1wlZrcPdQqq2YYrV56ih0DxFR8spxZQHbWNFXRbQ==
X-Received: by 2002:a17:902:267:b029:d2:6180:4a46 with SMTP id 94-20020a1709020267b02900d261804a46mr471381plc.26.1601279603265;
        Mon, 28 Sep 2020 00:53:23 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 141sm520241pfb.50.2020.09.28.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 00:53:22 -0700 (PDT)
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
Date:   Mon, 28 Sep 2020 16:52:46 +0900
Message-Id: <20200928075246.853729-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200928075246.853729-1-namhyung@kernel.org>
References: <20200928075246.853729-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For comparison, it now runs the benchmark twice - one if regular -b
and another for --buildid-all.

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 18.112 msec (+- 0.034 msec)
    Average time per event: 1.776 usec (+- 0.003 usec)
    Average memory usage: 7388 KB (+- 6 KB)
    Average build-id-all injection took: 17.504 msec (+- 0.035 msec)
    Average time per event: 1.716 usec (+- 0.003 usec)
    Average memory usage: 7459 KB (+- 2 KB)

Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/inject-buildid.c | 46 +++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index b09f9126bb4f..02040eff6818 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -226,7 +226,7 @@ static void sigpipe_handler(int sig __maybe_unused)
 	/* child exited */
 }
 
-static int setup_injection(struct bench_data *data)
+static int setup_injection(struct bench_data *data, bool build_id_all)
 {
 	int ready_pipe[2];
 	int dev_null_fd;
@@ -247,6 +247,7 @@ static int setup_injection(struct bench_data *data)
 
 	if (data->pid == 0) {
 		const char **inject_argv;
+		int inject_argc = 2;
 
 		close(data->input_pipe[1]);
 		close(data->output_pipe[0]);
@@ -263,17 +264,22 @@ static int setup_injection(struct bench_data *data)
 
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
@@ -364,23 +370,17 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
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
 
-	collect_dso();
-	if (nr_dsos == 0) {
-		printf("  Cannot collect DSOs for injection\n");
-		return -1;
-	}
+	pr_debug("  Build-id%s injection benchmark\n", build_id_all ? "-all" : "");
 
 	for (i = 0; i < iterations; i++) {
 		struct timeval start, end, diff;
@@ -388,7 +388,7 @@ static int do_inject_loop(struct bench_data *data)
 
 		pr_debug("  Iteration #%d\n", i+1);
 
-		if (setup_injection(data) < 0) {
+		if (setup_injection(data, build_id_all) < 0) {
 			printf("  Build-id injection setup failed\n");
 			break;
 		}
@@ -408,8 +408,8 @@ static int do_inject_loop(struct bench_data *data)
 
 	time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
 	time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
-	printf("  Average build-id injection took: %.3f msec (+- %.3f msec)\n",
-		time_average, time_stddev);
+	printf("  Average build-id%s injection took: %.3f msec (+- %.3f msec)\n",
+	       build_id_all ? "-all" : "", time_average, time_stddev);
 
 	/* each iteration, it processes MMAP2 + BUILD_ID + nr_samples * SAMPLE */
 	time_average = avg_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
@@ -421,6 +421,22 @@ static int do_inject_loop(struct bench_data *data)
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
@@ -436,6 +452,6 @@ int bench_inject_build_id(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	return do_inject_loop(&data);
+	return do_inject_loops(&data);
 }
 
-- 
2.28.0.681.g6f77f65b4e-goog

