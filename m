Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C592295068
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502806AbgJUQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:08:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:8295 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502799AbgJUQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:08:51 -0400
IronPort-SDR: Rv74zu4G7mmjRrv9AZr9sklUqbXYeBMCxuxvyvfWW8sofUiS9cz6QYXK/UEFlBN+srnU4iucOO
 vzVXTKjD0gew==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="166615350"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="166615350"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:08:50 -0700
IronPort-SDR: 5FcaEDjs9+1cG767U5gSLlizsH8fyLquw9xuXG+POVFcZnjuTFasFEpl5AmO1Tw7QKGEh0QnwL
 ZheqI+NfCQlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="359545450"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2020 09:08:50 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 602B5580720;
        Wed, 21 Oct 2020 09:08:48 -0700 (PDT)
Subject: [PATCH v2 13/15] perf record: stop threads in the end of trace
 streaming
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
Message-ID: <76431e0e-a758-a262-61ea-97e05f433f44@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:08:47 +0300
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


