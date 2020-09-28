Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F027B82A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgI1XbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgI1XbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:05 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84651216C4;
        Mon, 28 Sep 2020 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335864;
        bh=1uk2ydITKCZXPh14bJoTz3qsavwW7DyPhAI3heHlzN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWHC7E+us4aSzvA+LnNsw6pnIOCtCdZ351J38ylg7PONZ7bbtknnV7nEk97sTIo9Z
         wmPN9PL7V3neyYB+gyBlK7XoMvZL/oaTrDan6P3Y9J3vPYM4yE9Wlg43NinpWUJt8i
         ql8U1eIaF4E0CTzpb65MQ9xuprYVBNfMq9MUqjdw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/15] preempt: Make preempt count unconditional
Date:   Mon, 28 Sep 2020 16:30:49 -0700
Message-Id: <20200928233102.24265-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The handling of preempt_count() is inconsistent across kernel
configurations. On kernels which have PREEMPT_COUNT=n
preempt_disable/enable() and the lock/unlock functions are not affecting
the preempt count, only local_bh_disable/enable() and _bh variants of
locking, soft interrupt delivery, hard interrupt and NMI context affect it.

It's therefore impossible to have a consistent set of checks which provide
information about the context in which a function is called. In many cases
it makes sense to have separate functions for separate contexts, but there
are valid reasons to avoid that and handle different calling contexts
conditionally.

The lack of such indicators which work on all kernel configuratios is a
constant source of trouble because developers either do not understand the
implications or try to work around this inconsistency in weird
ways. Neither seem these issues be catched by reviewers and testing.

Recently merged code does:

	 gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;

Looks obviously correct, except for the fact that preemptible() is
unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
that code use GFP_ATOMIC on such kernels.

Attempts to make preempt count unconditional and consistent have been
rejected in the past with handwaving performance arguments.

Freshly conducted benchmarks did not reveal any measurable impact from
enabling preempt count unconditionally. On kernels with CONFIG_PREEMPT_NONE
or CONFIG_PREEMPT_VOLUNTARY the preempt count is only incremented and
decremented but the result of the decrement is not tested. Contrary to that
enabling CONFIG_PREEMPT which tests the result has a small but measurable
impact due to the conditional branch/call.

It's about time to make essential functionality of the kernel consistent
across the various preemption models.

Enable CONFIG_PREEMPT_COUNT unconditionally. Follow up changes will remove
the #ifdeffery and remove the config option at the end.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/Kconfig.preempt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259..3f4712f 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -75,8 +75,7 @@ config PREEMPT_RT
 endchoice
 
 config PREEMPT_COUNT
-       bool
+       def_bool y
 
 config PREEMPTION
        bool
-       select PREEMPT_COUNT
-- 
2.9.5

