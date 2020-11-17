Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F802B7150
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKQWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728952AbgKQWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:08:23 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D396124248;
        Tue, 17 Nov 2020 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605650902;
        bh=vw3o+FkpU4mvDT8gAc0jS/pGzbrqAbpHEsPcEKhuvwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N58ihijMmGHGdfJdUMPWxF3d0osByRjkYLzh++Va7mxmywVeBBmvK5RErfsEJOPaQ
         rvgUFvpK4mgULdp2k9nJ8kj8mcmk2La3L0rz7fjhPz2aaAfT8cqCom3PzphCkJ5fTE
         lIDFWhXFE5KHH246i/fiyCrOJbHTsg+eHadWoqiI=
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
Subject: [PATCH 4/4] dt-bindings: hwmon: convert AD ADM1275 bindings to dt-schema
Date:   Tue, 17 Nov 2020 23:08:07 +0100
Message-Id: <20201117220807.208747-4-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117220807.208747-1-krzk@kernel.org>
References: <20201117220807.208747-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Analog Devices ADM1275 bindings to dt-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/hwmon/adi,adm1275.yaml           | 58 +++++++++++++++++++
 .../devicetree/bindings/hwmon/adm1275.txt     | 25 --------
 Documentation/hwmon/adm1275.rst               |  2 +-
 3 files changed, 59 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
new file mode 100644
index 000000000000..2cad28c499dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/adi,adm1275.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADM1075/ADM127x/ADM129x digital power monitors
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |
+  The ADM1293 and ADM1294 are high accuracy integrated digital power monitors
+  that offer digital current, voltage, and power monitoring using an on-chip,
+  12-bit analog-to-digital converter (ADC), communicated through a PMBus
+  compliant I2C interface.
+
+  Datasheets:
+    https://www.analog.com/en/products/adm1294.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adm1075
+      - adi,adm1272
+      - adi,adm1275
+      - adi,adm1276
+      - adi,adm1278
+      - adi,adm1293
+      - adi,adm1294
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Shunt resistor value in micro-Ohm.
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+        power-sensor@10 {
+            compatible = "adi,adm1272";
+            reg = <0x10>;
+            shunt-resistor-micro-ohms = <500>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
deleted file mode 100644
index 1ecd03f3da4d..000000000000
--- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-adm1275 properties
-
-Required properties:
-- compatible: Must be one of the supported compatible strings:
-	- "adi,adm1075" for adm1075
-	- "adi,adm1272" for adm1272
-	- "adi,adm1275" for adm1275
-	- "adi,adm1276" for adm1276
-	- "adi,adm1278" for adm1278
-	- "adi,adm1293" for adm1293
-	- "adi,adm1294" for adm1294
-- reg: I2C address
-
-Optional properties:
-
-- shunt-resistor-micro-ohms
-	Shunt resistor value in micro-Ohm
-
-Example:
-
-adm1272@10 {
-	compatible = "adi,adm1272";
-	reg = <0x10>;
-	shunt-resistor-micro-ohms = <500>;
-};
diff --git a/Documentation/hwmon/adm1275.rst b/Documentation/hwmon/adm1275.rst
index ce6528f90e4a..804590eeabdc 100644
--- a/Documentation/hwmon/adm1275.rst
+++ b/Documentation/hwmon/adm1275.rst
@@ -83,7 +83,7 @@ or current scaling. Reported voltages, currents, and power are raw measurements,
 and will typically have to be scaled.
 
 The shunt value in micro-ohms can be set via device tree at compile-time. Please
-refer to the Documentation/devicetree/bindings/hwmon/adm1275.txt for bindings
+refer to the Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml for bindings
 if the device tree is used.
 
 Platform data support
-- 
2.25.1

