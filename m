Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860522E1AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgLWKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:04:40 -0500
Received: from foss.arm.com ([217.140.110.172]:47968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWKEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:04:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0EF1435;
        Wed, 23 Dec 2020 02:03:54 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 664383F718;
        Wed, 23 Dec 2020 02:03:51 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 04/11] coresight: ete: Add support for ETE sysreg access
Date:   Wed, 23 Dec 2020 15:33:36 +0530
Message-Id: <1608717823-18387-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for handling the system registers for Embedded Trace
Extensions (ETE). ETE shares most of the registers with ETMv4 except
for some and also adds some new registers. Re-arrange the ETMv4x list
to share the common definitions and add the ETE sysreg support.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 32 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h      | 42 +++++++++++++++++-----
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 31d65f3..dff502f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -110,6 +110,38 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
 	}
 }
 
+u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
+{
+	u64 res = 0;
+
+	switch (offset) {
+	ETE_READ_CASES(res)
+	default :
+		WARN_ONCE(1, "ete: trying to read unsupported register @%x\n",
+			 offset);
+	}
+
+	if (!_relaxed)
+		__iormb(res);	/* Imitate the !relaxed I/O helpers */
+
+	return res;
+}
+
+void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
+{
+	if (!_relaxed)
+		__iowmb();	/* Imitate the !relaxed I/O helpers */
+	if (!_64bit)
+		val &= GENMASK(31, 0);
+
+	switch (offset) {
+	ETE_WRITE_CASES(val)
+	default :
+		WARN_ONCE(1, "ete: trying to write to unsupported register @%x\n",
+			offset);
+	}
+}
+
 static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
 			       struct csdev_access *csa)
 {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 69af577..6f64f08 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -28,6 +28,7 @@
 #define TRCAUXCTLR			0x018
 #define TRCEVENTCTL0R			0x020
 #define TRCEVENTCTL1R			0x024
+#define TRCRSR				0x028
 #define TRCSTALLCTLR			0x02C
 #define TRCTSCTLR			0x030
 #define TRCSYNCPR			0x034
@@ -48,6 +49,7 @@
 #define TRCSEQRSTEVR			0x118
 #define TRCSEQSTR			0x11C
 #define TRCEXTINSELR			0x120
+#define TRCEXTINSELRn(n)		(0x120 + (n * 4)) /* n = 0-3 */
 #define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
 #define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
 #define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
@@ -156,9 +158,22 @@
 #define CASE_WRITE(val, x)					\
 	case (x): { write_etm4x_sysreg_const_offset((val), (x)); break; }
 
-#define CASE_LIST(op, val)			\
-	CASE_##op((val), TRCPRGCTLR)		\
+#define ETE_ONLY_LIST(op, val)			\
+	CASE_##op((val), TRCRSR)		\
+	CASE_##op((val), TRCEXTINSELRn(1))	\
+	CASE_##op((val), TRCEXTINSELRn(2))	\
+	CASE_##op((val), TRCEXTINSELRn(3))
+
+#define ETM_ONLY_LIST(op, val)			\
 	CASE_##op((val), TRCPROCSELR)		\
+	CASE_##op((val), TRCVDCTLR)		\
+	CASE_##op((val), TRCVDSACCTLR)		\
+	CASE_##op((val), TRCVDARCCTLR)		\
+	CASE_##op((val), TRCITCTRL)		\
+	CASE_##op((val), TRCOSLAR)
+
+#define COMMON_LIST(op, val)		\
+	CASE_##op((val), TRCPRGCTLR)		\
 	CASE_##op((val), TRCSTATR)		\
 	CASE_##op((val), TRCCONFIGR)		\
 	CASE_##op((val), TRCAUXCTLR)		\
@@ -175,9 +190,6 @@
 	CASE_##op((val), TRCVIIECTLR)		\
 	CASE_##op((val), TRCVISSCTLR)		\
 	CASE_##op((val), TRCVIPCSSCTLR)		\
-	CASE_##op((val), TRCVDCTLR)		\
-	CASE_##op((val), TRCVDSACCTLR)		\
-	CASE_##op((val), TRCVDARCCTLR)		\
 	CASE_##op((val), TRCSEQEVRn(0))		\
 	CASE_##op((val), TRCSEQEVRn(1))		\
 	CASE_##op((val), TRCSEQEVRn(2))		\
@@ -272,7 +284,6 @@
 	CASE_##op((val), TRCSSPCICRn(5))	\
 	CASE_##op((val), TRCSSPCICRn(6))	\
 	CASE_##op((val), TRCSSPCICRn(7))	\
-	CASE_##op((val), TRCOSLAR)		\
 	CASE_##op((val), TRCOSLSR)		\
 	CASE_##op((val), TRCPDCR)		\
 	CASE_##op((val), TRCPDSR)		\
@@ -344,7 +355,6 @@
 	CASE_##op((val), TRCCIDCCTLR1)		\
 	CASE_##op((val), TRCVMIDCCTLR0)		\
 	CASE_##op((val), TRCVMIDCCTLR1)		\
-	CASE_##op((val), TRCITCTRL)		\
 	CASE_##op((val), TRCCLAIMSET)		\
 	CASE_##op((val), TRCCLAIMCLR)		\
 	CASE_##op((val), TRCDEVAFF0)		\
@@ -364,8 +374,22 @@
 	CASE_##op((val), TRCPIDR2)		\
 	CASE_##op((val), TRCPIDR3)
 
-#define ETM4x_READ_CASES(res)	CASE_LIST(READ, (res))
-#define ETM4x_WRITE_CASES(val)	CASE_LIST(WRITE, (val))
+#define ETM4x_READ_CASES(res)			\
+	COMMON_LIST(READ, (res))		\
+	ETM_ONLY_LIST(READ, (res))
+
+#define ETM4x_WRITE_CASES(res)			\
+	COMMON_LIST(WRITE, (res))		\
+	ETM_ONLY_LIST(WRITE, (res))
+
+#define ETE_READ_CASES(res)			\
+	COMMON_LIST(READ, (res))		\
+	ETE_ONLY_LIST(READ, (res))
+
+#define ETE_WRITE_CASES(res)			\
+	COMMON_LIST(WRITE, (res))		\
+	ETE_ONLY_LIST(WRITE, (res))
+
 
 #define read_etm4x_sysreg_offset(offset, _64bit)				\
 	({									\
-- 
2.7.4

