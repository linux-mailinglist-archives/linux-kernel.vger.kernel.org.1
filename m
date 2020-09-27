Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFC279ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgI0G1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730393AbgI0G1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B27CDDA9EFB4BC5EB9C9;
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
Subject: [PATCH v3 14/21] dt-bindings: arm: hisilicon: convert hisilicon,dsa-subctrl bindings to json-schema
Date:   Sun, 27 Sep 2020 14:21:22 +0800
Message-ID: <20200927062129.4573-15-thunder.leizhen@huawei.com>
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

Convert the Hisilicon HiP05/HiP06 DSA subsystem controller binding to DT
schema format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../hisilicon/controller/hisilicon,dsa-subctrl.txt | 15 ---------
 .../controller/hisilicon,dsa-subctrl.yaml          | 37 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
deleted file mode 100644
index 88f81760ddc8621..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Hisilicon HiP05/HiP06 DSA sub system controller
-
-Required properties:
-- compatible : "hisilicon,dsa-subctrl", "syscon";
-- reg : Register address and size
-
-The DSA sub system controller is shared by peripheral controllers in
-HiP05 or HiP06 Soc to implement some basic configurations.
-
-Example:
-	/* for HiP05 dsa sub system */
-	pcie_sas: system_controller@a0000000 {
-		compatible = "hisilicon,dsa-subctrl", "syscon";
-		reg = <0xa0000000 0x10000>;
-	};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.yaml
new file mode 100644
index 000000000000000..f5dabeede5cff26
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,dsa-subctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon HiP05/HiP06 DSA subsystem controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  The DSA sub system controller is shared by peripheral controllers in
+  HiP05 or HiP06 Soc to implement some basic configurations.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,dsa-subctrl
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
+    /* for HiP05 dsa sub system */
+    pcie_sas: system_controller@a0000000 {
+        compatible = "hisilicon,dsa-subctrl", "syscon";
+        reg = <0xa0000000 0x10000>;
+    };
+...
\ No newline at end of file
-- 
1.8.3


