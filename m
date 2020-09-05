Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7189225E686
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIEIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 04:31:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgIEIbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:31:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9013058B589323AA0492;
        Sat,  5 Sep 2020 16:31:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 16:31:32 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <yt.shen@mediatek.com>, <ck.hu@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <yongqiang.niu@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] drm/mediatek: add missing put_device() call in mtk_ddp_comp_init()
Date:   Sat, 5 Sep 2020 16:30:58 +0800
Message-ID: <20200905083058.1631726-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if of_find_device_by_node() succeed, mtk_ddp_comp_init() doesn't have
a corresponding put_device(). Thus add put_device() to fix the exception
handling for this function implementation.

Fixes: d0afe37f5209 ("drm/mediatek: support CMDQ interface in ddp component")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 57c88de9a329..526648885b97 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -496,6 +496,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (of_address_to_resource(node, 0, &res) != 0) {
 		dev_err(dev, "Missing reg in %s node\n", node->full_name);
+		put_device(&larb_pdev->dev);
 		return -EINVAL;
 	}
 	comp->regs_pa = res.start;
-- 
2.25.4

