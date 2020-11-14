Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9EC2B30E1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 22:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgKNVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 16:01:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgKNVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 16:01:48 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605387706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2A0cy+kJbvQjzVnwHknJh5VJweiz4wWIjgPTNXjz/Fc=;
        b=E0Pkuenp6m9IzF08Xi8EDY/WV/Ht0TCGhFq1hSbl057vUcXtMdA9bJbb7dsUvQ5Xm1G+1W
        cbLSBEV7Gi05GJxctFPoIKgP+wU6TqByd+/wVh2lRr3D9dCUJwXKQ1KY8USUQB5GutwpLm
        fctbuXUKivu4GoqOHkQmyXln2gk/nic8+PxOqPGCA31YPSEmneiwfDj/tGLLxLxcUYHfuy
        FkuWhz4FJBvhX5+2OQgNz7HT7lSpErDo9ntzn74kpqeCicTyOCoc4MajZ8LLB5FgKHw4nb
        vMBHtfz4wz02+iTSd2oSAF6DLys6O8FbJMf8Ga/tm6u/IR77LoVPDT3g7DVamQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605387706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2A0cy+kJbvQjzVnwHknJh5VJweiz4wWIjgPTNXjz/Fc=;
        b=brQdzKIJVFXcmQv9Qn8Kf8/lbzEhOSxNlg0RVtL1+C54F56FgTtudytSSkGCZoqEbcxpa0
        YHiXaPHd1gp2WFAg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: genirq: Remove GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
Date:   Sat, 14 Nov 2020 22:01:45 +0100
Message-ID: <87eekvac06.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bb9d812643d8 ("arch: remove tile port") removed the last user of
this cruft two years ago...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h  |   15 ---------------
 kernel/irq/Kconfig   |    5 -----
 kernel/irq/irqdesc.c |   51 ---------------------------------------------------
 3 files changed, 71 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -954,21 +954,6 @@ static inline void irq_free_desc(unsigne
 	irq_free_descs(irq, 1);
 }
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-unsigned int irq_alloc_hwirqs(int cnt, int node);
-static inline unsigned int irq_alloc_hwirq(int node)
-{
-	return irq_alloc_hwirqs(1, node);
-}
-void irq_free_hwirqs(unsigned int from, int cnt);
-static inline void irq_free_hwirq(unsigned int irq)
-{
-	return irq_free_hwirqs(irq, 1);
-}
-int arch_setup_hwirq(unsigned int irq, int node);
-void arch_teardown_hwirq(unsigned int irq);
-#endif
-
 #ifdef CONFIG_GENERIC_IRQ_LEGACY
 void irq_init_desc(unsigned int irq);
 #endif
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -26,11 +26,6 @@ config GENERIC_IRQ_SHOW_LEVEL
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
        bool
 
-# Facility to allocate a hardware interrupt. This is legacy support
-# and should not be used in new code. Use irq domains instead.
-config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-       bool
-
 # Support for delayed migration from interrupt context
 config GENERIC_PENDING_IRQ
 	bool
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -810,57 +810,6 @@ int __ref
 }
 EXPORT_SYMBOL_GPL(__irq_alloc_descs);
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-/**
- * irq_alloc_hwirqs - Allocate an irq descriptor and initialize the hardware
- * @cnt:	number of interrupts to allocate
- * @node:	node on which to allocate
- *
- * Returns an interrupt number > 0 or 0, if the allocation fails.
- */
-unsigned int irq_alloc_hwirqs(int cnt, int node)
-{
-	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL, NULL);
-
-	if (irq < 0)
-		return 0;
-
-	for (i = irq; cnt > 0; i++, cnt--) {
-		if (arch_setup_hwirq(i, node))
-			goto err;
-		irq_clear_status_flags(i, _IRQ_NOREQUEST);
-	}
-	return irq;
-
-err:
-	for (i--; i >= irq; i--) {
-		irq_set_status_flags(i, _IRQ_NOREQUEST | _IRQ_NOPROBE);
-		arch_teardown_hwirq(i);
-	}
-	irq_free_descs(irq, cnt);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(irq_alloc_hwirqs);
-
-/**
- * irq_free_hwirqs - Free irq descriptor and cleanup the hardware
- * @from:	Free from irq number
- * @cnt:	number of interrupts to free
- *
- */
-void irq_free_hwirqs(unsigned int from, int cnt)
-{
-	int i, j;
-
-	for (i = from, j = cnt; j > 0; i++, j--) {
-		irq_set_status_flags(i, _IRQ_NOREQUEST | _IRQ_NOPROBE);
-		arch_teardown_hwirq(i);
-	}
-	irq_free_descs(from, cnt);
-}
-EXPORT_SYMBOL_GPL(irq_free_hwirqs);
-#endif
-
 /**
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
