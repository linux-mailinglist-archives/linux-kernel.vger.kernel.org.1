Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BA27FBD4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgJAIq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:46:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65514 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgJAIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:46:29 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0918dUZJ028754;
        Thu, 1 Oct 2020 04:46:15 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg6ad4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 04:46:15 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0918kDwA049569
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 1 Oct 2020 04:46:14 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 1 Oct 2020 01:46:04 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 1 Oct 2020 01:46:04 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0918k9Nv015441;
        Thu, 1 Oct 2020 04:46:09 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <michael.hennerich@analog.com>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] dt-bindings: clock: adi,axi-clkgen: convert old binding to yaml format
Date:   Thu, 1 Oct 2020 11:50:35 +0300
Message-ID: <20201001085035.82938-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_02:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the old binding for the AXI clkgen driver to a yaml
format.

As maintainers, added:
 - Lars-Peter Clausen <lars@metafoo.de> - as original author of driver &
   binding
 - Michael Hennerich <michael.hennerich@analog.com> - as supporter of
   Analog Devices drivers

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/clock/adi,axi-clkgen.yaml        | 52 +++++++++++++++++++
 .../devicetree/bindings/clock/axi-clkgen.txt  | 25 ---------
 2 files changed, 52 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/axi-clkgen.txt

diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
new file mode 100644
index 000000000000..45497f370cb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/adi,axi-clkgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for Analog Devices AXI clkgen pcore clock generator
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  The axi_clkgen IP core is a software programmable clock generator,
+  that can be synthesized on various FPGA platforms.
+
+  Link: https://wiki.analog.com/resources/fpga/docs/axi_clkgen
+
+properties:
+  compatible:
+    enum:
+      - adi,axi-clkgen-2.00.a
+
+  clocks:
+    description:
+      Phandle and clock specifier for the parent clock(s). This must either
+      reference one clock if only the first clock input is connected or two
+      if both clock inputs are connected. For the later case the clock
+      connected to the first input must be specified first.
+    minItems: 1
+    maxItems: 2
+
+  '#clock-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+examples:
+  - |
+    clock@ff000000 {
+      compatible = "adi,axi-clkgen-2.00.a";
+      #clock-cells = <0>;
+      reg = <0xff000000 0x1000>;
+      clocks = <&osc 1>;
+    };
diff --git a/Documentation/devicetree/bindings/clock/axi-clkgen.txt b/Documentation/devicetree/bindings/clock/axi-clkgen.txt
deleted file mode 100644
index aca94fe9416f..000000000000
--- a/Documentation/devicetree/bindings/clock/axi-clkgen.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Binding for the axi-clkgen clock generator
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be "adi,axi-clkgen-1.00.a" or "adi,axi-clkgen-2.00.a".
-- #clock-cells : from common clock binding; Should always be set to 0.
-- reg : Address and length of the axi-clkgen register set.
-- clocks : Phandle and clock specifier for the parent clock(s). This must
-	either reference one clock if only the first clock input is connected or two
-	if both clock inputs are connected. For the later case the clock connected
-	to the first input must be specified first.
-
-Optional properties:
-- clock-output-names : From common clock binding.
-
-Example:
-	clock@ff000000 {
-		compatible = "adi,axi-clkgen";
-		#clock-cells = <0>;
-		reg = <0xff000000 0x1000>;
-		clocks = <&osc 1>;
-	};
-- 
2.17.1

