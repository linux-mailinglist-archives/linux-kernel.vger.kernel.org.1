Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7269328B125
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgJLJKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:10:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:3665 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgJLJKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:10:15 -0400
IronPort-SDR: +R2igll7c8brWBaRatk3CVD9UKKDVDfHjoz6f9tYZWWg3Px6dMc2OfvZ3AC0/Oug4XlygoQ7ox
 v6LIMuXJxuhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="227356978"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="227356978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:10:13 -0700
IronPort-SDR: 3ISA1hPRcQaVCZTm4pNWhfPqOk9beN3HKxotX9JjVOtxCkkOhg2E4TAczGfciHjHJLDueqmPTZ
 TgU7hQh8DKFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="344807200"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2020 02:10:13 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id 10B30580814;
        Mon, 12 Oct 2020 02:10:10 -0700 (PDT)
Subject: [PATCH v1 13/15] perf record: stop threads in the end of trace
 streaming
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
Message-ID: <4cc1a63d-091b-0cb5-9258-71a2f95d3b7c@linux.intel.com>
Date:   Mon, 12 Oct 2020 12:10:09 +0300
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


Close write fd of comm.msg pipe to signal thread to terminate
and receive THREAD_MSG__READY confirmation on termination.
Accumulate thread stats into global stats to be correctly
calculated and displayed in perf tool output.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 64 ++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3b7e9026f25b..a15642656066 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -85,6 +85,16 @@ struct switch_output {
 	int		 cur_file;
 };
 
+enum thread_msg {
+	THREAD_MSG__UNSUPPORTED = 0,
+	THREAD_MSG__READY,
+	THREAD_MSG__MAX,
+};
+
+static const char *thread_msg_tags[THREAD_MSG__MAX] = {
+	"UNSUPPORTED", "READY"
+};
+
 struct thread_data {
 	pid_t		   tid;
 	struct {
@@ -1796,6 +1806,50 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
 	}
 }
 
+static int record__terminate_thread(struct thread_data *thread_data)
+{
+	int res;
+	enum thread_msg ack = THREAD_MSG__UNSUPPORTED;
+	pid_t tid = thread_data->tid;
+
+	close(thread_data->comm.msg[1]);
+	res = read(thread_data->comm.ack[0], &ack, sizeof(ack));
+	if (res != -1)
+		pr_debug("threads: %d -> %s\n", tid, thread_msg_tags[ack]);
+	else
+		pr_err("threads: failed to recv msg=%s from %d\n",
+		       thread_msg_tags[ack], tid);
+
+	return 0;
+}
+
+static int record__stop_threads(struct record *rec, unsigned long *waking)
+{
+	int i, j, nr_thread_data = rec->nr_thread_data;
+	struct thread_data *thread_data = rec->thread_data;
+
+	if (!record__threads_enabled(rec))
+		return 0;
+
+	for (i = 1; i < nr_thread_data; i++)
+		record__terminate_thread(&thread_data[i]);
+
+	for (i = 0; i < nr_thread_data; i++) {
+		pr_debug("threads: %d : samples %lld, wakes %ld\n",
+			 thread_data[i].tid, thread_data[i].samples,
+			 thread_data[i].waking);
+
+		rec->samples += thread_data[i].samples;
+		*waking      += thread_data[i].waking;
+		for (j = 0; j < thread_data[i].nr_mmaps; j++) {
+			rec->session->bytes_transferred += thread_data[i].maps[j].bytes_transferred;
+			rec->session->bytes_compressed  += thread_data[i].maps[j].bytes_compressed;
+		}
+	}
+
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1903,7 +1957,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (record__open(rec) != 0) {
 		err = -1;
-		goto out_child;
+		goto out_free_threads;
 	}
 	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
@@ -2203,18 +2257,20 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	if (!quiet)
-		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
-
 	if (target__none(&rec->opts.target))
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__stop_threads(rec, &waking);
+out_free_threads:
 	record__free_thread_data(rec);
 	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
+	if (!quiet)
+		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
+
 	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
 		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
 		session->header.env.comp_ratio = ratio + 0.5;
-- 
2.24.1

