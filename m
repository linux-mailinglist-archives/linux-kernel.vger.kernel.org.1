Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683A327D0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgI2OQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:16:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730772AbgI2OP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB84C16B1EE2ADFAB6D7;
        Tue, 29 Sep 2020 22:15:24 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 22:15:17 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 11/17] dt-bindings: arm: hisilicon: convert hisilicon,cpuctrl bindings to json-schema
Date:   Tue, 29 Sep 2020 22:14:48 +0800
Message-ID: <20200929141454.2312-12-thunder.leizhen@huawei.com>
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

Convert the Hisilicon CPU controller binding to DT schema format using
json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 29 ++++++++++++++++++++++
 .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |  8 ------
 2 files changed, 29 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
new file mode 100644
index 000000000000000..f6a314db3a59416
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/cpuctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon CPU controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  The clock registers and power registers of secondary cores are defined
+  in CPU controller, especially in HIX5HD2 SoC.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,cpuctrl
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+...
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
deleted file mode 100644
index ceffac537671668..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-Hisilicon CPU controller
-
-Required properties:
-- compatible : "hisilicon,cpuctrl"
-- reg : Register address and size
-
-The clock registers and power registers of secondary cores are defined
-in CPU controller, especially in HIX5HD2 SoC.
-- 
1.8.3


