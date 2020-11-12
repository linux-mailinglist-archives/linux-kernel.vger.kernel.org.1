Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBF2AFCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgKLBjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:39:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgKLAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:37:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D202168B;
        Thu, 12 Nov 2020 00:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YR-0002EC-Ii; Wed, 11 Nov 2020 19:33:35 -0500
Message-ID: <20201112003335.464397507@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:33:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 16/17] tracing: Fix some typos in comments
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

s/detetector/detector/
s/enfoced/enforced/
s/writen/written/
s/actualy/actually/
s/bascially/basically/
s/Regarldess/Regardless/
s/zeroes/zeros/
s/followd/followed/
s/incrememented/incremented/
s/separatelly/separately/
s/accesible/accessible/
s/sythetic/synthetic/
s/enabed/enabled/
s/heurisitc/heuristic/
s/assocated/associated/
s/otherwides/otherwise/
s/specfied/specified/
s/seaching/searching/
s/hierachry/hierarchy/
s/internel/internal/
s/Thise/This/

Link: https://lkml.kernel.org/r/20201029150554.3354-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/blktrace.c            | 4 ++--
 kernel/trace/bpf_trace.c           | 2 +-
 kernel/trace/trace.c               | 2 +-
 kernel/trace/trace_benchmark.c     | 6 +++---
 kernel/trace/trace_dynevent.c      | 2 +-
 kernel/trace/trace_dynevent.h      | 6 +++---
 kernel/trace/trace_entries.h       | 2 +-
 kernel/trace/trace_events.c        | 4 ++--
 kernel/trace/trace_events_filter.c | 2 +-
 kernel/trace/trace_events_hist.c   | 2 +-
 kernel/trace/trace_events_synth.c  | 4 ++--
 kernel/trace/trace_export.c        | 2 +-
 kernel/trace/trace_hwlat.c         | 4 ++--
 kernel/trace/tracing_map.c         | 6 +++---
 kernel/trace/tracing_map.h         | 2 +-
 15 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f1022945e346..1c3d0f57d763 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1343,7 +1343,7 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 			 * ones now use the 64bit ino as the whole ID and
 			 * no longer use generation.
 			 *
-			 * Regarldess of the content, always output
+			 * Regardless of the content, always output
 			 * "LOW32,HIGH32" so that FILEID_INO32_GEN fid can
 			 * be mapped back to @id on both 64 and 32bit ino
 			 * setups.  See __kernfs_fh_to_dentry().
@@ -1385,7 +1385,7 @@ static void blk_log_dump_pdu(struct trace_seq *s,
 				 i == 0 ? "" : " ", pdu_buf[i]);
 
 		/*
-		 * stop when the rest is just zeroes and indicate so
+		 * stop when the rest is just zeros and indicate so
 		 * with a ".." appended
 		 */
 		if (i == end && end != pdu_len - 1) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4517c8b66518..f4172b870377 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -113,7 +113,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	 * Instead of moving rcu_read_lock/rcu_dereference/rcu_read_unlock
 	 * to all call sites, we did a bpf_prog_array_valid() there to check
 	 * whether call->prog_array is empty or not, which is
