Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C828B10C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgJLJBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:01:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:28728 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgJLJBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:01:54 -0400
IronPort-SDR: MDjwfYEo/Qb+6vCEHSV/ci2yxw0hlvGsN8ab7On7Ivgv9cLZZF6wmIJCHjdRid0T7lULJZv9dU
 xrA88hmAgrhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="250403829"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="250403829"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:01:54 -0700
IronPort-SDR: 2m6Tg1BaJ4CE+U8ZZuPIQJWYDs1aeHRWSBbX6zd9OFixxWBpRcMcK7XkRkjb14Kk0vzp9hG/6t
 ZE+KjMajww0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="356553768"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 12 Oct 2020 02:01:53 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id 531E15805EC;
        Mon, 12 Oct 2020 02:01:51 -0700 (PDT)
Subject: [PATCH v1 08/15] perf record: write trace data into mmap trace files
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
Message-ID: <0652b8dd-e753-7c10-27e9-af9524e7ccc5@linux.intel.com>
Date:   Mon, 12 Oct 2020 12:01:50 +0300
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


Write trace data into per mmap trace files located
at data directory. Streaming thread adjusts its affinity
according to mask of the buffer being processed.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 44 ++++++++++++++++++++++++++++++++-----
 tools/perf/util/record.h    |  1 +
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 619aaee11231..ba26d75c51d6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -120,6 +120,11 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+static int record__threads_enabled(struct record *rec)
+{
+	return rec->opts.threads;
+}
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -894,6 +899,20 @@ static int record__mmap_evlist(struct record *rec,
 				return -EINVAL;
 		}
 	}
+
+	if (record__threads_enabled(rec)) {
+		int i, ret, nr = evlist->core.nr_mmaps;
+		struct mmap *mmaps = rec->opts.overwrite ?
+				     evlist->overwrite_mmap : evlist->mmap;
+
+		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < nr; i++)
+			mmaps[i].file = &rec->data.dir.files[i];
+	}
+
 	return 0;
 }
 
@@ -1184,8 +1203,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
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
@@ -1231,7 +1254,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.use_clockid)
 		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
 
-	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!record__threads_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
@@ -1242,15 +1267,21 @@ static void
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
@@ -2041,8 +2072,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		status = err;
 
 	record__synthesize(rec, true);
-	/* this will be recalculated during process_buildids() */
-	rec->samples = 0;
 
 	if (!err) {
 		if (!rec->timestamp_filename) {
@@ -2680,9 +2709,12 @@ int cmd_record(int argc, const char **argv)
 
 	}
 
-	if (rec->opts.kcore)
+	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
+	if (record__threads_enabled(rec))
+		rec->opts.affinity = PERF_AFFINITY_CPU;
+
 	if (rec->opts.comp_level != 0) {
 		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
 		rec->no_buildid = true;
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 266760ac9143..aeda3cdaa3e9 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -74,6 +74,7 @@ struct record_opts {
 	int	      ctl_fd;
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
+	bool	      threads;
 };
 
 extern const char * const *record_usage;
-- 
2.24.1

