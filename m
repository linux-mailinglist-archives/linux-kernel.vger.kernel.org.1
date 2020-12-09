Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6D52D3B81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgLIGeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:34:15 -0500
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:57952
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgLIGeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:34:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR2B5zcl5I+q8O5wQnu6Wdz/x8ROf6IY5YzHz88iDMPG8N19y6kf70lBR1Akl4oKJE1Rvc3OveJACd9dndIVWNExjXbwJ0z1QIDgV1/uk2GYXPS5Ect15EcoL2uuhsXVQI+kheNN+nJ98r32tqKD6peRK7um54MwBER+VtUsaWhvxIUN6xEHoOPqV6gT5oLRk0b0uk/InmWdCEM52NGahCahQLLg49M182tI+pE80med7i0P4oRK6xE0UdPydpu98QdWvQMx5ue3083gZ35Kb9x4OhSg0OlQBsenj6MofgotVIwNNRPXJyvox2UgKwxUs4i1efTjtzoC4Y/lOtETng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlVIqCF3ResnuFKj8jDnBInEWttMi/afewLrFoCzYy4=;
 b=D7FOnCQ8qjzcYs2Mc9k+xOeu5TZH+2VSEVIqNiOtq2tFome2DueVuEs5ySH5j+934bgYCr+70l6WpqYPCkuhzMYm68NFHU/PC1pkYTP3uAeOj1kuHt2e3OiNGPbLE0al4o3geDZ4lDWGL8TCP7Gyc3BLJ7EB8Dmcpis+auKTJIXX1IGcu3j+h2VvFp/APEF0Vd2AWgYTUQxPgbtF50m3xxse1bFL3Z2rL11A+Ra63Dolfl3O8XWmwk/KlwqexFffWe4Gd5vtRwtwUnoi1WWtFNVF+fzueMDqz2NNRVeK0oxOvZBLMn6+F1IFd+Lu1PPvbitI+3zDvDJSJ854yL+VLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlVIqCF3ResnuFKj8jDnBInEWttMi/afewLrFoCzYy4=;
 b=fEUQU7RQI+WArBmlZ/GNwvM0GZV/4wfiMMe4KYdyJKfL527lCGriBfz6JhFGDwWSYiGHR1dXwhVpQ7C49aJ89mPwp+yiB/Cq5gnrKKmDNQTgk4zpgebcb+TlkHE5ZQ/nKCquvuPHEwZ2Nb5CSxI6P0VJO/pqeSw/uFCzrKERvAs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB6144.eurprd04.prod.outlook.com (2603:10a6:803:fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 06:33:12 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 06:33:12 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: [PATCH v2 3/5] dt-bindings: phy: Convert mixel,mipi-dsi-phy to json-schema
Date:   Wed,  9 Dec 2020 14:24:26 +0800
Message-Id: <1607495069-10946-4-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607495069-10946-1-git-send-email-victor.liu@nxp.com>
References: <1607495069-10946-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0148.apcprd06.prod.outlook.com
 (2603:1096:1:1f::26) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0148.apcprd06.prod.outlook.com (2603:1096:1:1f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 06:33:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa97d772-ec87-404b-5f87-08d89c0c4da5
X-MS-TrafficTypeDiagnostic: VI1PR04MB6144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6144A1CD0F2072BB52382B5F98CC0@VI1PR04MB6144.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckiPI9h8cplZwygdNyDWwmzuNIvMKcthP3hxpFsxSW55Nd82vHYjDfk4fjmKpt+8BCyycF3D06cw77kkOCMvEAJLkYCLGTkhYtjBsHfmS3qhM4qaTaPWJ9LwUP/yxEWIhF5mhJVTYIChDpdAPPA6aaGDWvxYggplrGHcpVkzG3mAcqssY0VVtYqQhTy0QlLDJbvxlOlA7dhMog3FJvoW2yMfy6WRLC8D9Jjx67f87JFQVB1tpleLRTzA8K98D5gwR96wlaFuRkORQ0E06ERtCSDBuQYGVjTuSs7vo/Mvc/SAu+ON2D5nBv885lUiB4aJ+nuYMBF2nfZhEMjsWO4vS1ODuycHytwzhlVfb+PBJUmoC5gAjpZS6HQRQso9zd3i5KjvFIc8tWEDkKoY0p11naRv4yoAQFxAGEqOZFGBKt+TYog5Vsz5577CnYC53AttJEsSO8PCLsao5YDvfoywpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(2616005)(26005)(52116002)(5660300002)(186003)(16526019)(34490700003)(8936002)(8676002)(6486002)(66574015)(6666004)(66476007)(2906002)(7416002)(956004)(36756003)(6512007)(508600001)(66946007)(83380400001)(4326008)(6506007)(86362001)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2htanFNTUZGWm8rU0pjYUIrZUJORWV5THlQSnFXQ0J2c3AxQlE3N0llYlo2?=
 =?utf-8?B?NmhoL3ZjRXprME5WMmhTRkpIdXF2d25makhyNVI4L3FTbGRibTY2Lyt0NDE0?=
 =?utf-8?B?eWk1c2llTXA2NXQ3TzkrRU5MUUVROUwweDlha2RtNUJrWFJQb05HRGRQTng4?=
 =?utf-8?B?NHNnQkVhbFl2bmlxcDFFMFFja0ZkdW8wRXE0RFgrOXpKc0ZueU5wVVJzbXg5?=
 =?utf-8?B?ZmZvT25rN0oveklZdUx5bGdZU0pFTENGN2ZLQS9PVE5rdkNFNkloUnFwdmwy?=
 =?utf-8?B?WDFYamZ5U2FrVk90eW9mYXRkcHRVWVB1dDlKV1F5U0tqOC84L2kwSUxKbjEv?=
 =?utf-8?B?dXBSTUZVTHBuTHVVbzNrM1lOVkFRWXpnT0hZcWVRSU4xTHVQcHJXMU9xUVRo?=
 =?utf-8?B?WDl4WkUwYVFTQlIyNWtjRjJJZG9rSVRDNmJVZDBjOUppdjB6d1F2ckpMcHNO?=
 =?utf-8?B?ODFxUlB1M1NuY21Ga2dmM3hGMmtWUTN4YXJaTmlmbXpXTlliVmtNMUh5L2tw?=
 =?utf-8?B?WDZVY0FtRUNsRFg5bjZQdzBLSVJYcFNhZ3RtcGdOYmVJUHZ3SWxBKzg3clg2?=
 =?utf-8?B?dTdjT3U3REhHUXU0OE9CZTZ5TjkwUlkvWGwxR2pBZnFWWVpJMTlLcDNyZ3JW?=
 =?utf-8?B?T2xER0hTRjRQVWZUQ3J0TnJEcTI0OFpvVzZFNzNPWmJEc0JiYWxCeGg2SXZ3?=
 =?utf-8?B?aExLTEwyUGhwc0RqbFU4ck5mZEN0K0Yrc3VsdTE3UUhaWlBRdVZHZEdmUHBx?=
 =?utf-8?B?K1BVOWRMYlFEeUE3Z3R2bGNmajFheXJaNTBFZDcrSC9YTzdhVEJHU2Z4bnlI?=
 =?utf-8?B?eTU3bXpDeGRZZHVCTkE0bFNUWFFkOGhnS1dCQ3BqTVpFUXdMV1FTWHBkZXk1?=
 =?utf-8?B?Si94YzF2YzVKeVdMWGRDcTN2R3BpZTNrbE1IaS8vNjNBSEN3UUJOdUFNVG5x?=
 =?utf-8?B?Z1ZrU1RRdzQ4REdJYkwreTJEaEgyMHNERnU0UWl4bVJyZTlwS2s0RUxvZHRq?=
 =?utf-8?B?VjNqYmovT1lrTzB6VkdHRUR4TTZaMTVMOUtGaGV4VTlDaXYvNkYzam1YSzNU?=
 =?utf-8?B?OG9vTkZJT0FEWnQzSUZUbWk2QUJ3Qis4aHhaNzdJbmdCT3pFTUV5ajY3WENX?=
 =?utf-8?B?cmVIT3ZCSzRPNE14UjRzY3pnRmgvakJGUEJaQ1ViZTU4RGdLbDZpQ3FMWGdD?=
 =?utf-8?B?RWNSTmxrVnFON1MxQTRXTzVPeXErdzRTeHJucXdMdEREbVpPNVRJVkl0M2JK?=
 =?utf-8?B?Mi8rdTNRQXBHVU56cklleWdieGZkUEx2UkpCUHFPT2dLd2pJNkx4djZ3Q1Jk?=
 =?utf-8?Q?g/2XC/huPaUHhiyyau+zzrLoCrqZZ/oSz8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 06:33:12.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: aa97d772-ec87-404b-5f87-08d89c0c4da5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgTEC7ApeNUlHaFBAwqMfGR+avdiS/zROMyKI7rsCKbxrC9VXlpeu7fxySebPeBBb3T4DFaLiaWwcCO4D4MM/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the mixel,mipi-dsi-phy binding to
DT schema format using json-schema.

Comparing to the plain text version, the new binding adds
the 'assigned-clocks', 'assigned-clock-parents' and
'assigned-clock-rates' properites, otherwise 'make dtbs_check'
would complain that there are mis-matches.  Also, the new
binding requires the 'power-domains' property since all potential
SoCs that embed this PHY would provide a power domain for it.
The example of the new binding takes reference to the latest
dphy node in imx8mq.dtsi.

Cc: Guido Günther <agx@sigxcpu.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v2:
* Newly introduced in v2.  (Guido)

 .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 29 ---------
 .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 73 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
deleted file mode 100644
index 9b23407..00000000
--- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Mixel DSI PHY for i.MX8
-
-The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
-MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
-electrical signals for DSI.
-
-Required properties:
-- compatible: Must be:
-  - "fsl,imx8mq-mipi-dphy"
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names: Must contain the following entries:
-  - "phy_ref": phandle and specifier referring to the DPHY ref clock
-- reg: the register range of the PHY controller
-- #phy-cells: number of cells in PHY, as defined in
-  Documentation/devicetree/bindings/phy/phy-bindings.txt
-  this must be <0>
-
-Optional properties:
-- power-domains: phandle to power domain
-
-Example:
-	dphy: dphy@30a0030 {
-		compatible = "fsl,imx8mq-mipi-dphy";
-		clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
-		clock-names = "phy_ref";
-		reg = <0x30a00300 0x100>;
-		power-domains = <&pd_mipi0>;
-		#phy-cells = <0>;
-        };
diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
new file mode 100644
index 00000000..f869fd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mixel,mipi-dsi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mixel DSI PHY for i.MX8
+
+maintainers:
+  - Guido Günther <agx@sigxcpu.org>
+
+description: |
+  The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
+  MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
+  electrical signals for DSI.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mq-mipi-dphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: phy_ref
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-parents
+  - assigned-clock-rates
+  - "#phy-cells"
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mq-clock.h>
+    dphy: dphy@30a0030 {
+        compatible = "fsl,imx8mq-mipi-dphy";
+        reg = <0x30a00300 0x100>;
+        clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+        clock-names = "phy_ref";
+        assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+        assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
+        assigned-clock-rates = <24000000>;
+        #phy-cells = <0>;
+        power-domains = <&pgc_mipi>;
+    };
-- 
2.7.4

