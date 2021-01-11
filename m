Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60B22F1108
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbhAKLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:20:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728318AbhAKLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:20:23 -0500
X-UUID: a43e46f9aac24f2db83beb1f49bdf68d-20210111
X-UUID: a43e46f9aac24f2db83beb1f49bdf68d-20210111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1984674395; Mon, 11 Jan 2021 19:19:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:19:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:19:34 +0800
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
Subject: [PATCH v6 01/33] dt-bindings: iommu: mediatek: Convert IOMMU to DT schema
Date:   Mon, 11 Jan 2021 19:18:42 +0800
Message-ID: <20210111111914.22211-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MediaTek IOMMU to DT schema.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iommu/mediatek,iommu.txt         | 105 -----------
 .../bindings/iommu/mediatek,iommu.yaml        | 167 ++++++++++++++++++
 2 files changed, 167 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
deleted file mode 100644
index ac949f7fe3d4..000000000000
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ /dev/null
@@ -1,105 +0,0 @@
-* Mediatek IOMMU Architecture Implementation
-
-  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U), and
-this M4U have two generations of HW architecture. Generation one uses flat
-pagetable, and only supports 4K size page mapping. Generation two uses the
-ARM Short-Descriptor translation table format for address translation.
-
-  About the M4U Hardware Block Diagram, please check below:
-
-              EMI (External Memory Interface)
-               |
-              m4u (Multimedia Memory Management Unit)
-               |
-          +--------+
-          |        |
-      gals0-rx   gals1-rx    (Global Async Local Sync rx)
-          |        |
-          |        |
-      gals0-tx   gals1-tx    (Global Async Local Sync tx)
-          |        |          Some SoCs may have GALS.
-          +--------+
-               |
-           SMI Common(Smart Multimedia Interface Common)
-               |
-       +----------------+-------
-       |                |
-       |             gals-rx        There may be GALS in some larbs.
-       |                |
-       |                |
-       |             gals-tx
-       |                |
-   SMI larb0        SMI larb1   ... SoCs have several SMI local arbiter(larb).
-   (display)         (vdec)
-       |                |
-       |                |
- +-----+-----+     +----+----+
- |     |     |     |    |    |
- |     |     |...  |    |    |  ... There are different ports in each larb.
- |     |     |     |    |    |
-OVL0 RDMA0 WDMA0  MC   PP   VLD
-
-  As above, The Multimedia HW will go through SMI and M4U while it
-access EMI. SMI is a bridge between m4u and the Multimedia HW. It contain
-smi local arbiter and smi common. It will control whether the Multimedia
-HW should go though the m4u for translation or bypass it and talk
-directly with EMI. And also SMI help control the power domain and clocks for
-each local arbiter.
-  Normally we specify a local arbiter(larb) for each multimedia HW
-like display, video decode, and camera. And there are different ports
-in each larb. Take a example, There are many ports like MC, PP, VLD in the
-video decode local arbiter, all these ports are according to the video HW.
-  In some SoCs, there may be a GALS(Global Async Local Sync) module between
-smi-common and m4u, and additional GALS module between smi-larb and
-smi-common. GALS can been seen as a "asynchronous fifo" which could help
-synchronize for the modules in different clock frequency.
-
-Required properties:
-- compatible : must be one of the following string:
-	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
-	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
-	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
-	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
-						     generation one m4u HW.
-	"mediatek,mt8167-m4u" for mt8167 which uses generation two m4u HW.
-	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
-	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
-- reg : m4u register base and size.
-- interrupts : the interrupt of m4u.
-- clocks : must contain one entry for each clock-names.
-- clock-names : Only 1 optional clock:
-  - "bclk": the block clock of m4u.
-  Here is the list which require this "bclk":
-  - mt2701, mt2712, mt7623 and mt8173.
-  Note that m4u use the EMI clock which always has been enabled before kernel
-  if there is no this "bclk".
-- mediatek,larbs : List of phandle to the local arbiters in the current Socs.
-	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
-	according to the local arbiter index, like larb0, larb1, larb2...
-- iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
-	Specifies the mtk_m4u_id as defined in
-	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
-	dt-binding/memory/mt2712-larb-port.h for mt2712,
-	dt-binding/memory/mt6779-larb-port.h for mt6779,
-	dt-binding/memory/mt8167-larb-port.h for mt8167,
-	dt-binding/memory/mt8173-larb-port.h for mt8173, and
-	dt-binding/memory/mt8183-larb-port.h for mt8183.
-
-Example:
-	iommu: iommu@10205000 {
-		compatible = "mediatek,mt8173-m4u";
-		reg = <0 0x10205000 0 0x1000>;
-		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&infracfg CLK_INFRA_M4U>;
-		clock-names = "bclk";
-		mediatek,larbs = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
-		#iommu-cells = <1>;
-	};
-
-Example for a client device:
-	display {
-		compatible = "mediatek,mt8173-disp";
-		iommus = <&iommu M4U_PORT_DISP_OVL0>,
-			 <&iommu M4U_PORT_DISP_RDMA0>;
-		...
-	};
diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
new file mode 100644
index 000000000000..b9946809fc2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/mediatek,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek IOMMU Architecture Implementation
+
+maintainers:
+  - Yong Wu <yong.wu@mediatek.com>
+
+description: |+
+  Some MediaTek SOCs contain a Multimedia Memory Management Unit (M4U), and
+  this M4U have two generations of HW architecture. Generation one uses flat
+  pagetable, and only supports 4K size page mapping. Generation two uses the
+  ARM Short-Descriptor translation table format for address translation.
+
+  About the M4U Hardware Block Diagram, please check below:
+
+                EMI (External Memory Interface)
+                 |
+                m4u (Multimedia Memory Management Unit)
+                 |
+            +--------+
+            |        |
+        gals0-rx   gals1-rx    (Global Async Local Sync rx)
+            |        |
+            |        |
+        gals0-tx   gals1-tx    (Global Async Local Sync tx)
+            |        |          Some SoCs may have GALS.
+            +--------+
+                 |
+             SMI Common(Smart Multimedia Interface Common)
+                 |
+         +----------------+-------
+         |                |
+         |             gals-rx        There may be GALS in some larbs.
+         |                |
+         |                |
+         |             gals-tx
+         |                |
+     SMI larb0        SMI larb1   ... SoCs have several SMI local arbiter(larb).
+     (display)         (vdec)
+         |                |
+         |                |
+   +-----+-----+     +----+----+
+   |     |     |     |    |    |
+   |     |     |...  |    |    |  ... There are different ports in each larb.
+   |     |     |     |    |    |
+  OVL0 RDMA0 WDMA0  MC   PP   VLD
+
+  As above, The Multimedia HW will go through SMI and M4U while it
+  access EMI. SMI is a bridge between m4u and the Multimedia HW. It contain
+  smi local arbiter and smi common. It will control whether the Multimedia
+  HW should go though the m4u for translation or bypass it and talk
+  directly with EMI. And also SMI help control the power domain and clocks for
+  each local arbiter.
+
+  Normally we specify a local arbiter(larb) for each multimedia HW
+  like display, video decode, and camera. And there are different ports
+  in each larb. Take a example, There are many ports like MC, PP, VLD in the
+  video decode local arbiter, all these ports are according to the video HW.
+
+  In some SoCs, there may be a GALS(Global Async Local Sync) module between
+  smi-common and m4u, and additional GALS module between smi-larb and
+  smi-common. GALS can been seen as a "asynchronous fifo" which could help
+  synchronize for the modules in different clock frequency.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-m4u  # generation one
+          - mediatek,mt2712-m4u  # generation two
+          - mediatek,mt6779-m4u  # generation two
+          - mediatek,mt8167-m4u  # generation two
+          - mediatek,mt8173-m4u  # generation two
+          - mediatek,mt8183-m4u  # generation two
+
+      - description: mt7623 generation one
+        items:
+          - const: mediatek,mt7623-m4u
+          - const: mediatek,mt2701-m4u
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: bclk is the block clock.
+
+  clock-names:
+    items:
+      - const: bclk
+
+  mediatek,larbs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 16
+    description: |
+      List of phandle to the local arbiters in the current Socs.
+      Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
+      according to the local arbiter index, like larb0, larb1, larb2...
+
+  '#iommu-cells':
+    const: 1
+    description: |
+      This is the mtk_m4u_id according to the HW. Specifies the mtk_m4u_id as
+      defined in
+      dt-binding/memory/mt2701-larb-port.h for mt2701 and mt7623,
+      dt-binding/memory/mt2712-larb-port.h for mt2712,
+      dt-binding/memory/mt6779-larb-port.h for mt6779,
+      dt-binding/memory/mt8167-larb-port.h for mt8167,
+      dt-binding/memory/mt8173-larb-port.h for mt8173,
+      dt-binding/memory/mt8183-larb-port.h for mt8183.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - mediatek,larbs
+  - '#iommu-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2701-m4u
+              - mediatek,mt2712-m4u
+              - mediatek,mt8173-m4u
+
+    then:
+      required:
+        - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    iommu: iommu@10205000 {
+            compatible = "mediatek,mt8173-m4u";
+            reg = <0x10205000 0x1000>;
+            interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&infracfg CLK_INFRA_M4U>;
+            clock-names = "bclk";
+            mediatek,larbs = <&larb0 &larb1 &larb2
+                              &larb3 &larb4 &larb5>;
+            #iommu-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/memory/mt8173-larb-port.h>
+
+    /* Example for a client device */
+    display {
+           compatible = "mediatek,mt8173-disp";
+           iommus = <&iommu M4U_PORT_DISP_OVL0>,
+                    <&iommu M4U_PORT_DISP_RDMA0>;
+     };
-- 
2.18.0

