Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9994B27FEC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbgJAMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:08:38 -0400
Received: from mail-am6eur05on2135.outbound.protection.outlook.com ([40.107.22.135]:9792
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731816AbgJAMI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANPHs8UpMTP3DZQ31ny2rW6vJALAxvgKCSHL/hzayoqvRuaB8ckoXk2xFq160LB17SXXpxnNwLbQXX+CMV51/kR/cvhSOWQZWefQYt1s/V+yDROQIKVa1G+gbM7/Wac5pwL2JcmmEBsjMvi/nHorIFeInpXdQ4ZlQDlAn+pKm+hkZC6lzcfCCcBbAHsm4elBYdlSgLvHTBKNBRe6Pvp0AmCBcPD/xBGcWzT+mjqGUYhf/hBUTEH2+g0OTPrqUnkLloyV8hYEhJ4KBPS4aEqsu7mMEunh5xLVzvjWuZLHuwx5/ehrtcuIfXBToQPc6bDugOijvKzjHbYyFvSfHWc7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7NzJOZTPdP3W0SwI5UbZoK3BBMiC26rC+p4fR6kS7k=;
 b=b8jDAWjIbzuhv1Bp0Iqzb88dlafwNfpgkV7eov3BuSfyiEIffRU5zNgR2/wJ2gOMOHWKlSJ0YtqYh4M2FtEwKVIcPMH61lCYeHJsLveVCBawsLO0mUb0HQrhb45LzZInbIaMpz+z8EbPXktlgVNdKcB+RjoryJvHYygEBzp+OofzG3G0WwPUbXDNMPbiHoJwv9eDE15OA6M8GvP4kFxXyDyevWk9KtK2R2Re5D60136ZGtgUXZv68z+I1ugqJvQ2bnlz327ECjvjGLF+J8+TDlVXxJ4ja8zHuLMxog/I8IwgueQfZbH4rxj2+7hpqb1M2xhZ+WoStUu+Mbt0muacMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7NzJOZTPdP3W0SwI5UbZoK3BBMiC26rC+p4fR6kS7k=;
 b=jkxu2WHrHHsPajnSEqnqPEDKzjywgY+L8sjy21Jzri1vhq7semNOli1XRv9ITVmFkgjp9/mCz7AU9ehBQlDkL7PTZv+eH838PwkuFb28ZgtHJdrlLm2UzNd/ZrATXSZ/Ge3YVkxa21Yb1iWp80A7fPceIkDwqcr2kB0VyNuR/pY=
Authentication-Results: kemnade.info; dkim=none (message not signed)
 header.d=none;kemnade.info; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM4PR1001MB1345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 12:08:25 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 12:08:25 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8M Mini SoMs and boards
Date:   Thu,  1 Oct 2020 14:06:59 +0200
Message-Id: <20201001120717.13027-2-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001120717.13027-1-frieder.schrempf@kontron.de>
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM5PR1001CA0037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::14) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (89.247.42.197) by AM5PR1001CA0037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 12:08:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ed8948-7dd1-4aeb-5daa-08d86602b350
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1345:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR1001MB134588D40F083B370AFB191CE9300@AM4PR1001MB1345.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JSaJS7SwYViioH/32nXZL9OJApy/PTuMeN5OpFNDB/eItcDhy7MuIvjNErmHlYjQU6YCdTHHilfaBN7g17D1Q+zJZokk1IKuxQRU+RP27tImxA8sEYIJrWwAuD0BSQYrbpTo11HqcVeF/XmAl3xNWxG+kL2eUxaAM1Uu19rfcwXmmohAiryiMNVr6nC6cfOhProaDDFYbt36nkS2/9MO9BXTaKXAVrP2HaCSKDyeLVyme1NNL6WCZRKPSRhGvD+dU8KDK3XrtkLU1c+K9+Yh+CA3tf5+zwD2pnwvNuN+awuTAhV6AOM4TjandDl/3RfKyguW2MWPogOr8aIJ+3ZQ64oqdu3I97OaQMGMO2NuYZ5Hmxx30ph2472gt0UkFhx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(346002)(376002)(136003)(396003)(39840400004)(366004)(2906002)(66556008)(66946007)(8676002)(186003)(4326008)(5660300002)(16526019)(66476007)(2616005)(52116002)(956004)(6506007)(6512007)(7416002)(1076003)(6486002)(8936002)(26005)(478600001)(36756003)(316002)(86362001)(110136005)(6666004)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3KxdFiXiBEIBtBs0cE9jGcg1bd+jWokoB/5MV4SrXvjGo1RcfqgIcMvF6icAci9ranVbIpfWFJgYIPfW7022FMhGGmqu9XdpJDanmafWO4Yn8GA4tzQVw8KZohfOszAG+F6HjaObc69SMA3Y0ZgJkiUu5Jwrs/M5mM0IL2BCZyGcBsfQO+AfsmN1d2PN63AhUUC+HwYViCMllPCjCRCruYUQmEeA1vdf4KtKafb88vy22nik8IZH57F8K/A9jY4QONoSKsX8UUlZvx5MBZ7zCgUDINskjT+/lFZkgL6ZEibKQhCtGAV1etf2/sCDcbweBpePcNXR/yTsSVK03smrfFnKFrxD1AJoXmyDo6zFdIqWKwoAFiHdzJRK8HzNonJ26A9tM56o0j/cT5VuXKIzRK8oemBPQCz8NvOs3aF0c8Ua1+T6D3kT6u+9QUOiKYPzKVHpm7TuUTq+S24620AAaSbwr5X5El2/btYMkaw5O0Eb5inwK/mrLBDtRjP9vmNGHupVsym+vzaTEuzSI/24RLu7BiTDtDBlePBd6qKfKK2xyPOL8G51b0eGCOWzv4cA4q3Hl3VMtszDlmsanCOvLBI0q4mzGvbBaMs0vyHbfL+3ozJhmqQvEptCEICPctJc5MSZBvhs9dxV8+yW0znfiA==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed8948-7dd1-4aeb-5daa-08d86602b350
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 12:08:25.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4PBVgZ0z6Ep8wO+QpMRIW6wx8R0fd5jfTDRzLk7kWvzkZUIbue1Om1RZWTHwalZRYCFVC8eR4cJBXMOb7hfwPb2zZnfEILykBMCG52R9XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add entries for the SoMs and boards based on i.MX8MM from Kontron
Electronics GmbH.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
* None

Changes for v2:
* Merge the SoMs and baseboards N8010 and N8011 into a single
  configuration (N801X).
* Add Rob's R-b tag
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6da9d734cdb7..4217c61e3048 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -345,6 +345,13 @@ properties:
         items:
           - enum:
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - kontron,imx8mm-n801x-som  # Kontron N801X SOM
+          - const: fsl,imx8mm
+
+      - description: Kontron N801X S Board
+        items:
+          - const: kontron,imx8mm-n801x-s
+          - const: kontron,imx8mm-n801x-som
           - const: fsl,imx8mm
 
       - description: i.MX8MN based Boards
-- 
2.17.1

