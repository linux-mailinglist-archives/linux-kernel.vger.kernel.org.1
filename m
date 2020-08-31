Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8A25800C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHaSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgHaSB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:28 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18E8217A0;
        Mon, 31 Aug 2020 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896888;
        bh=CVEWYQgFpWW6NMnuqYywOVmxspLm8FhkQXA5CJO8Ees=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzH/NCDXmBcU8l7HCQfsqdAh760TKym4+LQGpGjTb5ypVB5oGVMFLn/W5XVZbdh78
         SJ65c01nA1AYXhHMx2GPAjsq9XoCGHNi6Jy0P4nY3zUTxPaTaSQhcId4xsx1tSZQ9f
         08Sy2vr58Fqw3FvH1wRW6r8uhrR1zzWrq6sEkMtE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        urezki@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 23/24] rcu/segcblist: Prevent useless GP start if no CBs to accelerate
Date:   Mon, 31 Aug 2020 11:01:15 -0700
Message-Id: <20200831180116.32690-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The rcu_segcblist_accelerate() function returns true iff it is necessary
to request another grace period.  A tracing session showed that this
function unnecessarily requests grace periods.

For exmaple, consider the following sequence of events:
1. Callbacks are queued only on the NEXT segment of CPU A's callback list.
2. CPU A runs RCU_SOFTIRQ, accelerating these callbacks from NEXT to WAIT.
3. Thus rcu_segcblist_accelerate() returns true, requesting grace period N.
4. RCU's grace-period kthread wakes up on CPU B and starts grace period N.
4. CPU A notices the new grace period and invokes RCU_SOFTIRQ.
5. CPU A's RCU_SOFTIRQ again invokes rcu_segcblist_accelerate(), but
   there are no new callbacks.  However, rcu_segcblist_accelerate()
   nevertheless (uselessly) requests a new grace period N+1.

This extra grace period results in additional lock contention and also
additional wakeups, all for no good reason.

This commit therefore adds a check to rcu_segcblist_accelerate() that
prevents the return of true when there are no new callbacks.

This change reduces the number of grace periods (GPs) and wakeups in each
of eleven five-second rcutorture runs as follows:

+----+-------------------+-------------------+
| #  | Number of GPs     | Number of Wakeups |
+====+=========+=========+=========+=========+
| 1  | With    | Without | With    | Without |
+----+---------+---------+---------+---------+
| 2  |      75 |      89 |     113 |     119 |
+----+---------+---------+---------+---------+
| 3  |      62 |      91 |     105 |     123 |
+----+---------+---------+---------+---------+
| 4  |      60 |      79 |      98 |     110 |
+----+---------+---------+---------+---------+
| 5  |      63 |      79 |      99 |     112 |
+----+---------+---------+---------+---------+
| 6  |      57 |      89 |      96 |     123 |
+----+---------+---------+---------+---------+
| 7  |      64 |      85 |      97 |     118 |
+----+---------+---------+---------+---------+
| 8  |      58 |      83 |      98 |     113 |
+----+---------+---------+---------+---------+
| 9  |      57 |      77 |      89 |     104 |
+----+---------+---------+---------+---------+
| 10 |      66 |      82 |      98 |     119 |
+----+---------+---------+---------+---------+
| 11 |      52 |      82 |      83 |     117 |
+----+---------+---------+---------+---------+

The reduction in the number of wakeups ranges from 5% to 40%.

Cc: urezki@gmail.com
[ paulmck: Rework commit log and comment. ]
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9a0f661..2d2a6b6b9 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -475,8 +475,16 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * Also advance to the oldest segment of callbacks whose
 	 * ->gp_seq[] completion is at or after that passed in via "seq",
 	 * skipping any empty segments.
+	 *
+	 * Note that segment "i" (and any lower-numbered segments
+	 * containing older callbacks) will be unaffected, and their
+	 * grace-period numbers remain unchanged.  For example, if i ==
+	 * WAIT_TAIL, then neither WAIT_TAIL nor DONE_TAIL will be touched.
+	 * Instead, the CBs in NEXT_TAIL will be merged with those in
+	 * NEXT_READY_TAIL and the grace-period number of NEXT_READY_TAIL
+	 * would be updated.  NEXT_TAIL would then be empty.
 	 */
-	if (++i >= RCU_NEXT_TAIL)
+	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
 	/*
-- 
2.9.5

