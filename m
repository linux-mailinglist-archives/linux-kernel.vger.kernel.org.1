Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4D27D0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgI2OPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:15:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731120AbgI2OPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B8B255224D7ED0D69A2A;
        Tue, 29 Sep 2020 22:15:29 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 22:15:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 16/17] dt-bindings: arm: hisilicon: convert hisilicon,hi3798cv200-perictrl bindings to json-schema
Date:   Tue, 29 Sep 2020 22:14:53 +0800
Message-ID: <20200929141454.2312-17-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200929141454.2312-1-thunder.leizhen@huawei.com>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Hisilicon Hi3798CV200 Peripheral Controller binding to DT
schema format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../hisilicon/controller/hi3798cv200-perictrl.yaml | 64 ++++++++++++++++++++++
 .../controller/hisilicon,hi3798cv200-perictrl.txt  | 21 -------
 2 files changed, 64 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
new file mode 100644
index 000000000000000..cba1937aad9a8d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi3798cv200-perictrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Hi3798CV200 Peripheral Controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  The Hi3798CV200 Peripheral Controller controls peripherals, queries
+  their status, and configures some functions of peripherals.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hi3798cv200-perictrl
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    peripheral-controller@8a20000 {
+        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
+        reg = <0x8a20000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x8a20000 0x1000>;
+
+        phy@850 {
+            compatible = "hisilicon,hi3798cv200-combphy";
+            reg = <0x850 0x8>;
+            #phy-cells = <1>;
+            clocks = <&crg 42>;
+            resets = <&crg 0x188 4>;
+            assigned-clocks = <&crg 42>;
+            assigned-clock-rates = <100000000>;
+            hisilicon,fixed-mode = <4>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
deleted file mode 100644
index 0d5282f4670658d..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Hisilicon Hi3798CV200 Peripheral Controller
-
-The Hi3798CV200 Peripheral Controller controls peripherals, queries
-their status, and configures some functions of peripherals.
-
-Required properties:
-- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
-  and "simple-mfd".
-- reg: Register address and size of Peripheral Controller.
-- #address-cells: Should be 1.
-- #size-cells: Should be 1.
-
-Examples:
-
-	perictrl: peripheral-controller@8a20000 {
-		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
-			     "simple-mfd";
-		reg = <0x8a20000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-- 
1.8.3


