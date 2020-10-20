Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8AC293D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407662AbgJTNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:47:24 -0400
Received: from mail.efficios.com ([167.114.26.124]:43586 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407645AbgJTNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:47:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C43632D91D1;
        Tue, 20 Oct 2020 09:47:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8UytBngmCBcE; Tue, 20 Oct 2020 09:47:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C31C62D8D7D;
        Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C31C62D8D7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603201639;
        bh=evGcJcZu7eb5xkZgGi9gbAmIj12E+WcIcJugnrtvDDM=;
        h=From:To:Date:Message-Id;
        b=CRE9mfL/B+vjvnlK676wVdJiqAPeWhe0xZ3oGJHNKR9P/BjDaejQ2h59XDrieQFUd
         InSmJ+4CH+/+13YNz1nDaoc6j/AayWDGzQI8ApC1rQ0ZE8HPARxQJa4O9rgGDDA0pV
         54AOmoKAezns0fS9Sl5XbA/G5C+utoE4s54zu/RPC2ApqRptc51BIcMHLDDXzBFBA7
         fnm1kC8EPmer+SHf7wISWXIV2t9fbP4RC2c86RsLdG+R0dYEN9ewkRT6xjN6VeRvVo
         Tm8Ctg/X9lEdnGMArzjWC7kHy4kzW2+IK43wUqk3FgTKKAYEuY6jTje+OlOOXjuPnW
         MpSGCwaje4CBQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gdVJCw0HO2SI; Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 439202D91CD;
        Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3/3] sched: membarrier: document memory ordering scenarios
Date:   Tue, 20 Oct 2020 09:47:15 -0400
Message-Id: <20201020134715.13909-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020134715.13909-1-mathieu.desnoyers@efficios.com>
References: <20201020134715.13909-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document membarrier ordering scenarios in membarrier.c. Thanks to Alan
Stern for refreshing my memory. Now that I have those in mind, it seems
appropriate to serialize them to comments for posterity.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 kernel/sched/membarrier.c | 128 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 8b93b6844901..943bdf5e9108 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -6,6 +6,134 @@
  */
 #include "sched.h"
 
+/*
+ * For documentation purposes, here are some membarrier ordering
+ * scenarios to keep in mind:
+ *
+ * A) Userspace thread execution after IPI vs membarrier's memory
+ *    barrier before sending the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the start of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU0 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU1 after the IPI-induced memory barrier:
+ *
+ *         CPU0                              CPU1
+ *
+ *         x = 1
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r2 = y
+ *                                           y = 1
+ *                                           barrier()
+ *                                           r1 = x
+ *
+ *                     BUG_ON(r1 == 0 && r2 == 0)
+ *
+ * The write to y and load from x by CPU1 are unordered by the hardware,
+ * so it's possible to have "r1 = x" reordered before "y = 1" at any
+ * point after (b).  If the memory barrier at (a) is omitted, then "x = 1"
+ * can be reordered after (a) (although not after (c)), so we get r1 == 0
+ * and r2 == 0.  This violates the guarantee that membarrier() is
+ * supposed by provide.
+ *
+ * The timing of the memory barrier at (a) has to ensure that it executes
+ * before the IPI-induced memory barrier on CPU1.
+ *
+ * B) Userspace thread execution before IPI vs membarrier's memory
+ *    barrier after completing the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the end of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU1 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU0 after the membarrier():
+ *
+ *         CPU0                              CPU1
+ *
+ *                                           x = 1
+ *                                           barrier()
+ *                                           y = 1
+ *         r2 = y
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r1 = x
+ *         BUG_ON(r1 == 0 && r2 == 1)
+ *
+ * The writes to x and y are unordered by the hardware, so it's possible to
+ * have "r2 = 1" even though the write to x doesn't execute until (b).  If
+ * the memory barrier at (c) is omitted then "r1 = x" can be reordered
+ * before (b) (although not before (a)), so we get "r1 = 0".  This violates
+ * the guarantee that membarrier() is supposed to provide.
+ *
+ * The timing of the memory barrier at (c) has to ensure that it executes
+ * after the IPI-induced memory barrier on CPU1.
+ *
+ * C) Scheduling userspace thread -> kthread -> userspace thread vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           d: switch to kthread (includes mb)
+ *           b: read rq->curr->mm == NULL
+ *                                           e: switch to user (includes mb)
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (e). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ *
+ * D) exit_mm vs membarrier
+ *
+ * Two thread groups are created, A and B.  Thread group B is created by
+ * issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
+ * Let's assume we have a single thread within each thread group (Thread A
+ * and Thread B).  Thread A runs on CPU0, Thread B runs on CPU1.
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *             a: smp_mb()
+ *                                           exit_mm():
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *             b: read rq->curr->mm == NULL
+ *             c: smp_mb()
+ *
+ * Using scenario (B), we can show that (c) needs to be paired with (d).
+ *
+ * E) kthread_{use,unuse}_mm vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           kthread_unuse_mm()
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *           b: read rq->curr->mm == NULL
+ *                                           kthread_use_mm()
+ *                                             f: current->mm = mm
+ *                                             g: smp_mb()
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (g). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ */
+
 /*
  * Bitmask made from a "or" of all commands within enum membarrier_cmd,
  * except MEMBARRIER_CMD_QUERY.
-- 
2.17.1

