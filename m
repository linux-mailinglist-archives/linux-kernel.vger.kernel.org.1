Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F062EB90F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbhAFEuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbhAFEuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B02822D01;
        Wed,  6 Jan 2021 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908537;
        bh=UnD48NmW6BOlX27GwWs89YVapaipnYJPMncaS2Q2YQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKzuZcQUV1iO1g+wQ1OOt91QT7LyxrNdR2suqblkc9yLEBsrp9CRuoXdtm9XmZL3F
         TidAqF0dCkXhcE0qIQq3FnuajjJHHGs9cpz5sFfp13mRt7KVQ0roKxIASUfmkIVhrM
         VEBTqgaooK1TzjCpN83vw+WOItZ2v2EpU0s4PLujehB97iNddRbwdY6y7v7gkvj9mn
         q2aPtdxkA1tMg47rj0P8yujyWihXIFurDw9BBO3Cl8fOqnYaz+twsuxABktezIYJ9l
         msLuIRkUxTTNP8jvghMSRj7sJlwnWYb3bvdmYo9U+LRuDdOi+wEal8sBorfm8uYe0w
         d746bjL/RRKpw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/21] rcu/nocb: Only cond_resched() from actual offloaded batch processing
Date:   Tue,  5 Jan 2021 20:48:43 -0800
Message-Id: <20210106044853.20812-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

During a toggle operations, rcu_do_batch() may be invoked concurrently
by softirqs and offloaded processing for a given CPU's callbacks.
This commit therefore makes sure cond_resched() is invoked only from
the offloaded context.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 83362f6..4ef59a5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2516,8 +2516,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			/* Exceeded the time limit, so leave. */
 			break;
 		}
-		if (offloaded) {
-			WARN_ON_ONCE(in_serving_softirq());
+		if (!in_serving_softirq()) {
 			local_bh_enable();
 			lockdep_assert_irqs_enabled();
 			cond_resched_tasks_rcu_qs();
-- 
2.9.5

