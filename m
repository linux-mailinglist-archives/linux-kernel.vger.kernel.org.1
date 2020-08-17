Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8389B245AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 05:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHQDND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 23:13:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:51656 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgHQDNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:13:00 -0400
IronPort-SDR: dALmI6AQSadk4eHInM3HFnriAAFXozzOSwWzXW0aE0WrlowyyASt3vtO4pOVGmsLmFvICVrGOh
 Dn1xxAMdHLtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134145254"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="134145254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 20:12:59 -0700
IronPort-SDR: uUu91F89MBv3L9cx4eYnF/38ljUprjtyhtKI5GmTZ8yS0CczOoASuBb7EeN17IAV8w2Bnejsfs
 Q48oRYe+/+SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="328485459"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2020 20:12:56 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        andriy.shevchenko@intel.com, balbi@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v8 1/2] dt-bindings: phy: Add USB PHY support for Intel LGM SoC
Date:   Mon, 17 Aug 2020 11:12:48 +0800
Message-Id: <20200817031249.36795-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200817031249.36795-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200817031249.36795-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add the dt-schema to support USB PHY on Intel LGM SoC

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
new file mode 100644
index 000000000000..ce62c0b94daf
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,lgm-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel LGM USB PHY Device Tree Bindings
+
+maintainers:
+  - Vadivel Murugan Ramuthevar <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+properties:
+  compatible:
+    const: intel,lgm-usb-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: USB PHY and Host controller reset
+      - description: APB BUS reset
+      - description: General Hardware reset
+
+  reset-names:
+    items:
+      - const: phy
+      - const: apb
+      - const: phy31
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-phy@e7e00000 {
+        compatible = "intel,lgm-usb-phy";
+        reg = <0xe7e00000 0x10000>;
+        clocks = <&cgu0 153>;
+        resets = <&rcu 0x70 0x24>,
+                 <&rcu 0x70 0x26>,
+                 <&rcu 0x70 0x28>;
+        reset-names = "phy", "apb", "phy31";
+        #phy-cells = <0>;
+    };
-- 
2.11.0

