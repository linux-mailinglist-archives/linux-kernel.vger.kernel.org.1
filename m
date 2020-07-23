Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4222B744
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGWULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:11:02 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:52420 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726033AbgGWULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:11:01 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 21911950-1500050 
        for multiple; Thu, 23 Jul 2020 21:10:44 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: Warn if garbage is passed to default_wake_function()
Date:   Thu, 23 Jul 2020 21:10:42 +0100
Message-Id: <20200723201042.18861-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the default_wake_function() passes its flags onto
try_to_wake_up(), warn if those flags collide with internal values.
Given that the supplied flags are garbage, no repair can be done but at
least alert the user to the damage they are causing.

In the belief that these errors should be picked up during testing, the
warning is only compiled in under CONFIG_SCHED_DEBUG.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7b918059332b..4be209266d8a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4481,6 +4481,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
-- 
2.20.1

