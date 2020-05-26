Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6630C1BB46E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 05:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1DRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 23:17:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbgD1DRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:17:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4163CD85AA8205E4AD0;
        Tue, 28 Apr 2020 11:17:50 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 11:17:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <ck.hu@mediatek.com>, <enric.balletbo@collabora.com>,
        <yuehaibing@huawei.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 -next] soc: mediatek: Fix Kconfig warning
Date:   Tue, 28 Apr 2020 11:17:29 +0800
Message-ID: <20200428031729.49372-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <CAAOTY__km=QZQACp8g-Qr+aWZ4r0Yp7O5j7u8ZTpDpTXXfUdNw@mail.gmail.com>
References: <CAAOTY__km=QZQACp8g-Qr+aWZ4r0Yp7O5j7u8ZTpDpTXXfUdNw@mail.gmail.com>
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

Make MTK_MMSYS select COMMON_CLK_MT8173_MMSYS to fix this.

Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mmsys device")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: select COMMON_CLK_MT8173_MMSYS instead of adding DRM_MEDIATEK dependency  
---
 drivers/soc/mediatek/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index e84513318725..7f9da11e1a50 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -46,8 +46,7 @@ config MTK_SCPSYS
 
 config MTK_MMSYS
 	bool "MediaTek MMSYS Support"
-	depends on COMMON_CLK_MT8173_MMSYS
-	default COMMON_CLK_MT8173_MMSYS
+	select COMMON_CLK_MT8173_MMSYS
 	help
 	  Say yes here to add support for the MediaTek Multimedia
 	  Subsystem (MMSYS).
-- 
2.17.1


