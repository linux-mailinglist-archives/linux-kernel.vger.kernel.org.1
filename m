Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AEC27B82E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgI1XbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgI1XbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:05 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164B52100A;
        Mon, 28 Sep 2020 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335865;
        bh=SAdqNDMYiPXJzGpnDHbWkZPrsqj76BVlOKwIxsw8+d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2dWiDctDrVfJ2h6lUK1zGYT+5uA/152BHNj8OdIPtCur9wnBZY4cIrELAPON+wfU
         7pw46knccQWcITiREAlWKJ4TvNHZXfufoqBrNzCBqGgOyBFdx3ZUFRbSW1W/0lV+Hv
         g89LUHUTpaByxEbYvsJr3c2ubyYr6DBs8FZNmO7Q=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/15] lockdep: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:51 -0700
Message-Id: <20200928233102.24265-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/lockdep.h | 6 ++----
 lib/Kconfig.debug       | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6a584b3..879de69 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -560,16 +560,14 @@ do {									\
 
 #define lockdep_assert_preemption_enabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+	WARN_ON_ONCE(debug_locks			&&		\
 		     (preempt_count() != 0		||		\
 		      !raw_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+	WARN_ON_ONCE(debug_locks			&&		\
 		     (preempt_count() == 0		&&		\
 		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f50fbcf..d4d0574 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1161,7 +1161,6 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT
 	select TRACE_IRQFLAGS
 	default n
 	help
-- 
2.9.5

