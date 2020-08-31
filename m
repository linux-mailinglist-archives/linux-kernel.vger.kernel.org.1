Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107E25800B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgHaSBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbgHaSB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 860C721897;
        Mon, 31 Aug 2020 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896888;
        bh=VfLU9LD+04vt7A1OohC/jg5ul0BHrmZJ47kzIFGG+7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SphRx8EQQcIeFaXcEOCbF5k7rswtq/0JO00YCuA9Xo3pO9r4EIA9hr+e2vSD1aLP
         bye6p074QAKJSLyQ/axeYT2QjUsrXFTVofxxDjU5OsVX0lWq+EQIJIO6C9umZkKJ2Y
         r/Lq/C2FraIDfaFqG28ccdQCJnbjJdM3FsF4v13k=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Zqiang <qiang.zhang@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 24/24] rcu: Shrink each possible cpu krcp
Date:   Mon, 31 Aug 2020 11:01:16 -0700
Message-Id: <20200831180116.32690-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

CPUs can go offline shortly after kfree_call_rcu() has been invoked,
which can leave memory stranded until those CPUs come back online.
This commit therefore drains the kcrp of each CPU, not just the
ones that happen to be online.

Acked-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2323622..9245064 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3450,7 +3450,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long count = 0;
 
 	/* Snapshot count of all CPUs */
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
@@ -3465,7 +3465,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	int cpu, freed = 0;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		int count;
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
@@ -3498,7 +3498,7 @@ void __init kfree_rcu_scheduler_running(void)
 	int cpu;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-- 
2.9.5

