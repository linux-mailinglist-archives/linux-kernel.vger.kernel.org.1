Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D12F0D74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbhAKHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:45:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36078 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727829AbhAKHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:45:19 -0500
X-UUID: be01ae19a2f640b9aa9d131876603b11-20210111
X-UUID: be01ae19a2f640b9aa9d131876603b11-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 5606070; Mon, 11 Jan 2021 15:44:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 15:44:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 15:44:04 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Yidi Lin <yidi.lin@mediatek.com>
Subject: [PATCH v3, 10/15] drm/mediatek: Add pm runtime support for color
Date:   Mon, 11 Jan 2021 15:43:46 +0800
Message-ID: <1610351031-21133-11-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

color power domain need controled in the device.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Yidi Lin <yidi.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_color.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 6048cbc..14b9dd3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -9,6 +9,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_drm_crtc.h"
@@ -132,6 +133,8 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	pm_runtime_enable(dev);
+
 	ret = component_add(dev, &mtk_disp_color_component_ops);
 	if (ret)
 		dev_err(dev, "Failed to add component: %d\n", ret);
@@ -141,6 +144,8 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
 
 static int mtk_disp_color_remove(struct platform_device *pdev)
 {
+	pm_runtime_disable(&pdev->dev);
+
 	component_del(&pdev->dev, &mtk_disp_color_component_ops);
 
 	return 0;
-- 
1.8.1.1.dirty

