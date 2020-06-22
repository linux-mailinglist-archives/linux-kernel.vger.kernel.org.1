Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2135203650
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgFVMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 08:02:13 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:58701 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgFVMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:02:11 -0400
X-Greylist: delayed 729 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jun 2020 08:02:10 EDT
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05MC0mJU031409;
        Mon, 22 Jun 2020 21:00:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05MC0mJU031409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592827249;
        bh=eg9cS/iFCnkIuPhMhc6OKqBZdWFocu0SvTBatQL6K2w=;
        h=From:To:Cc:Subject:Date:From;
        b=cY9JURAWYJCcDpn5iJg7WHds4bmraJRN/tkBHgBGZqeLL+SkQxaooE6WJrzfAZKCv
         IO9uEd+I7TMg7rAbSrTRfDt2IhW8ZHKTqIIV8YNaaekSUt4ThlE0jqFyRojcfMjuPs
         P1aAzK6TuBw4C7ybGfVXh1dX2vtEemRq7wTBjo9S/viYGCUF68t+FgAbnUKCXf+W2u
         ZXOPk+L41yoOvWckMKSAhsob324NKewwglQby1BKLNHraHatLmHwXMTH4QQYSoaie9
         vcu3wQz6992wDnXWWpOKheSzZ6D2pv3Kf3AJ/wJF334SEbJkaTOUjFO/IF6px+fmaQ
         2mtl9CRpHCpBA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        - <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ASoC: Convert UniPhier AIO audio system to json-schema
Date:   Mon, 22 Jun 2020 21:00:39 +0900
Message-Id: <20200622120039.453616-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier AIO audio system binding to DT schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../sound/socionext,uniphier-aio.yaml         | 73 +++++++++++++++++++
 .../bindings/sound/uniphier,aio.txt           | 45 ------------
 2 files changed, 73 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt

diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
new file mode 100644
index 000000000000..bea8b06ff1b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/socionext,uniphier-aio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier AIO audio system
+
+maintainers:
+  - <alsa-devel@alsa-project.org>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-ld11-aio
+      - socionext,uniphier-ld20-aio
+      - socionext,uniphier-pxs2-aio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    const: aio
+
+  clocks:
+    maxItems: 1
+
+  reset-names:
+    const: aio
+
+  resets:
+    maxItems: 1
+
+  socionext,syscon:
+    description: |
+      Specifies a phandle to soc-glue, which is used for changing mode of S/PDIF
+      signal pin to output from Hi-Z. This property is optional if you use I2S
+      signal pins only.
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+  "#sound-dai-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+  - reset-names
+  - resets
+  - "#sound-dai-cells"
+
+examples:
+  - |
+    audio@56000000 {
+        compatible = "socionext,uniphier-ld20-aio";
+        reg = <0x56000000 0x80000>;
+        interrupts = <0 144 4>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_aout>;
+        clock-names = "aio";
+        clocks = <&sys_clk 40>;
+        reset-names = "aio";
+        resets = <&sys_rst 40>;
+        #sound-dai-cells = <1>;
+        socionext,syscon = <&soc_glue>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/uniphier,aio.txt b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
deleted file mode 100644
index 4ce68ed6f2f2..000000000000
--- a/Documentation/devicetree/bindings/sound/uniphier,aio.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Socionext UniPhier SoC audio driver
-
-The Socionext UniPhier audio subsystem consists of I2S and S/PDIF blocks in
-the same register space.
-
-Required properties:
-- compatible      : should be one of the following:
-		    "socionext,uniphier-ld11-aio"
-		    "socionext,uniphier-ld20-aio"
-		    "socionext,uniphier-pxs2-aio"
-- reg             : offset and length of the register set for the device.
-- interrupts      : should contain I2S or S/PDIF interrupt.
-- pinctrl-names   : should be "default".
-- pinctrl-0       : defined I2S signal pins for an external codec chip.
-- clock-names     : should include following entries:
-                    "aio"
-- clocks          : a list of phandle, should contain an entry for each
-                    entry in clock-names.
-- reset-names     : should include following entries:
-                    "aio"
-- resets          : a list of phandle, should contain an entry for each
-                    entry in reset-names.
-- #sound-dai-cells: should be 1.
-
-Optional properties:
-- socionext,syscon: a phandle, should contain soc-glue.
-                    The soc-glue is used for changing mode of S/PDIF signal pin
-                    to Output from Hi-Z. This property is optional if you use
-                    I2S signal pins only.
-
-Example:
-	audio {
-		compatible = "socionext,uniphier-ld20-aio";
-		reg = <0x56000000 0x80000>;
-		interrupts = <0 144 4>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_aout>;
-		clock-names = "aio";
-		clocks = <&sys_clk 40>;
-		reset-names = "aio";
-		resets = <&sys_rst 40>;
-		#sound-dai-cells = <1>;
-
-		socionext,syscon = <&sg>;
-	};
-- 
2.25.1

