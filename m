Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79D527196D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIUCrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:47:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:53124 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUCq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:46:59 -0400
IronPort-SDR: L8steXR67Ok//3JalJOl28B1XfrfaW/jM3FyxpPoF5Z2N/bQKEtIUlqEexd+bsWo0k30VNI8iN
 n3UqTx0sqbLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="161218633"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="161218633"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 19:46:58 -0700
IronPort-SDR: B4vP/uTDSnpKBcigSZNk0WL13JUqmkU+I1SZsnnnUoECCeQaW0Rim5WRwLIkjkyMIO+JrOfji9
 SLZyW1i3C/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="321538176"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2020 19:46:55 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 3/4] dt-bindings: usb: Add Intel Keem Bay USB controller bindings
Date:   Mon, 21 Sep 2020 10:44:58 +0800
Message-Id: <20200921024459.20899-4-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921024459.20899-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200921024459.20899-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Intel Keem Bay USB controller.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../bindings/usb/intel,keembay-dwc3.yaml      | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml b/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
new file mode 100644
index 000000000000..dd32c10ce6c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/intel,keembay-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Keem Bay DWC3 USB controller
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+properties:
+  compatible:
+    const: intel,keembay-dwc3
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: async_master
+      - const: ref
+      - const: alt_ref
+      - const: suspend
+
+  ranges: true
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+# Required child node:
+
+patternProperties:
+  "^dwc3@[0-9a-f]+$":
+    type: object
+    description:
+      A child node must exist to represent the core DWC3 IP block.
+      The content of the node is defined in dwc3.txt.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #define KEEM_BAY_A53_AUX_USB
+    #define KEEM_BAY_A53_AUX_USB_REF
+    #define KEEM_BAY_A53_AUX_USB_ALT_REF
+    #define KEEM_BAY_A53_AUX_USB_SUSPEND
+
+    usb {
+          compatible = "intel,keembay-dwc3";
+          clocks = <&scmi_clk KEEM_BAY_A53_AUX_USB>,
+                   <&scmi_clk KEEM_BAY_A53_AUX_USB_REF>,
+                   <&scmi_clk KEEM_BAY_A53_AUX_USB_ALT_REF>,
+                   <&scmi_clk KEEM_BAY_A53_AUX_USB_SUSPEND>;
+          clock-names = "async_master", "ref", "alt_ref", "suspend";
+          ranges;
+          #address-cells = <1>;
+          #size-cells = <1>;
+
+          dwc3@34000000 {
+                compatible = "snps,dwc3";
+                reg = <0x34000000 0x10000>;
+                interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+                dr_mode = "peripheral";
+          };
+    };
-- 
2.17.1

