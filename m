Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0902DC3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgLPQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:11:15 -0500
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:64121
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgLPQLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naT/lgXBJ4pF+3KE5McWeLZZ/rdcwJoKnmsYVoaSsGnmJ32NOtIhh9vxqlH0929loiFqn1PAg/ghgt4+7qIm3zjqr9qo6KCW2rKQAUq5MZI29DtQ8Aisrr4JAmoynRqoH6dRsMSTkx0PJQZ1oo7V833jsBwLM/sQuQbo0xUoPgQIS0vBEVc0hZViyG668cGYu/IVhbKb3TE7YLM67FuC1NfMKJ0mnP1ncShiLzyT5CBHYKMfoy+TqCfBGiLI4KArUscIcf8hP+0jc/jj5O3HeZLTouF2/uLbOUN1Arc3fqqbWK1d6hSWgCOiMbHlb9O6TLK20VmAFAl53HcSgm1UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a9oVdAtGU7Uq3QPsBORUaNrWyC8b4xEplt+GHuNetk=;
 b=Hum6yVZBjspOQHdVWROESFvasJCN3XaPBukXrzlFYjBjVtzMOLvMDSkE8PmLl21Pol/Yzh9OFEv0OHZvZJrEWz9yQ1hsn1Thcmy46WQPmIxk2Y8952is8IdrnRGEyqJrjWFbKOjItI+ULXESlnjwYC8l4IJaTliIinWKO/Q/AgjJWzWL47piUBy4r22gVU8Ejw77cu9WGTjXf7a8uPJ3rIEicoP00JWClnrF0unR2uUVVQynp+F7UEJ6yPAMjjEgZGCopsho/G+lrgFxhjxHbdV/58UnQGbW/xT65pZLcztAlX8nPPZkF/z8PUpILCgIrq4i12tGWonAVXciNLSEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a9oVdAtGU7Uq3QPsBORUaNrWyC8b4xEplt+GHuNetk=;
 b=JVnVPjuEL+14XEbkatFGUrIOrTKzV3zck/6dCbKot+RQIn9Q6F6HOhXvWJ4SxTDR6Keh3QJrYLj22iNZ/gOxU817KabnwXg8sNgaumBUf47tIsZypy14KPLmtLPtBxZfptBaIVYjRyqGeIBu77ui+WwbBWJovzBHGR4PULIyOQA=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB2976.eurprd04.prod.outlook.com (2603:10a6:802:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 16:10:26 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2%7]) with mapi id 15.20.3654.026; Wed, 16 Dec 2020
 16:10:26 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] bus: fsl-mc: add missing __iomem attribute
