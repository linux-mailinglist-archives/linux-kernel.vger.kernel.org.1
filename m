Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117726A487
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIOMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:00:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIOLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:46:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBjoXr127858;
        Tue, 15 Sep 2020 06:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600170350;
        bh=jWYp+2dj1jih45hI+bYNB1k0eml6H7E8orooNmkJj6A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=x2xy0ly1lxl//nZINUOaRzNfWkjdOF2mqCdXApoiSWEWG+cNlF0cyNR9mLjotn/QB
         Gjgr9AbSxhH8iKJSMWPc+027RUaYPJf9BgepLwYDCpTMrweIsDgALoieuLseXEVRFG
         EHUCKNBU/GWQQyfarJtteSmDkYddr0gvzfTdb96A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FBjokP084898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 06:45:50 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:45:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:45:50 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBjin7091853;
        Tue, 15 Sep 2020 06:45:47 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 1/3] dt-bindings: usb: Convert cdns-usb3.txt to YAML schema
Date:   Tue, 15 Sep 2020 14:45:41 +0300
Message-ID: <20200915114543.2599-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915114543.2599-1-rogerq@ti.com>
References: <20200915114543.2599-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts cdns-usb3.txt to YAML schema cdns,usb3.yaml

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/usb/cdns,usb3.yaml    | 92 +++++++++++++++++++
 .../devicetree/bindings/usb/cdns-usb3.txt     | 45 ---------
 2 files changed, 92 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
new file mode 100644
index 000000000000..9b14c8443d39
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/cdns,usb3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence USBSS-DRD controller bindings
+
+maintainers:
+  - Pawel Laszczak <pawell@cadence.com>
+
+properties:
+  compatible:
+    const: cdns,usb3
+
+  reg:
+    items:
+      - description: OTG controller registers
+      - description: XHCI Host controller registers
+      - description: DEVICE controller registers
+
+  reg-names:
+    items:
+      - const: otg
+      - const: xhci
+      - const: dev
+
+  interrupts:
+    items:
+      - description: OTG/DRD controller interrupt
+      - description: XHCI host controller interrupt
+      - description: Device controller interrupt
+
+  interrupt-names:
+    items:
+      - const: host
+      - const: peripheral
+      - const: otg
+
+  dr_mode:
+    enum: [host, otg, peripheral]
+
+  maximum-speed:
+    enum: [super-speed, high-speed, full-speed]
+
+  phys:
+   minItems: 1
+   maxItems: 2
+
+  phy-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      anyOf:
+        - const: cdns3,usb2-phy
+        - const: cdns3,usb3-phy
+
+  cdns,on-chip-buff-size:
+    description:
+      size of memory intended as internal memory for endpoints
+      buffers expressed in KB
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@6000000 {
+            compatible = "cdns,usb3";
+            reg = <0x00 0x6000000 0x00 0x10000>,
+                  <0x00 0x6010000 0x00 0x10000>,
+                  <0x00 0x6020000 0x00 0x10000>;
+            reg-names = "otg", "xhci", "dev";
+            interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "host", "peripheral", "otg";
+            maximum-speed = "super-speed";
+            dr_mode = "otg";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
deleted file mode 100644
index b7dc606d37b5..000000000000
--- a/Documentation/devicetree/bindings/usb/cdns-usb3.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Binding for the Cadence USBSS-DRD controller
-
-Required properties:
- - reg: Physical base address and size of the controller's register areas.
-	 Controller has 3 different regions:
-	 - HOST registers area
-	 - DEVICE registers area
-	 - OTG/DRD registers area
- - reg-names - register memory area names:
-	"xhci" - for HOST registers space
-	"dev" - for DEVICE registers space
-	"otg" - for OTG/DRD registers space
- - compatible: Should contain: "cdns,usb3"
- - interrupts: Interrupts used by cdns3 controller:
-	"host" - interrupt used by XHCI driver.
-	"peripheral" - interrupt used by device driver
-	"otg" - interrupt used by DRD/OTG  part of driver
-
-Optional properties:
- - maximum-speed : valid arguments are "super-speed", "high-speed" and
-                   "full-speed"; refer to usb/generic.txt
- - dr_mode: Should be one of "host", "peripheral" or "otg".
- - phys: reference to the USB PHY
- - phy-names: from the *Generic PHY* bindings;
-	Supported names are:
-	- cdns3,usb2-phy
-	- cdns3,usb3-phy
-
- - cdns,on-chip-buff-size : size of memory intended as internal memory for endpoints
-	buffers expressed in KB
-
-Example:
-	usb@f3000000 {
-		compatible = "cdns,usb3";
-		interrupts = <GIC_USB_IRQ 7 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>,
-				<GIC_USB_IRQ  8 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host", "peripheral", "otg";
-		reg = <0xf3000000 0x10000>,	/* memory area for HOST registers */
-			<0xf3010000 0x10000>,	/* memory area for DEVICE registers */
-			<0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
-		reg-names = "xhci", "dev", "otg";
-		phys = <&usb2_phy>, <&usb3_phy>;
-		phy-names = "cdns3,usb2-phy", "cnds3,usb3-phy";
-	};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

