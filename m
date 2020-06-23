Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA720455D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgFWAa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731717AbgFWAaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A1320DD4;
        Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872220;
        bh=ZnfhGx5U6A8JH7MyaM8fTjw6ysA6x6Vvaxq31qKSurw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XQ5dIPkX4LJFwIoydcGNNZn/mzT6mYv0oOZXfN2jbVAJDArpWGVnJWBq64u7vGdF
         eQo/yP6g4QFsLm+wmjKCgAJaua8dI6SA9xstsJ63ctrmU3tkA+lJr0RqDDFtgVFyhb
         e+QExg75zR+31DAkMFih+xbVXYqQAWSyL9zr7r7I=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 27/30] rcu-tasks: Fix synchronize_rcu_tasks_trace() header comment
Date:   Mon, 22 Jun 2020 17:30:10 -0700
Message-Id: <20200623003013.26252-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The synchronize_rcu_tasks_trace() header comment incorrectly claims that
any number of things delimit RCU Tasks Trace read-side critical sections,
when in fact only rcu_read_lock_trace() and rcu_read_unlock_trace() do so.
This commit therefore fixes this comment, and, while in the area, fixes
a typo in the rcu_read_lock_trace() header comment.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 4 ++--
 kernel/rcu/tasks.h             | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 4c25a41..d9015aa 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -36,8 +36,8 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting);
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
  *
- * When synchronize_rcu_trace() is invoked by one task, then that task
- * is guaranteed to block until all other tasks exit their read-side
+ * When synchronize_rcu_tasks_trace() is invoked by one task, then that
+ * task is guaranteed to block until all other tasks exit their read-side
  * critical sections.  Similarly, if call_rcu_trace() is invoked on one
  * task while other tasks are within RCU read-side critical sections,
  * invocation of the corresponding RCU callback is deferred until after
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ce23f6c..a77298c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1118,11 +1118,10 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
  * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
  *
  * Control will return to the caller some time after a trace rcu-tasks
- * grace period has elapsed, in other words after all currently
- * executing rcu-tasks read-side critical sections have elapsed.  These
- * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
- * anyway) cond_resched().
+ * grace period has elapsed, in other words after all currently executing
+ * rcu-tasks read-side critical sections have elapsed.  These read-side
+ * critical sections are delimited by calls to rcu_read_lock_trace()
+ * and rcu_read_unlock_trace().
  *
  * This is a very specialized primitive, intended only for a few uses in
  * tracing and other situations requiring manipulation of function preambles
-- 
2.9.5

