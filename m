Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E962B7145
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgKQWIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQWIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:08:16 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C69D2417E;
        Tue, 17 Nov 2020 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605650895;
        bh=R1pOBvGvWekAeZiIx18MTxN73pD71p2KQlMAqkn9JuE=;
        h=From:To:Cc:Subject:Date:From;
        b=jhtwsAIsEnfI7hZFU/Jd+KcXVg/cwpD1Eaqmqn7ug+HpZb+51NK3hV8ALpMzrxtI3
         8g3Gp7cvIynpuZcmoJ6imI3B/VfZBdXlbabFa87Obbq2vPSW7MUUvshqm6y/WkY789
         /SHCnfExLjEIfhjunlFiyA8wc+Dp20iMpkPavic0=
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
Subject: [PATCH 1/4] dt-bindings: hwmon: convert TI INA2xx bindings to dt-schema
Date:   Tue, 17 Nov 2020 23:08:04 +0100
Message-Id: <20201117220807.208747-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the TI INA2xx bindings to dt-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/hwmon/ina2xx.txt      | 24 --------
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml  | 55 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 56 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ina2xx.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
deleted file mode 100644
index 02af0d94e921..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-ina2xx properties
-
-Required properties:
-- compatible: Must be one of the following:
-	- "ti,ina209" for ina209
-	- "ti,ina219" for ina219
-	- "ti,ina220" for ina220
-	- "ti,ina226" for ina226
-	- "ti,ina230" for ina230
-	- "ti,ina231" for ina231
-- reg: I2C address
-
-Optional properties:
-
-- shunt-resistor
-	Shunt resistor value in micro-Ohm
-
-Example:
-
-ina220@44 {
-	compatible = "ti,ina220";
-	reg = <0x44>;
-	shunt-resistor = <1000>;
-};
diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
new file mode 100644
index 000000000000..6f0443322a36
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,ina2xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments INA209 family of power/voltage monitors
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |
+  The INA209 is a high-side current shunt and power monitor with
+  an I2C interface.
+
+  Datasheets:
+    https://www.ti.com/product/INA209
+
+properties:
+  compatible:
+    enum:
+      - ti,ina209
+      - ti,ina219
+      - ti,ina220
+      - ti,ina226
+      - ti,ina230
+      - ti,ina231
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor:
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
+        power-sensor@44 {
+            compatible = "ti,ina220";
+            reg = <0x44>;
+            shunt-resistor = <1000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0818a5b03832..e9ba2e555679 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8669,7 +8669,7 @@ INA209 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/hwmon/ina2xx.txt
+F:	Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
 F:	Documentation/hwmon/ina209.rst
 F:	drivers/hwmon/ina209.c
 
-- 
2.25.1

