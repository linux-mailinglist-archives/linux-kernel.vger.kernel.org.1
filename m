Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E8C2B1D21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKMOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgKMOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:22 -0500
Message-Id: <20201113141733.276505871@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LTgrOO5Fq9FzIj5LSBGHqN8dEDpi/W15DA3S3hhXg70=;
        b=cSGo9Tj3VjO3e4v7/dAH4IZZ25PwX3n0as7D8hV6VwZCQNPp1S/12d3Kuq14YP2Q+vyrH8
        jJ/wX30Nie2wEr/7EzpBjuF3iQ1GzsFOZEuMiW2uttAjvlghPcqlVwST2tjAzHciJ3rLq2
        7uMKgBEOH2VHJqnsUsfRZ0RZTXOPOxBG+ztScXR/kk53gqcz+APJbPKljJlmOTBDu0qFSd
        geRk0h1rhyNhLZUWadkKhKDlm2LK9xR6e6jqW+rtDsZmAZ0P4di9X83bBTcSkBrFBjeZOz
        jTvXn+8jksC0VgwFXsC/4El8Vh0d+LxM/viS14PxPZXkBWuZlPiBQb7W9OznGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LTgrOO5Fq9FzIj5LSBGHqN8dEDpi/W15DA3S3hhXg70=;
        b=noONE0INwvcUkNhZIQyhLfhz07DlUVIlJ0h9nTo2GLLZIKCJd/IkkvvJH09DJ6hENwmy+q
        rE/SZK+1OHpuQlDw==
Date:   Fri, 13 Nov 2020 15:02:12 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 05/19] ARM: irqstat: Get rid of duplicated declaration
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_cpustat_t is exactly the same as the asm-generic one. Define
ack_bad_irq so the generic header does not emit the generic version of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/hardirq.h |   11 +++--------
 arch/arm/include/asm/irq.h     |    2 ++
 2 files changed, 5 insertions(+), 8 deletions(-)

--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -2,16 +2,11 @@
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
 #include <asm/irq.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
+#define ack_bad_irq ack_bad_irq
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_HARDIRQ_H */
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,6 +31,8 @@ void handle_IRQ(unsigned int, struct pt_
 void init_IRQ(void);
 
 #ifdef CONFIG_SMP
+#include <linux/cpumask.h>
+
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace

