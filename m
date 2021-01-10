Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D692F0A2B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbhAJWwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:52:05 -0500
Received: from foss.arm.com ([217.140.110.172]:39078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbhAJWuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:50:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 249C31474;
        Sun, 10 Jan 2021 14:49:18 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA1F63F719;
        Sun, 10 Jan 2021 14:49:16 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 10/28] coresight: etm4x: Add commentary on the registers
Date:   Sun, 10 Jan 2021 22:48:32 +0000
Message-Id: <20210110224850.1880240-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about define a switch..case table for individual register
access by offset for implementing the system instruction support,
document the possible set of registers for each group to make
it easier to correlate.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3
 - Fix commit description spelling mistake (Mathieu)
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index b6854f6fd666..3c2b49ffabc8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -45,13 +45,13 @@
 #define TRCVDSACCTLR			0x0A4
 #define TRCVDARCCTLR			0x0A8
 /* Derived resources registers */
-#define TRCSEQEVRn(n)			(0x100 + (n * 4))
+#define TRCSEQEVRn(n)			(0x100 + (n * 4)) /* n = 0-2 */
 #define TRCSEQRSTEVR			0x118
 #define TRCSEQSTR			0x11C
 #define TRCEXTINSELR			0x120
-#define TRCCNTRLDVRn(n)			(0x140 + (n * 4))
-#define TRCCNTCTLRn(n)			(0x150 + (n * 4))
-#define TRCCNTVRn(n)			(0x160 + (n * 4))
+#define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
+#define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
+#define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
 /* ID registers */
 #define TRCIDR8				0x180
 #define TRCIDR9				0x184
@@ -60,7 +60,7 @@
 #define TRCIDR12			0x190
 #define TRCIDR13			0x194
 #define TRCIMSPEC0			0x1C0
-#define TRCIMSPECn(n)			(0x1C0 + (n * 4))
+#define TRCIMSPECn(n)			(0x1C0 + (n * 4)) /* n = 1-7 */
 #define TRCIDR0				0x1E0
 #define TRCIDR1				0x1E4
 #define TRCIDR2				0x1E8
@@ -69,9 +69,12 @@
 #define TRCIDR5				0x1F4
 #define TRCIDR6				0x1F8
 #define TRCIDR7				0x1FC
-/* Resource selection registers */
+/*
+ * Resource selection registers, n = 2-31.
+ * First pair (regs 0, 1) is always present and is reserved.
+ */
 #define TRCRSCTLRn(n)			(0x200 + (n * 4))
-/* Single-shot comparator registers */
+/* Single-shot comparator registers, n = 0-7 */
 #define TRCSSCCRn(n)			(0x280 + (n * 4))
 #define TRCSSCSRn(n)			(0x2A0 + (n * 4))
 #define TRCSSPCICRn(n)			(0x2C0 + (n * 4))
@@ -81,11 +84,13 @@
 #define TRCPDCR				0x310
 #define TRCPDSR				0x314
 /* Trace registers (0x318-0xEFC) */
-/* Comparator registers */
+/* Address Comparator registers n = 0-15 */
 #define TRCACVRn(n)			(0x400 + (n * 8))
 #define TRCACATRn(n)			(0x480 + (n * 8))
+/* Data Value Comparator Value registers, n = 0-7 */
 #define TRCDVCVRn(n)			(0x500 + (n * 16))
 #define TRCDVCMRn(n)			(0x580 + (n * 16))
+/* ContextID/Virtual ContextID comparators, n = 0-7 */
 #define TRCCIDCVRn(n)			(0x600 + (n * 8))
 #define TRCVMIDCVRn(n)			(0x640 + (n * 8))
 #define TRCCIDCCTLR0			0x680
-- 
2.24.1

