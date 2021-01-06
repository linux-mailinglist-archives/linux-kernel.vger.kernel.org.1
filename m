Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC552EBD44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAFLkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:40:14 -0500
Received: from tux.runtux.com ([176.9.82.136]:56838 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAFLkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:40:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id C36A66EFD2;
        Wed,  6 Jan 2021 12:39:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ztHTl1_m2aKa; Wed,  6 Jan 2021 12:39:30 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id C9C376EF93;
        Wed,  6 Jan 2021 12:39:29 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 5BB5346C; Wed,  6 Jan 2021 12:39:29 +0100 (CET)
Date:   Wed, 6 Jan 2021 12:39:29 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
Message-ID: <20210106113929.fizyg6fcsmsntkiy@runtux.com>
References: <20210106113730.k5qveshjgcd57kgx@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106113730.k5qveshjgcd57kgx@runtux.com>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hd44780 displays are often used with pcf8574 based I/O expanders.
Add example to documentation.

Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
---
 .../bindings/auxdisplay/hit,hd44780.yaml      | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
index 9222b06e93a0..0ec2ce7b1df1 100644
--- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
@@ -12,7 +12,10 @@ maintainers:
 description:
   The Hitachi HD44780 Character LCD Controller is commonly used on character
   LCDs that can display one or more lines of text. It exposes an M6800 bus
-  interface, which can be used in either 4-bit or 8-bit mode.
+  interface, which can be used in either 4-bit or 8-bit mode. By using a
+  GPIO expander it is possible to use the driver with one of the popular I2C
+  expander boards based on the PCF8574 available for these displays. For
+  an example see below.
 
 properties:
   compatible:
@@ -94,3 +97,29 @@ examples:
             display-height-chars = <2>;
             display-width-chars = <16>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c@2000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            pcf8574: pcf8574@27 {
+                    compatible = "nxp,pcf8574";
+                    reg = <0x27>;
+                    gpio-controller;
+                    #gpio-cells = <2>;
+            };
+    };
+    hd44780 {
+            compatible = "hit,hd44780";
+            display-height-chars = <2>;
+            display-width-chars  = <16>;
+            data-gpios = <&pcf8574 4 0>,
+                         <&pcf8574 5 0>,
+                         <&pcf8574 6 0>,
+                         <&pcf8574 7 0>;
+            enable-gpios = <&pcf8574 2 0>;
+            rs-gpios = <&pcf8574 0 0>;
+            rw-gpios = <&pcf8574 1 0>;
+            backlight-gpios = <&pcf8574 3 0>;
+    };
-- 
2.20.1
