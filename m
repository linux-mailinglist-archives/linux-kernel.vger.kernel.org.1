Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC6723F5F9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 04:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgHHCjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 22:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:08 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F71CC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:08 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id o2so1670434qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djkMUkZcrMKQIRHk66rYevNXyQYjoTPBJqAUtrmCrFU=;
        b=MUwMipCiS3U+QJPXtfsbgCtqpFrdTwS7pey7j+iXKnaHtVF0SdQzOvfX3VstiI+9Lp
         YGJ5PSZawNpvNT7Ym8GmtO+Va4ChofXWWIlZ1YQd/ywqM39TBHw5JB1v8Z6xf3SQR8rC
         ruAXdaXrHljG5xVxGea/PR5cMlGpfs1jVrwn0DsFE312dzaWWRD7v10ysiZXFhESf4y7
         ofE9G+xFR/l3WkpgE+yw8neg3AAUXl1pmWkZo8tl3Yup18dRzioUlzl0xcy62r1MuVRp
         g5jtdS0y9Mmi8+ARrVixLmmcfFatHnF7I5U9EqMaIrgIqmtJ0FqO6Msm8fE3eR/9pS+o
         er9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djkMUkZcrMKQIRHk66rYevNXyQYjoTPBJqAUtrmCrFU=;
        b=Zl2Vi2qsOYMphHfUw2YTSfvz/Q7Wu2PFcD9Ugj9BkqgePdThr0FdyzsMPjUdZxGd+q
         HihY+Z6d7F8yb6fxjZLfZDfRIy5d1R72lzJvGMvkNyCp9CZCGtdHRTwxAc81C2l0vVWp
         efr19gG2UW1DqxpPv3TXb7liPo/TBEWezAzDgPQ6WSAs3c2pB16xgaGLyIobNgooB/Ez
         kgQgMlxelxN+1BrYrp5bCbYX0Dq4WA3wKHSGe3GySmqCyChYB+I1vWM4NEU/h5CLm5xH
         EuAAweBEfIejzebXjRADbOWUOCI2GTnELVrNRl8KY9ft66k7alKANbIXvCDhJilLOkTe
         CKOw==
X-Gm-Message-State: AOAM531R44uoReWI+uFUd5PEZaV7IcfRCwavRhEht9YD6E+HOE1PvpGa
        DbcT0xbm4KVgLpaF88gsnDI=
X-Google-Smtp-Source: ABdhPJwNFsTGZd+kpRo10/Y7ndY8eHfZPn6p6QQzwHZ09zQqUXNf4JnjPSJBqo6yzDJr1c8qMDFvjA==
X-Received: by 2002:a0c:fb11:: with SMTP id c17mr17008021qvp.113.1596854347051;
        Fri, 07 Aug 2020 19:39:07 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 07/18] perf: util: add general function to parse sublevel options
Date:   Sat,  8 Aug 2020 10:31:30 +0800
Message-Id: <20200808023141.14227-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This factors out a general function perf_parse_sublevel_options() to parse
sublevel options. The 'sublevel' options is something like the '--debug'
options which allow more sublevel options.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: add util/parse-sublevel-options.c
---
 tools/perf/util/Build                    |  1 +
 tools/perf/util/debug.c                  | 61 ++++++---------------
 tools/perf/util/parse-sublevel-options.c | 70 ++++++++++++++++++++++++
 tools/perf/util/parse-sublevel-options.h | 11 ++++
 4 files changed, 99 insertions(+), 44 deletions(-)
 create mode 100644 tools/perf/util/parse-sublevel-options.c
 create mode 100644 tools/perf/util/parse-sublevel-options.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8d18380ecd10..e86607ada0b5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -117,6 +117,7 @@ endif
 perf-y += parse-branch-options.o
 perf-y += dump-insn.o
 perf-y += parse-regs-options.o
+perf-y += parse-sublevel-options.o
 perf-y += term.o
 perf-y += help-unknown-cmd.o
 perf-y += mem-events.o
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index adb656745ecc..5cda5565777a 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -20,6 +20,7 @@
 #include "target.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
+#include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
 
@@ -173,65 +174,37 @@ void trace_event(union perf_event *event)
 		     trace_event_printer, event);
 }
 
