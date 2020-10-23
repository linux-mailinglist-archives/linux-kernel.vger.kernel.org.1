Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885F229719F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbgJWOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbgJWOrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:22 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F24F24641;
        Fri, 23 Oct 2020 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464441;
        bh=mmBI23rjjBmPGjD8SbLtdgVhsw2qBsYlz8/3jt8pg4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4zUl0pv4yew5LXQ/jUTp0/zpzlhPKT0LutIspUzkQJVGFevVo6elHSCzf2qvmIgn
         CPR4CaXBpskuAzka35zpe73y6bm/s/3fP7sUFfkyAT3zhqE+UP2Ys7j8eYCRBocyyX
         e6QQfxz0mCgRKhrNxDVUf+diaCIW5e5Qcj1kx2/M=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 10/16] rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
Date:   Fri, 23 Oct 2020 16:46:43 +0200
Message-Id: <20201023144649.53046-11-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to handle the pending bypass queue before we switch to the
final de-offload state. We'll have to be careful and later set
SEGCBLIST_SOFTIRQ_ONLY before re-enabling again IRQs, or new bypass
callbacks could be queued in the meantine.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_plugin.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c44b83b79196..49bd42995ae7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2342,12 +2342,19 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
+	rcu_nocb_lock_irqsave(rdp, flags);
 	/* Make sure nocb timer won't stay around */
-	rcu_nocb_lock_irqsave(rdp, flags);
 	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
 	del_timer_sync(&rdp->nocb_timer);
 
+	/*
+	 * Flush bypass. While IRQs are disabled and once we set
+	 * SEGCBLIST_SOFTIRQ_ONLY, no callback is supposed to be
+	 * enqueued on bypass.
+	 */
+	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
 	return ret;
 }
 
-- 
2.25.1

