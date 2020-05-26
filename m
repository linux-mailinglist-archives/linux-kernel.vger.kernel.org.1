Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1871B0DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgDTOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 10:04:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728451AbgDTOEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:04:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 35A7ACC59F4CA25CBBD4;
        Mon, 20 Apr 2020 22:04:43 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 22:04:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <ck.hu@mediatek.com>, <enric.balletbo@collabora.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/mediatek: Fix Kconfig warning
Date:   Mon, 20 Apr 2020 21:50:45 +0800
Message-ID: <20200420135045.27984-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: unmet direct dependencies detected for MTK_MMSYS
  Depends on [n]: (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && COMMON_CLK_MT8173_MMSYS [=n]
  Selected by [y]:
  - DRM_MEDIATEK [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_MEDIATEK [=y] || ARM && COMPILE_TEST [=n]) && COMMON_CLK [=y] && HAVE_ARM_SMCCC [=y] && OF [=y]

Add missing dependcy COMMON_CLK_MT8173_MMSYS to fix this.

Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mmsys device")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index c420f5a3d33b..4d9b5540de68 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -6,6 +6,7 @@ config DRM_MEDIATEK
 	depends on COMMON_CLK
 	depends on HAVE_ARM_SMCCC
 	depends on OF
+	depends on COMMON_CLK_MT8173_MMSYS
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
-- 
2.17.1


