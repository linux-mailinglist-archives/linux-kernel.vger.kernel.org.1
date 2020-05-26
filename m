Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0E19EDD3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 22:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgDEUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 16:14:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDEUOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:14:21 -0400
IronPort-SDR: kj5kycIH0o+G1KdpwwM1ZeLNc7kcNf3RTQYzRZteKaqScPBRWC5h/5tRxuw3gmwhi4OjDxSFGq
 hQ4bmhW5APaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:14:20 -0700
IronPort-SDR: JOq12exeXH/QcNI5i+batB0cXdBgcwSLFEFRugS3Qts5aAYOOBaJ68BmSq95G2nv7N07Z0NRwY
 PGBmEQs/dGzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688348"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:14:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V6 01/15] perf: Add perf text poke event
Date:   Sun,  5 Apr 2020 23:13:13 +0300
Message-Id: <20200405201327.7332-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record (single instruction) changes to the kernel text (i.e.
self-modifying code) in order to support tracers like Intel PT and
ARM CoreSight.

A copy of the running kernel code is needed as a reference point (e.g.
from /proc/kcore). The text poke event records the old bytes and the
new bytes so that the event can be processed forwards or backwards.

The basic problem is recording the modified instruction in an
unambiguous manner given SMP instruction cache (in)coherence. That is,
when modifying an instruction concurrently any solution with one or
multiple timestamps is not sufficient:

	CPU0				CPU1
 0
 1	write insn A
 2					execute insn A
 3	sync-I$
 4

Due to I$, CPU1 might execute either the old or new A. No matter where
we record tracepoints on CPU0, one simply cannot tell what CPU1 will
have observed, except that at 0 it must be the old one and at 4 it
must be the new one.

To solve this, take inspiration from x86 text poking, which has to
solve this exact problem due to variable length instruction encoding
and I-fetch windows.

 1) overwrite the instruction with a breakpoint and sync I$

This guarantees that that code flow will never hit the target
instruction anymore, on any CPU (or rather, it will cause an
exception).

 2) issue the TEXT_POKE event

 3) overwrite the breakpoint with the new instruction and sync I$

Now we know that any execution after the TEXT_POKE event will either
observe the breakpoint (and hit the exception) or the new instruction.

So by guarding the TEXT_POKE event with an exception on either side;
we can now tell, without doubt, which instruction another CPU will
have observed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/perf_event.h      |  8 +++
 include/uapi/linux/perf_event.h | 21 +++++++-
 kernel/events/core.c            | 90 ++++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9c3e7619c929..2d6e05d601f6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1232,6 +1232,9 @@ extern void perf_event_exec(void);
 extern void perf_event_comm(struct task_struct *tsk, bool exec);
 extern void perf_event_namespaces(struct task_struct *tsk);
 extern void perf_event_fork(struct task_struct *tsk);
+extern void perf_event_text_poke(const void *addr,
+				 const void *old_bytes, size_t old_len,
+				 const void *new_bytes, size_t new_len);
 
 /* Callchains */
 DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
@@ -1482,6 +1485,11 @@ static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
 static inline void perf_event_fork(struct task_struct *tsk)		{ }
+static inline void perf_event_text_poke(const void *addr,
+					const void *old_bytes,
+					size_t old_len,
+					const void *new_bytes,
+					size_t new_len)			{ }
 static inline void perf_event_init(void)				{ }
 static inline int  perf_swevent_get_recursion_context(void)		{ return -1; }
 static inline void perf_swevent_put_recursion_context(int rctx)		{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7b2d6fc9e6ed..e5bee6c17b86 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -383,7 +383,8 @@ struct perf_event_attr {
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
-				__reserved_1   : 31;
+				text_poke      :  1, /* include text poke events */
+				__reserved_1   : 30;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1024,6 +1025,24 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_CGROUP			= 19,
 
+	/*
+	 * Records changes to kernel text i.e. self-modified code. 'old_len' is
+	 * the number of old bytes, 'new_len' is the number of new bytes. Either
+	 * 'old_len' or 'new_len' may be zero to indicate, for example, the
+	 * addition or removal of a trampoline. 'bytes' contains the old bytes
+	 * followed immediately by the new bytes.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u16				old_len;
+	 *	u16				new_len;
+	 *	u8				bytes[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_TEXT_POKE			= 20,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1569979c8912..7ecc932f4845 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -388,6 +388,7 @@ static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
+static atomic_t nr_text_poke_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4554,7 +4555,7 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch ||
+	    attr->context_switch || attr->text_poke ||
 	    attr->bpf_event)
 		return true;
 	return false;
@@ -4630,6 +4631,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_dec(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_dec(&nr_text_poke_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -8598,6 +8601,89 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
 }
 
+struct perf_text_poke_event {
+	const void		*old_bytes;
+	const void		*new_bytes;
+	size_t			pad;
+	u16			old_len;
+	u16			new_len;
+
+	struct {
+		struct perf_event_header	header;
+
+		u64				addr;
+	} event_id;
+};
+
+static int perf_event_text_poke_match(struct perf_event *event)
+{
+	return event->attr.text_poke;
+}
+
+static void perf_event_text_poke_output(struct perf_event *event, void *data)
+{
+	struct perf_text_poke_event *text_poke_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	u64 padding = 0;
+	int ret;
+
+	if (!perf_event_text_poke_match(event))
+		return;
+
+	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
+
+	ret = perf_output_begin(&handle, event, text_poke_event->event_id.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, text_poke_event->event_id);
+	perf_output_put(&handle, text_poke_event->old_len);
+	perf_output_put(&handle, text_poke_event->new_len);
+
+	__output_copy(&handle, text_poke_event->old_bytes, text_poke_event->old_len);
+	__output_copy(&handle, text_poke_event->new_bytes, text_poke_event->new_len);
+
+	if (text_poke_event->pad)
+		__output_copy(&handle, &padding, text_poke_event->pad);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
+void perf_event_text_poke(const void *addr, const void *old_bytes,
+			  size_t old_len, const void *new_bytes, size_t new_len)
+{
+	struct perf_text_poke_event text_poke_event;
+	size_t tot, pad;
+
+	if (!atomic_read(&nr_text_poke_events))
+		return;
+
+	tot  = sizeof(text_poke_event.old_len) + old_len;
+	tot += sizeof(text_poke_event.new_len) + new_len;
+	pad  = ALIGN(tot, sizeof(u64)) - tot;
+
+	text_poke_event = (struct perf_text_poke_event){
+		.old_bytes    = old_bytes,
+		.new_bytes    = new_bytes,
+		.pad          = pad,
+		.old_len      = old_len,
+		.new_len      = new_len,
+		.event_id  = {
+			.header = {
+				.type = PERF_RECORD_TEXT_POKE,
+				.misc = PERF_RECORD_MISC_KERNEL,
+				.size = sizeof(text_poke_event.event_id) + tot + pad,
+			},
+			.addr = (unsigned long)addr,
+		},
+	};
+
+	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -10917,6 +11003,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_inc(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_inc(&nr_text_poke_events);
 
 	if (inc) {
 		/*
-- 
2.17.1

