Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC6302D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbhAYU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbhAYTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:46:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35EC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:45:17 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611603915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmzwfzchnYRW6siBme/ijZ5NVRhJycrcB3k96ppB1Vw=;
        b=cmTVLIB6u9/WQFsS2YSoDS7Dk8DJAD2SBQobB58v9FoTXeiROxNLFq2QcCy2ZB8UcTKRyZ
        yRGz97ZcEkrM7W52ZRZC2cG3VqzzuJ7c/Q9om/h2op6DUJYUCvGTQGo5uCvhCeqQV0ZDRV
        eHFAygj/xCJYu92PEC5EEkJtTlK0VEPwAEN1OZZ5Nf8lOmuf3mSZpS1LBpykxEJmsmUQ91
        lbMTNvqFOa1Off/H5WiNdkHZrbOJ9u6gEfaUer9WT6zPUrG0Z4l800F91vEs/p6s+j8m3H
        WXr00atwPxeHQXW3hQUyFz6+R5u+74HJO95HN7B148S0gNdRN42k+dQJc5sBvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611603915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmzwfzchnYRW6siBme/ijZ5NVRhJycrcB3k96ppB1Vw=;
        b=V9vgakQm3mxqGSvySMmeZPAgkVQ7xIP5hsFWVJ3mhIsCzcZfj5mQjjb63IALZMB+1h8hNd
        qezx+cVQf11ad7DQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] tracing: Merge irqflags + preempt counter.
Date:   Mon, 25 Jan 2021 20:45:08 +0100
Message-Id: <20210125194511.3924915-2-bigeasy@linutronix.de>
In-Reply-To: <20210125194511.3924915-1-bigeasy@linutronix.de>
References: <20210125140323.6b1ff20c@gandalf.local.home>
 <20210125194511.3924915-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state of the interrupts (irqflags) and the preemption counter are
both passed down to tracing_generic_entry_update(). Only one bit of
irqflags is actually required: The on/off state. The complete 32bit
of the preemption counter isn't needed. Just whether of the upper bits
(softirq, hardirq and NMI) are set and the preemption depth is needed.

The irqflags and the preemption counter could be evaluated early and the
information stored in an integer `trace_ctx'.
tracing_generic_entry_update() would use the upper bits as the
TRACE_FLAG_* and the lower 8bit as the disabled-preemption depth
(considering that one must be substracted from the counter in one
special cases).

The actual preemption value is not used except for the tracing record.
The `irqflags' variable is mostly used only for the tracing record. An
exception here is for instance wakeup_tracer_call() or
probe_wakeup_sched_switch() which explicilty disable interrupts and use
that `irqflags' to save (and restore) the IRQ state and to record the
state.

Struct trace_event_buffer has also the `pc' and flags' members which can
be replaced with `trace_ctx' since their actual value is not used
outside of trace recording.

This will reduce tracing_generic_entry_update() to simply assign values
to struct trace_entry. The evaluation of the TRACE_FLAG_* bits is moved
to _tracing_gen_ctx_flags() which replaces preempt_count() and
local_save_flags() invocations.

As an example, ftrace_syscall_enter() may invoke:
- trace_buffer_lock_reserve() -> =E2=80=A6 -> tracing_generic_entry_update()
- event_trigger_unlock_commit()
  -> ftrace_trace_stack() -> =E2=80=A6 -> tracing_generic_entry_update()
  -> ftrace_trace_userstack() -> =E2=80=A6 -> tracing_generic_entry_update()

In this case the TRACE_FLAG_* bits were evaluated three times. By using
the `trace_ctx' they are evaluated once and assigned three times.

A build with all tracers enabled on x86-64 with and without the patch:

    text     data      bss      dec      hex    filename
21970669 17084168  7639260 46694097  2c87ed1 vmlinux.old
21970293 17084168  7639260 46693721  2c87d59 vmlinux.new

text shrank by 379 bytes, data remained constant.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/trace_events.h         |  25 +++-
 kernel/trace/blktrace.c              |  17 +--
 kernel/trace/trace.c                 | 208 ++++++++++++++-------------
 kernel/trace/trace.h                 |  38 +++--
 kernel/trace/trace_branch.c          |   6 +-
 kernel/trace/trace_event_perf.c      |   5 +-
 kernel/trace/trace_events.c          |  18 +--
 kernel/trace/trace_events_inject.c   |   6 +-
 kernel/trace/trace_functions.c       |  28 ++--
 kernel/trace/trace_functions_graph.c |  32 ++---
 kernel/trace/trace_hwlat.c           |   7 +-
 kernel/trace/trace_irqsoff.c         |  86 +++++------
 kernel/trace/trace_kprobe.c          |  10 +-
 kernel/trace/trace_mmiotrace.c       |  14 +-
 kernel/trace/trace_sched_wakeup.c    |  71 +++++----
 kernel/trace/trace_syscalls.c        |  20 ++-
 kernel/trace/trace_uprobe.c          |   4 +-
 17 files changed, 287 insertions(+), 308 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d321fe5ad1a14..091250b0895a3 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -148,17 +148,29 @@ enum print_line_t {
=20
 enum print_line_t trace_handle_return(struct trace_seq *s);
=20
-void tracing_generic_entry_update(struct trace_entry *entry,
-				  unsigned short type,
-				  unsigned long flags,
-				  int pc);
+static inline void tracing_generic_entry_update(struct trace_entry *entry,
+						unsigned short type,
+						unsigned int trace_ctx)
+{
+	struct task_struct *tsk =3D current;
+
+	entry->preempt_count		=3D trace_ctx & 0xff;
+	entry->pid			=3D (tsk) ? tsk->pid : 0;
+	entry->type			=3D type;
+	entry->flags =3D			trace_ctx >> 16;
+}
+
+unsigned int tracing_gen_ctx_flags(unsigned long irqflags);
+unsigned int tracing_gen_ctx(void);
+unsigned int tracing_gen_ctx_dec(void);
+
 struct trace_event_file;
=20
 struct ring_buffer_event *
 trace_event_buffer_lock_reserve(struct trace_buffer **current_buffer,
 				struct trace_event_file *trace_file,
 				int type, unsigned long len,
-				unsigned long flags, int pc);
+				unsigned int trace_ctx);
=20
 #define TRACE_RECORD_CMDLINE	BIT(0)
 #define TRACE_RECORD_TGID	BIT(1)
@@ -232,8 +244,7 @@ struct trace_event_buffer {
 	struct ring_buffer_event	*event;
 	struct trace_event_file		*trace_file;
 	void				*entry;
-	unsigned long			flags;
-	int				pc;
+	unsigned int			trace_ctx;
 	struct pt_regs			*regs;
 };
=20
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fb0fe4c66b84a..c54eae2ab208c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -72,17 +72,17 @@ static void trace_note(struct blk_trace *bt, pid_t pid,=
 int action,
 	struct blk_io_trace *t;
 	struct ring_buffer_event *event =3D NULL;
 	struct trace_buffer *buffer =3D NULL;
-	int pc =3D 0;
+	unsigned int trace_ctx =3D 0;
 	int cpu =3D smp_processor_id();
 	bool blk_tracer =3D blk_tracer_enabled;
 	ssize_t cgid_len =3D cgid ? sizeof(cgid) : 0;
=20
 	if (blk_tracer) {
 		buffer =3D blk_tr->array_buffer.buffer;
-		pc =3D preempt_count();
+		trace_ctx =3D tracing_gen_ctx_flags(0);
 		event =3D trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + len + cgid_len,
-						  0, pc);
+						  trace_ctx);
 		if (!event)
 			return;
 		t =3D ring_buffer_event_data(event);
@@ -107,7 +107,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid,=
 int action,
 		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);
=20
 		if (blk_tracer)
-			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+			trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 	}
 }
