Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19362A1CE7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKAJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:32:30 -0500
Received: from aposti.net ([89.234.176.197]:38612 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgKAJc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:32:29 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] dt-bindings: display: Add ABT Y030XX067A panel bindings
Date:   Sun,  1 Nov 2020 09:31:48 +0000
Message-Id: <20201101093150.8071-3-paul@crapouillou.net>
In-Reply-To: <20201101093150.8071-1-paul@crapouillou.net>
References: <20201101093150.8071-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Asia Better Technology (ABT) Y030XX067A panel is a 3.0" 320x480
24-bit IPS LCD panel. Its particularity is that it has non-square pixels
(as it is 4:3 for a resolution of 320x480), and that it requires odd
lines to be sent as RGB and even lines to be sent as GRB on its 8-bit
bus.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../display/panel/abt,y030xx067a.yaml         | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
new file mode 100644
index 000000000000..6407e8bf45fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/abt,y030xx067a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Asia Better Technology 3.0" (320x480 pixels) 24-bit IPS LCD panel
+
+description: |
+  The panel must obey the rules for a SPI slave device as specified in
+  spi/spi-controller.yaml
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: abt,y030xx067a
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "abt,y030xx067a";
+            reg = <0>;
+
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&vcc>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
-- 
2.28.0

