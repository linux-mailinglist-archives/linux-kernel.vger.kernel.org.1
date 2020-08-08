Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127A423F5F4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 04:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgHHCcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 22:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHHCcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:32:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7FC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:32:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so3504171qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YkO1yOs0y/LtnwCCdbUNLkSPyffbolLaUapYHAhXcg=;
        b=mJHeOsrf8WYgFY1A2ppukZ+TWkyWmdwpQ17xkcVxCTJA4aufdCCIeiHkBlzF2ZLySj
         yhkGMFmRODjhJeEs2E05o3YT2dM7LgcLBL1WRAVBERGOdH3r7YUDsCUvTIiHcbUOrN5w
         d1Mch8q8e6aGsmk84CmTtzMn1JWba8zT1XEnp98HMid/z+gnPeKwjfNUKbCb9tXumRKt
         jo3RL96fKoJjMmKukJOxO0cx1beqA7lL8+/hFy/R0fztGoP81qjwcw1Y/QjHzZiDwmve
         HPHSWIBOpxnrCdqe1hTft4/o5Bunep1P470qipSW/3pm3qz0//AfulyQpTCGKrMoFlJN
         ip1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YkO1yOs0y/LtnwCCdbUNLkSPyffbolLaUapYHAhXcg=;
        b=pWB3rIrtMpIPfe4ef6h5g0iKBliHhOqWoG6JoAtrMmSLcRYcQ/y0QCuoOm4IP/3JxJ
         wRL/VSBs8WuHDAd7ebqGQ+h+QoBPjosLSpoK1d07d0qfRAlIx88uc0QK2QKAHQIU9ooh
         dynoeX7wRgo1kzYc09UDSpnYuDL2IZasVhkgh4c5f/mEAQFc+9awlVVwaUCJhDOGKi2+
         3Mnw/bsNx4Ix99CVmn8cSyb08Qu329mWDgZ6NbC0Oa3A8zV8rsku/xXFNzlxkIgw3pVn
         eQBN6F93b7kIsCYO6F/l36caI4eeAyplAQV+eADUG0rWMVyKzy8LGGOgGCVDoy2YPfaO
         dJ8A==
X-Gm-Message-State: AOAM531xBwdzGqdZbVqNBsGkSqT7mnOxu4Z+VQs0zyJjaYt+k2wCbMRW
        j/0ZOxmL8869D0u2dHprjZQ=
X-Google-Smtp-Source: ABdhPJycLko7zkuGedPjAXQjfONic6l2G0T72MF/aHSszPGSnvw6IqTuy/F4diGu1TNrmu8qz4l68Q==
X-Received: by 2002:a37:4f07:: with SMTP id d7mr17466693qkb.144.1596853927360;
        Fri, 07 Aug 2020 19:32:07 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:32:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 02/18] perf ftrace: add option '-F/--funcs' to list available functions
Date:   Sat,  8 Aug 2020 10:31:25 +0800
Message-Id: <20200808023141.14227-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-F/--funcs' to list all available functions to trace,
which is read from tracing file 'available_filter_functions'.

$ sudo ./perf ftrace -F | head
trace_initcall_finish_cb
initcall_blacklisted
do_one_initcall
do_one_initcall
trace_initcall_start_cb
run_init_process
try_to_run_init_process
match_dev_by_label
match_dev_by_uuid
rootfs_init_fs_context

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: fix return value issue.
v2: option name '-l/--list-functions' -> '-F/--funcs'
---
 tools/perf/Documentation/perf-ftrace.txt |  4 +++
 tools/perf/builtin-ftrace.c              | 46 ++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 821d4d334a09..4f5628445a63 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -31,6 +31,10 @@ OPTIONS
 --verbose=::
         Verbosity level.
 
+-F::
+--funcs::
+        List all available functions to trace.
+
 -p::
 --pid=::
 	Trace on existing process id (comma separated list).
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 048a11192b59..1ebf71ecc1a8 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -33,6 +33,7 @@ struct perf_ftrace {
 	struct evlist		*evlist;
 	struct target		target;
 	const char		*tracer;
+	bool			list_avail_functions;
 	struct list_head	filters;
 	struct list_head	notrace;
 	struct list_head	graph_funcs;
@@ -128,6 +129,46 @@ static int append_tracing_file(const char *name, const char *val)
 	return __write_tracing_file(name, val, true);
 }
 
+static int read_tracing_file_to_stdout(const char *name)
+{
+	char buf[4096];
+	char *file;
+	int fd;
+	int ret = -1;
+
+	file = get_tracing_file(name);
+	if (!file) {
+		pr_debug("cannot get tracing file: %s\n", name);
+		return -1;
+	}
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		pr_debug("cannot open tracing file: %s: %s\n",
+			 name, str_error_r(errno, buf, sizeof(buf)));
+		goto out;
+	}
+
+	/* read contents to stdout */
+	while (true) {
+		int n = read(fd, buf, sizeof(buf));
+		if (n == 0)
+			break;
+		else if (n < 0)
+			goto out_close;
+
+		if (fwrite(buf, n, 1, stdout) != 1)
+			goto out_close;
+	}
+	ret = 0;
+
+out_close:
+	close(fd);
+out:
+	put_tracing_file(file);
+	return ret;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -302,6 +343,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
+	if (ftrace->list_avail_functions)
+		return read_tracing_file_to_stdout("available_filter_functions");
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
 		goto out;
@@ -487,6 +531,8 @@ int cmd_ftrace(int argc, const char **argv)
 	const struct option ftrace_options[] = {
 	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
 		   "tracer to use: function_graph(default) or function"),
+	OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
+		    "Show available functions to filter"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.25.1

