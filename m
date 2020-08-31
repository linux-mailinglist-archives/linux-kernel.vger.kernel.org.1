Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101C2258076
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHaSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbgHaSL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D5021582;
        Mon, 31 Aug 2020 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897483;
        bh=Rv0QZkvfDdaY44ySjZ0q9xWVE/nXdfi0BEhRe/LkNJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F//kdZpK/us8mF8Zv8ksYtCpbBUxKNMMifuPBJnt9UsxtRgquv3eedgLk+a+ETbCr
         HgIYRfnGP7+bbtscWsgElFzmgvyH9K0/Vw/7/SdIpERs0aNkbObVRGYvWgJivaATIm
         TzCVKWMwZFTP/ocDD12LzQcyFATKbRszLvjcHAkE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/13] rcu: IPI all CPUs at GP end for strict GPs
Date:   Mon, 31 Aug 2020 11:11:16 -0700
Message-Id: <20200831181120.1044-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, each CPU discovers the end of a given grace period on its
own time, which is again good for efficiency but bad for fast grace
periods, given that it is things like kfree() within the RCU callbacks
that will cause trouble for pointers leaked from RCU read-side critical
sections.  This commit therefore uses on_each_cpu() to IPI each CPU
after grace-period cleanup in order to inform each CPU of the end of
the old grace period in a timely manner, but only in kernels build with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 88f4fa6..4bbedfc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2052,6 +2052,10 @@ static void rcu_gp_cleanup(void)
 			   rcu_state.gp_flags & RCU_GP_FLAG_INIT);
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
+
+	// If strict, make all CPUs aware of the end of the old grace period.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 }
 
 /*
-- 
2.9.5