=20
@@ -222,8 +222,9 @@ static void __blk_add_trace(struct blk_trace *bt, secto=
r_t sector, int bytes,
 	struct blk_io_trace *t;
 	unsigned long flags =3D 0;
 	unsigned long *sequence;
+	unsigned int trace_ctx =3D 0;
 	pid_t pid;
-	int cpu, pc =3D 0;
+	int cpu;
 	bool blk_tracer =3D blk_tracer_enabled;
 	ssize_t cgid_len =3D cgid ? sizeof(cgid) : 0;
=20
@@ -252,10 +253,10 @@ static void __blk_add_trace(struct blk_trace *bt, sec=
tor_t sector, int bytes,
 		tracing_record_cmdline(current);
=20
 		buffer =3D blk_tr->array_buffer.buffer;
-		pc =3D preempt_count();
+		trace_ctx =3D tracing_gen_ctx_flags(0);
 		event =3D trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  sizeof(*t) + pdu_len + cgid_len,
-						  0, pc);
+						  trace_ctx);
 		if (!event)
 			return;
 		t =3D ring_buffer_event_data(event);
@@ -301,7 +302,7 @@ static void __blk_add_trace(struct blk_trace *bt, secto=
r_t sector, int bytes,
 			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
=20
 		if (blk_tracer) {
-			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+			trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 			return;
 		}
 	}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8a2d786b503a..d3c3bb58cf022 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -176,7 +176,7 @@ static union trace_eval_map_item *trace_eval_maps;
 int tracing_set_tracer(struct trace_array *tr, const char *buf);
 static void ftrace_trace_userstack(struct trace_array *tr,
 				   struct trace_buffer *buffer,
-				   unsigned long flags, int pc);
+				   unsigned int trace_ctx);
=20
 #define MAX_TRACER_SIZE		100
 static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
@@ -905,23 +905,23 @@ static inline void trace_access_lock_init(void)
=20
 #ifdef CONFIG_STACKTRACE
 static void __ftrace_trace_stack(struct trace_buffer *buffer,
-				 unsigned long flags,
-				 int skip, int pc, struct pt_regs *regs);
+				 unsigned int trace_ctx,
+				 int skip, struct pt_regs *regs);
 static inline void ftrace_trace_stack(struct trace_array *tr,
 				      struct trace_buffer *buffer,
-				      unsigned long flags,
-				      int skip, int pc, struct pt_regs *regs);
+				      unsigned int trace_ctx,
+				      int skip, struct pt_regs *regs);
=20
 #else
 static inline void __ftrace_trace_stack(struct trace_buffer *buffer,
-					unsigned long flags,
-					int skip, int pc, struct pt_regs *regs)
+					unsigned int trace_ctx,
+					int skip, struct pt_regs *regs)
 {
 }
 static inline void ftrace_trace_stack(struct trace_array *tr,
 				      struct trace_buffer *buffer,
-				      unsigned long flags,
-				      int skip, int pc, struct pt_regs *regs)
+				      unsigned long trace_ctx,
+				      int skip, struct pt_regs *regs)
 {
 }
=20
@@ -929,24 +929,24 @@ static inline void ftrace_trace_stack(struct trace_ar=
ray *tr,
=20
 static __always_inline void
 trace_event_setup(struct ring_buffer_event *event,
-		  int type, unsigned long flags, int pc)
+		  int type, unsigned int trace_ctx)
 {
 	struct trace_entry *ent =3D ring_buffer_event_data(event);
=20
-	tracing_generic_entry_update(ent, type, flags, pc);
+	tracing_generic_entry_update(ent, type, trace_ctx);
 }
=20
 static __always_inline struct ring_buffer_event *
 __trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
 			  unsigned long len,
-			  unsigned long flags, int pc)
+			  unsigned int trace_ctx)
 {
 	struct ring_buffer_event *event;
=20
 	event =3D ring_buffer_lock_reserve(buffer, len);
 	if (event !=3D NULL)
-		trace_event_setup(event, type, flags, pc);
+		trace_event_setup(event, type, trace_ctx);
=20
 	return event;
 }
@@ -1007,25 +1007,22 @@ int __trace_puts(unsigned long ip, const char *str,=
 int size)
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct print_entry *entry;
-	unsigned long irq_flags;
+	unsigned int trace_ctx;
 	int alloc;
-	int pc;
=20
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
 		return 0;
=20
-	pc =3D preempt_count();
-
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
=20
 	alloc =3D sizeof(*entry) + size + 2; /* possible \n added */
=20
-	local_save_flags(irq_flags);
+	trace_ctx =3D tracing_gen_ctx();
 	buffer =3D global_trace.array_buffer.buffer;
 	ring_buffer_nest_start(buffer);
-	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,=20
-					    irq_flags, pc);
+	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
+					    trace_ctx);
 	if (!event) {
 		size =3D 0;
 		goto out;
@@ -1044,7 +1041,7 @@ int __trace_puts(unsigned long ip, const char *str, i=
nt size)
 		entry->buf[size] =3D '\0';
=20
 	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(&global_trace, buffer, irq_flags, 4, pc, NULL);
+	ftrace_trace_stack(&global_trace, buffer, trace_ctx, 4, NULL);
  out:
 	ring_buffer_nest_end(buffer);
 	return size;
@@ -1061,25 +1058,22 @@ int __trace_bputs(unsigned long ip, const char *str)
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct bputs_entry *entry;
-	unsigned long irq_flags;
+	unsigned int trace_ctx;
 	int size =3D sizeof(struct bputs_entry);
 	int ret =3D 0;
-	int pc;
=20
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
 		return 0;
=20
-	pc =3D preempt_count();
-
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
=20
-	local_save_flags(irq_flags);
+	trace_ctx =3D tracing_gen_ctx();
 	buffer =3D global_trace.array_buffer.buffer;
=20
 	ring_buffer_nest_start(buffer);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
-					    irq_flags, pc);
+					    trace_ctx);
 	if (!event)
 		goto out;
=20
@@ -1088,7 +1082,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	entry->str			=3D str;
=20
 	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(&global_trace, buffer, irq_flags, 4, pc, NULL);
+	ftrace_trace_stack(&global_trace, buffer, trace_ctx, 4, NULL);
=20
 	ret =3D 1;
  out:
@@ -2584,36 +2578,69 @@ enum print_line_t trace_handle_return(struct trace_=
seq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
=20
-void
-tracing_generic_entry_update(struct trace_entry *entry, unsigned short typ=
e,
-			     unsigned long flags, int pc)
+unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
-	struct task_struct *tsk =3D current;
+	unsigned int trace_flags =3D 0;
+	unsigned int pc;
+
+	pc =3D preempt_count();
=20
-	entry->preempt_count		=3D pc & 0xff;
-	entry->pid			=3D (tsk) ? tsk->pid : 0;
-	entry->type			=3D type;
-	entry->flags =3D
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
+	if (irqs_disabled_flags(irqflags))
+		trace_flags |=3D TRACE_FLAG_IRQS_OFF;
 #else
-		TRACE_FLAG_IRQS_NOSUPPORT |
+	trace_flags |=3D TRACE_FLAG_IRQS_NOSUPPORT;
 #endif
-		((pc & NMI_MASK    ) ? TRACE_FLAG_NMI     : 0) |
-		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
-		((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0) |
-		(tif_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0) |
-		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
+
+	if (pc & NMI_MASK)
+		trace_flags |=3D TRACE_FLAG_NMI;
+	if (pc & HARDIRQ_MASK)
+		trace_flags |=3D TRACE_FLAG_HARDIRQ;
+
+	if (pc & SOFTIRQ_OFFSET)
+		trace_flags |=3D TRACE_FLAG_SOFTIRQ;
+
+	if (tif_need_resched())
+		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
+	if (test_preempt_need_resched())
+		trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
+	return (trace_flags << 16) | (pc & 0xff);
+}
+
+unsigned int tracing_gen_ctx(void)
+{
+	unsigned long irqflags;
+
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+	local_save_flags(irqflags);
+#else
+	irqflags =3D 0;
+#endif
+	return tracing_gen_ctx_flags(irqflags);
+}
+
+unsigned int tracing_gen_ctx_dec(void)
+{
+	unsigned int trace_ctx;
+
+	trace_ctx =3D tracing_gen_ctx();
+
+	/*
+	 * Subtract one from the preeption counter if preemption is enabled,
+	 * see trace_event_buffer_reserve()for details.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		trace_ctx--;
+	return trace_ctx;
 }
-EXPORT_SYMBOL_GPL(tracing_generic_entry_update);
=20
 struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
 			  unsigned long len,
-			  unsigned long flags, int pc)
+			  unsigned int trace_ctx)
 {
-	return __trace_buffer_lock_reserve(buffer, type, len, flags, pc);
+	return __trace_buffer_lock_reserve(buffer, type, len, trace_ctx);
 }
=20
 DEFINE_PER_CPU(struct ring_buffer_event *, trace_buffered_event);
@@ -2733,7 +2760,7 @@ struct ring_buffer_event *
 trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 			  struct trace_event_file *trace_file,
 			  int type, unsigned long len,
-			  unsigned long flags, int pc)
+			  unsigned int trace_ctx)
 {
 	struct ring_buffer_event *entry;
 	int val;
@@ -2746,15 +2773,15 @@ trace_event_buffer_lock_reserve(struct trace_buffer=
 **current_rb,
 		/* Try to use the per cpu buffer first */
 		val =3D this_cpu_inc_return(trace_buffered_event_cnt);
 		if (val =3D=3D 1) {
-			trace_event_setup(entry, type, flags, pc);
+			trace_event_setup(entry, type, trace_ctx);
 			entry->array[0] =3D len;
 			return entry;
 		}
 		this_cpu_dec(trace_buffered_event_cnt);
 	}
=20
-	entry =3D __trace_buffer_lock_reserve(*current_rb,
-					    type, len, flags, pc);
+	entry =3D __trace_buffer_lock_reserve(*current_rb, type, len,
+					    trace_ctx);
 	/*
 	 * If tracing is off, but we have triggers enabled
 	 * we still need to look at the event data. Use the temp_buffer
@@ -2763,8 +2790,8 @@ trace_event_buffer_lock_reserve(struct trace_buffer *=
*current_rb,
 	 */
 	if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
 		*current_rb =3D temp_buffer;
-		entry =3D __trace_buffer_lock_reserve(*current_rb,
-						    type, len, flags, pc);
+		entry =3D __trace_buffer_lock_reserve(*current_rb, type, len,
+						    trace_ctx);
 	}
 	return entry;
 }
