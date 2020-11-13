Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C459A2B1D23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKMOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52496 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgKMOY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:27 -0500
Message-Id: <20201113141733.737377332@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=S06QIqfNWoqS9gVbzzc2YmE/3ZeyYSj3ENqKW66z6Fk=;
        b=oKGHrc6ngr7pniRBz0GCkmv8BaYBF1FeplvyjX2vJwsAUgrYdz4cnmB3wC6mJfdcpJ40/H
        ux+ye5dfkWJDyog2W1IQX301wYzlzg7uWVTZrs75VYHHBnURdhLltHVQmJsjpqa9J9Hqgr
        RvCdcuEChzRjZQ8L7ZVwtW5/vwPvKRX3p4g3WHLxCUiZgLizT+s06zATCfIPpMAgpHOek2
        blevGecPsXV46jkSksH8VB2aY8+xrd0r+z1CmOkz77H4397toGWI/IsDpiSW1Qb0CCsW1q
        vz+nLMNGXJ53AFfra+OdwJruy0uePrpJBb5PcFI3scSV7vN2wUJUtoHsTtiJVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=S06QIqfNWoqS9gVbzzc2YmE/3ZeyYSj3ENqKW66z6Fk=;
        b=IPeONiRzhIvWN0gM+Ny+HdS5Bcn9NO+HpkoDUkh8pXwqmmyh85sM7Nl+LVtoPIFtKmYPWZ
        LACjWnVzSBcd/0BA==
Date:   Fri, 13 Nov 2020 15:02:16 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 09/19] irqstat: Move declaration into asm-generic/hardirq.h
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the declaration of the irq_cpustat per cpu variable to
asm-generic/hardirq.h and remove the now empty linux/irq_cpustat.h header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/asm-generic/hardirq.h |    3 ++-
 include/linux/irq_cpustat.h   |   24 ------------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -12,7 +12,8 @@ typedef struct {
 #endif
 } ____cacheline_aligned irq_cpustat_t;
 
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+
 #include <linux/irq.h>
 
 #ifndef ack_bad_irq
--- a/include/linux/irq_cpustat.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __irq_cpustat_h
-#define __irq_cpustat_h
-
-/*
- * Contains default mappings for irq_cpustat_t, used by almost every
- * architecture.  Some arch (like s390) have per cpu hardware pages and
- * they define their own mappings for irq_stat.
- *
- * Keith Owens <kaos@ocs.com.au> July 2000.
- */
-
-
-/*
- * Simple wrappers reducing source bloat.  Define all irq_stat fields
- * here, even ones that are arch dependent.  That way we get common
- * definitions instead of differing sets for each arch.
- */
-
-#ifndef __ARCH_IRQ_STAT
-DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
-#endif
-
-#endif	/* __irq_cpustat_h */

