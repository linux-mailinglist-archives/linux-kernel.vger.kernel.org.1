Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F042D2B67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgLHMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:51:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9037 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgLHMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:51:25 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cr0QD2M2pzhnnK;
        Tue,  8 Dec 2020 20:50:12 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Dec 2020 20:50:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/4] reset: hisilicon: correct vendor prefix
Date:   Tue, 8 Dec 2020 20:46:38 +0800
Message-ID: <20201208124641.1787-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201208124641.1787-1-thunder.leizhen@huawei.com>
References: <20201208124641.1787-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
stated in "vendor-prefixes.yaml".

For backward compatibility reasons fall back to the deprecated compatible
if the new one failed.

Fixes: 1527058736fa ("reset: hisilicon: add reset-hi3660")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/reset/hisilicon/reset-hi3660.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index a7d4445924e558c..965f5ceba7d8f4d 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -83,9 +83,14 @@ static int hi3660_reset_probe(struct platform_device *pdev)
 	if (!rc)
 		return -ENOMEM;
 
-	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
+	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");
+	if (rc->map == ERR_PTR(-ENODEV)) {
+		/* fall back to the deprecated compatible */
+		rc->map = syscon_regmap_lookup_by_phandle(np,
+							  "hisi,rst-syscon");
+	}
 	if (IS_ERR(rc->map)) {
-		dev_err(dev, "failed to get hi3660,rst-syscon\n");
+		dev_err(dev, "failed to get hisilicon,rst-syscon\n");
 		return PTR_ERR(rc->map);
 	}
 
-- 
1.8.3


