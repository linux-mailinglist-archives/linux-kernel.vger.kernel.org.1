Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D327E229B80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbgGVPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGVPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:33:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E59C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Thn9yqgRHu/PXpLQKdHMdfKNVEezxunukJ744Cn+7Tk=; b=rZLTDdFfj7xkYzIiRgPTUasveK
        fWRMFGuIlvvEWwWEls4L76jddih2vhw2xmjvhAFhEVzFsEi2jGAb/vLC2uYOYsgLZRrzHXFy0BEni
        14XlhVniv7enLGJQeG9wd9TKqGX34amaheKGZvYmeaqHkhHEONaEeh7g6mkD9Su5T7H/AFGOTG37M
        c0LAMEfrmA4i39HLMH3NuLlxnAIWNPGt/m+z9Ifr/BHfGef4wRqnF45vQAViCbmWksaBGdLnEc1oR
        liw3VWaPyNt7Ux5oLfKcp3j5u+sCBYMDD2ieviyhm6PobF4ToiYh+cL3/GjppaaAWmjEV15+9iBl0
        WIS6Xh8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyGjv-000111-0l; Wed, 22 Jul 2020 15:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9121630753E;
        Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4672A200D4171; Wed, 22 Jul 2020 17:33:01 +0200 (CEST)
Message-ID: <20200722153017.243366177@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Jul 2020 17:01:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, peterz@infradead.org
Subject: [RFC][PATCH 4/9] irq_work: Unconditionally build on SMP
References: <20200722150149.525408253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
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


