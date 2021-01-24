Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69373301F14
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 23:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbhAXWLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 17:11:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8970 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbhAXWLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:11:01 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10OM6JJ8029413;
        Sun, 24 Jan 2021 17:10:18 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 368hk9b1ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 17:10:17 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10OMAGjH065040
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 24 Jan 2021 17:10:16 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 24 Jan 2021 17:10:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Sun, 24 Jan 2021 17:10:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Sun, 24 Jan 2021 17:10:15 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10OMA990001908;
        Sun, 24 Jan 2021 17:10:13 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <petre.minciunescu@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 2/2] dt-bindings: clock: ad9545: Add documentation
Date:   Mon, 25 Jan 2021 00:13:04 +0200
Message-ID: <20210124221304.51007-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210124221304.51007-1-alexandru.tachici@analog.com>
References: <20210124221304.51007-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_10:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101240139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add dt bindings for ad9545.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../devicetree/bindings/clock/clk-ad9545.yaml | 352 ++++++++++++++++++
 1 file changed, 352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-ad9545.yaml

diff --git a/Documentation/devicetree/bindings/clock/clk-ad9545.yaml b/Documentation/devicetree/bindings/clock/clk-ad9545.yaml
new file mode 100644
index 000000000000..3611eaaa145c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clk-ad9545.yaml
@@ -0,0 +1,352 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/clk-ad9545.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588
+
+maintainers:
+  - Alexandru Tachici <alexandru.tachici@analog.com>
+
+description: |
+  Analog Devices AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588,
+  1 pps Synchronizer and Jitter Cleaner
+
+  Relevant documents:
+    [1] ad9545 datasheet:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/ad9545.pdf
+
+    [2] Defines used: include/dt-bindings/clock/ad9545.h
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9545
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#clock-cells":
+    description: |
+      The first cell indicates the clock type and the second number is the clock address (see [2]).
+    const: 2
+
+  reg:
+    description: |
+      I2C address of the secondary device.
+    minimum: 0
+    maximum: 0xFF
+
+  avcc-supply:
+    description: |
+      Phandle to the Avcc power supply.
+
+  adi,freq-doubler:
+    description: |
+      The system clock PLL provides the user with the option of doubling the reference frequency.
+    type: boolean
+
+  adi,ref-crystal:
+    description: |
+      At XOA,XOB there is a crystal connected that needs maintaining.
+      Otherwise it is assumed that there is a TCXO or OCXO connected.
+    type: boolean
+
+  adi,ref-frequency-hz:
+    description: |
+      Reference input frequency at XOA,XOB. This is used for the system clock.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  clocks:
+    items:
+      - description: Ref A clock input
+      - description: Ref AA clock input
+      - description: Ref B clock input
+      - description: Ref BB clock input
+    maxItems: 4
+
+  clock-output-names:
+    minItems: 1
+    maxItems: 10
+
+  assigned-clocks:
+     minItems: 1
+     maxItems: 14
+
+  assigned-clock-rates:
+    description: |
+      Can initialize frequency of the 2 auxiliary NCOs, 2 PLLs and 10 clock outputs.
+      Output clock rates must be one of the divisors of PLL assigned frequency.
+    minItems: 1
+    maxItems: 14
+
+patternProperties:
+  "^ref-input-clk@[0-3]$":
+    description: |
+      Represents a reference clock input.
+    type: object
+
+    properties:
+      reg:
+        description: |
+          The reference input number. It can have up to 4 input clocks numbered from 0 to 3.
+          (mapped: [refa, refaa, refb, refbb] -> [0, 1, 2, 3])
+        maxItems: 1
+
+      adi,single-ended-mode:
+        description: |
+          Single-ended configuration mode.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0, 1, 2, 3]
+        maxItems: 1
+
+      adi,differential-mode:
+        description: |
+          Differential configuration mode.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0, 1, 2]
+        maxItems: 1
+
+      adi,r-divider-ratio:
+        description: |
+          Each reference input has a dedicated divider.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximum: 1073741824
+        maxItems: 1
+
+      adi,ref-dtol-pbb:
+        description: |
+          REFx offset limit. Constitutes a fractional portion of the corresponding nominal period.
+          The 24-bit number represents fractional units of parts per billion (ppb) up to a
+          maximum of approximately 17 million ppb (1.7%).
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 0
+          - maximum: 16777215
+          - default: 100000
+
+      adi,ref-monitor-hysteresis-pbb:
+        description: |
+          Basis points of the offset limit representing per ten thousand of REFx offset limit.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0, 3125, 6250, 12500, 25000, 50000, 75000, 87500]
+          - default: 12500
+
+      adi,ref-validation-timer-ms:
+        description: |
+          Time required for a reference to remain in tolerance condition before being
+          available to be used.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximum: 1048574
+          - default: 10
+
+      adi,freq-lock-threshold-ps:
+        description: |
+          Phase lock detector threshold (in picoseconds).
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximum: 16777215
+        maxItems: 1
+
+      adi,phase-lock-threshold-ps:
+        description: |
+          Profile 0 frequency lock threshold. Frequency lock detector threshold (in picoseconds).
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximum: 16777215
+        maxItems: 1
+
+    required:
+      - reg
+      - adi,r-divider-ratio
+      - adi,ref-dtol-pbb
+      - adi,ref-monitor-hysteresis-pbb
+      - adi,ref-validation-timer-ms
+      - adi,freq-lock-threshold-ps
+      - adi,phase-lock-threshold-ps
+
+  "^pll-clk@[0-1]$":
+    description: |
+      Represents a PLL.
+    type: object
+
+    properties:
+      reg:
+        description: |
+          PLL number. AD9545 has two PLLs.
+        maxItems: 1
+
+      adi,pll-source:
+        description: |
+          Each PLL can have 1 signal source. Choose from Ref-A to Ref-BB [0-3] or aux NCOs [4-5].
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0, 1, 2, 3, 4, 5]
+        maxItems: 1
+
+      adi,pll-loop-bandwidth-hz:
+        description: |
+          PLL loop bandwidth.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximum: 1850
+        maxItems: 1
+
+    required:
+      - reg
+      - adi,pll-source
+      - adi,pll-loop-bandwidth-hz
+
+  "^aux-nco-clk@[0-1]$":
+    description: |
+      Represents an auxiliary Numerical Controlled Oscilator. Generates timestamps that
+      can be sent to the DPLL0 or DPLL1.
+    type: object
+
+    properties:
+      reg:
+        description: |
+          Auxiliary NCO address (see [2]).
+        maxItems: 1
+
+      adi,freq-lock-threshold-ps:
+        description: |
+          Phase lock detector threshold (in picoseconds).
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximum: 16777215
+        maxItems: 1
+
+      adi,phase-lock-threshold-ps:
+        description: |
+          Profile 0 frequency lock threshold. Frequency lock detector threshold (in picoseconds).
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 1
+          - maximum: 16777215
+        maxItems: 1
+
+    required:
+      - reg
+      - adi,freq-lock-threshold-ps
+      - adi,phase-lock-threshold-ps
+
+  "^output-clk@([0-9])$":
+    description: |
+      Represents a clock output.
+    type: object
+
+    properties:
+      reg:
+        description: |
+          The reference input number. It can have up to 10 output clocks mapped:
+          (OUT0AP OUT0AN OUT0BP OUT0BN OUT0CP OUT0CN OUT1AP OUT1AN OUT1BP OUT1BN) ->
+          (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
+        maxItems: 1
+
+      adi,current-source:
+        description: |
+          If specified output is set as current source.
+        type: boolean
+
+      adi,current-source-microamp:
+        description: |
+          The magnitude of the driver current.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [7500, 12500, 15000]
+        minItems: 1
+
+      adi,output-mode:
+        description: |
+          Output driver mode.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0, 1, 2]
+        maxItems: 1
+
+    required:
+      - reg
+      - adi,current-source-microamp
+      - adi,output-mode
+
+  clocks: true
+  assigned-clocks: true
+
+required:
+  - compatible
+  - reg
+  - adi,ref-frequency-hz
+
+"additionalProperties": false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ad9545.h>
+
+    i2c1 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            ad9545_clock: ad9545@4A {
+                compatible = "adi,ad9545";
+                reg = <0x4A>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                adi,ref-crystal;
+                adi,ref-frequency-hz = <49152000>;
+
+                #clock-cells = <2>;
+                clocks = <&ad9545_clock AD9545_CLK_NCO AD9545_NCO0>,
+                         <&ad9545_clock AD9545_CLK_PLL AD9545_PLL1>,
+                         <&ad9545_clock AD9545_CLK_OUT AD9545_Q1A>,
+                         <&ad9545_clock AD9545_CLK_OUT AD9545_Q1B>;
+                assigned-clocks = <&ad9545_clock AD9545_CLK_NCO AD9545_NCO0>,
+                                  <&ad9545_clock AD9545_CLK_PLL AD9545_PLL1>,
+                                  <&ad9545_clock AD9545_CLK_OUT AD9545_Q1A>,
+                                  <&ad9545_clock AD9545_CLK_OUT AD9545_Q1B>;
+                assigned-clock-rates = <10000>, <1875000000>, <156250000>, <156250000>;
+
+                aux-nco-clk@AD9545_NCO0 {
+                        reg = <AD9545_NCO0>;
+                        adi,freq-lock-threshold-ps = <16000000>;
+                        adi,phase-lock-threshold-ps = <16000000>;
+                };
+
+                ad9545_apll1: pll-clk@AD9545_PLL1 {
+                        reg = <AD9545_PLL1>;
+                        adi,pll-source = <4>;
+                        adi,pll-loop-bandwidth-hz = <200>;
+                };
+
+                output-clk@AD9545_Q1A {
+                        reg = <AD9545_Q1A>;
+                        adi,output-mode = <DRIVER_MODE_SINGLE_DIV_DIF>;
+                        adi,current-source-microamp = <15000>;
+                };
+
+                output-clk@AD9545_Q1B {
+                        reg = <AD9545_Q1B>;
+                        adi,output-mode = <DRIVER_MODE_SINGLE_DIV_DIF>;
+                        adi,current-source-microamp = <15000>;
+                };
+            };
+    };
+...
-- 
2.20.1

