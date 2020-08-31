Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C348258024
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgHaSC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgHaSB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:27 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97F421734;
        Mon, 31 Aug 2020 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896886;
        bh=BdtMVTG43fc+tm1YBUYCMLtTAL4y3fwCR6qbRAeKVW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXumo4CUM/yjIibrAruL5EOeWun29GjRSk6g54F0l2+ZAaA90aDvjAL06Y8p3x6Hd
         a87BHAvQ07tSHo5nVEIcTW0bPq3E2TCGnwNBshw7hhy7XjKNofUZt/kNDPYmWrPI+X
         vZkoJSFn1mkzcC0vIhI8ynXzeXdPn1dA3rZeUW3g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/24] rcu: Clarify comments about FQS loop reporting quiescent states
Date:   Mon, 31 Aug 2020 11:01:12 -0700
Message-Id: <20200831180116.32690-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Since at least v4.19, the FQS loop no longer reports quiescent states
for offline CPUs except in emergency situations.

This commit therefore fixes the comment in rcu_gp_init() to match the
current code.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 52108dd..2c7afe4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1706,10 +1706,13 @@ static bool rcu_gp_init(void)
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
-	 * Apply per-leaf buffered online and offline operations to the
-	 * rcu_node tree.  Note that this new grace period need not wait
-	 * for subsequent online CPUs, and that quiescent-state forcing
-	 * will handle subsequent offline CPUs.
+	 * Apply per-leaf buffered online and offline operations to
+	 * the rcu_node tree. Note that this new grace period need not
+	 * wait for subsequent online CPUs, and that RCU hooks in the CPU
+	 * offlining path, when combined with checks in this function,
+	 * will handle CPUs that are currently going offline or that will
+	 * go offline later.  Please also refer to "Hotplug CPU" section
+	 * of RCU's Requirements documentation.
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
-- 
2.9.5

