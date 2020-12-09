Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF972D3CC2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgLIICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:02:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45258 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726449AbgLIICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:02:42 -0500
X-UUID: bda078e12a65473a8c6ec9539b6e132c-20201209
X-UUID: bda078e12a65473a8c6ec9539b6e132c-20201209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1960935038; Wed, 09 Dec 2020 16:01:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:01:58 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:01:58 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH v5 04/27] dt-bindings: memory: mediatek: Add domain definition
Date:   Wed, 9 Dec 2020 16:00:39 +0800
Message-ID: <20201209080102.26626-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest SoC, there are several HW IP require a sepecial iova
range, mainly CCU and VPU has this requirement. Take CCU as a example,
CCU require its iova locate in the range(0x4000_0000 ~ 0x43ff_ffff).

In this patch we add a domain definition for the special port. In the
example of CCU, If we preassign CCU port in domain1, then iommu driver
will prepare a independent iommu domain of the special iova range for it,
then the iova got from dma_alloc_attrs(ccu-dev) will locate in its special
range.

This is a preparing patch for multi-domain support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/memory/mtk-smi-larb-port.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
index 7d64103209af..2d4c973c174f 100644
--- a/include/dt-bindings/memory/mtk-smi-larb-port.h
+++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
@@ -7,9 +7,16 @@
 #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
 
 #define MTK_LARB_NR_MAX			32
+#define MTK_M4U_DOM_NR_MAX		8
+
+#define MTK_M4U_DOM_ID(domid, larb, port)	\
+	(((domid) & 0x7) << 16 | (((larb) & 0x1f) << 5) | ((port) & 0x1f))
+
+/* The default dom id is 0. */
+#define MTK_M4U_ID(larb, port)		MTK_M4U_DOM_ID(0, larb, port)
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
 #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
+#define MTK_M4U_TO_DOM(id)		(((id) >> 16) & 0x7)
 
 #endif
-- 
2.18.0

