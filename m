Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18C82ECED1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbhAGLgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:36:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40314 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610019411; x=1641555411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JWeO86KOE7jMgZEGKA5JBjsUu3gtOMWih93HdRaA6Hc=;
  b=GNsmPVeTgXuViuOYsybwn7pX1ce2rVqBE3Nof/UWGygxknvOEh3s9uf1
   iu3Z4rNK/kkfiP3huDMEFCD8wk1MruEx9lU0gnpdncnIxHjhyEPDLzsi5
   mDT7d/DBTHZjTaN07HmGizjWxmLA91ELL7bh5ELYT3j6tQMPJJN+hvdzw
   wg0LKgEJmQFpGRHBWQFdJW0k4UVDeKpzjDRR6JmwB702mBKz1WCQajFyO
   +LMYJEFP01EK5Y0jiL1h+/dFIRJGO9hi2EHPtH1cM9qypf5eQIPZRTc7e
   giHyxBKLprQHztw6HOeFo/pD0umofK8cGaeOEeOKQvk3QFO9zZ7Ue+84R
   A==;
IronPort-SDR: PN5wXTbQNo+G6edafOmWDnQommQ66EMn/7dplmXbGSg867WCx4IMDxdWrTy7hc+XZsKNFa/ok1
 4zlcjMcXQCujvU5gFrg0P9+BkaIkwUukKt2e6FiTEiuFsm/ARBouEJDwAdI2nNvuMdVdxgXqAJ
 6P3wO8Me9cA9hrHEbC7Uwkuvoq7RIoIXlLvJRtQ52iVIFCf7q7I3/Whh9w4ErxWlkwebUMGWoD
 NuxtHGbGYcpo+zdvBZnN9iMo3yeC7ac2pJzN0vLmc7Ela44vKR6zBRdo9y6Tnj88yeZot9M+lS
 M3Q=
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="110122993"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2021 04:35:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 04:35:35 -0700
Received: from daniela.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 7 Jan 2021 04:35:33 -0700
From:   <daire.mcnamara@microchip.com>
To:     <cyril.jean@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.linux.org>,
        <padmarao.begari@microchip.com>, <Atish.Patra@wdc.com>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <palmer@dabbelt.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: clk: microchip: Add Microchip PolarFire host binding
Date:   Thu, 7 Jan 2021 11:34:59 +0000
Message-ID: <20210107113500.15642-2-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107113500.15642-1-daire.mcnamara@microchip.com>
References: <20210107113500.15642-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Add device tree bindings for the Microchip PolarFire system
clock controller

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 .../bindings/clock/microchip,mpfs.yaml        | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
new file mode 100644
index 000000000000..a4756480a8ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/microchip,mpfs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire Clock Control Module Binding
+
+maintainers:
+  - Daire McNamara <daire.mcnamara@microchip.com>
+
+description: |
+  Microchip PolarFire clock control (CLKCFG) is an integrated clock controller,
+  which gates and enables all peripheral clocks.
+
+  This device tree binding describes 32 gate clocks.  Clocks are referenced by
+  user nodes by the CLKCFG node phandle and the clock index in the group, from
+  0 to 31.
+
+properties:
+  compatible:
+    const: microchip,mpfs-clkcfg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description: |
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/microchip,mpfs-clock.h
+      for the full list of PolarFire clock IDs.
+
+  clock-output-names:
+    maxItems: 32
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - clock-output-names
+
+additionalProperties: false
+
+examples:
+  # Clock Config node:
+  - |
+    #include <dt-bindings/clock/microchip,mpfs-clock.h>
+    soc {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ref: refclk {
+                compatible = "fixed-clock";
+                #clock-cells = <0>;
+                clock-frequency = <600000000>;
+                clock-output-names = "msspllclk";
+            };
+            clkcfg: clock-controller@20002000 {
+                compatible = "microchip,mpfs-clkcfg";
+                reg = <0x0 0x20002000 0x0 0x1000>;
+                clocks = <&ref>;
+                #clock-cells = <1>;
+                clock-output-names = "cpu", "axi", "ahb", "envm", "mac0", "mac1", "mmc", "timer",
+                                     "mmuart0", "mmuart1", "mmuart2", "mmuart3", "mmuart4",
+                                     "spi0", "spi1", "i2c0", "i2c1", "can0", "can1", "usb", "rtc",
+                                     "qspi", "gpio0", "gpio1", "gpio2", "ddrc",
+                                     "fic0", "fic1", "fic2", "fic3", "athena", "cfm";
+        };
+    };
-- 
2.25.1

