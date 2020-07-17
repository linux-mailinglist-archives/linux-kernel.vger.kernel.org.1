Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1693E223E11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGQOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgGQOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:32:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C48C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:32:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l6so5510347plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GvevElFJ4U4yRnRWYa1+v1t10H7nq52DoERX/gTSI0=;
        b=Lgeip9hghppaA6iVI7wZVa/TBeo14rd/5J0d9H/vAkUaGQ4Do4n+RXcT9ycXCV4lwl
         xjAFZNHbtyrqugE+7vYb1LwSM8Qs9rcNQrwpp4gFeTMTkfv7y7dZ6H5hh6AHOUr+P9sW
         fnwFuTJmANuuUoZC5KoiaRYyxtiRln+pjND+hlg3vDYkt7lKokPmVwGGZDHDHzvLP0bK
         vHA6DROqXRAsG/b4vh3tYMmmP+eEoWl1mTzzzy+d1z5OziSJRj/uSPWZXJ965378G0Q0
         cBsSAZ21yMcFUOyqAQrwBjF8rg+pn6fUzBPMhAYrNu83Flwk5QTnkWFcOnOLKftCebhg
         KwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GvevElFJ4U4yRnRWYa1+v1t10H7nq52DoERX/gTSI0=;
        b=t4FsbMwZfEyfUOBqljetW747md5wYQi4KNXoaMXbN2PBftjlIj37XtXL5Q5SZNau/6
         SWXm1rx08NsrbtgPr921djBg9H9SJ3Wg4kAOxavSHyTMvPmS2viEJOQ/qeIQ0QpuZ9c2
         h8nl23mmkY/o8PCMAkx748paQbaOA/Q5INRDsOhLp3t39Q60WjXmswjvGddkD9F+nbUz
         v1Zjqe/Fv4RGr5EI8KOFSzjOgZESW5F78DbXOb7gD6QZSSJ6TIiLkD1bY2RMxRzsbawy
         +FyuPArfVd0DHrLVPHTHXzxxy20xCdN0TuzZX9rZ55JlDUsZmJ7d2r1N0sYMjVQgYXX/
         /3iw==
X-Gm-Message-State: AOAM530QMUAwa66Pb5Bgpte8MbRa9PndFwsQ3rL8a1pt2YrLnlrQy8GM
        57WqUSk2+16DWc+eMA2DWvc=
X-Google-Smtp-Source: ABdhPJxT3xatBa08XtGlq5UX6Ds3lEPuVUDvxgnEIHU0goMUU4qFxz7P5Lm6sylgWsLYPloJgdmqbQ==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr10641089pju.19.1594996378246;
        Fri, 17 Jul 2020 07:32:58 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id f29sm8052506pga.59.2020.07.17.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:32:57 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 01/17] perf ftrace: select function/function_graph tracer automatically
Date:   Fri, 17 Jul 2020 22:32:13 +0800
Message-Id: <20200717143229.47546-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143229.47546-1-changbin.du@gmail.com>
References: <20200717143229.47546-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '-g/-G' options have already implied function_graph tracer should be
used instead of function tracer. So the extra option '--tracer' can be
killed.

This patch changes the behavior as below:
  - By default, function tracer is used.
  - If '-g' or '-G' option is on, then function_graph tracer is used.
  - The perf configuration item 'ftrace.tracer' is marked as deprecated.
  - The option '--tracer' is marked as deprecated.

Here are some examples.

This will start tracing all functions using function tracer:
  $ sudo perf ftrace

This will trace all functions using function graph tracer:
  $ sudo perf ftrace -G '*'

This will trace function vfs_read using function graph tracer:
  $ sudo perf ftrace -G vfs_read

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: remove default '*' for -G/-T.
---
 tools/perf/Documentation/perf-config.txt |  5 -----
 tools/perf/Documentation/perf-ftrace.txt |  2 +-
 tools/perf/builtin-ftrace.c              | 15 ++++++++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c7d3df5798e2..a25fee7de3b2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -612,11 +612,6 @@ trace.*::
 		"libbeauty", the default, to use the same argument beautifiers used in the
 		strace-like sys_enter+sys_exit lines.
 
-ftrace.*::
-	ftrace.tracer::
-		Can be used to select the default tracer. Possible values are
-		'function' and 'function_graph'.
-
 llvm.*::
 	llvm.clang-path::
 		Path to clang. If omit, search it from $PATH.
diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index b80c84307dc9..952e46669168 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -24,7 +24,7 @@ OPTIONS
 
 -t::
 --tracer=::
-	Tracer to use: function_graph or function.
+	Tracer to use: function_graph or function. This option is deprecated.
 
 -v::
 --verbose=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 2bfc1b0db536..5f53da87040d 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -27,7 +27,6 @@
 #include "util/cap.h"
 #include "util/config.h"
 
-#define DEFAULT_TRACER  "function_graph"
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -419,6 +418,7 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
 	if (strcmp(var, "ftrace.tracer"))
 		return -1;
 
+	pr_warning("Configuration ftrace.tracer is deprecated\n");
 	if (!strcmp(value, "function_graph") ||
 	    !strcmp(value, "function")) {
 		ftrace->tracer = value;
@@ -459,7 +459,7 @@ int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
 	struct perf_ftrace ftrace = {
-		.tracer = DEFAULT_TRACER,
+		.tracer = "function",
 		.target = { .uid = UINT_MAX, },
 	};
 	const char * const ftrace_usage[] = {
@@ -469,7 +469,7 @@ int cmd_ftrace(int argc, const char **argv)
 	};
 	const struct option ftrace_options[] = {
 	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
-		   "tracer to use: function_graph(default) or function"),
+		   "tracer to use: function or function_graph (This option is deprecated)"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
 	OPT_INCR('v', "verbose", &verbose,
@@ -479,11 +479,13 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
 		    "list of cpus to monitor"),
 	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
-		     "trace given functions only", parse_filter_func),
+		     "trace given functions using function tracer",
+		     parse_filter_func),
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
 	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
-		     "Set graph filter on given functions", parse_filter_func),
+		     "trace given functions using function_graph tracer",
+		     parse_filter_func),
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
@@ -505,6 +507,9 @@ int cmd_ftrace(int argc, const char **argv)
 	if (!argc && target__none(&ftrace.target))
 		ftrace.target.system_wide = true;
 
+	if (!list_empty(&ftrace.graph_funcs) || !list_empty(&ftrace.nograph_funcs))
+		ftrace.tracer = "function_graph";
+
 	ret = target__validate(&ftrace.target);
 	if (ret) {
 		char errbuf[512];
-- 
2.25.1

