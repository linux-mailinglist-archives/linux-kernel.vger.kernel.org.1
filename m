Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC02A2305
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgKBCZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:25:02 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:19623
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbgKBCZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:25:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRVn178MHGX9+xlE8w025omyl9TetISSy1JGWSOKUKo+sSfQ3MTRGcvWhQSxvBhKKq69saUeFaXELn+sFIjnew0fUBCQ0b5HCOhRnm11Wb/VXGIr4XCEdC153vN6YIq5gaKTrjPJupOZo3wVlSLQEWD45uxNDwHe3oRYH5ONgOI+qizgwft7lbpHnn3pdOhgjhkOAPFMrZGFqCbuyZ7bex09mSPzL1YXCKabqf4PhCBbwZMLvGwkorPNtGw2uKf5bWf3T0Qxihf2bVJ3wKoobNZ1/nKWbK8jaQVTwOp2zjK0Y8crd7KtIzUAjNyVtcOfrby3SWowWKemm98+sVgfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/hXIYR+1/QwHNSoIYpcDyHuXohFMlgdngnQsfdSvGA=;
 b=NnuIkkDB80WBycC5Q0mpt4+/O1IrHwQnXaBzEr2raXCgCRXFO1j/LsNbsh5b/49+Kl/X7jonfsuytJg1EsYVx7HPuvhKi4k8lC7gK08GXVX/J0CPuZ4+rnz4E815TLd3f6TBc592L4BTcYCYDnVN15DTF382cx/GmPrLSD3GLL72ubGyC6aj3dQuYwqWMjjIWBqGwbrpbL4SAw+73YSoz11izOOzlOhxAZoe7fNwgU44QNCfiIETd6XHUbROmrah6Z9tQnlCarNXDRw0PXYgOKb5s1Dw9DBu8ERK/N1OyskaLttOETuF4n58cz/Ld9iFePvxY9c57jwAC4YVA09LdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/hXIYR+1/QwHNSoIYpcDyHuXohFMlgdngnQsfdSvGA=;
 b=qB9WK6ut/pXFTAcenUZ3FCqBvTlsz2WwSg0ayJr03wqsOxay9JJhh1uHfgpArHPBtU+ryBLge+E/XurbSWpiJpofAW0BkoHeupCRvieh8JOsqSLOr77MKXSG09aJPKxZ5uFIH8bu9ItnH3EePmwgU9S4NqImORgRD6zslKRaUks=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7674.eurprd04.prod.outlook.com (2603:10a6:10:1f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 02:24:56 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%8]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 02:24:56 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: imx8mq-evk: add linux,autosuspend-period property for IR
Date:   Mon,  2 Nov 2020 10:25:25 +0800
Message-Id: <20201102022527.14265-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
References: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend Transport; Mon, 2 Nov 2020 02:24:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: def15efa-e2c9-4e5c-ba91-08d87ed67d10
X-MS-TrafficTypeDiagnostic: DBBPR04MB7674:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB767483B96611BEE8B5A60067E6100@DBBPR04MB7674.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nPgYWqtYzXqRmzK6ixEB5zm5URcLxRQzgdoG8xCng36rd+PQ1pdw49+9ZID5IHQ9TPNstO+oV1j3wjvATHE+8qz3TN30F9qLPj0BJKwVszeFB6J/Ba6h2xFXSX3evA4obX5EXk1Jw+7mZvN7AdHigmXfDYwAT7xSGuIVFYHGYtxF8bl4UIdPcYh/biD4u8fmqYAoYXTdFgodCQXoBaijywxKBrjXpK6SZKMx1oO+6hUmcJd8YVAEkqrWuaWpDXTY4jklTP7E3gOWOiXpHfTrUkEJmMchl2rsf5L7cljFsRTJo9KbOWq2NkLbtB93ggXu6YhiViZz5vBr7+BulTMideVKZNWcQuRuA82v5aeBC+jS7jMzXV8GrY6ngGVjtvtoX8PzI9JgmgOxX7AcC+gLbsmhZMiDF7Q8Bljt890IM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(186003)(5660300002)(16526019)(26005)(2906002)(6486002)(6512007)(6666004)(6506007)(36756003)(478600001)(69590400008)(52116002)(66946007)(86362001)(8676002)(8936002)(66556008)(66476007)(4744005)(4326008)(1076003)(316002)(83380400001)(2616005)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B5WFHafCJ8FnDJ30NPdveuBdVgq1c13ejU/xrGQoEfaiG+QDx52796FSMW4ZiTKWrTV9n3/2f4yYUYy5dbAXcIypbX1dG4t1AuSPMzfmjlqZS9NNdlR4CvQhD9LAcFFYiKeGOfYWnum8ZKQ549LJUwmT2jp7Pasv+j0xdpkIg6zT54na8r1j4/tncPi8Mx6g55lcjxskvmaof30NIRpq6VHT/onMR8T5qmS7CgJVEJu+emLLVh167HcdsQ+4LMQ7aKIzo5wZZOpHqanGcoyNuOwc/nAdWm5x5pSIvr60t2Pj+ieh5nsL5ZWBHvOfAEYtwUEyAkIh+UW7KAW83/5UkpdGBkz5Pdgk/rwpviE3kVXz14vbkGBq5Id1+e4sjia6Hm8fztVnxMKDWl1xUx9GdGoqm5Wz2ewJKJVh3rP6yTCfVa3mZPkfVvma2cwZY+lr3CmTomPiOxfjtEpyfpbopuHkPUZ3NoP3mbRW08gKlUcdqWQM6FhUgLcbQzjsmHwoot2zTjeJ+GXZ7QCpOVI+Z/LLs98p1h0hIuYSL41NL8CEA4PqAzrkpH0fOwRZfqW6wA3nv8jGwvgwXoJE05C+CLpLKXLXg0v7wvj3Vby+KAnH+5ZAmS7SkAkkXUWdLzwcp3PkhHCq9h9f8NBBsj2+cw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def15efa-e2c9-4e5c-ba91-08d87ed67d10
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 02:24:56.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYEysJ5MMr3dkXo22Xfq8/jASs4GXiKcsfbVaaN++A7XQqpO4fuV77QGLh99DbxL0NW3YgtvU2TuGIPQr0jiNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux,autosuspend-period property for IR, details please refer to:

commit ff1c9223b7b8 ("media: rc: gpio-ir-recv: add QoS support for cpuidle system")

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 2418cca00bc5..e89d1ba8b77e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -57,6 +57,7 @@
 		gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ir>;
+		linux,autosuspend-period = <125>;
 	};
 
 	wm8524: audio-codec {
-- 
2.17.1

