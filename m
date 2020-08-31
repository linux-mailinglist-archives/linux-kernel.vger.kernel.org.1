Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432BC258009
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgHaSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgHaSB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C0C215A4;
        Mon, 31 Aug 2020 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896884;
        bh=ZpEymyqav3YyMpdsc6ES/niPTHg4XJIiINsSUIRbYEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3ODGLOpgu8VVg1oeFwi+e1udzdL0dGBwE+29tTqmqFFMnjHNIffWbMNK8N/I5iNc
         Wtq7TjxwUj6A46BYatfnL2WBZEcXvrEqUYnATVf2DDYRMkmvy/+L3cpGpG5x2rfBDE
         8rNJN8lrPDkgmJotUOqoa+98SKzDUqvG/7IYqgZs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/24] rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_kick_kthreads
Date:   Mon, 31 Aug 2020 11:01:05 -0700
Message-Id: <20200831180116.32690-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that sysfs can change the value of rcu_kick_kthreads at any time,
this commit adds a READ_ONCE() to the sole access to that variable.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b5d3b47..a1780a6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -158,7 +158,7 @@ static void rcu_stall_kick_kthreads(void)
 {
 	unsigned long j;
 
-	if (!rcu_kick_kthreads)
+	if (!READ_ONCE(rcu_kick_kthreads))
 		return;
 	j = READ_ONCE(rcu_state.jiffies_kick_kthreads);
 	if (time_after(jiffies, j) && rcu_state.gp_kthread &&
@@ -580,7 +580,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
-	if ((rcu_stall_is_suppressed() && !rcu_kick_kthreads) ||
+	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
-- 
2.9.5

