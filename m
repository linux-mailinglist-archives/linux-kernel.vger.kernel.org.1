Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180DB2EBE8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbhAFNUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:20:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10112 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:20:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D9qgZ40Gtz15pl1;
        Wed,  6 Jan 2021 21:18:34 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:19:22 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <b.zolnierkie@samsung.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] video: fbdev: pxa3xx_gcu: use resource_size
Date:   Wed, 6 Jan 2021 21:20:06 +0800
Message-ID: <20210106132006.1036-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size rather than a verbose computation on
the end and start fields.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 4279e13a3b58..1d26be9d1f2d 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -594,8 +594,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	 * container_of(). This isn't really necessary as we have a fixed minor
 	 * number anyway, but this is to avoid statics. */
 
-	priv->misc_dev.minor	= PXA3XX_GCU_MINOR,
-	priv->misc_dev.name	= DRV_NAME,
+	priv->misc_dev.minor	= PXA3XX_GCU_MINOR;
+	priv->misc_dev.name	= DRV_NAME;
 	priv->misc_dev.fops	= &pxa3xx_gcu_miscdev_fops;
 
 	/* handle IO resources */
-- 
2.22.0

