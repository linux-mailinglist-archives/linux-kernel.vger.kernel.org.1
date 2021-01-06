Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43672EC566
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbhAFU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFU7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:59:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CBDC061757;
        Wed,  6 Jan 2021 12:58:49 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m25so9588457lfc.11;
        Wed, 06 Jan 2021 12:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3C5qorUchd+Gu0RBmxpHfL4EcgXGnmcBFZeCm/djUM=;
        b=XOjzHs0sO8WMuE1pI9KPEMRZh4qP+N/82ss3Q80wrQ11VKxDXQ/mJYE3HlzuBqT8Tf
         22nUqywKbapA9EG5lELIr4/TpvHerp42XxXIGeoKZSPSykGAurMM15Gi4LkFxRgEY+A1
         CuD2qEsWfwua2lKJlLyMTg9Hcwci9IhgvLDFImEAflZplnp54rVDtBnKNkH3/uymlpfD
         ylXPyNaB4taY+BHDlkVeU3Y7DZi9RdRcSE4BUrFoSNMXPYyRBnj4O2fox4ugH9jnFZrd
         8mV2jvmaYPMKAHhK7AwkYCjVCLJnO0rkzdKn+As89C5tDALIOv0BHgfMbQ51fmO98PyX
         iGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3C5qorUchd+Gu0RBmxpHfL4EcgXGnmcBFZeCm/djUM=;
        b=dQOJIcKM0WFnhpe1GT1VUKHRewx+UY2wLS217Ogu/BL1nlR5Me6WsN32TWKf38sfnk
         cLpM+rj1jxYFbP0g/vGUOn9laVhSTkUpSv+bbmmAVM5cDJGX2RQzJRAthGIdVYXgMOcq
         EIGZ9vH0Pm1/RKv+ae4EFMEtHW0Ykyage29VY0q8hzPfN+xyc+AKc2DU7r2oyteNLe7I
         SEA5aekCylWno/RZwcdnd/kLcBFl/A7nUawxlOqqLJf8wXT5BaOItXd6A2mPfNQBWi3t
         4Ro7AzfGEke3rXDyYjcj+/k3tw9KE0MqZ45eRq6+76YzKas3zv6448pEjMxLUs9yyTpn
         V/rw==
X-Gm-Message-State: AOAM533C4jDlxEWjrQF3LzOvuhzDthuNyxCdHn8EYgBLkOr3GIbuFTJn
        4zihLrj/Wf7pS45QUgIMsU0=
X-Google-Smtp-Source: ABdhPJzeGC5FwbnoLaHqLEVv4OMKzhoXrCvTwpV5/LnR17RNB+ki4wzBhjfK0685TwIXfXhzuZhugA==
X-Received: by 2002:a19:d82:: with SMTP id 124mr2502083lfn.604.1609966727766;
        Wed, 06 Jan 2021 12:58:47 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t3sm606970lfe.263.2021.01.06.12.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:58:47 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 1/3] dt-bindings: phy: brcm,brcmstb-usb-phy: convert to the json-schema
Date:   Wed,  6 Jan 2021 21:58:36 +0100
Message-Id: <20210106205838.10964-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Changes that require mentioning:
1. interrupt-names
   Name "wakeup" was changed to the "wake". It matches example and what
   Linux driver looks for in the first place
2. brcm,ipp and brcm,ioc
   Both were described as booleans with 0 / 1 values. In examples they
   were integers and Linux checks for int as well. Both got uint32.
3. Added minimal description

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add Al as maintainer
V3: Define "reg" and "reg-names" directly in the properties
V4: additionalProperties: false
    Fix example to use brcm,syscon-piarbctl (with the prefix)
---
 .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  86 --------
 .../bindings/phy/brcm,brcmstb-usb-phy.yaml    | 193 ++++++++++++++++++
 2 files changed, 193 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
