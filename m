Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3A28E586
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbgJNRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389519AbgJNRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F008022259;
        Wed, 14 Oct 2020 17:37:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiO-002yGf-P5; Wed, 14 Oct 2020 13:37:28 -0400
Message-ID: <20201014173728.633472308@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 04/12] tracing: Fix some typos in comments
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

s/wihin/within/
s/retrieven/retrieved/
s/suppport/support/
s/wil/will/
s/accidently/accidentally/
s/if the if the/if the/

Link: https://lkml.kernel.org/r/20201010140924.3809-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 kernel/trace/trace.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0806fa9f2815..63c97012ed39 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9465,7 +9465,7 @@ __init static int tracer_alloc_buffers(void)
 	}
 
 	/*
-	 * Make sure we don't accidently add more trace options
+	 * Make sure we don't accidentally add more trace options
 	 * than we have bits for.
 	 */
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
@@ -9494,7 +9494,7 @@ __init static int tracer_alloc_buffers(void)
 
 	/*
 	 * The prepare callbacks allocates some memory for the ring buffer. We
-	 * don't free the buffer if the if the CPU goes down. If we were to free
+	 * don't free the buffer if the CPU goes down. If we were to free
 	 * the buffer, then the user would lose any trace that was in the
 	 * buffer. The memory will be removed once the "instance" is removed.
 	 */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5b0e797cacdd..f777bb68e660 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -246,7 +246,7 @@ typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
  * tracing_snapshot_cond(tr, cond_data), the cond_data passed in is
  * passed in turn to the cond_snapshot.update() function.  That data
  * can be compared by the update() implementation with the cond_data
- * contained wihin the struct cond_snapshot instance associated with
+ * contained within the struct cond_snapshot instance associated with
  * the trace_array.  Because the tr->max_lock is held throughout the
  * update() call, the update() function can directly retrieve the
  * cond_snapshot and cond_data associated with the per-instance
@@ -271,7 +271,7 @@ typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
  *	take the snapshot, by returning 'true' if so, 'false' if no
  *	snapshot should be taken.  Because the max_lock is held for
  *	the duration of update(), the implementation is safe to
- *	directly retrieven and save any implementation data it needs
+ *	directly retrieved and save any implementation data it needs
  *	to in association with the snapshot.
  */
 struct cond_snapshot {
@@ -573,7 +573,7 @@ struct tracer {
  *   The function callback, which can use the FTRACE bits to
  *    check for recursion.
  *
- * Now if the arch does not suppport a feature, and it calls
+ * Now if the arch does not support a feature, and it calls
  * the global list function which calls the ftrace callback
  * all three of these steps will do a recursion protection.
  * There's no reason to do one if the previous caller already
@@ -1479,7 +1479,7 @@ __trace_event_discard_commit(struct trace_buffer *buffer,
 /*
  * Helper function for event_trigger_unlock_commit{_regs}().
  * If there are event triggers attached to this event that requires
- * filtering against its fields, then they wil be called as the
+ * filtering against its fields, then they will be called as the
  * entry already holds the field information of the current event.
  *
  * It also checks if the event should be discarded or not.
-- 
2.28.0


