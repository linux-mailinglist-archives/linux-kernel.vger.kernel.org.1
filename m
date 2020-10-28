Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6B29E204
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgJ2CFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:05:24 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42286 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727100AbgJ1Vif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:35 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09SF497F004985;
        Wed, 28 Oct 2020 08:22:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=tq7yBnvDxNGm8iUhmUfjginyy01MbJ3pPzoglT8ekqk=;
 b=FfDUVZXwGSIf565WycX//IwXRINFW/Tsr9i64lyDiqhzokYhCYp45mpblgyG6ShI8cj6
 p0COHRJ7bOrfT66maj4I6NsRXeh68llY8RunGEqwlA8wKS2jD0uzYZhNJBAcIgaNAgdX
 po0Yg52o/DI8bSjDpSXROULlKTi78eubdeGMZYIyk99sR2iB+6exISjTyZAdsD9VXN5H
 L5VrNqk5cViAIUDpPfdBvXa9XTIv0yJUo/kSEGQhRvxOc+jX/IXkSfIhzXgngkG6ZRA8
 9vXpgrvED83uBO5RPdywxA30Rncoer5uJDxDBQVUBIrKBVHpbSaEzujYLKi+Yr+jcB+e 1A== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34cfux8vc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 08:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqCLe+7SKiHYDOQy4XFQZaEo/NkyFXJ/2S6BfEqn8cJLuucTv8qjj/Hj1k/X9U18itLAD92ZUnmuTFKW9SjJxKbtXukA7XycgPMZGrBNe3SSnhTqSQivSJUU4ymoVDJVEtQiOACLZhlWkJYso4L2J9CG/B+yS94Dlgwz4hYsfvMHzC7axNCl6n/7IMjv6mxwHJB0dO3p1est7zi3RF9tJSjfCEmYHl+l8Wy+ncKjyxRDjwgqGLNEFnuwvkOAHduxHLzd4KZYY538agXHSbGpNfowc+v7yaugXoQnY4Q+7R02vomsHVa+R/F+Q1t9/alzpKf8280Yx7FWDGTx8o1eoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq7yBnvDxNGm8iUhmUfjginyy01MbJ3pPzoglT8ekqk=;
 b=BAOEtCQH6rYKBdF6zLHyexDhSl71Z78FJHTog49LRShJLEg0XWvlGXsKeSzj83s+/swwfJGTldBRlDbSJoUtkU3cTIyyeotcg2A1PrPHJ6DojOsJSLt9BM6tsLDVuGjhcIycr/YPQMgGAfm9Dvnlc5hjFDdaw99Qb1/NGB58a9RwQjdPmuNE0rX4aty2BBvZ9q0DkzHRHxTNx0hc2dbDAnhUWoFWHXGJTi1VblLWGHCQ5nkGnaOpuIe+cVD1d7Y2mzXa26+kzevECWP1p7jiGqJPvm9YfKN/tC4nhwm3WCKjJ9DRJatTSIXrJOYeh+904FttZ+sWDwv92slZmFFl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq7yBnvDxNGm8iUhmUfjginyy01MbJ3pPzoglT8ekqk=;
 b=KC/swBtrmLr4Ex+M0hE/fq0X1ITmQvVxqV7ryVa0eVxoQjCpQ0F/9LW5q/AHyaGKMT03keoWqrBDFxawHRjf1yhoYjKkc/idhMtW40IC7py77pampmxql4WgrwMIpuroJ/EjSXPpGdtwXoxKkTIbHICTethF4vhi0uAgVfziIFg=