@@ -2850,7 +2877,7 @@ void trace_event_buffer_commit(struct trace_event_buf=
fer *fbuffer)
 		ftrace_exports(fbuffer->event, TRACE_EXPORT_EVENT);
 	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
-				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
+				    fbuffer->trace_ctx, fbuffer->regs);
 }
 EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
=20
@@ -2866,7 +2893,7 @@ EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 				     struct trace_buffer *buffer,
 				     struct ring_buffer_event *event,
-				     unsigned long flags, int pc,
+				     unsigned int trace_ctx,
 				     struct pt_regs *regs)
 {
 	__buffer_unlock_commit(buffer, event);
@@ -2877,8 +2904,8 @@ void trace_buffer_unlock_commit_regs(struct trace_arr=
ay *tr,
 	 * and mmiotrace, but that's ok if they lose a function or
 	 * two. They are not that meaningful.
 	 */
-	ftrace_trace_stack(tr, buffer, flags, regs ? 0 : STACK_SKIP, pc, regs);
-	ftrace_trace_userstack(tr, buffer, flags, pc);
+	ftrace_trace_stack(tr, buffer, trace_ctx, regs ? 0 : STACK_SKIP, regs);
+	ftrace_trace_userstack(tr, buffer, trace_ctx);
 }
=20
 /*
@@ -2892,9 +2919,8 @@ trace_buffer_unlock_commit_nostack(struct trace_buffe=
r *buffer,
 }
=20
 void
-trace_function(struct trace_array *tr,
-	       unsigned long ip, unsigned long parent_ip, unsigned long flags,
-	       int pc)
+trace_function(struct trace_array *tr, unsigned long ip, unsigned long
+	       parent_ip, unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_function;
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
@@ -2902,7 +2928,7 @@ trace_function(struct trace_array *tr,
 	struct ftrace_entry *entry;
=20
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_FN, sizeof(*entry),
-					    flags, pc);
+					    trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -2936,8 +2962,8 @@ static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_st=
acks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
=20
 static void __ftrace_trace_stack(struct trace_buffer *buffer,
-				 unsigned long flags,
-				 int skip, int pc, struct pt_regs *regs)
+				 unsigned int trace_ctx,
+				 int skip, struct pt_regs *regs)
 {
 	struct trace_event_call *call =3D &event_kernel_stack;
 	struct ring_buffer_event *event;
@@ -2984,7 +3010,7 @@ static void __ftrace_trace_stack(struct trace_buffer =
*buffer,
=20
 	size =3D nr_entries * sizeof(unsigned long);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-					    sizeof(*entry) + size, flags, pc);
+					    sizeof(*entry) + size, trace_ctx);
 	if (!event)
 		goto out;
 	entry =3D ring_buffer_event_data(event);
@@ -3005,22 +3031,22 @@ static void __ftrace_trace_stack(struct trace_buffe=
r *buffer,
=20
 static inline void ftrace_trace_stack(struct trace_array *tr,
 				      struct trace_buffer *buffer,
-				      unsigned long flags,
-				      int skip, int pc, struct pt_regs *regs)
+				      unsigned int trace_ctx,
+				      int skip, struct pt_regs *regs)
 {
 	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
 		return;
=20
-	__ftrace_trace_stack(buffer, flags, skip, pc, regs);
+	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
 }
=20
-void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
-		   int pc)
+void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
+		   int skip)
 {
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
=20
 	if (rcu_is_watching()) {
-		__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
+		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
 		return;
 	}
=20
@@ -3034,7 +3060,7 @@ void __trace_stack(struct trace_array *tr, unsigned l=
ong flags, int skip,
 		return;
=20
 	rcu_irq_enter_irqson();
-	__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
+	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
 	rcu_irq_exit_irqson();
 }
=20
@@ -3044,19 +3070,15 @@ void __trace_stack(struct trace_array *tr, unsigned=
 long flags, int skip,
  */
 void trace_dump_stack(int skip)
 {
-	unsigned long flags;
-
 	if (tracing_disabled || tracing_selftest_running)
 		return;
=20
-	local_save_flags(flags);
-
 #ifndef CONFIG_UNWINDER_ORC
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
 	__ftrace_trace_stack(global_trace.array_buffer.buffer,
-			     flags, skip, preempt_count(), NULL);
+			     tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
=20
@@ -3065,7 +3087,7 @@ static DEFINE_PER_CPU(int, user_stack_count);
=20
 static void
 ftrace_trace_userstack(struct trace_array *tr,
-		       struct trace_buffer *buffer, unsigned long flags, int pc)
+		       struct trace_buffer *buffer, unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_user_stack;
 	struct ring_buffer_event *event;
@@ -3092,7 +3114,7 @@ ftrace_trace_userstack(struct trace_array *tr,
 	__this_cpu_inc(user_stack_count);
=20
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_USER_STACK,
-					    sizeof(*entry), flags, pc);
+					    sizeof(*entry), trace_ctx);
 	if (!event)
 		goto out_drop_count;
 	entry	=3D ring_buffer_event_data(event);
@@ -3112,7 +3134,7 @@ ftrace_trace_userstack(struct trace_array *tr,
 #else /* CONFIG_USER_STACKTRACE_SUPPORT */
 static void ftrace_trace_userstack(struct trace_array *tr,
 				   struct trace_buffer *buffer,
-				   unsigned long flags, int pc)
+				   unsigned int trace_ctx)
 {
 }
 #endif /* !CONFIG_USER_STACKTRACE_SUPPORT */
@@ -3242,9 +3264,9 @@ int trace_vbprintk(unsigned long ip, const char *fmt,=
 va_list args)
 	struct trace_buffer *buffer;
 	struct trace_array *tr =3D &global_trace;
 	struct bprint_entry *entry;
-	unsigned long flags;
+	unsigned int trace_ctx;
 	char *tbuffer;
-	int len =3D 0, size, pc;
+	int len =3D 0, size;
=20
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
@@ -3252,7 +3274,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt,=
 va_list args)
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
 	preempt_disable_notrace();
=20
 	tbuffer =3D get_trace_buf();
@@ -3266,12 +3288,11 @@ int trace_vbprintk(unsigned long ip, const char *fm=
t, va_list args)
 	if (len > TRACE_BUF_SIZE/sizeof(int) || len < 0)
 		goto out_put;
