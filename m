Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9B2A2306
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgKBCZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:25:06 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:19623
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbgKBCZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC8zVXHnIB3alqX5AZ57CpqUXtiUqd1SHIW/poB4EtNdbnUzCgqYREa1oF/vL4MmGSbI0R1TEN+LAFyIq6+eSoQa+a45SQaCDYlzdsYBfJCSDLZ1i4nzzVPRi7KzGuMwAlw1p9sMYzzesw3MEn9q+STpjffsEbVuhrZycrbGdDuv1HDXxbE+MK1ztveRG+BaJp2y1vnuHk1D3664IQjOdkWUbzHd1xv1SWSkjpngLmDghuDzcMLf2u+5aFbbEjCgIA+NHpatJBz3Q8fHtf2rl+S/2AwlGnOtukPMe3lkQy6YJg8RIwfnklfvKXZ3xkb3YUlRTyuJIG1RhpvIiYpdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FTd8waqFsZQbV4tc3waJZJtvT9/xmw0PQRudlkTLBA=;
 b=hlygwMz6vty8BN4pzlFVoQKWza9Bo4luBJDaujtBhIIeQI0NIgqpTfMRaBqwU6pCRLLhrgXhVqpoG6mgppuCysJT8ACsAIFFwE/vonRfEcjl12SeWrpZRUeOVSZiKQRy+FD7FMvdgyxwscxf5qYunbGS3cRzY+A3TAeed4ZcjPj0T8W+83dvTfrBPUHFmwuMVnpIbJP5pKB00lX2WK+gaGLkO2waw1Ttn3XOoob3KwNq/OAPsC4xUQezf5vuyLOHkgzzP14d713/Xkt59m3dUSHSpZsJbSiVIwn/hmKPblIozOxLIb7fNfwukFeyz6ta5AHgo0whsMZdWH4F0WW6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FTd8waqFsZQbV4tc3waJZJtvT9/xmw0PQRudlkTLBA=;
 b=LE7itlDaaLsxVdg7pGGIq0WLm9OqwaZcJlzF1sJBiRCqSwd/3UXhW9mEqk0WWj0+9fQDO0lCeAUpk+/NRlLLeY8O6l+9K4WwT1GvXingcht2lWtW0uepkoYTWDmMx368rJJ5LxqQqG9NkCabSVwtDa5+NvYsBM1zxZfCI9dljmU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7674.eurprd04.prod.outlook.com (2603:10a6:10:1f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 02:24:59 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%8]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 02:24:59 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: imx8mm-evk: add IR support
Date:   Mon,  2 Nov 2020 10:25:26 +0800
Message-Id: <20201102022527.14265-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
References: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend Transport; Mon, 2 Nov 2020 02:24:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2632d800-20e6-44af-355d-08d87ed67ebe
X-MS-TrafficTypeDiagnostic: DBBPR04MB7674:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7674685C1907F0C2194AC92CE6100@DBBPR04MB7674.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZ0NHzbudzLL2D23lEu5y+SLYEWX8Eq4wTPM8BhTmg/cCwAK+Rwc2wDD9ZFH01W/tFzQ0W2FJ9QkXdj/YYlILW2zq+ynN5JZR6VcGi9Xtc2QfpfiZJCBNUDQ9wNNJsQyRyk1j9+bLJYkBPFZ78OSvwrpBFQlAgizJA22iLdWmxI/URK6gN4Sjlshqg1utLWV5rsxz51r5Nh+MY0QGeHVZSCl0vscDmFqF6zJBPzTMdO6yf3QN5AaxgXiqeoZmRk3XrI6jATrCP6SDixTgV8SRmE+o6DSLVYOHWVJk5cUFUR1I9Wimth/ZlbSiVKqCrh4WiCioaLpSXJa8kvEX5hf/lzV82/wqRXPkigvG8pt9h4WGOoc1M9l0KkAqES1imAaOeoRbm76ZjKddsbAhhJKYPWNq3DpQ/dEak8V5qLQPpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(186003)(5660300002)(16526019)(26005)(2906002)(6486002)(6512007)(6666004)(6506007)(36756003)(478600001)(69590400008)(52116002)(66946007)(86362001)(8676002)(8936002)(66556008)(66476007)(4744005)(4326008)(1076003)(316002)(83380400001)(2616005)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Lk7N1FLEqzWsTheu+4nFhsv2vdlUwJavIiEOmWTfcXb2vQ09yeXvtfIaiIOqNIKTXzqvRJAS7jAiy2u9fs0pUFWnoeDhYYyTkhk0R08ndGp0QumksuvEStsoLswRQTZhdZutT2MCEqoWBo5t2BEoBux/gimoQhaN7/zVKdrVCo2i2cCeqJH54Qgx5h/Kt8hwbfvxqGEyGlzPXeSGJqweV+4/oRMz0U145MxevhHnSFzj8m5jUhAq4dX14vXy8rjpYxjN75TjDkmTQD9IFvDKPQZsEYvavUi20raAd2lxqDHdLYLn34o2UpWjeRBM0KDRYILzhI9hKVfzaF7QjzW5RLcd6dpdJUW9z0EMBlsttFRTyvRb6drQolU/PnM6XggIUH7Si80vkobH42NnY/A29FUw0JcdY4EzDrzAPkUJxpX5KdDCfAoHygVIirS1mbUOmLzokJ1dbLbwDdFdEa7Gx/BMx0HzIHWv4B+xP3Cv8eTmxk4TTakEE9exyYv28c1neOWpgGkHJY2nx12x1jQlsyINLUfheRJD6ZJMpNSZhHxkdntpFEG8zk5ig9xL6pBaUtiy9y7mDc3tyIR+1iaidFM+mzl7BKI2nptopJ0+xlIiBG7wryxlxj0y1FfbSWMwq6NZEhUVtPnErG7tB671lw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2632d800-20e6-44af-355d-08d87ed67ebe
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 02:24:59.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3huWuyoj5Qa+oRawFFDDXury3tlRd7rB2iUQr7HVmGxcSLdzfVpZGO7yB/iN/rqyS95msn5tv/TuYVFIMX+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IR support on i.MX8MM EVK board.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index fbfb57b195ad..6518f088b2c2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -41,6 +41,14 @@
 		enable-active-high;
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ir>;
+		linux,autosuspend-period = <125>;
+	};
+
 	wm8524: audio-codec {
 		#sound-dai-cells = <0>;
 		compatible = "wlf,wm8524";
@@ -364,6 +372,12 @@
 		>;
 	};
 
+	pinctrl_ir: irgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13              0x4f
+		>;
+	};
+
 	pinctrl_gpio_wlf: gpiowlfgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21	0xd6
-- 
2.17.1