Date:   Wed, 16 Dec 2020 18:10:15 +0200
Message-Id: <20201216161015.29060-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM4PR0101CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::33) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0065.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 16:10:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f1b9438-ee3c-4ece-20e5-08d8a1dd198b
X-MS-TrafficTypeDiagnostic: VI1PR04MB2976:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB297645A6172650704E1A728EECC50@VI1PR04MB2976.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YT0A0S+8sS3huLYtjI58PWuEZ6A0cIacGOgXSX45H21qrd6U2RgEv0AJGXW9O0FWJnZLaeIBWrhETgDX5e2YDBlNbWYqB9CIaH8Q/kY91RmmYa+pVoKir6krNwQjXuposbknETLNMejdPl4g32vyJFfduyEiP6JGmLKtq0ydlQgpu20gUWlwEDMKpFqkaluPb21ydt90keZlipQaHb0J3G/EVF/4ScnIct9Cx6BIOCg/qCA03KaDWCtfQu9JHu3prH7G0FEkgn+jDHPcbNNpWal/+gdvxxUdZLBjN32d/BKCbIncnLYfCB0oVwcbzvonzvE2CbFtbvZz8R3UyQOHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(2616005)(83380400001)(36756003)(52116002)(8676002)(16526019)(26005)(316002)(5660300002)(6486002)(86362001)(478600001)(956004)(6512007)(186003)(66476007)(66946007)(9686003)(66556008)(2906002)(1076003)(4326008)(8936002)(6666004)(4744005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OeUzPOu0bjotGxXspUbRwTkPvZvg86NGKVQ6f9WgSkfbo/RUV29HV5xX1doj?=
 =?us-ascii?Q?G8k5WRw8lr6vXSzsuZMhosC/2DYgcmy2Fb2KBaVZY1nUa0Hs/56NScWqM/pm?=
 =?us-ascii?Q?uN8wQCOQagHPvpiKFAy9MMekMALrEcyz0xZeSiQ6xtB9x0cCkzj8DRlZ4Nkd?=
 =?us-ascii?Q?aDKTTza/UvZNMl52yP4DEmWX/fTSgn7lUi6P6uqXalQMAZh4OD6X1jqb3Kx7?=
 =?us-ascii?Q?OGfFh/J7RplvhlfT5Z6CJKn5GDTpXvUwLdVvJ6cPMl1PWiFrJd4Im8rIuTyo?=
 =?us-ascii?Q?G2yUQNb1Yr827g/olwNOpr/39RkFWADJvaHG5AvWLgq0QdgjlmCGd0N3EAdW?=
 =?us-ascii?Q?tzWEfQRDhEKB8GBL2XmBb/CGSuTeII9QCruVlI+ewqXZQNX1iXqRQ97nYmYk?=
 =?us-ascii?Q?7fTIPZ5Xh2+G6jwz8ZfC73LlV/r4n/JRzPsAYyaaKbDPPgWIq+4hpd87MrXU?=
 =?us-ascii?Q?vg9YKpbbefQQSdxMszf5sKb9EZ6Jh9nH5xN3pbKEt7ccwFPCk8M2t0jPjruK?=
 =?us-ascii?Q?CxO0hvcTD+76jPv9w3Zc4Iq4l5yVc6UOuQ0RDmDCwHl7D2VxiVKafvXO+LOo?=
 =?us-ascii?Q?C7jIZsjZT+UxHp/7kRhrBKehzA9qWnsemQXBLi2ZbCS8E3GnfSVpU0ZCqPv2?=
 =?us-ascii?Q?KOwoE6Ex65P1A0ZjC/iwgR21G2J8FdmFQeC5oEpoFW1aFseTy0Ys+vR2SR98?=
 =?us-ascii?Q?8NytyMSsbxbwYA8oeyTxfzMmPD2S7EXO5p4QFrJQWu2tYFCgqIAZtuFiYlTm?=
 =?us-ascii?Q?1uUFx7y6qaCiQFtwZm4mxxSLd+uT0fgH3/9+KugkNg7ajn0uALJVawAdVOqi?=
 =?us-ascii?Q?JrFgQFU1HXN31XgfVWWHvKW/haWjcm/oU4SNbw+2oj9jSTR/BBDllaCkqkIb?=
 =?us-ascii?Q?1tjSJP8IJuttKZKBY1XR6dxi15sgzQnD/6NlfKnm8rarRlrK017YPkcVq6Dn?=
 =?us-ascii?Q?LQJ0j0198qC3Ojctqdj/jVTF7BdnvFIBOFhr4W5ngau3FBbW2t1ADp4ef0ch?=
 =?us-ascii?Q?cfSx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 16:10:26.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1b9438-ee3c-4ece-20e5-08d8a1dd198b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt/BetfPtdJhbG/coK0HvWaqqYVUvz2w0Wnz58X0ccnCAk7h3Rib6SVXxf5xtiq6stSa4/KIR5L+VLkvoAOn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2976
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This pointer to an i/o register block is missing the __iomem attribute,
so add it. The issue was found by 0-day sparse run.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index b8e6acdf932e..5a8fc68d6109 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -41,7 +41,7 @@ struct fsl_mc {
 	struct fsl_mc_device *root_mc_bus_dev;
 	u8 num_translation_ranges;
 	struct fsl_mc_addr_translation_range *translation_ranges;
-	void *fsl_mc_regs;
+	void __iomem *fsl_mc_regs;
 };
 
 /**
-- 
2.17.1

