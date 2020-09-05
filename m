Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27025E779
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgIEMQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 08:16:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgIEMQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 08:16:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BBD328909026AC3E515;
        Sat,  5 Sep 2020 20:16:23 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 20:16:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <matthias.bgg@gmail.com>, <sean.wang@mediatek.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Bluetooth: btmtksdio: use NULL instead of zero
Date:   Sat, 5 Sep 2020 20:15:49 +0800
Message-ID: <20200905121549.32936-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/bluetooth/btmtksdio.c:499:57: warning: Using plain integer as NULL pointer
drivers/bluetooth/btmtksdio.c:533:57: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c7ab7a23bd67..ba45c59bd9f3 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -496,7 +496,7 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 	sdio_claim_host(bdev->func);
 
 	/* Disable interrupt */
-	sdio_writel(func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
+	sdio_writel(func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
 
 	int_status = sdio_readl(func, MTK_REG_CHISR, NULL);
 
@@ -530,7 +530,7 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 	}
 
 	/* Enable interrupt */
-	sdio_writel(func, C_INT_EN_SET, MTK_REG_CHLPCR, 0);
+	sdio_writel(func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
 
 	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
-- 
2.17.1


