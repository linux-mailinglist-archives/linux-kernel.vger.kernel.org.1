Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1BC2B4375
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgKPMRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:17:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:15646 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgKPMRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:17:20 -0500
IronPort-SDR: 6oq0t1bYNpKeW4lYCS5jkv7/YPgOOgOyDiG9F5pLuje8mK619CwZgVAaVW81RbqMn1K5TeYgeR
 MWpQI4UpZsrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="188780176"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="188780176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:17:19 -0800
IronPort-SDR: Whyn+cS//VO3c5R3MkkCVwvD9BJU6Z2pjXR3H+zOz3Q+y1CEPpLJHO42XMlzRklf5COYntBYYC
 ZrhjaeCNWDsg==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="543582898"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.228.209]) ([10.249.228.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:17:16 -0800
Subject: [PATCH v3 04/12] perf record: stop threads in the end of trace
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
Message-ID: <d031b690-9554-f6e7-c406-bb7bc45c1d71@linux.intel.com>
Date:   Mon, 16 Nov 2020 15:17:14 +0300
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


Signal thread to terminate by closing write fd of comm.msg pipe.
Receive THREAD_MSG__READY message as the confirmation of the
thread's termination. Stop threads created for parallel trace
streaming prior their stats processing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e41e1cd90168..d0b528cde68b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -111,6 +111,16 @@ struct thread_data {
 
 static __thread struct thread_data *thread;
 
+enum thread_msg {
+	THREAD_MSG__UNDEFINED = 0,
+	THREAD_MSG__READY,
+	THREAD_MSG__MAX,
+};
+
+static const char *thread_msg_tags[THREAD_MSG__MAX] = {
+	"UNDEFINED", "READY"
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -1818,6 +1828,23 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
 	}
 }
 
+static int record__terminate_thread(struct thread_data *thread_data)
+{
+	int res;
+	enum thread_msg ack = THREAD_MSG__UNDEFINED;
+	pid_t tid = thread_data->tid;
+
+	close(thread_data->comm.msg[1]);
+	res = read(thread_data->comm.ack[0], &ack, sizeof(ack));
+	if (res != -1)
+		pr_debug("threads[%d]: sent %s\n", tid, thread_msg_tags[ack]);
+	else
+		pr_err("threads[%d]: failed to recv msg=%s from tid=%d\n",
+		       thread->tid, thread_msg_tags[ack], tid);
+
+	return 0;
+}
+
 static int record__start_threads(struct record *rec)
 {
 	struct thread_data *thread_data = rec->thread_data;
@@ -1834,6 +1861,9 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
 	int t;
 	struct thread_data *thread_data = rec->thread_data;
 
+	for (t = 1; t < rec->nr_threads; t++)
+		record__terminate_thread(&thread_data[t]);
+
 	for (t = 0; t < rec->nr_threads; t++) {
 		rec->samples += thread_data[t].samples;
 		*waking += thread_data[t].waking;
-- 
2.24.1

