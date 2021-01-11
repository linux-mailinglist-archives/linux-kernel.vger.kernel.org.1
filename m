Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7993A2F1123
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbhAKLUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:20:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59035 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728318AbhAKLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:20:35 -0500
X-UUID: f871bb856f7642a8b66258334904b0e4-20210111
X-UUID: f871bb856f7642a8b66258334904b0e4-20210111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 602766215; Mon, 11 Jan 2021 19:19:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:19:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:19:46 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v6 02/33] dt-bindings: memory: mediatek: Add a common memory header file
Date:   Mon, 11 Jan 2021 19:18:43 +0800
Message-ID: <20210111111914.22211-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put all the macros about smi larb/port togethers.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/dt-bindings/memory/mt2712-larb-port.h |  2 +-
 include/dt-bindings/memory/mt6779-larb-port.h |  2 +-
 include/dt-bindings/memory/mt8167-larb-port.h |  2 +-
 include/dt-bindings/memory/mt8173-larb-port.h |  2 +-
 include/dt-bindings/memory/mt8183-larb-port.h |  2 +-
 include/dt-bindings/memory/mtk-memory-port.h  | 15 +++++++++++++++
 6 files changed, 20 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/memory/mtk-memory-port.h

diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
index 6f9aa7349cef..83e8070b4c1c 100644
--- a/include/dt-bindings/memory/mt2712-larb-port.h
+++ b/include/dt-bindings/memory/mt2712-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT2712_H
 #define __DTS_IOMMU_PORT_MT2712_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-memory-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
index 2ad0899fbf2f..91b0be285f41 100644
--- a/include/dt-bindings/memory/mt6779-larb-port.h
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -7,7 +7,7 @@
 #ifndef _DTS_IOMMU_PORT_MT6779_H_
 #define _DTS_IOMMU_PORT_MT6779_H_
 
-#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-memory-port.h>
 
 #define M4U_LARB0_ID			 0
 #define M4U_LARB1_ID			 1
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
index 000fb299a408..13925c4fee00 100644
--- a/include/dt-bindings/memory/mt8167-larb-port.h
+++ b/include/dt-bindings/memory/mt8167-larb-port.h
@@ -8,7 +8,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8167_H
 #define __DTS_IOMMU_PORT_MT8167_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-memory-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index 9f31ccfeca21..c2379b3236d6 100644
--- a/include/dt-bindings/memory/mt8173-larb-port.h
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8173_H
 #define __DTS_IOMMU_PORT_MT8173_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-memory-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
index 2c579f305162..de8bf81b5d9e 100644
--- a/include/dt-bindings/memory/mt8183-larb-port.h
+++ b/include/dt-bindings/memory/mt8183-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8183_H
 #define __DTS_IOMMU_PORT_MT8183_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-memory-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
new file mode 100644
index 000000000000..53354cf4f6e3
--- /dev/null
+++ b/include/dt-bindings/memory/mtk-memory-port.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
+#define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
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

