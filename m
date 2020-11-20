Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702B92BA6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgKTJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:56:33 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:55838 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgKTJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:56:32 -0500
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 90E95B6A27;
        Fri, 20 Nov 2020 17:56:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P21631T139747833935616S1605866174624500_;
        Fri, 20 Nov 2020 17:56:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8c60b62957be87e8119d0fd2edf8f776>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v14 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND flash controller
Date:   Fri, 20 Nov 2020 17:56:10 +0800
Message-Id: <20201120095613.20172-2-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120095613.20172-1-yifeng.zhao@rock-chips.com>
References: <20201120095613.20172-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation support for Rockchip RK3xxx NAND flash controllers

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v14: None
Changes in v13: None
Changes in v12:
- Fix some warnings while make dt_binding_check
- Drop a allOf defined

Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8:
- Fix a error while make dt_binding_check

Changes in v7:
- Fix some wrong define

Changes in v6:
- Fix some wrong define
- Modified the definition of compatible

Changes in v5:
- Fix some wrong define.
- Add boot-medium define.
- Remove some compatible define.

Changes in v4:
- The compatible define with rkxx_nfc.
- Add assigned-clocks.
- Fix some wrong defineChanges in.

Changes in v3:
- Change the title for the dt-bindings.

Changes in v2: None

 .../mtd/rockchip,nand-controller.yaml         | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml

diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
new file mode 100644
index 000000000000..0922536b1811
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/rockchip,nand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoCs NAND FLASH Controller (NFC)
+
+allOf:
+  - $ref: "nand-controller.yaml#"
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,px30-nfc
+      - const: rockchip,rk2928-nfc
+      - const: rockchip,rv1108-nfc
+      - items:
+          - const: rockchip,rk3036-nfc
+          - const: rockchip,rk2928-nfc
+      - items:
+          - const: rockchip,rk3308-nfc
+          - const: rockchip,rv1108-nfc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ahb
+      - const: nfc
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+patternProperties:
+  "^nand@[0-7]$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+      nand-ecc-mode:
+        const: hw
+
+      nand-ecc-step-size:
+        const: 1024
+
+      nand-ecc-strength:
+        enum: [16, 24, 40, 60, 70]
+        description: |
+          The ECC configurations that can be supported are as follows.
+            NFC v600 ECC 16, 24, 40, 60
+              RK2928, RK3066, RK3188
+
+            NFC v622 ECC 16, 24, 40, 60
+              RK3036, RK3128
+
+            NFC v800 ECC 16
+              RK3308, RV1108
+
+            NFC v900 ECC 16, 40, 60, 70
+              RK3326, PX30
+
+      nand-bus-width:
+        const: 8
+
+      rockchip,boot-blks:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 2
+        default: 16
+        description:
+          The NFC driver need this information to select ECC
+          algorithms supported by the boot ROM.
+          Only used in combination with 'nand-is-boot-medium'.
+
+      rockchip,boot-ecc-strength:
+        enum: [16, 24, 40, 60, 70]
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          If specified it indicates that a different BCH/ECC setting is
+          supported by the boot ROM.
+            NFC v600 ECC 16, 24
+              RK2928, RK3066, RK3188
+
+            NFC v622 ECC 16, 24, 40, 60
+              RK3036, RK3128
+
+            NFC v800 ECC 16
+              RK3308, RV1108
+
+            NFC v900 ECC 16, 70
+              RK3326, PX30
+
+          Only used in combination with 'nand-is-boot-medium'.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3308-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    nfc: nand-controller@ff4b0000 {
+      compatible = "rockchip,rk3308-nfc",
+                   "rockchip,rv1108-nfc";
+      reg = <0xff4b0000 0x4000>;
+      interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+      clock-names = "ahb", "nfc";
+      assigned-clocks = <&clks SCLK_NANDC>;
+      assigned-clock-rates = <150000000>;
+
+      pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_csn0
+                   &flash_rdn &flash_rdy &flash_wrn>;
+      pinctrl-names = "default";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      nand@0 {
+        reg = <0>;
+        label = "rk-nand";
+        nand-bus-width = <8>;
+        nand-ecc-mode = "hw";
+        nand-ecc-step-size = <1024>;
+        nand-ecc-strength = <16>;
+        nand-is-boot-medium;
+        rockchip,boot-blks = <8>;
+        rockchip,boot-ecc-strength = <16>;
+      };
+    };
+
+...
-- 
2.17.1



