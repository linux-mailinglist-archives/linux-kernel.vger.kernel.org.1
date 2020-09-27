Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA14279EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgI0G10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730418AbgI0G1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:07 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED2C6FC572A46CB6871A;
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
Subject: [PATCH v3 20/21] dt-bindings: arm: hisilicon: convert hisilicon,hi6220-sramctrl bindings to json-schema
Date:   Sun, 27 Sep 2020 14:21:28 +0800
Message-ID: <20200927062129.4573-21-thunder.leizhen@huawei.com>
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

Convert the Hisilicon Hi6220 SRAM controller binding to DT schema format
using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../hi3620/hisilicon,hi6220-sramctrl.txt           | 16 ---------
 .../hi3620/hisilicon,hi6220-sramctrl.yaml          | 38 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
deleted file mode 100644
index 963a2cb13a249d9..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Hisilicon Hi6220 SRAM controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-sramctrl", "syscon"
-- reg : Register address and size
-
-Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
-SRAM banks for power management, modem, security, etc. Further, use "syscon"
-managing the common sram which can be shared by multiple modules.
-
-Example:
-	/*for Hi6220*/
-	sram: sram@fff80000 {
-		compatible = "hisilicon,hi6220-sramctrl", "syscon";
-		reg = <0x0 0xfff80000 0x0 0x12000>;
-	};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml
new file mode 100644
index 000000000000000..f66d414a7a48071
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Hi6220 SRAM controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  Hisilicon's SoCs use sram for multiple purpose; on Hi6220 there have several
+  SRAM banks for power management, modem, security, etc. Further, use "syscon"
+  managing the common sram which can be shared by multiple modules.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hi6220-sramctrl
+      - const: syscon
+
+  reg:
+    description: Register address and size
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    /* for Hi6220 */
+    sram: sram@fff80000 {
+        compatible = "hisilicon,hi6220-sramctrl", "syscon";
+        reg = <0xfff80000 0x12000>;
+    };
+...
\ No newline at end of file
-- 
1.8.3


