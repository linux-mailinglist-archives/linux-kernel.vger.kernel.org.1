Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F82F5402
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbhAMUUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:20:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23691 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbhAMUUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610569247; x=1642105247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7dbWcybAcPSCs9JfAgrdc5kMVgaiF/4Xqgv+SIR8YsI=;
  b=IVpF718BZYB942eRrBJFHQwbB1E7LhLyC3yvp8upvKj579If4mZufyKc
   JN28gfztQa1TcXLYo/qVQdR/+QjG3DYaMbyXLmMYESTo4T4OJ2EChbNKd
   rWFZpcfUBj5QNKcSORgNokpx79vOBJgvurtgZ5OR3Nbavq9EzD3YJTSYV
   b/N/hPJYbfh7lCdKZ4NqW2+F1IibG6SyefpoMuiFQki+7rnJL4Pbp/Q83
   vNWs/r4DLrhnR4Fhz/hkCfDBXzNPQQEolzccTzhqxV/oP1EZOjs+WPx7E
   QZKu0OkbUmkqgMr74Y57zyFlOLIX3QsvItshB+qWVsZ32GWqrIkYnPj9m
   Q==;
IronPort-SDR: Q5YVbzN1MpxfO8X9+xyiHVwEmpQEDlQHouAC2ZroV729l8ei0sVFOTiVzzEHBRlvnCD3XvniYK
 LfF1s7I0kzJTrYJfZOz/VToqxVSSVOOSYa9kPD53mngsfYfQcbYH6tkjuhdPgIR969c/AXIkVw
 yJ1es9qWP3VasmjgYFCXG7Qi0ZgwwdutfnsOh0OwXPPk5vbyzYjUL7nC1o+CXGOPnMwGS7C82l
 cPuC96TXeK9UfE66gxFLiXF3cF5EgIV+sjjMsm7w+0yyCojLRYrx0zEFj3GFAezJJFCEjgZb7B
 XNU=
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="99992683"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2021 13:19:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 13:19:30 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 13 Jan 2021 13:19:28 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Wed, 13 Jan 2021 21:19:13 +0100
Message-ID: <20210113201915.2734205-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113201915.2734205-1-steen.hegelund@microchip.com>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
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

