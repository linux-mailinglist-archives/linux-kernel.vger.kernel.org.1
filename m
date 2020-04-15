Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4E1AAF32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416374AbgDORLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410726AbgDORLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F8D21927;
        Wed, 15 Apr 2020 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970661;
        bh=mlApiG8qTOwKhA8HRb4oZyqEFXkqBHFParB9JqIEgEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eqyw29CcPH3nQsxH0nGWEb+OBAAFCvW7E9TIq2YNPd8stLv1xpkCxHcC+CL33mOqM
         +E9tAWaN+nWotg9YZcaSM9RG88c61Bc3ZQHpXI8y8FW0LEmzA+1M09yrXWsVNNQSCd
         uRYFvE3PTgKxnnjfBiYjMNkP2/B0dRX6D20dKNZg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/19] rcu: Convert ULONG_CMP_GE() to time_after() for jiffy comparison
Date:   Wed, 15 Apr 2020 10:10:52 -0700
Message-Id: <20200415171054.9013-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the ULONG_CMP_GE() in rcu_gp_fqs_loop() to
time_after() to reflect the fact that it is comparing a timestamp to
the jiffies counter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 97c0b47..66321cc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1700,7 +1700,7 @@ static void rcu_gp_fqs_loop(void)
 		    !rcu_preempt_blocked_readers_cgp(rnp))
 			break;
 		/* If time for quiescent-state forcing, do it. */
-		if (ULONG_CMP_GE(jiffies, rcu_state.jiffies_force_qs) ||
+		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
 		    (gf & RCU_GP_FLAG_FQS)) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
-- 
2.9.5

