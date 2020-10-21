Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDE294D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442906AbgJUNPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:15:47 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:62253
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437394AbgJUNPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri4zt3emXvdOs1oZpjYztMdlbeiiJZ0oUwVjeB2CjY5CD8CWlrTHp5Pafape4gwQKfpiR8mR9g1zx3zziEmOaYATsTETP3zrhppEF/Qk08hbdBuucNySCzzbhpPFikOUFD97XzdGow87RMDG0K1v0lq9OdsEScAbsi9RUGp1/wbdV8jax5n04p2tV3J8VnfmPZzMXoT1rm4TqB7t5QZypY3c6hiv7iQ61cX96WZRzKeApkwoQcGjfqTpzcGMUMUlDj0dkf9jlRdyDvs+5RWruWN6Cgwe7jbKU7Ta+WIiVvnDFvwoseD26sG2ywdmCdJpVPAcD+V9Z3ev29jPmtg1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAL+RuC6sOBPgmdy9CPtMnJ3C3ef7Wj6C1za3+NDcwY=;
 b=kB/eiw67HvpItqzPVL0LeDjz+ZpMWoicbTCO0APAl+gpy+GvFIkhm/51sHQZ5/AQwlGjED174Yq+fS8ah0LE4/fg56OTFLuR7Pmp8czKoZlb1KJQHNPorVJafPLqIbIKTSFLET/wqyRUSU9st7NoTwrN0Eu/+T4P+CSpdy5kClupBm0Lb7WhBt6oDOTDywAT2TbKuvU3UYUpWp1iaFTVfzJZT0ixeZa4saZLm5nwl+NTB0TjT5Am1I0zYfZcEzfUiyfNMSS593MA859o2oxm4IMs2p9Ncl0DD5h1KCISOn7ewszId5abincFU2iMPbndAMpKDid1ZheFQDZHvA2T/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAL+RuC6sOBPgmdy9CPtMnJ3C3ef7Wj6C1za3+NDcwY=;
 b=qfCIR1Ma6vMCpB/p0Ci/xKLwst97kUe2KR25BTAs42yWJnfJUIayLpynKDEiqfktbggSjJdiFyQQ0hJUEZ3hB2eHvHf3i/N30YiCuBwYGYzmK5JfHCUg7Fs52728absdJxrRv/QsrQX9phatmygjg88Fm/qeeknK2ZeknoWGbpU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.26; Wed, 21 Oct
 2020 13:15:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 13:15:41 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/5] clk: imx: add imx8m_clk_hw_composite_bus_critical
Date:   Wed, 21 Oct 2020 21:10:16 +0800
Message-Id: <1603285820-30196-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
References: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 13:15:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e0d51d3-0778-4119-446f-08d875c368c3
X-MS-TrafficTypeDiagnostic: DB7PR04MB5995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB59958109E07D0F129B83FC0F881C0@DB7PR04MB5995.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHRvJMQVSWP3mnSUP29JpOA861PyEMo+cCKlza5FOVGLoQlC5m3QX3IdBl2UolqbIKBHs3s/JW1m09vPP7iySK9KxXJpYKEQicBH24srLCswZ9Woqk6KEIWhwlEhIZnZP/5Q74oBjgaMYcDSQ+kFsZMaT7mi8PY4bV9a9BW8ZzrzpV0Pk89Dd4vPa6pEea1WYHZOqSHijEKPZ75wNMHfwjz+5yL4TXUzXRUBUZNBjvcdgNrHMmdj/cSGNIZKsgpO2x19sPcg55N9Y9Ej5QijZsZsBX/RLwT73fhxR+3ZyOQktKGocXaAxjkcBM+SBt88S/jc1KMnQZs3J1doHWgvnBeiqxt+EhIJB9mZWl7yySSrz5mXtYA5+pdN8dR5AB2v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(5660300002)(66946007)(4326008)(478600001)(316002)(8676002)(36756003)(66556008)(66476007)(52116002)(86362001)(4744005)(6506007)(2906002)(2616005)(83380400001)(956004)(9686003)(6512007)(6666004)(186003)(16526019)(26005)(69590400008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rvvodbtUrb37CxQf1X1SAKRolctnZpl1oHmkxNCEq5kuqh/so9e+OSQfcTjvoQeTpSTyQeAkiRLSnM8TmHclsZWKzVXV54mpNmGLVs2G4iFx9DWJenqEe7X2NaoOEA2tGTkm75B6SiQ253H6r1Mcn2ybIP/gdXa3Ld3Ypw3WZRXc1c8z8WYd9Z06aYpIAelDdo7t9T2MDHq0OCGhNsAFXUXNpTI8UGv3351iuKAgUhPsrlhTcRlx1clh44MBlNidUI3nUEtWKOhVGYGkYJXTMe46/z5JArwFAbgpTUvAgZg0i41pDaPsv202JCXLAFVdjp0ZtPDWaRjswWQpIkkZmVKhY9ODZF7/C5d9rudJg2IjICpaiMHLL0dXrm1aoMnl4rkaDmxfmd3gXnn2sQSMwWttioiC+nNKmpgbd4vAmU67CubwMGsaKxfcucaw1TnnsJv86qn0/Ff3GNa02ct1SOYbSZ0hz2hobcrs7TB/aDrEQFussDS5tzrBReFjTXfYe4rOkr3GFrGc+4iIWYLYnCemTU5iS8XftUlDa9M8bl4ihChD0qUrHUWlYcB2pFz0nIDoFhprVivLWudEDGrBLMgUZsrXuyHe/oweRBYXqlwFm2d2M4lstgjno7b2H1o1hPLsnMvFftSZJ9QBBAVPbQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0d51d3-0778-4119-446f-08d875c368c3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 13:15:41.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcZSCqYsjF6LcmTb19Uxe+VdrMwCX4OnUZPwEyNtx3wUpeBQ7WhJSHKPmswjh+/PSsHs49wpYwtBOgde/SZSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add imx8m_clk_hw_composite_bus_critical for bus critical clock usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3b796b3da249..1d7be0c86538 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -549,6 +549,11 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 			IMX_COMPOSITE_BUS, \
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
 
+#define imx8m_clk_hw_composite_bus_critical(name, parent_names, reg)	\
+	imx8m_clk_hw_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
+			IMX_COMPOSITE_BUS, \
+			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE | CLK_IS_CRITICAL)
+
 #define imx8m_clk_hw_composite_core(name, parent_names, reg)	\
 	imx8m_clk_hw_composite_flags(name, parent_names, \
 			ARRAY_SIZE(parent_names), reg, \
-- 
2.28.0

