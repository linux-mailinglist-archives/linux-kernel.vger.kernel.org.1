Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737FD27B0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI1PSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:18:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbgI1PRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:17:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C5873411824F303FF16B;
        Mon, 28 Sep 2020 23:17:29 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 23:17:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 17/20] dt-bindings: arm: hisilicon: convert hisilicon,hi6220-mediactrl bindings to json-schema
Date:   Mon, 28 Sep 2020 23:13:21 +0800
Message-ID: <20200928151324.2134-18-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200928151324.2134-1-thunder.leizhen@huawei.com>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Hisilicon Hi6220 Media domain controller binding to DT schema
format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../controller/hisilicon,hi6220-mediactrl.txt      | 18 ----------
 .../controller/hisilicon,hi6220-mediactrl.yaml     | 42 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.yaml

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
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.yaml
new file mode 100644
index 000000000000000..d6edbe8773a103b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Hi6220 Media domain controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  Hisilicon designs this system controller to control the multimedia
+  domain(e.g. codec, G3D ...) for mobile platform.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hi6220-mediactrl
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
+    media_ctrl: media_ctrl@f4410000 {
+        compatible = "hisilicon,hi6220-mediactrl", "syscon";
+        reg = <0xf4410000 0x1000>;
+        #clock-cells = <1>;
+    };
+...
-- 
1.8.3


