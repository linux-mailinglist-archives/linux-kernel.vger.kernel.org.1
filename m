Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD202D6DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394975AbgLKB5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:57:13 -0500
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:40512
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391239AbgLKB4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:56:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeqa9t6cyyLs1h0UsNZieskfIMQXCO53tZa4u7moS1DenvX8zUkY8YuxQb4eWWzSHE33UHTvMXe/Q4l9kluEnkvRhnyxHBXkIE9g6tdIWC88IE56MlMyNDicKpi7Oe/Y7Yeyg1jncZhm1dl/y5D1vbkUu9ZG/30EouFnx4HyWfm6sKGGQ56zT6+xVW4xJIxeyYw3b10gSK5NuBz6Edr04lHJExBcPmqFYpO3aLTUNBvsqFYVSpwyWjaFZ/NMNA/vurgvfkGXOpO071FlMj6YUAWtzCPCEoZ6dN7rAyCY1+g08jnpC/i2rsTDhh3XF6hlWv0aMc5BZM1YvzSq4AA99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTQt44M7XtQAFncnJe3Nu7zGVUbs8IkzfxqUDT1dzsg=;
 b=Vcw52Zhk2FOJ0Entnd+oazF8ImRTKO35cr/n+4Q1yQqJ8zP+qp2f4P+JIWgFUjyDUOnukVjwQFiodqZkM11OfHpJpLRnmgXBPPId7iphyfPoY508s5i/6AgHEVUl6Y83qbcRIoBKVcegVxnKv/1vXrJQ4Ak46PZxuLjTHY//Of3XpY2JNWSeO0djiUtQXY+JiiuLpR98pttnRtJWEGBaX72po8Rvv/sq+LfOson8o6P7GZ+U913uLtV7pLJr/OTJngFayM+mPh+YNarV02WQ5BV85KoVIly9wvc+c7hGQTTF1VEqgGSjA78kDJsEWfZ5JC8T4a4PyklEnwGn1o+AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTQt44M7XtQAFncnJe3Nu7zGVUbs8IkzfxqUDT1dzsg=;
 b=XRIF0+BqoDxUf6es3/7+2p6xUV3dHlQp+CAbmjgXG0nzdIFmn5jQ4A6xAsAsuA2urVs87Wg8Fs43t98wA38vfyTio995Iykp1GSWvUJZUUFrlU1g2yKOve3etqkNbgxMQA2FGZ1P3M3Tbq+CoEvelyiQWCN5yenTSU0vFA7fJ2M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0402MB3952.eurprd04.prod.outlook.com (2603:10a6:803:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 01:55:00 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 01:55:00 +0000
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
Subject: [PATCH v3 3/5] dt-bindings: phy: Convert mixel,mipi-dsi-phy to json-schema
Date:   Fri, 11 Dec 2020 09:46:20 +0800
Message-Id: <1607651182-12307-4-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3676.5 via Frontend Transport; Fri, 11 Dec 2020 01:54:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37b54dbb-0972-4232-5a68-08d89d77c4f8
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3952EE6F7EC4F47DF010EF6C98CA0@VI1PR0402MB3952.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqGe4yEyb95kbPCMzzwXCTNT5wu5zZz4KhXxHYrRmMyZc6ZifTY4Va/3DlFFHUyrgTPIRkh+XNryBXaiu+3/SI7hxGr3I3xypRiAMPLqqHo1M7hKCw0YULkaKarPBdnZa4Aw5jS88p8iTWgHn6N21fqq4tuNIBGYIvvVrNX8pecwC9rw9Wz+u0Na5fPlgBHCiQLCulF1Ke0B5lrfB+1PYqXW/BHAzNt81DZloapHzGMxEEGa7hWasJCwIvOQbljxVzYmC3G+xnZn9NZg4RoS2MjHg583LCcRGg9RhINIESgSSRS5C2YuLJJxwT4oWiOcJ7CRDJooL9Kl5jBSDOLbGxuPpBwBQWBMKA+sBUUeaEEm3b4FjRQ11RGk5pBbgEK9wpZVsdHe4Otq8f8SDWbFEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(52116002)(316002)(956004)(2616005)(5660300002)(66556008)(4326008)(66476007)(2906002)(66946007)(6512007)(7416002)(8676002)(16526019)(26005)(186003)(8936002)(6486002)(36756003)(478600001)(966005)(86362001)(6666004)(6506007)(83380400001)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c0VqaUtUYThCd3RjNmJnU2lVeUtSMDFQRE9mdGtzS3NCTWhjNjRWdWVDcVZs?=
 =?utf-8?B?YzVtNkpYdDFrZjZ0cjA5SlFRN2lBMW03N3VaM2I2NDdjeWM4RHBlb0swKytG?=
 =?utf-8?B?ZlFzSjQ2bHY3NXNQU0FNSy9XWnlUcVJ4azJxbEVQdi9kMC9VV1RFSTIyU0d0?=
 =?utf-8?B?eU11Q05iTjI2dXpnbXlCQVVyeGdrWjBvR1BWN3YwQTlBUGdkODlmckMvQlJL?=
 =?utf-8?B?dGV4TTF2ck9Md05rU1VSditLSTB5YXVKR3E1NWdYOVl1MEJ3M3dXMitnaCt4?=
 =?utf-8?B?dy96bGxlYUFjOWx4cndReVRqNjdzQUQwUVJ6R0NJcVZGSGo2MTR0QTU4VFVF?=
 =?utf-8?B?Q2xpZ1k2bFRvSDRGeUh2YnNsZVR3aE11a25nQVpFa0JtYythK0pFMFJRZjl5?=
 =?utf-8?B?U05MRm5xcHJSbzV2ekV3RnkzemRLbmc3S3BtWlJrcWs0Umx4Qjk2R3NmRk9E?=
 =?utf-8?B?aVlmK3I4ZFV6RExmcFIwZit5MVFsMnRNbWt3Y0VReGZjamQ1YVArelJRRUcz?=
 =?utf-8?B?c0c3N1NBQnpPeTNURkRCR2VPTTJqRlRYWGtqaTY3YTYwa1F4VmU3eFVhd25E?=
 =?utf-8?B?OUZXeVpJZFErSWliREpGanNQZTBqcnAwODliaklRQWNoTUlZVjdRYVBNdFdI?=
 =?utf-8?B?eW10YU8yalY3SmNidzVTcWMvZzBqYXRIRmZBMlcra29pQXhzemx6b1diYUpU?=
 =?utf-8?B?ZlY5REcxQmU1SWttejBvMEVjMERCZmd0L0RwYlB3WHRMZEI3NGhEaDZoRFhV?=
 =?utf-8?B?ZEI4TmpzZWZneDQzbnM0cnZpYTNlZGhmc1JYYWJUOFJWSHY4dmJ2dDBwRERV?=
 =?utf-8?B?ZWRVbFVadjRmeUFlNEM1alN2aXBlUncxaGRxOTFadGtSSnhSTklyVUM0ekc3?=
 =?utf-8?B?T0pUT01jdzNRblh1RE50QS84bjdxMmR6Q2Z5cG1xYS9Mbm8zTCt6ams5dDN6?=
 =?utf-8?B?UmdZY2pSc1FwbVhZZ29KOTFKbGNHTEtsd2lTM2VPSDMzQlFHV3B3dTRYVFFx?=
 =?utf-8?B?SHZ2ci9GRzEydE8xODZlbDFnZlFSY3k1TFVlSVRndW9mOHErRnlQY01nNG1u?=
 =?utf-8?B?Z2FiaUFKTml4VDRud1B5cG1aNmltREdtU0ZzaGNHeTE5aGhQWGtoSjlmMDJt?=
 =?utf-8?B?ZVZpR2V0VW5BYUhDSEd3OE1uMU9jdEQya3lzdEFjdGM1SlhrWW5IVm1Sa0tL?=
 =?utf-8?B?M0RVS29Ob1VVcnhzb0hyeWNMWTlUSzhmK2pFcS95Y2xzeVVkNWszYml6aHhL?=
 =?utf-8?B?WXVHay90SlpBOTdKUkFhUzA0QXhDMlg0bHFaUVpTK0VCL1Z0Z2pVaFBtUnEy?=
 =?utf-8?Q?/83tZXoh8+a4xMj0hwFMNGW4K5Ixl1tWCG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 01:55:00.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b54dbb-0972-4232-5a68-08d89d77c4f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr1zB7tatXcVZIsVsDzWPvJ17BHqe/GpkUeYAQVaQCFpd2WLdjby0z8s7ENxPAAv770PNsQQ0qJTbswgD58ahA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3952
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
v2->v3:
* Improve the 'clock-names' property by dropping 'items:'.

v1->v2:
* Newly introduced in v2.  (Guido)

 .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 29 ---------
 .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 72 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 29 deletions(-)
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
index 00000000..c34f2e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
@@ -0,0 +1,72 @@
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
+    const: phy_ref
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

