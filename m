Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4935A2B7149
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgKQWIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQWIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:08:18 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A0C2463B;
        Tue, 17 Nov 2020 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605650897;
        bh=JOZkuiu9GUDMmzBxJ8dLr8lnFOVINfPlnEmDixPOTcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHuCO4jFfG5ySyxB8MOlllDJDXXE3usIsNMl/UqypODE6r6mXC+UpL5plzU/2S4HN
         Y0MIm6KH7jtRrLk1PEP1mnufH0apzSBmrJOwj/l6/nT/4+TTe3ywJtLCF8THXoAVwU
         TRG7nym7auagp0Dby8MrOZSwYbPQ+zkf2/rp1sHk=
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
Subject: [PATCH 2/4] dt-bindings: hwmon: convert AD AD741x bindings to dt-schema
Date:   Tue, 17 Nov 2020 23:08:05 +0100
Message-Id: <20201117220807.208747-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117220807.208747-1-krzk@kernel.org>
References: <20201117220807.208747-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Analog Devices AD741x bindings to dt-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/hwmon/ad741x.txt      | 15 -------
 .../devicetree/bindings/hwmon/adi,ad741x.yaml | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ad741x.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ad741x.txt b/Documentation/devicetree/bindings/hwmon/ad741x.txt
deleted file mode 100644
index 9102152c8410..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ad741x.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* AD7416/AD7417/AD7418 Temperature Sensor Device Tree Bindings
-
-Required properties:
-- compatible: one of
-		"adi,ad7416"
-		"adi,ad7417"
-		"adi,ad7418"
-- reg: I2C address
-
-Example:
-
-hwmon@28 {
-	compatible = "adi,ad7418";
-	reg = <0x28>;
-};
diff --git a/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml b/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
new file mode 100644
index 000000000000..ce7f8ce9da0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/adi,ad741x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7416/AD7417/AD7418 temperature sensors
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7416
+      - adi,ad7417
+      - adi,ad7418
+
+  reg:
+    maxItems: 1
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
+        temperature-sensor@28 {
+            compatible = "adi,ad7418";
+            reg = <0x28>;
+        };
+    };
-- 
2.25.1

