Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0055B2C292F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgKXOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388625AbgKXOO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:14:58 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669FB206FB;
        Tue, 24 Nov 2020 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227297;
        bh=PrUzHkuQSWZIMZxZ+NQmmORR5bj7LQLhBBz/VO5uZHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrKyAJat45aUAhmn5/X5YWpFMTe3Djlzp7SmpOl7yqUrNwuG3fEdjYYnPCPgNngo0
         AYQrAaRkmyapMI2bZMafFCYNAmOT/cGjN9fvOR1VNwi3LEjnRJww0sTO/nB4HfjwwH
         7eaGO3t0fjm3SnPMZvkO4BnJES8RZrWNleJZqces=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khZ5r-00DGcy-Hz; Tue, 24 Nov 2020 14:14:55 +0000
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
Subject: [PATCH v2 3/6] arm64: Mark the recheduling IPI as raw interrupt
Date:   Tue, 24 Nov 2020 14:14:46 +0000
Message-Id: <20201124141449.572446-4-maz@kernel.org>
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
 arch/arm64/Kconfig      | 1 +
 arch/arm64/kernel/smp.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..d18c2c15848d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,6 +108,7 @@ config ARM64
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_IPI
+	select ARCH_WANTS_IRQ_RAW
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 18e9727d3f64..bad51f7f7ffe 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -995,6 +995,10 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 
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

