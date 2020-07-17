Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F000223E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgGQOiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGQOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:38:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D9DC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so5523223plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9i+/+jWHzL4Xcjz4Ie7ZuxiFCfxMRdDSo/Gp7wHU4Uw=;
        b=e6zjRZq2dbDynVXLfMUA+dlBBXalb615wkpdJ4MNtADhMNjDt//jwZL5o06gce2WEC
         BMwRTPcHnDFc96i+Zagn9GsUmlVGsc2t+f/m8NU6gWg+0wiXRRuk7+Y2NppWiodY+ks8
         xRJ2KE5N610eBX6/3Q++RqqC1MeX72fBDbcE8tj8UXUSxIFmm+YH4Zy5QIERtBA8EhXK
         CdWHkQtGlw3Yu5+mkYNGBktSmdTcagEYnm3TSh/7r4qGArvD6sj56ks2gR9O+pAcNKpf
         JJY5xwYSRwh6KwHHoLE0+/6p0NjSOc/YFFQv+lVLUYN/MxNMicSM97Vh6WBmpMPm2CHT
         RvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9i+/+jWHzL4Xcjz4Ie7ZuxiFCfxMRdDSo/Gp7wHU4Uw=;
        b=QCGqnO51Jj2LyYKJutHUkQD1y893gM6PMpPEm5L1H013Nl25pDP6Xtup4kyklF7QWh
         ggWKjM367OSyGsC74t4lkhwZY0sKDOE1Y0C5imKuqwnGgRtBJWai6FvTzpJcUhqwuIZq
         9+WqBPPTCjB63RGVGPyi2rlP/ggmxO8pUi+OTanGp4HFEBNwONbRywyyFeh1DvVwnTQY
         07BeRh57ex5QdVe2sThepCsTAotlLnC7eGSDyA8t+2G5LcmgpNxfKzuugjMR3di/vwh7
         gZAI0P7tQkYrncLNrvKHA3CDXJMTsw3xZ80UTYNhKelQtpJtKmaJ3lex6l/YXRKDLTBj
         37VA==
X-Gm-Message-State: AOAM531OwpqsuY3r/wearh2RafCJMPoEyDuAY6srfyy26mz4pHmd0SG+
        y5bSqs2WEHY+h4/Z+vQmWhBkafmIk6E=
X-Google-Smtp-Source: ABdhPJybX4boj+ULupUcN7Sye/rxQwflrAr3jY8aS1sixhPXtlwfzEwNcU+0d6M7WCfh5Va9YCev6g==
X-Received: by 2002:a17:902:d698:: with SMTP id v24mr7797651ply.163.1594996732711;
        Fri, 17 Jul 2020 07:38:52 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:38:52 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 16/17] perf: ftrace: Add set_tracing_options() to set all trace options
Date:   Fri, 17 Jul 2020 22:36:27 +0800
Message-Id: <20200717143628.47721-17-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the __cmd_ftrace() becomes a bit long. This moves the trace
option setting code to a separate function set_tracing_options().

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 118 +++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 64b68331048a..edf307f7d716 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -463,110 +463,118 @@ static int set_tracing_thresh(struct perf_ftrace *ftrace)
 	return 0;
 }
 
-static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
+static int set_tracing_options(struct perf_ftrace *ftrace)
 {
-	char *trace_file;
-	int trace_fd;
-	char buf[4096];
-	struct pollfd pollfd = {
-		.events = POLLIN,
-	};
-
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
-
-	signal(SIGINT, sig_handler);
-	signal(SIGUSR1, sig_handler);
-	signal(SIGCHLD, sig_handler);
-	signal(SIGPIPE, sig_handler);
-
-	if (ftrace->list_avail_functions)
-		return read_tracing_file_to_stdout("available_filter_functions");
-
-	if (reset_tracing_files(ftrace) < 0) {
-		pr_err("failed to reset ftrace\n");
-		goto out;
-	}
-
-	/* reset ftrace buffer */
-	if (write_tracing_file("trace", "0") < 0)
-		goto out;
-
-	if (argc && perf_evlist__prepare_workload(ftrace->evlist,
-				&ftrace->target, argv, false,
-				ftrace__workload_exec_failed_signal) < 0) {
-		goto out;
-	}
-
 	if (set_tracing_pid(ftrace) < 0) {
 		pr_err("failed to set ftrace pid\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_cpu(ftrace) < 0) {
 		pr_err("failed to set tracing cpumask\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_func_stack_trace(ftrace) < 0) {
 		pr_err("failed to set tracing option func_stack_trace\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_func_irqinfo(ftrace) < 0) {
 		pr_err("failed to set tracing option irq-info\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_filters(ftrace) < 0) {
 		pr_err("failed to set tracing filters\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_depth(ftrace) < 0) {
 		pr_err("failed to set graph depth\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_percpu_buffer_size(ftrace) < 0) {
 		pr_err("failed to set tracing per-cpu buffer size\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_trace_inherit(ftrace) < 0) {
 		pr_err("failed to set tracing option function-fork\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_sleep_time(ftrace) < 0) {
 		pr_err("failed to set tracing option sleep-time\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_funcgraph_irqs(ftrace) < 0) {
 		pr_err("failed to set tracing option funcgraph-irqs\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_funcgraph_verbose(ftrace) < 0) {
 		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_thresh(ftrace) < 0) {
 		pr_err("failed to set tracing thresh\n");
-		goto out_reset;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
+{
+	char *trace_file;
+	int trace_fd;
+	char buf[4096];
+	struct pollfd pollfd = {
+		.events = POLLIN,
+	};
+
+	if (!(perf_cap__capable(CAP_PERFMON) ||
+	      perf_cap__capable(CAP_SYS_ADMIN))) {
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
+		return -1;
 	}
 
+	signal(SIGINT, sig_handler);
+	signal(SIGUSR1, sig_handler);
+	signal(SIGCHLD, sig_handler);
+	signal(SIGPIPE, sig_handler);
+
+	if (ftrace->list_avail_functions)
+		return read_tracing_file_to_stdout("available_filter_functions");
+
+	if (reset_tracing_files(ftrace) < 0) {
+		pr_err("failed to reset ftrace\n");
+		goto out;
+	}
+
+	/* reset ftrace buffer */
+	if (write_tracing_file("trace", "0") < 0)
+		goto out;
+
+	if (argc && perf_evlist__prepare_workload(ftrace->evlist,
+				&ftrace->target, argv, false,
+				ftrace__workload_exec_failed_signal) < 0) {
+		goto out;
+	}
+
+	if (set_tracing_options(ftrace) < 0)
+		goto out_reset;
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
-- 
2.25.1

