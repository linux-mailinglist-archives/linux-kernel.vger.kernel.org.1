Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FF2A1D9E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 12:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgKALgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 06:36:01 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:9342
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbgKALgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:36:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc1MEwQy8iKCeVs7D/WbHCa4pSdbnchHpTxk9BlGYT+mHZjlDin5tSkJYYzZPUbH+Yp24xBFnh8gU9VcT8s4nHUH/ZUpW1L00mhdhqCht8UUuEMMfizoXLlgV+KZW6Er8IzUrD4l3qq0TrhjRfaUes2rE5v8sn/OPjE6uA8XVRnF24hC/grX1jGwDZkwwxNM9LK0rDaAnT37+5clAgkjve9244wMQNpWZgBwnuD61cZmMB1oM9xPVI2/1dsHc96lNh13AK8shTPuhf3C6sg/mXTunh0X/+bKBo+f5AmgAkD6mPtidFuVRYrMl84b9S/koHF5k6hy+6XWA0uyC77X7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VK8S/n7ugTfppXfJpBsHZIXH8IDmjzpCieihTwbCrg=;
 b=Jdx4hjkkUeJ1kfEzumKG2TwupoZUdnJAgw9xQD/pjUowNQpZS92tjfKGJH2fe9JX6pc3fEbJFt4rx6pFNR5pyvzG+bbpCSFEeDZtshjaRecrtM40XwyVk3Ou+niknpM+tLm2tcWHfs3XGGro96ZoWwb/Tb3jvtNAv3qStA6fb+SRRUn1DficNc6231neP+Rb69VFuxu9+2Xf1oGH2shkIATqvRWDqk6YpenEC0qLi+PTle/0PWqFUHkqZZxw/Lws7g/8ZrVRJLWP7iWrAzgCyLMYI3sQF1j3ia96NGQtGFZ0V+iJlBW/+PAfJEMKFcjBb4ms1/iY+rOSuKSt6sTKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VK8S/n7ugTfppXfJpBsHZIXH8IDmjzpCieihTwbCrg=;
 b=WUHpg1Mgl9NdPObZePJ1bVde1T1KIw6ipKYcx0bWrvxPnS1N+7viPmrktU55gXp0Hi6bU51SirvZ/s1aiTkOc2SODLLs7Tib2DJPfmXlCNB1GGBbTOv412Lo3AvwqpCIY1i5N8TRg1G1Ge9lSzQoV2un/0Tg6Ovq24FHu1Y5+00=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7948.eurprd04.prod.outlook.com (2603:10a6:10:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Sun, 1 Nov
 2020 11:35:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3499.029; Sun, 1 Nov 2020
 11:35:55 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2] ARM: dts: imx: add usb alias
Date:   Sun,  1 Nov 2020 19:29:53 +0800
Message-Id: <1604230193-25750-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0141.apcprd03.prod.outlook.com
 (2603:1096:4:c8::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0141.apcprd03.prod.outlook.com (2603:1096:4:c8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.10 via Frontend Transport; Sun, 1 Nov 2020 11:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 411f6203-a208-4d6f-a335-08d87e5a4b98
X-MS-TrafficTypeDiagnostic: DBBPR04MB7948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7948D027F0DF8F84D0F089A688130@DBBPR04MB7948.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD0uPobix4EcKMn4u5W/QJqGBcTzLNU63HGvdEfUNQu6oOA+xybCsGbskX/i2H4Aog6F8AyqMm2KZaRrcIjLnXuFnoCXMRknO/z4qa4MlOA4v3MoBPaZmiekNSmXR4cqmsHb5VmAhlFqircXL6TuM0J3RR6SAREa839qpp0qPwLQ4cdiRlbhefdUIWqZRna6jSPcaVcUZ3EptYTOGnyA7hEg6dA7GfTjUjkpewOGenFRYFJYhyTAC00h6KvAXp6hIxAZVzJfMBuoB+n4ePArJi9xYT8u13apIX7gSuPDZNjG/RkpDqvcl7vGplMY7XFfwAw+PUuztJlu2cq9X6a7SNdjtYdtR6DNoAKDwzZlFPbncmVzElRydoEcQzB1gcGf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(366004)(136003)(396003)(316002)(52116002)(478600001)(6486002)(6506007)(66946007)(5660300002)(2616005)(956004)(16526019)(66556008)(26005)(66476007)(2906002)(6512007)(186003)(9686003)(4326008)(69590400008)(36756003)(83380400001)(8936002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7BnWZyRRuuAVMGrMMN1PLI2qypl0f+hiS1a62JBDK0qbXUkLQdOnBaca1/OPJ1WByKKVLI05byCq6loWT8R/c5J3c8P3G+JX4mCpgPEM5FETCC53/sDRiuNt/zzsutmJh4YgIdfNKh2Fo3aDSzh5Zit0IakKsFcY2Ek83PzmPhdHwp5PayUZAdRbFH+H3OabVwoO8+zZ9F0/93i+mbIe0ndK1fDAD+WKe0Nf+zJ95NlEcuCQiPCGWdZMh9QezIh//fMxJZTN4gRDhnoNsPTtrSli8rGZuXuaYZvPNz0ExFrL/XMQs9qsGgo8PLo+f7jBueXrh5cYwNwJhJEfBv3Qg5KVmLcQ3yxhTlU/ShyiOPDIm7AW/voMeCtBpdkv9dCGte3GaXNFErH2wY/DU2wt11u5U9bxDl03dS5QtODyOXLUusB9uVAWX1/H+AcnPUiMwkjG18bvGn1D/ov2jFtaXf+q6ix7cRx69eFnrK4IzQonvCivv2vbt6vaPk/7rz5WgOGwdPDSvE4rcmM/5+vaIVF1vRl70NY/txi37k0MGSrkzD1MJvrey35EyiVj8oakYxljN7SNduiB6SDfXmMGteD0iqCPfn3UmPtSY/b0gGQ/1/0YVRU/fSGdOmwBdnfRBTY18mA2sVOx/OIUbmUgFg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411f6203-a208-4d6f-a335-08d87e5a4b98
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2020 11:35:55.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 704xKRpoyQ4b+wqV8WZ77dh3q0SVQnIlIbTPXpw0TKOuLlF7+u59hkemT5ti1NjmcfY/M6SbNWCI4bZYIwg4Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add usb alias for bootloader searching the controller in correct order.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Typo fix emulator->searching

 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sll.dtsi | 2 ++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 arch/arm/boot/dts/imx7d.dtsi   | 6 ++++++
 arch/arm/boot/dts/imx7s.dtsi   | 2 ++
 7 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 7a8837cbe21b..947584b40b1f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -45,6 +45,10 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg;
+		usb1 = &usbh1;
+		usb2 = &usbh2;
+		usb3 = &usbh3;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 91a8c54d5e11..997b96c1c47b 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -39,6 +39,9 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 0b622201a1f3..04f8d637a501 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -36,6 +36,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi3 = &ecspi3;
 		spi4 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index dfdca1804f9f..343f2a3170bb 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -49,6 +49,9 @@ aliases {
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
 		spi4 = &ecspi5;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d7d9f3e46b92..09021a35c266 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -47,6 +47,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index cff875b80b60..b0bcfa9094a3 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -7,6 +7,12 @@
 #include <dt-bindings/reset/imx7-reset.h>
 
 / {
+	aliases {
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			clock-frequency = <996000000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 84d9cc13afb9..358ef453ce14 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -47,6 +47,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbh;
 	};
 
 	cpus {
-- 
2.28.0

