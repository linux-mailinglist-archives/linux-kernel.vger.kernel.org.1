Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49B242D37
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHLQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485AF2076B;
        Wed, 12 Aug 2020 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249805;
        bh=KNHjhQzMcYdz2g5TSJ6MQ1LSesLYWtv8i1t9BPqnPoU=;
        h=From:To:Subject:Date:From;
        b=Evl+c2GBbQy/asVPy2CAJqy9HfXs8u8ue1EDDHfkHq+7zYrfKBbTRfeHO9xa588kS
         YcqzyvEAeBg+ldqK/GiFh673DhoeCv92e/ztWxSWcQ+7zLLBXC8mUR+lOB7Dazsx5D
         Z3GEeKExZ8bNvahBQXRYtQAqAO36PZGscKb04qbI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 01/11] dt-bindings: extcon: ptn5150: Convert binding to DT schema
Date:   Wed, 12 Aug 2020 18:29:48 +0200
Message-Id: <20200812162958.6180-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ptn-5150 extcon driver bindings to DT schema format using
json-schema.  The differences with original bindings document:
 - Use "gpios" suffix for the "int" and "vbus" gpio,
 - Skip generic properties like "reg" or "pinctrl".

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/extcon/extcon-ptn5150.txt        | 27 ----------
 .../bindings/extcon/extcon-ptn5150.yaml       | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
deleted file mode 100644
index 936fbdf12815..000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* PTN5150 CC (Configuration Channel) Logic device
-
-PTN5150 is a small thin low power CC logic chip supporting the USB Type-C
-connector application with CC control logic detection and indication functions.
-It is interfaced to the host controller using an I2C interface.
-
-Required properties:
-- compatible: should be "nxp,ptn5150"
-- reg: specifies the I2C slave address of the device
-- int-gpio: should contain a phandle and GPIO specifier for the GPIO pin
-	connected to the PTN5150's INTB pin.
-- vbus-gpio: should contain a phandle and GPIO specifier for the GPIO pin which
-	is used to control VBUS.
-- pinctrl-names : a pinctrl state named "default" must be defined.
-- pinctrl-0 : phandle referencing pin configuration of interrupt and vbus
-	control.
-
-Example:
-	ptn5150@1d {
-		compatible = "nxp,ptn5150";
-		reg = <0x1d>;
-		int-gpio = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
-		vbus-gpio = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ptn5150_default>;
-		status = "okay";
-	};
diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
new file mode 100644
index 000000000000..f6316f12028b
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PTN5150 CC (Configuration Channel) Logic device
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |
+  PTN5150 is a small thin low power CC logic chip supporting the USB Type-C
+  connector application with CC control logic detection and indication
+  functions.  It is interfaced to the host controller using an I2C interface.
+
+properties:
+  compatible:
+    const: nxp,ptn5150
+
+  int-gpios:
+    description:
+      GPIO pin (input) connected to the PTN5150's INTB pin.
+
+  reg:
+    maxItems: 1
+
+  vbus-gpios:
+    description:
+      GPIO pin (output) used to control VBUS.
+
+required:
+  - compatible
+  - int-gpios
+  - reg
+  - vbus-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ptn5150@1d {
+            compatible = "nxp,ptn5150";
+            reg = <0x1d>;
+            int-gpios = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
+            vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.17.1

