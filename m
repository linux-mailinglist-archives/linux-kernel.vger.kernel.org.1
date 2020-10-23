Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6042971AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750861AbgJWOs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750723AbgJWOrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:07 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45BA62245A;
        Fri, 23 Oct 2020 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464426;
        bh=az5MB8mDXjZ//PpRg6rXDxuZ/Fc8CINMW7Dgo8UHtIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y32Bpu2oKUlLdT8bU9JpRTpVIZeyzmdQKeq1isQiGtadWyRViFb5xk/Qdm3MbsPKg
         6Guti+hw5Ms8ZWSd/B2CY4Vl6J+YhZXtXFZDNfpGowBTgNVR4/KfAguuQ09dTMsilD
         72BSQI6n3Lzf8PUn+PKBjsKwpuFufUalIxP7ONrQ=
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
Subject: [PATCH 04/16] rcu/nocb: Always init segcblist on CPU up
Date:   Fri, 23 Oct 2020 16:46:37 +0200
Message-Id: <20201023144649.53046-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An rdp's segcblist enabled state is treated differently on CPU hotplug
operations, depending on whether it is offloaded or not.

1) Not offloaded: An rdp is disabled on CPU down. All its callbacks are
   migrated and no more aren't supposed to be enqueued until it gets
   re-enabled on CPU up.

2) Offloaded: An rdp is not disabled on CPU down in order to let the
   CB/GP kthreads finish their jobs on remaining callbacks. Hence it is
   not re-enabled on CPU up either.

Since an rdp's offloaded state is set in stone at boot, we expect the
offloaded state to remain the same between CPU down and CPU up. So 1)
and 2) are symmetrical.

Now the offloaded state will become toggable at runtime. Hence the new
possible asymmetrical scenarios:

3) An rdp goes into CPU down while in a not-offloaded state. It gets
   later set to offloaded and finally goes into CPU up.

4) An rdp goes into CPU down while in an offloaded state. It gets
   later set to not-offloaded and finally goes into CPU up.

The scenario 4) is currently well handled. The rdp isn't disabled on
CPU down and it gets re-initialized on CPU up. We require the segcblist
to be empty in order to toggle to non-offloaded state while a CPU is
offlined.

The scenario 3) would run into trouble though, as the rdp is disabled
on CPU down and not re-initialized/re-enabled on CPU up.

In order to fix this, always re-initialize/re-enable an rdp on CPU up
unless it still has callbacks at that time, which anyway can only happen
when the rdp went down and up in offloaded state (case 2), the only
case that doesn't need re-initialization.

NOTE: The proper longer term fix will be to wait for all the offloaded
callbacks to be processed before completing CPU down operations. So we
can unconditionally re-initialize on CPU up.

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
 kernel/rcu/tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3b7adc9cc068..6bad7018dc18 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3940,12 +3940,18 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->qlen_last_fqs_check = 0;
 	rdp->n_force_qs_snap = rcu_state.n_force_qs;
 	rdp->blimit = blimit;
-	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
-	    !rcu_segcblist_is_offloaded(&rdp->cblist))
-		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
+	/*
+	 * Lock in case the CB/GP kthreads are still around handling
+	 * old callbacks (longer term we should flush all callbacks
+	 * before completing CPU offline)
+	 */
+	rcu_nocb_lock(rdp);
+	if (rcu_segcblist_empty(&rdp->cblist)) /* No early-boot CBs? */
+		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
+	rcu_nocb_unlock(rdp);
 
 	/*
 	 * Add CPU to leaf rcu_node pending-online bitmask.  Any needed
-- 
2.25.1

