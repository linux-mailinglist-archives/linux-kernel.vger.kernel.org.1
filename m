Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54802DF928
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 07:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgLUGLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 01:11:42 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57051 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727224AbgLUGLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 01:11:42 -0500
X-UUID: a41423962c3f47d7897b628543fafd5a-20201221
X-UUID: a41423962c3f47d7897b628543fafd5a-20201221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 322426520; Mon, 21 Dec 2020 14:10:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Dec 2020 14:10:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Dec 2020 14:10:57 +0800
From:   <Yz.Wu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Seiya Wang <seiya.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Ryan Wu <Yz.Wu@mediatek.com>
Subject: [PATCH v3 1/2] dt-bindings: nvmem: mediatek: add support for MediaTek mt8192 SoC
Date:   Mon, 21 Dec 2020 14:10:19 +0800
Message-ID: <20201221061018.18503-2-Yz.Wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201221061018.18503-1-Yz.Wu@mediatek.com>
References: <20201221061018.18503-1-Yz.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wu <Yz.Wu@mediatek.com>

This updates dt-binding documentation for MediaTek mt8192

Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
---
This patch is based on v5.10-rc7.
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index 0668c45a156d..e2f0c0f34d10 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -7,6 +7,7 @@ Required properties:
 	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
 	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
 	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
+	      "mediatek,mt8192-efuse" or "mediatek,efuse": for MT8192
 - reg: Should contain registers location and length
 
 = Data cells =
-- 
2.18.0

