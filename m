Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1666B2737AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgIVAvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgIVAvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:51:01 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B8F123A32;
        Tue, 22 Sep 2020 00:50:59 +0000 (UTC)
Date:   Mon, 21 Sep 2020 20:50:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fixes for 5.9-rc5
Message-ID: <20200921205058.3eaf308c@rorschach.local.home>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes:

- Check kprobe is enabled before unregistering from ftrace as it isn't
  registered when disabled.

- Remove kprobes enabled via command-line that is on init text when freed.

- Add missing RCU synchronization for ftrace trampoline symbols removed
  from kallsyms.

- Free trampoline on error path if ftrace_startup() fails.

- Give more space for the longer PID numbers in trace output.

- Fix a possible double free in the histogram code.

- A couple of fixes that were discovered by sparse.


Please pull the latest trace-v5.9-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.9-rc5

Tag SHA1: 750719ec37a06d21a1b3c71da5859ae7039582e6
Head SHA1: a27026e95b57acbb8df7182e020b099e7f3b5ac3


Adrian Hunter (1):
      ftrace: Fix missing synchronize_rcu() removing trampoline from kallsyms

Jason Yan (1):
      bootconfig: init: make xbc_namebuf static

Masami Hiramatsu (2):
      kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()
      kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot

Miroslav Benes (1):
      ftrace: Free the trampoline when ftrace_startup() fails

Sebastian Andrzej Siewior (1):
      tracing: Make the space reserved for the pid wider

Tobias Klauser (1):
      ftrace: Let ftrace_enable_sysctl take a kernel pointer buffer

Tom Rix (1):
      tracing: fix double free

----
 include/linux/ftrace.h           |  3 +--
 include/linux/kprobes.h          |  5 +++++
 init/main.c                      |  4 +++-
 kernel/kprobes.c                 | 27 +++++++++++++++++++++++++--
 kernel/trace/ftrace.c            |  6 ++++--
 kernel/trace/trace.c             | 38 +++++++++++++++++++-------------------
 kernel/trace/trace_events_hist.c |  1 -
 kernel/trace/trace_output.c      | 12 ++++++------
 8 files changed, 63 insertions(+), 33 deletions(-)
---------------------------
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ce2c06f72e86..e5c2d5cc6e6a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -85,8 +85,7 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 extern int ftrace_enabled;
 extern int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
-		     void __user *buffer, size_t *lenp,
-		     loff_t *ppos);
+		     void *buffer, size_t *lenp, loff_t *ppos);
 
 struct ftrace_ops;
 
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9be1bff4f586..8aab327b5539 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -373,6 +373,8 @@ void unregister_kretprobes(struct kretprobe **rps, int num);
 void kprobe_flush_task(struct task_struct *tk);
 void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
 
+void kprobe_free_init_mem(void);
+
 int disable_kprobe(struct kprobe *kp);
 int enable_kprobe(struct kprobe *kp);
 
@@ -435,6 +437,9 @@ static inline void unregister_kretprobes(struct kretprobe **rps, int num)
 static inline void kprobe_flush_task(struct task_struct *tk)
 {
 }
+static inline void kprobe_free_init_mem(void)
+{
+}
 static inline int disable_kprobe(struct kprobe *kp)
 {
 	return -ENOSYS;
diff --git a/init/main.c b/init/main.c
index ae78fb68d231..e880b4ecb314 100644
--- a/init/main.c
+++ b/init/main.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/kmod.h>
+#include <linux/kprobes.h>
 #include <linux/vmalloc.h>
 #include <linux/kernel_stat.h>
 #include <linux/start_kernel.h>
@@ -303,7 +304,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
@@ -1402,6 +1403,7 @@ static int __ref kernel_init(void *unused)
 	kernel_init_freeable();
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
+	kprobe_free_init_mem();
 	ftrace_free_init_mem();
 	free_initmem();
 	mark_readonly();
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263c9cb9..d750e025d1ff 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2159,9 +2159,10 @@ static void kill_kprobe(struct kprobe *p)
 
 	/*
 	 * The module is going away. We should disarm the kprobe which
-	 * is using ftrace.
+	 * is using ftrace, because ftrace framework is still available at
+	 * MODULE_STATE_GOING notification.
 	 */
-	if (kprobe_ftrace(p))
+	if (kprobe_ftrace(p) && !kprobe_disabled(p) && !kprobes_all_disarmed)
 		disarm_kprobe_ftrace(p);
 }
 
