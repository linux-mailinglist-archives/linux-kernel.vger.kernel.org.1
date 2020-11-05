Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4792A77F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgKEH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:26:40 -0500
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:58244
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgKEH0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:26:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e078eRpoVEmrFqFSVidjJPpCnU50IkRgNFj3EnOpn1FuKfYTxzEWZuCeMobDKyAYxct/F/R+LvbdwTQlpiSWWJioFZOp7Y/2YTarnJ+kImvZ2Ino//+uth+uX5LNp3y55KM5TmuFphW9rVCf4RoO1kiL7Jk3zXAOvhpd+hkq7MfurJEKHtxq0pAF5NHDZm6Hw72dlTto1YuKmiItPKa3PdFg1NFOpXc/W1GfdXNIATTy33N1jVyVbyRQkntDeLia9d1WyKAwkkSiCTu+OoR/QD4eKUDtZDz905bXbJibmVMj3sA2CcHx/tqzu0vh+EPWjZ95L1tIO/zuFgdUKOmSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAlX+R5gF9Fbyihby34OqDI6NYjY1TrJk7fTEbtbwo=;
 b=XpBhEHcQE1qnpeUiHZgaR9C8TLpJVgqNxpzxf8zBoJjHo3HNH5r+1d23ZtrGYkwfepVA2CZBhkByQEGAsAa5QNNEz0FgFkQBqypxAlj2ICsp+X07+S/WEhtN1Wye/iN71oIVIO/XdUprhFNcSmcYC2KERRCkGdMD6vAaWNVFLAujSn7zU8J/zddGxVtkbm3t2betbANupJA9wcAnsGt1PQcIjX9fKsAN4F3CGJRz0YA2O0b2wXEgOdYRvqgXyWVNPa3wahQ4Js24vPmOpATIcatgxux1FHWFkqAymNO7PN6M1u0J0h+02EIWmYJUDwWU0I/z63Bqj6seDuUJVwB1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAlX+R5gF9Fbyihby34OqDI6NYjY1TrJk7fTEbtbwo=;
 b=NjVfQPCP7Czz3MeScZhmozpLa6TW8lFbv7NiSjSIFBbSaRbWrdDfG92l5MJ544nNrWXobHt/po3ZGSZA9gNmlAfCHBq8nVAxJMU1p3SLTSGLaLRi7pwAfBCb9+4ey4oVEXokH8ga7f3J0UyV400YsomiAHxFqRv3vlHDoR9xxDo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB8PR04MB6906.eurprd04.prod.outlook.com (2603:10a6:10:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 5 Nov
 2020 07:26:34 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 07:26:34 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] arm64: dts: imx8m: add compatible string to .dtsi file
Date:   Thu,  5 Nov 2020 15:26:27 +0800
Message-Id: <20201105072629.24175-2-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105072629.24175-1-alice.guo@nxp.com>
References: <20201105072629.24175-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 07:26:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cac486ff-1187-4345-dfc1-08d8815c1f97
X-MS-TrafficTypeDiagnostic: DB8PR04MB6906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB69066F99422F00FC1E1ACEC5E2EE0@DB8PR04MB6906.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SkuBjnmhEqpsyiSwgp55Nd+VhAFuSOeLQ9zhaGfk3xNDsyv6wfyu37UpSOCrqdME07+nN2rezMtQWOnYPQA3gYZ1fsfI9mRPoc+UUucbXlWPp/Z/txQDtEcL2hOY6ZOLDo51ag36VV03O9l6034JnGZVCe5IFx7/YIVFhtrzZfqX3nDtZk2nOqH5TlACP3yIiR6AK938AcqaUq12m9UPXnj9YhucpxPbypBE+r6hg9kMhqEQIYcfNPPZqhCu8u33XtIKSHYapfgyOyTUaq98HfThXbfEdPVpfcxNTd9hGBuE8YXihRTmY8r1mOei+QpOHk90l9lgEnPvLCY/PZgRsl9v20CU2moDQbK+G72SrJ2KtMe7PUAevRegPfUa+AoOogNkp6HdPSKWvkMfgsRBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(5660300002)(316002)(6512007)(44832011)(6666004)(478600001)(83380400001)(66946007)(8676002)(52116002)(6506007)(2906002)(86362001)(36756003)(4326008)(186003)(8936002)(66556008)(2616005)(26005)(6486002)(66476007)(956004)(16526019)(1076003)(142923001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +i+pjG4ubwK2HJqfjS4tFohWk5tSbKGHHzJUpIG9Y6EGeamMs1LAvjMteFTbhJR24dp2xuSEe26LMMMANJ+VRGgjSVuaBxlw37AW73vSPtmew3MHlCwwYVTbl4hEL7pCzA8aSpElDWdVJLEyfBmqghqh5HRLCEeDuE7xRB+RlsQQHujIdjKbtlqyd2kEKxAGHE25ffVwLDZtgJymSnRqaWjLU28g3tM8AC09uJkuEu0BAEMrdbHcMxd2Aqv9V187VD6za4hMNd4L3feXqL8Ix6EcSUCmQI0Z2PxETY/PluiTAL7Tngq174xsCaxg7Do/zaoa3qCYDN9tmBnH3IAKHuWitZA5iClk8m9JJyfW68eVbt70slX3be5TeLSqU84JfPcpeTEFbWqw9zTvOlodV5v8qVodoTkkAgbM8kG8Dag+rqEFahAZnd1QRm00+himzInJ6XjOf9pCta/jCh0XohwhgQIT1Qyf4GUvu+p+thGNfLj2GDn+1mBOSnBwf4yP/bvFfFbwrS9Sl2w17rfeCDIM0Cslr5Fr0w8vWiBieb7tQcsoRAyH7mP6qQWAi8t3vjDUeyqrnoAQXEzywz4olTndkHNMPwoU+y1IKGH4UChrkPVyzUGqyMTW4CIkwa5ww34eNmVUxxmZCww5ke5ypw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac486ff-1187-4345-dfc1-08d8815c1f97
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 07:26:34.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrNzFTNTaqCK/bRTCcvAy0HIy1tvb9qJB0ByK3i2GACV8+yUr3rnNWuGaVMPxNara/pXCdjwrI48iXESPxftsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6906
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string to .dtsi file for binding of imx8_soc_init_driver
and device.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 033fee525982..cd9a77d763eb 100644
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
index 479312293036..9cd218f5f004 100644
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

