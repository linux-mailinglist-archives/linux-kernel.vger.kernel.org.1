Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8262D5A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgLJMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:23:41 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:46512 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgLJMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:23:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 17349123B01;
        Thu, 10 Dec 2020 13:22:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607602948;
        bh=stdRd1Ge1u9OB3/zaOc1WCQ0FTlN9r2WHM/06jMJo8k=;
        h=Date:From:To:Subject:From;
        b=K5cL9Xpmn4q5In4An3pa1zlIAo+o35kI1Fvodu+o1M1MnvZug/Yf8emmew8t9lW5w
         BeWSGYFoYZzoazG/deG1UABmSvcLaYd4/ntbmmQXNEZ+rkSpLNkkp0w5jq1KVEraDq
         RZJ9mIa5+c875Zwfh5ud0z2yY8nHt3dG454QN4rgKkctHyN/pm9NiGIHYcJoeo2i1G
         +NvwQKCipnap7ce6Al+0N8tyYiF2Z/+FG9YP4Kg1X0JyaRbjavpdZE8YJHId5ylb4v
         OsWW2VNHG0sJGXS6biNWYzONoN43hen0+nFM/KEvEwCJG2UyXEkb44bmLQqfEjduHV
         OYBDhLmnqq1jA==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5pHo5vC9icYe; Thu, 10 Dec 2020 13:21:58 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id C0F9E123AFF;
        Thu, 10 Dec 2020 13:21:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607602918;
        bh=stdRd1Ge1u9OB3/zaOc1WCQ0FTlN9r2WHM/06jMJo8k=;
        h=Date:From:To:Subject:From;
        b=U5jhQoeTF29WCd56hwxzIcTs+KhBMWWyKbGeyWzGJavFnSC5p/E6kb/R8kEPGJ38z
         XW7EDuIfzppK/2XC4j5vD20Q/vsAPsY+lFDQRc16fQwTPAoIZj/FKpFPcWIWyNSKM3
         kfELTHGsDktZ13LpG+kKj2JPg+etMZ+YWwS7R7lKIBaCudl+VWf31hbgWX+ko6m/UJ
         K3aT1C5NUbx5A5U5FWBEUvToYcNg5h8q9li0CbC7fjxtUCpzXt1W8pPLQp66WPcF9F
         8wiseSy9/HfgwWVJ/y2sJP9/I9UvGrftEm1lRNDWKvgcEprT461WCNVtlYK/Dg5aTS
         gNPgn4RAuiYDw==
Date:   Thu, 10 Dec 2020 12:21:56 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Rob Herring' <robh+dt@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?'J=F3zsef_Horv=E1th'?= <info@ministro.hu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v1 2/2] Staging: silabs si4455 serial driver: docs device
 tree binding
Message-ID: <20201210122154.GA31799@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add: device tree binding schema

Signed-off-by: József Horváth <info@ministro.hu>
---
 .../bindings/serial/silabs,si4455.yaml        | 53 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml

diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
new file mode 100644
index 000000000000..80a73a61755b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Silicon Labs Si4455 device tree bindings
+
+maintainers:
+  - József Horváth <info@ministro.hu>
+
+allOf:
+  - $ref: "/schemas/serial.yaml#"
+
+properties:
+  compatible:
+    const: silabs,si4455
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency:
+    description: maximum clock frequency on SPI port
+    maximum: 500000
+
+  shutdown-gpios:
+    description: gpio pin for SDN
+    maxItems: 1
+
+required:
+  - reg
+  - interrupts
+  - spi-max-frequency
+  - shutdown-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    &spi0 {
+      serial0: si4455@0 {
+        compatible = "silabs,si4455";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+        shutdown-gpios = <&gpio 26 1>;
+        spi-max-frequency = <300000>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a29bc17d446d..16cc96971ac2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15937,7 +15937,7 @@ F:	drivers/platform/x86/touchscreen_dmi.c
 SILICON LABS SI4455 SERIAL DRIVER
 M:	József Horváth <info@ministro.hu>
 S:	Maintained
-F:	Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt
+F:	Documentation/devicetree/bindings/serial/silabs,si4455.yaml
 F:	drivers/tty/serial/si4455.c
 F:	drivers/tty/serial/si4455_api.h
 
-- 
2.17.1

