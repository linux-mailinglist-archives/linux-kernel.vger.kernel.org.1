Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C022B714D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgKQWIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQWIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:08:21 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA4C2463D;
        Tue, 17 Nov 2020 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605650900;
        bh=yTQmv61AmnAjUoZciHjnR6cwQwL/BN4XCNEwKXM1ROY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uT1WoT+7fd9E/+giaNn9JFWFylLc26DpNUcAaiEieNbxLVW8MCjwfFotPPIijt6zz
         suIc4F2WO87bVa9CuGb4VwL6OuE0UEvZbs1UzWxnb3MqzxWZoxfaBQsRIIhz6KNG85
         sH5R1gNBYIzxwWoSLj7VeG0bda5ALC7wfglLwaow=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/4] dt-bindings: hwmon: convert TI ADS7828 bindings to dt-schema
Date:   Tue, 17 Nov 2020 23:08:06 +0100
Message-Id: <20201117220807.208747-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117220807.208747-1-krzk@kernel.org>
References: <20201117220807.208747-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the TI ADS7828 bindings to dt-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/hwmon/ads7828.txt     | 25 --------
 .../devicetree/bindings/hwmon/ti,ads7828.yaml | 57 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 3 files changed, 57 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
deleted file mode 100644
index fe0cc4ad7ea9..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ads7828.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-ads7828 properties
-
-Required properties:
-- compatible: Should be one of
-	       ti,ads7828
-	       ti,ads7830
-- reg: I2C address
-
-Optional properties:
-
-- ti,differential-input
-  Set to use the device in differential mode.
-- vref-supply
-  The external reference on the device is set to this regulators output. If it
-  does not exists the internal reference will be used and output by the ads78xx
-  on the "external vref" pin.
-
-  Example ADS7828 node:
-
-  ads7828: ads@48 {
-	   comatible = "ti,ads7828";
-	   reg = <0x48>;
-	   vref-supply = <&vref>;
-	   ti,differential-input;
-  };
diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
new file mode 100644
index 000000000000..33ee575bb09d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,ads7828.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS7828/ADS7830 Analog to Digital Converter (ADC)
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |
+  The ADS7828 is 12-Bit, 8-Channel Sampling Analog to Digital Converter (ADC)
+  with an I2C interface.
+
+  Datasheets:
+    https://www.ti.com/product/ADS7828
+
+properties:
+  compatible:
+    enum:
+      - ti,ads7828
+      - ti,ads7830
+
+  reg:
+    maxItems: 1
+
+  ti,differential-input:
+    description:
+      Set to use the device in differential mode.
+    type: boolean
+
+  vref-supply:
+    description:
+      The regulator to use as an external reference. If it does not exists the
+      internal reference will be used.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@48 {
+            comatible = "ti,ads7828";
+            reg = <0x48>;
+            vref-supply = <&vref>;
+            ti,differential-input;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index ab623ba930d5..1b1fa0424539 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -350,10 +350,6 @@ properties:
           - st,24c256
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
-            # 8-Channels, 12-bit ADC
-          - ti,ads7828
-            # 8-Channels, 8-bit ADC
-          - ti,ads7830
             # Temperature Monitoring and Fan Control
           - ti,amc6821
             # Temperature sensor with 2-wire interface
-- 
2.25.1

