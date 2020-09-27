Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C674B279EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgI0G1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14301 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730357AbgI0G1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C9A547748221436D5460;
        Sun, 27 Sep 2020 14:26:57 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 14:26:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 15/21] dt-bindings: arm: hisilicon: convert hisilicon,hip04-fabric bindings to json-schema
Date:   Sun, 27 Sep 2020 14:21:23 +0800
Message-ID: <20200927062129.4573-16-thunder.leizhen@huawei.com>
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

Convert the Hisilicon Fabric controller binding to DT schema format using
json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../controller/hipxx/hisilicon,hip04-fabric.txt    |  5 -----
 .../controller/hipxx/hisilicon,hip04-fabric.yaml   | 26 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt
deleted file mode 100644
index 1709ac91d4cd99c..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-Fabric:
-
-Required Properties:
-- compatible: "hisilicon,hip04-fabric";
-- reg: Address and size of Fabric
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.yaml
new file mode 100644
index 000000000000000..ae0a4e68aa8d628
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.yaml#
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
+    description: Register address and size
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+...
\ No newline at end of file
-- 
1.8.3


