Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4C2A83D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgKEQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgKEQqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:46:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A52221FA;
        Thu,  5 Nov 2020 16:46:04 +0000 (UTC)
Date:   Thu, 5 Nov 2020 11:46:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [GIT PULL] tracing: Fixes for v5.10-rc2
Message-ID: <20201105114602.2f4c655e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes:

- Fix off-by-one error in retrieving the context buffer for trace_printk()

- Fix off-by-one error in stack nesting limit

- Fix recursion to not make all NMI code false positive as recursing

- Stop losing events in function tracing when transitioning between irq context

- Stop losing events in ring buffer when transitioning between irq context

- Fix return code of error pointer in parse_synth_field() to prevent
  NULL pointer dereference.

- Fix false positive of NMI recursion in kprobe event handling


Please pull the latest trace-v5.10-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.10-rc2

Tag SHA1: c89bf1020df178df8b4f91aee2de6d731d453372
Head SHA1: 645f224e7ba2f4200bf163153d384ceb0de5462e


Qiujun Huang (2):
      tracing: Fix out of bounds write in get_trace_buf
      tracing: Fix the checking of stackidx in __ftrace_trace_stack

Steven Rostedt (VMware) (5):
      ftrace: Fix recursion check for NMI test
      ftrace: Handle tracing when switching between context
      ring-buffer: Fix recursion protection transitions between interrupt context
      tracing: Make -ENOMEM the default error for parse_synth_field()
      kprobes: Tell lockdep about kprobe nesting

----
 kernel/kprobes.c                  | 25 ++++++++++++++---
 kernel/trace/ring_buffer.c        | 58 +++++++++++++++++++++++++++++++--------
 kernel/trace/trace.c              |  6 ++--
 kernel/trace/trace.h              | 26 ++++++++++++++++--
 kernel/trace/trace_events_synth.c | 17 +++++-------
 kernel/trace/trace_selftest.c     |  9 ++++--
 6 files changed, 107 insertions(+), 34 deletions(-)
---------------------------
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8a12a25fa40d..41fdbb7953c6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1249,7 +1249,13 @@ __acquires(hlist_lock)
 
 	*head = &kretprobe_inst_table[hash];
 	hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
+	/*
+	 * Nested is a workaround that will soon not be needed.
+	 * There's other protections that make sure the same lock
+	 * is not taken on the same CPU that lockdep is unaware of.
+	 * Differentiate when it is taken in NMI context.
+	 */
+	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
 }
 NOKPROBE_SYMBOL(kretprobe_hash_lock);
 
