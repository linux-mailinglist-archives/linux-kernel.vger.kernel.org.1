Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAAC2CD520
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgLCMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:04:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8929 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgLCMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:03:59 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmvbR5rJ2z785t;
        Thu,  3 Dec 2020 20:02:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 20:02:43 +0800
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
Subject: [PATCH 1/4] reset: hisilicon: correct vendor prefix
Date:   Thu, 3 Dec 2020 20:02:09 +0800
Message-ID: <20201203120212.1105-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201203120212.1105-1-thunder.leizhen@huawei.com>
References: <20201203120212.1105-1-thunder.leizhen@huawei.com>
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

Fixes: 1527058736fa ("reset: hisilicon: add reset-hi3660")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/reset/hisilicon/reset-hi3660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index a7d4445924e558c..8f1953159a65b31 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -83,7 +83,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
 	if (!rc)
 		return -ENOMEM;
 
-	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
+	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");
 	if (IS_ERR(rc->map)) {
 		dev_err(dev, "failed to get hi3660,rst-syscon\n");
 		return PTR_ERR(rc->map);
-- 
1.8.3


