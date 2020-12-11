Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB992D6DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391735AbgLKB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:56:15 -0500
Received: from mail-am6eur05on2088.outbound.protection.outlook.com ([40.107.22.88]:38298
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391225AbgLKBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:55:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MafHRAIaZLxyOqG9NDdIJPISa3nfXAB2eTX7OCIzmehFdrEsSPfWlBz6enon1iFOSRmD2I08RbCQNgmU1XgqrzHszMHSyPdBqYs1TERb8xIEyQh3d5jfox886jMV4X1WFcZa1VESw2rgZG3pSSsffyiUEz7YTftFl0blaFnTwln/hnbQ9jrXVJcN0SmxxIcrtcO34NAq1LiljDcymQ1VZZdmpBr7JqVWUkgD+8W2UG9avkhQaOlXxdZ28UEqdjRrpe2KhwJHgbAB0mRv/wIX/Z/wyUSJLrteRGQhvScv3cufBBgoSep0iWo02gdptQC2xGTa91RLhtRDiK2571Tycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttQ/OcOu/Epp1ERZEqByxHR+fVO/OATaPAD8cfj/eN0=;
 b=NjhD0PZVeK82UOOh0SYuGpK9BQIXRUc4XIJ+3StyLH+AtNka9GANQVkZWhWVukiIObSyb9hW3QHu6SUQgMsBM8Pmz5pvQWLLlY/2Co6h7Z4gJlwkIzsVSsNRbSxXCEQvIkAcFFCT0ulc01L2nlHfUU83Tr9cDzyM8z2LqfLxpKVP2XlBWQ4Boz64hDDlViLt515itZ33+5B/jQMCmfsf+Wskuc8ynJAWKusH0YbvHuPi0tg7DjIyjJqdvk4FBKwRb8nj8KeDse7b6bwY/UhC9wq/vVQ46IA0pYTrkVcQ4ntsThOyN4NnppGj++wg/iypAOzRNeDy+Qu5WNg/tzHkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttQ/OcOu/Epp1ERZEqByxHR+fVO/OATaPAD8cfj/eN0=;
 b=ojd6COTUZC6w2Y5+SUhu3Ghtd5IUeCsOBgZBLTECuBYKB95FkwX4oqdj95bVR6zbHuV0yfzAvbjprne6LY3FUiMSBs8J4W+igeRJuZFPucVQ36yD+bmNQLsWfwmQulXKhkFj+xPOhByfLAm7PStG4YtlB8EVtOvT5rQNjyCj6+g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB4045.eurprd04.prod.outlook.com (2603:10a6:803:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 01:55:06 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 01:55:06 +0000
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
Subject: [PATCH v3 4/5] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel combo PHY support for i.MX8qxp
Date:   Fri, 11 Dec 2020 09:46:21 +0800
Message-Id: <1607651182-12307-5-git-send-email-victor.liu@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3676.5 via Frontend Transport; Fri, 11 Dec 2020 01:55:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d21a3e2a-2f14-4152-62a9-08d89d77c890
X-MS-TrafficTypeDiagnostic: VI1PR04MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB40458E48AB332AB1B478569F98CA0@VI1PR04MB4045.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tTf6H2SB74uXjmvWO1qApYrZsoydvc4NDsHD1noY/ZTNqpzdSe29QPZ5HKxYuUZM5JR1k0JEqVzzidCYSHlGMeUgNb3aFUXWBQR1XL8o9h0FWly3TvVeF9Z+TlGmhGrQouUQmzWcY16nUdrN1oO2UwPc+g/+eNEWJ/RzlgAZWHxCIKmCILIeSEQriCDQUbSjp8AbM47j+4oqJVPMOOHI4WFw9KojiYfWIPeZk493cKaSp7iUeWdTFZkDc1C3Rad79ENbEVqstrzbxCzKwazYl4R21ddo7VH5QemT8wkOimi2Z2tDmZYj96gBC3Enwk+0imz+J4BR2MQINXel0FzSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(2616005)(66946007)(66476007)(6512007)(186003)(66556008)(26005)(7416002)(83380400001)(6486002)(16526019)(316002)(52116002)(956004)(2906002)(4326008)(6506007)(36756003)(6666004)(5660300002)(86362001)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTlKTVc0WlE2WitSY29UWm9TbHFZeE9jem9uSHNKNmQ1d2hTbXFwSlNuOVlZ?=
 =?utf-8?B?ZlZlVHA5aFArMkdDclIzazZUTFFxMytUV1VYaDdqRmVZaXZGWjRMMS9XNkRr?=
 =?utf-8?B?V1hVL2ExaHF6ek9oMXdCajJnVSsrNTNIOG5ab29Pbmdhd1dLLzZQZkFKZFM0?=
 =?utf-8?B?SjVnRkpGZkw5VGJOV3FWQ2JOOCs1QkFNWjdYWkhHR2ZkaXdkRnpoM1hkN2gz?=
 =?utf-8?B?eG5qYi9UMFo1b0g2OFV0UDdKVjhqYUEwV25Zb0JkVlZVU1krekFnK2VwY0hO?=
 =?utf-8?B?dXd3WGViTXhUdDJLRGlOYm5tSTVaTEdiQkZEVVhqbDBlSEJSd2NlN2hsdmJQ?=
 =?utf-8?B?emNtTTNJcVdJdyszR1RRL0tuNCtWQW94Rmk5T0tCbGtoVElJS2dMN2FNZTN5?=
 =?utf-8?B?SmhqQlM4TG9uNHlRV2krbXY0NFhwR3AwdEJQNUgzTjVjOWQrNG0wc0JWZjR3?=
 =?utf-8?B?TjdjUVlnU21BZVBhck5LMUpNVFpnaHovQXYvWExjVC9xNVdKMVRINDZzTUM3?=
 =?utf-8?B?RXBrMDJvT3JiM3ZsbzkyaW5MU0p6TVJjME1NeW4wa2dZQkNmTFcrb0ZMT3d6?=
 =?utf-8?B?OHFaUmtFcXErNVJZaGxRbnkrVEpaMExJTmtUc1VVRGpZNExHTCswaUJLU1pl?=
 =?utf-8?B?OERhTkNuT2hJem5xcDNMNTk2TUhNdXBxM2xuMnkzMURLM2REZjRIL2gwYW5v?=
 =?utf-8?B?azBlNDhKblJkU3ZUTUVkYXhjdTJnNEgzZTFYaUxYUFo4MHV5YXozc25XVGxt?=
 =?utf-8?B?eGswS3k4ODN0b3gvRDAyRmFLdzVBUDJYTWw0bS8vNFFvbGVMdisvNC9WSW9T?=
 =?utf-8?B?RmwxTDJLWGE2Z1dHcXBGd1VFUzB2RWg4dnNoS1JDQzBaSXpaTnRZZTVPU0d4?=
 =?utf-8?B?RmxQSjNYU3lPaW9zWUxBYncvcnlxVGVzeXB3RnQ0NU5mR0JYNnIrTFR5bnU3?=
 =?utf-8?B?NVZETDEyMGJST1pHWDQ5Z2VMT2lHMzM1dnl6VVJ3dlVMcmxoMlFDNFA2aEJZ?=
 =?utf-8?B?a0p4SlpwNkRxbjZWQlFyZDVmZ0FkYlZwY3J5MktheFU5Q3YwTm1OTjlDc1hu?=
 =?utf-8?B?RVpsNUwxaFVXWXo1Ly92T2xwU21YanRLNThLVWRqc0JMS3YwSUIybWlxd2dE?=
 =?utf-8?B?YmorbWtSR2tIeGYwOCtUOE9iNENrQ0RtNXdPYnhpYTQvWkxPUW1DUXBOQUp2?=
 =?utf-8?B?K2h1eDJSdFBiTkJzdEJnemkxeEowL1ZHRU51bGRQczJVb2k0V3A0Tk80SGdu?=
 =?utf-8?B?OGRCQmtLek42VWtkV3hrZnRQSWhhUENvNjZVT1ZWNE5nbVp3V3BrRGYybW9j?=
 =?utf-8?Q?PGDxXu/OgeJns2bxXlly4w0iLXKGCAEuNu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 01:55:06.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: d21a3e2a-2f14-4152-62a9-08d89d77c890
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GoFzv2ioe5ZPTXACyTQxnJfXv48zvZCUsUrVmc8D1QnCE2HtRX1IdPtG1Efk/Kr9Ff3eQQeqGzFpCmv2ZEQtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Mixel MIPI DPHY + LVDS PHY combo IP
as found on Freescale i.MX8qxp SoC.

Cc: Guido Günther <agx@sigxcpu.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* No change.

v1->v2:
* Add the binding for i.MX8qxp Mixel combo PHY based on the converted binding.
  (Guido)

 .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 41 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
index c34f2e6..786cfd7 100644
--- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
@@ -14,10 +14,14 @@ description: |
   MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
   electrical signals for DSI.
 
+  The Mixel PHY IP block found on i.MX8qxp is a combo PHY that can work
+  in either MIPI-DSI PHY mode or LVDS PHY mode.
+
 properties:
   compatible:
     enum:
       - fsl,imx8mq-mipi-dphy
+      - fsl,imx8qxp-mipi-dphy
 
   reg:
     maxItems: 1
@@ -40,6 +44,11 @@ properties:
   "#phy-cells":
     const: 0
 
+  fsl,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      A phandle which points to Control and Status Registers(CSR) module.
+
   power-domains:
     maxItems: 1
 
@@ -48,12 +57,38 @@ required:
   - reg
   - clocks
   - clock-names
-  - assigned-clocks
-  - assigned-clock-parents
-  - assigned-clock-rates
   - "#phy-cells"
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mq-mipi-dphy
+    then:
+      properties:
+        fsl,syscon: false
+
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
+        - assigned-clock-rates
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-mipi-dphy
+    then:
+      properties:
+        assigned-clocks: false
+        assigned-clock-parents: false
+        assigned-clock-rates: false
+
+      required:
+        - fsl,syscon
+
 additionalProperties: false
 
 examples:
-- 
2.7.4

