Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98B829506B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502834AbgJUQKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:10:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:20965 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387937AbgJUQKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:10:44 -0400
IronPort-SDR: cQDjEmGRcTs0zy/+9B5Q5dR+fi12V5jacNJbagJ+5ns8H+IZk0ez94Le8Weklf5lOoMsi8C8un
 0/ViPLSbwddA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="154345050"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="154345050"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:10:18 -0700
IronPort-SDR: 0TaBEWzZ552jendrPKjttEc3JnVanL2EXe8kfbmeJQMGbsaKO/lJCVyT897E9StLnjFAbidQhS
 N7L4yJE0DseA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="392768497"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 21 Oct 2020 09:10:13 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 36F77580720;
        Wed, 21 Oct 2020 09:10:10 -0700 (PDT)
Subject: [PATCH v2 14/15] perf record: start threads in the beginning of trace
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
Message-ID: <0584888b-17b3-7a62-e585-8582d8a2d439@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:10:09 +0300
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


Start threads in detached state because its management is possible
via messaging. Block signals prior the threads start so only main
tool thread would be notified on external async signals during data
collection. Streaming threads connect one-to-one to mapped data
buffers and write into per-CPU trace files located at data directory.
Data buffers and threads are affined to local NUMA nodes and monitored
CPUs according to system topology. --cpu option can be used to specify
CPUs to be monitored.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 128 +++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a15642656066..1d41e996a994 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -56,6 +56,7 @@
 #include <poll.h>
 #include <pthread.h>
 #include <unistd.h>
+#include <sys/syscall.h>
 #include <sched.h>
 #include <signal.h>
 #ifdef HAVE_EVENTFD_SUPPORT
@@ -1377,6 +1378,62 @@ static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
 		perf_mmap__put(map);
 }
 
+static void *record__thread(void *arg)
+{
+	enum thread_msg msg = THREAD_MSG__READY;
+	bool terminate = false;
+	struct fdarray *pollfd;
+	int err, ctlfd_pos;
+
+	thread = arg;
+	thread->tid = syscall(SYS_gettid);
+
+	err = write(thread->comm.ack[1], &msg, sizeof(msg));
+	if (err == -1)
+		pr_err("threads: %d failed to notify on start. Error %m", thread->tid);
+
+	pollfd = &(thread->pollfd);
+	ctlfd_pos = thread->ctlfd_pos;
+
+	for (;;) {
+		unsigned long long hits = thread->samples;
+
+		if (record__mmap_read_all(thread->rec, false) < 0 || terminate)
+			break;
+
+		if (hits == thread->samples) {
+
+			err = fdarray__poll(pollfd, -1);
+			/*
+			 * Propagate error, only if there's any. Ignore positive
+			 * number of returned events and interrupt error.
+			 */
+			if (err > 0 || (err < 0 && errno == EINTR))
+				err = 0;
+			thread->waking++;
+
+			if (fdarray__filter(pollfd, POLLERR | POLLHUP,
+					    record__thread_munmap_filtered, NULL) == 0)
+				break;
+		}
+
+		if (pollfd->entries[ctlfd_pos].revents & POLLHUP) {
+			terminate = true;
+			close(thread->comm.msg[0]);
+			pollfd->entries[ctlfd_pos].fd = -1;
+			pollfd->entries[ctlfd_pos].events = 0;
+		}
+
+		pollfd->entries[ctlfd_pos].revents = 0;
+	}
+
+	err = write(thread->comm.ack[1], &msg, sizeof(msg));
+	if (err == -1)
+		pr_err("threads: %d failed to notify on termination. Error %m", thread->tid);
+
+	return NULL;
+}
+
 static void record__init_features(struct record *rec)
 {
 	struct perf_session *session = rec->session;
@@ -1823,6 +1880,58 @@ static int record__terminate_thread(struct thread_data *thread_data)
 	return 0;
 }
 
+static int record__start_threads(struct record *rec)
+{
+	int i, j, ret = 0;
+	sigset_t full, mask;
+	pthread_t handle;
+	pthread_attr_t attrs;
+	int nr_thread_data = rec->nr_thread_data;
+	struct thread_data *thread_data = rec->thread_data;
+
+	if (!record__threads_enabled(rec))
+		return 0;
+
+	sigfillset(&full);
+	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
+		pr_err("Failed to block signals on threads start. Error: %m\n");
+		return -1;
+	}
+
+	pthread_attr_init(&attrs);
+	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
+
+	for (i = 1; i < nr_thread_data; i++) {
+		int res = 0;
+		enum thread_msg msg = THREAD_MSG__UNSUPPORTED;
+
+		if (pthread_create(&handle, &attrs, record__thread, &thread_data[i])) {
+			for (j = 1; j < i; j++)
+				record__terminate_thread(&thread_data[i]);
+			pr_err("Failed to start threads. Error: %m\n");
+			ret = -1;
+			goto out_err;
+		}
+
+		res = read(thread_data[i].comm.ack[0], &msg, sizeof(msg));
+		if (res > 0)
+			pr_debug("threads: %d -> %s\n", rec->thread_data[i].tid,
+				 thread_msg_tags[msg]);
+	}
+
+	thread = &thread_data[0];
+	thread->tid = syscall(SYS_gettid);
+	pr_debug("threads: %d -> %s\n", thread->tid, thread_msg_tags[THREAD_MSG__READY]);
+
+out_err:
+	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
+		pr_err("Failed to unblock signals on threads start. Error: %m\n");
+		ret = -1;
+	}
+
+	return ret;
+}
+
 static int record__stop_threads(struct record *rec, unsigned long *waking)
 {
 	int i, j, nr_thread_data = rec->nr_thread_data;
@@ -1965,7 +2074,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = record__kcore_copy(&session->machines.host, data);
 		if (err) {
 			pr_err("ERROR: Failed to copy kcore\n");
-			goto out_child;
+			goto out_free_threads;
 		}
 	}
 
@@ -1976,7 +2085,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
 		pr_err("ERROR: Apply config to BPF failed: %s\n",
 			 errbuf);
-		goto out_child;
+		goto out_free_threads;
 	}
 
 	/*
@@ -1994,11 +2103,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -2006,16 +2115,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -2024,10 +2133,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
-- 
2.24.1


