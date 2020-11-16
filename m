Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1572B435C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgKPMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:10:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:31993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbgKPMKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:10:23 -0500
IronPort-SDR: c/OfR3hsAWZjUtVWD2IHDShoSPl1bNqx8iBk+rbCTqy9pFRfXop2vjgyzF3PtTqkczKs5/l8ft
 0UDS0MmZEXMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="255446429"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="255446429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:10:22 -0800
IronPort-SDR: equLe1cxBbsPQrStd6SMXZWGOsbPCHFxasC6O2BlX1SkcMkeDKaAYHRrkam79NJ35HvlUiJPBB
 ciUVOYC2hP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="356259724"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2020 04:10:20 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 1/2] dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
Date:   Mon, 16 Nov 2020 20:08:30 +0800
Message-Id: <20201116120831.32641-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Intel Keem Bay USB PHY.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/intel,phy-keembay-usb.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml

diff --git a/Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml b/Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
new file mode 100644
index 000000000000..a217bb8ac5bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/intel,phy-keembay-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Keem Bay USB PHY bindings
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+properties:
+  compatible:
+    const: intel,keembay-usb-phy
+
+  reg:
+    items:
+      - description: USB APB CPR (clock, power, reset) register
+      - description: USB APB slave register
+
+  reg-names:
+    items:
+      - const: cpr-apb-base
+      - const: slv-apb-base
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-phy@20400000 {
+          compatible = "intel,keembay-usb-phy";
+          reg = <0x20400000 0x1c>,
+                <0x20480000 0xd0>;
+          reg-names = "cpr-apb-base", "slv-apb-base";
+          #phy-cells = <0>;
+    };
-- 
2.17.1

