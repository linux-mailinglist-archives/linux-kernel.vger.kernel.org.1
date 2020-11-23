Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387002C028C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgKWJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:51:43 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:49030
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgKWJvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:51:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD1LL7LSvlY5GQCRhte9qyVPBKCZsqQph/brJ/gIqU6OAjakLJVlSLZgmWCpHgBFYryiZx8eyCVSEY2QlYf7i+4/Mmz6nhTJs1Sl/fiJiLaWw9PV/vn3trK+Df7MlN/oZdWwRAh3i6Yviyq+/60Mebaj98/+WAqe167/7rNCoxsheTEIqRzlI/PkDPUZmhCAKlYE/99L9BZoIaDgwsOUy+aN0uEfSEjTrmhN6vuu8s8O5zUusS9KH+P9jA3mEX6+wO0iOVWDwuVy4mMkJ14CX/b3fqZLdE1+QHinlrO8yhQOyhZij4npMmh7CtG0iKHQQk9PCNqsk/BskViWiv52QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzQOv9x9rg0lGCAYQolEokWLvP12XsCAPE9o6lAbwms=;
 b=dAdQDoA7Pec2tGItji/hrGDjdzxyo3un3PPgX3nMcWLeRvXsE2NAQHQoMOJ/0FFgt5PO5XcIw/7Oc417NiK3fbEuSkD95Wa8dT+PCdFtA+VkqUrWCw7VV8xUQxyOzjoHXxFhbj1UtZN7PP7MTelCLwQLzhboVTQLytzdsIkh/m03py0uNu4kKh2XZ4M0Nxv7GaWu913AFOLXQJWYHwyKpLZcf4CUnm2B/eOwIOupBZ65BNTJCbhEuI7TuU/JkniusHSR9sX+E0GUYdLC+TxB2drMpNtPfSiqHsSOFjXuoR2QrwiiM/AF1uakXZkhub0O8IDGe2uOJGiY0YZ2+4X1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzQOv9x9rg0lGCAYQolEokWLvP12XsCAPE9o6lAbwms=;
 b=rtZoZNi/6gr1jwiqA6zBPYv4jmsgBWYXKUcE2VdkULSaHTe1MyK1mORHLcZd9OUGoy52zMfMx4db5qnS33inKcaKYehIxUOXbhr0Uh96ohhdJ3spjBzDvpaceb63uErEyayUo4INXD+Ap6LTaA+xNP4s0nyEiMzpeE+ZsXzbLEg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 09:51:39 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 09:51:39 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/4] arm64: dts: imx8m: add SoC ID compatible
Date:   Mon, 23 Nov 2020 17:51:06 +0800
Message-Id: <20201123095108.19724-2-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123095108.19724-1-alice.guo@nxp.com>
References: <20201123095108.19724-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::41) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 09:51:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8c0998f-74b4-4aa6-e2ee-08d88f955fb3
X-MS-TrafficTypeDiagnostic: AM7PR04MB7048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7048644FE42E80D373FF1400E2FC0@AM7PR04MB7048.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8ZT3ksQ/YFLd6l3YdFJPif64XzyNSPD83ZfWoTSFC3HZD+lZl2MHkNzZbT5urwJE55Ww/HdiT53XBF5x5vpR+uoj8+Dz9JCVHDJ9C6ynaV9Q2rkaVdt1E6aeKxJILbSdsLcCHdL3WC2nU/BmAmH7FAtZAbX2cWMJYuNThtGI+8hBzoVVE3CaXvtL6Nb7IAksOjmaDEYbfuIld7MBID/KTa3mJIirgCfnImikez46C49/Rx3DPDicAWKXuwBoW7RJxMQmvySp3gXY0uNj+xZdgEHw9dhEYdQvvtFdCK0AgamtZLoWzjOzPL8h0DUsTDk/4DEf0iLyEQ/GNJjnxRjamj/zVo1UoK3zqeYQ2lwPfexd/ddCy8x64LM/W3PruIG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(2616005)(478600001)(6666004)(4326008)(52116002)(8936002)(8676002)(6486002)(316002)(2906002)(6506007)(6512007)(36756003)(186003)(16526019)(26005)(44832011)(66946007)(66556008)(956004)(83380400001)(66476007)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UeYs3q3sTGqBE/1RFErUwZk9n277GGDS6IUToB5DCKRBELBJKjusjJBMXUafHZPQbqd7QtMNqwzOz+876sFQkkD+x4rhpldaADTxYPvxXKYXD8zBmW5Sz7IhRjkkHSAfU5k9GzuPoN7wjcP47gn3fPOnvAxmFVbd/p3rtuWUPwqtobDjXIUTcH/46slnujentlWR1div4v/CVgBq6/Sn+fMneGKcz/qiDryuljOSN6sYkS/qp4XsSIxjJvWEqonw8xnB4SKenr2CLyNsgoBZNDJi1mVh+il/PWeEeX3sooEPjkVGLvH8x0OYWmsm81ejFg3Z1OKXa0XQ8pw8pUDK1tWg7gKrACMbg0yN08nLvw17QvOZ4/ffnxm2KcbQq776yP5BgQxxoE46Kf4M2LSxdLxp728L6tr0zrBYjSkWX5rVUBzqNxs2uQMzQu2sdlg7/+jSd0WEEiklpBSfIER9DqgB0Mlka9bYJH2nA8Eh9ZnuqCVmAZoKrYFRwzks4m5kEbvx0ZdEx0LVlxKJemhBaxzfHc9AbvNEj2jA4kN6Rqi31OHupQLqq19GK2qU5HkNK9QuqZWp2wpO3ebagh4Hl9KTblanANSLymPcOAjwrYqkmsEw8TqSupl4T7he4/4XypWycK7pG17sUd6vD5HNA5Hf/CL36ZdUVr4ph8qoXdHOQOOLNpzISxifCNDvloAt5a6sREfkePURKoqH9chx4TbYsdK5pvbcycKBPFs0C0kWujIhPN4d6ZY8AhFihRE1DXG+k3Mt0BpEStUIG15D3c3+qmp8TQs2cXQTdCblxZbusJuaPOLTX3BpdGiUM08m+7vrlp7rwQH/am5xd3RBhxBK+5ccQ4qb6QBiiei98D2BHwOq2d/q0SkRFbhmQtjmZECImIp1em+qu/kJi3Rc8Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c0998f-74b4-4aa6-e2ee-08d88f955fb3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 09:51:39.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwFfKh04I5EVmlYQVyk5rW+9OMJ0cAZb9QgTlGxUXt408Hc1Q43JMsUouHfRBr7L1jHdGkCaY+sWfMoI5nHN5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048
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

v2: remove the subject prefix "LF-2571-2"
v3: none
v4: change subject and commit message, add Reviewed-by
v5: none

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

