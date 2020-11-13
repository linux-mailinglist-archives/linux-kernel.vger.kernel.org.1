Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF102B1D46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKMOZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:25:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgKMOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:26 -0500
Message-Id: <20201113141733.625146223@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=j4YFkLEVJW9mHHVjXYizVQN08g6GeJTUUb5qDNcMGts=;
        b=X0A7oXXLl77tzShFHyL2be6dGuH2n0ajai/5PNHmXMm2Nduo9l3C78d2rRfs8um7hiajwz
        LLHAaVgSEsf6QYSzwSiDzq7rbw2QitpZ/aAANOMbAqrig6bybRybNZB2muYuDrXv5T0Hog
        aHx9kd4TQ2jtGQ+JxY6sbWUbsBVwCq+pV/QRiq3z6aaCJCLE9A1b9C5fsm24FrH0YwrudH
        abLQf3y2N1gR3t9uvLayu0DU2BCqPqAeUlywRucg5A6Eb8qDHpfmNIYKW7ulE/xc0pSBjS
        U0YyqBRBrS8x2r8DBsXej93yuZ/6flBjmjqANnRgpcLYv59gobr0sTeVHTdWZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=j4YFkLEVJW9mHHVjXYizVQN08g6GeJTUUb5qDNcMGts=;
        b=IfoJhzBOzwM0Ah30l/7drK6GoTjrrURxvcwYoU7580CtlGXgaQQtBYwJYv96kjOc5mH649
        PlRaWsaQfp6lUCDg==
Date:   Fri, 13 Nov 2020 15:02:15 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 08/19] sh: irqstat: Use the generic irq_cpustat_t
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SH can now use the generic irq_cpustat_t. Define ack_bad_irq so the generic
header does not emit the generic version of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/hardirq.h |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/arch/sh/include/asm/hardirq.h
+++ b/arch/sh/include/asm/hardirq.h
@@ -2,16 +2,10 @@
 #ifndef __ASM_SH_HARDIRQ_H
 #define __ASM_SH_HARDIRQ_H
 
-#include <linux/threads.h>
-#include <linux/irq.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-	unsigned int __nmi_count;		/* arch dependent */
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 extern void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq ack_bad_irq
+#define ARCH_WANTS_NMI_IRQSTAT
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_SH_HARDIRQ_H */

