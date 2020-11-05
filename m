Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0F42A8A76
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbgKEXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:09:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbgKEXJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA6C322227;
        Thu,  5 Nov 2020 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617767;
        bh=HhvHdO7A5VVPWKmO1W7LwWqDfVAt2vIcpulVCjrP4w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WR4//QL09aWY1n3s+BKaq6ZwOHRkPHpzIUHgRoRIwZLEnC5VeANOutb1wGmzvWeY
         oVFpsAjjUM9S2/IWwLLlgGRbz5cCzh6oi+jGlRcLRkRizurRJThxcXrTa/eiewhND2
         nsHyzo0bwgDhAJmKluYnj3N3iWmIFmqw6LaO10Tw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/16] rcu,ftrace: Fix ftrace recursion
Date:   Thu,  5 Nov 2020 15:09:15 -0800
Message-Id: <20201105230921.19017-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Kim reported that perf-ftrace made his box unhappy. It turns out that
commit:

  ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")

removed one too many notrace qualifiers, probably due to there not being
a helpful comment.

This commit therefore reinstates the notrace and adds a comment to avoid
losing it again.

[ paulmck: Apply Steven Rostedt's feedback on the comment. ]
Fixes: ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
Reported-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a9b7c9a..aaed35e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1093,8 +1093,11 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
  * CPU can safely enter RCU read-side critical sections.  In other words,
  * if the current CPU is not in its idle loop or is in an interrupt or
  * NMI handler, return true.
+ *
+ * Make notrace because it can be called by the internal functions of
+ * ftrace, and making this notrace removes unnecessary recursion calls.
  */
-bool rcu_is_watching(void)
+notrace bool rcu_is_watching(void)
 {
 	bool ret;
 
-- 
2.9.5

