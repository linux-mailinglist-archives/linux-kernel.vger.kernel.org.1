Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38632F4304
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbhAMETU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:19:20 -0500
Received: from foss.arm.com ([217.140.110.172]:57902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbhAMETU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:19:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 304B911FB;
        Tue, 12 Jan 2021 20:18:34 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7121D3F719;
        Tue, 12 Jan 2021 20:18:31 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/11] coresight: ete: Add support for ETE sysreg access
Date:   Wed, 13 Jan 2021 09:48:11 +0530
Message-Id: <1610511498-4058-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 32 +++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h      | 52 ++++++++++++++++++----
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 2ce2d0a..4305dc2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -114,6 +114,38 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
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
index 0e86eba..ca24ac5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -29,6 +29,7 @@
 #define TRCAUXCTLR			0x018
 #define TRCEVENTCTL0R			0x020
 #define TRCEVENTCTL1R			0x024
+#define TRCRSR				0x028
 #define TRCSTALLCTLR			0x02C
 #define TRCTSCTLR			0x030
 #define TRCSYNCPR			0x034
@@ -49,6 +50,7 @@
 #define TRCSEQRSTEVR			0x118
 #define TRCSEQSTR			0x11C
 #define TRCEXTINSELR			0x120
+#define TRCEXTINSELRn(n)		(0x120 + (n * 4)) /* n = 0-3 */
 #define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
 #define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
 #define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
@@ -160,10 +162,22 @@
 #define CASE_NOP(__unused, x)					\
 	case (x):	/* fall through */
 
+#define ETE_ONLY_SYSREG_LIST(op, val)		\
+	CASE_##op((val), TRCRSR)		\
+	CASE_##op((val), TRCEXTINSELRn(1))	\
+	CASE_##op((val), TRCEXTINSELRn(2))	\
+	CASE_##op((val), TRCEXTINSELRn(3))
+
 /* List of registers accessible via System instructions */
-#define ETM_SYSREG_LIST(op, val)		\
-	CASE_##op((val), TRCPRGCTLR)		\
+#define ETM4x_ONLY_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPROCSELR)		\
+	CASE_##op((val), TRCVDCTLR)		\
+	CASE_##op((val), TRCVDSACCTLR)		\
+	CASE_##op((val), TRCVDARCCTLR)		\
+	CASE_##op((val), TRCOSLAR)
+
+#define ETM_COMMON_SYSREG_LIST(op, val)		\
+	CASE_##op((val), TRCPRGCTLR)		\
 	CASE_##op((val), TRCSTATR)		\
 	CASE_##op((val), TRCCONFIGR)		\
 	CASE_##op((val), TRCAUXCTLR)		\
@@ -180,9 +194,6 @@
 	CASE_##op((val), TRCVIIECTLR)		\
 	CASE_##op((val), TRCVISSCTLR)		\
 	CASE_##op((val), TRCVIPCSSCTLR)		\
-	CASE_##op((val), TRCVDCTLR)		\
-	CASE_##op((val), TRCVDSACCTLR)		\
-	CASE_##op((val), TRCVDARCCTLR)		\
 	CASE_##op((val), TRCSEQEVRn(0))		\
 	CASE_##op((val), TRCSEQEVRn(1))		\
 	CASE_##op((val), TRCSEQEVRn(2))		\
@@ -277,7 +288,6 @@
 	CASE_##op((val), TRCSSPCICRn(5))	\
 	CASE_##op((val), TRCSSPCICRn(6))	\
 	CASE_##op((val), TRCSSPCICRn(7))	\
-	CASE_##op((val), TRCOSLAR)		\
 	CASE_##op((val), TRCOSLSR)		\
 	CASE_##op((val), TRCACVRn(0))		\
 	CASE_##op((val), TRCACVRn(1))		\
@@ -369,12 +379,36 @@
 	CASE_##op((val), TRCPIDR2)		\
 	CASE_##op((val), TRCPIDR3)
 
-#define ETM4x_READ_SYSREG_CASES(res)	ETM_SYSREG_LIST(READ, (res))
-#define ETM4x_WRITE_SYSREG_CASES(val)	ETM_SYSREG_LIST(WRITE, (val))
+#define ETM4x_READ_SYSREG_CASES(res)		\
+	ETM_COMMON_SYSREG_LIST(READ, (res))	\
+	ETM4x_ONLY_SYSREG_LIST(READ, (res))
+
+#define ETM4x_WRITE_SYSREG_CASES(val)		\
+	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
+	ETM4x_ONLY_SYSREG_LIST(WRITE, (val))
+
+#define ETM_COMMON_SYSREG_LIST_CASES		\
+	ETM_COMMON_SYSREG_LIST(NOP, __unused)
+
+#define ETM4x_SYSREG_LIST_CASES			\
+	ETM_COMMON_SYSREG_LIST_CASES		\
+	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
 
-#define ETM4x_SYSREG_LIST_CASES		ETM_SYSREG_LIST(NOP, __unused)
 #define ETM4x_MMAP_LIST_CASES		ETM_MMAP_LIST(NOP, __unused)
 
+/* ETE only supports system register access */
+#define ETE_READ_CASES(res)			\
+	ETM_COMMON_SYSREG_LIST(READ, (res))	\
+	ETE_ONLY_SYSREG_LIST(READ, (res))
+
+#define ETE_WRITE_CASES(val)			\
+	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
+	ETE_ONLY_SYSREG_LIST(WRITE, (val))
+
+#define ETE_ONLY_SYSREG_LIST_CASES		\
+	ETM_COMMON_SYSREG_LIST_CASES		\
+	ETE_ONLY_SYSREG_LIST(NOP, __unused)
+
 #define read_etm4x_sysreg_offset(offset, _64bit)				\
 	({									\
 		u64 __val;							\
-- 
2.7.4

