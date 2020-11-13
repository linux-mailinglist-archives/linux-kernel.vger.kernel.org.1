Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC82B1D16
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgKMOYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC149C0613D1;
        Fri, 13 Nov 2020 06:24:17 -0800 (PST)
Message-Id: <20201113141732.680780121@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RnPutIEhghgoo536rGP1gany4COll9eV5Xh0J3bCRIo=;
        b=Oi7V+t3xMEVk/+5l6bz8QLaSNx3nUUoDN6UwYKH3pm2ZJbGJ8GLol3FoZmJPqe1Lh6/Dxh
        1nFGYLlKHZhmFpXrxnk6JdbowHwTuGlO2STIeU8MeveK6O95OmP3Y/VreNOCTmosQKpltl
        PodJ580NczVuQOFpRgrs7SX4Ei9k8aBdoe6gjx9954mt69zvRCw8nwR76Sh7ec51WIle3i
        tn6ga8Tw6wzpm67El32MNj8AxrJlHq2DalzZhCV1JpZfLvMG75RYS9W5lWLRNni53vzQwG
        5MLc2ApK4iDcWiRj9cBqcZj5cSawHc9QSGKYtcAM60QM6RanQU/pcQhN9wqsqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RnPutIEhghgoo536rGP1gany4COll9eV5Xh0J3bCRIo=;
        b=xlFmjKxnDnUjXDDS5b3QeICpxgLMcYIi4FZ/GuOqg1NYVyeTiU7BKlPKFqFLY+z+/eZi6x
        enZDTrTmo4YKGdAg==
Date:   Fri, 13 Nov 2020 15:02:08 +0100
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
Subject: [patch 01/19] parisc: Remove bogus __IRQ_STAT macro
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a leftover from a historical array based implementation and unused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/include/asm/hardirq.h |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -32,7 +32,6 @@ typedef struct {
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define __ARCH_IRQ_STAT
-#define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
 #define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)

