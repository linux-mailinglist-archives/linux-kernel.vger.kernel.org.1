Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2227B829
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgI1XbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgI1XbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:04 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D782076A;
        Mon, 28 Sep 2020 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335864;
        bh=OGJxMPHPLjuEnrMo2rPzwuZXv15O/IwiP4N5EDWk7d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zL+EWn/zB78lXo7PCgBp7UC4Qek5YEX2MocgZnu0pXF52VLbYAw+XEcUCkcAiwOoq
         PR5vDP2fETCN2Z0bWuMaIGLFZc9XYx0dFX7X8af4cQOlD1IEcjHEktCqrml3ZVKzA5
         G+bcco2KVUi7UavdoECSGx1KVqx2Yljmy4wQYKX8=
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
Subject: [PATCH tip/core/rcu 01/15] lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
Date:   Mon, 28 Sep 2020 16:30:48 -0700
Message-Id: <20200928233102.24265-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

ARCH_NO_PREEMPT disables the selection of CONFIG_PREEMPT_VOLUNTARY and
CONFIG_PREEMPT, but architectures which set this config option still
support preempt count for hard and softirq accounting.

There is absolutely no reason to prevent lockdep from using the preempt
counter nor is there a reason to prevent the enablement of
CONFIG_DEBUG_ATOMIC_SLEEP on such architectures.

Remove the dependencies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c..f50fbcf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1161,7 +1161,7 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
+	select PREEMPT_COUNT
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1323,7 +1323,6 @@ config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
-	depends on !ARCH_NO_PREEMPT
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called inside atomic sections: when a spinlock is
-- 
2.9.5

