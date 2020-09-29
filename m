Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E409E27D0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgI2OPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:15:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728599AbgI2OPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 78E8BC5ADCCD71D945CE;
        Tue, 29 Sep 2020 22:15:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 22:15:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 04/17] dt-bindings: arm: hisilicon: convert Hisilicon board/soc bindings to json-schema
Date:   Tue, 29 Sep 2020 22:14:41 +0800
Message-ID: <20200929141454.2312-5-thunder.leizhen@huawei.com>
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

Convert Hisilicon SoC bindings to DT schema format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 57 --------------------
 .../bindings/arm/hisilicon/hisilicon.yaml          | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
deleted file mode 100644
index ffe760a636b5e7f..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Hisilicon Platforms Device Tree Bindings
-----------------------------------------------------
-Hi3660 SoC
-Required root node properties:
-	- compatible = "hisilicon,hi3660";
-
-HiKey960 Board
-Required root node properties:
-	- compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
-
-Hi3670 SoC
-Required root node properties:
-	- compatible = "hisilicon,hi3670";
-
-HiKey970 Board
-Required root node properties:
-	- compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
-
-Hi3798cv200 SoC
-Required root node properties:
-	- compatible = "hisilicon,hi3798cv200";
-
-Hi3798cv200 Poplar Board
-Required root node properties:
-	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
-
-Hi4511 Board
-Required root node properties:
-	- compatible = "hisilicon,hi3620-hi4511";
-
-Hi6220 SoC
-Required root node properties:
-	- compatible = "hisilicon,hi6220";
-
-HiKey Board
-Required root node properties:
-	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
-
-HiP01 ca9x2 Board
-Required root node properties:
-	- compatible = "hisilicon,hip01-ca9x2";
-
-HiP04 D01 Board
-Required root node properties:
-	- compatible = "hisilicon,hip04-d01";
-
-HiP05 D02 Board
-Required root node properties:
-	- compatible = "hisilicon,hip05-d02";
-
-HiP06 D03 Board
-Required root node properties:
-	- compatible = "hisilicon,hip06-d03";
-
-HiP07 D05 Board
-Required root node properties:
-	- compatible = "hisilicon,hip07-d05";
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
new file mode 100644
index 000000000000000..6d17309c7c84308
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/hisilicon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Platforms Device Tree Bindings
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+properties:
+  $nodename:
+    const: '/'
+
+  compatible:
+    oneOf:
+      - description: Hi3660 based boards.
+        items:
+          - const: hisilicon,hi3660-hikey960
+          - const: hisilicon,hi3660
+
+      - description: Hi3670 based boards.
+        items:
+          - const: hisilicon,hi3670-hikey970
+          - const: hisilicon,hi3670
+
+      - description: Hi3798cv200 based boards.
+        items:
+          - const: hisilicon,hi3798cv200-poplar
+          - const: hisilicon,hi3798cv200
+
+      - description: Hi4511 Board
+        items:
+          - const: hisilicon,hi3620-hi4511
+
+      - description: Hi6220 based boards.
+        items:
+          - const: hisilicon,hi6220-hikey
+          - const: hisilicon,hi6220
+
+      - description: HiP01 based boards.
+        items:
+          - const: hisilicon,hip01-ca9x2
+          - const: hisilicon,hip01
+
+      - description: HiP04 D01 Board
+        items:
+          - const: hisilicon,hip04-d01
+
+      - description: HiP05 D02 Board
+        items:
+          - const: hisilicon,hip05-d02
+
+      - description: HiP06 D03 Board
+        items:
+          - const: hisilicon,hip06-d03
+
+      - description: HiP07 D05 Board
+        items:
+          - const: hisilicon,hip07-d05
+...
-- 
1.8.3


