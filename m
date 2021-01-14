Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195A42F65E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbhANQ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:26:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5560 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbhANQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610641559; x=1642177559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tDy1Ty/j0XhdbcBXXPw/CY2LnOTHbcQR+30q3Xoh7I=;
  b=DDVDHxEykJhimg1KEj2Mh+b/BXICxaStrU541Ha1xsaPhDmSOkwm6sT8
   1D4sLXTCyAKz2sVS10P/iHe7AEq3Fz67EhWAapv9ZtTcj7wXUvMANJwev
   IgElFKTTgH3nrzIt0Yx+Iios2hbcwRYlBae4Zrpa1fnduimBHtTibe1/N
   TQHlb6Q/M6V1Sasutolsz68eV3GKfjLVFXFPZmPZmtxF2FWAFXk8kQwcf
   jxg4UlWKfM6h7IX6IwojKs6FlH/sB+RwbQsEOqVgLjU4PdS+SWt8jJJ44
   6Hoj3TxeIfSaWNiKT0kkI2EYZn/u5cre5t+D+ZVt16684eDy0RNQgZvja
   A==;
IronPort-SDR: uQCiCBJ8CO5J0HpcLdEIFesXgHmvnyXupPU9XZUSYfb8ZzDavnSbvPGXp6T6u00TqlirDbu8hV
 8wp44cxkiJUPdRLm4NYxDyavD4ELqcN4S2iOBVLNJysWUtpEXqezOYwEHelB/8t2/XLieoYE2x
 1ISSeOcx/mAiYOClscUSZ52on/TToDFpJ5+qWS6BN8tfXXauvtBPUXZRMkHf5WfrD6Arbu9v3V
 cPI5x69QUHDc0+VJcZtWqFHFvfQ2Xuv8XtKNq2OxdFCbUb7f576oGoYd24J+8gINeGm5mxGl6Q
 WXA=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="105447446"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 09:24:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 09:24:41 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 09:24:39 -0700
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
Subject: [PATCH v3 1/3] dt-bindings: reset: microchip sparx5 reset driver bindings
Date:   Thu, 14 Jan 2021 17:24:30 +0100
Message-ID: <20210114162432.3039657-2-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114162432.3039657-1-steen.hegelund@microchip.com>
References: <20210114162432.3039657-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

