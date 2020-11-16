Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6E2B4388
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgKPMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:19:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:33006 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgKPMTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:19:46 -0500
IronPort-SDR: kiP35a81h4t1x4OkDe87NkP2q/f9SfmVlbdZmdQXqopMv0R/6rllckLOkQST/KStzj/UAcDBl4
 R/30tCSEe2iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="234890264"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="234890264"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:19:46 -0800
IronPort-SDR: QDc9WV9vYdaygni7Q3aMCtTuOTNZ+a4/G6pWkpaez+oe6xr1nVQQequmny8CN2A2NWERmhM0Xy
 olfmX+8F988Q==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="543583511"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.228.209]) ([10.249.228.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:19:43 -0800
Subject: [PATCH v3 07/12] perf record: init data file at mmap buffer object
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
Message-ID: <ad205903-41a6-5041-f4f3-6f57d83cbd3a@linux.intel.com>
Date:   Mon, 16 Nov 2020 15:19:41 +0300
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


Initialize data files located at mmap buffer objects so trace data
can be written into several data file located at data directory.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 41 ++++++++++++++++++++++++++++++-------
 tools/perf/util/record.h    |  1 +
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 779676531edf..f5e5175da6a1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -158,6 +158,11 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+static int record__threads_enabled(struct record *rec)
+{
+	return rec->opts.threads_spec;
+}
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -1060,7 +1065,7 @@ static int record__free_thread_data(struct record *rec)
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
-	int ret;
+	int i, ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -1099,6 +1104,18 @@ static int record__mmap_evlist(struct record *rec,
 	if (ret)
 		return ret;
 
+	if (record__threads_enabled(rec)) {
+		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
+		if (ret)
+			return ret;
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
+			if (evlist->mmap)
+				evlist->mmap[i].file = &rec->data.dir.files[i];
+			if (evlist->overwrite_mmap)
+				evlist->overwrite_mmap[i].file = &rec->data.dir.files[i];
+		}
+	}
+
 	return 0;
 }
 
@@ -1400,8 +1417,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	/*
 	 * Mark the round finished in case we wrote
 	 * at least one event.
+	 *
+	 * No need for round events in directory mode,
+	 * because per-cpu maps and files have data
+	 * sorted by kernel.
 	 */
-	if (bytes_written != rec->bytes_written)
+	if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
 		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
@@ -1514,7 +1535,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.use_clockid)
 		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
 
-	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!record__threads_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
@@ -1525,15 +1548,21 @@ static void
 record__finish_output(struct record *rec)
 {
 	struct perf_data *data = &rec->data;
-	int fd = perf_data__fd(data);
+	int i, fd = perf_data__fd(data);
 
 	if (data->is_pipe)
 		return;
 
 	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+	if (record__threads_enabled(rec)) {
+		for (i = 0; i < data->dir.nr; i++)
+			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
+	}
 
 	if (!rec->no_buildid) {
+		/* this will be recalculated during process_buildids() */
+		rec->samples = 0;
 		process_buildids(rec);
 
 		if (rec->buildid_all)
@@ -2438,8 +2467,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		status = err;
 
 	record__synthesize(rec, true);
-	/* this will be recalculated during process_buildids() */
-	rec->samples = 0;
 
 	if (!err) {
 		if (!rec->timestamp_filename) {
@@ -3179,7 +3206,7 @@ int cmd_record(int argc, const char **argv)
 
 	}
 
-	if (rec->opts.kcore)
+	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
 	if (rec->opts.comp_level != 0) {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 266760ac9143..9c13a39cc58f 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -74,6 +74,7 @@ struct record_opts {
 	int	      ctl_fd;
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
+	int	      threads_spec;
 };
 
 extern const char * const *record_usage;
-- 
2.24.1

