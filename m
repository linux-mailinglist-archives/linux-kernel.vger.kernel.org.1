Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9BF27DEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgI3DTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:19:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729949AbgI3DSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:18:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 97687ADA38F6F5B3BA6F;
        Wed, 30 Sep 2020 11:18:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:18:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v6 13/17] dt-bindings: arm: hisilicon: convert hisilicon,hip04-fabric bindings to json-schema
Date:   Wed, 30 Sep 2020 11:17:08 +0800
Message-ID: <20200930031712.2365-14-thunder.leizhen@huawei.com>
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

Convert the Hisilicon Fabric controller binding to DT schema format using
json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../arm/hisilicon/controller/hip04-fabric.yaml     | 27 ++++++++++++++++++++++
 .../controller/hisilicon,hip04-fabric.txt          |  5 ----
 2 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-fabric.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-fabric.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-fabric.yaml
new file mode 100644
index 000000000000000..60c516a04ad58b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-fabric.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hip04-fabric.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Fabric controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: Hisilicon Fabric controller
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hip04-fabric
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
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
deleted file mode 100644
index 40453d02f2024bd..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-Fabric:
-
-Required Properties:
-- compatible: "hisilicon,hip04-fabric";
-- reg: Address and size of Fabric
-- 
1.8.3


