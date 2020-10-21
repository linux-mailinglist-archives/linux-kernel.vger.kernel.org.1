Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2A294964
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440689AbgJUIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:37:03 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:59471
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408254AbgJUIhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:37:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwwyTBMp/hGXORfUxss5AprjyPBBO9bj7ReAt9H44LX5PQebr8wDrVshHsr+JkOujU1JzVVoVPcN0Ixl8w2IDZ2Z7kUVLXfsyEGKCm9kkMKqDaDU/TlfZz+NPBDM7YNpE9K9+yZfU1r1kWWfe3RzsoksCyBowPAB/EibG8PQ+RuO5DcY82DlojyHPT+gUTzVMtB+JRgz7kP7QqqVgEiEIzlgc9nkjo9NGytC9uTSQ1tPt2N+ZYrXRfyy5azd5aMjHxYn3VI0FfscJEXqmzUmlm7xOY7gBfcIj1Mavq0reb70rrTvbaWdT2bZ0Vw8Jj/eHTLUZqDQnnAhIw1ko0OZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAL+RuC6sOBPgmdy9CPtMnJ3C3ef7Wj6C1za3+NDcwY=;
 b=lDALBHi053GXATIuU076ibhmtvGh6kciIt+7jZZd+pGm7RAzx4ewxywVUdewRN0CveWeBmUK7/yJT9zeIiIvC6YriJiBAYW8b1fu+GZZ6DFJ1lQ0tYmyx83URyzkAz6Z3j8sLUwGXpICn1F/yy9MzpWc3+rzl4rPn0tQO+VAkHxqAAzjO9aAa9hpbyelv3QW9bgK1hkM99WTXqES6H8EjL7+vG6+sx9cE2Vkd86I2gq99DUacnD/MUvS+x96LE7oYZBITp+MPiqyZ0NfYgCjShFgT+DhCNohDPPJO9zlzs3IB1kph1hNzpdkqezHLLRsBbfdnfeTJh6rrnoU8SbgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAL+RuC6sOBPgmdy9CPtMnJ3C3ef7Wj6C1za3+NDcwY=;
 b=HgM41u09cLwz1U5XyfrGABKEQCJ8FT7pkSDoTu2Zc67iQCMv45jfxpariXgSDy8PoifMB2FWcZdWdf3XbjaSWK4oMtrcCM6TiSTWj1hWJn5Zf1HdDp6A8xRk4H2ppRXUtmK1giiCGzN4muaeteHwNBbXIpmeJkDEj4aZBJ5ssmU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2376.eurprd04.prod.outlook.com (2603:10a6:4:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 21 Oct
 2020 08:36:56 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:36:56 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/5] clk: imx: add imx8m_clk_hw_composite_bus_critical
Date:   Wed, 21 Oct 2020 16:31:30 +0800
Message-Id: <1603269094-29367-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603269094-29367-1-git-send-email-peng.fan@nxp.com>
References: <1603269094-29367-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0155.apcprd03.prod.outlook.com
 (2603:1096:4:c9::10) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0155.apcprd03.prod.outlook.com (2603:1096:4:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 08:36:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1aebf226-bcb8-4162-ed27-08d8759c7816
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2376FF8B875CC7E00CF53BAA881C0@DB6PR0401MB2376.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBeOkBqwil3SAHmh4b75I0kAh+NN5uNGEJuJQsCCnZrjkkhpOBkKEVVSgtxGlrKfuN9OuxU06Ng388jfFzKDdNdCkD6cAv/2aP1kDqKsbWaq4qRBNQNqSPDftKG/mF6B4cS5fm0vvQxd5I3Ctsm9jWIze5f/A+9aRAEm4f2rFfznmWfSwwOXy7BzWAp6Q/7V5b+wwbEBrhnupfeOpDuHDsK4EkyuEX9jmf6hb4s20i6FqeujJQMwqDV0kiZf11Ey/2v3Jf1H28L1DkIrbeH/0GoAx5kT8S3mN6hy0/NkAOfdb8Tcu0MUrPgGKdM4WWYkExVGuU2KJ1lxePGkmNulMyrBlcWXv43rZMvBod82BvQZsz57i/b3KbEnSDAX4xEJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(69590400008)(956004)(2616005)(16526019)(5660300002)(83380400001)(4744005)(26005)(52116002)(4326008)(6506007)(36756003)(316002)(478600001)(8936002)(66556008)(8676002)(186003)(66946007)(9686003)(6486002)(6666004)(86362001)(66476007)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YR6s1pz4QJgZHuEYp1kYHK0LGm8gwCbxqkxDms+KzKMI8JToOHqZ+1XazW90v23LQS/AkHsuGc5trNw/SB+pS/o0h+P0w4FSwVA+7/usp48p5nhgIRXwOrA54F6ltwrxBNaX8wWueS5FlZuSIvVtxlRIsz/2+/yg2lh5SeuBFJq4YXOO1iuYhWMgbbMIUpIYD4JkWny0nOx0V4qpo77CsrQw00JM9DDanT2fonYHqPIl+ROW978RP7mVxzzpET3GLwB9BOp6MY7iiidfcMlKLydFPQbRWWVGixBxJszEHvLZX9hmrPtv9Y0xNrwALwxcqpKBXGM4Xrdt6cVJh7DWteqdHVQ8GZi1yyThcmzn1jJSYctY/XLRUEmZsnhdmpLzHSeNB7UEwhIS4hILv6Do+3v6Wo8Hl44Wzyezo4t6oPvBKT9FcoyBurIRIg04xxRsjUZk6M4y4ZBFwS61Da0tE0T9/hJPWf1xMF7zuD9kxO4v0ELCtD9op3zsBQmstpYNpOabFNksd09TYXL0DDAsqGrOz8xegz2gUXk96fvaxh/nuzmlODBIjQG8hrvWr1vDAGM9nqTLj8Og7uDEbYejeSpd8YaxFVparJNX+cUQCMYuG9HZDj48yQXbDpv14E2fA5hLLzWkbUTTdhbHO+OxhA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aebf226-bcb8-4162-ed27-08d8759c7816
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 08:36:56.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8ZEbyCxhUo08mwC08xBYqUbj/dVyXas+4m/CmBizKHuUfdJuqjl4jOk9E/HvcS84KkvvDkzE83AtNME3bNAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2376
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

