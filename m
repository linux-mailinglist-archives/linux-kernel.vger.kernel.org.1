Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08109279EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgI0G13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730358AbgI0G1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:05 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C300174747B8D1288C3B;
        Sun, 27 Sep 2020 14:27:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 14:26:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 19/21] dt-bindings: arm: hisilicon: convert hisilicon,hi6220-pmctrl bindings to json-schema
Date:   Sun, 27 Sep 2020 14:21:27 +0800
Message-ID: <20200927062129.4573-20-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200927062129.4573-1-thunder.leizhen@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Hisilicon Hi6220 Power Management domain controller binding
to DT schema format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../controller/hi3620/hisilicon,hi6220-pmctrl.txt  | 18 ----------
 .../controller/hi3620/hisilicon,hi6220-pmctrl.yaml | 42 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt
deleted file mode 100644
index 46f5d8c775cea25..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.txt
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
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.yaml
new file mode 100644
index 000000000000000..5454b43f538c245
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Hi6220 Power Management domain controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  Hisilicon designs this system controller to control the power management
+  domain for mobile platform.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hi6220-pmctrl
+      - const: syscon
+
+  reg:
+    description: Register address and size
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+examples:
+  - |
+    /* for Hi6220 */
+    pm_ctrl: pm_ctrl@f7032000 {
+        compatible = "hisilicon,hi6220-pmctrl", "syscon";
+        reg = <0xf7032000 0x1000>;
+        #clock-cells = <1>;
+    };
+...
\ No newline at end of file
-- 
1.8.3


