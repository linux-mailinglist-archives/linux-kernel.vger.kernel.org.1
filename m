Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4232629E82C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgJ2KCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgJ2KCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:02:09 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A177C0613CF;
        Thu, 29 Oct 2020 03:02:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id EBACC23FAD6;
        Thu, 29 Oct 2020 11:02:07 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.971
X-Spam-Level: 
X-Spam-Status: No, score=-2.971 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.071, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cXRXHlHf3Bm9; Thu, 29 Oct 2020 11:02:06 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id A765D23F4B8;
        Thu, 29 Oct 2020 11:02:04 +0100 (CET)
From:   poeschel@lemonage.de
To:     Rob Herring <robh+dt@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Lars Poeschel <poeschel@lemonage.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v5 24/25] auxdisplay: lcd2s DT binding doc
Date:   Thu, 29 Oct 2020 11:01:31 +0100
Message-Id: <20201029100139.311853-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029095231.311083-1-poeschel@lemonage.de>
References: <20201029095231.311083-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Add a binding doc for the modtronix lcd2s auxdisplay driver. It also
adds modtronix to the list of known vendor-prefixes.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v5:
- Picked up Robs Reviewed-by
Changes in v3:
- Fixed make dt_binding_doc errors
Changes in v2:
- Adopted yaml based file format
---
 .../bindings/auxdisplay/modtronix,lcd2s.yaml  | 58 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml b/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
new file mode 100644
index 000000000000..a1d55a2634a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/modtronix,lcd2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Modtronix engineering LCD2S Character LCD Display
+
+maintainers:
+  - Lars Poeschel <poeschel@lemonage.de>
+
+description:
+  The LCD2S is a Character LCD Display manufactured by Modtronix Engineering.
+  The display supports a serial I2C and SPI interface. The driver currently
+  only supports the I2C interface.
+
+properties:
+  compatible:
+    const: modtronix,lcd2s
+
+  reg:
+    maxItems: 1
+    description:
+      I2C bus address of the display.
+
+  display-height-chars:
+    description: Height of the display, in character cells.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+
+  display-width-chars:
+    description: Width of the display, in character cells.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 16
+    maximum: 20
+
+required:
+  - compatible
+  - reg
+  - display-height-chars
+  - display-width-chars
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      lcd2s: auxdisplay@28 {
+        compatible = "modtronix,lcd2s";
+        reg = <0x28>;
+        display-height-chars = <4>;
+        display-width-chars = <20>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8470..65f40ab5a87f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -681,6 +681,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^modtronix,.*":
+    description: Modtronix Engineering
   "^mosaixtech,.*":
     description: Mosaix Technologies, Inc.
   "^motorola,.*":
-- 
2.28.0

