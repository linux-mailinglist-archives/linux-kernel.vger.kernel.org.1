Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324F52B987F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgKSQqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:46:18 -0500
Received: from foss.arm.com ([217.140.110.172]:34532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgKSQqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 852BD1682;
        Thu, 19 Nov 2020 08:46:16 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 673AB3F719;
        Thu, 19 Nov 2020 08:46:15 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 11/25] coresight: etm4x: Define DEVARCH register fields
Date:   Thu, 19 Nov 2020 16:45:33 +0000
Message-Id: <20201119164547.2982871-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119164547.2982871-1-suzuki.poulose@arm.com>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the fields of the DEVARCH register for identifying
a component as an ETMv4.x unit. Going forward, we use the
DEVARCH register for the component identification, rather
than the TRCIDR3.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          |  4 +-
 drivers/hwtracing/coresight/coresight-etm4x.h | 42 +++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c2499b62e64e..6f776f075602 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1622,8 +1622,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
-		.devarch	= 0x47704a13,
-		.devarch_mask	= 0xfff0ffff,
+		.devarch	= ETM_DEVARCH_ETMv4x_ARCH,
+		.devarch_mask	= ETM_DEVARCH_ID_MASK,
 		.devtype	= 0x00000013,
 	}
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 6591a59c1012..d8f047547a36 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -498,6 +498,48 @@
 					 ETM_MODE_EXCL_KERN | \
 					 ETM_MODE_EXCL_USER)
 
+/*
+ * TRCDEVARCH Bit field definitions
+ * Bits[31:21]	- ARCHITECT = Always Arm Ltd.
+ *                * Bits[31:28] = 0x4
+ *                * Bits[27:21] = 0b0111011
+ * Bit[20]	- PRESENT,  Indicates the presence of this register.
+ *
+ * Bit[19:16]	- REVISION, Revision of the architecture.
+ *
+ * Bit[15:0]	- ARCHID, Identifies this component as an ETM
+ *                * Bits[15:12] - architecture version of ETM
+ *                *             = 4 for ETMv4
+ *                * Bits[11:0] = 0xA13, architecture part number for ETM.
+ */
+#define ETM_DEVARCH_ARCHITECT_MASK		GENMASK(31, 21)
+#define ETM_DEVARCH_ARCHITECT_ARM		((0x4 << 28) | (0b0111011 << 21))
+#define ETM_DEVARCH_PRESENT			BIT(20)
+#define ETM_DEVARCH_REVISION_SHIFT		16
+#define ETM_DEVARCH_REVISION_MASK		GENMASK(19, 16)
+#define ETM_DEVARCH_REVISION(x)			\
+	(((x) & ETM_DEVARCH_REVISION_MASK) >> ETM_DEVARCH_REVISION_SHIFT)
+#define ETM_DEVARCH_ARCHID_MASK			GENMASK(15, 0)
+#define ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT	12
+#define ETM_DEVARCH_ARCHID_ARCH_VER_MASK	GENMASK(15, 12)
+#define ETM_DEVARCH_ARCHID_ARCH_VER(x)		\
+	(((x) & ETM_DEVARCH_ARCHID_ARCH_VER_MASK) >> ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT)
+
+#define ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(ver)			\
+	(((ver) << ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT) & ETM_DEVARCH_ARCHID_ARCH_VER_MASK)
+
+#define ETM_DEVARCH_ARCHID_ARCH_PART(x)		((x) & 0xfffUL)
+
+#define ETM_DEVARCH_MAKE_ARCHID(major)			\
+	((ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(major)) | ETM_DEVARCH_ARCHID_ARCH_PART(0xA13))
+
+#define ETM_DEVARCH_ARCHID_ETMv4x		ETM_DEVARCH_MAKE_ARCHID(0x4)
+
+#define ETM_DEVARCH_ID_MASK						\
+	(ETM_DEVARCH_ARCHITECT_MASK | ETM_DEVARCH_ARCHID_MASK | ETM_DEVARCH_PRESENT)
+#define ETM_DEVARCH_ETMv4x_ARCH						\
+	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETMv4x | ETM_DEVARCH_PRESENT)
+
 #define TRCSTATR_IDLE_BIT		0
 #define TRCSTATR_PMSTABLE_BIT		1
 #define ETM_DEFAULT_ADDR_COMP		0
-- 
2.24.1

