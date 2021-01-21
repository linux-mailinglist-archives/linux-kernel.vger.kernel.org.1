Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECD2FE2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbhAUG3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:29:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42019 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727072AbhAUG0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:26:20 -0500
X-UUID: f4ffa75eb587450db4691b690f47d303-20210121
X-UUID: f4ffa75eb587450db4691b690f47d303-20210121
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 492986384; Thu, 21 Jan 2021 14:25:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Jan 2021 14:25:22 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 14:25:21 +0800
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
Subject: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
Date:   Thu, 21 Jan 2021 14:24:28 +0800
Message-ID: <20210121062429.26504-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121062429.26504-1-yong.wu@mediatek.com>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 24476291C01264CB107719D7F0A11F842FC2D47325FB94F0AD32DB898B4DCD9F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config MTK_SMI always depends on MTK_IOMMU which is built-in
currently. Thus we don't have module_exit before. This patch adds
module_exit and module_license. It is a preparing patch for supporting
MTK_SMI could been built as a module.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index e2aebd2bfa8e..aa2a25abf04f 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
 	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
 }
 module_init(mtk_smi_init);
+
+static void __exit mtk_smi_exit(void)
+{
+	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
+}
+module_exit(mtk_smi_exit);
+
+MODULE_DESCRIPTION("MediaTek SMI driver");
+MODULE_ALIAS("platform:MediaTek-SMI");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

