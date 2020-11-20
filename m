Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2FF2BA71A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgKTKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:11:30 -0500
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:33857
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKTKL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:11:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsPYtqmvcbnPDxyH4ADxurRkiVGW3wfvj64QjCy6kwFo/KYPtdcuRZ8Cj4CcDC8SlaghZLKO01dHnIr5I+jDGmMOxRuudm2doHy/AxS9OCqY1MhEN0sPNrnXPJUzWlZ2lRBS7LQBTJlECj8fkJImh4chht9Mlo0Yg5J1WqscAizCRwpDFY4sTuAJD3yYisDyOWckAw4b4EjdtnlOf3I+PbKhIjJ4gRxGJ39gjMlN6BREZUDB8Rjktx99hj0IXNw+Kz0kzG3wjmiDbtIuS0zSOSEvG73+mYM/TZmd5AaGiAo2YhWb9TW2wq575d47Ed/+uHc/Amby53qEedeo0HBjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLQbDZbRRTmyeMNqxR6YW7DuY22M2naWY7ShStkjDUc=;
 b=nxIqgfLLvPb/Ff0gKbwWhgummI6IqqRd5g87xXV0LxEnbFQCRCR+s9ASj1+Ais4I/d1GUwXsO71mzqIA/teXl5vmjrg3fBDRsBaZrgmBDDNWYhC5xsgt/JAC3R34JAkNgTppM2ttzFpD2jBKA7kOdbCEucawkuh3VIzN3qNOE5zODJXh37kXvhNhFaIiyUhvrOHIaFGg3GM3vUMB1NiPTOidqP6BCqW69L9Z/AzP7GURtxMetNpOpboOVboyrDfX7jdW/iXze/a6sa7FJBbryapRKZCs0yB5Lxf09QSqi6JIZpLZOlRk/aca1UX51OSEKAXhfVq5u6up3G+vsfR/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLQbDZbRRTmyeMNqxR6YW7DuY22M2naWY7ShStkjDUc=;
 b=Al27E+G4Woti6qOEfUKG04cXgVg5gJKtl/cbxTfkAg3hcudgkftDtIktzf/RtQTvBaskQ0O+ru8ShZkCD27ClbEshJ99CsLkCn8uxt08ABhAShz7rNq2ZyH0LnTSr1VzGVfqdAp7PhIjsU9prbgwjOsfUO5FHFpYa6i9nFE1oYo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 10:11:25 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.034; Fri, 20 Nov 2020
 10:11:25 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] arm64: dts: imx8m: add SoC ID compatible
Date:   Fri, 20 Nov 2020 18:11:10 +0800
Message-Id: <20201120101112.31819-2-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120101112.31819-1-alice.guo@nxp.com>
References: <20201120101112.31819-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::49) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Fri, 20 Nov 2020 10:11:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 192fcac6-b8b9-4793-6d06-08d88d3ca320
X-MS-TrafficTypeDiagnostic: AS8PR04MB7799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB779953917704CDBB15336CBDE2FF0@AS8PR04MB7799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BGGeMU18gyPr6AjQWgOEsXXzn/NA+7Y7QkTnzWg2IE2euSN97j7tJCeQSDrOIPUm7sl4D46EWHHZRvWePqA8UJ48E3gfpITdt64emcyUU0riV3BkpAMFLJFgyRJ4gDi5zxBiRpmc4tY9SSBj4nLHH3dD3WTzzPS7h3rFUi9boUrwPdLP29lh38YOaUF3MkAp9lPHjb357LC9U0HnmVSPS4m7UTWZpqIWs4c+YkyY6hRcJ40Ac16cQcdFXwM9LrXau3eGiMc0RnN/xdsTO8jzk8pCxO0xLJSG88tSlTv9bMUfHtulLwsefw5P3pvLbQl6OE/1kGvn+f91H2BecgsgPFmQaSZqpkS0DzWrWL1d8qgzTw0vVaW7F9ndO/oepoI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(2906002)(6666004)(66946007)(1076003)(5660300002)(6512007)(66556008)(52116002)(16526019)(26005)(6486002)(86362001)(186003)(66476007)(6506007)(316002)(36756003)(956004)(4326008)(478600001)(44832011)(2616005)(8676002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V/KDZVfWlbBdpjzH222kigK0FshNwmQyg90YZi2s5klzbDHnf7ceqvZnM904orIWZdhZ7/rjvQykWAYtkcEamkMHqbcssILcu9eMlwuiD+P0px2exUyNwnpfUf3u5xUei//42vlay98K3fn2wLnwZDQ2GbSCWooAXJe9lHcl4Uxp3EIvjyFRv6IQwD+Fv5xDFzFPwTJN3xLREPS3lNGa/OMwuQ9wXXi2gYa3ccMLj0l03fCZoORPy0zsDAfaQ85L5t5YP+emL734qMnznW7HOFnzYPVL/5Pj6BX5q4W2IAk6I/x8q8M4cfNKbZZ4vcy9/BGXt+kJzYTdNenbGgDFNnbi0OBih3aPOHKxQ433I5xl2STDVbPAMnUikODJxV3x0AAkO9MxSfTwiZshoRd+mS+ihrOqEz7GpES/5TS831x8CRXy1NOcYClxHKKSIkHPDUKmRBrlX66YNCYFK98FFSa/gukNX7otqD23Mzx6PhsKQfVEFjMCvc+4WEAbGLe3SwkC6SPVXKR6XkfDnfTX95Q40ZBZJfLc1GSWmMWmtTvbp/wbTA7mBPsdX9KxqXswFMQ/YNf6PUrGZx8aUMAQ2f5leQkKgc6szpx4l0AYhyvMLyXL4mTIHlkZOw1jU5zMZ1Q8Epd59Wdd/ad9hjXC9IPN3PK0k7aQ4bspZuoww534rqIm//zDSpf9TvrWL09nCt+vdSIwg0pPARAsmfkoGGSPpZqEiHIJ4mHiHju7qH9L4jBP/9M6TA6AK5Q7Secvzw2LYCczM67yVzp4+UN2/9YTvvPiOyDXjT4Hrj8bKwm8nbXfytTV/jKW9Rh+YeoGeT7Sz7f301ve5swnsnYjEmCGHWW3JHoPA4LbH3fWYEV4pe/hsHZDPAO5wioT68I34MN1OItUwB1CoKO2ay6bDg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192fcac6-b8b9-4793-6d06-08d88d3ca320
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:11:25.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Swt3mPw5eDAa+X5egPr8a1t4/0+ktCZwcwrzcnbKnSKC55/9ZU1lN1G/FkH48vx3K/9cuj8/xSI5Yr3uGdIIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string to .dtsi files for binding of imx8_soc_info and
device.

v2: remove the subject prefix "LF-2571-2"
v3: none
v4: change subject and commit message, add Reviewed-by

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
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

