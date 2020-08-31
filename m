Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3091425806C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgHaSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgHaSLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3778A20E65;
        Mon, 31 Aug 2020 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897482;
        bh=RT8zUpvBeGSNkpNMBCtjwCvDmhV5N9JXCZ8P2M0fqTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3MEF7sMIx+W869ni9dtu7ZxfvJOLDLQ2pNq3AHsOAv/bJ/UvrWyEuuDmZMlD+WM5
         Qhn1HWDJyTdWEZb1SpvUxEsF4vgTk+XnLCNSsL/Ye6xy71qFlDSIRdgz0sKvz3/SFI
         NCLJBkMK9MvSs+yZs7pNvm32HU1HUBlJkcfAIprA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/13] rcu: Reduce leaf fanout for strict RCU grace periods
Date:   Mon, 31 Aug 2020 11:11:09 -0700
Message-Id: <20200831181120.1044-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because strict RCU grace periods will complete more quickly, they will
experience greater lock contention on each leaf rcu_node structure's
->lock.  This commit therefore reduces the leaf fanout in order to reduce
this lock contention.

Note that this also has the effect of reducing the number of CPUs
supported to 16 in the case of CONFIG_RCU_FANOUT_LEAF=2 or 81 in the
case of CONFIG_RCU_FANOUT_LEAF=3.  However, greater numbers of CPUs are
probably a bad idea when using CONFIG_RCU_STRICT_GRACE_PERIOD=y.  Those
wishing to live dangerously are free to edit their kernel/rcu/Kconfig
files accordingly.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 0ebe15a..b71e21f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -135,10 +135,12 @@ config RCU_FANOUT
 
 config RCU_FANOUT_LEAF
 	int "Tree-based hierarchical RCU leaf-level fanout value"
-	range 2 64 if 64BIT
-	range 2 32 if !64BIT
+	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
+	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
+	range 2 3 if RCU_STRICT_GRACE_PERIOD
 	depends on TREE_RCU && RCU_EXPERT
-	default 16
+	default 16 if !RCU_STRICT_GRACE_PERIOD
+	default 2 if RCU_STRICT_GRACE_PERIOD
 	help
 	  This option controls the leaf-level fanout of hierarchical
 	  implementations of RCU, and allows trading off cache misses
-- 
2.9.5

