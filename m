Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2629504C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444311AbgJUP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:59:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:24616 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444304AbgJUP7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:59:54 -0400
IronPort-SDR: uo8+WMwuixrIsLIZrlpLOJJvNQS1FJUE4tvTQHkdBZ6D7BnMFqHzpFGLvbVeVXijPkbCjQeKxe
 Kv521PY2XJZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167481440"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="167481440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 08:59:52 -0700
IronPort-SDR: 8zm29fNV2KYGDDlDOG2Wg8VQpGPbSN/bBPQI4ROGbYvymv9sJ6egvAP0tlp4TaUW13e58xnCTF
 WVnQj/C/HZyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="302056697"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2020 08:59:52 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 043BC580720;
        Wed, 21 Oct 2020 08:59:49 -0700 (PDT)
Subject: [PATCH v2 04/15] perf session: move reader object definition to
 header file
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <635d39aa-5ce8-2c0b-9b12-952b95ed22da@linux.intel.com>
Date:   Wed, 21 Oct 2020 18:59:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
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

