Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391A27F663
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgI3XyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbgI3XyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:54:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DEB206FA;
        Wed, 30 Sep 2020 23:54:00 +0000 (UTC)
Date:   Wed, 30 Sep 2020 19:53:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A couple of fixes
Message-ID: <20200930195359.01d9f770@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Two tracing fixes:

- Fix temp buffer accounting that caused a WARNING for
  ftrace_dump_on_opps()

- Move the recursion check in one of the function callback helpers to the
  beginning of the function, as if the rcu_is_watching() gets traced, it
  will cause a recursive loop that will crash the kernel.


Please pull the latest trace-v5.9-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.9-rc6

Tag SHA1: 87d55eca1585b1bd70fe7de33cd5ea2957628027
Head SHA1: b40341fad6cc2daa195f8090fd3348f18fff640a


Steven Rostedt (VMware) (2):
      tracing: Fix trace_find_next_entry() accounting of temp buffer size
      ftrace: Move RCU is watching check after recursion check

----
 kernel/trace/ftrace.c |  6 ++----
 kernel/trace/trace.c  | 10 ++++++----
 2 files changed, 8 insertions(+), 8 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 603255f5f085..541453927c82 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6993,16 +6993,14 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 {
 	int bit;
 
-	if ((op->flags & FTRACE_OPS_FL_RCU) && !rcu_is_watching())
-		return;
-
 	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
 	if (bit < 0)
 		return;
 
 	preempt_disable_notrace();
 
-	op->func(ip, parent_ip, op, regs);
+	if (!(op->flags & FTRACE_OPS_FL_RCU) || rcu_is_watching())
+		op->func(ip, parent_ip, op, regs);
 
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c26345e83..d3e5de717df2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3546,13 +3546,15 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 	if (iter->ent && iter->ent != iter->temp) {
 		if ((!iter->temp || iter->temp_size < iter->ent_size) &&
 		    !WARN_ON_ONCE(iter->temp == static_temp_buf)) {
-			kfree(iter->temp);
-			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
-			if (!iter->temp)
+			void *temp;
+			temp = kmalloc(iter->ent_size, GFP_KERNEL);
+			if (!temp)
 				return NULL;
+			kfree(iter->temp);
+			iter->temp = temp;
+			iter->temp_size = iter->ent_size;
 		}
 		memcpy(iter->temp, iter->ent, iter->ent_size);
-		iter->temp_size = iter->ent_size;
 		iter->ent = iter->temp;
 	}
 	entry = __find_next_entry(iter, ent_cpu, NULL, ent_ts);
