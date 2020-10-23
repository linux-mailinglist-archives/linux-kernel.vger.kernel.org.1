Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52312971A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbgJWOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbgJWOrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:24 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB2C20853;
        Fri, 23 Oct 2020 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464444;
        bh=bGi/rnp5UbyotlPlQTWgF7VznJ464GbGJ801ntzuXz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaT5m/4lc2DiSjujbQwaZWHgsBAyS5yyy1b2E6/CSuz6XCoYP5gGQDHYUbTCNjHnc
         9v7U7Yy4smraH8nM++2SOqIVPwxi5MC7ccl+xXboENpTIADBEqIJzHTVbXeliMOm78
         GjYtfI494XbC/+GLUMH9xJcb2GQbeGatmy5/f2QA=
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
Subject: [PATCH 11/16] rcu: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
Date:   Fri, 23 Oct 2020 16:46:44 +0200
Message-Id: <20201023144649.53046-12-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
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
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 49bd42995ae7..2f083beab9d9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2353,7 +2353,14 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
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
 
 	return ret;
 }
-- 
2.25.1

