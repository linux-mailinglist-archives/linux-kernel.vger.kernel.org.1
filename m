Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF062CE549
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLDBny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:43:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8640 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLDBnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:43:53 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnFnq0qzyz15WJn;
        Fri,  4 Dec 2020 09:42:39 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:42:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] dt-bindings: reset: convert Hisilicon reset controller bindings to json-schema
Date:   Fri, 4 Dec 2020 09:42:36 +0800
Message-ID: <20201204014236.1158-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201204014236.1158-1-thunder.leizhen@huawei.com>
References: <20201204014236.1158-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Hisilicon reset controller binding to DT schema format using
json-schema.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../bindings/reset/hisilicon,hi3660-reset.txt      | 44 -------------
 .../bindings/reset/hisilicon,hi3660-reset.yaml     | 77 ++++++++++++++++++++++
 2 files changed, 77 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
deleted file mode 100644
index aefd26710f9e87d..000000000000000
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Hisilicon System Reset Controller
-======================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-The reset controller registers are part of the system-ctl block on
-hi3660 and hi3670 SoCs.
-
-Required properties:
-- compatible: should be one of the following:
-		 "hisilicon,hi3660-reset" for HI3660
-		 "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
-- hisilicon,rst-syscon: phandle of the reset's syscon.
-- #reset-cells : Specifies the number of cells needed to encode a
-  reset source.  The type shall be a <u32> and the value shall be 2.
-
-	 Cell #1 : offset of the reset assert control
-	           register from the syscon register base
-		   offset + 4: deassert control register
-		   offset + 8: status control register
-	 Cell #2 : bit position of the reset in the reset control register
-
-Example:
-	iomcu: iomcu@ffd7e000 {
-		compatible = "hisilicon,hi3660-iomcu", "syscon";
-		reg = <0x0 0xffd7e000 0x0 0x1000>;
-	};
-
-	iomcu_rst: iomcu_rst_controller {
-		compatible = "hisilicon,hi3660-reset";
-		hisilicon,rst-syscon = <&iomcu>;
-		#reset-cells = <2>;
-	};
-
-Specifying reset lines connected to IP modules
-==============================================
-example:
-
-        i2c0: i2c@..... {
-                ...
-		resets = <&iomcu_rst 0x20 3>; /* offset: 0x20; bit: 3 */
-                ...
-        };
diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
new file mode 100644
index 000000000000000..9bf40952e5b7d28
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/hisilicon,hi3660-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon System Reset Controller
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: |
+  Please also refer to reset.txt in this directory for common reset
+  controller binding usage.
+  The reset controller registers are part of the system-ctl block on
+  hi3660 and hi3670 SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: hisilicon,hi3660-reset
+      - items:
+          - const: hisilicon,hi3670-reset
+          - const: hisilicon,hi3660-reset
+
+  hisilicon,rst-syscon:
+    description: phandle of the reset's syscon.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#reset-cells':
+    description: |
+      Specifies the number of cells needed to encode a reset source.
+      Cell #1 : offset of the reset assert control register from the syscon
+                register base
+                offset + 4: deassert control register
+                offset + 8: status control register
+      Cell #2 : bit position of the reset in the reset control register
+    const: 2
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/hi3660-clock.h>
+
+    iomcu: iomcu@ffd7e000 {
+        compatible = "hisilicon,hi3660-iomcu", "syscon";
+        reg = <0xffd7e000 0x1000>;
+    };
+
+    iomcu_rst: iomcu_rst_controller {
+        compatible = "hisilicon,hi3660-reset";
+        hisilicon,rst-syscon = <&iomcu>;
+        #reset-cells = <2>;
+    };
+
+    /* Specifying reset lines connected to IP modules */
+    i2c@ffd71000 {
+        compatible = "snps,designware-i2c";
+        reg = <0xffd71000 0x1000>;
+        interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clock-frequency = <400000>;
+        clocks = <&crg_ctrl HI3660_CLK_GATE_I2C0>;
+        resets = <&iomcu_rst 0x20 3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+        status = "disabled";
+    };
+...
-- 
1.8.3


