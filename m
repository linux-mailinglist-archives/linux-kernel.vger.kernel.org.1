Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B82F0A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbhAJWu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:50:59 -0500
Received: from foss.arm.com ([217.140.110.172]:39070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbhAJWu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:50:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F4414BF;
        Sun, 10 Jan 2021 14:49:25 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 792BF3F719;
        Sun, 10 Jan 2021 14:49:24 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 15/28] coresight: etm4x: Cleanup secure exception level masks
Date:   Sun, 10 Jan 2021 22:48:37 +0000
Message-Id: <20210110224850.1880240-16-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rely on the ETM architecture version to decide whether
Secure EL2 is available on the CPU for excluding the level
for address comparators and viewinst main control register.
We must instead use the TRCDIDR3.EXLEVEL_S field to detect
the supported levels.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  6 ++++--
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index feea52938a7b..3e3733c650a7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -840,7 +840,6 @@ static void etm4_init_arch_data(void *info)
 	 * TRCARCHMAJ, bits[11:8] architecture major versin number
 	 */
 	drvdata->arch = BMVAL(etmidr1, 4, 11);
-	drvdata->config.arch = drvdata->arch;
 
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
@@ -856,6 +855,7 @@ static void etm4_init_arch_data(void *info)
 	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
 	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
+	drvdata->config.s_ex_level = drvdata->s_ex_level;
 	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
 	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
 
@@ -1027,16 +1027,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 static u64 etm4_get_access_type(struct etmv4_config *config)
 {
 	u64 access_type = etm4_get_ns_access_type(config);
-	u64 s_hyp = (config->arch & 0x0f) >= 0x4 ? ETM_EXLEVEL_S_HYP : 0;
 
-	/*
-	 * EXLEVEL_S, bits[11:8], don't trace anything happening
-	 * in secure state.
-	 */
-	access_type |= (ETM_EXLEVEL_S_APP	|
-			ETM_EXLEVEL_S_OS	|
-			s_hyp			|
-			ETM_EXLEVEL_S_MON);
+	/* All supported secure ELs are excluded */
+	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
 
 	return access_type;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index fba3c02eea0b..29cd27f53e72 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -557,6 +557,8 @@
 /* PowerDown Control Register bits */
 #define TRCPDCR_PU			BIT(3)
 
+#define TRCACATR_EXLEVEL_SHIFT		8
+
 /* secure state access levels - TRCACATRn */
 #define ETM_EXLEVEL_S_APP		BIT(8)
 #define ETM_EXLEVEL_S_OS		BIT(9)
@@ -631,7 +633,7 @@ enum etm_impdef_type {
  * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
  * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
  * @ext_inp:	External input selection.
- * @arch:	ETM architecture version (for arch dependent config).
+ * @s_ex_level: Secure ELs where tracing is supported.
  */
 struct etmv4_config {
 	u32				mode;
@@ -675,7 +677,7 @@ struct etmv4_config {
 	u32				vmid_mask0;
 	u32				vmid_mask1;
 	u32				ext_inp;
-	u8				arch;
+	u8				s_ex_level;
 };
 
 /**
-- 
2.24.1

