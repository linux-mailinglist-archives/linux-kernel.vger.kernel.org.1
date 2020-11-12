Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57ED2B026F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgKLKAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:00:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:19234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKLKAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:00:11 -0500
IronPort-SDR: f1N/9JIZnLYPA3pa+dr0687NuFcAQkoPqfc5u1VUF9220uhUvoaJ39hLaKKSGnCS0nFgvbLoAA
 e5eQLJbzXj1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="170392474"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="170392474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 02:00:11 -0800
IronPort-SDR: uAFv3wFEMV+71baN4rZmGMrJNUhzOYP0pvkdAqCiv4k6GeUQaUoxvCKgZ+TyjDyAfTv4ZGJWI6
 ynBdzuPjhvmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="399346149"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2020 02:00:09 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v3 1/2] dt-bindings: phy: Add Intel Keem Bay USB PHY bindings
Date:   Thu, 12 Nov 2020 17:58:20 +0800
Message-Id: <20201112095821.27110-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112095821.27110-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20201112095821.27110-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

