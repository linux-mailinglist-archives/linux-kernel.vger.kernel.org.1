Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490E32F0A21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbhAJWvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:51:13 -0500
Received: from foss.arm.com ([217.140.110.172]:39074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbhAJWu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:50:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C8C152F;
        Sun, 10 Jan 2021 14:49:36 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34D733F719;
        Sun, 10 Jan 2021 14:49:35 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 22/28] coresight: etm4x: Detect system instructions support
Date:   Sun, 10 Jan 2021 22:48:44 +0000
Message-Id: <20210110224850.1880240-23-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETM v4.4 onwards adds support for system instruction access
to the ETM. Detect the support on an ETM and switch to using the
mode when available.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 3b17feb86d8a..6cbc6e0c0819 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -782,6 +782,37 @@ static const struct coresight_ops etm4_cs_ops = {
 	.source_ops	= &etm4_source_ops,
 };
 
+static inline bool cpu_supports_sysreg_trace(void)
+{
+	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+
+	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
+}
+
+static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
+				    struct csdev_access *csa)
+{
+	u32 devarch;
+
+	if (!cpu_supports_sysreg_trace())
+		return false;
+
+	/*
+	 * ETMs implementing sysreg access must implement TRCDEVARCH.
+	 */
+	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
+	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
+		return false;
+	*csa = (struct csdev_access) {
+		.io_mem	= false,
+		.read	= etm4x_sysreg_read,
+		.write	= etm4x_sysreg_write,
+	};
+
+	drvdata->arch = etm_devarch_to_arch(devarch);
+	return true;
+}
+
 static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
@@ -812,9 +843,17 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
+	/*
+	 * Always choose the memory mapped io, if there is
+	 * a memory map to prevent sysreg access on broken
+	 * systems.
+	 */
 	if (drvdata->base)
 		return etm4_init_iomem_access(drvdata, csa);
 
+	if (etm4_init_sysreg_access(drvdata, csa))
+		return true;
+
 	return false;
 }
 
-- 
2.24.1

