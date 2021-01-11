Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446E2F0D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbhAKHpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:45:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36078 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727741AbhAKHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:45:01 -0500
X-UUID: 9c7f9b5c7e694911ac363c0ff5926d5c-20210111
X-UUID: 9c7f9b5c7e694911ac363c0ff5926d5c-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 529237252; Mon, 11 Jan 2021 15:44:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 15:44:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 15:44:03 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Yidi Lin <yidi.lin@mediatek.com>
Subject: [PATCH v3, 09/15] drm/mediatek: Add pm runtime support for gamma
Date:   Mon, 11 Jan 2021 15:43:45 +0800
Message-ID: <1610351031-21133-10-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gamma power domain need controled in the device.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Yidi Lin <yidi.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 3c1ea07..da93079 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk_drm_crtc.h"
@@ -156,6 +157,8 @@ static int mtk_disp_gamma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	pm_runtime_enable(dev);
+
 	ret = component_add(dev, &mtk_disp_gamma_component_ops);
 	if (ret)
 		dev_err(dev, "Failed to add component: %d\n", ret);
@@ -165,6 +168,8 @@ static int mtk_disp_gamma_probe(struct platform_device *pdev)
 
 static int mtk_disp_gamma_remove(struct platform_device *pdev)
 {
+	pm_runtime_disable(&pdev->dev);
+
 	component_del(&pdev->dev, &mtk_disp_gamma_component_ops);
 
 	return 0;
-- 
1.8.1.1.dirty