=20
-	local_save_flags(flags);
 	size =3D sizeof(*entry) + sizeof(u32) * len;
 	buffer =3D tr->array_buffer.buffer;
 	ring_buffer_nest_start(buffer);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
-					    flags, pc);
+					    trace_ctx);
 	if (!event)
 		goto out;
 	entry =3D ring_buffer_event_data(event);
@@ -3281,7 +3302,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt,=
 va_list args)
 	memcpy(entry->buf, tbuffer, sizeof(u32) * len);
 	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(tr, buffer, flags, 6, pc, NULL);
+		ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
 	}
=20
 out:
@@ -3304,9 +3325,9 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 {
 	struct trace_event_call *call =3D &event_print;
 	struct ring_buffer_event *event;
-	int len =3D 0, size, pc;
+	int len =3D 0, size;
 	struct print_entry *entry;
-	unsigned long flags;
+	unsigned int trace_ctx;
 	char *tbuffer;
=20
 	if (tracing_disabled || tracing_selftest_running)
@@ -3315,7 +3336,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	/* Don't pollute graph traces with trace_vprintk internals */
 	pause_graph_tracing();
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
 	preempt_disable_notrace();
=20
=20
@@ -3327,11 +3348,10 @@ __trace_array_vprintk(struct trace_buffer *buffer,
=20
 	len =3D vscnprintf(tbuffer, TRACE_BUF_SIZE, fmt, args);
=20
-	local_save_flags(flags);
 	size =3D sizeof(*entry) + len + 1;
 	ring_buffer_nest_start(buffer);
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    flags, pc);
+					    trace_ctx);
 	if (!event)
 		goto out;
 	entry =3D ring_buffer_event_data(event);
@@ -3340,7 +3360,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	memcpy(&entry->buf, tbuffer, len + 1);
 	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(&global_trace, buffer, flags, 6, pc, NULL);
+		ftrace_trace_stack(&global_trace, buffer, trace_ctx, 6, NULL);
 	}
=20
 out:
@@ -6653,7 +6673,6 @@ tracing_mark_write(struct file *filp, const char __us=
er *ubuf,
 	enum event_trigger_type tt =3D ETT_NONE;
 	struct trace_buffer *buffer;
 	struct print_entry *entry;
-	unsigned long irq_flags;
 	ssize_t written;
 	int size;
 	int len;
@@ -6673,7 +6692,6 @@ tracing_mark_write(struct file *filp, const char __us=
er *ubuf,
=20
 	BUILD_BUG_ON(TRACE_BUF_SIZE >=3D PAGE_SIZE);
=20
-	local_save_flags(irq_flags);
 	size =3D sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
=20
 	/* If less than "<faulted>", then make sure we can still add that */
@@ -6682,7 +6700,7 @@ tracing_mark_write(struct file *filp, const char __us=
er *ubuf,
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    irq_flags, preempt_count());
+					    tracing_gen_ctx());
 	if (unlikely(!event))
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
@@ -6734,7 +6752,6 @@ tracing_mark_raw_write(struct file *filp, const char =
__user *ubuf,
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct raw_data_entry *entry;
-	unsigned long irq_flags;
 	ssize_t written;
 	int size;
 	int len;
@@ -6756,14 +6773,13 @@ tracing_mark_raw_write(struct file *filp, const cha=
r __user *ubuf,
=20
 	BUILD_BUG_ON(TRACE_BUF_SIZE >=3D PAGE_SIZE);
=20
-	local_save_flags(irq_flags);
 	size =3D sizeof(*entry) + cnt;
 	if (cnt < FAULT_SIZE_ID)
 		size +=3D FAULT_SIZE_ID - cnt;
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
-					    irq_flags, preempt_count());
+					    tracing_gen_ctx());
 	if (!event)
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e448d2da0b991..8daf3a0758b12 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -589,8 +589,7 @@ struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
 			  unsigned long len,
-			  unsigned long flags,
-			  int pc);
+			  unsigned int trace_ctx);
=20
 struct trace_entry *tracing_get_trace_entry(struct trace_array *tr,
 						struct trace_array_cpu *data);
@@ -615,11 +614,11 @@ unsigned long trace_total_entries(struct trace_array =
*tr);
 void trace_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-		    unsigned long flags, int pc);
+		    unsigned int trace_ctx);
 void trace_graph_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-		    unsigned long flags, int pc);
+		    unsigned int trace_ctx);
 void trace_latency_header(struct seq_file *m);
 void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
@@ -687,11 +686,10 @@ static inline void latency_fsnotify(struct trace_arra=
y *tr) { }
 #endif
=20
 #ifdef CONFIG_STACKTRACE
-void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
-		   int pc);
+void __trace_stack(struct trace_array *tr, unsigned int trace_ctx, int ski=
p);
 #else
-static inline void __trace_stack(struct trace_array *tr, unsigned long fla=
gs,
-				 int skip, int pc)
+static inline void __trace_stack(struct trace_array *tr, unsigned int trac=
e_ctx,
+				 int skip)
 {
 }
 #endif /* CONFIG_STACKTRACE */
@@ -831,10 +829,10 @@ extern void graph_trace_open(struct trace_iterator *i=
ter);
 extern void graph_trace_close(struct trace_iterator *iter);
 extern int __trace_graph_entry(struct trace_array *tr,
 			       struct ftrace_graph_ent *trace,
-			       unsigned long flags, int pc);
+			       unsigned int trace_ctx);
 extern void __trace_graph_return(struct trace_array *tr,
 				 struct ftrace_graph_ret *trace,
-				 unsigned long flags, int pc);
+				 unsigned int trace_ctx);
=20
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
@@ -1297,15 +1295,15 @@ extern int call_filter_check_discard(struct trace_e=
vent_call *call, void *rec,
 void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 				     struct trace_buffer *buffer,
 				     struct ring_buffer_event *event,
-				     unsigned long flags, int pc,
+				     unsigned int trcace_ctx,
 				     struct pt_regs *regs);
=20
 static inline void trace_buffer_unlock_commit(struct trace_array *tr,
 					      struct trace_buffer *buffer,
 					      struct ring_buffer_event *event,
-					      unsigned long flags, int pc)
+					      unsigned int trace_ctx)
 {
-	trace_buffer_unlock_commit_regs(tr, buffer, event, flags, pc, NULL);
+	trace_buffer_unlock_commit_regs(tr, buffer, event, trace_ctx, NULL);
 }
=20
 DECLARE_PER_CPU(struct ring_buffer_event *, trace_buffered_event);
