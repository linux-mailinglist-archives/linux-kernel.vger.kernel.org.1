Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04927DEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgI3DTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:19:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbgI3DSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:18:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 777C860047683712F8EF;
        Wed, 30 Sep 2020 11:18:37 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:18:29 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v6 03/17] dt-bindings: arm: hisilicon: split the dt-bindings of each controller into a separate file
Date:   Wed, 30 Sep 2020 11:16:58 +0800
Message-ID: <20200930031712.2365-4-thunder.leizhen@huawei.com>
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

Split the devicetree bindings of each Hisilicon controller from
hisilicon.txt into a separate file, the file name is the compatible name
attach the .txt file name extension.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |   8 +
 .../controller/hisilicon,hi3798cv200-perictrl.txt  |  21 +++
 .../controller/hisilicon,hi6220-aoctrl.txt         |  18 ++
 .../controller/hisilicon,hi6220-mediactrl.txt      |  18 ++
 .../controller/hisilicon,hi6220-pmctrl.txt         |  18 ++
 .../controller/hisilicon,hi6220-sysctrl.txt        |  19 ++
 .../controller/hisilicon,hip01-sysctrl.txt         |  19 ++
 .../controller/hisilicon,hip04-bootwrapper.txt     |   9 +
 .../controller/hisilicon,hip04-fabric.txt          |   5 +
 .../arm/hisilicon/controller/hisilicon,pctrl.txt   |  13 ++
 .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 +++
 .../bindings/arm/hisilicon/hisilicon.txt           | 194 ---------------------
 12 files changed, 173 insertions(+), 194 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
