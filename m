Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26F329862C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 05:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422240AbgJZEha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 00:37:30 -0400
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:49735
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1421452AbgJZEh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:37:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF7m9WUcVPc8WgM/RRG0i22Hrk1mXTqVuoi2EcvFQobvZj0r/pfl0hT90byxVjbUhb+qgk5elsz8AXVZtZmzXGWElKMSpvGbdrCv3K8A9BVzyej9+URtplO3YGQgxvci5p6IIBwQunPxHxMcAIuaBSMXNtAVQuG/sVqZHy7JpPWwdnmgBFz/HY96tNtLu2dfcdm9jaDs29q/As/3M33MGkjlrY9SoJPp7DPDBZFuYvYQl4OTOwILJK7Pwe8zbc8EU/9y8vC/Quj2y9DlAyeU4hLlAPAki11PAgy3OtwU5VTvVi5Kcn/l8tymdizAnv4hG19Q07Qmlc5gYfj2pvc9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k8NSHboDbgK1R/2mYZQ2qt+Ex4mBtHNtlcAJu3NJLU=;
 b=jfDCqw0P6ks5ODIsf/TOBq/eLFhUjtrzw4V7UDWZYqEnCQNlmNC3ovO4rsy6qG3k9j4iouxYkO9DM6J404YaEb6CdteLgo0IiclF4wJ5y7izE8g+EmIFjv/Ho69yW95yWP7o4U5Tqx1koT3wDStU6l4+gf1kgSkXA1bz8qJQOAffWDjePQfY7dDzze2Y+AH64nGbNXIZQ8pwnEQaFzMnMSrxuDqT81fdritxZQIpjJT/2E3Ynf50bKEcNRhUgA/YBgb6QMBPUxD/WleRzaA0ACpGoMnFWB/h4CV4KkSpMpsYSlVOjpCDRGWDBquBUVT3Ze0fxYFiCZTNLjS5Ebrdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k8NSHboDbgK1R/2mYZQ2qt+Ex4mBtHNtlcAJu3NJLU=;
 b=HhLfwyRTsy7o+EdBeUL0hNZ1koSgicBCxzlfMuTdUPRR/lPyK4X9HfbRio+465QN6K3Q1svNmbEs280MvpNC6DnC3qeaKxGQVkaFqNVj1ysq7sokF8Ohtm7InHmRlTD27h4fSswwtCqiBdpeKeUr9Bc2fgS8QlI3D9hsToNuhWk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3579.eurprd04.prod.outlook.com (2603:10a6:7:88::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 26 Oct
 2020 04:37:24 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 04:37:24 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv9] arm64: dts: layerscape: Add PCIe EP node for ls1088a
Date:   Mon, 26 Oct 2020 12:27:59 +0800
Message-Id: <20201026042759.15155-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR0601CA0021.apcprd06.prod.outlook.com (2603:1096:3::31)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR0601CA0021.apcprd06.prod.outlook.com (2603:1096:3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 04:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfddab30-4fed-40bf-de36-08d87968d541
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB35796218469ABC1122D8956A84190@HE1PR0402MB3579.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb7GeyQIpHNfcPa0DuF3hJO6uoZgzYrFNF6nP3v/wSWbJ064l51YpY/VU0Lg6jr6RuLUaD71NpkH5njfC67IE3VhDfR/mK+6xccxspotso9eXlfoeiCIa2Wgi8P5LFqrKg0MXdgmc7nuLnH7U/EgceI0IlHXnar507Fw4ukz78XkqYOyCfgZ/er/T5U4tW7VlJQA39q+5Q43hYi7JFuQ2DuUv7iQ5EL1BIHPnoZcYtj7PEQXvWgSFpw7+Yk5QXawsKhIJ3uTguiKt9BMbCbkY0vSDhho/dfF+s4OB0R/iIz892SgyeqjTZuZcV7adSA51I6WLQR54S3gG9oI5xrZ2CJLeRFYwAItLdClv02PaPk5ANaqqutbwaG/zLw1iM5E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(6636002)(316002)(66556008)(66946007)(5660300002)(83380400001)(66476007)(52116002)(69590400008)(478600001)(86362001)(36756003)(956004)(6506007)(2616005)(1076003)(6512007)(26005)(186003)(54906003)(8676002)(8936002)(2906002)(4326008)(16526019)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 31NY/k5ZqwKjgS1Pxr5AXgAp/AkOit5JNA5VEYoF5Od2ZIdKI/Z25voZwsRKwVM20RxMqBtFfGNRrO671ahgfqsBcklT2FrXFgeXuiMzUQ3VyMlnw3pA0YUbK6O/rsIGIAuaAn9a0uPFrSyZzN+u8OZGazGQfquTvFvZ0rooIHkz0nvX4LPe+kwkgZVp1HUAgtfZ26cbbOwde6RRXI6U8u0hegphtvwKKHoQ+o+Jh3kpD4BjoiyXn479DHPRHZvxsCtAv3HyV0bBLR36iZI0DhTjiks0Gt/q3r3yva6qhZinfn4TeshJi5wFruEpOON+1m82nfjzhKhI5N6gOSqpihNBg7Boz+7BH+AcyDW0dZ8GxVjkr8CXV+gksH6ir+PKAG44kyvINRCq2gdocGZVAIaxRndTZtNsYynTkXCNmepNXYNrVezYyyeaNiJ8TOV3YwnqV2PmRjH+BDca3e4bZYczSN6PvUi7GAyKpW5rNJJJpGSGIs/vxh8K3nVRzIaDDIg40p7uxsEVpr8iilxl4OED8lGboJGC1TW82BelTyndXS6JHgXNws6yfMkJVX/yA8WyzD7melfUHW1/j0zqqRKkU3RY1xPFpUi1dX9t3pghOLtSr6Xt9YyLeIFziFhgah8etmSE+cdWodVK6/Jijw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfddab30-4fed-40bf-de36-08d87968d541
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 04:37:24.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrHgfiIPtUmRm7fGqfewGEuiV01mBBOu4sc183u08H/PUirMY7RpigCeyaHXxdtnrE06UAy+GlYQoY5tHq4Gpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add PCIe EP node for ls1088a to support EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V9:
 - Rebase the patch since V8 patch was not accepted due to conflict.
 - Correct the number of outbound windows.
 - Add lables for EP nodes.

 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index ff5805206a28..8d8e610acba6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -517,6 +517,17 @@
 			status = "disabled";
 		};
 
+		pcie_ep1: pcie-ep@3400000 {
+			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+			       0x20 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <24>;
+			num-ob-windows = <256>;
+			max-functions = /bits/ 8 <2>;
+			status = "disabled";
+		};
+
 		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
@@ -543,6 +554,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep2: pcie-ep@3500000 {
+			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+			       0x28 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
+			status = "disabled";
+		};
+
 		pcie3: pcie@3600000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
@@ -569,6 +590,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep3: pcie-ep@3600000 {
+			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03600000 0x0 0x00100000
+			       0x30 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
+			status = "disabled";
+		};
+
 		smmu: iommu@5000000 {
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
-- 
2.17.1

