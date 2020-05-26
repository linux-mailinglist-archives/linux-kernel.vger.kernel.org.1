Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C281BE208
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgD2PHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 11:07:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:30730 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgD2PHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:39 -0400
IronPort-SDR: hKBiy9lD7ObHeClg1IN9+eFGOAKIM4ea/doMaMaB+94JLuvb7H4rr3UJPXodJKyXAo/RX1zAFJ
 +wuNxqE1YFww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:31 -0700
IronPort-SDR: MVbcSrPQcJRyykbQqkrANxZbNSDzuBtisuKLNkvqp5bkc5CNyODnMzDPMsy8DK4BjCJv1Qy4r5
 fUKeNJX8XDjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227374"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] perf thread-stack: Add branch stack support
Date:   Wed, 29 Apr 2020 18:07:43 +0300
Message-Id: <20200429150751.12570-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT already has support for creating branch stacks for each context
(per-cpu or per-thread). In the more common per-cpu case, the branch stack
is not separated for different threads, instead being cleared in between
each sample. That approach will not work very well for adding branch stacks
to regular events. The branch stacks really need to be accumulated
separately for each thread.

As a start to accomplishing that, this patch adds support for putting
branch stack support into the thread-stack. The advantages are:
1. the branches are accumulated separately for each thread
2. the branch stack is cleared only in between continuous traces

This helps pave the way for adding branch stacks to regular events, not
just synthesized events as at present.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-bts.c    |   2 +-
 tools/perf/util/intel-pt.c     |   2 +-
 tools/perf/util/thread-stack.c | 113 +++++++++++++++++++++++++++++----
 tools/perf/util/thread-stack.h |   5 +-
 4 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 059e1c805ed0..506112f52619 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -432,7 +432,7 @@ static int intel_bts_process_buffer(struct intel_bts_queue *btsq,
 					    le64_to_cpu(branch->from),
 					    le64_to_cpu(branch->to),
 					    btsq->intel_pt_insn.length,
-					    buffer->buffer_nr + 1);
+					    buffer->buffer_nr + 1, true, 0, 0);
 		if (filter && !(filter & btsq->sample_flags))
 			continue;
 		err = intel_bts_synth_branch_sample(btsq, branch);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4be7634dccf5..865e79ccf55b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2032,7 +2032,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	    pt->synth_opts.thread_stack)
 		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
 				    state->to_ip, ptq->insn_len,
