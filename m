Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2644E258021
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgHaSDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgHaSBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:24 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9086920866;
        Mon, 31 Aug 2020 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896883;
        bh=Zv8CPkwO+8Sx8yjhF3kXqyIGO3+PF6wlIFtXzoJQavw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUkdiMtGmBH5rc5Mis/B3HC1DZ2jg4moYq59lTM1pi+jCF+8uF53hFRAEG0kaEh6U
         vtWWFAzdNfoxNgjfoSt7B/8jQnL6HsNQif2qJLMiZlkrKemgRzBicK1fmat3BXhckM
         K1x04Wc8X+PZ7kkmFkzK4mCE26xSlkTn0Z61//MA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/24] rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_resched_ns
Date:   Mon, 31 Aug 2020 11:01:04 -0700
Message-Id: <20200831180116.32690-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that sysfs can change the value of rcu_resched_ns at any time,
this commit adds a READ_ONCE() to the sole access to that variable.
While in the area, this commit also adds bounds checking, clamping the
value to at least a millisecond, but no longer than a second.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1dca14c..da05afc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2394,8 +2394,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
-	if (unlikely(bl > 100))
-		tlimit = local_clock() + rcu_resched_ns;
+	if (unlikely(bl > 100)) {
+		long rrn = READ_ONCE(rcu_resched_ns);
+
+		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
+		tlimit = local_clock() + rrn;
+	}
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
-- 
2.9.5

