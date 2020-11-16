Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6452B436F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgKPMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:16:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:51875 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbgKPMQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:16:24 -0500
IronPort-SDR: wSsntN72R0bvOFapwfvmCFhCWD2fwIVO9i6YIwxjcvVAKacVxggkcZ3BH21s9AA2uao3VQk2LF
 +mbHVlhiL4LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="232353412"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="232353412"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:16:23 -0800
IronPort-SDR: /80X0D5Fma+ao6SsDhb+/xR6FPpdJiemuBvyDBxzh5IEcfOSIOZKB98nHRRI/f5V9MgG9Tuv03
 xlWDtKYuxLZg==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="543582640"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.228.209]) ([10.249.228.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:16:20 -0800
Subject: [PATCH v3 03/12] perf record: introduce thread local variable
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
Message-ID: <96d7752f-2c0c-330d-a11c-0961e0315c3c@linux.intel.com>
Date:   Mon, 16 Nov 2020 15:16:19 +0300
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


Introduce thread local variable and use it for threaded trace streaming.
Use thread affinity mask instead or record affinity mask in affinity modes.
Introduce and use evlist__ctlfd_update() function to propogate external
control commands to global evlist object.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 137 ++++++++++++++++++++++++------------
 tools/perf/util/evlist.c    |  16 +++++
 tools/perf/util/evlist.h    |   1 +
 3 files changed, 109 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 765a90e38f69..e41e1cd90168 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -109,6 +109,8 @@ struct thread_data {
 	u64			bytes_written;
 };
 
+static __thread struct thread_data *thread;
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -130,7 +132,6 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
-	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
 	struct thread_mask	*thread_masks;
 	struct thread_data	*thread_data;
@@ -565,7 +566,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 		bf   = map->data;
 	}
 
-	rec->samples++;
+	thread->samples++;
 	return record__write(rec, map, bf, size);
 }
 
@@ -1244,16 +1245,23 @@ static struct perf_event_header finished_round_event = {
 
 static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
+	int ret = 0;
+
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
-	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
-			  rec->affinity_mask.nbits)) {
-		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
-		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
-			  map->affinity_mask.bits, rec->affinity_mask.nbits);
-		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&rec->affinity_mask),
-				  (cpu_set_t *)rec->affinity_mask.bits);
-		if (verbose == 2)
-			mmap_cpu_mask__scnprintf(&rec->affinity_mask, "thread");
+	    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.bits,
+			  thread->mask->affinity.nbits)) {
+		bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.nbits);
+		bitmap_or(thread->mask->affinity.bits, thread->mask->affinity.bits,
+			  map->affinity_mask.bits, thread->mask->affinity.nbits);
+		ret = sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread->mask->affinity),
+					(cpu_set_t *)thread->mask->affinity.bits);
+		if (ret)
+			pr_err("threads[%d]: sched_setaffinity() call failed: %m\n", thread->tid);
+		if (verbose == 2) {
+			pr_debug("threads[%d]: addr=", thread->tid);
+			mmap_cpu_mask__scnprintf(&thread->mask->affinity, "thread");
+			pr_debug("threads[%d]: on cpu=%d\n", thread->tid, sched_getcpu());
+		}
 	}
 }
 
@@ -1291,17 +1299,21 @@ static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_
 static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 				    bool overwrite, bool synch)
 {
-	u64 bytes_written = rec->bytes_written;
+	u64 bytes_written;
 	int i;
 	int rc = 0;
-	struct mmap *maps;
+	struct mmap **maps;
+	int nr_mmaps;
 	int trace_fd = rec->data.file.fd;
 	off_t off = 0;
 
 	if (!evlist)
 		return 0;
 
-	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
+	bytes_written = thread->bytes_written;
+	maps = overwrite ? thread->overwrite_maps : thread->maps;
+	nr_mmaps = thread->nr_mmaps;
+
 	if (!maps)
 		return 0;
 
@@ -1311,9 +1323,9 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	if (record__aio_enabled(rec))
 		off = record__aio_get_pos(trace_fd);
 
-	for (i = 0; i < evlist->core.nr_mmaps; i++) {
+	for (i = 0; i < nr_mmaps; i++) {
 		u64 flush = 0;
-		struct mmap *map = &maps[i];
+		struct mmap *map = maps[i];
 
 		if (map->core.base) {
 			record__adjust_affinity(rec, map);
@@ -1376,6 +1388,15 @@ static int record__mmap_read_all(struct record *rec, bool synch)
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
@@ -1797,6 +1818,33 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
 	}
 }
 
+static int record__start_threads(struct record *rec)
+{
+	struct thread_data *thread_data = rec->thread_data;
+
+	thread = &thread_data[0];
+
+	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
+
+	return 0;
+}
+
+static int record__stop_threads(struct record *rec, unsigned long *waking)
+{
+	int t;
+	struct thread_data *thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		rec->samples += thread_data[t].samples;
+		*waking += thread_data[t].waking;
+		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld\n",
+			 thread_data[t].tid, thread_data[t].samples, thread_data[t].waking,
+			 rec->session->bytes_transferred, rec->session->bytes_compressed);
+	}
+
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1904,7 +1952,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (record__open(rec) != 0) {
 		err = -1;
-		goto out_child;
+		goto out_free_threads;
 	}
 	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
@@ -1912,7 +1960,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = record__kcore_copy(&session->machines.host, data);
 		if (err) {
 			pr_err("ERROR: Failed to copy kcore\n");
-			goto out_child;
+			goto out_free_threads;
 		}
 	}
 
