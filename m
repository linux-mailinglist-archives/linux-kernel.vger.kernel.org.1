Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6852FA038
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404238AbhARMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404048AbhARMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:36:58 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33477C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:35:44 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id JCbi240024C55Sk06CbiuL; Mon, 18 Jan 2021 13:35:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1Tkz-004aJf-Me; Mon, 18 Jan 2021 13:35:41 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1Tkz-002MtQ-Ay; Mon, 18 Jan 2021 13:35:41 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] dt-bindings: auxdisplay: ht16k33: Convert to json-schema
Date:   Mon, 18 Jan 2021 13:35:38 +0100
Message-Id: <20210118123538.564597-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118123538.564597-1-geert@linux-m68k.org>
References: <20210118123538.564597-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Holtek HT16K33 LED controller with keyscan Device Tree
binding documentation to json-schema.

Move the file from display to auxdisplay.
Update the example:
  - Sort properties in order of documentation,
  - Group tuples using angle brackets to improve human readability and
    enable automatic validation.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../bindings/auxdisplay/holtek,ht16k33.yaml   | 77 +++++++++++++++++++
 .../devicetree/bindings/display/ht16k33.txt   | 43 -----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 78 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/ht16k33.txt

diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
new file mode 100644
index 0000000000000000..64ffff460026040f
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/holtek,ht16k33.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Holtek HT16K33 RAM mapping 16*8 LED controller with keyscan
+
+maintainers:
+  - Robin van der Gracht <robin@protonic.nl>
+
+allOf:
+  - $ref: "/schemas/input/matrix-keymap.yaml#"
+
+properties:
+  compatible:
+    const: holtek,ht16k33
+
+  reg:
+    maxItems: 1
+
+  refresh-rate-hz:
+    maxItems: 1
+    description: Display update interval in Hertz
+
+  interrupts:
+    maxItems: 1
+
+  debounce-delay-ms:
+    maxItems: 1
+    description: Debouncing interval time in milliseconds
+
+  linux,keymap: true
+
+  linux,no-autorepeat:
+    description: Disable keyrepeat
+
+  default-brightness-level:
+    minimum: 1
+    maximum: 16
+    default: 16
+    description: Initial brightness level
+
+required:
+  - compatible
+  - reg
+  - refresh-rate-hz
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/input.h>
+    i2c1 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ht16k33: ht16k33@70 {
+                    compatible = "holtek,ht16k33";
+                    reg = <0x70>;
+                    refresh-rate-hz = <20>;
+                    interrupt-parent = <&gpio4>;
+                    interrupts = <5 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>;
+                    debounce-delay-ms = <50>;
+                    linux,keymap = <MATRIX_KEY(2, 0, KEY_F6)>,
+                                   <MATRIX_KEY(3, 0, KEY_F8)>,
+                                   <MATRIX_KEY(4, 0, KEY_F10)>,
+                                   <MATRIX_KEY(5, 0, KEY_F4)>,
+                                   <MATRIX_KEY(6, 0, KEY_F2)>,
+                                   <MATRIX_KEY(2, 1, KEY_F5)>,
+                                   <MATRIX_KEY(3, 1, KEY_F7)>,
+                                   <MATRIX_KEY(4, 1, KEY_F9)>,
+                                   <MATRIX_KEY(5, 1, KEY_F3)>,
+                                   <MATRIX_KEY(6, 1, KEY_F1)>;
+            };
+      };
diff --git a/Documentation/devicetree/bindings/display/ht16k33.txt b/Documentation/devicetree/bindings/display/ht16k33.txt
deleted file mode 100644
index ec43776970164921..0000000000000000
--- a/Documentation/devicetree/bindings/display/ht16k33.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Holtek ht16k33 RAM mapping 16*8 LED controller driver with keyscan
--------------------------------------------------------------------------------
-
-Required properties:
-- compatible:		"holtek,ht16k33"
-- reg:			I2C slave address of the chip.
-- refresh-rate-hz:	Display update interval in HZ.
-
-Optional properties:
-- linux,no-autorepeat:	Disable keyrepeat.
-- default-brightness-level: Initial brightness level [1-16] (default: 16).
-
-- Keypad
- Supply the 'interrupts' property to enable the keyscan feature.
- - interrupts:		Interrupt specification for the key pressed interrupt.
- - debounce-delay-ms:	Debouncing interval time in milliseconds.
- - linux,keymap: 	The keymap for keys as described in the binding
-			document (devicetree/bindings/input/matrix-keymap.txt).
-
-Example:
-
-&i2c1 {
-	ht16k33: ht16k33@70 {
-		compatible = "holtek,ht16k33";
-		reg = <0x70>;
-		refresh-rate-hz = <20>;
-		debounce-delay-ms = <50>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <5 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>;
-		linux,keymap = <
-			MATRIX_KEY(2, 0, KEY_F6)
-			MATRIX_KEY(3, 0, KEY_F8)
-			MATRIX_KEY(4, 0, KEY_F10)
-			MATRIX_KEY(5, 0, KEY_F4)
-			MATRIX_KEY(6, 0, KEY_F2)
-			MATRIX_KEY(2, 1, KEY_F5)
-			MATRIX_KEY(3, 1, KEY_F7)
-			MATRIX_KEY(4, 1, KEY_F9)
-			MATRIX_KEY(5, 1, KEY_F3)
-			MATRIX_KEY(6, 1, KEY_F1)
-		>;
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index cc1e6a5ee6e67357..aeb209ad82496d06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8160,7 +8160,7 @@ F:	net/hsr/
 HT16K33 LED CONTROLLER DRIVER
 M:	Robin van der Gracht <robin@protonic.nl>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/ht16k33.txt
+F:	Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
 F:	drivers/auxdisplay/ht16k33.c
 
 HTCPEN TOUCHSCREEN DRIVER
-- 
2.25.1

