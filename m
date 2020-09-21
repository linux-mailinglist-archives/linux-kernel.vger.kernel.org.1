Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D33272415
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgIUMoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgIUMoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:44:14 -0400
Received: from lenoir.home (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1CC222BB;
        Mon, 21 Sep 2020 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600692254;
        bh=iSQLytuvoTVSkVFQJBym4elXGfzuYLVgReaXc9VqAPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GX+m1v5R4v7md0gi81mfNEKZZ4idp+KVP5+LZuddvagaWs2lCERWOHhng8wxeqo3s
         fTwLykGfTsjHvuwbzvRIv34PKfTCv2VSBaJbCq2fCBX70ntyoXLQmXE78iGW9ZW+wa
         d3HqKZih0xoq5P0kY6jqNyKIFbuoHoCk1ovFpSuY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH 08/12] rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
Date:   Mon, 21 Sep 2020 14:43:47 +0200
Message-Id: <20200921124351.24035-9-frederic@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921124351.24035-1-frederic@kernel.org>
References: <20200921124351.24035-1-frederic@kernel.org>
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
---
 kernel/rcu/tree_plugin.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3361bd351f3b..cee15841c178 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2302,11 +2302,17 @@ static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
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
 }
 
 static long rcu_nocb_rdp_deoffload(void *arg)
-- 
2.28.0

