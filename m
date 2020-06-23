Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C37D204526
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbgFWAVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbgFWAVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F73207BC;
        Tue, 23 Jun 2020 00:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871709;
        bh=fU6W1mx7Mvw4FUa7SJkFbMPJ0L55/o+J4pVf+Hoys1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9Sh0nM8yges2us8955FZJzV7I0kAwHJVRCTssPeL72l6wxi7YI8zy5e1dZ5r1QPK
         CUUFrE/v7g0tXGqhtNthXNj8TQ5DKaEUfD7TlU3oAw4i0fPOYTGAgCZwt+gpPdCz56
         JvFvGvUlJPRg3dsA6G8zG2dXO2dsfU2+CVawudRo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yang <richard.weiyang@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/26] rcu: Simplify the calculation of rcu_state.ncpus
Date:   Mon, 22 Jun 2020 17:21:24 -0700
Message-Id: <20200623002147.25750-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@gmail.com>

There is only 1 bit set in mask, which means that the only difference
between oldmask and the new one will be at the position where the bit is
set in mask.  This commit therefore updates rcu_state.ncpus by checking
whether the bit in mask is already set in rnp->expmaskinitnext.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c716ead..9caaeee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3824,10 +3824,9 @@ void rcu_cpu_starting(unsigned int cpu)
 {
 	unsigned long flags;
 	unsigned long mask;
-	int nbits;
-	unsigned long oldmask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	bool newcpu;
 
 	if (per_cpu(rcu_cpu_started, cpu))
 		return;
@@ -3839,12 +3838,10 @@ void rcu_cpu_starting(unsigned int cpu)
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-	oldmask = rnp->expmaskinitnext;
+	newcpu = !(rnp->expmaskinitnext & mask);
 	rnp->expmaskinitnext |= mask;
-	oldmask ^= rnp->expmaskinitnext;
-	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
-	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
-- 
2.9.5

