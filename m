Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1C2CE8C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgLDHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:43:37 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:33294
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbgLDHnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:43:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyx5Q0uRNIX2N/CS7/q5zuEjvu9PeW8kvLZUlqYuVxn518htGLzBpzXItijVCZ+Op+YA229HLBgN0jDauMH9INmislnM1UnrinJGWNphCfNl/jUEpn6ThagvJ4HkZu+VbD6VMQPAdbzuKMEez7yE6tXwFl/YVDKcEMbuFEdEnyJFEoDbbBUCAA429sYSd1XzOZh83tWcOnU5t+foBS/YOfvhHJ4oqJ+XNdgLgwx5wjXRvAVqRh9pCjBDVO4VD5vKeGq2cDwWtyEMTCdrtMT75cZe6sfp+Q4+MEAcBKd+f56P2lfNbRlkIA0hcF4hl1VnAPM02tA7P6nvSKOZrVhE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDkx75d8BodAfPnizTup55/foyEQ8eu4JZgxq2YzmLU=;
 b=WYFeBtdAA/AcadVV8cYyJC+gHiWxDImyx3/TTmbQMgzm7qy6Rvhv1HowOH5JaI7ds2g7Diaq2/1+MqvOImfWR6rJO1ZFZaurQM2eNWbGVlRVKsYmS1NomYBzCTgVhoxhtLSUDZmzhORtwNgAwZvdsnV2rJskizphqlr+FDDgMqcXypCoLKEOKzZfQTVxsXoj37nyyu2aLKH3Zfsoy1ctqz+n6iv7LzvRVpGFjGJ1aPaFsvSeE81YR8TNo9yOK9cBPnKHljxFIgtdkV/NXMxfZahP07yqqTuFz8RVQJXiPmeyo8t9bAYIWdCnMwJ9tOgV/YdTjPuDQvuqSHJxwXrMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDkx75d8BodAfPnizTup55/foyEQ8eu4JZgxq2YzmLU=;
 b=lRXavAtZZ+b3e6/VIgmk5hSLlwaBF+qCnVTiUb0+Dhm332qc9vpsf2/8c9dyn0daFYxTqyRP5ZuMtO/puNelzsIh4wHy3kUAm4CpaX+idnv+UtM5zYRGVPMmb6fb1Q0GhP7qmfB4MraTh4vKs1Afpp9MojvmuOpXYxOgTZzWyMU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0402MB3421.eurprd04.prod.outlook.com (2603:10a6:803:5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 07:42:20 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3611.025; Fri, 4 Dec 2020
 07:42:20 +0000
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
Subject: [PATCH 3/4] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel combo PHY support for i.MX8qxp
Date:   Fri,  4 Dec 2020 15:33:43 +0800
Message-Id: <1607067224-15616-4-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0098.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::24) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0098.apcprd01.prod.exchangelabs.com (2603:1096:3:15::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 07:42:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d95f1bfa-abc5-4b48-e57f-08d898282179
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB34212834B2DDF2A7CC3719A398F10@VI1PR0402MB3421.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqgUd2eJOUGUzXguqrN1UCBZq/Y3IEugVoME6dvPoLcy6Lo2JBKLkFlRlpCni5poUYOwAxE8nGG/d1RFILfUqfKKgeMpIObaSkgpVqnEGDGGgrLIqR/aqyCDYJi25yQR+wITq2Ov6NSSXmKpD0q+4wwhFe9U48frpG7Q9y7Sihy6Zl5iLDk0Lgjdpc4wQ0alDqLgG4m1iSt/e4muFK1PL0jsL0Gwc3Zvn2q8l9AHz0Fb38/ODZvBLTWQQpuN8FBTEJMABqbcmKUawCM3BsEmN7qHgMGfD7KuuvLxo2rLlNc2coRYCnij1fAkmrN5/LjAjsablujllpghJC399d/y2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(4326008)(66556008)(6512007)(66476007)(66946007)(83380400001)(316002)(8676002)(36756003)(7416002)(2906002)(86362001)(6486002)(8936002)(26005)(186003)(66574015)(52116002)(16526019)(2616005)(956004)(478600001)(6666004)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QU5ybXNQTVZTS2tKS1Faa3NUb0llTjNkdGVGdThIaGNqOS9GbFlONVIzSjdj?=
 =?utf-8?B?dTRpaXJKemwrdjk0TUhua2syS24rSDNaVmFZamIwcUR4eUZXdk0xN1djVkRJ?=
 =?utf-8?B?bWY5MStRZlBHTk1PcGRNcmJqL3pwU0dJVndEbTFVY2pXTmp0N2t1SUtqOGtI?=
 =?utf-8?B?WnBodlVnSlMwWGhHcyt0b3k5OUVMQzRYSGVteGNOZ3NqSC9HUzRhQ3crcmky?=
 =?utf-8?B?Rk1lVEs5dHMrU2RvejBDRUtveU4rL3B2YVVaSnBUV1o0akZwdDZPQ0JvM1U5?=
 =?utf-8?B?eE4rVlBubDEyVUNPd1BqLzZONkRyZStWNVJnN1lRV3ZDa3F4T2NWRlkzcG5Q?=
 =?utf-8?B?QkhZa1kzWWx2b2c4MDcvanpicFdDV0hpajY3WlVpdXZmU0ZXd1FLTjNYRE0w?=
 =?utf-8?B?dFBSV1dlQUR5TGt2Y1RsTXMybUpjaGsvekMrYUMvRGRlTnVLNWxNazY2bXA2?=
 =?utf-8?B?THJDNytiUFE5NjZPUUh6SGpUUVpwNm43ZmxablptR3pzV3R1NmRyb2lBcnNY?=
 =?utf-8?B?YXdaN1BoYS8zQmZad1FMbmlOaTRmNE53U1NjZ3RDZUorVEYxV1BHQytOK1RW?=
 =?utf-8?B?SFpCaUpmeThZQlhHSEJLMGl6S0JJMnJuTVRKU2VIaG8yZWluTk9mYkV5N2tC?=
 =?utf-8?B?L1pwdWxIRVFCTmFxZzRWMEl6aGpZdjZtaDR5ZWdrV2VieWNXbWFmdjVsc3V1?=
 =?utf-8?B?VTZ4TWg3cFpEU0xNOW1KRXI2a1RCQXV3Q0dlUmdxRlg5Y1hKd1p3dURZVG4y?=
 =?utf-8?B?WjhoZklRNjArTjIxSE5seTlPWEZaK3Q1TXBna1NhQTdRNDMwdnVodVNpNVZE?=
 =?utf-8?B?UEhVNEFjWjU1TXlrRFQ4NktNL3NVMFpKT1VaTSt2ZXRIUEcyVzllczcwNUp4?=
 =?utf-8?B?cjA1TVZsRTZnaDRBN2puRXQwckhFdVhvTzZsMlV4Mk9hNUdkVmlpeFFJK3E1?=
 =?utf-8?B?anZ6UHdXRW1wVHZwYm9Xang0UjlQU3VtVmhrMVdHeDVBVy9hYmt4T0IyWlhw?=
 =?utf-8?B?YnN1SU83cjd6aGdHUTJ0UitqM3ZDaHJXUVM5eUVHY2Rnb2NMdHpwcmtCaHFD?=
 =?utf-8?B?c2xHSytRc2ZtZlRURzdUMVk3dm1iQTlEWnc5N3ByU21oREpCUUhEUjQ2KzdI?=
 =?utf-8?B?M1E5akZFVlovakJwVDEyWnloWER4K21hZDYraGtiQ3RtVlJUY2JyTTlpQXh0?=
 =?utf-8?B?SHp2aUQ1MzdoNm9pck1MaytObkMwdVdaM29VVFcySDE3b3NzdWFvYUhiZG05?=
 =?utf-8?B?MmtqL0JRMXZGS21OWWNtTUhsbFZlRmtpQm9kajg1TUFnZndXMTB6QVhkRTJm?=
 =?utf-8?Q?GSjfYyjKOBhQ5g2tNg5a1BQBVSPgRQJweh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95f1bfa-abc5-4b48-e57f-08d898282179
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 07:42:20.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe1WaRUVPNwY5zK2tY8wTtidWCmltW6hW0/E925L+26mJBIQnUgGduaWdVjHM1KB75lGke/XwfCW+PWJWsBGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3421
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
 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
index 9b23407..0afce99 100644
--- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
@@ -4,9 +4,13 @@ The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
 MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
 electrical signals for DSI.
 
+The Mixel PHY IP block found on i.MX8qxp is a combo PHY that can work
+in either MIPI-DSI PHY mode or LVDS PHY mode.
+
 Required properties:
-- compatible: Must be:
+- compatible: Should be one of:
   - "fsl,imx8mq-mipi-dphy"
+  - "fsl,imx8qxp-mipi-dphy"
 - clocks: Must contain an entry for each entry in clock-names.
 - clock-names: Must contain the following entries:
   - "phy_ref": phandle and specifier referring to the DPHY ref clock
@@ -14,6 +18,8 @@ Required properties:
 - #phy-cells: number of cells in PHY, as defined in
   Documentation/devicetree/bindings/phy/phy-bindings.txt
   this must be <0>
+- fsl,syscon: Phandle to a system controller, as required by the PHY
+  in i.MX8qxp SoC.
 
 Optional properties:
 - power-domains: phandle to power domain
-- 
2.7.4

