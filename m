Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406A42B43A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgKPMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:25:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:35075 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgKPMZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:25:24 -0500
IronPort-SDR: c+d/SKQOa+WZ1Svgea/YkxbH1VK6V/ChGabNn7pSeatS3Y6tvzwnTDbm2qZqHTh7A3tx2Y12uD
 9HIC9/7k5BEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="150586110"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="150586110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:25:24 -0800
IronPort-SDR: OqdaRrfsKl4PZgQSbASYNdwf0TkWIR52WMO2uUJ6IvHTTvBCB13WDXxLRJtL/EhnoODWy3Svd7
 ZmbyCYJPIUBA==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="543585116"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.228.209]) ([10.249.228.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:25:20 -0800
Subject: [PATCH v3 12/12] perf session: use reader functions to load perf data
 file
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d3f3ab63-7841-97c5-76a0-87d1a763566d@linux.intel.com>
Date:   Mon, 16 Nov 2020 15:25:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Use the reader functions to load data file similar to loading of
data directory files.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/session.c | 215 ++++++++++++--------------------------
 1 file changed, 66 insertions(+), 149 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3cb30c1667c0..f6b06187c6f5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2194,109 +2194,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	return 0;
 }
 
-static int
-reader__process_events(struct reader *rd, struct perf_session *session,
-		       struct ui_progress *prog)
-{
-	u64 data_size = rd->data_size;
-	u64 head, page_offset, file_offset, file_pos, size;
-	int err = 0, mmap_prot, mmap_flags, map_idx = 0;
-	size_t	mmap_size;
-	char *buf, *mmaps[NUM_MMAPS];
-	union perf_event *event;
-	s64 skip;
-
-	page_offset = page_size * (rd->data_offset / page_size);
-	file_offset = page_offset;
-	head = rd->data_offset - page_offset;
-
-	ui_progress__init_size(prog, data_size, "Processing events...");
-
-	data_size += rd->data_offset;
-
-	mmap_size = MMAP_SIZE;
-	if (mmap_size > data_size) {
-		mmap_size = data_size;
-		session->one_mmap = true;
-	}
-
-	memset(mmaps, 0, sizeof(mmaps));
-
-	mmap_prot  = PROT_READ;
-	mmap_flags = MAP_SHARED;
-
-	if (session->header.needs_swap) {
-		mmap_prot  |= PROT_WRITE;
-		mmap_flags = MAP_PRIVATE;
-	}
-remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd->fd,
-		   file_offset);
-	if (buf == MAP_FAILED) {
-		pr_err("failed to mmap file\n");
-		err = -errno;
-		goto out;
-	}
-	mmaps[map_idx] = buf;
-	map_idx = (map_idx + 1) & (ARRAY_SIZE(mmaps) - 1);
-	file_pos = file_offset + head;
-	if (session->one_mmap) {
-		session->one_mmap_addr = buf;
-		session->one_mmap_offset = file_offset;
-	}
-
-more:
-	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
-	if (IS_ERR(event))
-		return PTR_ERR(event);
-
-	if (!event) {
-		if (mmaps[map_idx]) {
-			munmap(mmaps[map_idx], mmap_size);
-			mmaps[map_idx] = NULL;
-		}
-
-		page_offset = page_size * (head / page_size);
-		file_offset += page_offset;
-		head -= page_offset;
-		goto remap;
-	}
-
-	size = event->header.size;
-
-	skip = -EINVAL;
-
-	if (size < sizeof(struct perf_event_header) ||
-	    (skip = rd->process(session, event, file_pos, rd->path)) < 0) {
-		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
-		       file_offset + head, rd->path, event->header.size,
-		       event->header.type, strerror(-skip));
-		err = skip;
-		goto out;
-	}
-
-	if (skip)
-		size += skip;
-
-	head += size;
-	file_pos += size;
-
-	err = __perf_session__process_decomp_events(session);
-	if (err)
-		goto out;
-
-	ui_progress__update(prog, size);
-
-	if (session_done())
-		goto out;
-
-	if (file_pos < data_size)
-		goto more;
-
-out:
-	return err;
-}
-
 static s64 process_simple(struct perf_session *session,
 			  union perf_event *event,
 			  u64 file_offset,
@@ -2305,52 +2202,6 @@ static s64 process_simple(struct perf_session *session,
 	return perf_session__process_event(session, event, file_offset, file_path);
 }
 
-static int __perf_session__process_events(struct perf_session *session)
-{
-	struct reader rd = {
-		.fd		= perf_data__fd(session->data),
-		.data_size	= session->header.data_size,
-		.data_offset	= session->header.data_offset,
-		.process	= process_simple,
-		.path		= session->data->file.path,
-	};
-	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
-	struct ui_progress prog;
-	int err;
-
-	perf_tool__fill_defaults(tool);
-
-	if (rd.data_size == 0)
-		return -1;
-
-	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
-
-	err = reader__process_events(&rd, session, &prog);
-	if (err)
-		goto out_err;
-	/* do the final flush for ordered samples */
-	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
-	if (err)
-		goto out_err;
-	err = auxtrace__flush_events(session, tool);
-	if (err)
-		goto out_err;
-	err = perf_session__flush_thread_stacks(session);
-out_err:
-	ui_progress__finish();
-	if (!tool->no_warn)
-		perf_session__warn_about_errors(session);
-	/*
-	 * We may switching perf.data output, make ordered_events
-	 * reusable.
-	 */
-	ordered_events__reinit(&session->ordered_events);
-	auxtrace__free_events(session);
-	session->one_mmap = false;
-	return err;
-}
-
 static int
 reader__init(struct reader *rd, bool *one_mmap)
 {
@@ -2467,6 +2318,72 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	session->active_reader = NULL;;
 	return ret;
 }
+
+static int __perf_session__process_events(struct perf_session *session)
+{
+	struct reader *rd;
+	struct ordered_events *oe = &session->ordered_events;
+	struct perf_tool *tool = session->tool;
+	struct ui_progress prog;
+	int err;
+
+	perf_tool__fill_defaults(tool);
+
+	rd = session->readers = zalloc(sizeof(struct reader));
+	if (!rd)
+		return -ENOMEM;
+
+	session->nr_readers = 1;
+
+	*rd = (struct reader) {
+		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
+		.process	= process_simple,
+		.path		= session->data->file.path,
+	};
+
+	ui_progress__init_size(&prog, rd->data_size, "Processing events...");
+
+	reader__init(rd, &session->one_mmap);
+	if (reader__mmap(rd, session) != READER_OK)
+		goto out_err;
+
+	while (true) {
+		if (session_done())
+			break;
+
+		err = reader__read_event(rd, session, &prog);
+		if (err < 0)
+			break;
+		if (err == READER_EOF) {
+			err = reader__mmap(rd, session);
+			if (err <= 0)
+				break;
+		}
+	}
+
+	/* do the final flush for ordered samples */
+	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
+	if (err)
+		goto out_err;
+	err = auxtrace__flush_events(session, tool);
+	if (err)
+		goto out_err;
+	err = perf_session__flush_thread_stacks(session);
+out_err:
+	ui_progress__finish();
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
+	/*
+	 * We may switching perf.data output, make ordered_events
+	 * reusable.
+	 */
+	ordered_events__reinit(&session->ordered_events);
+	auxtrace__free_events(session);
+	session->one_mmap = false;
+	return err;
+}
 /*
  * This function reads, merge and process directory data.
  * It assumens the version 1 of directory data, where each
-- 
2.24.1