Received: from BN6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:405:6f::17)
 by MN2PR07MB7229.namprd07.prod.outlook.com (2603:10b6:208:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 15:22:46 +0000
Received: from BN8NAM12FT057.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::38) by BN6PR03CA0079.outlook.office365.com
 (2603:10b6:405:6f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 28 Oct 2020 15:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT057.mail.protection.outlook.com (10.13.182.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.9 via Frontend Transport; Wed, 28 Oct 2020 15:22:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 09SFMg2E150905
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 08:22:44 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 28 Oct 2020 16:22:41 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 28 Oct 2020 16:22:41 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09SFMfgZ005180;
        Wed, 28 Oct 2020 16:22:41 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09SFMffE005179;
        Wed, 28 Oct 2020 16:22:41 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH] dt-bindings: phy: Add Cadence Sierra PHY bindings in YAML format
Date:   Wed, 28 Oct 2020 16:22:41 +0100
Message-ID: <1603898561-5142-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb334b1-3901-49ac-3694-08d87b555246
X-MS-TrafficTypeDiagnostic: MN2PR07MB7229:
X-Microsoft-Antispam-PRVS: <MN2PR07MB72291BE6E1E821207E1C9AC5C5170@MN2PR07MB7229.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBlZhwg9DqwqpaA7r8O5A0b8/xpUJOUAjVnB6hmrWRoSbil95qYpM0fWqrRkGBRgRXlzLETzgc5nR14i4zfSmIlgkwayxE+PMyx5aR2GtgY/f2ZTma6D1w9QlrUWhZPbfi8vQliJQrsDo+i50K6qE86hEqSl416vmzdB5yVAfyEipXGdYUxM+DXRcbLWHej6J5tbB/1Et8IXoOjeuN6CutOOZQWBlyPYSc4xvlbnc9qqZQevWRN6+pqkyF8RWXyKUJDiJ2kE8FEGuZN6e7wCEZxCuqV7p8nZc/0Y4StBNMK5unD9GfLGhxjnSD7PdFPXEur9cktIfgdzuhb/1k0FWFNCfRFeZbClPqz8C/B58x54lmzx4VDG0mnVBUnwuVgMBQWywYwGnIO+QENeDWDGWaRaH4LKJayiX4WaebjR4oLVvGtD6MKKst9GcEswqxDKg5kY7Z/eqtLi3g8cwrUWAz+PhvlAEWT7wT0ftgXkWEgKyJo2gEPvFrdZMXO5QU64
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36092001)(46966005)(478600001)(82740400003)(316002)(70206006)(42186006)(70586007)(2906002)(2616005)(82310400003)(8676002)(426003)(83380400001)(110136005)(4326008)(36906005)(336012)(5660300002)(26005)(47076004)(86362001)(36756003)(186003)(54906003)(8936002)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 15:22:45.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb334b1-3901-49ac-3694-08d87b555246
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT057.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7229
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_07:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cadence Sierra PHY bindings in YAML format.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../bindings/phy/phy-cadence-sierra.txt       |  70 --------
 .../bindings/phy/phy-cadence-sierra.yaml      | 152 ++++++++++++++++++
 2 files changed, 152 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
