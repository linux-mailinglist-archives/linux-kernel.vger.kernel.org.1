Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949FF2BA9E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKTMO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:14:58 -0500
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com ([40.107.21.62]:59361
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbgKTMO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:14:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyuP0oH97IfSbkNweRyfvzGcQE0gL7XGTuALtpIu8CruGlIsK0Fng3Fti4L3zeZpe7o4KakCA9rT/6ZrnSlkY1b9NVMC7nyRpgN7GANrSMHgwDqaGImWdt/ZQybVZCFN79kMYpIlMDkRtGfRSk6BGyfFOHmgqaLGOn7CZf3OlQrIcHyPw957qrKPAlDRuVbSveWJRf8wjKdcsk36RGncJYM3rizac6dVAMeBaeT6vai780wqS3TC0FKN5poN4BcxXAZhLdai7gVjfCA9YxPcU/DES7DVYeTUorsgqb5CvliN6kVAQibwhGeZkUQ6bEFeeVBpaNzM21lzZV+j0+vYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOoYeYsIv8iarCAy0+j8YZf2VXqyhzS/J9RK04gfYEw=;
 b=IAvuPAr3dKAtAMa/z5aJl1AS62wUhYHnR6oqeQJXZRVSGRuYCWhrFzXjrAoL+QoOLq1oSDOHQD3rjdWWNPrwKSulZvUnQbuHc2/p27gsDZy+pdp9lipeMt4W0FDW41jEvN+eQa6C6XmHgQDjjBySquRemiw9ZHMm+HytF+FqWFsx88ssC/g8qokHP76vz6RdyvWbQnXV5hpNl5Po5WUk1Zy5zSCuggQKW3PqlFZu6A/TyCGOFsnECmSoTxaBDNIDyovf7MKIxo5UIDE6c9BO9jxH58hXpthN1v0LwjFikkKm0ylIrL7Q8tb6DKn/Qdn02MJ2Ka1EgsAcHCex3gvyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOoYeYsIv8iarCAy0+j8YZf2VXqyhzS/J9RK04gfYEw=;
 b=G4h5opZJtfLAeYnPTM6S06wEZv96EZMw/aJ26UXvcErVgK9WS/2dHOadn9za/r+BbmKsCWK1zqmbj36GHuuxy+4kYFoXkk+fXcfDPNPPE6U3jv1cn1kXVunJH+VduUZb8hGRXcOLSHEWk/T+PcU8uRLFXyCCdwFUWYpoN6jff9g=
Received: from AM6P192CA0064.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::41)
 by DB8PR10MB2875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 12:14:53 +0000
