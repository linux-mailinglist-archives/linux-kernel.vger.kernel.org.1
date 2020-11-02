Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E312E2A247B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 06:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKBFx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 00:53:57 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:51182
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbgKBFx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 00:53:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCNfBf5OW1dA+8sCKtQZ+Ph1D++GTFyEzDE3tne/llT6NtBk5lRq8aKt5r3/q6gpb+mBQA8vL/05tnmzWEaATTUwCrLgcY9OzYRy7VLTfEveSbWmCrVyVpenQwtuKM9NJRbHneI/BVeRItGcmSbdnwKTkL6Civl0Jpcd/+hTEtfGPxfBk80m2k6EyqYQ+Eg2OkPcHvfJGFq6AN+6i0J8jvhislDNdBnM78ereTbHogvs+fWHVwEB6qrjQXx69tSlORLJGJJtcwUTl2QNE7Xu0bw3kESMmokc6UZu6Gx4vjDR9PenC4IkZdxKjtBXm2RJCZZGtF8vAGSUdzHM+J9VyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Iv8pIwCa0bGIk3lGt7KRSYNyWc290gJlM6jWkW1OeU=;
 b=RxRhdhHxukP5P4DNPqV9HRR7yIb+Bs2eLT5gkm33ztR1InPMU4mlfZi3Q0GOIe8Sl852ROYN8y/9NqdfQknFc9/GFyaxQysAX9+W/THnpP6XLsAT1ei15yGzzty4A7PhFn0TSCnhq5gphZIjsMdraizDI20ZFMGPk/GN+WzZ9K7/a1QRYKnti+ltB2CWDM2AOJI9aOPVYL/Jzri5kBkqIxf96y0nXkwJRPY6zI/gaUMw01sUWad1/7oaNnn0JZaHmNwOTp78C+ZV/orKp8WPiHjcDbWM6FN6siK/rrVkrE6HwO4nLHy1bbzsq3NVcxMz3ogz9enneTMQuHdoMJmiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Iv8pIwCa0bGIk3lGt7KRSYNyWc290gJlM6jWkW1OeU=;
 b=Wuk3lLPFCVD2UvTLH2fLvufqJ3PHRooytdgPcb0IpWMQ4EC5bqemGK3BeVZsG4HLGE7Zj1dQaNw4PxUE1TxeE+HOUaFDUW/GAFJH9p39U6pb9qhVlea9OLozkhH+am7Jj88/FOnjErjs6Q1/e65TBRvtdHZiot8BYDA3ZpwSsh0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3372.eurprd04.prod.outlook.com (2603:10a6:7:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 05:53:52 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 05:53:52 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10] arm64: dts: layerscape: Add PCIe EP node for ls1088a
Date:   Mon,  2 Nov 2020 13:44:17 +0800
Message-Id: <20201102054417.5792-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend Transport; Mon, 2 Nov 2020 05:53:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab336ea9-1e95-40be-535c-08d87ef3ad4f
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3372DE993B07E58F0E6620C084100@HE1PR0402MB3372.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeyJC8fWhuP+AQWCC0uDQqSwTI/01SNJxc6D6lvHAHNPdBnoQe6udK+7JmDZaWc4CjUM2VEj1gPnUVX62a7iqsewW1kNm/QTkfIja4vwc3I9dj9lbd78GRiTzC7Ty/M4eyDpQs055Ss+zLjEswdub/gvmmU39+vaEJ1yTY8ee/yCzYyC6Ylse8OZoAiWBlllNCRmsWa70p6CUJLmj4MQIZFiQRbpKJUPinKARxlGjy1KYl0EIGzByVVpU/CifJgsLAG8R5X82WWL9+LC+/IT/JiLzXSMSKFLqJf+V1POeTmQvQS0eWM+jSs1O3j7Rjy079h+IFUyB+EqkjSng06PU/wodwhTzMlCucH80NrYeF86ets0nY5YJ24hojXNZR0j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(69590400008)(316002)(8936002)(8676002)(54906003)(52116002)(6636002)(6506007)(86362001)(2616005)(186003)(6486002)(16526019)(26005)(956004)(4326008)(36756003)(1076003)(478600001)(66476007)(66946007)(66556008)(6512007)(5660300002)(6666004)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: v0IuvmKqgo1ygg2DnVdxtEhjCIrjauJxh00bkaFm3O5ITMfT32GEFgUOnuCm9uBVli5bRbstUyNDS8O7UOKA6BBOJw6aBj/ldMhq+JfyNJ4p6n2LDrBbWbrhA+NAL4442aGJaV9EDFU3By9A/lpVwMyXTIYhGrrsWHlhx73Vz2zCbhGFtXHHndeOzCL1mvm1qhMzb2X0mM9nAGXposi+JxxJMLM3G+ZGhN0uHxnxRayt4FtcuLxLvfXY/JpVapB1QKNY2eRvocNn2yxMAU/mdWduBPFKMTquhNz9ScnrV8KghFUMx1Xnn9ZkXaoZoJB9G56KmUeeHmliIp61z0DLPduGpCHK8ySkdUzJVhx55g1Te7fYqIGr07WrVbDm30fPBEMufHF3PQVzZWbNYW3Yb6xZiy08JQQF4cdEoc6xt0xFrQe0k0QkvtVDCL6xJI7ZDvpPHkv3zo8tI/YlbCz1ESAauDXP//DR8ciY7JVH3kGc9PEdDPBbcUJqCbSKWNhBIA83cUSCOnkys4xqNpQu140RdXNmp4ZCs/3bRIKSdHnFmO+e93IwYrlJzIAYxniw4S37Iy7MX7lSTjywhxZb6wFY5dMPgD3fGHMgAkmnM0FBajleUKWvBl9VPLrLIBiX34mg4s/60MVsr2NpiybdtQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab336ea9-1e95-40be-535c-08d87ef3ad4f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 05:53:52.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBt/8UQNklIUunBpBsn8wgR236vWFoG3Far7ir9XOZgCyj8OPwlxOw7FwfBpbhwVLp3WtK5wePB+QwETb78SRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add PCIe EP node for ls1088a to support EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V10:
 - Add a space between compatibles.

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
+			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
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
+			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
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
+			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
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

