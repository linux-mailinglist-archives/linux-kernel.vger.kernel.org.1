Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA12B437D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgKPMSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:18:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:11065 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgKPMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:18:14 -0500
IronPort-SDR: OTvpzAdx4fPPWI0G0MORC0HHsFVzwk8prbxt238h2tgupUiN7gIK8iJT7PRvmmtzlzjRYVsORF
 q4sq/FcRorvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158513273"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="158513273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:18:13 -0800
IronPort-SDR: FhsreTnuM35DGEjp1ZInUDvqcEIO0XaSlu8yyFYnvrJrV2FYoHE6vcJ3xr5JZpGMFYU/vdUjwZ
 X1RMWMVh2pYQ==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="543583093"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.228.209]) ([10.249.228.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:18:10 -0800
Subject: [PATCH v3 05/12] perf record: start threads in the beginning of trace
 streaming
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
Message-ID: <21207250-375b-4212-2c40-6d2f6d5b1f01@linux.intel.com>
Date:   Mon, 16 Nov 2020 15:18:08 +0300
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


Start thread in detached state because its management is implemented
via messaging to avoid any scaling issues. Block signals prior thread
start so only main tool thread would be notified on external async
signals during data collection. Thread affinity mask is used to assign
eligible cpus for the thread to run. Wait and sync on thread start using
thread comm.ack pipe.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 103 +++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d0b528cde68b..13773739bedc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1407,6 +1407,64 @@ static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
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
+		pr_err("threads[%d]: failed to notify on start. Error %m", thread->tid);
+
+	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
+
+	pollfd = &thread->pollfd;
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
+		pr_err("threads[%d]: failed to notify on termination. Error %m", thread->tid);
+
+	return NULL;
+}
+
 static void record__init_features(struct record *rec)
 {
 	struct perf_session *session = rec->session;
@@ -1847,13 +1905,56 @@ static int record__terminate_thread(struct thread_data *thread_data)
 
 static int record__start_threads(struct record *rec)
 {
+	int t, tt, ret = 0, nr_threads = rec->nr_threads;
 	struct thread_data *thread_data = rec->thread_data;
+	sigset_t full, mask;
+	pthread_t handle;
+	pthread_attr_t attrs;
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
+	for (t = 1; t < nr_threads; t++) {
+		enum thread_msg msg = THREAD_MSG__UNDEFINED;
+
+		pthread_attr_setaffinity_np(&attrs, MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
+					    (cpu_set_t *)(thread_data[t].mask->affinity.bits));
+
+		if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
+			for (tt = 1; tt < t; tt++)
+				record__terminate_thread(&thread_data[t]);
+			pr_err("Failed to start threads. Error: %m\n");
+			ret = -1;
+			goto out_err;
+		}
+
+		if (read(thread_data[t].comm.ack[0], &msg, sizeof(msg)) > 0)
+			pr_debug("threads[%d]: sent %s\n", rec->thread_data[t].tid,
+				 thread_msg_tags[msg]);
+	}
+
+	if (nr_threads > 1) {
+		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread_data[0].mask->affinity),
+				  (cpu_set_t *)thread_data[0].mask->affinity.bits);
+	}
 
 	thread = &thread_data[0];
 
 	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
 
-	return 0;
+out_err:
+	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
+		pr_err("Failed to unblock signals on threads start. Error: %m\n");
+		ret = -1;
+	}
+
+	return ret;
 }
 
 static int record__stop_threads(struct record *rec, unsigned long *waking)
-- 
2.24.1

