Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F92F1127
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbhAKLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:20:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59035 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729655AbhAKLUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:20:51 -0500
X-UUID: 88bc27248e374090bbec2c133f777448-20210111
X-UUID: 88bc27248e374090bbec2c133f777448-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 131113744; Mon, 11 Jan 2021 19:20:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:20:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:20:10 +0800
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
Subject: [PATCH v6 04/33] dt-bindings: memory: mediatek: Rename header guard for SMI header file
Date:   Mon, 11 Jan 2021 19:18:45 +0800
Message-ID: <20210111111914.22211-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only rename the header guard for all the SoC larb port header file.
No funtional change.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/memory/mt2701-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt2712-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt6779-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt8167-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt8173-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt8183-larb-port.h | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/dt-bindings/memory/mt2701-larb-port.h b/include/dt-bindings/memory/mt2701-larb-port.h
index 2d85c2ec6cfd..25d03526f142 100644
--- a/include/dt-bindings/memory/mt2701-larb-port.h
+++ b/include/dt-bindings/memory/mt2701-larb-port.h
@@ -4,8 +4,8 @@
  * Author: Honghui Zhang <honghui.zhang@mediatek.com>
  */
 
-#ifndef _MT2701_LARB_PORT_H_
-#define _MT2701_LARB_PORT_H_
+#ifndef _DT_BINDINGS_MEMORY_MT2701_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT2701_LARB_PORT_H_
 
 /*
  * Mediatek m4u generation 1 such as mt2701 has flat m4u port numbers,
diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
index 83e8070b4c1c..e41a2841bcff 100644
--- a/include/dt-bindings/memory/mt2712-larb-port.h
+++ b/include/dt-bindings/memory/mt2712-larb-port.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2017 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT2712_H
-#define __DTS_IOMMU_PORT_MT2712_H
+#ifndef _DT_BINDINGS_MEMORY_MT2712_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT2712_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-memory-port.h>
 
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
index 91b0be285f41..3fb438a96e35 100644
--- a/include/dt-bindings/memory/mt6779-larb-port.h
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -4,8 +4,8 @@
  * Author: Chao Hao <chao.hao@mediatek.com>
  */
 
-#ifndef _DTS_IOMMU_PORT_MT6779_H_
-#define _DTS_IOMMU_PORT_MT6779_H_
+#ifndef _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-memory-port.h>
 
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
index 13925c4fee00..aae57d4824ca 100644
--- a/include/dt-bindings/memory/mt8167-larb-port.h
+++ b/include/dt-bindings/memory/mt8167-larb-port.h
@@ -5,8 +5,8 @@
  * Author: Honghui Zhang <honghui.zhang@mediatek.com>
  * Author: Fabien Parent <fparent@baylibre.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT8167_H
-#define __DTS_IOMMU_PORT_MT8167_H
+#ifndef _DT_BINDINGS_MEMORY_MT8167_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8167_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-memory-port.h>
 
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index c2379b3236d6..167a7fc51868 100644
--- a/include/dt-bindings/memory/mt8173-larb-port.h
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015-2016 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT8173_H
-#define __DTS_IOMMU_PORT_MT8173_H
+#ifndef _DT_BINDINGS_MEMORY_MT8173_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8173_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-memory-port.h>
 
diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
index de8bf81b5d9e..36abdf0ce5a2 100644
--- a/include/dt-bindings/memory/mt8183-larb-port.h
+++ b/include/dt-bindings/memory/mt8183-larb-port.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2018 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT8183_H
-#define __DTS_IOMMU_PORT_MT8183_H
+#ifndef _DT_BINDINGS_MEMORY_MT8183_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8183_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-memory-port.h>
 
-- 
2.18.0

