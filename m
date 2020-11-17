Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06EF2B5992
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 07:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgKQGMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 01:12:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7549 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQGMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:12:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZwZW11KRzhb1M;
        Tue, 17 Nov 2020 14:12:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Nov 2020
 14:12:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ti.com>
CC:     <yangyingliang@huawei.com>
Subject: [PATCH] drm/omap: dmm_tiler: fix return error code in omap_dmm_probe()
Date:   Tue, 17 Nov 2020 14:10:45 +0800
Message-ID: <20201117061045.3452287-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -ENOMEM when allocating refill memory failed.

Fixes: 71e8831f6407 ("drm/omap: DMM/TILER support for OMAP4+ platform")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 42ec51bb7b1b..7f4317248812 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -889,6 +889,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 					   &omap_dmm->refill_pa, GFP_KERNEL);
 	if (!omap_dmm->refill_va) {
 		dev_err(&dev->dev, "could not allocate refill memory\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 
-- 
2.25.1

