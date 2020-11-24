Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105C42C292D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbgKXOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388659AbgKXOPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:15:00 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8690120866;
        Tue, 24 Nov 2020 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227299;
        bh=wPxwPSYUJQvenwuxZ8Stbfu0z1HC9dk+8Z9jU6IDIhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLXfpeHpaZ9aPQRFVdueYCQZ8dNyAd3w6YeeFmVIdMbvh1NO1kn5CzctmCH/56bOs
         MWsdtLWLPKO4LFd1TpuAoVO4HPMp2/69yCGpDdTNTeeZNdItO6uTMfvXgYJR2khCWo
         ps7UyOyqxB6xOBm8Wu6k5n/TUTRqouP58f85mbVY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khZ5s-00DGcy-PH; Tue, 24 Nov 2020 14:14:57 +0000
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
Subject: [PATCH v2 5/6] genirq: Drop IRQ_HIDDEN from IRQF_MODIFY_MASK
Date:   Tue, 24 Nov 2020 14:14:48 +0000
Message-Id: <20201124141449.572446-6-maz@kernel.org>
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

IRQ_HIDDEN is hardly a flag generic code should use, so let's
drop it from IRQF_MODIFY_MASK. In turn, update both arm and arm64
to use __irq_modify_status() when setting this flag.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/kernel/smp.c   | 2 +-
 arch/arm64/kernel/smp.c | 2 +-
 include/linux/irq.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0e09c8320caf..dc746f808400 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -737,7 +737,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
-		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+		__irq_modify_status(ipi_base + i, 0, IRQ_HIDDEN, ~0);
 
 		/* The recheduling IPI is special... */
 		if (i == IPI_RESCHEDULE)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index bad51f7f7ffe..684f41a3ba58 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -994,7 +994,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
-		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+		__irq_modify_status(ipi_base + i, 0, IRQ_HIDDEN, ~0);
 
 		/* The recheduling IPI is special... */
 		if (i == IPI_RESCHEDULE)
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 605ba5949255..0e71227fd3ec 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -107,7 +107,7 @@ enum {
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
-- 
2.28.0

