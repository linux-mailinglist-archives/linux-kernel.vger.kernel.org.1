Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D4279ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgI0G1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730391AbgI0G1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C238D6EC2B1BF2E5D891;
        Sun, 27 Sep 2020 14:26:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 14:26:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 03/21] dt-bindings: arm: hisilicon: convert Hisilicon board/soc bindings to json-schema
Date:   Sun, 27 Sep 2020 14:21:11 +0800
Message-ID: <20200927062129.4573-4-thunder.leizhen@huawei.com>
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

Convert Hisilicon SoC bindings to DT schema format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 57 ----------------
 .../bindings/arm/hisilicon/hisilicon.yaml          | 77 ++++++++++++++++++++++
 2 files changed, 77 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
deleted file mode 100644
index f7e52476f5f2f3c..000000000000000
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
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
new file mode 100644
index 000000000000000..362decf3b85c6fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
@@ -0,0 +1,77 @@
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
+      - description: Hi3660 SoC
+        items:
+          - const: hisilicon,hi3660
+
+      - description: HiKey960 Board
+        items:
+          - const: hisilicon,hi3660-hikey960
+          - const: hisilicon,hi3660
+
+      - description: Hi3670 SoC
+        items:
+          - const: hisilicon,hi3670
+
+      - description: HiKey970 Board
+        items:
+          - const: hisilicon,hi3670-hikey970
+          - const: hisilicon,hi3670
+
+      - description: Hi3798cv200 SoC
+        items:
+          - const: hisilicon,hi3798cv200
+
+      - description: Hi3798cv200 Poplar Board
+        items:
+          - const: hisilicon,hi3798cv200-poplar
+          - const: hisilicon,hi3798cv200
+
+      - description: Hi4511 Board
+        items:
+          - const: hisilicon,hi3620-hi4511
+
+      - description: Hi6220 SoC
+        items:
+          - const: hisilicon,hi6220
+
+      - description: HiKey Board
+        items:
+          - const: hisilicon,hi6220-hikey
+          - const: hisilicon,hi6220
+
+      - description: HiP01 ca9x2 Board
+        items:
+          - const: hisilicon,hip01-ca9x2
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


