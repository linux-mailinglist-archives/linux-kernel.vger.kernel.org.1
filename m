Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF402DC0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgLPNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLPNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:15:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F14C061794;
        Wed, 16 Dec 2020 05:15:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h205so4693133lfd.5;
        Wed, 16 Dec 2020 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4jmJAOQCco9M3h+AoC7gWzpQon/ZawA/8oWPNkEngQ=;
        b=Lltyb3OHjMrMpnH10EYmim6elXWeyvj8x9zcvRANz9icPbJXkV+b4lOIamqJkOwBIm
         FzGh2upBIT+V/nvfqRvYRktB3QlYCE6qzZ9mHQC39c4rEJZnIswU++WWdMtXiWGtJQn8
         ShGQ8gr3XEJeqd7WBqWAiQTxTZzt2pMFghIcKM0iD70My9fMsbXOl6W+GtUoL6miNEqG
         QILc2Z8MNITPc8Aep8AOAyQjpAlQDuqS6qS9AL/3E2lrb56bJcwXq71tIr5aoKvB5uU4
         jj+d/ULpF7809ihtOOe6nUVmCLNAJ11Cguf0XRC+BP0nLKWxKc5w51I3NX27AuVfBw0A
         VexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4jmJAOQCco9M3h+AoC7gWzpQon/ZawA/8oWPNkEngQ=;
        b=CnPrv6MLPLIz+jlIEzy3MhaHu/kL69iN+RCGefj910VyGaDSmSijTUm5t20wJGww1R
         04apT/3V0UcBwvmPqkNp/Qk8G8xZV5ZMajrtT0xU66+i0UElhak45EsOOeb52vYw7F5c
         ByLmb1gUEmflJr2zADG4hybI4cO2L6diMiFJE8maLZNeZzTF5QjUmM8dcop+pTyJxO7H
         inHrrVkS2lxbeLGixrjdb22SR3BZGIBLh6h+t0xUDrHw6A2gWOsBeOQuk6hnrp3CPmzr
         2rtZNbtHCXSUt73CUI1xWRWYDXFLdch3xAYe5Vo/KoNxW0vtLfYzXxqQ0jSOfalhiPPT
         tYwg==
X-Gm-Message-State: AOAM533ZZ1WSNBM1c/uZcrmlkNGmmrKrA4d7NZa2v129S7gCoF5wAOI7
        Lk1IRQDmu+0KuWN8Eq/ll9E=
X-Google-Smtp-Source: ABdhPJzgyJLvHAuEw7IesmqyD7qLJYq81K+f61mn2CQBC/BmGuvLZh9k7sajC31iMlc5jotpXjwFJA==
X-Received: by 2002:a2e:b047:: with SMTP id d7mr9621904ljl.467.1608124500712;
        Wed, 16 Dec 2020 05:15:00 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n84sm220899lfd.176.2020.12.16.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 05:15:00 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] dt-bindings: phy: brcm,brcmstb-usb-phy: convert to the json-schema
Date:   Wed, 16 Dec 2020 14:14:49 +0100
Message-Id: <20201216131451.16900-1-zajec5@gmail.com>
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
   were integers and Linux driver checks for int as well.
   I made both uint32 but that probably should be refactored later.
3. Added minimal description

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  86 --------
 .../bindings/phy/brcm,brcmstb-usb-phy.yaml    | 195 ++++++++++++++++++
 2 files changed, 195 insertions(+), 86 deletions(-)
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
index 000000000000..34664bdfa4be
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
@@ -0,0 +1,195 @@
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
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm7211-usb-phy
+      - brcm,bcm7216-usb-phy
+      - brcm,brcmstb-usb-phy
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
+          items:
+            - description: the base CTRL register
+            - description: XHCI EC register
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
+          items:
+            - description: the base CTRL register
+            - description: XHCI EC register
+            - description: XHCI GBL register
+            - description: USB PHY register
+            - description: USB MDIO register
+            - description: BDC register
+        reg-names:
+          minItems: 5
+          maxItems: 6
+          items:
+            - const: ctrl
+            - const: xhci_ec
+            - const: xhci_gbl
+            - const: usb_phy
+            - const: usb_mdio
+            - const: bdc_ec
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
+          items:
+            - description: the base CTRL register
+            - description: XHCI EC register
+            - description: XHCI GBL register
+        reg-names:
+          minItems: 3
+          maxItems: 3
+          items:
+            - const: ctrl
+            - const: xhci_ec
+            - const: xhci_gbl
+
+additionalProperties: true
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
+        syscon-piarbctl = <&syscon_piarbctl>;
+        clocks = <&scmi_clk 256>;
+        clock-names = "sw_usb";
+    };
-- 
2.26.2

