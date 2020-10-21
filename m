Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C444229505C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502589AbgJUQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:04:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:62514 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502474AbgJUQEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:04:32 -0400
IronPort-SDR: MgZU1KBOsDFT9Q+U8nSAjF2h5R7zQs3Kv6QF1++h3whz30dAOmjeg+mrND1iMfwHLhD/vAGTkG
 vR5ozMuXpgCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="252088776"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="252088776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:04:32 -0700
IronPort-SDR: 2V/J8IEwbVfwYE3O2ziESbtx39Jus96psnHeH5RyO/KHry0KJyFPDAIYHYddBPjfeg9EO9NS7B
 HqSjjZeb1MnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="466345901"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 21 Oct 2020 09:04:30 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 7FADF580107;
        Wed, 21 Oct 2020 09:04:27 -0700 (PDT)
Subject: [PATCH v2 10/15] perf record: manage thread specific data array
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
Message-ID: <06b6c1bb-9875-83f8-2b1d-601e186ea80a@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:04:26 +0300
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


Provide allocation, initialization, finalization and releasing of
thread specific objects at thread specific data array. Allocate
thread specific object for every data buffer making one-to-one
relation between data buffer and a thread processing the buffer.
Deliver event fd related signals to thread's pollfd object.
Deliver thread control commands to ctlfd_pos fd of thread 1+.
Deliver tool external control commands via ctlfd_pos fd of thread 0.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 101 ++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8e512096a060..89cb8e913fb3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -884,6 +884,94 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
 	return kcore_copy(from_dir, kcore_dir);
 }
 
+static int record__alloc_thread_data(struct record *rec, struct mmap *mmaps, int nr_mmaps,
+				     struct fdarray *evlist_pollfd, int ctlfd_pos)
+{
+	int i, j, k, nr_thread_data;
+	struct thread_data *thread_data;
+
+	rec->nr_thread_data = nr_thread_data = nr_mmaps;
+	rec->thread_data = thread_data = zalloc(rec->nr_thread_data * sizeof(*(rec->thread_data)));
+	if (!thread_data) {
+		pr_err("Failed to allocate thread data\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nr_thread_data; i++) {
+		short revents;
+		int pos, fd;
+
+		thread_data[i].tid = -1;
+
+		if (pipe(thread_data[i].comm.msg) ||
+		    pipe(thread_data[i].comm.ack)) {
+			pr_err("Failed to create thread comm pipes, errno %d\n", errno);
+			return -ENOMEM;
+		}
+
+		thread_data[i].maps = &mmaps[i];
+		thread_data[i].nr_mmaps = 1;
+
+		thread_data[i].rec = rec;
+
+		fdarray__init(&(thread_data[i].pollfd), 64);
+
+		for (j = 0; j < thread_data[i].nr_mmaps; j++) {
+			struct mmap *map = &(thread_data[i].maps[j]);
+
+			for (k = 0; k < evlist_pollfd->nr; k++) {
+				if (evlist_pollfd->priv[k].ptr != map)
+					continue;
+
+				fd = evlist_pollfd->entries[k].fd;
+				revents = evlist_pollfd->entries[k].events;
+				pos = fdarray__add(&(thread_data[i].pollfd),
+						fd, revents | POLLERR | POLLHUP,
+						fdarray_flag__default);
+				if (pos >= 0)
+					thread_data[i].pollfd.priv[pos].ptr = map;
+				else
+					return -ENOMEM;
+			}
+		}
+
+		if (i) {
+			fd = thread_data[i].comm.msg[0];
+			revents = POLLIN | POLLERR | POLLHUP;
+		} else {
+			if (ctlfd_pos == -1)
+				continue;
+			fd = evlist_pollfd->entries[ctlfd_pos].fd;
+			revents = evlist_pollfd->entries[ctlfd_pos].events;
+		}
+		thread_data[i].ctlfd_pos =
+				fdarray__add(&(thread_data[i].pollfd),
+					     fd, revents, fdarray_flag__nonfilterable);
+		if (thread_data[i].ctlfd_pos < 0)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int record__free_thread_data(struct record *rec)
+{
+	int i;
+
+	if (rec->thread_data) {
+		for (i = 0; i < rec->nr_thread_data; i++) {
+			close(rec->thread_data[i].comm.msg[0]);
+			close(rec->thread_data[i].comm.msg[1]);
+			close(rec->thread_data[i].comm.ack[0]);
+			close(rec->thread_data[i].comm.ack[1]);
+			fdarray__exit(&(rec->thread_data[i].pollfd));
+		}
+		zfree(&rec->thread_data);
+	}
+
+	return 0;
+}
+
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
@@ -918,6 +1006,9 @@ static int record__mmap_evlist(struct record *rec,
 		}
 	}
 
+	if (evlist__initialize_ctlfd(evlist, opts->ctl_fd, opts->ctl_fd_ack))
+		return -1;
+
 	if (record__threads_enabled(rec)) {
 		int i, ret, nr = evlist->core.nr_mmaps;
 		struct mmap *mmaps = rec->opts.overwrite ?
@@ -929,6 +1020,12 @@ static int record__mmap_evlist(struct record *rec,
 
 		for (i = 0; i < nr; i++)
 			mmaps[i].file = &rec->data.dir.files[i];
+
+		ret = record__alloc_thread_data(rec, mmaps, nr,
+						&evlist->core.pollfd,
+						evlist->ctl_fd.pos);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1910,9 +2007,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		perf_evlist__start_workload(rec->evlist);
 	}
 
-	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
-		goto out_child;
-
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -2063,6 +2157,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__free_thread_data(rec);
 	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
-- 
2.24.1