@@ -1258,7 +1264,13 @@ static void kretprobe_table_lock(unsigned long hash,
 __acquires(hlist_lock)
 {
 	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
-	raw_spin_lock_irqsave(hlist_lock, *flags);
+	/*
+	 * Nested is a workaround that will soon not be needed.
+	 * There's other protections that make sure the same lock
+	 * is not taken on the same CPU that lockdep is unaware of.
+	 * Differentiate when it is taken in NMI context.
+	 */
+	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
 }
 NOKPROBE_SYMBOL(kretprobe_table_lock);
 
@@ -2028,7 +2040,12 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
 	hash = hash_ptr(current, KPROBE_HASH_BITS);
-	raw_spin_lock_irqsave(&rp->lock, flags);
+	/*
+	 * Nested is a workaround that will soon not be needed.
+	 * There's other protections that make sure the same lock
+	 * is not taken on the same CPU that lockdep is unaware of.
+	 */
+	raw_spin_lock_irqsave_nested(&rp->lock, flags, 1);
 	if (!hlist_empty(&rp->free_instances)) {
 		ri = hlist_entry(rp->free_instances.first,
 				struct kretprobe_instance, hlist);
@@ -2039,7 +2056,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 		ri->task = current;
 
 		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			raw_spin_lock_irqsave(&rp->lock, flags);
+			raw_spin_lock_irqsave_nested(&rp->lock, flags, 1);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
 			raw_spin_unlock_irqrestore(&rp->lock, flags);
 			return 0;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7f45fd9d5a45..dc83b3fa9fe7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -438,14 +438,16 @@ enum {
 };
 /*
  * Used for which event context the event is in.
- *  NMI     = 0
- *  IRQ     = 1
- *  SOFTIRQ = 2
- *  NORMAL  = 3
+ *  TRANSITION = 0
+ *  NMI     = 1
+ *  IRQ     = 2
+ *  SOFTIRQ = 3
+ *  NORMAL  = 4
  *
  * See trace_recursive_lock() comment below for more details.
  */
 enum {
+	RB_CTX_TRANSITION,
 	RB_CTX_NMI,
 	RB_CTX_IRQ,
 	RB_CTX_SOFTIRQ,
@@ -3014,10 +3016,10 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
  * a bit of overhead in something as critical as function tracing,
  * we use a bitmask trick.
  *
- *  bit 0 =  NMI context
- *  bit 1 =  IRQ context
- *  bit 2 =  SoftIRQ context
- *  bit 3 =  normal context.
+ *  bit 1 =  NMI context
+ *  bit 2 =  IRQ context
+ *  bit 3 =  SoftIRQ context
+ *  bit 4 =  normal context.
  *
  * This works because this is the order of contexts that can
  * preempt other contexts. A SoftIRQ never preempts an IRQ
@@ -3040,6 +3042,30 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
  * The least significant bit can be cleared this way, and it
  * just so happens that it is the same bit corresponding to
  * the current context.
+ *
+ * Now the TRANSITION bit breaks the above slightly. The TRANSITION bit
+ * is set when a recursion is detected at the current context, and if
+ * the TRANSITION bit is already set, it will fail the recursion.
+ * This is needed because there's a lag between the changing of
+ * interrupt context and updating the preempt count. In this case,
+ * a false positive will be found. To handle this, one extra recursion
+ * is allowed, and this is done by the TRANSITION bit. If the TRANSITION
+ * bit is already set, then it is considered a recursion and the function
+ * ends. Otherwise, the TRANSITION bit is set, and that bit is returned.
+ *
+ * On the trace_recursive_unlock(), the TRANSITION bit will be the first
+ * to be cleared. Even if it wasn't the context that set it. That is,
+ * if an interrupt comes in while NORMAL bit is set and the ring buffer
+ * is called before preempt_count() is updated, since the check will
+ * be on the NORMAL bit, the TRANSITION bit will then be set. If an
+ * NMI then comes in, it will set the NMI bit, but when the NMI code
+ * does the trace_recursive_unlock() it will clear the TRANSTION bit
+ * and leave the NMI bit set. But this is fine, because the interrupt
+ * code that set the TRANSITION bit will then clear the NMI bit when it
+ * calls trace_recursive_unlock(). If another NMI comes in, it will
+ * set the TRANSITION bit and continue.
+ *
+ * Note: The TRANSITION bit only handles a single transition between context.
  */
 
 static __always_inline int
@@ -3055,8 +3081,16 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 		bit = pc & NMI_MASK ? RB_CTX_NMI :
 			pc & HARDIRQ_MASK ? RB_CTX_IRQ : RB_CTX_SOFTIRQ;
 
-	if (unlikely(val & (1 << (bit + cpu_buffer->nest))))
-		return 1;
+	if (unlikely(val & (1 << (bit + cpu_buffer->nest)))) {
+		/*
+		 * It is possible that this was called by transitioning
+		 * between interrupt context, and preempt_count() has not
+		 * been updated yet. In this case, use the TRANSITION bit.
+		 */
+		bit = RB_CTX_TRANSITION;
+		if (val & (1 << (bit + cpu_buffer->nest)))
+			return 1;
+	}
 
 	val |= (1 << (bit + cpu_buffer->nest));
 	cpu_buffer->current_context = val;
@@ -3071,8 +3105,8 @@ trace_recursive_unlock(struct ring_buffer_per_cpu *cpu_buffer)
 		cpu_buffer->current_context - (1 << cpu_buffer->nest);
 }
 
-/* The recursive locking above uses 4 bits */
-#define NESTED_BITS 4
+/* The recursive locking above uses 5 bits */
+#define NESTED_BITS 5
 
 /**
  * ring_buffer_nest_start - Allow to trace while nested
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 528971714fc6..410cfeb16db5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2750,7 +2750,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	/*
 	 * If tracing is off, but we have triggers enabled
 	 * we still need to look at the event data. Use the temp_buffer
-	 * to store the trace event for the tigger to use. It's recusive
+	 * to store the trace event for the trigger to use. It's recursive
 	 * safe and will not be recorded anywhere.
 	 */
 	if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
@@ -2952,7 +2952,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
 
 	/* This should never happen. If it does, yell once and skip */
-	if (WARN_ON_ONCE(stackidx > FTRACE_KSTACK_NESTING))
+	if (WARN_ON_ONCE(stackidx >= FTRACE_KSTACK_NESTING))
 		goto out;
 
 	/*
@@ -3132,7 +3132,7 @@ static char *get_trace_buf(void)
 
 	/* Interrupts must see nesting incremented before we use the buffer */
 	barrier();
-	return &buffer->buffer[buffer->nesting][0];
+	return &buffer->buffer[buffer->nesting - 1][0];
 }
 
 static void put_trace_buf(void)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f3f5e77123ad..1dadef445cd1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -637,6 +637,12 @@ enum {
 	 * function is called to clear it.
 	 */
 	TRACE_GRAPH_NOTRACE_BIT,
+
+	/*
+	 * When transitioning between context, the preempt_count() may
+	 * not be correct. Allow for a single recursion to cover this case.
+	 */
+	TRACE_TRANSITION_BIT,
 };
 
 #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
@@ -691,14 +697,27 @@ static __always_inline int trace_test_and_set_recursion(int start, int max)
 		return 0;
 
 	bit = trace_get_context_bit() + start;
-	if (unlikely(val & (1 << bit)))
-		return -1;
+	if (unlikely(val & (1 << bit))) {
+		/*
+		 * It could be that preempt_count has not been updated during
+		 * a switch between contexts. Allow for a single recursion.
+		 */
+		bit = TRACE_TRANSITION_BIT;
+		if (trace_recursion_test(bit))
+			return -1;
+		trace_recursion_set(bit);
+		barrier();
+		return bit + 1;
+	}
+
+	/* Normal check passed, clear the transition to allow it again */
+	trace_recursion_clear(TRACE_TRANSITION_BIT);
 
 	val |= 1 << bit;
 	current->trace_recursion = val;
 	barrier();
 
-	return bit;
+	return bit + 1;
 }
 
 static __always_inline void trace_clear_recursion(int bit)
