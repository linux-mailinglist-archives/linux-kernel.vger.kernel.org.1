Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626562D85FA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438684AbgLLKpp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:45:45 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:57803 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407387AbgLLKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:11 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-SdKfkgReOQ2d_GF2LQ-0LQ-1; Sat, 12 Dec 2020 05:44:13 -0500
X-MC-Unique: SdKfkgReOQ2d_GF2LQ-0LQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65BEA10054FF;
        Sat, 12 Dec 2020 10:44:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 544FC7086C;
        Sat, 12 Dec 2020 10:44:08 +0000 (UTC)
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
Subject: [PATCH 2/8] perf tools: Add debug_set_display_time function
Date:   Sat, 12 Dec 2020 11:43:52 +0100
Message-Id: <20201212104358.412065-3-jolsa@kernel.org>
In-Reply-To: <20201212104358.412065-1-jolsa@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to display time in perf debug output via new
debug_set_display_time function.

It will be used in perf daemon command to get verbose
output into log file.

The debug time format is:

  [2020-12-03 18:25:31.822152] affinity: SYS
  [2020-12-03 18:25:31.822164] mmap flush: 1
  [2020-12-03 18:25:31.822175] comp level: 0
  [2020-12-03 18:25:32.002047] mmap size 528384B

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/debug.c | 34 +++++++++++++++++++++++++++++++---
 tools/perf/util/debug.h |  1 +
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 50fd6a4be4e0..dc148b08814b 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -10,6 +10,7 @@
 #include <api/debug.h>
 #include <linux/kernel.h>
 #include <linux/time64.h>
+#include <sys/time.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #endif
@@ -31,21 +32,48 @@ int debug_ordered_events;
 static int redirect_to_stderr;
 int debug_data_convert;
 static FILE *debug_file;
+bool debug_display_time;
 
 void debug_set_file(FILE *file)
 {
 	debug_file = file;
 }
 
+void debug_set_display_time(bool set)
+{
+	debug_display_time = set;
+}
+
+static int fprintf_time(FILE *file)
+{
+	struct timeval tod;
+	struct tm ltime;
+	char date[64];
+
+	if (!debug_display_time)
+		return 0;
+
+	if (gettimeofday(&tod, NULL) != 0)
+		return 0;
+
+	if (localtime_r(&tod.tv_sec, &ltime) == NULL)
+		return 0;
+
+	strftime(date, sizeof(date),  "%F %H:%M:%S", &ltime);
+	return fprintf(file, "[%s.%06lu] ", date, tod.tv_usec);
+}
+
 int veprintf(int level, int var, const char *fmt, va_list args)
 {
 	int ret = 0;
 
 	if (var >= level) {
-		if (use_browser >= 1 && !redirect_to_stderr)
+		if (use_browser >= 1 && !redirect_to_stderr) {
 			ui_helpline__vshow(fmt, args);
-		else
-			ret = vfprintf(debug_file, fmt, args);
+		} else {
+			ret = fprintf_time(debug_file);
+			ret += vfprintf(debug_file, fmt, args);
+		}
 	}
 
 	return ret;
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 43f712295645..48f631966067 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -64,6 +64,7 @@ int veprintf(int level, int var, const char *fmt, va_list args);
 
 int perf_debug_option(const char *str);
 void debug_set_file(FILE *file);
+void debug_set_display_time(bool set);
 void perf_debug_setup(void);
 int perf_quiet_option(void);
 
-- 
2.26.2

