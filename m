Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090602A71D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbgKDXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:32:41 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:51801 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgKDXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:32:40 -0500
Received: from localhost.localdomain (abag227.neoplus.adsl.tpnet.pl [83.6.170.227])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id F388C4025F;
        Thu,  5 Nov 2020 00:22:33 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 2/4] arm64: kpti: Add KRYO2XX gold/silver CPU cores to kpti safelist
Date:   Thu,  5 Nov 2020 00:22:11 +0100
Message-Id: <20201104232218.198800-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104232218.198800-1-konrad.dybcio@somainline.org>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM KRYO2XX gold (big) silver (LITTLE) CPU cores are based on
Cortex-A73 and Cortex-A53 respectively and are meltdown safe,
hence add them to kpti_safe_list[].

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/kernel/cpufeature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..6f36c4f62f69 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1337,6 +1337,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
 		MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_GOLD),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
 		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
 		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 		{ /* sentinel */ }
-- 
2.29.2

