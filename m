Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B147C2FC421
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbhASWwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:52:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11175 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404568AbhASO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:29:15 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DKr5p65lFzl7Cq;
        Tue, 19 Jan 2021 22:05:34 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 19 Jan 2021 22:06:50 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rui.xiang@huawei.com>,
        <guohanjun@huawei.com>, <houtao1@huawei.com>
Subject: [PATCH] arm64: kernel: Make IPI_WAKEUP under control of CONFIG_ARM64_ACPI_PARKING_PROTOCOL
Date:   Tue, 19 Jan 2021 14:06:09 +0000
Message-ID: <20210119140609.106420-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since commit 5e89c55e4ed81d7abb1ce8828db35fa389dc0e90
("arm64: kernel: implement ACPI parking protocol")

On arm64, IPI 6 will be wasted without setting
CONFIG_ARM64_ACPI_PARKING_PROTOCOL.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 arch/arm64/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ad00f99ee9b0..8b494ad1c61e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -73,7 +73,9 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
+#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 	IPI_WAKEUP,
+#endif
 	NR_IPI
 };
 
@@ -795,7 +797,9 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
+#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 	[IPI_WAKEUP]		= "CPU wake-up interrupts",
+#endif
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
-- 
2.25.0

