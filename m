Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C42ACFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgKJGj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:39:56 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:40458 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgKJGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:39:56 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07902727|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.627402-0.00133112-0.371267;FP=17316820775139370430|1|1|17|0|-1|-1|-1;HT=ay29a033018047192;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.IuovrI7_1604990386;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuovrI7_1604990386)
          by smtp.aliyun-inc.com(10.147.41.158);
          Tue, 10 Nov 2020 14:39:50 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [RESEND PATCH 12/19] dt-bindings: Add bindings for USB phy on Allwinner A100
Date:   Tue, 10 Nov 2020 14:39:42 +0800
Message-Id: <1ce71bac2732620f8fe77b23ca84e062385e7e8a.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a device tree binding for the A100's USB PHY.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 .../phy/allwinner,sun50i-a100-usb-phy.yaml    | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
new file mode 100644
index 000000000000..cc9bbebe2bd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a100-usb-phy.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/allwinner,sun50i-a100-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A100 USB PHY Device Tree Bindings
+
+maintainers:
+  - Yangtao Li <tiny.windzz@gmail.com>
+
+properties:
+  "#phy-cells":
+    const: 1
+
+  compatible:
+    const: allwinner,sun50i-a100-usb-phy
+
+  reg:
+    items:
+      - description: PHY Control registers
+      - description: PHY PMU0 registers
+      - description: PHY PMU1 registers
+
+  reg-names:
+    items:
+      - const: phy_ctrl
+      - const: pmu0
+      - const: pmu1
+
+  clocks:
+    items:
+      - description: USB OTG PHY bus clock
+      - description: USB Host 0 PHY bus clock
+
+  clock-names:
+    items:
+      - const: usb0_phy
+      - const: usb1_phy
+
+  resets:
+    items:
+      - description: USB OTG reset
+      - description: USB Host 1 Controller reset
+
+  reset-names:
+    items:
+      - const: usb0_reset
+      - const: usb1_reset
+
+  usb0_id_det-gpios:
+    description: GPIO to the USB OTG ID pin
+
+  usb0_vbus_det-gpios:
+    description: GPIO to the USB OTG VBUS detect pin
+
+  usb0_vbus_power-supply:
+    description: Power supply to detect the USB OTG VBUS
+
+  usb0_vbus-supply:
+    description: Regulator controlling USB OTG VBUS
+
+  usb1_vbus-supply:
+    description: Regulator controlling USB1 Host controller
+
+required:
+  - "#phy-cells"
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/sun50i-a100-ccu.h>
+    #include <dt-bindings/reset/sun50i-a100-ccu.h>
+
+    phy@5100400 {
+        #phy-cells = <1>;
+        compatible = "allwinner,sun50i-a100-usb-phy";
+        reg = <0x05100400 0x14>,
+              <0x05101800 0x4>,
+              <0x05200800 0x4>;
+        reg-names = "phy_ctrl",
+                    "pmu0",
+                    "pmu1";
+        clocks = <&ccu CLK_USB_PHY0>,
+                 <&ccu CLK_USB_PHY1>;
+        clock-names = "usb0_phy",
+                      "usb1_phy";
+        resets = <&ccu RST_USB_PHY0>,
+                 <&ccu RST_USB_PHY1>;
+        reset-names = "usb0_reset",
+                      "usb1_reset";
+        usb0_id_det-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
+        usb0_vbus_power-supply = <&usb_power_supply>;
+        usb0_vbus-supply = <&reg_drivevbus>;
+        usb1_vbus-supply = <&reg_usb1_vbus>;
+    };
-- 
2.28.0

