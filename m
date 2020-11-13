Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB552B1D22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKMOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52544 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKMOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:25 -0500
Message-Id: <20201113141733.501611990@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OHBT/GvIcx8sVKLm+I9A4wHeNhC5PYlDa+OcCnGbESo=;
        b=U1TO39nOFoVbk93TwLqtmx7eirvEZHX/LsbXoG8kX8NYI9La4G+iYW3KsdHywpTurZ21jE
        lcKQVyEXjPaHxz3lSGJORdX0PV4/sTuPicpK53k1W2sARNdyynyNxlK04wAOdXNtq2Y+1I
        kyXeIknJBqtGPO0mtTckQdR6o/1fHSJzBO7XiCN5CwzRlIea3+p6Z888Nq7lq2nzxJewYo
        FBDQ/0oalzSY9f6mcTHDO8LMM+TNDOAqrhVtE/ljspI/osFPT/oFpJxPDXcxEnAtj1IgFU
        qFZzF+5Bvq53Hh55iyMItfff0W0EZlIbcRP2pxMeFBFeamngsGfkzvqthPnUbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OHBT/GvIcx8sVKLm+I9A4wHeNhC5PYlDa+OcCnGbESo=;
        b=un8PSw38kc67x10IKXSJioXWUKjQjWWlL39xWy2VdmA0v1fdujzmkwrpWq2pk6cDYFi2rd
        8SpDL5kN3gfHhbCA==
Date:   Fri, 13 Nov 2020 15:02:14 +0100
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
Subject: [patch 07/19] asm-generic/irqstat: Add optional __nmi_count member
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional __nmi_count member to irq_cpustat_t so more architectures
can use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/asm-generic/hardirq.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -7,6 +7,9 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+#ifdef ARCH_WANTS_NMI_IRQSTAT
+	unsigned int __nmi_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */

