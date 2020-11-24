Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797A2C292C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388687AbgKXOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388650AbgKXOO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:14:59 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A842076E;
        Tue, 24 Nov 2020 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227298;
        bh=+lmTg9V6v6xiZd+sEaTBflIDj0fWKFnCwApiSlJWWuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwd1qIUy2yT9OqlqXWsFER4zsrIklH6YxGr9WtaoyrCEsEOr2uFX5v56NB+/Lbum9
         QIEZCF2KWV2okvJhVaj6aX9YKlIo3bCG3PIsV38RaVEhkDITh4/x7l+YFZUHnQSwtU
         JnX7Zq4Nmtqmr1FRMkLkmtwfryrV/v8MuvDK6dhg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khZ5s-00DGcy-5x; Tue, 24 Nov 2020 14:14:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: [PATCH v2 4/6] arm: Mark the recheduling IPI as raw interrupt
Date:   Tue, 24 Nov 2020 14:14:47 +0000
Message-Id: <20201124141449.572446-5-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124141449.572446-1-maz@kernel.org>
References: <20201124141449.572446-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, Valentin.Schneider@arm.com, peterz@infradead.org, mark.rutland@arm.com, linux@arm.linux.org.uk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag the rescheduling IPI as 'raw', making sure such interrupt
skips both tick management  and irqtime accounting.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/Kconfig      | 1 +
 arch/arm/kernel/smp.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17eb2b50..a5e3e9963ba4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,7 @@ config ARM
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_IRQ_IPI if SMP
+	select ARCH_WANTS_IRQ_RAW if GENERIC_IRQ_IPI
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48099c6e1e4a..0e09c8320caf 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -738,6 +738,10 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+
+		/* The recheduling IPI is special... */
+		if (i == IPI_RESCHEDULE)
+			__irq_modify_status(ipi_base + i, 0, IRQ_RAW, ~0);
 	}
 
 	ipi_irq_base = ipi_base;
-- 
2.28.0

