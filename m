Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8D2EC16D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbhAFQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbhAFQsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:48:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A76A23139;
        Wed,  6 Jan 2021 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951691;
        bh=eJd6DzlaJ+U6LYftqjDY7J8Rq4Ed0PxBxGA1GaspaK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9moo8VZECq1SdPizstAyXPm11CAf9wkJaWvKteYbjj61+LI92uEgDQf/wXosP9ME
         3H0ygr5kMgDjalyVMfza6EqzPoIh2SmXGqnCcyKkIt7IOuORD95QRT3Wah2t+OU3cs
         CaQLJQTcP6rl+0m1M2rGyElfmeK0Yvw5MB6ogwGBS5KszKGtUbRYlqjD5Ul3pMgr9c
         zugViQSGxawTX2WomaJAcmeEAHZqAmRAH17y7tQtBeMKXLJVx8PDeYo+/KgyYJlO4L
         Z3xR7ZRKVGmgAFCEqlQ6S8Q/PkFcMd2YuoUkSllLjuwNwnPvhq2Jf/XLMYoxKxTx8C
         uHQ9XKR7Vfumg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] rcu: Unconditionally use rcuc threads on PREEMPT_RT
Date:   Wed,  6 Jan 2021 08:48:08 -0800
Message-Id: <20210106164809.20068-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106164746.GA19969@paulmck-ThinkPad-P72>
References: <20210106164746.GA19969@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

PREEMPT_RT systems have long used the rcutree.use_softirq kernel
boot parameter to avoid use of RCU_SOFTIRQ handlers, which can disrupt
real-time applications by invoking callbacks during return from interrupts
that arrived while executing time-critical code.  This kernel boot
parameter instead runs RCU core processing in an 'rcuc' kthread, thus
allowing the scheduler to do its job of avoiding disrupting time-critical
code.

This commit therefore disables the rcutree.use_softirq kernel boot
parameter on PREEMPT_RT systems, thus forcing such systems to do RCU
core processing in 'rcuc' kthreads.  This approach has long been in
use by users of the -rt patchset, and there have been no complaints.
There is therefore no way for the system administrator to override this
choice, at least without modifying and rebuilding the kernel.

Signed-off-by: Scott Wood <swood@redhat.com>
[bigeasy: Reword commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ paulmck: Update kernel-parameters.txt accordingly. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/rcu/tree.c                               | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..521255f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4092,6 +4092,10 @@
 			value, meaning that RCU_SOFTIRQ is used by default.
 			Specify rcutree.use_softirq=0 to use rcuc kthreads.
 
+			But note that CONFIG_PREEMPT_RT=y kernels disable
+			this kernel boot parameter, forcibly setting it
+			to zero.
+
 	rcutree.rcu_fanout_exact= [KNL]
 			Disable autobalancing of the rcu_node combining
 			tree.  This is used by rcutorture, and might
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..d609035 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -100,8 +100,10 @@ static struct rcu_state rcu_state = {
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
 /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
-static bool use_softirq = true;
+static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT);
+#ifndef CONFIG_PREEMPT_RT
 module_param(use_softirq, bool, 0444);
+#endif
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
 module_param(rcu_fanout_exact, bool, 0444);
-- 
2.9.5

