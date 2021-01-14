Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C20B2F5D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbhANJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:26:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5049 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbhANJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610616393; x=1642152393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7dbWcybAcPSCs9JfAgrdc5kMVgaiF/4Xqgv+SIR8YsI=;
  b=iG4dTsBmPR0B4DfvQNvk8mn+k0lc15iZ5fcSLI7Go4IqD3BaWk4RvSPF
   zwlexBOv6+g+Y6shBtcD/9REuS6L031hAs+hwo5N4GcO7NF3Dgq9kIOnL
   10QjPqv6KxHHSsHhi9GqgU2QkpzWNQ7xHfICVnBvhWzTVMcvA1ixnRJAT
   ZhJTeeSv/VquXxl73+VVWbQiXN7Zq+Q9ULqbQcKAXEZBWa+GB5p0nQWPS
   o92hxn5DsEVc1uRuLpNZCpNWHSxFKLqK+qZlswGQOPBOX/AdErQOD67UF
   yYk3FJWve/tZALz0wgCYL7K+ikUDiLNzG+7CnRui9jANypfy/BAGMg1KK
   A==;
IronPort-SDR: +4PmEIyCXSXkPIYvcokK5cNc4LN9N2AWBldNkhpXcJz/iCE31hYerYLcAsv8hYX4gI3c3Mmocq
 sgug9f7Z3vyTEITdY70AmWv/hSJibC0R4l6MJRznJJ0zCOQihhx5lnUTADftZ4Wg6z8V+2GaQp
 p0I2fT0t36vZ91QsQRG1hX21YqKovKjtyhYQIltCrX9/u69iQENd0qutTrazlbHXiRXzAvf8YS
 d+mprQ4/o5M8RzKWScYkHLpMMwTyMlWsXREi7nCipVzJSzAUGKPj6PMX2ZCl6AAbb9VkYp1Y1Q
 6PU=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="105407067"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 02:25:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 02:25:15 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 02:25:13 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Thu, 14 Jan 2021 10:24:58 +0100
Message-ID: <20210114092500.2822208-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114092500.2822208-1-steen.hegelund@microchip.com>
References: <20210114092500.2822208-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 .../bindings/reset/microchip,rst.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
new file mode 100644
index 000000000000..b5526753e85d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microchip Sparx5 Switch Reset Controller
+
+maintainers:
+  - Steen Hegelund <steen.hegelund@microchip.com>
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+description: |
+  The Microchip Sparx5 Switch provides reset control and implements the following
+  functions
+    - One Time Switch Core Reset (Soft Reset)
+
+properties:
+  $nodename:
+    pattern: "^reset-controller@[0-9a-f]+$"
+
+  compatible:
+    const: microchip,sparx5-switch-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+  syscons:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: Array of syscons used to access reset registers
+    minItems: 2
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+  - syscons
+
+additionalProperties: false
+
+examples:
+  - |
+    reset: reset-controller@0 {
+        compatible = "microchip,sparx5-switch-reset";
+        reg = <0x0 0x0>;
+        #reset-cells = <1>;
+        syscons = <&cpu_ctrl>,<&gcb_ctrl>;
+    };
+
-- 
2.29.2

