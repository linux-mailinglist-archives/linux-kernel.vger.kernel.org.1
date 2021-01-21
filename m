Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F642FE2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbhAUG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:27:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42019 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726931AbhAUGZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:25:56 -0500
X-UUID: f850b44332cb458aa8d930e56f64993a-20210121
X-UUID: f850b44332cb458aa8d930e56f64993a-20210121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 994015492; Thu, 21 Jan 2021 14:25:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Jan 2021 14:25:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 14:25:09 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <yi.kuo@mediatek.com>
Subject: [PATCH 1/3] memory: mtk-smi: Use platform_register_drivers
Date:   Thu, 21 Jan 2021 14:24:27 +0800
Message-ID: <20210121062429.26504-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121062429.26504-1-yong.wu@mediatek.com>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this file, we have 2 drivers, smi-common and smi-larb.
Use platform_register_drivers.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index ac350f8d1e20..e2aebd2bfa8e 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -587,26 +587,13 @@ static struct platform_driver mtk_smi_common_driver = {
 	}
 };
 
+static struct platform_driver * const smidrivers[] = {
+	&mtk_smi_common_driver,
+	&mtk_smi_larb_driver,
+};
+
 static int __init mtk_smi_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&mtk_smi_common_driver);
-	if (ret != 0) {
-		pr_err("Failed to register SMI driver\n");
-		return ret;
-	}
-
-	ret = platform_driver_register(&mtk_smi_larb_driver);
-	if (ret != 0) {
-		pr_err("Failed to register SMI-LARB driver\n");
-		goto err_unreg_smi;
-	}
-	return ret;
-
-err_unreg_smi:
-	platform_driver_unregister(&mtk_smi_common_driver);
-	return ret;
+	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
 }
-
 module_init(mtk_smi_init);
-- 
2.18.0

