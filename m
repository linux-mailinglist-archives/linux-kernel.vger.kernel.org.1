Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780682CF2CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbgLDRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgLDRKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:32 -0500
Message-Id: <20201204170804.889561591@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4e6w51D2zYSiWrsd35tAgMKU9G97HBIk2T2aNo2cbgQ=;
        b=SWGKe1/s2StmkieGd9hRhA5zP7Ytn0LB6SzrOk3YrGC47rtZs/MYGsW+Fg3PeE3imHw4/W
        k09YCGu5UecuHEPH7aqQRydAbSwhMFbp1KZdXFsLjeK7J010SPvwn+YmepNj+/9iGRUUKu
        69+za6KQSnp0gO/UsMbcrmrAlhjiD2XOSg9Nk5pdzU6at/cLoCb7dF97BZ2BPeX3YcuE2q
        zFfG6zx44TqxwKHBabbZHA2B4z7vw8zDiaFXtG6p3b2m2wy8nSAStyiegg7ib2m9wr2xfC
        89yMN6TQmyE09Xqb//aFkc4hYOmw0px35io4hlM/5QiwkR/wjbMj5d3Q9dl6Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4e6w51D2zYSiWrsd35tAgMKU9G97HBIk2T2aNo2cbgQ=;
        b=7dEXI2OllpsUZf5FlPENJUHaVBBGrR1I1kVMRT8LRS7RnYhaDZHPDlHccIeNlNhGHd7U5t
        h0XOUcVxzyVFpgBA==
Date:   Fri, 04 Dec 2020 18:01:53 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 2/9] irqtime: Make accounting correct on RT
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vtime_account_irq and irqtime_account_irq() base checks on preempt_count()
which fails on RT because preempt_count() does not contain the softirq
accounting which is seperate on RT.

These checks do not need the full preempt count as they only operate on the
hard and softirq sections.

Use irq_count() instead which provides the correct value on both RT and non
RT kernels. The compiler is clever enough to fold the masking for !RT:

       99b:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax
 -     9a2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
 +     9a2:	25 00 ff ff 00       	and    $0xffff00,%eax

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 kernel/sched/cputime.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -60,7 +60,7 @@ void irqtime_account_irq(struct task_str
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
-	pc = preempt_count() - offset;
+	pc = irq_count() - offset;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -421,7 +421,7 @@ void vtime_task_switch(struct task_struc
 
 void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
-	unsigned int pc = preempt_count() - offset;
+	unsigned int pc = irq_count() - offset;
 
 	if (pc & HARDIRQ_OFFSET) {
 		vtime_account_hardirq(tsk);

