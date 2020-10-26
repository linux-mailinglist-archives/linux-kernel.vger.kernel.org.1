Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6A29876F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769637AbgJZHai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:30:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:29074 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1769611AbgJZHac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:30:32 -0400
IronPort-SDR: SMRHei13pSZMoOgYemDBTDOR8gRQC5lxy9EfsnNo3Sg8R0BAWMomVFYgrEmtGN1HEou/Inh1ZT
 JSiaKLMsNSJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="229521550"
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="229521550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 00:30:31 -0700
IronPort-SDR: /KpiLGGIVpeiNhghe6DtDh2uCp6gj1mV6GJwr+WiW2wMSews7PvpFi9fJ2wKuIaKyXkSBQpiBw
 tPYFAs+6OybA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="350017831"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga004.fm.intel.com with ESMTP; 26 Oct 2020 00:30:27 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        robh+dt@kernel.org
Cc:     boris.brezillon@collabora.com, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [RESENDPATCH v15 1/2] dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC
Date:   Mon, 26 Oct 2020 15:30:20 +0800
Message-Id: <20201026073021.33327-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201026073021.33327-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201026073021.33327-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add YAML file for dt-bindings to support NAND Flash Controller
on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/intel,lgm-nand.yaml    | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
new file mode 100644
index 000000000000..313daec4d783
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/intel,lgm-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel LGM SoC NAND Controller Device Tree Bindings
+
+allOf:
+  - $ref: "nand-controller.yaml"
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+properties:
+  compatible:
+    const: intel,lgm-nand
+
+  reg:
+    maxItems: 6
+
+  reg-names:
+    items:
+       - const: ebunand
+       - const: hsnand
+       - const: nand_cs0
+       - const: nand_cs1
+       - const: addr_sel0
+       - const: addr_sel1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^nand@[a-f0-9]+$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+      nand-ecc-mode: true
+
+      nand-ecc-algo:
+        const: hw
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - dmas
+  - dma-names
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    nand-controller@e0f00000 {
+      compatible = "intel,lgm-nand";
+      reg = <0xe0f00000 0x100>,
+            <0xe1000000 0x300>,
+            <0xe1400000 0x8000>,
+            <0xe1c00000 0x1000>,
+            <0x17400000 0x4>,
+            <0x17c00000 0x4>;
+      reg-names = "ebunand", "hsnand", "nand_cs0", "nand_cs1",
+        "addr_sel0", "addr_sel1";
+      clocks = <&cgu0 125>;
+      dmas = <&dma0 8>, <&dma0 9>;
+      dma-names = "tx", "rx";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      nand@0 {
+        reg = <0>;
+        nand-ecc-mode = "hw";
+      };
+    };
+
+...
-- 
2.11.0

