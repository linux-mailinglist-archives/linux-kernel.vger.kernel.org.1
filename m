Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE87B2EC1F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbhAFRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbhAFRSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26C812313A;
        Wed,  6 Jan 2021 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953433;
        bh=5BoiNrYJZyMPFNIGzBh9BJRNr8Z28Flj2zdht1Qu29I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPd+Xm9Nned4zAIog71ukzdXpTf64C5ZevfJegTFjHN1W+fbo/hc25Hc/czakc7H4
         2pYmXeTzsJb0thSO9wJgMrTcbI/wJY072sP+IMwPALGK0T5lcdREELqq77dm7MbdOF
         zyY2C3yHg/vpFf+nBHpOXrzrQtos8mW8xR72gCFgJpJzFNxwAgCxXx3z5VDfjGQK7Q
         Y/Z0qjE5RfJg5Q9o3d+1iq6HNBdKpIo/m9KsNFY9qbgiUpeWMsnCg92Xgi3clkG9oJ
         ugo8cpG/wFuvSer6GWPPTpqI2UX9F4VIThFVboBnqRKonSamL2CocshWRyVNEABBXy
         M1GmGhZBqduXg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/17] rcutorture: Make rcu_torture_fakewriter() use blocking wait primitives
Date:   Wed,  6 Jan 2021 09:16:59 -0800
Message-Id: <20210106171710.22239-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Full testing of the new SRCU polling API requires that the fake
writers also use it in order to test concurrent calls to all of the API
members, especially start_poll_synchronize_srcu().  This commit makes
rcu_torture_fakewriter() use all available blocking grace-period-wait
primitives available from the RCU flavor under test.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ea44a2b..1b70aa4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1289,6 +1289,8 @@ rcu_torture_writer(void *arg)
 static int
 rcu_torture_fakewriter(void *arg)
 {
+	unsigned long gp_snap;
+	int i;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fakewriter task started");
@@ -1300,15 +1302,37 @@ rcu_torture_fakewriter(void *arg)
 		if (cur_ops->cb_barrier != NULL &&
 		    torture_random(&rand) % (nfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
-		} else if (gp_normal == gp_exp) {
-			if (cur_ops->sync && torture_random(&rand) & 0x80)
-				cur_ops->sync();
-			else if (cur_ops->exp_sync)
+		} else {
+			switch (synctype[torture_random(&rand) % nsynctypes]) {
+			case RTWS_DEF_FREE:
+				break;
+			case RTWS_EXP_SYNC:
 				cur_ops->exp_sync();
-		} else if (gp_normal && cur_ops->sync) {
-			cur_ops->sync();
-		} else if (cur_ops->exp_sync) {
-			cur_ops->exp_sync();
+				break;
+			case RTWS_COND_GET:
+				gp_snap = cur_ops->get_gp_state();
+				i = torture_random(&rand) % 16;
+				if (i != 0)
+					schedule_timeout_interruptible(i);
+				udelay(torture_random(&rand) % 1000);
+				cur_ops->cond_sync(gp_snap);
+				break;
+			case RTWS_POLL_GET:
+				gp_snap = cur_ops->start_gp_poll();
+				while (!cur_ops->poll_gp_state(gp_snap)) {
+					i = torture_random(&rand) % 16;
+					if (i != 0)
+						schedule_timeout_interruptible(i);
+					udelay(torture_random(&rand) % 1000);
+				}
+				break;
+			case RTWS_SYNC:
+				cur_ops->sync();
+				break;
+			default:
+				WARN_ON_ONCE(1);
+				break;
+			}
 		}
 		stutter_wait("rcu_torture_fakewriter");
 	} while (!torture_must_stop());
-- 
2.9.5

