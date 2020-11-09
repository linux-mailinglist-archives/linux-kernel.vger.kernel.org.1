Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7991D2AB778
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgKILrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:47:37 -0500
Received: from foss.arm.com ([217.140.110.172]:38414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgKILrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:47:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03DFE106F;
        Mon,  9 Nov 2020 03:47:37 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9F983F718;
        Mon,  9 Nov 2020 03:47:34 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm/smp: Drop the macro S(x,s)
Date:   Mon,  9 Nov 2020 17:17:12 +0530
Message-Id: <1604922432-25825-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping between IPI type index and its string is direct without requiring
an additional offset. Hence the existing macro S(x, s) is now redundant
and can just be dropped. This also makes the code clean and simple.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Only build tested.

 arch/arm/kernel/smp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48099c6e1e4a..6ab2b0ad5f40 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -524,14 +524,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 }
 
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
-#define S(x,s)	[x] = s
-	S(IPI_WAKEUP, "CPU wakeup interrupts"),
-	S(IPI_TIMER, "Timer broadcast interrupts"),
-	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
-	S(IPI_CALL_FUNC, "Function call interrupts"),
-	S(IPI_CPU_STOP, "CPU stop interrupts"),
-	S(IPI_IRQ_WORK, "IRQ work interrupts"),
-	S(IPI_COMPLETION, "completion interrupts"),
+	[IPI_WAKEUP]		= "CPU wakeup interrupts",
+	[IPI_TIMER]		= "Timer broadcast interrupts",
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_IRQ_WORK]		= "IRQ work interrupts",
+	[IPI_COMPLETION]	= "completion interrupts",
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
-- 
2.20.1

