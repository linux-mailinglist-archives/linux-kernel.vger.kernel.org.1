Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8C92A8A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgKEXJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732660AbgKEXJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1EDD2222A;
        Thu,  5 Nov 2020 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617768;
        bh=62DzAOpAMgHQ0p0Kb9FjtK8t/M9X42x7FR7zIUClElE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUvPNvptqnpj5hc5GgbFvpuXgJn4waDCtArursRAiPrdvV3Hy7mizx4f0jcIrBxVQ
         +fcN8gyvz/O8MgQ8AIiTIHpOBxJBL9Wp7RBS03rDxx+uHt2PjdLKFsetrbje6cEkqK
         sx4JLgqa1jaQIwzwGDL5Zfg0uZ3mv/goiJeJf4t8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/16] rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs
Date:   Thu,  5 Nov 2020 15:09:16 -0800
Message-Id: <20201105230921.19017-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Testing showed that rcu_pending() can return 1 when offloaded callbacks
are ready to execute.  This invokes RCU core processing, for example,
by raising RCU_SOFTIRQ, eventually resulting in a call to rcu_core().
However, rcu_core() explicitly avoids in any way manipulating offloaded
callbacks, which are instead handled by the rcuog and rcuoc kthreads,
which work independently of rcu_core().

One exception to this independence is that rcu_core() invokes
do_nocb_deferred_wakeup(), however, rcu_pending() also checks
rcu_nocb_need_deferred_wakeup() in order to correctly handle this case,
invoking rcu_core() when needed.

This commit therefore avoids needlessly invoking RCU core processing
by checking rcu_segcblist_ready_cbs() only on non-offloaded CPUs.
This reduces overhead, for example, by reducing softirq activity.

This change passed 30 minute tests of TREE01 through TREE09 each.

On TREE08, there is at most 150us from the time that rcu_pending() chose
not to invoke RCU core processing to the time when the ready callbacks
were invoked by the rcuoc kthread.  This provides further evidence that
there is no need to invoke rcu_core() for offloaded callbacks that are
ready to invoke.

Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aaed35e..fe569db 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3718,7 +3718,8 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-- 
2.9.5