new file mode 100644
index 000000000000000..ceffac537671668
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
@@ -0,0 +1,8 @@
+Hisilicon CPU controller
+
+Required properties:
+- compatible : "hisilicon,cpuctrl"
+- reg : Register address and size
+
+The clock registers and power registers of secondary cores are defined
+in CPU controller, especially in HIX5HD2 SoC.
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
new file mode 100644
index 000000000000000..0d5282f4670658d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
@@ -0,0 +1,21 @@
+Hisilicon Hi3798CV200 Peripheral Controller
+
+The Hi3798CV200 Peripheral Controller controls peripherals, queries
+their status, and configures some functions of peripherals.
+
+Required properties:
+- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
+  and "simple-mfd".
+- reg: Register address and size of Peripheral Controller.
+- #address-cells: Should be 1.
+- #size-cells: Should be 1.
+
+Examples:
+
+	perictrl: peripheral-controller@8a20000 {
+		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
+			     "simple-mfd";
+		reg = <0x8a20000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
new file mode 100644
index 000000000000000..5a723c1d45f4a17
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
@@ -0,0 +1,18 @@
+Hisilicon Hi6220 Power Always ON domain controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-aoctrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, many clock registers are defined
+  under this controller and this property must be present.
+
+Hisilicon designs this system controller to control the power always
+on domain for mobile platform.
+
+Example:
+	/*for Hi6220*/
+	ao_ctrl: ao_ctrl@f7800000 {
+		compatible = "hisilicon,hi6220-aoctrl", "syscon";
+		reg = <0x0 0xf7800000 0x0 0x2000>;
+		#clock-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
new file mode 100644
index 000000000000000..dcfdcbcb6455771
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
@@ -0,0 +1,18 @@
+Hisilicon Hi6220 Media domain controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-mediactrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, many clock registers are defined
+  under this controller and this property must be present.
+
+Hisilicon designs this system controller to control the multimedia
+domain(e.g. codec, G3D ...) for mobile platform.
+
+Example:
+	/*for Hi6220*/
+	media_ctrl: media_ctrl@f4410000 {
+		compatible = "hisilicon,hi6220-mediactrl", "syscon";
+		reg = <0x0 0xf4410000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
new file mode 100644
index 000000000000000..972842f07b5a2ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
@@ -0,0 +1,18 @@
+Hisilicon Hi6220 Power Management domain controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-pmctrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, some clock registers are define
+  under this controller and this property must be present.
+
+Hisilicon designs this system controller to control the power management
+domain for mobile platform.
+
+Example:
+	/*for Hi6220*/
+	pm_ctrl: pm_ctrl@f7032000 {
+		compatible = "hisilicon,hi6220-pmctrl", "syscon";
+		reg = <0x0 0xf7032000 0x0 0x1000>;
+		#clock-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
new file mode 100644
index 000000000000000..07e318eda254f52
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
@@ -0,0 +1,19 @@
+Hisilicon Hi6220 system controller
+
+Required properties:
+- compatible : "hisilicon,hi6220-sysctrl"
+- reg : Register address and size
+- #clock-cells: should be set to 1, many clock registers are defined
+  under this controller and this property must be present.
+
+Hisilicon designs this controller as one of the system controllers,
+its main functions are the same as Hisilicon system controller, but
+the register offset of some core modules are different.
+
+Example:
+	/*for Hi6220*/
+	sys_ctrl: sys_ctrl@f7030000 {
+		compatible = "hisilicon,hi6220-sysctrl", "syscon";
+		reg = <0x0 0xf7030000 0x0 0x2000>;
+		#clock-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
new file mode 100644
index 000000000000000..db2dfdce799db91
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
@@ -0,0 +1,19 @@
+Hisilicon HiP01 system controller
+
+Required properties:
+- compatible : "hisilicon,hip01-sysctrl"
+- reg : Register address and size
+
+The HiP01 system controller is mostly compatible with hisilicon
+system controller,but it has some specific control registers for
+HIP01 SoC family, such as slave core boot, and also some same
+registers located at different offset.
+
+Example:
+
+	/* for hip01-ca9x2 */
+	sysctrl: system-controller@10000000 {
+		compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
+		reg = <0x10000000 0x1000>;
+		reboot-offset = <0x4>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
new file mode 100644
index 000000000000000..b0d53333f4fdae1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
@@ -0,0 +1,9 @@
+Bootwrapper boot method (software protocol on SMP):
+
+Required Properties:
+- compatible: "hisilicon,hip04-bootwrapper";
+- boot-method: Address and size of boot method.
+  [0]: bootwrapper physical address
+  [1]: bootwrapper size
+  [2]: relocation physical address
+  [3]: relocation size
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
new file mode 100644
index 000000000000000..40453d02f2024bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
@@ -0,0 +1,5 @@
+Fabric:
+
+Required Properties:
+- compatible: "hisilicon,hip04-fabric";
+- reg: Address and size of Fabric
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
new file mode 100644
index 000000000000000..deec777bc3a850a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
@@ -0,0 +1,13 @@
+PCTRL: Peripheral misc control register
+
+Required Properties:
+- compatible: "hisilicon,pctrl"
+- reg: Address and size of pctrl.
+
+Example:
+
+	/* for Hi3620 */
+	pctrl: pctrl@fca09000 {
+		compatible = "hisilicon,pctrl";
+		reg = <0xfca09000 0x1000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
new file mode 100644
index 000000000000000..963f7f1ca7a2f0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
@@ -0,0 +1,25 @@
+Hisilicon system controller
+
+Required properties:
+- compatible : "hisilicon,sysctrl"
+- reg : Register address and size
+
+Optional properties:
+- smp-offset : offset in sysctrl for notifying slave cpu booting
+		cpu 1, reg;
+		cpu 2, reg + 0x4;
+		cpu 3, reg + 0x8;
+		If reg value is not zero, cpun exit wfi and go
+- resume-offset : offset in sysctrl for notifying cpu0 when resume
+- reboot-offset : offset in sysctrl for system reboot
+
+Example:
+
+	/* for Hi3620 */
+	sysctrl: system-controller@fc802000 {
+		compatible = "hisilicon,sysctrl";
+		reg = <0xfc802000 0x1000>;
+		smp-offset = <0x31c>;
+		resume-offset = <0x308>;
+		reboot-offset = <0x4>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 54f423d87a80a6a..ffe760a636b5e7f 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -55,197 +55,3 @@ Required root node properties:
 HiP07 D05 Board
 Required root node properties:
 	- compatible = "hisilicon,hip07-d05";
-
-Hisilicon system controller
-
-Required properties:
-- compatible : "hisilicon,sysctrl"
-- reg : Register address and size
-
-Optional properties:
-- smp-offset : offset in sysctrl for notifying slave cpu booting
-		cpu 1, reg;
-		cpu 2, reg + 0x4;
-		cpu 3, reg + 0x8;
-		If reg value is not zero, cpun exit wfi and go
-- resume-offset : offset in sysctrl for notifying cpu0 when resume
-- reboot-offset : offset in sysctrl for system reboot
-
-Example:
-
-	/* for Hi3620 */
-	sysctrl: system-controller@fc802000 {
-		compatible = "hisilicon,sysctrl";
-		reg = <0xfc802000 0x1000>;
-		smp-offset = <0x31c>;
-		resume-offset = <0x308>;
-		reboot-offset = <0x4>;
-	};
-
------------------------------------------------------------------------
-Hisilicon Hi3798CV200 Peripheral Controller
-
-The Hi3798CV200 Peripheral Controller controls peripherals, queries
-their status, and configures some functions of peripherals.
-
-Required properties:
-- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
-  and "simple-mfd".
-- reg: Register address and size of Peripheral Controller.
-- #address-cells: Should be 1.
-- #size-cells: Should be 1.
-
-Examples:
-
-	perictrl: peripheral-controller@8a20000 {
-		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
-			     "simple-mfd";
-		reg = <0x8a20000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-
------------------------------------------------------------------------
-Hisilicon Hi6220 system controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-sysctrl"
-- reg : Register address and size
-- #clock-cells: should be set to 1, many clock registers are defined
-  under this controller and this property must be present.
-
-Hisilicon designs this controller as one of the system controllers,
-its main functions are the same as Hisilicon system controller, but
-the register offset of some core modules are different.
-
-Example:
-	/*for Hi6220*/
-	sys_ctrl: sys_ctrl@f7030000 {
-		compatible = "hisilicon,hi6220-sysctrl", "syscon";
-		reg = <0x0 0xf7030000 0x0 0x2000>;
-		#clock-cells = <1>;
-	};
-
-
-Hisilicon Hi6220 Power Always ON domain controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-aoctrl"
-- reg : Register address and size
-- #clock-cells: should be set to 1, many clock registers are defined
-  under this controller and this property must be present.
-
-Hisilicon designs this system controller to control the power always
-on domain for mobile platform.
-
-Example:
-	/*for Hi6220*/
-	ao_ctrl: ao_ctrl@f7800000 {
-		compatible = "hisilicon,hi6220-aoctrl", "syscon";
-		reg = <0x0 0xf7800000 0x0 0x2000>;
-		#clock-cells = <1>;
-	};
-
-
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
-
-
-Hisilicon Hi6220 Power Management domain controller
-
-Required properties:
-- compatible : "hisilicon,hi6220-pmctrl"
-- reg : Register address and size
-- #clock-cells: should be set to 1, some clock registers are define
-  under this controller and this property must be present.
-
-Hisilicon designs this system controller to control the power management
-domain for mobile platform.
-
-Example:
-	/*for Hi6220*/
-	pm_ctrl: pm_ctrl@f7032000 {
-		compatible = "hisilicon,hi6220-pmctrl", "syscon";
-		reg = <0x0 0xf7032000 0x0 0x1000>;
-		#clock-cells = <1>;
-	};
-
------------------------------------------------------------------------
-Hisilicon HiP01 system controller
-
-Required properties:
-- compatible : "hisilicon,hip01-sysctrl"
-- reg : Register address and size
-
-The HiP01 system controller is mostly compatible with hisilicon
-system controller,but it has some specific control registers for
-HIP01 SoC family, such as slave core boot, and also some same
-registers located at different offset.
-
-Example:
-
-	/* for hip01-ca9x2 */
-	sysctrl: system-controller@10000000 {
-		compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
-		reg = <0x10000000 0x1000>;
-		reboot-offset = <0x4>;
-	};
-
------------------------------------------------------------------------
-Hisilicon CPU controller
-
-Required properties:
-- compatible : "hisilicon,cpuctrl"
-- reg : Register address and size
-
-The clock registers and power registers of secondary cores are defined
-in CPU controller, especially in HIX5HD2 SoC.
-
------------------------------------------------------------------------
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
-
------------------------------------------------------------------------
-Fabric:
-
-Required Properties:
-- compatible: "hisilicon,hip04-fabric";
-- reg: Address and size of Fabric
-
------------------------------------------------------------------------
-Bootwrapper boot method (software protocol on SMP):
-
-Required Properties:
-- compatible: "hisilicon,hip04-bootwrapper";
-- boot-method: Address and size of boot method.
-  [0]: bootwrapper physical address
-  [1]: bootwrapper size
-  [2]: relocation physical address
-  [3]: relocation size
-- 
1.8.3


