Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29932ED022
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbhAGMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:42:23 -0500
Received: from foss.arm.com ([217.140.110.172]:59990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbhAGMlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:41:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58ACC1576;
        Thu,  7 Jan 2021 04:39:50 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2FEC3F719;
        Thu,  7 Jan 2021 04:39:48 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 26/26] coresight: Add support for v8.4 SelfHosted tracing
Date:   Thu,  7 Jan 2021 12:38:59 +0000
Message-Id: <20210107123859.674252-27-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210107123859.674252-1-suzuki.poulose@arm.com>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
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
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
[ Move the trace filtering setup etm_init_arch_data() and
 clean ups]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 34a6cdff75e7..6d96f4226bca 100644
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

