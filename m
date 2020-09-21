Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAB2728E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgIUOsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgIUOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:20 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CEEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 2559223F015;
        Mon, 21 Sep 2020 16:48:19 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.993
X-Spam-Level: 
X-Spam-Status: No, score=-2.993 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.093, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m3ZF75OxiVet; Mon, 21 Sep 2020 16:48:17 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 3B14823EFE2;
        Mon, 21 Sep 2020 16:48:16 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Rob Herring <robh+dt@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Palmer <daniel@0x0f.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 32/32] auxdisplay: lcd2s DT binding doc
Date:   Mon, 21 Sep 2020 16:46:44 +0200
Message-Id: <20200921144645.2061313-33-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921144645.2061313-1-poeschel@lemonage.de>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Add a binding doc for the modtronix lcd2s auxdisplay driver. It also
adds modtronix to the list of known vendor-prefixes.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
--
Changes in v2:
- Adopted yaml based file format
---
 .../bindings/auxdisplay/modtronix,lcd2s.yaml  | 55 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml b/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
new file mode 100644
index 000000000000..9a70e28d2e61
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/modtronix,lcd2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Modtronix engineering LCD2S Character LCD Display
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
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab03521..a9dd168db6ce 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -667,6 +667,8 @@ patternProperties:
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

