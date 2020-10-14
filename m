Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DF628D803
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbgJNBck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:32:40 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:18918
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbgJNBck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqSLlnsOiX+WSxbAMNFF2V7F+EOX97En5pApvrf3cK/mrZcZibQgzMzERbPVXWyMpaRC6EEGJziZJbxIW6jlfEUvrweiWtZnSZNRozY4VuRjQ8ZKwO3t9Izp4NWkfHHxKqNKjjvFX2D48/jNYL23JNDYcks2BZ7ie16Pk/gfjv5kSFS9v+9Y7Prnid6gnCLY39GkHR7cyr3jRSpGewjQGm+7Z4uJe96tYqDP8YCf6etNtibjv4Itl3VT8/z1gd8aceoep+dA1oLhT1Gh25PpOcA+sovpglBzSyuwn2HRfDxQy5MG3sgNv/+HqTt8fYKxWevYGX8FXKt9JEQM8Q0YPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jewIvuchVPd5MzamNtNcz9yhgSbHogHFJ6adt9lzvo=;
 b=a+K+Kb6Xj5JY/WxaDqGBoC/OLpHektsJbbuV+ssdltDIgtCkg3Zfr1sxaOaosM0CK+Sak33FkodhcIb524VeD28uKmhTZzZRY3p9+WbL5+OtV+Q98ZlKfeVoveMAnEBuQE9o2fJBb4Vga36Oloz+4Iz2KHe0PdXxb+AdbZuO8alh5kZXIJvlC/wdvR7tVXohVrHKV1pY9avTxTYKc5wEDCO1QwW36WIiRGsnY5HiMWrTklc0k64pZlqOF3CaNjEOuhgBURQUWRwXD2ANdX2wVWFNnhkxXA7ZTbyORS6winJvrAyMJf4jMwTFS5Rna1L+ctgRDY4TiGcXx0IaKDd2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jewIvuchVPd5MzamNtNcz9yhgSbHogHFJ6adt9lzvo=;
 b=L85Q1In0rNuALq0DNBjjdlv6Mq4EodPjyzeznlcjswpYtUsdlb67jP7zTXad2srSSmsn6FjGqFFC4g92SxiUFEXhr2JsETjbUmrSYjBIS+Y2vJheQ5FC1jHPKvzkXraDZE2P49R82drC5uPLRvqZz36ycz1UIQU5CvuCUQOI3KY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5242.eurprd04.prod.outlook.com (2603:10a6:10:18::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 01:32:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3455.031; Wed, 14 Oct
 2020 01:32:33 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: dts: imx: add usb alias
Date:   Wed, 14 Oct 2020 09:27:41 +0800
Message-Id: <1602638861-20278-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR0601CA0016.apcprd06.prod.outlook.com (2603:1096:3::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0601CA0016.apcprd06.prod.outlook.com (2603:1096:3::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 01:32:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f29ef049-fbee-433f-b262-08d86fe1060a
X-MS-TrafficTypeDiagnostic: DB7PR04MB5242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5242FC7319467462C395265088050@DB7PR04MB5242.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhfwu7of2+jUZW5Gl7K1lq3RMC+ECLk0G+7kMzQ1XZ06POkLhhM0E0QTCWWIcASdKbTN5zr5B4ufvzujHYrAJfCCl7DE+FoZ7y3H+TUlGbul4BWPt4xbL0BAfwmbLutkF5zSaraFTamlnJNdWD7VSv3l5V0Mh0yaS+DO9DJHGJpuEM/4JXjs1N339I5AhW0dIBujADokPUigGF+AqtLqaJWC7oZNjylHq7ISWyNnmI4JPWNRphsIfrrccKC2reOs3QftU/b6YZPNmw+jKhDUyDGd6mo6/KabC02O11Pj8A30uDbf03vp01LlvSl/aclW0IxiZRNjz3WWhC3+rIOQf1YWsHZC4vQLANyBuisaYSq1AbhF6gMxVBMcX0LB2TmL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(52116002)(186003)(69590400008)(478600001)(16526019)(36756003)(86362001)(6506007)(316002)(9686003)(6512007)(956004)(26005)(2616005)(5660300002)(2906002)(66476007)(66556008)(8676002)(66946007)(4326008)(8936002)(83380400001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1s7c1t5+RmcyZEPVJRZSr1QCbUsowyuyj/HA9vXRg/ka9Nj36BT52pB9hhXOaZWD4D8XmPZcgU+IX729l+ImEGr4HkhTWdOiOEZb4Gs9LrKbgpQgW7Lq4BKe8cjzdDabBcAvSNr0FfnkCUKGP2WEYfUL0vcOLpEBbKc8t3J5LxhfxmcELvXvHiJ56MHo1QeuQ/nldFeozCH8fleV3t6auXMIcBuigyKfTuSOADzoMq6+PMVAGCo8ob4eHpcPQRRLFv8fkG7vGgV+tmhJVFRoY4xUCFmXbg6BSGKj2Oq4b/bNrZwDSqN8FDAClxGDQ/lDorhGXrk1mUxg/hOdnRT2Vz6rJ8+stUS5zRc2QN/wLjNZX85gJa+5DEWxdQMF9Ib8FduvXkpgTVfwoli1YdBij1K2lJ/0YU7j6442HfHoPeyIbGq5dnDJj4vw5Acjkgfeh9FBhXLcVkzAlydTBAQT4tXVitBBJJ7rgwNYkv9TfPQaamEGGEMpTwPb5YBoN4TfnWdzI+UuLc4S7mDNDayhR87iWkHE39edi0jUYf7IW5cfMkURzk0PXF4bquzOqiMlNNoiP6N+uchrLm4GnWlmMln+7d1V7dK+GQwOIaSNqKEf3gWYRwbVWREMWoL6yKwtmJnSixnp5MWqQp9JGtMsWw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29ef049-fbee-433f-b262-08d86fe1060a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 01:32:33.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x2MwYE7Iwk96cJj7i+s6ji8MIBkh/DVjpwSjeHSdGsfInVoBi9pCdpxWjyO5AUiQwd5DpCVZWfpxIew0gFFpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add usb alias for bootloader emulator the controller in correct order.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

