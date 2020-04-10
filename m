Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34231A4AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDJUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 16:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDJUPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:15:05 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A332083E;
        Fri, 10 Apr 2020 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586549705;
        bh=3X97Uc+WPGTMXUU6SUFxMarYTyFxX0mmxOop8ri5ejI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YmkKEpff32bSfwR5xqLDDeFK4RrH8udF4Mf9cupl9k/9ECO69BpYsHEH+ACHfl2ow
         BzHgdtJowdY8bqJ8USHRJtGgooCUkZmyIc944QFvtr7DIsy9SFcr2vfaJxrmKj0w4u
         DMLqePsYs65/Kq54La85JxnnLtjiULBTF92anFPk=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 1/2] irq_work: Fix checking of IRQ_WORK_LAZY flag set on non PREEMPT_RT
Date:   Fri, 10 Apr 2020 15:15:01 -0500
Message-Id: <9d57c7003732523a6bd73792f263265e9c0ce162.1586549682.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586549682.git.zanussi@kernel.org>
References: <cover.1586549682.git.zanussi@kernel.org>
In-Reply-To: <cover.1586549682.git.zanussi@kernel.org>
References: <cover.1586549682.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

v4.14.175-rt81-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream 4.19-rt commit a854c3525b7082189996a41c1dc057dcb138e305 ]

When CONFIG_PREEMPT_RT_FULL is not set, some of the checks for using
lazy_list are not properly made as the IRQ_WORK_LAZY is not checked. There's
two locations that need this update, so a use_lazy_list() helper function is
added and used in both locations.

Link: https://lore.kernel.org/r/20200321230028.GA22058@duo.ucw.cz
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/irq_work.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2899ba0d23d1..838b56cef5fe 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -57,6 +57,12 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static inline bool use_lazy_list(struct irq_work *work)
+{
+	return (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+		|| (work->flags & IRQ_WORK_LAZY);
+}
+
 #ifdef CONFIG_SMP
 /*
  * Enqueue the irq_work @work on @cpu unless it's already pending
@@ -78,7 +84,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+	if (use_lazy_list(work))
 		list = &per_cpu(lazy_list, cpu);
 	else
 		list = &per_cpu(raised_list, cpu);
@@ -95,7 +101,7 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 bool irq_work_queue(struct irq_work *work)
 {
 	struct llist_head *list;
-	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+	bool lazy_work;
 
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
@@ -106,7 +112,7 @@ bool irq_work_queue(struct irq_work *work)
 
 	lazy_work = work->flags & IRQ_WORK_LAZY;
 
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+	if (use_lazy_list(work))
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
-- 
2.17.1

