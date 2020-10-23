Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4643F2971A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750818AbgJWOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbgJWOrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:12 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5318A22460;
        Fri, 23 Oct 2020 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464431;
        bh=jxFG6MHUZbunBKZRg4SeYrw205Zm76tdAI9U5nNICn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roslJr4WpN+Gsx6GiZNdbj0wEyalbFKlWppUjZu6gsVbxz8vMen8LaGb6rXSCnaud
         GCmViopYpGXajMEI19XxNOgqbMAkHmICbNG9ChusPLRySarRzG8mUFf9U0YrOVvFkb
         Dm6lcm+BxTnfi15JCvMAoN1nUUITsIU+QHqUnUjc=
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
Subject: [PATCH 06/16] rcu/nocb: Don't deoffload an offline CPU with pending work
Date:   Fri, 23 Oct 2020 16:46:39 +0200
Message-Id: <20201023144649.53046-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offlining offloaded CPUs don't migrate their callbacks just like
non-offloaded CPUs do. It's up to their CB/GP kthread to handle what
remains.

Therefore we can't afford to de-offload an offline CPU that still has
pending work to do, or the callbacks would be ignored.

NOTE: The long term solution will be to wait for all pending callbacks
to be processed before completing a CPU down operation.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_plugin.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 09caf319a4a9..33e9d53d2181 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2228,6 +2228,14 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	printk("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
+	/*
+	 * If there are still pending work offloaded, the offline
+	 * CPU won't help much handling them.
+	 */
+	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		return -EBUSY;
+	}
 	raw_spin_lock_rcu_node(rnp);
 	rcu_segcblist_offload(cblist, false);
 	raw_spin_unlock_rcu_node(rnp);
-- 
2.25.1

