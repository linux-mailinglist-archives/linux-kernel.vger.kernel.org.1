Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4132B00D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgKLIDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:03:05 -0500
Received: from aclms3.advantech.com.tw ([125.252.70.86]:49683 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgKLICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:02:34 -0500
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te2c999f714ac1401c81390@ACLMS3.advantech.com.tw>;
 Thu, 12 Nov 2020 16:01:59 +0800
Received: from localhost (172.16.12.104) by taipei09.ADVANTECH.CORP
 (172.20.0.236) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Nov
 2020 16:01:57 +0800
From:   Shihlun Lin <shihlun.lin@advantech.com.tw>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Campion Kang <campion.kang@advantech.com.tw>,
        Shihlun Lin <shihlun.lin@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: [PATCH v4 3/6] dt-bindings: mfd: ahc1ec0.yaml: Add Advantech embedded controller - AHC1EC0
Date:   Thu, 12 Nov 2020 16:01:53 +0800
Message-ID: <20201112080156.463-3-shihlun.lin@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112080156.463-1-shihlun.lin@advantech.com.tw>
References: <20201112080156.463-1-shihlun.lin@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.12.104]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei09.ADVANTECH.CORP (172.20.0.236)
X-StopIT: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding schema for Advantech embedded controller AHC1EC0.

Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
---
 .../devicetree/bindings/mfd/ahc1ec0.yaml      | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ahc1ec0.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml b/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
new file mode 100644
index 000000000000..a73d1cf65a4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ahc1ec0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Advantech Embedded Controller (AHC1EC0)
+
+maintainers:
+  - Shihlun Lin <shihlun.lin@advantech.com.tw>
+  - Campion Kang <campion.kang@advantech.com.tw>
+
+description: |
+  AHC1EC0 is one of the embedded controllers used by Advantech to provide several
+  functions such as watchdog, hwmon, brightness, etc. Advantech related applications
+  can control the whole system via these functions.
+
+properties:
+  compatible:
+    const: advantech,ahc1ec0
+
+  advantech,sub-dev-nb:
+    description:
+      The number of sub-devices specified in the platform.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+  advantech,sub-dev:
+    description:
+      A list of the sub-devices supported in the platform. Defines for the
+      appropriate values can found in dt-bindings/mfd/ahc1ec0.h.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    minItems: 1
+    maxItems: 6
+
+  advantech,hwmon-profile:
+    description:
+      The number of sub-devices specified in the platform. Defines for the
+      hwmon profiles can found in dt-bindings/mfd/ahc1ec0.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+required:
+  - compatible
+  - advantech,sub-dev-nb
+  - advantech,sub-dev
+
+if:
+  properties:
+    advantech,sub-dev:
+      contains:
+        const: 0x3
+then:
+  required:
+    - advantech,hwmon-profile
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/mfd/ahc1ec0.h>
+    ahc1ec0 {
+        compatible = "advantech,ahc1ec0";
+
+        advantech,sub-dev-nb = <2>;
+        advantech,sub-dev = <AHC1EC0_SUBDEV_HWMON
+                             AHC1EC0_SUBDEV_WDT>;
+
+        advantech,hwmon-profile = <AHC1EC0_HWMON_PRO_UNO2271G>;
+    };
-- 
2.17.1

