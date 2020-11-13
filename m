Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209572B1D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKMOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgKMOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2379C0613D1;
        Fri, 13 Nov 2020 06:24:20 -0800 (PST)
Message-Id: <20201113141733.156361337@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=r+KsoatkzEvFJZ6Uvemw+0bRBnybVbuAAET/CM5K9Pk=;
        b=O0Gw/PBRfyV5eSjQcVbv7jg+mEj3vPu+omjz2/4gumbSqYTwbod9fjfxDBec4KD3ldbfj1
        PKTwzSBW+XPJ5yA4AToMdseNerHoIbd6/J6Ak2g0AJSySvu1E1qwcXempGYdbHR3E9L8m6
        HUkEVjg30iV6HuEAWXHO5t5JWELG7hR7rYG86QhVorHRWkTx3bfNZ1QZCbNLkbHGThTj9h
        Gmy1CtUgQRty4mQJxzs5u4m4E890g/7qSRuvoEBxpoozS8r8bgiVGBYkFzTvoHfi2Ge2xV
        wl4VyGJTXnKlI48Yyl9nD27SGp7lD50AAUO7KCpatdJr9vU0agxVjcJ6SLopZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=r+KsoatkzEvFJZ6Uvemw+0bRBnybVbuAAET/CM5K9Pk=;
        b=xm6caWshtGnMX9Pmj2feIgupPTX3uOPlK73ZAKK12FC5HYr0Iu+WtgRZY/vqPeNKeXFDjU
        JzBZ9C0kLyStR8Bw==
Date:   Fri, 13 Nov 2020 15:02:11 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 04/19] um/irqstat: Get rid of the duplicated declarations
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_cpustat_t and ack_bad_irq() are exactly the same as the asm-generic
ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/hardirq.h |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -2,22 +2,7 @@
 #ifndef __ASM_UM_HARDIRQ_H
 #define __ASM_UM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-#include <linux/irq.h>
-
-#ifndef ack_bad_irq
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
-#endif
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
 