-static struct debug_variable {
-	const char *name;
-	int *ptr;
-} debug_variables[] = {
-	{ .name = "verbose",		.ptr = &verbose },
-	{ .name = "ordered-events",	.ptr = &debug_ordered_events},
-	{ .name = "stderr",		.ptr = &redirect_to_stderr},
-	{ .name = "data-convert",	.ptr = &debug_data_convert },
-	{ .name = "perf-event-open",	.ptr = &debug_peo_args },
+static struct sublevel_option debug_opts[] = {
+	{ .name = "verbose",		.value_ptr = &verbose },
+	{ .name = "ordered-events",	.value_ptr = &debug_ordered_events},
+	{ .name = "stderr",		.value_ptr = &redirect_to_stderr},
+	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
+	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
 	{ .name = NULL, }
 };
 
 int perf_debug_option(const char *str)
 {
-	struct debug_variable *var = &debug_variables[0];
-	char *vstr, *s = strdup(str);
-	int v = 1;
-
-	vstr = strchr(s, '=');
-	if (vstr)
-		*vstr++ = 0;
-
-	while (var->name) {
-		if (!strcmp(s, var->name))
-			break;
-		var++;
-	}
-
-	if (!var->name) {
-		pr_err("Unknown debug variable name '%s'\n", s);
-		free(s);
-		return -1;
-	}
+	int ret;
 
-	if (vstr) {
-		v = atoi(vstr);
-		/*
-		 * Allow only values in range (0, 10),
-		 * otherwise set 0.
-		 */
-		v = (v < 0) || (v > 10) ? 0 : v;
-	}
+	ret = perf_parse_sublevel_options(str, debug_opts);
+	if (ret)
+		return ret;
 
-	if (quiet)
-		v = -1;
+	/* Allow only verbose value in range (0, 10), otherwise set 0. */
+	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
-	*var->ptr = v;
-	free(s);
 	return 0;
 }
 
 int perf_quiet_option(void)
 {
-	struct debug_variable *var = &debug_variables[0];
+	struct sublevel_option *opt = &debug_opts[0];
 
 	/* disable all debug messages */
-	while (var->name) {
-		*var->ptr = -1;
-		var++;
+	while (opt->name) {
+		*opt->value_ptr = -1;
+		opt++;
 	}
 
 	return 0;
diff --git a/tools/perf/util/parse-sublevel-options.c b/tools/perf/util/parse-sublevel-options.c
new file mode 100644
index 000000000000..a841d17ffd57
--- /dev/null
+++ b/tools/perf/util/parse-sublevel-options.c
@@ -0,0 +1,70 @@
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "util/debug.h"
+#include "util/parse-sublevel-options.h"
+
+static int parse_one_sublevel_option(const char *str,
+				     struct sublevel_option *opts)
+{
+	struct sublevel_option *opt = opts;
+	char *vstr, *s = strdup(str);
+	int v = 1;
+
+	if (!s) {
+		pr_err("no memory\n");
+		return -1;
+	}
+
+	vstr = strchr(s, '=');
+	if (vstr)
+		*vstr++ = 0;
+
+	while (opt->name) {
+		if (!strcmp(s, opt->name))
+			break;
+		opt++;
+	}
+
+	if (!opt->name) {
+		pr_err("Unknown option name '%s'\n", s);
+		free(s);
+		return -1;
+	}
+
+	if (vstr)
+		v = atoi(vstr);
+
+	*opt->value_ptr = v;
+	free(s);
+	return 0;
+}
+
+/* parse options like --foo a=<n>,b,c... */
+int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts)
+{
+	char *s = strdup(str);
+	char *p = NULL;
+	int ret;
+
+	if (!s) {
+		pr_err("no memory\n");
+		return -1;
+	}
+
+	p = strtok(s, ",");
+	while (p) {
+		ret = parse_one_sublevel_option(p, opts);
+		if (ret) {
+			free(s);
+			return ret;
+		}
+
+		p = strtok(NULL, ",");
+	}
+
+	free(s);
+	return 0;
+}
diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
new file mode 100644
index 000000000000..9b9efcc2aaad
--- /dev/null
+++ b/tools/perf/util/parse-sublevel-options.h
@@ -0,0 +1,11 @@
+#ifndef _PERF_PARSE_SUBLEVEL_OPTIONS_H
+#define _PERF_PARSE_SUBLEVEL_OPTIONS_H
+
+struct sublevel_option {
+	const char *name;
+	int *value_ptr;
+};
+
+int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
+
+#endif
\ No newline at end of file
-- 
2.25.1

