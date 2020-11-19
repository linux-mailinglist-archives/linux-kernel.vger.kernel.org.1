Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71902B988D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgKSQqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:46:18 -0500
Received: from foss.arm.com ([217.140.110.172]:34520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgKSQqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3468F1478;
        Thu, 19 Nov 2020 08:46:15 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 171063F719;
        Thu, 19 Nov 2020 08:46:13 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 10/25] coresight: etm4x: Add sysreg access helpers
Date:   Thu, 19 Nov 2020 16:45:32 +0000
Message-Id: <20201119164547.2982871-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119164547.2982871-1-suzuki.poulose@arm.com>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETM architecture defines the system instructions for accessing
via register accesses. Add basic support for accessing a given
register via system instructions.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3:
 - Removed stacking of parameters and other style comments
   from Mathieu.
---
 .../coresight/coresight-etm4x-core.c          |  32 ++
 drivers/hwtracing/coresight/coresight-etm4x.h | 342 ++++++++++++++++--
 2 files changed, 352 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index ea8521b539e1..c2499b62e64e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -72,6 +72,38 @@ static inline bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
 	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
 }
 
+u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
+{
+	u64 res = 0;
+
+	switch (offset) {
+	ETM4x_READ_CASES(res)
+	default :
+		WARN_ONCE(1, "etm4x: trying to read unsupported register @%x\n",
+			 offset);
+	}
+
+	if (!_relaxed)
+		__iormb(res);	/* Imitate the !relaxed I/O helpers */
+
+	return res;
+}
+
+void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
+{
+	if (!_relaxed)
+		__iowmb();	/* Imitate the !relaxed I/O helpers */
+	if (!_64bit)
+		val &= GENMASK(31, 0);
+
+	switch (offset) {
+	ETM4x_WRITE_CASES(val)
+	default :
+		WARN_ONCE(1, "etm4x: trying to write to unsupported register @%x\n",
+			offset);
+	}
+}
+
 static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
 {
 	/* Writing 0 to TRCOSLAR unlocks the trace registers */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a46b348f5e66..6591a59c1012 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -125,29 +125,324 @@
 #define TRCCIDR2			0xFF8
 #define TRCCIDR3			0xFFC
 
-#define etm4x_relaxed_read32(csa, offset)		\
-	readl_relaxed((csa)->base + (offset))
-
-#define etm4x_read32(csa, offset)			\
-	readl((csa)->base + (offset))
-
-#define etm4x_relaxed_write32(csa, val, offset)		\
-	writel_relaxed((val), (csa)->base + (offset))
-
-#define etm4x_write32(csa, val, offset)			\
-	writel((val), (csa)->base + (offset))
-
-#define etm4x_relaxed_read64(csa, offset)		\
-	readq_relaxed((csa)->base + (offset))
-
-#define etm4x_read64(csa, offset)			\
-	readq((csa)->base + (offset))
-
-#define etm4x_relaxed_write64(csa, val, offset)		\
-	writeq_relaxed((val), (csa)->base + (offset))
+/*
+ * System instructions to access ETM registers.
+ * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
+ */
+#define ETM4x_OFFSET_TO_REG(x)		((x) >> 2)
+
+#define ETM4x_CRn(n)			(((n) >> 7) & 0x7)
+#define ETM4x_Op2(n)			(((n) >> 4) & 0x7)
+#define ETM4x_CRm(n)			((n) & 0xf)
+
+#include <asm/sysreg.h>
+#define ETM4x_REG_NUM_TO_SYSREG(n)				\
+	sys_reg(2, 1, ETM4x_CRn(n), ETM4x_CRm(n), ETM4x_Op2(n))
+
+#define READ_ETM4x_REG(reg)					\
+	read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
+#define WRITE_ETM4x_REG(val, reg)				\
+	write_sysreg_s(val, ETM4x_REG_NUM_TO_SYSREG((reg)))
+
+#define read_etm4x_sysreg_const_offset(offset)			\
+	READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
+
+#define write_etm4x_sysreg_const_offset(val, offset)		\
+	WRITE_ETM4x_REG(val, ETM4x_OFFSET_TO_REG(offset))
+
+#define CASE_READ(res, x)					\
+	case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }
+
+#define CASE_WRITE(val, x)					\
+	case (x): { write_etm4x_sysreg_const_offset((val), (x)); break; }
+
+#define CASE_LIST(op, val)			\
+	CASE_##op((val), TRCPRGCTLR)		\
+	CASE_##op((val), TRCPROCSELR)		\
+	CASE_##op((val), TRCSTATR)		\
+	CASE_##op((val), TRCCONFIGR)		\
+	CASE_##op((val), TRCAUXCTLR)		\
+	CASE_##op((val), TRCEVENTCTL0R)		\
+	CASE_##op((val), TRCEVENTCTL1R)		\
+	CASE_##op((val), TRCSTALLCTLR)		\
+	CASE_##op((val), TRCTSCTLR)		\
+	CASE_##op((val), TRCSYNCPR)		\
+	CASE_##op((val), TRCCCCTLR)		\
+	CASE_##op((val), TRCBBCTLR)		\
+	CASE_##op((val), TRCTRACEIDR)		\
+	CASE_##op((val), TRCQCTLR)		\
+	CASE_##op((val), TRCVICTLR)		\
+	CASE_##op((val), TRCVIIECTLR)		\
+	CASE_##op((val), TRCVISSCTLR)		\
+	CASE_##op((val), TRCVIPCSSCTLR)		\
+	CASE_##op((val), TRCVDCTLR)		\
+	CASE_##op((val), TRCVDSACCTLR)		\
+	CASE_##op((val), TRCVDARCCTLR)		\
+	CASE_##op((val), TRCSEQEVRn(0))		\
+	CASE_##op((val), TRCSEQEVRn(1))		\
+	CASE_##op((val), TRCSEQEVRn(2))		\
+	CASE_##op((val), TRCSEQRSTEVR)		\
+	CASE_##op((val), TRCSEQSTR)		\
+	CASE_##op((val), TRCEXTINSELR)		\
+	CASE_##op((val), TRCCNTRLDVRn(0))	\
+	CASE_##op((val), TRCCNTRLDVRn(1))	\
+	CASE_##op((val), TRCCNTRLDVRn(2))	\
+	CASE_##op((val), TRCCNTRLDVRn(3))	\
+	CASE_##op((val), TRCCNTCTLRn(0))	\
+	CASE_##op((val), TRCCNTCTLRn(1))	\
+	CASE_##op((val), TRCCNTCTLRn(2))	\
+	CASE_##op((val), TRCCNTCTLRn(3))	\
+	CASE_##op((val), TRCCNTVRn(0))		\
+	CASE_##op((val), TRCCNTVRn(1))		\
+	CASE_##op((val), TRCCNTVRn(2))		\
+	CASE_##op((val), TRCCNTVRn(3))		\
+	CASE_##op((val), TRCIDR8)		\
+	CASE_##op((val), TRCIDR9)		\
+	CASE_##op((val), TRCIDR10)		\
+	CASE_##op((val), TRCIDR11)		\
+	CASE_##op((val), TRCIDR12)		\
+	CASE_##op((val), TRCIDR13)		\
+	CASE_##op((val), TRCIMSPECn(0))		\
+	CASE_##op((val), TRCIMSPECn(1))		\
+	CASE_##op((val), TRCIMSPECn(2))		\
+	CASE_##op((val), TRCIMSPECn(3))		\
+	CASE_##op((val), TRCIMSPECn(4))		\
+	CASE_##op((val), TRCIMSPECn(5))		\
+	CASE_##op((val), TRCIMSPECn(6))		\
+	CASE_##op((val), TRCIMSPECn(7))		\
+	CASE_##op((val), TRCIDR0)		\
+	CASE_##op((val), TRCIDR1)		\
+	CASE_##op((val), TRCIDR2)		\
+	CASE_##op((val), TRCIDR3)		\
+	CASE_##op((val), TRCIDR4)		\
+	CASE_##op((val), TRCIDR5)		\
+	CASE_##op((val), TRCIDR6)		\
+	CASE_##op((val), TRCIDR7)		\
+	CASE_##op((val), TRCRSCTLRn(2))		\
+	CASE_##op((val), TRCRSCTLRn(3))		\
+	CASE_##op((val), TRCRSCTLRn(4))		\
+	CASE_##op((val), TRCRSCTLRn(5))		\
+	CASE_##op((val), TRCRSCTLRn(6))		\
+	CASE_##op((val), TRCRSCTLRn(7))		\
+	CASE_##op((val), TRCRSCTLRn(8))		\
+	CASE_##op((val), TRCRSCTLRn(9))		\
+	CASE_##op((val), TRCRSCTLRn(10))	\
+	CASE_##op((val), TRCRSCTLRn(11))	\
+	CASE_##op((val), TRCRSCTLRn(12))	\
+	CASE_##op((val), TRCRSCTLRn(13))	\
+	CASE_##op((val), TRCRSCTLRn(14))	\
+	CASE_##op((val), TRCRSCTLRn(15))	\
+	CASE_##op((val), TRCRSCTLRn(16))	\
+	CASE_##op((val), TRCRSCTLRn(17))	\
+	CASE_##op((val), TRCRSCTLRn(18))	\
+	CASE_##op((val), TRCRSCTLRn(19))	\
+	CASE_##op((val), TRCRSCTLRn(20))	\
+	CASE_##op((val), TRCRSCTLRn(21))	\
+	CASE_##op((val), TRCRSCTLRn(22))	\
+	CASE_##op((val), TRCRSCTLRn(23))	\
+	CASE_##op((val), TRCRSCTLRn(24))	\
+	CASE_##op((val), TRCRSCTLRn(25))	\
+	CASE_##op((val), TRCRSCTLRn(26))	\
+	CASE_##op((val), TRCRSCTLRn(27))	\
+	CASE_##op((val), TRCRSCTLRn(28))	\
+	CASE_##op((val), TRCRSCTLRn(29))	\
+	CASE_##op((val), TRCRSCTLRn(30))	\
+	CASE_##op((val), TRCRSCTLRn(31))	\
+	CASE_##op((val), TRCSSCCRn(0))		\
+	CASE_##op((val), TRCSSCCRn(1))		\
+	CASE_##op((val), TRCSSCCRn(2))		\
+	CASE_##op((val), TRCSSCCRn(3))		\
+	CASE_##op((val), TRCSSCCRn(4))		\
+	CASE_##op((val), TRCSSCCRn(5))		\
+	CASE_##op((val), TRCSSCCRn(6))		\
+	CASE_##op((val), TRCSSCCRn(7))		\
+	CASE_##op((val), TRCSSCSRn(0))		\
+	CASE_##op((val), TRCSSCSRn(1))		\
+	CASE_##op((val), TRCSSCSRn(2))		\
+	CASE_##op((val), TRCSSCSRn(3))		\
+	CASE_##op((val), TRCSSCSRn(4))		\
+	CASE_##op((val), TRCSSCSRn(5))		\
+	CASE_##op((val), TRCSSCSRn(6))		\
+	CASE_##op((val), TRCSSCSRn(7))		\
+	CASE_##op((val), TRCSSPCICRn(0))	\
+	CASE_##op((val), TRCSSPCICRn(1))	\
+	CASE_##op((val), TRCSSPCICRn(2))	\
+	CASE_##op((val), TRCSSPCICRn(3))	\
+	CASE_##op((val), TRCSSPCICRn(4))	\
+	CASE_##op((val), TRCSSPCICRn(5))	\
+	CASE_##op((val), TRCSSPCICRn(6))	\
+	CASE_##op((val), TRCSSPCICRn(7))	\
+	CASE_##op((val), TRCOSLAR)		\
+	CASE_##op((val), TRCOSLSR)		\
+	CASE_##op((val), TRCPDCR)		\
+	CASE_##op((val), TRCPDSR)		\
+	CASE_##op((val), TRCACVRn(0))		\
+	CASE_##op((val), TRCACVRn(1))		\
+	CASE_##op((val), TRCACVRn(2))		\
+	CASE_##op((val), TRCACVRn(3))		\
+	CASE_##op((val), TRCACVRn(4))		\
+	CASE_##op((val), TRCACVRn(5))		\
+	CASE_##op((val), TRCACVRn(6))		\
+	CASE_##op((val), TRCACVRn(7))		\
+	CASE_##op((val), TRCACVRn(8))		\
+	CASE_##op((val), TRCACVRn(9))		\
+	CASE_##op((val), TRCACVRn(10))		\
+	CASE_##op((val), TRCACVRn(11))		\
+	CASE_##op((val), TRCACVRn(12))		\
+	CASE_##op((val), TRCACVRn(13))		\
+	CASE_##op((val), TRCACVRn(14))		\
+	CASE_##op((val), TRCACVRn(15))		\
+	CASE_##op((val), TRCACATRn(0))		\
+	CASE_##op((val), TRCACATRn(1))		\
+	CASE_##op((val), TRCACATRn(2))		\
+	CASE_##op((val), TRCACATRn(3))		\
+	CASE_##op((val), TRCACATRn(4))		\
+	CASE_##op((val), TRCACATRn(5))		\
+	CASE_##op((val), TRCACATRn(6))		\
+	CASE_##op((val), TRCACATRn(7))		\
+	CASE_##op((val), TRCACATRn(8))		\
+	CASE_##op((val), TRCACATRn(9))		\
+	CASE_##op((val), TRCACATRn(10))		\
+	CASE_##op((val), TRCACATRn(11))		\
+	CASE_##op((val), TRCACATRn(12))		\
+	CASE_##op((val), TRCACATRn(13))		\
+	CASE_##op((val), TRCACATRn(14))		\
+	CASE_##op((val), TRCACATRn(15))		\
+	CASE_##op((val), TRCDVCVRn(0))		\
+	CASE_##op((val), TRCDVCVRn(1))		\
+	CASE_##op((val), TRCDVCVRn(2))		\
+	CASE_##op((val), TRCDVCVRn(3))		\
+	CASE_##op((val), TRCDVCVRn(4))		\
+	CASE_##op((val), TRCDVCVRn(5))		\
+	CASE_##op((val), TRCDVCVRn(6))		\
+	CASE_##op((val), TRCDVCVRn(7))		\
+	CASE_##op((val), TRCDVCMRn(0))		\
+	CASE_##op((val), TRCDVCMRn(1))		\
+	CASE_##op((val), TRCDVCMRn(2))		\
+	CASE_##op((val), TRCDVCMRn(3))		\
+	CASE_##op((val), TRCDVCMRn(4))		\
+	CASE_##op((val), TRCDVCMRn(5))		\
+	CASE_##op((val), TRCDVCMRn(6))		\
+	CASE_##op((val), TRCDVCMRn(7))		\
+	CASE_##op((val), TRCCIDCVRn(0))		\
+	CASE_##op((val), TRCCIDCVRn(1))		\
+	CASE_##op((val), TRCCIDCVRn(2))		\
+	CASE_##op((val), TRCCIDCVRn(3))		\
+	CASE_##op((val), TRCCIDCVRn(4))		\
+	CASE_##op((val), TRCCIDCVRn(5))		\
+	CASE_##op((val), TRCCIDCVRn(6))		\
+	CASE_##op((val), TRCCIDCVRn(7))		\
+	CASE_##op((val), TRCVMIDCVRn(0))	\
+	CASE_##op((val), TRCVMIDCVRn(1))	\
+	CASE_##op((val), TRCVMIDCVRn(2))	\
+	CASE_##op((val), TRCVMIDCVRn(3))	\
+	CASE_##op((val), TRCVMIDCVRn(4))	\
+	CASE_##op((val), TRCVMIDCVRn(5))	\
+	CASE_##op((val), TRCVMIDCVRn(6))	\
+	CASE_##op((val), TRCVMIDCVRn(7))	\
+	CASE_##op((val), TRCCIDCCTLR0)		\
+	CASE_##op((val), TRCCIDCCTLR1)		\
+	CASE_##op((val), TRCVMIDCCTLR0)		\
+	CASE_##op((val), TRCVMIDCCTLR1)		\
+	CASE_##op((val), TRCITCTRL)		\
+	CASE_##op((val), TRCCLAIMSET)		\
+	CASE_##op((val), TRCCLAIMCLR)		\
+	CASE_##op((val), TRCDEVAFF0)		\
+	CASE_##op((val), TRCDEVAFF1)		\
+	CASE_##op((val), TRCLAR)		\
+	CASE_##op((val), TRCLSR)		\
+	CASE_##op((val), TRCAUTHSTATUS)		\
+	CASE_##op((val), TRCDEVARCH)		\
+	CASE_##op((val), TRCDEVID)		\
+	CASE_##op((val), TRCDEVTYPE)		\
+	CASE_##op((val), TRCPIDR4)		\
+	CASE_##op((val), TRCPIDR5)		\
+	CASE_##op((val), TRCPIDR6)		\
+	CASE_##op((val), TRCPIDR7)		\
+	CASE_##op((val), TRCPIDR0)		\
+	CASE_##op((val), TRCPIDR1)		\
+	CASE_##op((val), TRCPIDR2)		\
+	CASE_##op((val), TRCPIDR3)
+
+#define ETM4x_READ_CASES(res)	CASE_LIST(READ, (res))
+#define ETM4x_WRITE_CASES(val)	CASE_LIST(WRITE, (val))
+
+#define read_etm4x_sysreg_offset(offset, _64bit)				\
+	({									\
+		u64 __val;							\
+										\
+		if (__builtin_constant_p((offset)))				\
+			__val = read_etm4x_sysreg_const_offset((offset));	\
+		else								\
+			__val = etm4x_sysreg_read((offset), true, (_64bit));	\
+		__val;								\
+	 })
+
+#define write_etm4x_sysreg_offset(val, offset, _64bit)			\
+	do {								\
+		if (__builtin_constant_p((offset)))			\
+			write_etm4x_sysreg_const_offset((val),		\
+							(offset));	\
+		else							\
+			etm4x_sysreg_write((val), (offset), true,	\
+					   (_64bit));			\
+	} while (0)
+
+
+#define etm4x_relaxed_read32(csa, offset)				\
+	((u32)((csa)->io_mem ?						\
+		 readl_relaxed((csa)->base + (offset)) :		\
+		 read_etm4x_sysreg_offset((offset), false)))
+
+#define etm4x_relaxed_read64(csa, offset)				\
+	((u64)((csa)->io_mem ?						\
+		 readq_relaxed((csa)->base + (offset)) :		\
+		 read_etm4x_sysreg_offset((offset), true)))
+
+#define etm4x_read32(csa, offset)					\
+	({								\
+		u32 __val = etm4x_relaxed_read32((csa), (offset));	\
+		__iormb(__val);						\
+		__val;							\
+	 })
+
+#define etm4x_read64(csa, offset)					\
+	({								\
+		u64 __val = etm4x_relaxed_read64((csa), (offset));	\
+		__iormb(__val);						\
+		__val;							\
+	 })
+
+#define etm4x_relaxed_write32(csa, val, offset)				\
+	do {								\
+		if ((csa)->io_mem)					\
+			writel_relaxed((val), (csa)->base + (offset));	\
+		else							\
+			write_etm4x_sysreg_offset((val), (offset),	\
+						  false);		\
+	} while (0)
+
+#define etm4x_relaxed_write64(csa, val, offset)				\
+	do {								\
+		if ((csa)->io_mem)					\
+			writeq_relaxed((val), (csa)->base + (offset));	\
+		else							\
+			write_etm4x_sysreg_offset((val), (offset),	\
+						  true);		\
+	} while (0)
+
+#define etm4x_write32(csa, val, offset)					\
+	do {								\
+		__iowmb();						\
+		etm4x_relaxed_write32((csa), (val), (offset));		\
+	} while (0)
+
+#define etm4x_write64(csa, val, offset)					\
+	do {								\
+		__iowmb();						\
+		etm4x_relaxed_write64((csa), (val), (offset));		\
+	} while (0)
 
-#define etm4x_write64(csa, val, offset)			\
-	writeq((val), (csa)->base + (offset))
 
 /* ETMv4 resources */
 #define ETM_MAX_NR_PE			8
@@ -514,4 +809,7 @@ enum etm_addr_ctxtype {
 
 extern const struct attribute_group *coresight_etmv4_groups[];
 void etm4_config_trace_mode(struct etmv4_config *config);
+
+u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
+void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);
 #endif
-- 
2.24.1

