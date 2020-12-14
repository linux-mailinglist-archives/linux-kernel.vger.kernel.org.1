Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82D82D9E71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408642AbgLNSC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:02:58 -0500
Received: from foss.arm.com ([217.140.110.172]:50526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408646AbgLNRjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:39:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB27152B;
        Mon, 14 Dec 2020 09:38:18 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8C193F66E;
        Mon, 14 Dec 2020 09:38:16 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, jonathan.zhouwen@huawei.com,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 24/25] arm64: Add TRFCR_ELx definitions
Date:   Mon, 14 Dec 2020 17:37:30 +0000
Message-Id: <20201214173731.302520-25-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Zhou <jonathan.zhouwen@huawei.com>

Add definitions for the Arm v8.4 SelfHosted trace extensions registers.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
[ split the register definitions to separate patch
  rename some of the symbols ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e2ef4c2edf06..eeaab5521385 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -187,6 +187,7 @@
 #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
 
 #define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
+#define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
 
 #define SYS_TTBR0_EL1			sys_reg(3, 0, 2, 0, 0)
 #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
@@ -466,6 +467,7 @@
 #define SYS_PMCCFILTR_EL0		sys_reg(3, 3, 14, 15, 7)
 
 #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
+#define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
 #define SYS_DACR32_EL2			sys_reg(3, 4, 3, 0, 0)
 #define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
 #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
@@ -818,6 +820,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_TRACE_FILT_SHIFT	40
 #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
 #define ID_AA64DFR0_PMSVER_SHIFT	32
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
@@ -992,6 +995,14 @@
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
+#define TRFCR_ELx_TS_SHIFT		5
+#define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
+#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
+#define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
+#define TRFCR_EL2_CX			BIT(3)
+#define TRFCR_ELx_ExTRE			BIT(1)
+#define TRFCR_ELx_E0TRE			BIT(0)
+
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
-- 
2.24.1

