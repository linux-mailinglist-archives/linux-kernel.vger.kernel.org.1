Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE85C21861A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGHL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 07:28:43 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46910 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728862AbgGHL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:28:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jkchen@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U26jOw3_1594207719;
Received: from localhost(mailfrom:jkchen@linux.alibaba.com fp:SMTPD_---0U26jOw3_1594207719)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 19:28:39 +0800
From:   Jay Chen <jkchen@linux.alibaba.com>
To:     will@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jay Chen <jkchen@linux.alibaba.com>
Subject: [PATCH] perf/smmuv3: To simplify code for ioremap page in pmcg
Date:   Wed,  8 Jul 2020 19:27:09 +0800
Message-Id: <20200708112709.19502-1-jkchen@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_platform_get_and_ioremap_resource to simplify the code
a bit.

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 48e28ef93a70..2d09f3e47d12 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -755,8 +755,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
+	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
 	if (IS_ERR(smmu_pmu->reg_base))
 		return PTR_ERR(smmu_pmu->reg_base);
 
-- 
2.27.0

