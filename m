Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26B42B1D49
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgKMOZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:25:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52496 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgKMOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:24 -0500
Message-Id: <20201113141733.392015387@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TyQaO1KTOnQylNyXqxWcHMMYAxiiSJ2Q6FuIeS+IiF4=;
        b=lEDXukR0oK89SaoPklU/SlvTO4AL3FW7GtfHdqKagFFJBz68+N8DGdCe/0EEWypICcBgfZ
        wSwEA6mdjl0V8HHeF09kj/7r5ookPrS4PPP/mFt7wBY+msVoxO8OIaRotonDWQPXXat5ot
        UwXzLRGrG+BjHy9sq1LL5SuGdK2ZwyH6oYS17dxfNKVv40lxmUF0I/zMgsJTI2beJJ6Thk
        3bgYhE2ykrFnPGkhew+FXzp5SoptOYITranaNsMPwVkAXjBXG1OVfC4kPgOyOQR0j4GYYz
        83OwnIjUaKOVlixefPLnQ38+4y8XAZhRP+5bBagZC3NLAENT7q6vhSsVBtwIwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TyQaO1KTOnQylNyXqxWcHMMYAxiiSJ2Q6FuIeS+IiF4=;
        b=8EcLL2MjKtWP9jXkLNSdACpvbZt324DYTS3ZV5jkNvp419QrSxtZ6sgw1e9rErz090S0+8
        MNDYn4yqeq+V2VCA==
Date:   Fri, 13 Nov 2020 15:02:13 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [patch 06/19] arm64: irqstat: Get rid of duplicated declaration
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/hardirq.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,11 +13,8 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+#define ack_bad_irq ack_bad_irq
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 

