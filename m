Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCB221A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 04:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgGPCnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 22:43:24 -0400
Received: from mx.socionext.com ([202.248.49.38]:52330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgGPCnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:43:23 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Jul 2020 11:43:21 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9C53C60060;
        Thu, 16 Jul 2020 11:43:21 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 16 Jul 2020 11:43:21 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 3A11E1A0509;
        Thu, 16 Jul 2020 11:43:21 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: Add UniPhier AHCI PHY description
Date:   Thu, 16 Jul 2020 11:43:01 +0900
Message-Id: <1594867382-27509-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594867382-27509-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1594867382-27509-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for PHY interface built into ahci controller implemented
in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
new file mode 100644
index 0000000..bab2ff4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/socionext,uniphier-ahci-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier AHCI PHY
+
+description: |
+  This describes the deivcetree bindings for PHY interfaces built into
+  AHCI controller implemented on Socionext UniPhier SoCs.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pxs2-ahci-phy
+      - socionext,uniphier-pxs3-ahci-phy
+
+  reg:
+    description: PHY register region (offset and length)
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:          # for PXs2
+        - const: link
+      - items:          # for others
+        - const: link
+        - const: phy
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: link
+      - const: phy
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    ahci-glue@65700000 {
+        compatible = "socionext,uniphier-pxs3-ahci-glue",
+                     "simple-mfd";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x65700000 0x100>;
+
+        ahci_phy: phy@10 {
+            compatible = "socionext,uniphier-pxs3-ahci-phy";
+            reg = <0x10 0x10>;
+            #phy-cells = <0>;
+            clock-names = "link", "phy";
+            clocks = <&sys_clk 28>, <&sys_clk 30>;
+            reset-names = "link", "phy";
+            resets = <&sys_rst 28>, <&sys_rst 30>;
+        };
+    };
-- 
2.7.4

