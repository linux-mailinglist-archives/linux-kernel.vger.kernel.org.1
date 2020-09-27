Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBEB279EDB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgI0G05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:26:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729713AbgI0G0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:26:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A0CF8F58B3A948F004C5;
        Sun, 27 Sep 2020 14:26:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 14:26:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 10/21] dt-bindings: arm: hisilicon: convert hisilicon,pcie-sas-subctrl bindings to json-schema
Date:   Sun, 27 Sep 2020 14:21:18 +0800
Message-ID: <20200927062129.4573-11-thunder.leizhen@huawei.com>
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

Convert the Hisilicon HiP05/HiP06 PCIe-SAS subsystem controller binding
to DT schema format using json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../controller/hisilicon,pcie-sas-subctrl.txt      | 15 ---------
 .../controller/hisilicon,pcie-sas-subctrl.yaml     | 37 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
deleted file mode 100644
index 43efdaf408f6fe1..000000000000000
--- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
-
-Required properties:
-- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
-- reg : Register address and size
-
-The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
-HiP05 or HiP06 Soc to implement some basic configurations.
-
-Example:
-	/* for HiP05 PCIe-SAS sub system */
-	pcie_sas: system_controller@b0000000 {
-		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
-		reg = <0xb0000000 0x10000>;
-	};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
new file mode 100644
index 000000000000000..8d1341022de587d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon HiP05/HiP06 PCIe-SAS subsystem controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
+  HiP05 or HiP06 Soc to implement some basic configurations.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,pcie-sas-subctrl
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
+    /* for HiP05 PCIe-SAS sub system */
+    pcie_sas: system_controller@b0000000 {
+        compatible = "hisilicon,pcie-sas-subctrl", "syscon";
+        reg = <0xb0000000 0x10000>;
+    };
+...
\ No newline at end of file
-- 
1.8.3


