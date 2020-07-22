Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B73229EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgGVSH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 14:07:56 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:12738 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:07:55 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06MI7ePS038841;
        Thu, 23 Jul 2020 03:07:40 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Thu, 23 Jul 2020 03:07:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06MI7bJZ038819
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 23 Jul 2020 03:07:40 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] dt-bindings: sound: convert Everest ES8316 binding to yaml
Date:   Thu, 23 Jul 2020 03:07:28 +0900
Message-Id: <20200722180728.993812-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts Everest Semiconductor ES8316 low power audio
CODEC binding to DT schema.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../bindings/sound/everest,es8316.txt         | 23 ---------
 .../bindings/sound/everest,es8316.yaml        | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.yaml

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
deleted file mode 100644
index 1bf03c5f2af4..000000000000
--- a/Documentation/devicetree/bindings/sound/everest,es8316.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Everest ES8316 audio CODEC
-
-This device supports both I2C and SPI.
-
-Required properties:
-
-  - compatible  : should be "everest,es8316"
-  - reg : the I2C address of the device for I2C
-
-Optional properties:
-
-  - clocks : a list of phandle, should contain entries for clock-names
-  - clock-names : should include as follows:
-         "mclk" : master clock (MCLK) of the device
-
-Example:
-
-es8316: codec@11 {
-	compatible = "everest,es8316";
-	reg = <0x11>;
-	clocks = <&clks 10>;
-	clock-names = "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
new file mode 100644
index 000000000000..b713404dac4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Everest ES8316 audio CODEC
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: everest,es8316
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for master clock (MCLK)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      es8316: codec@11 {
+        compatible = "everest,es8316";
+        reg = <0x11>;
+        clocks = <&clks 10>;
+        clock-names = "mclk";
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.27.0