@@ -1366,8 +1364,7 @@ __event_trigger_test_discard(struct trace_event_file =
*file,
  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself
- * @irq_flags: The state of the interrupts at the start of the event
- * @pc: The state of the preempt count at the start of the event.
+ * @trace_ctx: The tracing context flags.
  *
  * This is a helper function to handle triggers that require data
  * from the event itself. It also tests the event against filters and
@@ -1377,12 +1374,12 @@ static inline void
 event_trigger_unlock_commit(struct trace_event_file *file,
 			    struct trace_buffer *buffer,
 			    struct ring_buffer_event *event,
-			    void *entry, unsigned long irq_flags, int pc)
+			    void *entry, unsigned int trace_ctx)
 {
 	enum event_trigger_type tt =3D ETT_NONE;
=20
 	if (!__event_trigger_test_discard(file, buffer, event, entry, &tt))
-		trace_buffer_unlock_commit(file->tr, buffer, event, irq_flags, pc);
+		trace_buffer_unlock_commit(file->tr, buffer, event, trace_ctx);
=20
 	if (tt)
 		event_triggers_post_call(file, tt);
@@ -1394,8 +1391,7 @@ event_trigger_unlock_commit(struct trace_event_file *=
file,
  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself
- * @irq_flags: The state of the interrupts at the start of the event
- * @pc: The state of the preempt count at the start of the event.
+ * @trace_ctx: The tracing context flags.
  *
  * This is a helper function to handle triggers that require data
  * from the event itself. It also tests the event against filters and
@@ -1408,14 +1404,14 @@ static inline void
 event_trigger_unlock_commit_regs(struct trace_event_file *file,
 				 struct trace_buffer *buffer,
 				 struct ring_buffer_event *event,
-				 void *entry, unsigned long irq_flags, int pc,
+				 void *entry, unsigned int trace_ctx,
 				 struct pt_regs *regs)
 {
 	enum event_trigger_type tt =3D ETT_NONE;
=20
 	if (!__event_trigger_test_discard(file, buffer, event, entry, &tt))
 		trace_buffer_unlock_commit_regs(file->tr, buffer, event,
-						irq_flags, pc, regs);
+						trace_ctx, regs);
=20
 	if (tt)
 		event_triggers_post_call(file, tt);
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index eff099123aa27..e47fdb4c92fbc 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -37,7 +37,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int =
val, int expect)
 	struct ring_buffer_event *event;
 	struct trace_branch *entry;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
 	const char *p;
=20
 	if (current->trace_recursion & TRACE_BRANCH_BIT)
@@ -59,10 +59,10 @@ probe_likely_condition(struct ftrace_likely_data *f, in=
t val, int expect)
 	if (atomic_read(&data->disabled))
 		goto out;
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx_flags(flags);
 	buffer =3D tr->array_buffer.buffer;
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_BRANCH,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		goto out;
=20
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_per=
f.c
index a711816559580..288ad2c274fba 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -421,11 +421,8 @@ NOKPROBE_SYMBOL(perf_trace_buf_alloc);
 void perf_trace_buf_update(void *record, u16 type)
 {
 	struct trace_entry *entry =3D record;
-	int pc =3D preempt_count();
-	unsigned long flags;
=20
-	local_save_flags(flags);
-	tracing_generic_entry_update(entry, type, flags, pc);
+	tracing_generic_entry_update(entry, type, tracing_gen_ctx());
 }
 NOKPROBE_SYMBOL(perf_trace_buf_update);
=20
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e9d28eeccb7e6..20ccce3e4ffb9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -258,22 +258,19 @@ void *trace_event_buffer_reserve(struct trace_event_b=
uffer *fbuffer,
 	    trace_event_ignore_this_pid(trace_file))
 		return NULL;
=20
-	local_save_flags(fbuffer->flags);
-	fbuffer->pc =3D preempt_count();
 	/*
 	 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
 	 * preemption (adding one to the preempt_count). Since we are
 	 * interested in the preempt_count at the time the tracepoint was
 	 * hit, we need to subtract one to offset the increment.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		fbuffer->pc--;
+	fbuffer->trace_ctx =3D tracing_gen_ctx_dec();
 	fbuffer->trace_file =3D trace_file;
=20
 	fbuffer->event =3D
 		trace_event_buffer_lock_reserve(&fbuffer->buffer, trace_file,
 						event_call->event.type, len,
-						fbuffer->flags, fbuffer->pc);
+						fbuffer->trace_ctx);
 	if (!fbuffer->event)
 		return NULL;
=20
@@ -3678,12 +3675,11 @@ function_test_events_call(unsigned long ip, unsigne=
d long parent_ip,
 	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct ftrace_entry *entry;
-	unsigned long flags;
+	unsigned int trace_ctx;
 	long disabled;
 	int cpu;
-	int pc;
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
 	preempt_disable_notrace();
 	cpu =3D raw_smp_processor_id();
 	disabled =3D atomic_inc_return(&per_cpu(ftrace_test_event_disable, cpu));
@@ -3691,11 +3687,9 @@ function_test_events_call(unsigned long ip, unsigned=
 long parent_ip,
 	if (disabled !=3D 1)
 		goto out;
=20
-	local_save_flags(flags);
-
 	event =3D trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
 						TRACE_FN, sizeof(*entry),
-						flags, pc);
+						trace_ctx);
 	if (!event)
 		goto out;
 	entry	=3D ring_buffer_event_data(event);
@@ -3703,7 +3697,7 @@ function_test_events_call(unsigned long ip, unsigned =
long parent_ip,
 	entry->parent_ip		=3D parent_ip;
=20
 	event_trigger_unlock_commit(&event_trace_file, buffer, event,
-				    entry, flags, pc);
+				    entry, trace_ctx);
  out:
 	atomic_dec(&per_cpu(ftrace_test_event_disable, cpu));
 	preempt_enable_notrace();
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events=
_inject.c
index 22bcf7c51d1ee..c188045c5f976 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -192,7 +192,6 @@ static void *trace_alloc_entry(struct trace_event_call =
*call, int *size)
 static int parse_entry(char *str, struct trace_event_call *call, void **pe=
ntry)
 {
 	struct ftrace_event_field *field;
-	unsigned long irq_flags;
 	void *entry =3D NULL;
 	int entry_size;
 	u64 val =3D 0;
@@ -203,9 +202,8 @@ static int parse_entry(char *str, struct trace_event_ca=
ll *call, void **pentry)
 	if (!entry)
 		return -ENOMEM;
=20
-	local_save_flags(irq_flags);
-	tracing_generic_entry_update(entry, call->event.type, irq_flags,
-				     preempt_count());
+	tracing_generic_entry_update(entry, call->event.type,
+				     tracing_gen_ctx());
=20
 	while ((len =3D parse_field(str, call, &field, &val)) > 0) {
 		if (is_function_field(field))
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index c5095dd28e20c..9bb03ab44fffc 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -132,10 +132,9 @@ function_trace_call(unsigned long ip, unsigned long pa=
rent_ip,
 {
 	struct trace_array *tr =3D op->private;
 	struct trace_array_cpu *data;
-	unsigned long flags;
+	unsigned int trace_ctx;
 	int bit;
 	int cpu;
-	int pc;
=20
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -144,15 +143,14 @@ function_trace_call(unsigned long ip, unsigned long p=
arent_ip,
 	if (bit < 0)
 		return;
=20
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
 	preempt_disable_notrace();
=20
 	cpu =3D smp_processor_id();
 	data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
-	if (!atomic_read(&data->disabled)) {
-		local_save_flags(flags);
-		trace_function(tr, ip, parent_ip, flags, pc);
-	}
+	if (!atomic_read(&data->disabled))
+		trace_function(tr, ip, parent_ip, trace_ctx);
+
 	ftrace_test_recursion_unlock(bit);
 	preempt_enable_notrace();
 }
@@ -184,7 +182,7 @@ function_stack_trace_call(unsigned long ip, unsigned lo=
ng parent_ip,
 	unsigned long flags;
 	long disabled;
 	int cpu;
-	int pc;
+	unsigned int trace_ctx;
=20
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -199,9 +197,9 @@ function_stack_trace_call(unsigned long ip, unsigned lo=
ng parent_ip,
 	disabled =3D atomic_inc_return(&data->disabled);
=20
 	if (likely(disabled =3D=3D 1)) {
-		pc =3D preempt_count();
-		trace_function(tr, ip, parent_ip, flags, pc);
-		__trace_stack(tr, flags, STACK_SKIP, pc);
+		trace_ctx =3D tracing_gen_ctx_flags(flags);
+		trace_function(tr, ip, parent_ip, trace_ctx);
+		__trace_stack(tr, trace_ctx, STACK_SKIP);
 	}
=20
 	atomic_dec(&data->disabled);
@@ -404,13 +402,11 @@ ftrace_traceoff(unsigned long ip, unsigned long paren=
t_ip,
=20
 static __always_inline void trace_stack(struct trace_array *tr)
 {
-	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
-	local_save_flags(flags);
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
=20
-	__trace_stack(tr, flags, FTRACE_STACK_SKIP, pc);
+	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
 }
=20
 static void
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_func=
tions_graph.c
index d874dec87131a..0aa6e6faa9439 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -96,8 +96,7 @@ print_graph_duration(struct trace_array *tr, unsigned lon=
g long duration,
=20
 int __trace_graph_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
-				unsigned long flags,
-				int pc)
+				unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_funcgraph_entry;
 	struct ring_buffer_event *event;
@@ -105,7 +104,7 @@ int __trace_graph_entry(struct trace_array *tr,
 	struct ftrace_graph_ent_entry *entry;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return 0;
 	entry	=3D ring_buffer_event_data(event);
@@ -129,10 +128,10 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	struct trace_array *tr =3D graph_array;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
 	long disabled;
 	int ret;
 	int cpu;
-	int pc;
=20
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
 		return 0;
@@ -174,8 +173,8 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled =3D atomic_inc_return(&data->disabled);
 	if (likely(disabled =3D=3D 1)) {
-		pc =3D preempt_count();
-		ret =3D __trace_graph_entry(tr, trace, flags, pc);
+		trace_ctx =3D tracing_gen_ctx_flags(flags);
+		ret =3D __trace_graph_entry(tr, trace, trace_ctx);
 	} else {
 		ret =3D 0;
 	}
@@ -188,7 +187,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
=20
 static void
 __trace_graph_function(struct trace_array *tr,
-		unsigned long ip, unsigned long flags, int pc)
+		unsigned long ip, unsigned int trace_ctx)
 {
 	u64 time =3D trace_clock_local();
 	struct ftrace_graph_ent ent =3D {
@@ -202,22 +201,21 @@ __trace_graph_function(struct trace_array *tr,
 		.rettime  =3D time,
 	};
=20
-	__trace_graph_entry(tr, &ent, flags, pc);
-	__trace_graph_return(tr, &ret, flags, pc);
+	__trace_graph_entry(tr, &ent, trace_ctx);
+	__trace_graph_return(tr, &ret, trace_ctx);
 }
=20
 void
 trace_graph_function(struct trace_array *tr,
 		unsigned long ip, unsigned long parent_ip,
-		unsigned long flags, int pc)
+		unsigned int trace_ctx)
 {
-	__trace_graph_function(tr, ip, flags, pc);
+	__trace_graph_function(tr, ip, trace_ctx);
 }
=20
 void __trace_graph_return(struct trace_array *tr,
 				struct ftrace_graph_ret *trace,
-				unsigned long flags,
-				int pc)
+				unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_funcgraph_exit;
 	struct ring_buffer_event *event;
@@ -225,7 +223,7 @@ void __trace_graph_return(struct trace_array *tr,
 	struct ftrace_graph_ret_entry *entry;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RET,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -239,9 +237,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	struct trace_array *tr =3D graph_array;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
 	long disabled;
 	int cpu;
-	int pc;
=20
 	ftrace_graph_addr_finish(trace);
=20
@@ -255,8 +253,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 	data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
 	disabled =3D atomic_inc_return(&data->disabled);
 	if (likely(disabled =3D=3D 1)) {
-		pc =3D preempt_count();
-		__trace_graph_return(tr, trace, flags, pc);
+		trace_ctx =3D tracing_gen_ctx_flags(flags);
+		__trace_graph_return(tr, trace, trace_ctx);
 	}
 	atomic_dec(&data->disabled);
 	local_irq_restore(flags);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index c0df9b97f147d..34dc1a712dcbb 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -108,14 +108,9 @@ static void trace_hwlat_sample(struct hwlat_sample *sa=
mple)
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct hwlat_entry *entry;
-	unsigned long flags;
-	int pc;
-
-	pc =3D preempt_count();
-	local_save_flags(flags);
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_HWLAT, sizeof(*entry),
-					  flags, pc);
+					  tracing_gen_ctx());
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d06aab4dcbb8f..7f36e7de69aa6 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -143,11 +143,14 @@ irqsoff_tracer_call(unsigned long ip, unsigned long p=
arent_ip,
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
=20
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
=20
-	trace_function(tr, ip, parent_ip, flags, preempt_count());
+	trace_ctx =3D tracing_gen_ctx_flags(flags);
+
+	trace_function(tr, ip, parent_ip, trace_ctx);
=20
 	atomic_dec(&data->disabled);
 }
@@ -177,8 +180,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent =
*trace)
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
+	unsigned int trace_ctx;
 	int ret;
-	int pc;
=20
 	if (ftrace_graph_ignore_func(trace))
 		return 0;
@@ -195,8 +198,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent =
*trace)
 	if (!func_prolog_dec(tr, &data, &flags))
 		return 0;
=20
-	pc =3D preempt_count();
-	ret =3D __trace_graph_entry(tr, trace, flags, pc);
+	trace_ctx =3D tracing_gen_ctx_flags(flags);
+	ret =3D __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
=20
 	return ret;
@@ -207,15 +210,15 @@ static void irqsoff_graph_return(struct ftrace_graph_=
ret *trace)
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
 	ftrace_graph_addr_finish(trace);
=20
 	if (!func_prolog_dec(tr, &data, &flags))
 		return;
=20
-	pc =3D preempt_count();
-	__trace_graph_return(tr, trace, flags, pc);
+	trace_ctx =3D tracing_gen_ctx_flags(flags);
+	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 }
=20
@@ -267,12 +270,12 @@ static void irqsoff_print_header(struct seq_file *s)
 static void
 __trace_function(struct trace_array *tr,
 		 unsigned long ip, unsigned long parent_ip,
-		 unsigned long flags, int pc)
+		 unsigned int trace_ctx)
 {
 	if (is_graph(tr))
-		trace_graph_function(tr, ip, parent_ip, flags, pc);
+		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, flags, pc);
+		trace_function(tr, ip, parent_ip, trace_ctx);
 }
=20
 #else
@@ -322,15 +325,13 @@ check_critical_timing(struct trace_array *tr,
 {
 	u64 T0, T1, delta;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
 	T0 =3D data->preempt_timestamp;
 	T1 =3D ftrace_now(cpu);
 	delta =3D T1-T0;
=20
-	local_save_flags(flags);
-
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
=20
 	if (!report_latency(tr, delta))
 		goto out;
@@ -341,9 +342,9 @@ check_critical_timing(struct trace_array *tr,
 	if (!report_latency(tr, delta))
 		goto out_unlock;
=20
-	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+	__trace_function(tr, CALLER_ADDR0, parent_ip, trace_ctx);
 	/* Skip 5 functions to get to the irq/preempt enable function */
-	__trace_stack(tr, flags, 5, pc);
+	__trace_stack(tr, trace_ctx, 5);
=20
 	if (data->critical_sequence !=3D max_sequence)
 		goto out_unlock;
@@ -363,16 +364,15 @@ check_critical_timing(struct trace_array *tr,
 out:
 	data->critical_sequence =3D max_sequence;
 	data->preempt_timestamp =3D ftrace_now(cpu);
-	__trace_function(tr, CALLER_ADDR0, parent_ip, flags, pc);
+	__trace_function(tr, CALLER_ADDR0, parent_ip, trace_ctx);
 }
=20
 static nokprobe_inline void
-start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
+start_critical_timing(unsigned long ip, unsigned long parent_ip)
 {
 	int cpu;
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
=20
 	if (!tracer_enabled || !tracing_is_enabled())
 		return;
@@ -393,9 +393,7 @@ start_critical_timing(unsigned long ip, unsigned long p=
arent_ip, int pc)
 	data->preempt_timestamp =3D ftrace_now(cpu);
 	data->critical_start =3D parent_ip ? : ip;
=20
-	local_save_flags(flags);
-
-	__trace_function(tr, ip, parent_ip, flags, pc);
+	__trace_function(tr, ip, parent_ip, tracing_gen_ctx());
=20
 	per_cpu(tracing_cpu, cpu) =3D 1;
=20
@@ -403,12 +401,12 @@ start_critical_timing(unsigned long ip, unsigned long=
 parent_ip, int pc)
 }
=20
 static nokprobe_inline void
-stop_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
+stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 {
 	int cpu;
 	struct trace_array *tr =3D irqsoff_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
+	unsigned int trace_ctx;
=20
 	cpu =3D raw_smp_processor_id();
 	/* Always clear the tracing cpu on stopping the trace */
@@ -428,8 +426,8 @@ stop_critical_timing(unsigned long ip, unsigned long pa=
rent_ip, int pc)
=20
 	atomic_inc(&data->disabled);
=20
-	local_save_flags(flags);
-	__trace_function(tr, ip, parent_ip, flags, pc);
+	trace_ctx =3D tracing_gen_ctx();
+	__trace_function(tr, ip, parent_ip, trace_ctx);
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start =3D 0;
 	atomic_dec(&data->disabled);
@@ -438,20 +436,16 @@ stop_critical_timing(unsigned long ip, unsigned long =
parent_ip, int pc)
 /* start and stop critical timings used to for stoppage (in idle) */
 void start_critical_timings(void)
 {
-	int pc =3D preempt_count();
-
-	if (preempt_trace(pc) || irq_trace())
-		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
+	if (preempt_trace(preempt_count()) || irq_trace())
+		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 NOKPROBE_SYMBOL(start_critical_timings);
=20
 void stop_critical_timings(void)
 {
-	int pc =3D preempt_count();
-
-	if (preempt_trace(pc) || irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
+	if (preempt_trace(preempt_count()) || irq_trace())
+		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 NOKPROBE_SYMBOL(stop_critical_timings);
@@ -609,19 +603,15 @@ static void irqsoff_tracer_stop(struct trace_array *t=
r)
  */
 void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
 {
-	unsigned int pc =3D preempt_count();
-
-	if (!preempt_trace(pc) && irq_trace())
-		stop_critical_timing(a0, a1, pc);
+	if (!preempt_trace(preempt_count()) && irq_trace())
+		stop_critical_timing(a0, a1);
 }
 NOKPROBE_SYMBOL(tracer_hardirqs_on);
=20
 void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
 {
-	unsigned int pc =3D preempt_count();
-
-	if (!preempt_trace(pc) && irq_trace())
-		start_critical_timing(a0, a1, pc);
+	if (!preempt_trace(preempt_count()) && irq_trace())
+		start_critical_timing(a0, a1);
 }
 NOKPROBE_SYMBOL(tracer_hardirqs_off);
=20
@@ -661,18 +651,14 @@ static struct tracer irqsoff_tracer __read_mostly =3D
 #ifdef CONFIG_PREEMPT_TRACER
 void tracer_preempt_on(unsigned long a0, unsigned long a1)
 {
-	int pc =3D preempt_count();
-
-	if (preempt_trace(pc) && !irq_trace())
-		stop_critical_timing(a0, a1, pc);
+	if (preempt_trace(preempt_count()) && !irq_trace())
+		stop_critical_timing(a0, a1);
 }
=20
 void tracer_preempt_off(unsigned long a0, unsigned long a1)
 {
-	int pc =3D preempt_count();
-
-	if (preempt_trace(pc) && !irq_trace())
-		start_critical_timing(a0, a1, pc);
+	if (preempt_trace(preempt_count()) && !irq_trace())
+		start_critical_timing(a0, a1);
 }
=20
 static int preemptoff_tracer_init(struct trace_array *tr)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e6fba1798771b..049a04d028e14 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1384,8 +1384,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct p=
t_regs *regs,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
=20
-	local_save_flags(fbuffer.flags);
-	fbuffer.pc =3D preempt_count();
+	fbuffer.trace_ctx =3D tracing_gen_ctx();
 	fbuffer.trace_file =3D trace_file;
=20
 	dsize =3D __get_data_size(&tk->tp, regs);
@@ -1394,7 +1393,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct p=
t_regs *regs,
 		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
 					call->event.type,
 					sizeof(*entry) + tk->tp.size + dsize,
-					fbuffer.flags, fbuffer.pc);
+					fbuffer.trace_ctx);
 	if (!fbuffer.event)
 		return;
=20
@@ -1432,8 +1431,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struc=
t kretprobe_instance *ri,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
=20
-	local_save_flags(fbuffer.flags);
-	fbuffer.pc =3D preempt_count();
+	fbuffer.trace_ctx =3D tracing_gen_ctx();
 	fbuffer.trace_file =3D trace_file;
=20
 	dsize =3D __get_data_size(&tk->tp, regs);
@@ -1441,7 +1439,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struc=
t kretprobe_instance *ri,
 		trace_event_buffer_lock_reserve(&fbuffer.buffer, trace_file,
 					call->event.type,
 					sizeof(*entry) + tk->tp.size + dsize,
-					fbuffer.flags, fbuffer.pc);
+					fbuffer.trace_ctx);
 	if (!fbuffer.event)
 		return;
=20
diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 84582bf1ed5fb..7221ae0b4c477 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -300,10 +300,11 @@ static void __trace_mmiotrace_rw(struct trace_array *=
tr,
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_rw *entry;
-	int pc =3D preempt_count();
+	unsigned int trace_ctx;
=20
+	trace_ctx =3D tracing_gen_ctx_flags(0);
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_MMIO_RW,
-					  sizeof(*entry), 0, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event) {
 		atomic_inc(&dropped_count);
 		return;
@@ -312,7 +313,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 	entry->rw			=3D *rw;
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, 0, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 void mmio_trace_rw(struct mmiotrace_rw *rw)
@@ -330,10 +331,11 @@ static void __trace_mmiotrace_map(struct trace_array =
*tr,
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_map *entry;
-	int pc =3D preempt_count();
+	unsigned int trace_ctx;
=20
+	trace_ctx =3D tracing_gen_ctx_flags(0);
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_MMIO_MAP,
-					  sizeof(*entry), 0, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event) {
 		atomic_inc(&dropped_count);
 		return;
@@ -342,7 +344,7 @@ static void __trace_mmiotrace_map(struct trace_array *t=
r,
 	entry->map			=3D *map;
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, 0, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 void mmio_trace_mapping(struct mmiotrace_map *map)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_w=
akeup.c
index c0181066dbe90..e5778d1d7a5b6 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -67,7 +67,7 @@ static bool function_enabled;
 static int
 func_prolog_preempt_disable(struct trace_array *tr,
 			    struct trace_array_cpu **data,
-			    int *pc)
+			    unsigned int *trace_ctx)
 {
 	long disabled;
 	int cpu;
@@ -75,7 +75,7 @@ func_prolog_preempt_disable(struct trace_array *tr,
 	if (likely(!wakeup_task))
 		return 0;
=20
-	*pc =3D preempt_count();
+	*trace_ctx =3D tracing_gen_ctx();
 	preempt_disable_notrace();
=20
 	cpu =3D raw_smp_processor_id();
@@ -116,8 +116,8 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *=
trace)
 {
 	struct trace_array *tr =3D wakeup_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
-	int pc, ret =3D 0;
+	unsigned int trace_ctx;
+	int ret =3D 0;
=20
 	if (ftrace_graph_ignore_func(trace))
 		return 0;
@@ -131,11 +131,10 @@ static int wakeup_graph_entry(struct ftrace_graph_ent=
 *trace)
 	if (ftrace_graph_notrace_addr(trace->func))
 		return 1;
=20
-	if (!func_prolog_preempt_disable(tr, &data, &pc))
+	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return 0;
=20
-	local_save_flags(flags);
-	ret =3D __trace_graph_entry(tr, trace, flags, pc);
+	ret =3D __trace_graph_entry(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
 	preempt_enable_notrace();
=20
@@ -146,16 +145,14 @@ static void wakeup_graph_return(struct ftrace_graph_r=
et *trace)
 {
 	struct trace_array *tr =3D wakeup_trace;
 	struct trace_array_cpu *data;
-	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
 	ftrace_graph_addr_finish(trace);
=20
-	if (!func_prolog_preempt_disable(tr, &data, &pc))
+	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
=20
-	local_save_flags(flags);
-	__trace_graph_return(tr, trace, flags, pc);
+	__trace_graph_return(tr, trace, trace_ctx);
 	atomic_dec(&data->disabled);
=20
 	preempt_enable_notrace();
@@ -217,13 +214,13 @@ wakeup_tracer_call(unsigned long ip, unsigned long pa=
rent_ip,
 	struct trace_array *tr =3D wakeup_trace;
 	struct trace_array_cpu *data;
 	unsigned long flags;
-	int pc;
+	unsigned int trace_ctx;
=20
-	if (!func_prolog_preempt_disable(tr, &data, &pc))
+	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
 		return;
=20
 	local_irq_save(flags);
-	trace_function(tr, ip, parent_ip, flags, pc);
+	trace_function(tr, ip, parent_ip, trace_ctx);
 	local_irq_restore(flags);
=20
 	atomic_dec(&data->disabled);
@@ -303,12 +300,12 @@ static void wakeup_print_header(struct seq_file *s)
 static void
 __trace_function(struct trace_array *tr,
 		 unsigned long ip, unsigned long parent_ip,
-		 unsigned long flags, int pc)
+		 unsigned int trace_ctx)
 {
 	if (is_graph(tr))
-		trace_graph_function(tr, ip, parent_ip, flags, pc);
+		trace_graph_function(tr, ip, parent_ip, trace_ctx);
 	else
-		trace_function(tr, ip, parent_ip, flags, pc);
+		trace_function(tr, ip, parent_ip, trace_ctx);
 }
=20
 static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
@@ -375,7 +372,7 @@ static void
 tracing_sched_switch_trace(struct trace_array *tr,
 			   struct task_struct *prev,
 			   struct task_struct *next,
-			   unsigned long flags, int pc)
+			   unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_context_switch;
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
@@ -383,7 +380,7 @@ tracing_sched_switch_trace(struct trace_array *tr,
 	struct ctx_switch_entry *entry;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_CTX,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -396,14 +393,14 @@ tracing_sched_switch_trace(struct trace_array *tr,
 	entry->next_cpu	=3D task_cpu(next);
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, flags, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 static void
 tracing_sched_wakeup_trace(struct trace_array *tr,
 			   struct task_struct *wakee,
 			   struct task_struct *curr,
-			   unsigned long flags, int pc)
+			   unsigned int trace_ctx)
 {
 	struct trace_event_call *call =3D &event_wakeup;
 	struct ring_buffer_event *event;
@@ -411,7 +408,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 	struct trace_buffer *buffer =3D tr->array_buffer.buffer;
=20
 	event =3D trace_buffer_lock_reserve(buffer, TRACE_WAKE,
-					  sizeof(*entry), flags, pc);
+					  sizeof(*entry), trace_ctx);
 	if (!event)
 		return;
 	entry	=3D ring_buffer_event_data(event);
@@ -424,7 +421,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 	entry->next_cpu			=3D task_cpu(wakee);
=20
 	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, flags, pc);
+		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
=20
 static void notrace
@@ -436,7 +433,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	unsigned long flags;
 	long disabled;
 	int cpu;
-	int pc;
+	unsigned int trace_ctx;
=20
 	tracing_record_cmdline(prev);
=20
@@ -455,8 +452,6 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	if (next !=3D wakeup_task)
 		return;
=20
-	pc =3D preempt_count();
-
 	/* disable local data, not wakeup_cpu data */
 	cpu =3D raw_smp_processor_id();
 	disabled =3D atomic_inc_return(&per_cpu_ptr(wakeup_trace->array_buffer.da=
ta, cpu)->disabled);
@@ -464,6 +459,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 		goto out;
=20
 	local_irq_save(flags);
+	trace_ctx =3D tracing_gen_ctx_flags(flags);
+
 	arch_spin_lock(&wakeup_lock);
=20
 	/* We could race with grabbing wakeup_lock */
@@ -473,9 +470,9 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	/* The task we are waiting for is waking up */
 	data =3D per_cpu_ptr(wakeup_trace->array_buffer.data, wakeup_cpu);
=20
-	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
-	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);
-	__trace_stack(wakeup_trace, flags, 0, pc);
+	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, trace_ctx);
+	tracing_sched_switch_trace(wakeup_trace, prev, next, trace_ctx);
+	__trace_stack(wakeup_trace, trace_ctx, 0);
=20
 	T0 =3D data->preempt_timestamp;
 	T1 =3D ftrace_now(cpu);
@@ -527,9 +524,8 @@ probe_wakeup(void *ignore, struct task_struct *p)
 {
 	struct trace_array_cpu *data;
 	int cpu =3D smp_processor_id();
-	unsigned long flags;
 	long disabled;
-	int pc;
+	unsigned int trace_ctx;
=20
 	if (likely(!tracer_enabled))
 		return;
@@ -550,11 +546,12 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	    (!dl_task(p) && (p->prio >=3D wakeup_prio || p->prio >=3D current->pr=
io)))
 		return;
=20
-	pc =3D preempt_count();
 	disabled =3D atomic_inc_return(&per_cpu_ptr(wakeup_trace->array_buffer.da=
ta, cpu)->disabled);
 	if (unlikely(disabled !=3D 1))
 		goto out;
=20
+	trace_ctx =3D tracing_gen_ctx();
+
 	/* interrupts should be off from try_to_wake_up */
 	arch_spin_lock(&wakeup_lock);
=20
@@ -581,19 +578,17 @@ probe_wakeup(void *ignore, struct task_struct *p)
=20
 	wakeup_task =3D get_task_struct(p);
=20
-	local_save_flags(flags);
-
 	data =3D per_cpu_ptr(wakeup_trace->array_buffer.data, wakeup_cpu);
 	data->preempt_timestamp =3D ftrace_now(cpu);
-	tracing_sched_wakeup_trace(wakeup_trace, p, current, flags, pc);
-	__trace_stack(wakeup_trace, flags, 0, pc);
+	tracing_sched_wakeup_trace(wakeup_trace, p, current, trace_ctx);
+	__trace_stack(wakeup_trace, trace_ctx, 0);
=20
 	/*
 	 * We must be careful in using CALLER_ADDR2. But since wake_up
 	 * is not called by an assembly function  (where as schedule is)
 	 * it should be safe to use it here.
 	 */
-	__trace_function(wakeup_trace, CALLER_ADDR1, CALLER_ADDR2, flags, pc);
+	__trace_function(wakeup_trace, CALLER_ADDR1, CALLER_ADDR2, trace_ctx);
=20
 out_locked:
 	arch_spin_unlock(&wakeup_lock);
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index d85a2f0f316b3..8bfcd3b094226 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -298,9 +298,8 @@ static void ftrace_syscall_enter(void *data, struct pt_=
regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
-	unsigned long irq_flags;
+	unsigned int trace_ctx;
 	unsigned long args[6];
-	int pc;
 	int syscall_nr;
 	int size;
=20
@@ -322,12 +321,11 @@ static void ftrace_syscall_enter(void *data, struct p=
t_regs *regs, long id)
=20
 	size =3D sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
=20
-	local_save_flags(irq_flags);
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D trace_buffer_lock_reserve(buffer,
-			sys_data->enter_event->event.type, size, irq_flags, pc);
+			sys_data->enter_event->event.type, size, trace_ctx);
 	if (!event)
 		return;
=20
@@ -337,7 +335,7 @@ static void ftrace_syscall_enter(void *data, struct pt_=
regs *regs, long id)
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
=20
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
-				    irq_flags, pc);
+				    trace_ctx);
 }
=20
 static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
@@ -348,8 +346,7 @@ static void ftrace_syscall_exit(void *data, struct pt_r=
egs *regs, long ret)
 	struct syscall_metadata *sys_data;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
-	unsigned long irq_flags;
-	int pc;
+	unsigned int trace_ctx;
 	int syscall_nr;
=20
 	syscall_nr =3D trace_get_syscall_nr(current, regs);
@@ -368,13 +365,12 @@ static void ftrace_syscall_exit(void *data, struct pt=
_regs *regs, long ret)
 	if (!sys_data)
 		return;
=20
-	local_save_flags(irq_flags);
-	pc =3D preempt_count();
+	trace_ctx =3D tracing_gen_ctx();
=20
 	buffer =3D tr->array_buffer.buffer;
 	event =3D trace_buffer_lock_reserve(buffer,
 			sys_data->exit_event->event.type, sizeof(*entry),
-			irq_flags, pc);
+			trace_ctx);
 	if (!event)
 		return;
=20
@@ -383,7 +379,7 @@ static void ftrace_syscall_exit(void *data, struct pt_r=
egs *regs, long ret)
 	entry->ret =3D syscall_get_return_value(current, regs);
=20
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
-				    irq_flags, pc);
+				    trace_ctx);
 }
=20
 static int reg_event_syscall_enter(struct trace_event_file *file,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3cf7128e1ad30..a1ed96a7a4624 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -961,7 +961,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 	esize =3D SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 	size =3D esize + tu->tp.size + dsize;
 	event =3D trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type, size, 0, 0);
+						call->event.type, size, 0);
 	if (!event)
 		return;
=20
@@ -977,7 +977,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
=20
 	memcpy(data, ucb->buf, tu->tp.size + dsize);
=20
-	event_trigger_unlock_commit(trace_file, buffer, event, entry, 0, 0);
+	event_trigger_unlock_commit(trace_file, buffer, event, entry, 0);
 }
=20
 /* uprobe handler */
--=20
2.30.0

