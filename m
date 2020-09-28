Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4127A573
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 04:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1CgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 22:36:12 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:63713
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726409AbgI1CgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 22:36:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFfl2tVBIhfNldJMeLKzi6nBWaAfvAD5+XQ3ySeG7toB6AYAS1BggdU8inDhf+ru7+iXNilioisxIKiATm/MvyYgChOPB+twyc+QEK+wuZrsfVgg4tHui36TjzJjCXZYiXGtlhhriEn7mmWvAzjldb9IrBNa1SNHnin50ij5F0Hwc4UNZX/7hGiSYzZKnx1wCl0vMRtOCRuTFyluFqa2pDx8xaW5unD4IbvgrZ6Zg8MFdAa8kDj2XaPxe/Pz/sW0zqla4bfpf+BomEXpQiu6Aao2uCj1le4Px0UdWFvmvrfbOP0VqQNtJkiZENrOdbA03JR+apiYMbtGNJHNaDLqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bps/eBlf6S9kyQYOo1XoeeRYpyITWQ/q4HIboIwZNI=;
 b=DfxOd536vXaOKruyyB9q1S7lgYc2XseqL5BgGuA1S1s66U4358vMOayhsbz/Y4FMHrlThbLpS8WEkrSUmBH/XfKOFkKx6ztM7h1M0A04LSsXbpMIeE0oEYzYE4yJ/lbAHJS2FM3KYXTwJTCP/o5o1nlGXxYLJ6p5FUfCdjyZoE23Ety6kMF4Lge31yc/PbHtjMAXfc5fa1zdQSR/QbTSfYzLCasiE4ypwPvEDw7tcGFduhsDDfk1l7RErBnVzHmLM3vRLW6T1Bt0U6A4SkWhY1MXQsdO2I/z/CsVRVCfR/xQlZhRtlA5fsnbZDlSrFrjzFbrWfoNkkhImtebOdjXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bps/eBlf6S9kyQYOo1XoeeRYpyITWQ/q4HIboIwZNI=;
 b=QxdDOG+Gw1m69uqsNBrd/eWY68cRraHn6kIDR7mRiY56CiZtk0lV2yidHgoZK4LQOeuYZw5krCMMq5swC5tCZP3AHYOLb817FcXxb80c37VtUZU9rS0C5vieTyDmaslSIaBiQP3eJS4W1BnsmceSxieSvd7XPvAHvt0vQvCSX4c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 02:36:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::9c75:8bb2:aff6:450d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::9c75:8bb2:aff6:450d%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 02:36:07 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, yibin.gong@nxp.com,
        krzk@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8mn-evk: Add cpu-supply to enable cpufreq
Date:   Mon, 28 Sep 2020 10:21:43 +0800
Message-Id: <1601259703-28308-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:3:1::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR0401CA0024.apcprd04.prod.outlook.com (2603:1096:3:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 02:36:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7817a4c0-c35d-48c8-2507-08d8635740a7
X-MS-TrafficTypeDiagnostic: DB8PR04MB7051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7051B07AA878FAC7AE891266F5350@DB8PR04MB7051.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il8q9ubGpZEFTPTDPd/5qhkHoYl0/BNjlKdCUMPpXIo3cJWcGnZ+0yGtEYZpZ4GcrVtkwLtgRJ/NFIotL9iPOOFe46usM/I25cj1fq+P0dBOsKznFsrZH0VkI/wC3nTBuW4nU2+1ACtOyLI9uR8/92Yfcj3x1INQyF+7VO7ezIEXcIWIgbg/rEwDCdeQcj4G4Ubpi3Tuz4x/0dwSoHlqlKNsuQQTTXTonpPAGCbkDLC1Z3DTUIB1tZrPRGeVm4NQHgB9Vz8hmRCXi3BiauNTs1fHlTPrVoZrNOLZIoBk3oWpE3JbmdlE+YizVrIiVGoW9kX8Se24wmOSOITPTcmZQSkp/y4ndp05mcuxYo8LYTCkggga+NWc0I1Pv2+o9uVVFMyVXXZ9R87QW6vNYbKtu+kOk+SMTmRGRCXu8vn20A/Nn/FLQNvjkQ07ueFiFFCx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(6506007)(52116002)(2616005)(26005)(36756003)(86362001)(6666004)(16526019)(6486002)(186003)(8676002)(956004)(8936002)(4326008)(2906002)(316002)(478600001)(66556008)(66476007)(6512007)(83380400001)(66946007)(5660300002)(32563001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bhLGviUsb3VBX/TaOVXncrY242XBWoDf+jJqWeZjfztyL6JL0wFhTGuwqxAUQOq20VfqUZm+VaZFOhFYUO6qK5+5zd6/SD1pRgqZW2Ux2be9V7qo0Hkm5VOEHToOI5V5UgtWPY9ZOyok4+9negNrVXMLqUkWFsTWPoQN3ajKnOGctLNzijpOVtuI//+ObO2+TMkxE1jwQhRwSS4jDr6RP2fbjKaxZfj6NGqp/qTOR3PEHRX5hwJdLklca+ZHFeoHAfd63/1l9tTlGpsVX9YMBsg6OrEN5/tuRm+ZOLdBnrX+G6EC5ZrxdM4zhQqqn8BvOxPj31cXwuDNVCIHeU4JkLrefa18WuSB0+Rd1i3cl5iO+iA9byAZw+K9B0phL83p9HnOs2U02XoMcl413+6z6IQaOSnTXGn8e1je5PMyiXlup46INtScPLGtipJhJBeVyGhq9T+E9p5gwUXuPsoki8/KM8+Zk53Et+tLnktGFT53V7G600jwLjTobHXTDQl4UmHKqEMCFj0vhhomwCZ3Ro1NLsGUX644zkDAkabSYOYLRhe16/s/JwR5rz6Sf8KKzeZXrEoueVc4RGG8mhz6dTZL6MzTZRbd3hWLvSuzuHq/eTvsjjxgYTWayqHPvO90apu18B9OqiaP2i1ZEblVzQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7817a4c0-c35d-48c8-2507-08d8635740a7
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 02:36:07.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGg205MjkIw4dVhzaxH8DAYkDvy5eiEymAYoTvQri2yrH+3PNqBJp60vhNHIQ6idW3DhAesVjOXaS3bxVA92Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC driver is ready on i.MX8MN EVK board, assign cpu-supply for
each A53 and restore the operating points table to enable cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 707d848..9e5c0af 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -14,6 +14,22 @@
 	compatible = "fsl,imx8mn-evk", "fsl,imx8mn";
 };
 
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
 &i2c1 {
 	pmic: pmic@25 {
 		compatible = "nxp,pca9450b";
@@ -109,19 +125,3 @@
 		};
 	};
 };
-
-&A53_0 {
-	/delete-property/operating-points-v2;
-};
-
-&A53_1 {
-	/delete-property/operating-points-v2;
-};
-
-&A53_2 {
-	/delete-property/operating-points-v2;
-};
-
-&A53_3 {
-	/delete-property/operating-points-v2;
-};
-- 
2.7.4