@@ -708,6 +727,7 @@ static __always_inline void trace_clear_recursion(int bit)
 	if (!bit)
 		return;
 
+	bit--;
 	bit = 1 << bit;
 	val &= ~bit;
 
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 84b7cab55291..881df991742a 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -584,7 +584,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 {
 	struct synth_field *field;
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
-	int len, ret = 0;
+	int len, ret = -ENOMEM;
 	struct seq_buf s;
 	ssize_t size;
 
@@ -617,10 +617,9 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		len--;
 
 	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
-	if (!field->name) {
-		ret = -ENOMEM;
+	if (!field->name)
 		goto free;
-	}
+
 	if (!is_good_name(field->name)) {
 		synth_err(SYNTH_ERR_BAD_NAME, errpos(field_name));
 		ret = -EINVAL;
@@ -638,10 +637,9 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		len += strlen(prefix);
 
 	field->type = kzalloc(len, GFP_KERNEL);
-	if (!field->type) {
-		ret = -ENOMEM;
+	if (!field->type)
 		goto free;
-	}
+
 	seq_buf_init(&s, field->type, len);
 	if (prefix)
 		seq_buf_puts(&s, prefix);
@@ -653,6 +651,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	}
 	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
 		goto free;
+
 	s.buffer[s.len] = '\0';
 
 	size = synth_field_size(field->type);
@@ -666,10 +665,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
 			type = kzalloc(len, GFP_KERNEL);
-			if (!type) {
-				ret = -ENOMEM;
+			if (!type)
 				goto free;
-			}
 
 			seq_buf_init(&s, type, len);
 			seq_buf_puts(&s, "__data_loc ");
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index b5e3496cf803..4738ad48a667 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -492,8 +492,13 @@ trace_selftest_function_recursion(void)
 	unregister_ftrace_function(&test_rec_probe);
 
 	ret = -1;
-	if (trace_selftest_recursion_cnt != 1) {
-		pr_cont("*callback not called once (%d)* ",
+	/*
+	 * Recursion allows for transitions between context,
+	 * and may call the callback twice.
+	 */
+	if (trace_selftest_recursion_cnt != 1 &&
+	    trace_selftest_recursion_cnt != 2) {
+		pr_cont("*callback not called once (or twice) (%d)* ",
 			trace_selftest_recursion_cnt);
 		goto out;
 	}
