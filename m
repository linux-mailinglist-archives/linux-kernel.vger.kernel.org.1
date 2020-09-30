Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D127DED3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgI3DTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:19:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729976AbgI3DSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:18:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87147261CA98E68529DC;
        Wed, 30 Sep 2020 11:18:47 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:18:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v6 15/17] dt-bindings: arm: hisilicon: convert Hi6220 domain controller bindings to json-schema
Date:   Wed, 30 Sep 2020 11:17:10 +0800
Message-ID: <20200930031712.2365-16-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200930031712.2365-1-thunder.leizhen@huawei.com>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Hisilicon Hi6220 domain controllers binding to DT schema
format using json-schema. All of them are grouped into one yaml file, to
help users understand differences and avoid repeated descriptions.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../hisilicon/controller/hi6220-domain-ctrl.yaml   | 68 ++++++++++++++++++++++
 .../controller/hisilicon,hi6220-aoctrl.txt         | 18 ------
 .../controller/hisilicon,hi6220-mediactrl.txt      | 18 ------
 .../controller/hisilicon,hi6220-pmctrl.txt         | 18 ------
 4 files changed, 68 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
new file mode 100644
index 000000000000000..6ea6d7ee7a14f0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi6220-domain-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Hi6220 domain controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  Hisilicon designs some special domain controllers for mobile platform,
+  such as: the power Always On domain controller, the Media domain
+  controller(e.g. codec, G3D ...) and the Power Management domain
+  controller.
+
+  The compatible names of each domain controller are as follows:
+  Power Always ON domain controller  --> hisilicon,hi6220-aoctrl
+  Media domain controller            --> hisilicon,hi6220-mediactrl
+  Power Management domain controller --> hisilicon,hi6220-pmctrl
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hisilicon,hi6220-aoctrl
+          - hisilicon,hi6220-mediactrl
+          - hisilicon,hi6220-pmctrl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ao_ctrl@f7800000 {
+        compatible = "hisilicon,hi6220-aoctrl", "syscon";
+        reg = <0xf7800000 0x2000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
+
+    media_ctrl@f4410000 {
+        compatible = "hisilicon,hi6220-mediactrl", "syscon";
+        reg = <0xf4410000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+    pm_ctrl@f7032000 {
+        compatible = "hisilicon,hi6220-pmctrl", "syscon";
+        reg = <0xf7032000 0x1000>;
+        #clock-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
deleted file mode 100644
index 5a723c1d45f4a17..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Hisilicon Hi6220 Power Always ON domain controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-aoctrl"
-- reg : Register address and size
-- #clock-cells: should be set to 1, many clock registers are defined
-  under this controller and this property must be present.
-
-Hisilicon designs this system controller to control the power always
-on domain for mobile platform.
-
-Example:
-	/*for Hi6220*/
-	ao_ctrl: ao_ctrl@f7800000 {
-		compatible = "hisilicon,hi6220-aoctrl", "syscon";
-		reg = <0x0 0xf7800000 0x0 0x2000>;
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
deleted file mode 100644
index dcfdcbcb6455771..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Hisilicon Hi6220 Media domain controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-mediactrl"
-- reg : Register address and size
-- #clock-cells: should be set to 1, many clock registers are defined
-  under this controller and this property must be present.
-
-Hisilicon designs this system controller to control the multimedia
-domain(e.g. codec, G3D ...) for mobile platform.
-
-Example:
-	/*for Hi6220*/
-	media_ctrl: media_ctrl@f4410000 {
-		compatible = "hisilicon,hi6220-mediactrl", "syscon";
-		reg = <0x0 0xf4410000 0x0 0x1000>;
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
deleted file mode 100644
index 972842f07b5a2ce..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Hisilicon Hi6220 Power Management domain controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-pmctrl"
-- reg : Register address and size
-- #clock-cells: should be set to 1, some clock registers are define
-  under this controller and this property must be present.
-
-Hisilicon designs this system controller to control the power management
-domain for mobile platform.
-
-Example:
-	/*for Hi6220*/
-	pm_ctrl: pm_ctrl@f7032000 {
-		compatible = "hisilicon,hi6220-pmctrl", "syscon";
-		reg = <0x0 0xf7032000 0x0 0x1000>;
-		#clock-cells = <1>;
-	};
-- 
1.8.3


