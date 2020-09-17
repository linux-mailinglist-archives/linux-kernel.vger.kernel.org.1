Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95626D785
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIQJUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:20:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgIQJUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:20:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D238686AB85E77F6F371;
        Thu, 17 Sep 2020 17:20:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 17:20:39 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <b.zolnierkie@samsung.com>, <sam@ravnborg.org>, <arnd@arndb.de>,
        <laurent.pinchart@ideasonboard.com>, <jani.nikula@intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] fbdev: mx3fb: remove unused variable 'irq'
Date:   Thu, 17 Sep 2020 17:19:20 +0800
Message-ID: <1600334360-4214-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the variable 'irq' that is set but never used.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/video/fbdev/mx3fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 603731a..894617d 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -1428,7 +1428,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	struct device *dev = mx3fb->dev;
 	struct mx3fb_platform_data *mx3fb_pdata = dev_get_platdata(dev);
 	const char *name = mx3fb_pdata->name;
-	unsigned int irq;
 	struct fb_info *fbi;
 	struct mx3fb_info *mx3fbi;
 	const struct fb_videomode *mode;
@@ -1441,7 +1440,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	}
 
 	ichan->client = mx3fb;
-	irq = ichan->eof_irq;
 
 	if (ichan->dma_chan.chan_id != IDMAC_SDC_0)
 		return -EINVAL;
-- 
2.8.1