-				    state->trace_nr);
+				    state->trace_nr, true, 0, 0);
 	else
 		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 83f6c83f5617..79698831b4b9 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -80,6 +80,10 @@ struct thread_stack_entry {
  * @comm: current comm
  * @arr_sz: size of array if this is the first element of an array
  * @rstate: used to detect retpolines
+ * @br_stack_rb: branch stack (ring buffer)
+ * @br_stack_sz: maximum branch stack size
+ * @br_stack_pos: current position in @br_stack_rb
+ * @mispred_all: mark all branches as mispredicted
  */
 struct thread_stack {
 	struct thread_stack_entry *stack;
@@ -95,6 +99,10 @@ struct thread_stack {
 	struct comm *comm;
 	unsigned int arr_sz;
 	enum retpoline_state_t rstate;
+	struct branch_stack *br_stack_rb;
+	unsigned int br_stack_sz;
+	unsigned int br_stack_pos;
+	bool mispred_all;
 };
 
 /*
@@ -126,13 +134,26 @@ static int thread_stack__grow(struct thread_stack *ts)
 }
 
 static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
-			      struct call_return_processor *crp)
+			      struct call_return_processor *crp,
+			      bool callstack, unsigned int br_stack_sz)
 {
 	int err;
 
-	err = thread_stack__grow(ts);
-	if (err)
-		return err;
+	if (callstack) {
+		err = thread_stack__grow(ts);
+		if (err)
+			return err;
+	}
+
+	if (br_stack_sz) {
+		size_t sz = sizeof(struct branch_stack);
+
+		sz += br_stack_sz * sizeof(struct branch_entry);
+		ts->br_stack_rb = zalloc(sz);
+		if (!ts->br_stack_rb)
+			return -ENOMEM;
+		ts->br_stack_sz = br_stack_sz;
+	}
 
 	if (thread->maps && thread->maps->machine) {
 		struct machine *machine = thread->maps->machine;
@@ -150,7 +171,9 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 }
 
 static struct thread_stack *thread_stack__new(struct thread *thread, int cpu,
-					      struct call_return_processor *crp)
+					      struct call_return_processor *crp,
+					      bool callstack,
+					      unsigned int br_stack_sz)
 {
 	struct thread_stack *ts = thread->ts, *new_ts;
 	unsigned int old_sz = ts ? ts->arr_sz : 0;
@@ -176,7 +199,7 @@ static struct thread_stack *thread_stack__new(struct thread *thread, int cpu,
 		ts += cpu;
 
 	if (!ts->stack &&
-	    thread_stack__init(ts, thread, crp))
+	    thread_stack__init(ts, thread, crp, callstack, br_stack_sz))
 		return NULL;
 
 	return ts;
@@ -319,6 +342,9 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 
 	if (!crp) {
 		ts->cnt = 0;
+		ts->br_stack_pos = 0;
+		if (ts->br_stack_rb)
+			ts->br_stack_rb->nr = 0;
 		return 0;
 	}
 
@@ -353,8 +379,33 @@ int thread_stack__flush(struct thread *thread)
 	return err;
 }
 
+static void thread_stack__update_br_stack(struct thread_stack *ts, u32 flags,
+					  u64 from_ip, u64 to_ip)
+{
+	struct branch_stack *bs = ts->br_stack_rb;
+	struct branch_entry *be;
+
+	if (!ts->br_stack_pos)
+		ts->br_stack_pos = ts->br_stack_sz;
+
+	ts->br_stack_pos -= 1;
+
+	be              = &bs->entries[ts->br_stack_pos];
+	be->from        = from_ip;
+	be->to          = to_ip;
+	be->flags.value = 0;
+	be->flags.abort = !!(flags & PERF_IP_FLAG_TX_ABORT);
+	be->flags.in_tx = !!(flags & PERF_IP_FLAG_IN_TX);
+	/* No support for mispredict */
+	be->flags.mispred = ts->mispred_all;
+
+	if (bs->nr < ts->br_stack_sz)
+		bs->nr += 1;
+}
+
 int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
-			u64 to_ip, u16 insn_len, u64 trace_nr)
+			u64 to_ip, u16 insn_len, u64 trace_nr, bool callstack,
+			unsigned int br_stack_sz, bool mispred_all)
 {
 	struct thread_stack *ts = thread__stack(thread, cpu);
 
@@ -362,12 +413,13 @@ int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 		return -EINVAL;
 
 	if (!ts) {
-		ts = thread_stack__new(thread, cpu, NULL);
+		ts = thread_stack__new(thread, cpu, NULL, callstack, br_stack_sz);
 		if (!ts) {
 			pr_warning("Out of memory: no thread stack\n");
 			return -ENOMEM;
 		}
 		ts->trace_nr = trace_nr;
+		ts->mispred_all = mispred_all;
 	}
 
 	/*
@@ -381,8 +433,14 @@ int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 		ts->trace_nr = trace_nr;
 	}
 
-	/* Stop here if thread_stack__process() is in use */
-	if (ts->crp)
+	if (br_stack_sz)
+		thread_stack__update_br_stack(ts, flags, from_ip, to_ip);
+
+	/*
+	 * Stop here if thread_stack__process() is in use, or not recording call
+	 * stack.
+	 */
+	if (ts->crp || !callstack)
 		return 0;
 
 	if (flags & PERF_IP_FLAG_CALL) {
@@ -430,6 +488,7 @@ static void __thread_stack__free(struct thread *thread, struct thread_stack *ts)
 {
 	__thread_stack__flush(thread, ts);
 	zfree(&ts->stack);
+	zfree(&ts->br_stack_rb);
 }
 
 static void thread_stack__reset(struct thread *thread, struct thread_stack *ts)
@@ -554,6 +613,38 @@ void thread_stack__sample_late(struct thread *thread, int cpu,
 	}
 }
 
+void thread_stack__br_sample(struct thread *thread, int cpu,
+			     struct branch_stack *dst, unsigned int sz)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+	const size_t bsz = sizeof(struct branch_entry);
+	struct branch_stack *src;
+	struct branch_entry *be;
+	unsigned int nr;
+
+	dst->nr = 0;
+
+	if (!ts)
+		return;
+
+	src = ts->br_stack_rb;
+	if (!src->nr)
+		return;
+
+	dst->nr = min((unsigned int)src->nr, sz);
+
+	be = &dst->entries[0];
+	nr = min(ts->br_stack_sz - ts->br_stack_pos, (unsigned int)dst->nr);
+	memcpy(be, &src->entries[ts->br_stack_pos], bsz * nr);
+
+	if (src->nr >= ts->br_stack_sz) {
+		sz -= nr;
+		be = &dst->entries[nr];
+		nr = min(ts->br_stack_pos, sz);
+		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
+	}
+}
+
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
@@ -921,7 +1012,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	}
 
 	if (!ts) {
-		ts = thread_stack__new(thread, sample->cpu, crp);
+		ts = thread_stack__new(thread, sample->cpu, crp, true, 0);
 		if (!ts)
 			return -ENOMEM;
 		ts->comm = comm;
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index 8962ddc4e1ab..c279a0cbbdd0 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -81,13 +81,16 @@ struct call_return_processor {
 };
 
 int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
-			u64 to_ip, u16 insn_len, u64 trace_nr);
+			u64 to_ip, u16 insn_len, u64 trace_nr, bool callstack,
+			unsigned int br_stack_sz, bool mispred_all);
 void thread_stack__set_trace_nr(struct thread *thread, int cpu, u64 trace_nr);
 void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start);
 void thread_stack__sample_late(struct thread *thread, int cpu,
 			       struct ip_callchain *chain, size_t sz, u64 ip,
 			       u64 kernel_start);
+void thread_stack__br_sample(struct thread *thread, int cpu,
+			     struct branch_stack *dst, unsigned int sz);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
-- 
2.17.1

