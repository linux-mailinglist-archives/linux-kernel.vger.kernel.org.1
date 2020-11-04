Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB44E2A5CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgKDDH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:07:28 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:18657
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730017AbgKDDH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:07:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/q1dIyXRAn0qY0GSsFR6usapJry/ckFw77ago+UijmSwT84KgubgCV4pkuwMudUqMep9fGjOLR+W3dB/8iIprfm7jF50Asp75HVW6BVFmb8MZRWo68x/+OujLuItrMR2w6DCsJo1W+JTfi5+N0fqM+2Ix6jRPqfJoTm3XMS093FCnMQEQsan33kYPzu68oNLfUhaKh0cD5d2wJRhQiYVCisPbiEdL8H4aAgA8qpj58fq9rqutj0PfBn29D3E0CcDSz/wIH2Z0KwCxPpoHpx+wu3pGOjsphseU5XDv4+D/HZrNqB3FRHfMru+H/nRjUQROr9OlJKfWWgq4fAlpqPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W/zgzbITw41BieKDty3BYftC/0bDPczpFFIfqUV2N8=;
 b=Sn8iLVrkNsXRndxBKnXHCwSU9QHMF/L36WQW4x6BLszUkFjv8thT70tHW+alOAUYFLiwOFMp7ewgT9bP94v3b3GkNTYF9UgoFZn1WNsEVi6/f8vuUOVv2CA5cVLRzNF/tu02wjn6oKm2QY5BDhCncb7ZxrYMU6C6Z+oTMWW/JoShRYp5puxpv2DyjFFVazOg9d4VTmEL0TQOdytKmywvwvN8f09g0blInKH/aMsb3UY8/q3Z0JD1MqSpl7Ye1HsZ76mfDH0OBSsRXZftxDZCVBW3ovjUqwpGbGxE3ZPI1dOWP0pzUmC6hDvwLyDSUzusgLpIkfDxhKzg5oHG31tYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W/zgzbITw41BieKDty3BYftC/0bDPczpFFIfqUV2N8=;
 b=Vl72K5mY6C5jzGd4wmCNU7nScBc+syixK848Hv6iirWMvxBU+DfKuVGqi8HDpxQ7B4XIQ92RQQdc3GCt27PPyTPrh1dzxW+Ii1gt7QArmoVDPH9dRppGvIyKtQzvkW+e7dRGY7b4uWAZbWCOlqOTEFA0H6JYYASN+nI/9bNa91U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7365.eurprd04.prod.outlook.com (2603:10a6:10:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:07:24 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:07:24 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 2/4] LF-2571-2 arm64: dts: imx8m: add compatible string to .dtsi file
Date:   Wed,  4 Nov 2020 11:06:43 +0800
Message-Id: <20201104030645.12931-3-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104030645.12931-1-alice.guo@nxp.com>
References: <20201104030645.12931-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0225.apcprd06.prod.outlook.com (2603:1096:4:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:07:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc14c003-33ce-41fc-c05a-08d8806ec0bd
X-MS-TrafficTypeDiagnostic: DBAPR04MB7365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7365B5908F463B4621C9FE67E2EF0@DBAPR04MB7365.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fls4IDtlochgDaXJfJZ8nnVyVU4nnzVn1ICTKGK3TpBOWWdL/nGb9/aNOez3k/o17nB6Ghl89t1uMRxorg5bGWBkIHwNo+79hItIZhLH3bobuaKDKsPKy3Jxw4nK6TRL25xGHJQAnjITI1M9CLuNwUrfI/+oQoow7hQgU2Zv0k+rqGG4MePgqGYMwfEx1pV7/ovt4yLbxLD+Q21YQk1SnaEBr9/roYUX1MzDWHEJ9qhx51k0BgNUMi5rU2Ie0284WrN9PeamtBB9xBncrUsD2lYY0DbjLSsHBwhgPCgdbUwrv9jPyObSD/lmyuHNVFPQxZmBftr0OieWn/obQwjtWMSEkPxmdN0KDZeVReSno4VPcn40xIfnlvs0PtAiPOspl9DMYJJdgik/ZkWSFCx7Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(1076003)(26005)(6506007)(2906002)(2616005)(956004)(36756003)(186003)(6666004)(6486002)(16526019)(478600001)(83380400001)(8676002)(4326008)(5660300002)(52116002)(316002)(66946007)(86362001)(44832011)(8936002)(66476007)(66556008)(6512007)(142923001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IGV2ooz2B8VklljdwSfF06YsfqgIlDIH7CZtejbe+7xz/4CVRXpi0J6nA7Tg2eEaEUdaDJn7i9Q+myKsIzJPn5AmYQhBlKEHF7zVfCuUWXO9ZHO7FP2lUR6bM9CqSgX0UK7Kz9xnXP4NGHfGF9QSP+oHI72fNmqFK0eu7nHB1Lc/ifOZvfRUpOSAaGceCzAyrwJfSlaKA73zoYLVnXJg88pY8X8XkUY/BccgP6XLDAEQUlL6+5VWY0u5Px7qghD6Ya4BIwkuE/n9FZs+3DHsQ6SlQDuw8bpf7KprXkDCufC9dwkBuci8Zq/Pye9wpq4B24lwLh1+Zo4xpk4LXs9KFlmfBCvxkuZ8sGrvo/Que4GKlGGdWui5iXI5owuu2/vRvWtu2zzHFAuVNc00FEtMHjFxJ9zw3EqVRC22t6svKq69PcIgcQ5LhnC9aLFEXEL2tSjf35j/LD/4nKhfXNXHg2THHpwPhVGw+oJ4w9W0OxrJBWF/SWmQ+klIJ38gP/+dF7KuSLyjAk++hUGyMkx0cfyGU8N85+hGCK1fBcvmFaqs+X+5EE235FerlUA7/qkTqQj/1XePv+MOj6lGGayNveEGGsmH7hgUOmK6u0cTWQnFKiTPuNTjNYdzXa5RgJ3NbooDmjmql5MMZfGb+JJXMw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc14c003-33ce-41fc-c05a-08d8806ec0bd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:07:24.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XftU0yFdXJidYJrAE2QygYYtZ6YWv32FTbptwE7qK2o9VvPibm9oRIf0/i+H63DcMTs4v+f90PhzYLGe+BZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7365
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
index ee486597afc0..ec71a5e8a062 100644
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
index 5e0e7d0f1bc4..a3c76bb880db 100644
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

