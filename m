Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3613F2A8A73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbgKEXJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732698AbgKEXJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 282F622243;
        Thu,  5 Nov 2020 23:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617770;
        bh=YG+T/KjOLKB+FKkyIhUQg8laeCA5qTCVg+kbJd/OhfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJXY9LLgj98lRjmdF6iLKKY2jR9WKMUTqvRKSvmwrGAIrsLN2B2hifArBS+L9LQfO
         VlwQsk5UFircvmhCm+A9/8a783Bkgv/xO83tkpn3hmeAk5OQwP/e5RnDGxkus6jV5O
         O+YDCEi0jHuZjZgum3U5tc6eY/iGIWRmHt2z2K/Y=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/16] srcu: Take early exit on memory-allocation failure
Date:   Thu,  5 Nov 2020 15:09:21 -0800
Message-Id: <20201105230921.19017-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

It turns out that init_srcu_struct() can be invoked from usermode tasks,
and that fatal signals received by these tasks can cause memory-allocation
failures.  These failures are not handled well by init_srcu_struct(),
so much so that NULL pointer dereferences can result.  This commit
therefore causes init_srcu_struct() to take an early exit upon detection
of memory-allocation failure.

Link: https://lore.kernel.org/lkml/20200908144306.33355-1-aik@ozlabs.ru/
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c13348e..6f7880a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -177,11 +177,13 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
+	if (!ssp->sda)
+		return -ENOMEM;
 	init_srcu_struct_nodes(ssp, is_static);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
-	return ssp->sda ? 0 : -ENOMEM;
+	return 0;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.9.5

