Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10140295066
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502790AbgJUQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:07:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:46901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502783AbgJUQHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:07:05 -0400
IronPort-SDR: cNkhhOg0PI1hdL7pDGBLCXP0VpKuMPDJWFys+modvLifjxDbuH+l/a/QUMN2Q6HGBq5RO8Gt3U
 YwA1oOZcnpLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167512730"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="167512730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:07:04 -0700
IronPort-SDR: hpb48Ym4Pd3xQVFU+hnvXyjcfHnPslRg8KpxIC770yDUYX5hOHt09P49jbg7YxcO291bMLxkzZ
 +KVQokKSOyyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="358934190"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2020 09:07:04 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id F0B89580720;
        Wed, 21 Oct 2020 09:07:01 -0700 (PDT)
Subject: [PATCH v2 12/15] perf record: introduce thread local variable for
 trace streaming
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
Message-ID: <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:07:00 +0300
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


Introduce thread local variable and use it for threaded trace streaming.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 71 ++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 89cb8e913fb3..3b7e9026f25b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -101,6 +101,8 @@ struct thread_data {
 	u64		   bytes_written;
 };
 
+static __thread struct thread_data *thread;
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -587,7 +589,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 		}
 	}
 
-	rec->samples++;
+	if (thread)
+		thread->samples++;
+	else
+		rec->samples++;
+
 	return record__write(rec, map, bf, compressed);
 }
 
@@ -1258,6 +1264,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	int i;
 	int rc = 0;
 	struct mmap *maps;
+	int nr_mmaps;
 	int trace_fd = rec->data.file.fd;
 	off_t off = 0;
 
@@ -1265,6 +1272,14 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		return 0;
 
 	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
+	nr_mmaps = evlist->core.nr_mmaps;
+
+	if (thread) {
+		bytes_written = thread->bytes_written;
+		maps = thread->maps;
+		nr_mmaps = thread->nr_mmaps;
+	}
+
 	if (!maps)
 		return 0;
 
@@ -1274,7 +1289,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	if (record__aio_enabled(rec))
 		off = record__aio_get_pos(trace_fd);
 
-	for (i = 0; i < evlist->core.nr_mmaps; i++) {
+	for (i = 0; i < nr_mmaps; i++) {
 		u64 flush = 0;
 		struct mmap *map = &maps[i];
 
@@ -1323,7 +1338,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	 * because per-cpu maps and files have data
 	 * sorted by kernel.
 	 */
-	if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
+	if (!thread && bytes_written != rec->bytes_written)
 		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
@@ -1343,6 +1358,15 @@ static int record__mmap_read_all(struct record *rec, bool synch)
 	return record__mmap_read_evlist(rec, rec->evlist, true, synch);
 }
 
+static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
+					   void *arg __maybe_unused)
+{
+	struct perf_mmap *map = fda->priv[fd].ptr;
+
+	if (map)
+		perf_mmap__put(map);
+}
+
 static void record__init_features(struct record *rec)
 {
 	struct perf_session *session = rec->session;
@@ -2020,7 +2044,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_ready(&switch_output_trigger);
 	perf_hooks__invoke_record_start();
 	for (;;) {
-		unsigned long long hits = rec->samples;
+		unsigned long long hits0, hits1;
+
+		if (thread)
+			hits0 = thread->samples;
+		else
+			hits0 = rec->samples;
 
 		/*
 		 * rec->evlist->bkw_mmap_state is possible to be
@@ -2089,20 +2118,44 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				alarm(rec->switch_output.time);
 		}
 
-		if (hits == rec->samples) {
+		if (thread)
+			hits1 = thread->samples;
+		else
+			hits1 = rec->samples;
+
+		if (hits0 == hits1) {
 			if (done || draining)
 				break;
-			err = evlist__poll(rec->evlist, -1);
+
+			if (thread)
+				err = fdarray__poll(&thread->pollfd, -1);
+			else
+				err = evlist__poll(rec->evlist, -1);
 			/*
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
 			 */
 			if (err > 0 || (err < 0 && errno == EINTR))
 				err = 0;
-			waking++;
 
-			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
-				draining = true;
+			if (thread) {
+				thread->waking++;
+				if (thread->ctlfd_pos != -1) {
+					evlist__ctlfd_update(rec->evlist,
+						&(thread->pollfd.entries[thread->ctlfd_pos]));
+				}
+			} else {
+				waking++;
+			}
+
+			if (thread) {
+				if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
+						    record__thread_munmap_filtered, NULL) == 0)
+					draining = true;
+			} else {
+				if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
+					draining = true;
+			}
 		}
 
 		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
-- 
2.24.1


