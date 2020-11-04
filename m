Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8428E2A71D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbgKDXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:32:41 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:53545 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbgKDXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:32:40 -0500
Received: from localhost.localdomain (abag227.neoplus.adsl.tpnet.pl [83.6.170.227])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id C1AC53E8B2;
        Thu,  5 Nov 2020 00:22:43 +0100 (CET)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver
Date:   Thu,  5 Nov 2020 00:22:13 +0100
Message-Id: <20201104232218.198800-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104232218.198800-1-konrad.dybcio@somainline.org>
References: <20201104232218.198800-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM KRYO2XX Silver cores are Cortex-A53 based and are
susceptible to the 845719 erratum. Add them to the lookup
list to apply the erratum.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/kernel/cpu_errata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 61314fd70f13..cafaf0da05b7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -299,6 +299,8 @@ static const struct midr_range erratum_845719_list[] = {
 	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
 	/* Brahma-B53 r0p[0] */
 	MIDR_REV(MIDR_BRAHMA_B53, 0, 0),
+	/* Kryo2XX Silver rAp4 */
+	MIDR_REV(MIDR_QCOM_KRYO_2XX_SILVER, 0xa, 0x4),
 	{},
 };
 #endif
-- 
2.29.2