-	 * a heurisitc to speed up execution.
+	 * a heuristic to speed up execution.
 	 *
 	 * If bpf_prog_array_valid() fetched prog_array was
 	 * non-NULL, we go into trace_call_bpf() and do the actual
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 410cfeb16db5..6a282bbc7e7f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3118,7 +3118,7 @@ struct trace_buffer_struct {
 static struct trace_buffer_struct *trace_percpu_buffer;
 
 /*
- * Thise allows for lockless recording.  If we're nested too deeply, then
+ * This allows for lockless recording.  If we're nested too deeply, then
  * this returns NULL.
  */
 static char *get_trace_buf(void)
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 2e9a4746ea85..801c2a7f7605 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -31,7 +31,7 @@ static bool ok_to_run;
  * it simply writes "START". As the first write is cold cache and
  * the rest is hot, we save off that time in bm_first and it is
  * reported as "first", which is shown in the second write to the
- * tracepoint. The "first" field is writen within the statics from
+ * tracepoint. The "first" field is written within the statics from
  * then on but never changes.
  */
 static void trace_do_benchmark(void)
@@ -112,7 +112,7 @@ static void trace_do_benchmark(void)
 		int i = 0;
 		/*
 		 * stddev is the square of standard deviation but
-		 * we want the actualy number. Use the average
+		 * we want the actually number. Use the average
 		 * as our seed to find the std.
 		 *
 		 * The next try is:
@@ -155,7 +155,7 @@ static int benchmark_event_kthread(void *arg)
 
 		/*
 		 * We don't go to sleep, but let others run as well.
-		 * This is bascially a "yield()" to let any task that
+		 * This is basically a "yield()" to let any task that
 		 * wants to run, schedule in, but if the CPU is idle,
 		 * we'll keep burning cycles.
 		 *
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 5fa49cfd2bb6..4f967d5cd917 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -276,7 +276,7 @@ int dynevent_arg_add(struct dynevent_cmd *cmd,
  * arguments of the form 'type variable_name;' or 'x+y'.
  *
  * The lhs argument string will be appended to the current cmd string,
- * followed by an operator, if applicable, followd by the rhs string,
+ * followed by an operator, if applicable, followed by the rhs string,
  * followed finally by a separator, if applicable.  Before the
  * argument is added, the @check_arg function, if present, will be
  * used to check the sanity of the current arg strings.
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index d6857a254ede..d6f72dcb7269 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -29,10 +29,10 @@ struct dyn_event;
  * @show: Showing method. This is invoked when user reads the event definitions
  *  via dynamic_events interface.
  * @is_busy: Check whether given event is busy so that it can not be deleted.
- *  Return true if it is busy, otherwides false.
- * @free: Delete the given event. Return 0 if success, otherwides error.
+ *  Return true if it is busy, otherwise false.
+ * @free: Delete the given event. Return 0 if success, otherwise error.
  * @match: Check whether given event and system name match this event. The argc
- *  and argv is used for exact match. Return true if it matches, otherwides
+ *  and argv is used for exact match. Return true if it matches, otherwise
  *  false.
  *
  * Except for @create, these methods are called under holding event_mutex.
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index ceafe2dc97e1..4547ac59da61 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -32,7 +32,7 @@
  *	to be deciphered for the format file. Although these macros
  *	may become out of sync with the internal structure, they
  *	will create a compile error if it happens. Since the
- *	internel structures are just tracing helpers, this is not
+ *	internal structures are just tracing helpers, this is not
  *	an issue.
  *
  *	When an internal structure is used, it should use:
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 244abbcd1db5..f4b459bb6d33 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2436,7 +2436,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 		/*
 		 * Since calls are grouped by systems, the likelyhood that the
 		 * next call in the iteration belongs to the same system as the
-		 * previous call is high. As an optimization, we skip seaching
+		 * previous call is high. As an optimization, we skip searching
 		 * for a map[] that matches the call's system if the last call
 		 * was from the same system. That's what last_i is for. If the
 		 * call has the same system as the previous call, then last_i
@@ -3271,7 +3271,7 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
  *
  * When a new instance is created, it needs to set up its events
  * directory, as well as other files associated with events. It also
- * creates the event hierachry in the @parent/events directory.
+ * creates the event hierarchy in the @parent/events directory.
  *
  * Returns 0 on success.
  *
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 78a678eeb140..d0f515ac9b7c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1950,7 +1950,7 @@ static int __ftrace_function_set_filter(int filter, char *buf, int len,
 	/*
 	 * The 'ip' field could have multiple filters set, separated
 	 * either by space or comma. We first cut the filter and apply
-	 * all pieces separatelly.
+	 * all pieces separately.
 	 */
 	re = ftrace_function_filter_re(buf, len, &re_cnt);
 	if (!re)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 96c3f86b81c5..39ebe1826fc3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3355,7 +3355,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 	} else {
 		field_var = NULL;
 		/*
-		 * If no explicit system.event is specfied, default to
+		 * If no explicit system.event is specified, default to
 		 * looking for fields on the onmatch(system.event.xxx)
 		 * event.
 		 */
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 881df991742a..5a8bc0b421f1 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1276,7 +1276,7 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 
 /**
  * synth_event_create - Create a new synthetic event
- * @name: The name of the new sythetic event
+ * @name: The name of the new synthetic event
  * @fields: An array of type/name field descriptions
  * @n_fields: The number of field descriptions contained in the fields array
  * @mod: The module creating the event, NULL if not created from a module
@@ -1446,7 +1446,7 @@ __synth_event_trace_init(struct trace_event_file *file,
 	 * this code to be called, etc).  Because this is called
 	 * directly by the user, we don't have that but we still need
 	 * to honor not logging when disabled.  For the iterated
-	 * trace case, we save the enabed state upon start and just
+	 * trace case, we save the enabled state upon start and just
 	 * ignore the following data calls.
 	 */
 	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 90f81d33fa3f..d960f6b11b5e 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -26,7 +26,7 @@ static int ftrace_event_register(struct trace_event_call *call,
 
 /*
  * The FTRACE_ENTRY_REG macro allows ftrace entry to define register
- * function and thus become accesible via perf.
+ * function and thus become accessible via perf.
  */
 #undef FTRACE_ENTRY_REG
 #define FTRACE_ENTRY_REG(name, struct_name, id, tstruct, print, regfn) \
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index c9ad5c6fbaad..d3ab2f4a77df 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -485,11 +485,11 @@ hwlat_width_write(struct file *filp, const char __user *ubuf,
  * @ppos: The current position in @file
  *
  * This function provides a write implementation for the "window" interface
- * to the hardware latency detetector. The window is the total time
+ * to the hardware latency detector. The window is the total time
  * in us that will be considered one sample period. Conceptually, windows
  * occur back-to-back and contain a sample width period during which
  * actual sampling occurs. Can be used to write a new total window size. It
- * is enfoced that any value written must be greater than the sample width
+ * is enforced that any value written must be greater than the sample width
  * size, or an error results.
  */
 static ssize_t
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 4b50fc0cb12c..d6bddb157ef2 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -609,7 +609,7 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
  * signal that state.  There are two user-visible tracing_map
  * variables, 'hits' and 'drops', which are updated by this function.
  * Every time an element is either successfully inserted or retrieved,
- * the 'hits' value is incrememented.  Every time an element insertion
+ * the 'hits' value is incremented.  Every time an element insertion
  * fails, the 'drops' value is incremented.
  *
  * This is a lock-free tracing map insertion function implementing a
@@ -642,9 +642,9 @@ struct tracing_map_elt *tracing_map_insert(struct tracing_map *map, void *key)
  * tracing_map_elt.  This is a lock-free lookup; see
  * tracing_map_insert() for details on tracing_map and how it works.
  * Every time an element is retrieved, the 'hits' value is
- * incrememented.  There is one user-visible tracing_map variable,
+ * incremented.  There is one user-visible tracing_map variable,
  * 'hits', which is updated by this function.  Every time an element
- * is successfully retrieved, the 'hits' value is incrememented.  The
+ * is successfully retrieved, the 'hits' value is incremented.  The
  * 'drops' value is never updated by this function.
  *
  * Return: the tracing_map_elt pointer val associated with the key.
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index a6de61fc22de..2c765ee2a4d4 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -50,7 +50,7 @@ typedef int (*tracing_map_cmp_fn_t) (void *val_a, void *val_b);
  * an instance of tracing_map_elt, where 'elt' in the latter part of
  * that variable name is short for 'element'.  The purpose of a
  * tracing_map_elt is to hold values specific to the particular
- * 32-bit hashed key it's assocated with.  Things such as the unique
+ * 32-bit hashed key it's associated with.  Things such as the unique
  * set of aggregated sums associated with the 32-bit hashed key, along
  * with a copy of the full key associated with the entry, and which
  * was used to produce the 32-bit hashed key.
-- 
2.28.0


