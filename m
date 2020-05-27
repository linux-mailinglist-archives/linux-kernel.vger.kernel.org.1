Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF471E45E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbgE0O3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbgE0O3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:29:18 -0400
Received: from lenoir.home (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E159208C3;
        Wed, 27 May 2020 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590589757;
        bh=OaAVBBewm6BZDZCoIu2UlgLgiBkFjNnLDhJvBL1agRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKXXcG488byB5Zxnm85C7o5H2EyNr1fAroH1ILEbTlDP+ZAAkS0eXG6mwfyScLvLZ
         BgbYaroEJyD0jCuXmbjrzdapDf0JHAwkWPAjohOz9AUA8ZUOs/PdAIiuEBBJFVlLba
         f1gEL2XurbvbUyI2qwsnkRl6eAEw+GrJkBhmbWKw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>
Subject: [PATCH 1/2] kthread: Switch to cpu_possible_mask
Date:   Wed, 27 May 2020 16:29:08 +0200
Message-Id: <20200527142909.23372-2-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527142909.23372-1-frederic@kernel.org>
References: <20200527142909.23372-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <mtosatti@redhat.com>

Next patch will switch unbound kernel threads mask to
housekeeping_cpumask(), a subset of cpu_possible_mask. So in order to
ease bisection, lets first switch kthreads default affinity from
cpu_all_mask to cpu_possible_mask.

It looks safe to do so as cpu_possible_mask seem to be initialized
at setup_arch() time, way before kthreadd is created.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Chris Friesen <chris.friesen@windriver.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jim Somerville <Jim.Somerville@windriver.com>
Cc: Christoph Lameter <cl@linux.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..788bec94aca7 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -360,7 +360,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_all_mask);
+		set_cpus_allowed_ptr(task, cpu_possible_mask);
 	}
 	kfree(create);
 	return task;
@@ -585,7 +585,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_all_mask);
+	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
-- 
2.26.2

