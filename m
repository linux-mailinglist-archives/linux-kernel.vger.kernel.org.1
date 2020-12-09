Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865362D3CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgLIICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:02:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44982 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728489AbgLIICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:02:50 -0500
X-UUID: 49c9e5100ff546779371ca6321fdc86f-20201209
X-UUID: 49c9e5100ff546779371ca6321fdc86f-20201209
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1512407944; Wed, 09 Dec 2020 16:02:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:02:09 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:02:08 +0800
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
Subject: [PATCH v5 05/27] dt-bindings: memory: mediatek: Rename header guard for SMI header file
Date:   Wed, 9 Dec 2020 16:00:40 +0800
Message-ID: <20201209080102.26626-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
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
index b6b2c6bf4459..5c7f303f078c 100644
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
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
index 60f57f54393e..bc93757df2bf 100644
--- a/include/dt-bindings/memory/mt6779-larb-port.h
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -4,8 +4,8 @@
  * Author: Chao Hao <chao.hao@mediatek.com>
  */
 
-#ifndef _DTS_IOMMU_PORT_MT6779_H_
-#define _DTS_IOMMU_PORT_MT6779_H_
+#ifndef _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
index fcb9a49ec60e..8570aab09db8 100644
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
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index d8c99c946053..1b568973fc2d 100644
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
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
index 275c095a6fd6..3095630bb190 100644
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
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
-- 
2.18.0

