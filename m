Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C525D2EAE0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbhAEPQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:16:11 -0500
Received: from tux.runtux.com ([176.9.82.136]:59868 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAEPQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:16:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 8FEE06F0C9;
        Tue,  5 Jan 2021 16:05:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id skaEZqaFV1wo; Tue,  5 Jan 2021 16:05:18 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 844C96EF52;
        Tue,  5 Jan 2021 16:05:18 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 369AF473; Tue,  5 Jan 2021 16:05:18 +0100 (CET)
Date:   Tue, 5 Jan 2021 16:05:18 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] auxdisplay: devicetree doc for HD44780/PCF8574
Message-ID: <20210105150518.euxpkga3viadr3r6@runtux.com>
References: <20210105150124.dvlochv3qrp4wpre@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105150124.dvlochv3qrp4wpre@runtux.com>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree documentation with example.

Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
---
 .../auxdisplay/hit,hd44780+nxp,pcf8575.yaml   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/hit,hd44780+nxp,pcf8575.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780+nxp,pcf8575.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780+nxp,pcf8575.yaml
new file mode 100644
index 000000000000..c8e822c43b10
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780+nxp,pcf8575.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/hit,hd44780+nxp,pcf8575.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hitachi HD44780 Character LCD Controller attached to I2C via PCF8575
+
+maintainers:
+  - Ralf Schlatterbeck <rsc@runtux.com>
+
+description:
+  The Hitachi HD44780 Character LCD Controller is commonly used on character
+  LCDs that can display one or more lines of text. The display itself
+  exposes a parallel connection but they're often used with a PCF8575
+  I/O expander to connect them to an I2C bus.
+
+properties:
+  compatible:
+    const: hit,hd44780+nxp,pcf8575
+
+  reg:
+    description: I2C-bus address
+    maxItems: 1
+
+  display-height-chars:
+    description: Height of the display, in character cells,
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+
+  display-width-chars:
+    description: Width of the display, in character cells.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 64
+
+  internal-buffer-width:
+    description:
+      Internal buffer width (default is 40 for displays with 1 or 2 lines, and
+      display-width-chars for displays with more than 2 lines).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 64
+
+required:
+  - compatible
+  - display-height-chars
+  - display-width-chars
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c@2000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      auxdisplay: hd44780@27 {
+        compatible = "hit,hd44780+nxp,pcf8575";
+        reg = <0x27>;
+        display-height-chars = <2>;
+        display-width-chars = <16>;
+      };
+    };
-- 
2.20.1