@@ -2452,6 +2453,28 @@ static struct notifier_block kprobe_module_nb = {
 extern unsigned long __start_kprobe_blacklist[];
 extern unsigned long __stop_kprobe_blacklist[];
 
+void kprobe_free_init_mem(void)
+{
+	void *start = (void *)(&__init_begin);
+	void *end = (void *)(&__init_end);
+	struct hlist_head *head;
+	struct kprobe *p;
+	int i;
+
+	mutex_lock(&kprobe_mutex);
+
+	/* Kill all kprobes on initmem */
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		head = &kprobe_table[i];
+		hlist_for_each_entry(p, head, hlist) {
+			if (start <= (void *)p->addr && (void *)p->addr < end)
+				kill_kprobe(p);
+		}
+	}
+
+	mutex_unlock(&kprobe_mutex);
+}
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 275441254bb5..603255f5f085 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2782,6 +2782,7 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
 {
 	lockdep_assert_held(&ftrace_lock);
 	list_del_rcu(&ops->list);
+	synchronize_rcu();
 }
 
 /*
@@ -2862,6 +2863,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 		__unregister_ftrace_function(ops);
 		ftrace_start_up--;
 		ops->flags &= ~FTRACE_OPS_FL_ENABLED;
+		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
+			ftrace_trampoline_free(ops);
 		return ret;
 	}
 
@@ -7531,8 +7534,7 @@ static bool is_permanent_ops_registered(void)
 
 int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
-		     void __user *buffer, size_t *lenp,
-		     loff_t *ppos)
+		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = -ENODEV;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f40d850ebabc..2a7c26345e83 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3782,14 +3782,14 @@ unsigned long trace_total_entries(struct trace_array *tr)
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                  _------=> CPU#            \n"
-		    "#                 / _-----=> irqs-off        \n"
-		    "#                | / _----=> need-resched    \n"
-		    "#                || / _---=> hardirq/softirq \n"
-		    "#                ||| / _--=> preempt-depth   \n"
-		    "#                |||| /     delay            \n"
-		    "#  cmd     pid   ||||| time  |   caller      \n"
-		    "#     \\   /      |||||  \\    |   /         \n");
+	seq_puts(m, "#                    _------=> CPU#            \n"
+		    "#                   / _-----=> irqs-off        \n"
+		    "#                  | / _----=> need-resched    \n"
+		    "#                  || / _---=> hardirq/softirq \n"
+		    "#                  ||| / _--=> preempt-depth   \n"
+		    "#                  |||| /     delay            \n"
+		    "#  cmd     pid     ||||| time  |   caller      \n"
+		    "#     \\   /        |||||  \\    |   /         \n");
 }
 
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -3810,26 +3810,26 @@ static void print_func_help_header(struct array_buffer *buf, struct seq_file *m,
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#           TASK-PID   %s  CPU#   TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
-	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
+	seq_printf(m, "#           TASK-PID    %s CPU#     TIMESTAMP  FUNCTION\n", tgid ? "   TGID   " : "");
+	seq_printf(m, "#              | |      %s   |         |         |\n",      tgid ? "     |    " : "");
 }
 
 static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file *m,
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char *space = "          ";
-	int prec = tgid ? 10 : 2;
+	const char *space = "            ";
+	int prec = tgid ? 12 : 2;
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#                          %.*s  _-----=> irqs-off\n", prec, space);
-	seq_printf(m, "#                          %.*s / _----=> need-resched\n", prec, space);
-	seq_printf(m, "#                          %.*s| / _---=> hardirq/softirq\n", prec, space);
-	seq_printf(m, "#                          %.*s|| / _--=> preempt-depth\n", prec, space);
-	seq_printf(m, "#                          %.*s||| /     delay\n", prec, space);
-	seq_printf(m, "#           TASK-PID %.*sCPU#  ||||    TIMESTAMP  FUNCTION\n", prec, "   TGID   ");
-	seq_printf(m, "#              | |   %.*s  |   ||||       |         |\n", prec, "     |    ");
+	seq_printf(m, "#                            %.*s  _-----=> irqs-off\n", prec, space);
+	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
+	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
+	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
+	seq_printf(m, "#                            %.*s||| /     delay\n", prec, space);
+	seq_printf(m, "#           TASK-PID  %.*s CPU#  ||||   TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
+	seq_printf(m, "#              | |    %.*s   |   ||||      |         |\n", prec, "       |    ");
 }
 
 void
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0b933546142e..1b2ef6490229 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3865,7 +3865,6 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 
 			s = kstrdup(field_str, GFP_KERNEL);
 			if (!s) {
-				kfree(hist_data->attrs->var_defs.name[n_vars]);
 				ret = -ENOMEM;
 				goto free;
 			}
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 4d1893564912..000e9dc224c6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -497,7 +497,7 @@ lat_print_generic(struct trace_seq *s, struct trace_entry *entry, int cpu)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%8.8s-%-5d %3d",
+	trace_seq_printf(s, "%8.8s-%-7d %3d",
 			 comm, entry->pid, cpu);
 
 	return trace_print_lat_fmt(s, entry);
@@ -588,15 +588,15 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%16s-%-5d ", comm, entry->pid);
+	trace_seq_printf(s, "%16s-%-7d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
 
 		if (!tgid)
-			trace_seq_printf(s, "(-----) ");
+			trace_seq_printf(s, "(-------) ");
 		else
-			trace_seq_printf(s, "(%5d) ", tgid);
+			trace_seq_printf(s, "(%7d) ", tgid);
 	}
 
 	trace_seq_printf(s, "[%03d] ", iter->cpu);
@@ -636,7 +636,7 @@ int trace_print_lat_context(struct trace_iterator *iter)
 		trace_find_cmdline(entry->pid, comm);
 
 		trace_seq_printf(
-			s, "%16s %5d %3d %d %08x %08lx ",
+			s, "%16s %7d %3d %d %08x %08lx ",
 			comm, entry->pid, iter->cpu, entry->flags,
 			entry->preempt_count, iter->idx);
 	} else {
@@ -917,7 +917,7 @@ static enum print_line_t trace_ctxwake_print(struct trace_iterator *iter,
 	S = task_index_to_char(field->prev_state);
 	trace_find_cmdline(field->next_pid, comm);
 	trace_seq_printf(&iter->seq,
-			 " %5d:%3d:%c %s [%03d] %5d:%3d:%c %s\n",
+			 " %7d:%3d:%c %s [%03d] %7d:%3d:%c %s\n",
 			 field->prev_pid,
 			 field->prev_prio,
 			 S, delim,
