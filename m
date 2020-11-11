Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1A2AF0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgKKMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:39:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56681 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726207AbgKKMjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:39:09 -0500
X-UUID: 25826fb48a314b3ab30193fa8d8f9342-20201111
X-UUID: 25826fb48a314b3ab30193fa8d8f9342-20201111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 613552493; Wed, 11 Nov 2020 20:39:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 20:39:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 20:39:02 +0800
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
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Subject: [PATCH v4 02/24] dt-bindings: memory: mediatek: Add a common larb-port header file
Date:   Wed, 11 Nov 2020 20:38:16 +0800
Message-ID: <20201111123838.15682-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put all the macros about smi larb/port togethers, this is a preparing
patch for extending LARB_NR and adding new dom-id support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt8167-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
 include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
 6 files changed, 20 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h

diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
index 6f9aa7349cef..b6b2c6bf4459 100644
--- a/include/dt-bindings/memory/mt2712-larb-port.h
+++ b/include/dt-bindings/memory/mt2712-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT2712_H
 #define __DTS_IOMMU_PORT_MT2712_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
index 2ad0899fbf2f..60f57f54393e 100644
--- a/include/dt-bindings/memory/mt6779-larb-port.h
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -7,7 +7,7 @@
 #ifndef _DTS_IOMMU_PORT_MT6779_H_
 #define _DTS_IOMMU_PORT_MT6779_H_
 
-#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			 0
 #define M4U_LARB1_ID			 1
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
index 000fb299a408..fcb9a49ec60e 100644
--- a/include/dt-bindings/memory/mt8167-larb-port.h
+++ b/include/dt-bindings/memory/mt8167-larb-port.h
@@ -8,7 +8,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8167_H
 #define __DTS_IOMMU_PORT_MT8167_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index 9f31ccfeca21..d8c99c946053 100644
--- a/include/dt-bindings/memory/mt8173-larb-port.h
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8173_H
 #define __DTS_IOMMU_PORT_MT8173_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
index 2c579f305162..275c095a6fd6 100644
--- a/include/dt-bindings/memory/mt8183-larb-port.h
+++ b/include/dt-bindings/memory/mt8183-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8183_H
 #define __DTS_IOMMU_PORT_MT8183_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
new file mode 100644
index 000000000000..2ec7fe5ce4e9
--- /dev/null
+++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef __DTS_MTK_IOMMU_PORT_H_
+#define __DTS_MTK_IOMMU_PORT_H_
+
+#define MTK_LARB_NR_MAX			16
+
+#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
+#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
+
+#endif
-- 
2.18.0

