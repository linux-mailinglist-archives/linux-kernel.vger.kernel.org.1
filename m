Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456822C8A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgK3RAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:04 -0500
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:14955
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbgK3RAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIsevt8M4lRaBXnuZ74gR4rcfo6ABzb/vGW7tlZwNPXlxDxnpb3aInKWnqM5C7NshX1g410IHZiawK/okrpKBqFAI4wB2B845dsHhQP2pol3b4VV4HTTaGuUJRcGL2nVIQONcdsL2yKH+2BNqseLrKSk17BttvDZ6oC6+lBz41+BOitmzGLGR20MDE7pcdKoaj4aeQzeXDMNSkf1OFTRMKDDfaHXBpsIVnlSutP6+22woEQbTyHvVhlORT3eH8gDIT1ZqjVTp53XHm3DfFS9qIk/DKYC2TXZ3MewOw2DOXzHI9CdWfmNLcggjca4k8zy96CQklOYqo8sctD1rW+FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzpfLVrhA+uuFr6IFU0fNd99lFWmJ7HqXAAv1pea1/4=;
 b=Q1ThKOrHMJNzjb//453ml0LFvWoRytm7DLFx4GbRzlqtwwimgHYUMc62BL/LPeI05aEKzDNAmxn0wq4pYUL/9esbXotMOUKgqd7hjGupikACodWkQU9jqvjnztlTmhh0RPE+R/U9ExvzN5nnn1Kyg36DHiM4x2Gy0q9ituQ5h3+kBJX/aM09O0HW34mpz5K9eBfbZzDsQR6Ykn9IXoA0f9JRR9QKfcqrZDAHWQVnYDRrIAB/uCVeqMesG9aYJotqlSRqkpYqaNj49IWmLuvmaVN9Wcxkgavt9JwZ6nChu/ZjHlpR3CcJlxy6QZfTIimLVfUbwIHE3SaiYEanjLmRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzpfLVrhA+uuFr6IFU0fNd99lFWmJ7HqXAAv1pea1/4=;
 b=eGDE8OgoBHaGgfugxPXL9NphevxiXbJH5VfwXTFx78+7JLVHTI9V+Gw1nzuxlUrQU7gMRVZ7tZiZnCokBX2BZBaEoN+EOk6teICgPxOnqIQixOxkY4G+yx85ZSLBJQ/JzeiKw+DFS52zhKOl8JMf/TynTju7LTbwTRJ/as/nvsA=
