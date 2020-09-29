Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1370127D0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgI2OPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:15:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730369AbgI2OP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9546A665D24B12652272;
        Tue, 29 Sep 2020 22:15:24 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 22:15:18 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 12/17] dt-bindings: arm: hisilicon: convert hisilicon,pctrl bindings to json-schema
Date:   Tue, 29 Sep 2020 22:14:49 +0800
Message-ID: <20200929141454.2312-13-thunder.leizhen@huawei.com>
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

Convert the Hisilicon peripheral misc control register binding to DT
schema format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../arm/hisilicon/controller/hisilicon,pctrl.txt   | 13 ---------
 .../bindings/arm/hisilicon/controller/pctrl.yaml   | 34 ++++++++++++++++++++++
 2 files changed, 34 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/pctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
deleted file mode 100644
index deec777bc3a850a..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-PCTRL: Peripheral misc control register
-
-Required Properties:
-- compatible: "hisilicon,pctrl"
-- reg: Address and size of pctrl.
-
-Example:
-
-	/* for Hi3620 */
-	pctrl: pctrl@fca09000 {
-		compatible = "hisilicon,pctrl";
-		reg = <0xfca09000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/pctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/pctrl.yaml
new file mode 100644
index 000000000000000..6d50658728092cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/pctrl.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/pctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral misc control register
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: Peripheral misc control register
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,pctrl
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pctrl@fca09000 {
+        compatible = "hisilicon,pctrl";
+        reg = <0xfca09000 0x1000>;
+    };
+...
-- 
1.8.3