Received: from AM5EUR02FT046.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::3f) by AM6P192CA0064.outlook.office365.com
 (2603:10a6:209:82::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 12:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT046.mail.protection.outlook.com (10.152.8.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 12:14:51 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Nov 2020 13:14:51 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 EEC7E3FBE0; Fri, 20 Nov 2020 12:14:50 +0000 (GMT)
Message-ID: <a5a57b416a47c044797d9b669c7e021acd69abae.1605868780.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1605868780.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <adam.ward@diasemi.com>
Date:   Fri, 20 Nov 2020 12:14:50 +0000
Subject: [PATCH 1/9] regulator: Update DA9121 dt-bindings
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 721348b5-23c0-4558-0c3b-08d88d4de23a
X-MS-TrafficTypeDiagnostic: DB8PR10MB2875:
X-Microsoft-Antispam-PRVS: <DB8PR10MB2875EA2C62B9E5D18859CB15CBFF0@DB8PR10MB2875.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3e0nNe4+jK/0BSE/fWUh4oQ/xzgqYOEdtJ1VhUw5YVkOCfF4sZ3pOt6jk8TtuCxMsQzp3FFZe6HH0CmR5D/aRP8LFG/O303zt6C0oLaKsogEpj0unBgwG/DLlGOdN33Zmw5CosdDycu502ZaloI4Imi59mSVxJP9tdDD4YIflF1CCWa2UCYwS6nbiIMDlLjnvTjACZ+G2HknQVavpGNmkKVZAgp+JZ4vesW1J4vtT9mniS7ocI8RmPttA1F5KD7xNLRz31N1GPTFuAFJu6e8gzcmfsIZ10YifKOMzIdqpKIpr5HzSYboID0GZ9WBh3Gja3pVFstNYRGFhkT4cgg//tVgG8ypywNP+VIgdhHRIa8bVazCs0gmBdeW+mynUm20OBcO7pX7nEjWOGRE3Dsx8SpT4ski/XeUte1WAWE4h69wI1r4VgIow5rAILOX3FxIN53g702pEyJJwypq2f0PWNRPV2mI/5bFiO1QbvkGH/h9aRW9L4O0UOq+rLxGOeT
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(36756003)(15650500001)(6266002)(478600001)(70206006)(4326008)(5660300002)(966005)(70586007)(8676002)(8936002)(82740400003)(2616005)(2906002)(33310700002)(44832011)(82310400003)(54906003)(316002)(47076004)(83380400001)(81166007)(110136005)(356005)(186003)(36906005)(26005)(426003)(336012)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 12:14:51.7718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721348b5-23c0-4558-0c3b-08d88d4de23a
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT046.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2875
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update bindings for the Dialog Semiconductor DA9121 voltage regulator to add device variants.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 .../devicetree/bindings/regulator/dlg,da9121.yaml  | 177 +++++++++++++++++++--
 MAINTAINERS                                        |   2 +
 .../dt-bindings/regulator/dlg,da9121-regulator.h   |  22 +++
 3 files changed, 185 insertions(+), 16 deletions(-)
 create mode 100644 include/dt-bindings/regulator/dlg,da9121-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index cde0d82..1bd177d 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -8,40 +8,185 @@ title: Dialog Semiconductor DA9121 voltage regulator
 
 maintainers:
   - Vincent Whitchurch <vincent.whitchurch@axis.com>
+  - Adam Ward <adam.ward@disasemi.com>
+
+description: |
+  Dialog Semiconductor DA9121 Single-channel 10A double-phase buck converter
+  Dialog Semiconductor DA9122 Double-channel  5A single-phase buck converter
+  Dialog Semiconductor DA9220 Double-channel  3A single-phase buck converter
+  Dialog Semiconductor DA9217 Single-channel  6A double-phase buck converter
+  Dialog Semiconductor DA9130 Single-channel 10A double-phase buck converter
+  Dialog Semiconductor DA9131 Double-channel  5A single-phase buck converter
+  Dialog Semiconductor DA9132 Double-channel  3A single-phase buck converter
+
+  Current limits
+
+  This is PER PHASE, and the current limit setting in the devices reflect
+  that with a maximum 10A limit. Allowing for transients at/near double
+  the rated current, this translates across the device range to per
+  channel figures as so...
+
+                               | DA9121    DA9122     DA9220    DA9217   DA9140
+                               | /DA9130   /DA9131    /DA9132
+    -----------------------------------------------------------------------------
+    Output current / channel   | 10000000   5000000   3000000   6000000  40000000
+    Output current / phase     |  5000000   5000000   3000000   3000000   9500000
+    -----------------------------------------------------------------------------
+    Min regulator-min-microvolt|   300000    300000    300000    300000    500000
+    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000   1000000
+    Device hardware default    |  1000000   1000000   1000000   1000000   1000000
+    -----------------------------------------------------------------------------
+    Min regulator-min-microamp |  7000000   3500000   3500000   7000000  26000000
+    Max regulator-max-microamp | 20000000  10000000   6000000  12000000  78000000
+    Device hardware default    | 15000000   7500000   5500000  11000000  58000000
 
 properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
   compatible:
-    const: dlg,da9121
+    enum:
+      - dlg,da9121
+      - dlg,da9122
+      - dlg,da9220
+      - dlg,da9217
+      - dlg,da9130
+      - dlg,da9131
+      - dlg,da9132
+      - dlg,da9140
 
   reg:
     maxItems: 1
+    description: Specifies the I2C slave address.
 
-  buck1:
-    description:
-      Initial data for the Buck1 regulator.
-    $ref: "regulator.yaml#"
+  interrupt-parent:
+    maxItems: 1
+    description: Specifies the reference to the interrupt controller.
+
+  interrupts:
+    maxItems: 1
+    description: IRQ line information.
+
+  dlg,irq-polling-delay-passive:
+    maxItems: 1
+    description: |
+      Specify the polling period, measured in milliseconds, between interrupt status
+      update checks. Range 1000-10000 ms.
+
+  regulators:
     type: object
+    $ref: regulator.yaml#
+    description: |
+      This node defines the settings for the BUCK. The content of the
+      sub-node is defined by the standard binding for regulators; see regulator.yaml.
+      The DA9121 regulator is bound using their names listed below
+      buck1 - BUCK1
+      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
+
+    patternProperties:
+      "^buck([0-1])$":
+        type: object
+        $ref: regulator.yaml#
+
+    properties:
+      regulator-mode:
+        maxItems: 1
+        description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+
+      regulator-initial-mode:
+        maxItems: 1
+        description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
 
-unevaluatedProperties: false
+      enable-gpios:
+        maxItems: 1
+        description: Specify a valid GPIO for platform control of the regulator
+
+      dlg,ripple-cancel:
+        maxItems: 1
+        description: |
+          Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+          Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)
+
+    additionalProperties: false
 
 required:
   - compatible
   - reg
+  - regulators
+
+additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/dlg,da9121-regulator.h>
     i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      regulator@68 {
-        compatible = "dlg,da9121";
-        reg = <0x68>;
-
-        buck1 {
-          regulator-min-microvolt = <680000>;
-          regulator-max-microvolt = <820000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic: da9121@68 {
+            compatible = "dlg,da9121";
+            reg = <0x68>;
+
+            interrupt-parent = <&gpio6>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+            dlg,irq-polling-delay-passive = <2000>;
+
+            regulators {
+                DA9121_BUCK1: buck1 {
+                    regulator-name = "BUCK1";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1900000>;
+                    regulator-min-microamp = <7000000>;
+                    regulator-max-microamp = <20000000>;
+                    regulator-boot-on;
+                    regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
+                    enable-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+                };
+            };
         };
-      };
     };
 
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/dlg,da9121-regulator.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic: da9122@68 {
+            compatible = "dlg,da9122";
+            reg = <0x68>;
+
+            interrupt-parent = <&gpio6>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+            dlg,irq-polling-delay-passive = <2000>;
+
+            regulators {
+                DA9122_BUCK1: buck1 {
+                    regulator-name = "BUCK1";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1900000>;
+                    regulator-min-microamp = <3500000>;
+                    regulator-max-microamp = <10000000>;
+                    regulator-boot-on;
+                    regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
+                    enable-gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
+                    dlg,ripple-cancel = <DA9121_BUCK_RIPPLE_CANCEL_NONE>;
+                };
+                DA9122_BUCK2: buck2 {
+                    regulator-name = "BUCK2";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1900000>;
+                    regulator-min-microamp = <3500000>;
+                    regulator-max-microamp = <10000000>;
+                    regulator-boot-on;
+                    regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
+                    enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
+                    dlg,ripple-cancel = <DA9121_BUCK_RIPPLE_CANCEL_NONE>;
+                };
+            };
+        };
+    };
 ...