Received: from AM6PR0502CA0050.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::27) by PA4PR10MB4477.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:bf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 16:59:11 +0000
Received: from VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::da) by AM6PR0502CA0050.outlook.office365.com
 (2603:10a6:20b:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Mon, 30 Nov 2020 16:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT054.mail.protection.outlook.com (10.152.13.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Mon, 30 Nov 2020 16:59:11 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 30 Nov 2020 17:59:05 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 AFC883FBE4; Mon, 30 Nov 2020 16:59:05 +0000 (GMT)
Message-ID: <0606d3ded5fef4c38760246146f197db4ce3a374.1606755367.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 30 Nov 2020 16:59:05 +0000
Subject: [PATCH V3 01/10] regulator: Update DA9121 dt-bindings
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b8a44c5-e9d1-4c6a-8684-08d8955142a5
X-MS-TrafficTypeDiagnostic: PA4PR10MB4477:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4477785F14E1203E4C731857CBF50@PA4PR10MB4477.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK6Taqz9swarFh7oWntHqXJXxm+5YPgWRI/RVzv3s6oevDLYvRb/mshqhaMSRib54oP61g3l2nr6jaNqjbSGkZ1LCbE+ynMunFhCa18EOOcmegy2fQGSC6jhECaTWSyI3bcK/LKR/5K2WDNx1m252uL0xVu7580jmOEcys8N+/LO+z7gxOnLnhLlaU9JeRHCAroiwe7Ww17Lo3m0p3TGOM1fRPr48YvYO1KNBOGKsiinabMpg9XifVURKqTWQmd9GJsU2aLGqEFzfBEobFp5ygMmsywyZpw0DvRQ+CeJJJemI08RbWA/GcO4ZSMpfuhGOKVPNMkQ/A4PDZo98T7IAPWenWTcnczzflK7VV3xBlRiNWeI2lSEQIOvNq/FN89CHrfwb8IDQcRGDm0wG5EP6lQPiZY43wVVL/xc2js0jFYIwYdF1EjpIgt4Gzqq+Jnw0c8S6UG8671N/z7m+fQNzjlbWK2plKydq2e+EPuX63Q=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(82310400003)(966005)(36756003)(5660300002)(70586007)(83380400001)(478600001)(8936002)(4326008)(15650500001)(6266002)(70206006)(107886003)(2906002)(8676002)(82740400003)(86362001)(316002)(81166007)(356005)(336012)(110136005)(186003)(54906003)(2616005)(42186006)(426003)(47076004)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 16:59:11.3260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8a44c5-e9d1-4c6a-8684-08d8955142a5
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4477
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update bindings for the Dialog Semiconductor DA9121 voltage regulator to
add device variants.
Because several variants have multiple regulators, and to regard potential
to add GPIO support in future, the 'regulators' sub-node is added,
following the precedent set by other multi-regulator devices, including
the DA9211 family. This breaks compatibility with the original submission
by Vincent Whitchurch - but as this is still in for-next, the alignment
could be made before upstreaming occurs.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 .../devicetree/bindings/regulator/dlg,da9121.yaml  | 164 +++++++++++++++++++--
 MAINTAINERS                                        |   2 +
 .../dt-bindings/regulator/dlg,da9121-regulator.h   |  22 +++
 3 files changed, 177 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/regulator/dlg,da9121-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 2ece46e..6f2164f 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -7,41 +7,183 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Dialog Semiconductor DA9121 voltage regulator
 
 maintainers:
-  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+  - Adam Ward <Adam.Ward.opensource@diasemi.com>
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
+
+  interrupts:
+    maxItems: 1
+    description: IRQ line information.
+
+  dlg,irq-polling-delay-passive-ms:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1000
+    maximum: 10000
+    description: |
+      Specify the polling period, measured in milliseconds, between interrupt status
+      update checks. Range 1000-10000 ms.
 
-  buck1:
-    description:
-      Initial data for the Buck1 regulator.
-    $ref: "regulator.yaml#"
+  regulators:
     type: object
+    $ref: regulator.yaml#
+    description: |
+      This node defines the settings for the BUCK. The content of the
+      sub-node is defined by the standard binding for regulators; see regulator.yaml.
+      The DA9121 regulator is bound using their names listed below
+      buck1 - BUCK1
+      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
 
-additionalProperties: false
+    patternProperties:
+      "^buck([1-2])$":
+        type: object
+        $ref: regulator.yaml#
+
+        properties:
+          regulator-mode:
+            maxItems: 1
+            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+
+          regulator-initial-mode:
+            maxItems: 1
+            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+
+          enable-gpios:
+            maxItems: 1
+            description: Specify a valid GPIO for platform control of the regulator
+
+          dlg,ripple-cancel:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            description: |
+              Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+              Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)
+
+        unevaluatedProperties: false
 
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
       #address-cells = <1>;
       #size-cells = <0>;
-      regulator@68 {
+      pmic@68 {
         compatible = "dlg,da9121";
         reg = <0x68>;
 
-        buck1 {
-          regulator-min-microvolt = <680000>;
-          regulator-max-microvolt = <820000>;
+        interrupt-parent = <&gpio6>;
+        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+        dlg,irq-polling-delay-passive-ms = <2000>;
+
+        regulators {
+          DA9121_BUCK1: buck1 {
+            regulator-name = "BUCK1";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1900000>;
+            regulator-min-microamp = <7000000>;
+            regulator-max-microamp = <20000000>;
+            regulator-boot-on;
+            regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
+            enable-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+          };
         };
       };
     };
 
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/dlg,da9121-regulator.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@68 {
+        compatible = "dlg,da9122";
+        reg = <0x68>;
+
+        interrupt-parent = <&gpio6>;
+        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+
+        dlg,irq-polling-delay-passive-ms = <2000>;
+
+        regulators {
+          DA9122_BUCK1: buck1 {
+            regulator-name = "BUCK1";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1900000>;
+            regulator-min-microamp = <3500000>;
+            regulator-max-microamp = <10000000>;
+            regulator-boot-on;
+            regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
+            enable-gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
+            dlg,ripple-cancel = <DA9121_BUCK_RIPPLE_CANCEL_NONE>;
+          };
+          DA9122_BUCK2: buck2 {
+            regulator-name = "BUCK2";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1900000>;
+            regulator-min-microamp = <3500000>;
+            regulator-max-microamp = <10000000>;
+            regulator-boot-on;
+            regulator-initial-mode = <DA9121_BUCK_MODE_AUTO>;
+            enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
+            dlg,ripple-cancel = <DA9121_BUCK_RIPPLE_CANCEL_NONE>;
+          };
+        };
+      };
+    };
 ...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9bff945..1e5b756 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5118,6 +5118,7 @@ S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
+F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
@@ -5142,6 +5143,7 @@ F:	drivers/rtc/rtc-da90??.c
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