deleted file mode 100644
index 698aacbdcfc4..000000000000
--- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
+++ /dev/null
@@ -1,86 +0,0 @@
-Broadcom STB USB PHY
-
-Required properties:
-- compatible: should be one of
-	"brcm,brcmstb-usb-phy"
-	"brcm,bcm7216-usb-phy"
-	"brcm,bcm7211-usb-phy"
-
-- reg and reg-names properties requirements are specific to the
-  compatible string.
-  "brcm,brcmstb-usb-phy":
-    - reg: 1 or 2 offset and length pairs. One for the base CTRL registers
-           and an optional pair for systems with USB 3.x support
-    - reg-names: not specified
-  "brcm,bcm7216-usb-phy":
-    - reg: 3 offset and length pairs for CTRL, XHCI_EC and XHCI_GBL
-           registers
-    - reg-names: "ctrl", "xhci_ec", "xhci_gbl"
-  "brcm,bcm7211-usb-phy":
-    - reg: 5 offset and length pairs for CTRL, XHCI_EC, XHCI_GBL,
-           USB_PHY and USB_MDIO registers and an optional pair
-	   for the BDC registers
-    - reg-names: "ctrl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
-
-- #phy-cells: Shall be 1 as it expects one argument for setting
-	      the type of the PHY. Possible values are:
-	      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
-	      - PHY_TYPE_USB3 for USB3.x PHY
-
-Optional Properties:
-- clocks : clock phandles.
-- clock-names: String, clock name.
-- interrupts: wakeup interrupt
-- interrupt-names: "wakeup"
-- brcm,ipp: Boolean, Invert Port Power.
-  Possible values are: 0 (Don't invert), 1 (Invert)
-- brcm,ioc: Boolean, Invert Over Current detection.
-  Possible values are: 0 (Don't invert), 1 (Invert)
-- dr_mode: String, PHY Device mode.
-  Possible values are: "host", "peripheral ", "drd" or "typec-pd"
-  If this property is not defined, the phy will default to "host" mode.
-- brcm,syscon-piarbctl: phandle to syscon for handling config registers
-NOTE: one or both of the following two properties must be set
-- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
-- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
-
-
-Example:
-
-usbphy_0: usb-phy@f0470200 {
-	reg = <0xf0470200 0xb8>,
-		<0xf0471940 0x6c0>;
-	compatible = "brcm,brcmstb-usb-phy";
-	#phy-cells = <1>;
-	dr_mode = "host"
-	brcm,ioc = <1>;
-	brcm,ipp = <1>;
-	brcm,has-xhci;
-	brcm,has-eohci;
-	clocks = <&usb20>, <&usb30>;
-	clock-names = "sw_usb", "sw_usb3";
-};
-
-usb-phy@29f0200 {
-	reg = <0x29f0200 0x200>,
-		<0x29c0880 0x30>,
-		<0x29cc100 0x534>,
-		<0x2808000 0x24>,
-		<0x2980080 0x8>;
-	reg-names = "ctrl",
-		"xhci_ec",
-		"xhci_gbl",
-		"usb_phy",
-		"usb_mdio";
-	brcm,ioc = <0x0>;
-	brcm,ipp = <0x0>;
-	compatible = "brcm,bcm7211-usb-phy";
-	interrupts = <0x30>;
-	interrupt-parent = <&vpu_intr1_nosec_intc>;
-	interrupt-names = "wake";
-	#phy-cells = <0x1>;
-	brcm,has-xhci;
-	syscon-piarbctl = <&syscon_piarbctl>;
-	clocks = <&scmi_clk 256>;
-	clock-names = "sw_usb";
-};
diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
new file mode 100644
index 000000000000..a5780beadf97
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
@@ -0,0 +1,193 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/brcm,brcmstb-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom STB USB PHY
+
+description: Broadcom's PHY that handles EHCI/OHCI and/or XHCI
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm7211-usb-phy
+      - brcm,bcm7216-usb-phy
+      - brcm,brcmstb-usb-phy
+
+  reg:
+    minItems: 1
+    maxItems: 6
+    items:
+      - description: the base CTRL register
+      - description: XHCI EC register
+      - description: XHCI GBL register
+      - description: USB PHY register
+      - description: USB MDIO register
+      - description: BDC register
+
+  reg-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      - const: ctrl
+      - const: xhci_ec
+      - const: xhci_gbl
+      - const: usb_phy
+      - const: usb_mdio
+      - const: bdc_ec
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: sw_usb
+      - const: sw_usb3
+
+  interrupts:
+    description: wakeup interrupt
+
+  interrupt-names:
+    const: wake
+
+  brcm,ipp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Invert Port Power
+    minimum: 0
+    maximum: 1
+
+  brcm,ioc:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Invert Over Current detection
+    minimum: 0
+    maximum: 1
+
+  dr_mode:
+    description: PHY Device mode. If this property is not defined, the PHY will
+      default to "host" mode.
+    enum:
+      - host
+      - peripheral
+      - drd
+      - typec-pd
+
+  brcm,syscon-piarbctl:
+    description: phandle to syscon for handling config registers
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  brcm,has-xhci:
+    description: Indicates the PHY has an XHCI PHY.
+    type: boolean
+
+  brcm,has-eohci:
+    description: Indicates the PHY has an EHCI/OHCI PHY.
+    type: boolean
+
+  "#phy-cells":
+    description: |
+      Cell allows setting the type of the PHY. Possible values are:
+      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
+      - PHY_TYPE_USB3 for USB3.x PHY
+    const: 1
+
+required:
+  - reg
+  - "#phy-cells"
+
+anyOf:
+  - required:
+      - brcm,has-xhci
+  - required:
+      - brcm,has-eohci
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,brcmstb-usb-phy
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm7211-usb-phy
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 6
+        reg-names:
+          minItems: 5
+          maxItems: 6
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm7216-usb-phy
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+        reg-names:
+          minItems: 3
+          maxItems: 3
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+
+    usb-phy@f0470200 {
+        compatible = "brcm,brcmstb-usb-phy";
+        reg = <0xf0470200 0xb8>,
+              <0xf0471940 0x6c0>;
+        #phy-cells = <1>;
+        dr_mode = "host";
+        brcm,ioc = <1>;
+        brcm,ipp = <1>;
+        brcm,has-xhci;
+        brcm,has-eohci;
+        clocks = <&usb20>, <&usb30>;
+        clock-names = "sw_usb", "sw_usb3";
+    };
+  - |
+    #include <dt-bindings/phy/phy.h>
+
+    usb-phy@29f0200 {
+        compatible = "brcm,bcm7211-usb-phy";
+        reg = <0x29f0200 0x200>,
+              <0x29c0880 0x30>,
+              <0x29cc100 0x534>,
+              <0x2808000 0x24>,
+              <0x2980080 0x8>;
+        reg-names = "ctrl",
+            "xhci_ec",
+            "xhci_gbl",
+            "usb_phy",
+            "usb_mdio";
+        brcm,ioc = <0x0>;
+        brcm,ipp = <0x0>;
+        interrupts = <0x30>;
+        interrupt-parent = <&vpu_intr1_nosec_intc>;
+        interrupt-names = "wake";
+        #phy-cells = <0x1>;
+        brcm,has-xhci;
+        brcm,syscon-piarbctl = <&syscon_piarbctl>;
+        clocks = <&scmi_clk 256>;
+        clock-names = "sw_usb";
+    };
-- 
2.26.2

