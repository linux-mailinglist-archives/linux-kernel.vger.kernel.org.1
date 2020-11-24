Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348B2C1B20
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 03:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgKXCAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 21:00:21 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:21627
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbgKXCAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 21:00:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpPIpcr2KxsK/Tetr/mJayBYCVl5FauZPX6IAPmx05ZR9iLI3fAXxHq+fPC2Mz+x51J6X7k5HjLizWBZu7fKhFu8AB5ZCF3immrSwNPR++lVAfmap9MiP4TTOW/OJcqBiiPUcb+udPHDelBPGyM9PUvy0TKQjOJmswGfACov8zcwAmQ1K2qKo7JoIdlLA6NLWWRXD1scRIJSXTG1IZsg7xWbviiBkUwBHNA2nmpxtP8bM/+yCmgwAaDlZZU3rc7CqiWvd4E5LB0OuNUBxeesmbIRpd8JFqV7jSV0AmaMt4ipTT5tSmF6rWokbpv/AATuvu9wOPc3+YjSe/BzCECaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9Z9S3TmKnT4aqTsb1HvO8pMfCKlinWvD2uxKXKkb34=;
 b=JeDoQJ9z1cSg8PyI+2RYea50yvlkC5vtl6SdOPokknbsMEZt0ZxMIWXd3alSaUGGm1ctMSMeqDfWIQ+pIj2Y3VU9wwu1Og+tZqdLSUZal6iSBlbzqwFNt0qHoMuDgxj+rzjrCibz10zoaD9UIKo71Ec550jxQCsH8thnkiTb0hUH+/8LdCJaP1Gpi8pUHIjCVDJbP2eAVrIYLTD/3fnpxwvtyF5QzRM3BhMhVqywN6fG0XVd42hidC0vmP9hTXEpppFZIiwCx2beiozPXRr4cGUwqaAfpyJ8vTiqU7e9ML4Q56at3Ib/q7nS/cjeqdKwF7RXOXccr7rB+3/VYKwUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9Z9S3TmKnT4aqTsb1HvO8pMfCKlinWvD2uxKXKkb34=;
 b=f6Fx5ZKa2qEjOP9GDlxB5vjrCRkrdbwGfDLEabrZLxt1/nR8giyPjubKuUm71s8NlHxkE6GrMYF3Z9QsLeu7GgQ7jdTcI1BoEujXMOrFaBY4dJ8d+96qCe0YMwgagSQ8Y08OPbRz3DrbABvVsmKVVp4Tdr+kKTZ65+0IBKHLrnE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 02:00:16 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 02:00:16 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 2/4] arm64: dts: imx8m: add SoC ID compatible
Date:   Tue, 24 Nov 2020 09:59:47 +0800
Message-Id: <20201124015949.29262-2-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124015949.29262-1-alice.guo@nxp.com>
References: <20201124015949.29262-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR04CA0188.apcprd04.prod.outlook.com (2603:1096:4:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 02:00:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b22df386-734e-4816-df9a-08d8901cafe4
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7096E3A5B16AB115D7E761ABE2FB0@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xbsoEhcR75W5FPfOTe8WOf0s69tRRIM88T/3GcKLypNvCLG4uPdmbWYrwiJ/7cxrviPO+gIwAsG0LSKSizWj7H/BeSlrcXQQj1ejWdLV985qTvvHQ9dNmiHQpXuT1W/7+3m9HkIJ7zQ5uQhgEwoAUV/r1SdJveI+GEbO11L8SURL4whNgKk9OMqZAMRhp/U8irQwfihvDq0jVSxoKPeSp8ca6P9cGxQ9z7FACI94DN3mEOaml8NhpwSa14HzbDkS9YGO+lueNFHbNoEk4zmZGcB+RnZpnkm/Ie6E1TwRea/x0ranMM6KBZ5Hc0sn9ioK06NI5fQ5vuuJnVOlnKZExQWtmPkk/V+XLvEvEe9cLqZLg2L2YcPZHZ6+dWtnkPP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(956004)(478600001)(36756003)(2616005)(6512007)(8936002)(44832011)(4326008)(316002)(6486002)(26005)(8676002)(52116002)(2906002)(6506007)(16526019)(186003)(66476007)(66556008)(6666004)(66946007)(83380400001)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: J13Jq+owMK0VaaAFU3T0R2LUkwQormYwrWHhaPxH0NXnLaIHZ1sgcD1GHD8sWScdJCQzw+FMOJBYcWXIfnqMZigtuy2apytZhA4T0+1w2R0SyhSf5RnYEkSmxKy//FxPF9U9RsMbkyInDHeqhWaDX0dgR0xYCPo+i1+t2dF1kJVxhvbeLhT69sQXa/viP6zQUHDQFW0SNL0xyyrEe/YAEloqqbn3i1T/z6C8J5AtlEn7yivDl2bZ49zV7IDnb0CAJmyG+Xbsd91MbK5maxvMIQwwvwGXGPHUsbZiM8WHMXe/+6K2rnw1j6C+Ky2YZ7Wlc9nWdmfMT/haSPh+d8cX+GmqlX8+ZASYTopBFmhzuFJ0UTM/RYWWVBgdySDdQiD/ydkgSuzMGtPcpzmGFyKtl+SgxBZamxMHkBQm5BYLlXdHZpYhSci7t4KMI9aBAMZ1ORkUaPXrumbz02V2k/PeB1SpOSYdAdH57zwglJkU1179XfAE5UqQOaZkVWb1UrtHlz5qmBZzShmaC/UsJo9/4KLH2blKf6m3y0m+eQoNUTenjbQ5nZcyLS9NZjOrVn4zykeh2crQb8yC7DkdCW/pwotoXk9+dSD5mLl3XjE4SLXzy9HSHs4ZZqYPrTzgTpLKZBRZiwRbIg1CB1dPAWlmC/3tQqpk/RgPyzvKkHtCRwB8OkgCe+Mdbx6ev4R9B2bHFEEo21XtYe0r/JnKzqjxz+0+MB7ytF0EpVHS4lNMBYq3rvmcMKbFM+Vo3W1fZ6pLgK2Cpf2rwIinEY7LQzicRDBVaVSkRkBrNDFZCZgE4SMIsPvBuIlB4NykWw9EbAE7IrqlcMGr/K8ggNK40rVvnWu4pCKZJUCBpVBW8HRYZ0ihv+Xza09RzFwLm3R7xrUrmlgRusDK96Z6mwpXbQR4tg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22df386-734e-4816-df9a-08d8901cafe4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 02:00:16.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDeuF9pfC1SpGm5A0CfpXQeqT5he0+I3uSPcXkjPAhwy/Xfr8TvZJO2uHK0DoxyLT/QmFlPw2R///udEeiZITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string to .dtsi files for binding of imx8_soc_info and
device.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

v2: remove the subject prefix "LF-2571-2"
v3: none
v4: change subject and commit message, add Reviewed-by
v5: none
v6: leave only the changelog under '---'

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c824f2615fe8..d457ce815e68 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -257,7 +257,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mm-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a06d2a6268e6..6d3a809a00fd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -241,7 +241,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mn-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ecccfbb4f5ad..ec6ac523ecfc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -218,7 +218,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mp-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a841a023e8e0..9b6d9307e5d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -286,7 +286,7 @@
 	};

 	soc@0 {
-		compatible = "simple-bus";
+		compatible = "fsl,imx8mq-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
--
2.17.1