diff --git a/MAINTAINERS b/MAINTAINERS
index 00584ca..622acba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5122,6 +5122,7 @@ S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
+F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
@@ -5146,6 +5147,7 @@ F:	drivers/rtc/rtc-da90??.c
 F:	drivers/thermal/da90??-thermal.c
 F:	drivers/video/backlight/da90??_bl.c
 F:	drivers/watchdog/da90??_wdt.c
+F:	include/dt-bindings/regulator/dlg,da9*-regulator.h
 F:	include/linux/mfd/da903x.h
 F:	include/linux/mfd/da9052/
 F:	include/linux/mfd/da9055/
diff --git a/include/dt-bindings/regulator/dlg,da9121-regulator.h b/include/dt-bindings/regulator/dlg,da9121-regulator.h
new file mode 100644
index 0000000..954edf6
--- /dev/null
+++ b/include/dt-bindings/regulator/dlg,da9121-regulator.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _DT_BINDINGS_REGULATOR_DLG_DA9121_H
+#define _DT_BINDINGS_REGULATOR_DLG_DA9121_H
+
+/*
+ * These buck mode constants may be used to specify values in device tree
+ * properties (e.g. regulator-initial-mode).
+ * A description of the following modes is in the manufacturers datasheet.
+ */
+
+#define DA9121_BUCK_MODE_FORCE_PFM		0
+#define DA9121_BUCK_MODE_FORCE_PWM		1
+#define DA9121_BUCK_MODE_FORCE_PWM_SHEDDING	2
+#define DA9121_BUCK_MODE_AUTO			3
+
+#define DA9121_BUCK_RIPPLE_CANCEL_NONE		0
+#define DA9121_BUCK_RIPPLE_CANCEL_SMALL		1
+#define DA9121_BUCK_RIPPLE_CANCEL_MID		2
+#define DA9121_BUCK_RIPPLE_CANCEL_LARGE		3
+
+#endif
-- 
1.9.1

