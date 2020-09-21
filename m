Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25E2272419
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIUMoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgIUMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:44:16 -0400
Received: from lenoir.home (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BD021BE5;
        Mon, 21 Sep 2020 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600692256;
        bh=JmVHmlHA6JccXUGbRcmXBHQFl1BTEkaRwH2UiiQCbOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zvfZipf2WwpO7SwV3RQ6Z03/mKUJVCJmrrbyI1DKpYt2lQe4Hx/88Jyo85xptI9va
         JyDnhbeXkZe8YacYMPR7wGKZb1E2gMyOUl98UdrwXkYlYVld2Blp6XBjI6cMYLXxWO
         RawUDdZ311kunzRVJc2FrVEnYgSlrPSa77/zvic0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH 09/12] rcu: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
Date:   Mon, 21 Sep 2020 14:43:48 +0200
Message-Id: <20200921124351.24035-10-frederic@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921124351.24035-1-frederic@kernel.org>
References: <20200921124351.24035-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set SEGCBLIST_SOFTIRQ_ONLY once everything is settled. After that, the
callbacks are handled locklessly and locally.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index cee15841c178..ef09897c8f2c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2312,7 +2312,14 @@ static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	 * enqueued on bypass.
 	 */
 	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
+	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
+	/*
+	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
+	 * rcu_nocb_unlock_irqrestore() anymore. Theoretically we
+	 * could set SEGCBLIST_SOFTIRQ_ONLY with cb unlocked and IRQs
+	 * disabled now, but let's be paranoid.
+	 */
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 }
 
 static long rcu_nocb_rdp_deoffload(void *arg)
-- 
2.28.0