deleted file mode 100644
index 03f5939d3d19..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Cadence Sierra PHY
------------------------
-
-Required properties:
-- compatible:	Must be "cdns,sierra-phy-t0" for Sierra in Cadence platform
-		Must be "ti,sierra-phy-t0" for Sierra in TI's J721E SoC.
-- resets:	Must contain an entry for each in reset-names.
-		See ../reset/reset.txt for details.
-- reset-names:	Must include "sierra_reset" and "sierra_apb".
-		"sierra_reset" must control the reset line to the PHY.
-		"sierra_apb" must control the reset line to the APB PHY
-		interface ("sierra_apb" is optional).
-- reg:		register range for the PHY.
-- #address-cells: Must be 1
-- #size-cells:	Must be 0
-
-Optional properties:
-- clocks:		Must contain an entry in clock-names.
-			See ../clocks/clock-bindings.txt for details.
-- clock-names:		Must contain "cmn_refclk_dig_div" and
-			"cmn_refclk1_dig_div" for configuring the frequency of
-			the clock to the lanes. "phy_clk" is deprecated.
-- cdns,autoconf:	A boolean property whose presence indicates that the
-			PHY registers will be configured by hardware. If not
-			present, all sub-node optional properties must be
-			provided.
-
-Sub-nodes:
-  Each group of PHY lanes with a single master lane should be represented as
-  a sub-node. Note that the actual configuration of each lane is determined by
-  hardware strapping, and must match the configuration specified here.
-
-Sub-node required properties:
-- #phy-cells:	Generic PHY binding; must be 0.
-- reg:		The master lane number.  This is the lowest numbered lane
-		in the lane group.
-- resets:	Must contain one entry which controls the reset line for the
-		master lane of the sub-node.
-		See ../reset/reset.txt for details.
-
-Sub-node optional properties:
-- cdns,num-lanes:	Number of lanes in this group.  From 1 to 4.  The
-			group is made up of consecutive lanes.
-- cdns,phy-type:	Can be PHY_TYPE_PCIE or PHY_TYPE_USB3, depending on
-			configuration of lanes.
-
-Example:
-	pcie_phy4: pcie-phy@fd240000 {
-		compatible = "cdns,sierra-phy-t0";
-		reg = <0x0 0xfd240000 0x0 0x40000>;
-		resets = <&phyrst 0>, <&phyrst 1>;
-		reset-names = "sierra_reset", "sierra_apb";
-		clocks = <&phyclock>;
-		clock-names = "phy_clk";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pcie0_phy0: pcie-phy@0 {
-				reg = <0>;
-				resets = <&phyrst 2>;
-				cdns,num-lanes = <2>;
-				#phy-cells = <0>;
-				cdns,phy-type = <PHY_TYPE_PCIE>;
-		};
-		pcie0_phy1: pcie-phy@2 {
-				reg = <2>;
-				resets = <&phyrst 4>;
-				cdns,num-lanes = <1>;
-				#phy-cells = <0>;
-				cdns,phy-type = <PHY_TYPE_PCIE>;
-		};
diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
new file mode 100644
index 000000000000..d210843863df
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/phy-cadence-sierra.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence Sierra PHY binding
+
+description:
+  This binding describes the Cadence Sierra PHY. Sierra PHY supports multilink
+  multiprotocol combinations including protocols such as PCIe, USB etc.
+
+maintainers:
+  - Swapnil Jakhade <sjakhade@cadence.com>
+  - Yuti Amonkar <yamonkar@cadence.com>
+
+properties:
+  compatible:
+    enum:
+      - cdns,sierra-phy-t0
+      - ti,sierra-phy-t0
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  resets:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Sierra PHY reset.
+      - description: Sierra APB reset. This is optional.
+
+  reset-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: sierra_reset
+      - const: sierra_apb
+
+  reg:
+    maxItems: 1
+    description:
+      Offset of the Sierra PHY configuration registers.
+
+  reg-names:
+    const: serdes
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: cmn_refclk_dig_div
+      - const: cmn_refclk1_dig_div
+
+  cdns,autoconf:
+    type: boolean
+    description:
+      A boolean property whose presence indicates that the PHY registers will be
+      configured by hardware. If not present, all sub-node optional properties
+      must be provided.
+
+patternProperties:
+  '^phy@[0-9a-f]$':
+    type: object
+    description:
+      Each group of PHY lanes with a single master lane should be represented as
+      a sub-node. Note that the actual configuration of each lane is determined
+      by hardware strapping, and must match the configuration specified here.
+    properties:
+      reg:
+        description:
+          The master lane number. This is the lowest numbered lane in the lane group.
+        minimum: 0
+        maximum: 15
+
+      resets:
+        minItems: 1
+        maxItems: 4
+        description:
+          Contains list of resets, one per lane, to get all the link lanes out of reset.
+
+      "#phy-cells":
+        const: 0
+
+      cdns,phy-type:
+        description:
+          Specifies the type of PHY for which the group of PHY lanes is used.
+          Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [2, 4]
+
+      cdns,num-lanes:
+        description:
+          Number of lanes in this group. The group is made up of consecutive lanes.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 1
+        maximum: 16
+
+    required:
+      - reg
+      - resets
+      - "#phy-cells"
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        sierra-phy@fd240000 {
+            compatible = "cdns,sierra-phy-t0";
+            reg = <0x0 0xfd240000 0x0 0x40000>;
+            resets = <&phyrst 0>, <&phyrst 1>;
+            reset-names = "sierra_reset", "sierra_apb";
+            clocks = <&cmn_refclk_dig_div>, <&cmn_refclk1_dig_div>;
+            clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            pcie0_phy0: phy@0 {
+                reg = <0>;
+                resets = <&phyrst 2>;
+                cdns,num-lanes = <2>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_PCIE>;
+            };
+            pcie0_phy1: phy@2 {
+                reg = <2>;
+                resets = <&phyrst 4>;
+                cdns,num-lanes = <1>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_PCIE>;
+            };
+        };
+    };
-- 
2.26.1

