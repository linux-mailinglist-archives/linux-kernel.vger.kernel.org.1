Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F72A1E3C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKANOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgKANOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:14:41 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7C52223F;
        Sun,  1 Nov 2020 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236481;
        bh=soTWofQsk5mAYc7LD8rgr4LwuCJPqqvnbnjj2BQ4Lv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbpPC3jRJtGUDsrBTIs6vU0uxT6b0XugBZTWp8j4H4QtNMnPyx5bDQzydbpWjg/Sq
         BWkYF1nVVXQF27UHiZF5a2Hbzu9O6inWTGx4le9kUnPDV5s87fMkz7fa/FQYtIbT7R
         2teNNNDk8PjUWorTLv/7TtppX7JA2JLu4HlOxdoU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZDBv-006QYT-8i; Sun, 01 Nov 2020 13:14:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: [PATCH 2/2] arm64: Mark the recheduling IPI as naked interrupt
Date:   Sun,  1 Nov 2020 13:14:30 +0000
Message-Id: <20201101131430.257038-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101131430.257038-1-maz@kernel.org>
References: <20201101131430.257038-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, Valentin.Schneider@arm.com, peterz@infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag the rescheduling IPI as 'naked', making sure such interrupt
doesn't trigger a rescheduling event by itself.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 82e75fc2c903..6c11be3e74d3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -993,6 +993,10 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+
+		/* The recheduling IPI is special... */
+		if (i == IPI_RESCHEDULE)
+			irq_set_status_flags(ipi_base + i, IRQ_NAKED);
 	}
 
 	ipi_irq_base = ipi_base;
-- 
2.28.0

