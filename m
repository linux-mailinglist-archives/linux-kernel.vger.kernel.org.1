Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80520453A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbgFWAXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbgFWAVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC286207DD;
        Tue, 23 Jun 2020 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871710;
        bh=fRzC9I2fzQqk+PaLvwfzjI6019SUcEan0gSkO5l4SRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOG5LWQJ/FEuBKuFDC//U0LEavLhdLfKfjN0rUGiwGF38hISqMkECEPcMjuWIt/Lo
         01J3G+hivki9yeKTGTGIihRRccJK5Pl5FKZVHPORxjhKQ4TV7H1sU87B/tAArZ/hOh
         MC+GZdt7S098+qXS6+dm9Rf39DE0o/Viw8EkVZvQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/26] rcu: Grace-period-kthread related sleeps to idle priority
Date:   Mon, 22 Jun 2020 17:21:28 -0700
Message-Id: <20200623002147.25750-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the long-standing schedule_timeout_interruptible()
and schedule_timeout_uninterruptible() calls used by RCU's grace-period
kthread to schedule_timeout_idle().  This conversion avoids polluting
the load-average with RCU-related sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index db17ffe..48ae673 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1620,7 +1620,7 @@ static void rcu_gp_slow(int delay)
 	if (delay > 0 &&
 	    !(rcu_seq_ctr(rcu_state.gp_seq) %
 	      (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
-		schedule_timeout_uninterruptible(delay);
+		schedule_timeout_idle(delay);
 }
 
 static unsigned long sleep_duration;
@@ -1643,7 +1643,7 @@ static void rcu_gp_torture_wait(void)
 	duration = xchg(&sleep_duration, 0UL);
 	if (duration > 0) {
 		pr_alert("%s: Waiting %lu jiffies\n", __func__, duration);
-		schedule_timeout_uninterruptible(duration);
+		schedule_timeout_idle(duration);
 		pr_alert("%s: Wait complete\n", __func__);
 	}
 }
@@ -2709,7 +2709,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	}
 	*statusp = RCU_KTHREAD_YIELDING;
 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
-	schedule_timeout_interruptible(2);
+	schedule_timeout_idle(2);
 	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
 	*statusp = RCU_KTHREAD_WAITING;
 }
-- 
2.9.5

