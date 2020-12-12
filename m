Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926B92D85F9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407385AbgLLKpG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:45:06 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:38009 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407360AbgLLKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:04 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-MUyigM7iPySexfQ1G61Stw-1; Sat, 12 Dec 2020 05:44:09 -0500
X-MC-Unique: MUyigM7iPySexfQ1G61Stw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6C7F800D55;
        Sat, 12 Dec 2020 10:44:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9689B60CCE;
        Sat, 12 Dec 2020 10:44:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 1/8] perf tools: Add debug_set_file function
Date:   Sat, 12 Dec 2020 11:43:51 +0100
Message-Id: <20201212104358.412065-2-jolsa@kernel.org>
In-Reply-To: <20201212104358.412065-1-jolsa@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to set debug output file via new debug_set_file function.

It's called during perf startup in perf_debug_setup to set stderr
file as default and any perf command can set it later to different
file.

It will be used in perf daemon command to get verbose output into
log file.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/debug.c | 9 ++++++++-
 tools/perf/util/debug.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 5cda5565777a..50fd6a4be4e0 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -30,6 +30,12 @@ bool dump_trace = false, quiet = false;
 int debug_ordered_events;
 static int redirect_to_stderr;
 int debug_data_convert;
+static FILE *debug_file;
+
+void debug_set_file(FILE *file)
+{
+	debug_file = file;
+}
 
 int veprintf(int level, int var, const char *fmt, va_list args)
 {
@@ -39,7 +45,7 @@ int veprintf(int level, int var, const char *fmt, va_list args)
 		if (use_browser >= 1 && !redirect_to_stderr)
 			ui_helpline__vshow(fmt, args);
 		else
-			ret = vfprintf(stderr, fmt, args);
+			ret = vfprintf(debug_file, fmt, args);
 	}
 
 	return ret;
@@ -227,6 +233,7 @@ DEBUG_WRAPPER(debug, 1);
 
 void perf_debug_setup(void)
 {
+	debug_set_file(stderr);
 	libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_debug_wrapper);
 }
 
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index f1734abd98dd..43f712295645 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -5,6 +5,7 @@
 
 #include <stdarg.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include <linux/compiler.h>
 
 extern int verbose;
@@ -62,6 +63,7 @@ int eprintf_time(int level, int var, u64 t, const char *fmt, ...) __printf(4, 5)
 int veprintf(int level, int var, const char *fmt, va_list args);
 
 int perf_debug_option(const char *str);
+void debug_set_file(FILE *file);
 void perf_debug_setup(void);
 int perf_quiet_option(void);
 
-- 
2.26.2

