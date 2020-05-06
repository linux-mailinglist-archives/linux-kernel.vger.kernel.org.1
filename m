Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB61C7276
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgEFOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 10:09:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbgEFOJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:09:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B35597B26A92DDEEEFB8;
        Wed,  6 May 2020 22:09:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 22:09:11 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] soc: mediatek: Missing platform_device_unregister() on error in mtk_mmsys_probe()
Date:   Wed, 6 May 2020 14:13:17 +0000
Message-ID: <20200506141317.119537-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_unregister() before return
from mtk_mmsys_probe() in the error handling case.

Fixes: 667c769246b0 ("soc / drm: mediatek: Fix mediatek-drm device probing")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 05e322c9c301..05ce4cb464b0 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -312,8 +312,10 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 
 	drm = platform_device_register_data(&pdev->dev, "mediatek-drm",
 					    PLATFORM_DEVID_AUTO, NULL, 0);
-	if (IS_ERR(drm))
+	if (IS_ERR(drm)) {
+		platform_device_unregister(clks);
 		return PTR_ERR(drm);
+	}
 
 	return 0;
 }



