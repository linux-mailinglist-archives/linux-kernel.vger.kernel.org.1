Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4F2FCCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbhATIW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:22:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:4817 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbhATIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611130847; x=1642666847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lIVXiYfF1ZAAiHw/fch8Q+/D+WuN/BFANz4ZM0AO5Ic=;
  b=amWeTR2L0su++ZX0kqRPeO/1M7Uex35WwpOln9NhhQrhzaCRNxcZdZet
   MjCV+pJ72Vy8JW5IjMd5mTABH1dzJtksFfyTLv5IoRWjoIlvbwuxUiaKP
   D+v3mlnUXKdYRjasRD7Nso5eU1aq2hl9uBBBM1oVgL/z3iZJN+mc/tt8s
   MW4bKm+nFOoIVN1ReucwC1Bk4Ga3D+1HqL71Nxr/TpYS6/HDK064GP2TL
   aHgAxIZWnREvl99DYG1tdOBcoAF9S3iezvK/4UbXPY11Z08JF051h0hli
   cGg/OpZWEXR/mivcD3N3qX8AXUecJswFxad2OJDdAOH4cVbkK3vmZaFz9
   g==;
IronPort-SDR: 4403iNUNK90EPytwP7Ki8SipcpnhxEWZCrnV6NwVvXU1EzrUeJxL71pvv4Ace2hcibU3E5BmH2
 7vCsJM4u9HKHEwPxr8qiMb83roTrdOejVpZYMUtKoBXLZ8+dxOHPxQfLOEtwh3a2zAXgJIPDe2
 1an5i47RbAQ1Dr0lsswN0KeqKt6XrKFfVQQDkk7PLjxKqJ2yNXsIOH1JT6o+yJsXCY2T4jxZ/f
 hQuwbu0gtPzc3q6bORAjSJBnw5kbODXFcLv23OGYMxSvLWcWZVJkWLhIoyUtyEbZ3qQ4M4N8R1
 mfc=
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="106602461"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 01:19:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 01:19:31 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 01:19:29 -0700
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
Subject: [PATCH v4 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Wed, 20 Jan 2021 09:19:19 +0100
Message-ID: <20210120081921.3315847-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120081921.3315847-1-steen.hegelund@microchip.com>
References: <20210120081921.3315847-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Sparx5 reset device driver bindings

The driver uses two syscons on sparx5 for access to
the reset control and the reset status.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 .../bindings/reset/microchip,rst.yaml         | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
new file mode 100644
index 000000000000..af01016e246f
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -0,0 +1,59 @@
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
+  cpu-syscon:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: syscon used to access CPU reset
+    maxItems: 1
+
+  gcb-syscon:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: syscon used to access Global Control Block
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+  - cpu-syscon
+  - gcb-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    reset: reset-controller@0 {
+        compatible = "microchip,sparx5-switch-reset";
+        reg = <0x0 0x0>;
+        #reset-cells = <1>;
+        cpu-syscon = <&cpu_ctrl>;
+        gcb-syscon = <&gcb_ctrl>;
+    };
+
-- 
2.29.2

