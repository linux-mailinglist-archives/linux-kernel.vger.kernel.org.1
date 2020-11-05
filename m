Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10C52A8AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbgKEXZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732585AbgKEXY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:58 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7EB22203;
        Thu,  5 Nov 2020 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618697;
        bh=i66/RTzrfyFgisQYwKZ10N2f6nbfwPZTHh0SE8IirIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3b39y9sZOg+WncN2OU7xs5aVMngCHle+wig0g4OvOhj2n8mCex7hgXc/jxjSsD6X
         m9ciAnKUUIbkhWv/tpb+JW0XOpW0MAn2PR9YO7+NukqWZnd/MDsS+ziCMXjU6Kw6nT
         CHhtl0x/tsBTY6UGZ10MADFKdfg2x89EsZEY2odM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jakub Kicinski <kuba@kernel.org>, paulmck@kernel.org
Subject: [PATCH tip/core/rcu 5/7] srcu: Use a more appropriate lockdep helper
Date:   Thu,  5 Nov 2020 15:24:52 -0800
Message-Id: <20201105232454.19919-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105232345.GA19179@paulmck-ThinkPad-P72>
References: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

The lockdep_is_held() macro is defined as:

 #define lockdep_is_held(lock)		lock_is_held(&(lock)->dep_map)

This hides away the dereference, so that builds with !LOCKDEP don't break.
This works in current kernels because the RCU_LOCKDEP_WARN() eliminates
its condition at preprocessor time in !LOCKDEP kernels.  However, later
patches in this series will cause the compiler to see this condition even
in !LOCKDEP kernels.  This commit prepares for this upcoming change by
switching from lock_is_held() to lockdep_is_held().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: jiangshanlai@gmail.com
CC: paulmck@kernel.org
CC: josh@joshtriplett.org
CC: rostedt@goodmis.org
CC: mathieu.desnoyers@efficios.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c13348e..6cd6fa2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -906,7 +906,7 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 {
 	struct rcu_synchronize rcu;
 
-	RCU_LOCKDEP_WARN(lock_is_held(&ssp->dep_map) ||
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
 			 lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
-- 
2.9.5

