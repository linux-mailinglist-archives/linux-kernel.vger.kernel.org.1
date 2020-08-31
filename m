Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0003225802F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgHaSEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbgHaSEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DEA2145D;
        Mon, 31 Aug 2020 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897048;
        bh=iMkwxDd3YrTJpp4F9jO9Wr9+IbHF1XwKyVCOl8Pmq9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpTHqBWVFhjftHHF6xyoTDtxFFb+j1zJcGS+5rDT2OqyCmKepzMPp9v2Pc5TpICnE
         EE1RfvTxThPWFQLAY/y9UNG/ZUQmvHs/WcH+k5yCxNYoGiv2pfTMBVCjEY7DL6G8XT
         2FdcZhq94sUYsWdieeXUmu7Wo1rkabHmeLWONyOc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/14] rcutorture: Output number of elapsed grace periods
Date:   Mon, 31 Aug 2020 11:03:54 -0700
Message-Id: <20200831180406.494-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit adds code to print the grace-period number at the start
of the test along with both the grace-period number and the number of
elapsed grace periods at the end of the test.  Note that variants of
RCU)without the notion of a grace-period number (for example, Tiny RCU)
just print zeroes.

[ paulmck: Adjust commit log. ]
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index db37861..c8206ff 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -172,6 +172,7 @@ static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
+static unsigned long start_gp_seq;
 
 static int rcu_torture_writer_state;
 #define RTWS_FIXED_DELAY	0
@@ -2469,8 +2470,9 @@ rcu_torture_cleanup(void)
 
 	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
 	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
-	pr_alert("%s:  End-test grace-period state: g%lu f%#x\n",
-		 cur_ops->name, gp_seq, flags);
+	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
+		 cur_ops->name, (long)gp_seq, flags,
+		 rcutorture_seq_diff(gp_seq, start_gp_seq));
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
 	if (rcu_torture_can_boost())
@@ -2594,6 +2596,8 @@ rcu_torture_init(void)
 	long i;
 	int cpu;
 	int firsterr = 0;
+	int flags = 0;
+	unsigned long gp_seq = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
 		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops,
@@ -2636,6 +2640,11 @@ rcu_torture_init(void)
 			nrealreaders = 1;
 	}
 	rcu_torture_print_module_parms(cur_ops, "Start of test");
+	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
+	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	start_gp_seq = gp_seq;
+	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
+		 cur_ops->name, (long)gp_seq, flags);
 
 	/* Set up the freelist. */
 
-- 
2.9.5

