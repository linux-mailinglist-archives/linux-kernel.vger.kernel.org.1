Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0647C29D955
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbgJ1Wu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:50:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389543AbgJ1Wu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Thn9yqgRHu/PXpLQKdHMdfKNVEezxunukJ744Cn+7Tk=; b=DCCY2JzqrNAIofTLINRtIninIU
        a1rlBzms85wcDG6fpjkFODtWeJSnrEaf8/Ds/LP0Sy84xJMdvwhDwwpen+4bF1j9qsVdU8uvcQmvm
        E1ZSyNJoGYJuxT+lQ5cszzKAgoXuNzfJCwLmHbJxWT8o5BgsBX3adXDxq+zeknWpPsuprjcowYWdA
        jJviq7h4inNHF84G3URlltQwgjxkcC8ypRhvq6cJGvuplSJIZbZqzQmYuSKzYCAZug83bjyFcU+XJ
        8JW4dzFsipINye1YWqN9YSjSlvvjyvYXsgqpQBKqVaU5w5MwHrOChxWkaXyJTfQ/xLxXy+dDOSIvN
        AKXj2hxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXjOP-0005LI-Fc; Wed, 28 Oct 2020 11:13:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A41C2307197;
        Wed, 28 Oct 2020 12:13:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D4F1F20B285AB; Wed, 28 Oct 2020 12:13:21 +0100 (CET)
Message-ID: <20201028111221.464733855@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 12:07:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v3 4/6] irq_work: Unconditionally build on SMP
References: <20201028110707.971887448@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Makefile   |    1 +
 kernel/irq_work.c |    3 +++
 2 files changed, 4 insertions(+)

--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_TRACE_CLOCK) += trace/
 obj-$(CONFIG_RING_BUFFER) += trace/
 obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
+obj-$(CONFIG_SMP) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
 obj-$(CONFIG_KCSAN) += kcsan/
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_IRQ_WORK
 
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
@@ -212,3 +213,5 @@ void irq_work_sync(struct irq_work *work
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
+
+#endif /* CONFIG_IRQ_WORK */


