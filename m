Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3458A28B113
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgJLJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:03:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:53646 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgJLJDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:03:51 -0400
IronPort-SDR: DcPByeqJxuoeQ8MWiL6YRbXZdo8xTsDC3JWSwYjE5yNUkUMU+/Aso54E46bThP8NNnRuJVMEav
 +7gpVI0uo1Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="165767768"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="165767768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:03:51 -0700
IronPort-SDR: BDsFsbFqgtIJIQDtab+NJC9JQlv/uwwhQbAGQXru0WBUlFEQjlXgUOQu+x6w03/1mhV0TorXNh
 zdztCNbWnjbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="345787525"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2020 02:03:50 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id A9EC0580814;
        Mon, 12 Oct 2020 02:03:48 -0700 (PDT)
Subject: [PATCH v1 10/15] perf record: manage thread specific data array
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
Message-ID: <ae6d0e04-fcf0-533e-8ce8-ec3062ac81b7@linux.intel.com>
Date:   Mon, 12 Oct 2020 12:03:47 +0300
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

