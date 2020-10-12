Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9642128B0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgJLI7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:59:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:1612 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgJLI7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:59:03 -0400
IronPort-SDR: jKAmXEmt0nxlQmd4OwqR/aHK71ZPzN7KLM9ODtNuBz8inIJalPkwlCRXGNAjkxtUhjz4e8A0iG
 LD61JfFMA/WA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145574487"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="145574487"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:59:02 -0700
IronPort-SDR: +np3smSNdJnd9lhvZAg3Ct1dmzFeLiq/YPlKBcL0RMrkgT8qRAQ05oyGVbrT1elCDzIfq60Hyz
 MQMfB6tQfIXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="389895279"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 12 Oct 2020 01:59:02 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id E61E5580814;
        Mon, 12 Oct 2020 01:58:59 -0700 (PDT)
Subject: [PATCH v1 06/15] perf session: load data directory into tool process
 memory
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
Message-ID: <39cf6164-f3be-ae34-292a-94faef32fdb9@linux.intel.com>
Date:   Mon, 12 Oct 2020 11:58:58 +0300
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


Read trace files located at data directory into tool process memory.
Basic analysis support of data directories is provided for report
mode. Raw dump (-D) and aggregated reports are available for data
directories, still with no memory consumption optimizations. However
data directories collected with --compression-level option enabled
can be analyzed with little less memory because trace files are
unmaped from tool process memory after loading collected data.
The implementation is based on the prototype [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/session.c | 48 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/session.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6afc670fdf0c..0752eec19813 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		goto more;
 
 out:
+	if (rd->unmap_file) {
+		int i;
+
+		for (i = 0; i < NUM_MMAPS; i++) {
+			if (mmaps[i]) {
+				munmap(mmaps[i], mmap_size);
+				mmaps[i] = NULL;
+			}
+		}
+	}
+
 	return err;
 }
 
@@ -2231,6 +2242,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
 		.path		= session->data->file.path,
+		.unmap_file	= false,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
@@ -2247,6 +2259,42 @@ static int __perf_session__process_events(struct perf_session *session)
 	err = reader__process_events(&rd, session, &prog);
 	if (err)
 		goto out_err;
+
+	if (perf_data__is_dir(session->data)) {
+		int i, nr = session->data->dir.nr;
+		struct reader file_rd[nr];
+		u64 total_size = perf_data__size(session->data);
+
+		total_size -= session->data->file.size;
+		ui_progress__init_size(&prog, total_size, "Sorting events...");
+
+		memset(&file_rd, 0, nr * sizeof(file_rd[0]));
+
+		for (i = 0; i < nr ; i++) {
+			struct perf_data_file *file;
+
+			file = &session->data->dir.files[i];
+			file_rd[i] = (struct reader) {
+				.fd             = file->fd,
+				.path           = file->path,
+				.data_size      = file->size,
+				.data_offset    = 0,
+				.process	= process_simple,
+			};
+			file_rd[i].unmap_file = perf_header__has_feat(&session->header,
+								      HEADER_COMPRESSED);
+			session->reader = &file_rd[i];
+
+			if (zstd_init(&(file_rd[i].zstd_data), 0))
+				goto out_err;
+			err = reader__process_events(&file_rd[i], session, &prog);
+			zstd_fini(&(file_rd[i].zstd_data));
+			session->reader = NULL;
+			if (err)
+				goto out_err;
+		}
+	}
+
 	/* do the final flush for ordered samples */
 	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
 	if (err)
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 4fc9ccdf7970..d428f3eaf7fd 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -43,6 +43,7 @@ struct reader {
 	u64		 data_offset;
 	reader_cb_t	 process;
 	struct zstd_data zstd_data;
+	bool		 unmap_file;
 };
 
 struct perf_session {
-- 
2.24.1


