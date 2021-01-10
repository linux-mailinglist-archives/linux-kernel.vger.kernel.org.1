Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D72F0A1C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbhAJWvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:51:01 -0500
Received: from foss.arm.com ([217.140.110.172]:39084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbhAJWvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:51:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E12515DB;
        Sun, 10 Jan 2021 14:49:46 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8C213F719;
        Sun, 10 Jan 2021 14:49:44 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 28/28] coresight: Add support for v8.4 SelfHosted tracing
Date:   Sun, 10 Jan 2021 22:48:50 +0000
Message-Id: <20210110224850.1880240-29-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Zhou <jonathan.zhouwen@huawei.com>

v8.4 tracing extensions added support for trace filtering controlled
by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
tracing if we are running the kernel at EL2.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
[ Move the trace filtering setup etm_init_arch_data() and
 clean ups]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 3d3165dd09d4..18c1a80abab8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -859,6 +859,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 	return false;
 }
 
+static void cpu_enable_tracing(void)
+{
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+	u64 trfcr;
+
+	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
+		return;
+
+	/*
+	 * If the CPU supports v8.4 SelfHosted Tracing, enable
+	 * tracing at the kernel EL and EL0, forcing to use the
+	 * virtual time as the timestamp.
+	 */
+	trfcr = (TRFCR_ELx_TS_VIRTUAL |
+		 TRFCR_ELx_ExTRE |
+		 TRFCR_ELx_E0TRE);
+
+	/* If we are running at EL2, allow tracing the CONTEXTIDR_EL2. */
+	if (is_kernel_in_hyp_mode())
+		trfcr |= TRFCR_EL2_CX;
+
+	write_sysreg_s(trfcr, SYS_TRFCR_EL1);
+}
+
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
@@ -1044,6 +1068,7 @@ static void etm4_init_arch_data(void *info)
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
 	etm4_cs_lock(drvdata, csa);
+	cpu_enable_tracing();
 }
 
 static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
-- 
2.24.1

