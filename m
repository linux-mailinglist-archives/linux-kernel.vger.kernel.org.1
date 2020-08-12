Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E7243138
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHLW5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 18:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHLW5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551AD221E2;
        Wed, 12 Aug 2020 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273055;
        bh=OGPqyqYdUZfsg/o5cMh1UEDvxRNNqJG7kPy8M8xnfBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+lHJLtpnxZ+ZgcHiLV8P7hmqGeftveOvyoAPptL7BSeXXBQCnvq2DFAWdhxTNqgQ
         OL4R6F8bhSOqCCNxBOVO1k/hhkmmhlsxsL/r2VaxDIf4FkdtuzVcinE4F/pzjF7sLA
         MIYYUohgP7jMWRVS3cuUz4LZ1SDqrnEZxsALYfGI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/12] rcu: Always set .need_qs from __rcu_read_lock() for strict GPs
Date:   Wed, 12 Aug 2020 15:57:25 -0700
Message-Id: <20200812225732.20068-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The ->rcu_read_unlock_special.b.need_qs field in the task_struct
structure indicates that the RCU core needs a quiscent state from the
corresponding task.  The __rcu_read_unlock() function checks this (via
an eventual call to rcu_preempt_deferred_qs_irqrestore()), and if set
reports a quiscent state immediately upon exit from the outermost RCU
read-side critical section.

Currently, this flag is only set when the scheduling-clock interrupt
decides that the current RCU grace period is too old, as in about
one full second too old.  But if the kernel has been built with
CONFIG_RCU_STRICT_GRACE_PERIOD=y, we clearly do not want to wait that
long.  This commit therefore sets the .need_qs field immediately at the
start of the RCU read-side critical section from within __rcu_read_lock()
in order to unconditionally enlist help from __rcu_read_unlock().

But note the additional check for rcu_state.gp_kthread, which prevents
attempts to awaken RCU's grace-period kthread during early boot before
there is a scheduler.  Leaving off this check results in early boot hangs.
So early that there is no console output.  Thus, this additional check
fails until such time as RCU's grace-period kthread has been created,
avoiding these empty-console hangs.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5c0c580..7ed55c5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -376,6 +376,8 @@ void __rcu_read_lock(void)
 	rcu_preempt_read_enter();
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
+		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
-- 
2.9.5