@@ -1923,7 +1971,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
 		pr_err("ERROR: Apply config to BPF failed: %s\n",
 			 errbuf);
-		goto out_child;
+		goto out_free_threads;
 	}
 
 	/*
@@ -1941,11 +1989,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe) {
 		err = perf_header__write_pipe(fd);
 		if (err < 0)
-			goto out_child;
+			goto out_free_threads;
 	} else {
 		err = perf_session__write_header(session, rec->evlist, fd, false);
 		if (err < 0)
-			goto out_child;
+			goto out_free_threads;
 	}
 
 	err = -1;
@@ -1953,16 +2001,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	    && !perf_header__has_feat(&session->header, HEADER_BUILD_ID)) {
 		pr_err("Couldn't generate buildids. "
 		       "Use --no-buildid to profile anyway.\n");
-		goto out_child;
+		goto out_free_threads;
 	}
 
 	err = record__setup_sb_evlist(rec);
 	if (err)
-		goto out_child;
+		goto out_free_threads;
 
 	err = record__synthesize(rec, false);
 	if (err < 0)
-		goto out_child;
+		goto out_free_threads;
 
 	if (rec->realtime_prio) {
 		struct sched_param param;
@@ -1971,10 +2019,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (sched_setscheduler(0, SCHED_FIFO, &param)) {
 			pr_err("Could not set realtime priority.\n");
 			err = -1;
-			goto out_child;
+			goto out_free_threads;
 		}
 	}
 
+	if (record__start_threads(rec))
+		goto out_free_threads;
+
 	/*
 	 * When perf is starting the traced process, all the events
 	 * (apart from group members) have enable_on_exec=1 set,
@@ -2045,7 +2096,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_ready(&switch_output_trigger);
 	perf_hooks__invoke_record_start();
 	for (;;) {
-		unsigned long long hits = rec->samples;
+		unsigned long long hits = thread->samples;
 
 		/*
 		 * rec->evlist->bkw_mmap_state is possible to be
@@ -2114,20 +2165,26 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				alarm(rec->switch_output.time);
 		}
 
-		if (hits == rec->samples) {
+		if (hits == thread->samples) {
 			if (done || draining)
 				break;
-			err = evlist__poll(rec->evlist, -1);
+			err = fdarray__poll(&thread->pollfd, -1);
 			/*
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
 			 */
 			if (err > 0 || (err < 0 && errno == EINTR))
 				err = 0;
-			waking++;
+			thread->waking++;
 
-			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
+			if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
+					    record__thread_munmap_filtered, NULL) == 0)
 				draining = true;
+
+			if (thread->ctlfd_pos != -1) {
+				evlist__ctlfd_update(rec->evlist,
+					&thread->pollfd.entries[thread->ctlfd_pos]);
+			}
 		}
 
 		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
@@ -2175,18 +2232,20 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -2995,17 +3054,6 @@ int cmd_record(int argc, const char **argv)
 
 	symbol__init(NULL);
 
-	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
-		rec->affinity_mask.nbits = cpu__max_cpu();
-		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
-		if (!rec->affinity_mask.bits) {
-			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
-			err = -ENOMEM;
-			goto out_opts;
-		}
-		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
-	}
-
 	err = record__auxtrace_init(rec);
 	if (err)
 		goto out;
@@ -3134,7 +3182,6 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
-	bitmap_free(rec->affinity_mask.bits);
 	evlist__delete(rec->evlist);
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8bdf3d2c907c..758a4896fedd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1970,6 +1970,22 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 	return err;
 }
 
+int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update)
+{
+	int ctlfd_pos = evlist->ctl_fd.pos;
+	struct pollfd *entries = evlist->core.pollfd.entries;
+
+	if (!evlist__ctlfd_initialized(evlist))
+		return 0;
+
+	if (entries[ctlfd_pos].fd != update->fd ||
+	    entries[ctlfd_pos].events != update->events)
+		return -1;
+
+	entries[ctlfd_pos].revents = update->revents;
+	return 0;
+}
+
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e1a450322bc5..9b73d6ccf066 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -380,6 +380,7 @@ void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
+int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 int evlist__ctlfd_ack(struct evlist *evlist);
 
-- 
2.24.1


