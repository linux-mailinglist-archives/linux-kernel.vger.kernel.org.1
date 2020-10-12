Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5128B0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgJLI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:56:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:44686 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLI4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:56:11 -0400
IronPort-SDR: YyPrrxHRICcDtJAYnulU9oq5TLv+pzYdd81rTlcnSmjtI9y1clBVR5JvZ96F1BD7AWMUHbssxu
 Yb9io1hdBMaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="183165446"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="183165446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:56:11 -0700
IronPort-SDR: HdCJJ3Yh/o7M09Ukqrkjsg4Gf90hj3WLFLBNtWDs6u5fEY/1z3Rsf2mWbQiaXu+20NVER2+L6H
 z7Z1anhPednA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="529876817"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2020 01:56:10 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id 790B15805EC;
        Mon, 12 Oct 2020 01:56:08 -0700 (PDT)
Subject: [PATCH v1 04/15] perf session: move reader object definition to
 header file
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <19ec2135-d2df-f263-ade8-699f1e06ad71@linux.intel.com>
Date:   Mon, 12 Oct 2020 11:56:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Move definition of reader to session header file to be shared
among different source files. Introduce reference to active
reader object from session object.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/session.c | 27 ---------------------------
 tools/perf/util/session.h | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6f09d506b2f6..911b2dbcd0ac 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2110,33 +2110,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	return 0;
 }
 
-/*
- * On 64bit we can mmap the data file in one go. No need for tiny mmap
- * slices. On 32bit we use 32MB.
- */
-#if BITS_PER_LONG == 64
-#define MMAP_SIZE ULLONG_MAX
-#define NUM_MMAPS 1
-#else
-#define MMAP_SIZE (32 * 1024 * 1024ULL)
-#define NUM_MMAPS 128
-#endif
-
-struct reader;
-
-typedef s64 (*reader_cb_t)(struct perf_session *session,
-			   union perf_event *event,
-			   u64 file_offset,
-			   const char *file_path);
-
-struct reader {
-	int		 fd;
-	const char	 *path;
-	u64		 data_size;
-	u64		 data_offset;
-	reader_cb_t	 process;
-};
-
 static int
 reader__process_events(struct reader *rd, struct perf_session *session,
 		       struct ui_progress *prog)
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 378ffc3e2809..abdb8518a81f 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -20,6 +20,30 @@ struct thread;
 struct auxtrace;
 struct itrace_synth_opts;
 
+/*
+ * On 64bit we can mmap the data file in one go. No need for tiny mmap
+ * slices. On 32bit we use 32MB.
+ */
+#if BITS_PER_LONG == 64
+#define MMAP_SIZE ULLONG_MAX
+#define NUM_MMAPS 1
+#else
+#define MMAP_SIZE (32 * 1024 * 1024ULL)
+#define NUM_MMAPS 128
+#endif
+
+typedef s64 (*reader_cb_t)(struct perf_session *session,
+			   union perf_event *event,
+			   u64 file_offset, const char *file_path);
+
+struct reader {
+	int		 fd;
+	const char	 *path;
+	u64		 data_size;
+	u64		 data_offset;
+	reader_cb_t	 process;
+};
+
 struct perf_session {
 	struct perf_header	header;
 	struct machines		machines;
@@ -41,6 +65,7 @@ struct perf_session {
 	struct zstd_data	zstd_data;
 	struct decomp		*decomp;
 	struct decomp		*decomp_last;
+	struct reader		*reader;
 };
 
 struct decomp {
-- 
2.24.1


