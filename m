Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17600271967
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIUCqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:46:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:53124 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUCqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:46:52 -0400
IronPort-SDR: yOdyzdiprVQC+zLCmN4zstBbB7bLeIGfef0BrRVjY837p/w2d1OuizNC6OMEO5ODF073aLHE89
 2C6Uh+wvwOpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="161218608"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="161218608"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 19:46:51 -0700
IronPort-SDR: FiBfSDEGSN/WE2/QDHhi0DrZN2KbaYcMBohyKvv2QmJY8K/5unYu6xXEyK4t9MbrR7fqnI+u1f
 Q8URAWHuUOXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="321538153"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2020 19:46:48 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 1/4] dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
Date:   Mon, 21 Sep 2020 10:44:56 +0800
Message-Id: <20200921024459.20899-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921024459.20899-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200921024459.20899-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding description for Intel Keem Bay USB PHY.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
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

