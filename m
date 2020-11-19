Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B225D2B9878
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgKSQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:46:45 -0500
Received: from foss.arm.com ([217.140.110.172]:34672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbgKSQqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B21DF1650;
        Thu, 19 Nov 2020 08:46:38 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FB3B3F718;
        Thu, 19 Nov 2020 08:46:37 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 25/25] coresight: Add support for v8.4 SelfHosted tracing
Date:   Thu, 19 Nov 2020 16:45:47 +0000
Message-Id: <20201119164547.2982871-26-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119164547.2982871-1-suzuki.poulose@arm.com>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
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
index 1d054d2ab2a0..647685736134 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -760,6 +760,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 	return false;
 }
 
+static void cpu_enable_tracing(void)
+{
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+	u64 trfcr;
+
+	if (!(dfr0 >> ID_AA64DFR0_TRACE_FILT_SHIFT))
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
@@ -943,6 +967,7 @@ static void etm4_init_arch_data(void *info)
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
 	etm4_cs_lock(drvdata, csa);
+	cpu_enable_tracing();
 }
 
 static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
-- 
2.24.1

