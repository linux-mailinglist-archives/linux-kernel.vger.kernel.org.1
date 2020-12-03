Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1062CCD31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgLCDQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:16:26 -0500
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:23489
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727748AbgLCDQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:16:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGGFoF/aA1s490XQR1TWkWw7xXnSMX7XyxlaPkZjhk28O4RkR1HqqtC8mohDelmew6CrE+cYdCf5YnyqeFtL+P6RVZ290IF+YICliUDDGixE3y3Rden9YkZIhZcF9hfHiB4YKec/XVodiji6f43PegjIFJfH4kduNi2AIJMt6tpVcX+BHZPhoYdCWk9bzAMJGVIO223f399zoe3wi9Ek5iEa5ECLtgIkwCOJeSfCCwXQnpTi1vvD/n2tB1eoqzEhEYnZVXDSQx6W8gGsMpKqSPLNfurys2K227D6phgX1gBsglSxt8OLOWsx6azFsb3aKCl0RFkEJoiARrVOL0HYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BD2f08bXUw/vNHr3oMHVBpMqHKE9P9wOQ+8bdJmpSc=;
 b=QRJ2BfFGNQaczKBDU/fCjrDu9Q9C46lkn6jlIjbK2xaw78dTBWA0uqetLr6ZU1mtCycApIq1yr7daQoEgfEOhU7CnFdQxwxqTqlqFx2Q7aQW4PTnZa5qjOfXdKOFatHakA17i4TCmP/UUZow5GBZrM+fMxkCDTnSGqYXs++D94eg8gEBSLO244gQjx72PP1qK1vj1wErSHcJ6HHyaa72P7HlJg1P3W5xnaIm9bnUP1PcCgTrqlPVzaIH0GZ4cOlRKBhYFOtP4DJYYiZBGHWihhbakk6uRXqUOIwRc7eQ2isVy5EZsZbMlrQ8zZFD9v8VnbEmdYqIQT3SMKYoRG9mKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BD2f08bXUw/vNHr3oMHVBpMqHKE9P9wOQ+8bdJmpSc=;
 b=RdBclXryWoNd9e8DI92eY8mnv1Cqrob3ESpaKQO7zfLdG8xuom2OPzmCnq//o4wOkLR1rc1rs5iMZZLwnNV5rxm2H1eG8E1nO2EjkQ8mkGKrcmB0seq1dV/CrGOD4gGAhmvd80PuE1Kg7/IDAznl0se3WOhakiKkkOHJO+g/NsE=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0402MB2879.eurprd04.prod.outlook.com (2603:10a6:800:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 3 Dec
 2020 03:14:49 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3611.025; Thu, 3 Dec 2020
 03:14:49 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, laurentiu.palcu@oss.nxp.com
Subject: [PATCH v2 6/6] MAINTAINERS: add maintainer for i.MX8qxp DPU DRM driver
Date:   Thu,  3 Dec 2020 11:06:31 +0800
Message-Id: <1606964791-24927-7-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606964791-24927-1-git-send-email-victor.liu@nxp.com>
References: <1606964791-24927-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:3:18::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 03:14:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac279901-1536-41b6-47d6-08d8973997f9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB287975F02ECA82949B029D0E98F20@VI1PR0402MB2879.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guyn8XjbxDpsTUz7pJBkE7FLfSQgLw7H6ZkvnYwBrpctIDnw0dMm9t9nexsLtrKB5DMsQMl3C+QYQK4fL/gvtG6LUq7uhcaVJ2h4Z7qFtU6IsRAzFQSRLJmd3Q6G5vt5E/8+DUXkyNgB2ec2iMhaYi4S850KV3qATTSKwwi/iurH/KWoiqdWnshfxx499eR40jq/ipeRJ5FzOQExQYa/YlWpelBEUjUwyO7fihvZAMToIqqFfRhSpAImzpXlbcm1Aa/lTPOyb5Qz+EYrhox3U32v7BeQ6b3z5DEGAX/itdlAXv2kemn6SoxDVnp+M1qzW+A+nQ3m4VJzebh2plHNvQpDSBqy95Fsu1eTeyjbJ6CfHTwsPDtBd3XNkK0Baz6T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(8936002)(4326008)(186003)(66476007)(6666004)(66556008)(5660300002)(26005)(478600001)(7416002)(6486002)(956004)(2906002)(6512007)(316002)(2616005)(4744005)(66946007)(8676002)(69590400008)(86362001)(6506007)(52116002)(16526019)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?woLXDZC+BIMzZMf6/Ulns9NaPyuJAVPMlscPmL9xAR9LPjBBWT6hpe4apt/d?=
 =?us-ascii?Q?8Zo33iqqvgHlJ9df7I/Cg6Gub09ZQLqTJMOZNiblm/vnwmSqR2rCrdwLl9pR?=
 =?us-ascii?Q?4Isd4W+TR+BZAd3MhaApMbq3SgTIn2XXAdSzGEbKaLFKghLg/PoyZweu+3+7?=
 =?us-ascii?Q?lS9naSfRBaIIm+4kRI+iE0AgF/KSO8OlOCUDjass9Z9rIDeVnJ4pRxLMhfiG?=
 =?us-ascii?Q?ukeXMACE4yJFyCmv/2x/+mRX07StS2t0DUAXdl66gCG18Ev7F2k7KwIJ2Hhw?=
 =?us-ascii?Q?92c9aBtI+R4kYLjlT2pjRL5NRl2TAwKHOAomk/fMvVBq1VTXaPwNGfnm1xeS?=
 =?us-ascii?Q?4E8Qd9vht8Z9SFW7cIF64Kz9AGtiBfOAQ7vZPTrLmigRBTPnz81Y94wtLM4Y?=
 =?us-ascii?Q?/i51CDTsiEsHWRVcvOzMIVXdu09bTQJkQeolJsmvmwfNVmTzc1VgIyqX/m9y?=
 =?us-ascii?Q?OXUrhtW7tq2bnM88VnbzJvLkpd2VJif7blUyM0x14fg5+ipYm6GGH9Glt3l0?=
 =?us-ascii?Q?ibiRwc1FPlClZ60B85Dq34ysh47dRbM8tDziTPox2WBw3SsygrMXL5B4M95w?=
 =?us-ascii?Q?z2QLdrw4UBKGwJKrkOJ2FelZjicYARztNMPBfdWtrol6kjYSH27ga+saabxn?=
 =?us-ascii?Q?KDvGOhrYuY00ENpHXk9V+5xaF33tY7HYV11h6lOFLc+LceWDRdjhrWCQg+Mn?=
 =?us-ascii?Q?lWtWexptcHyE//v3SC3Ssm8A/mo6WfyGi/MsSaXNRyQW8FCgtl1CB9VJ7cGW?=
 =?us-ascii?Q?5mEfjAMYVIr2rrt/TIL3uGKW53JOsOBWnV441ZU+xBuEfCJXnhsE+ZPUKUdc?=
 =?us-ascii?Q?jEFjoUHdNb9bfujuB3SE3jtFr4fPmA4HYCAHOkXQFxvZISymYwvtgIwSOSTn?=
 =?us-ascii?Q?5wshhX9uHZh6Fmpb+AAoXoYpfkyU2NFxno5APSzVnSsDmViISf4VGe5v4W6f?=
 =?us-ascii?Q?e4KKXsKjrn56+3CqEVG9/1XFJxEDQa6rneCcXf0Ugt/+nal1vhwTGa+gP1xv?=
 =?us-ascii?Q?XHcG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac279901-1536-41b6-47d6-08d8973997f9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 03:14:49.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hScrjsS32Or0lybrMR9iH5TvkNcyggbn7ft6riJ0Q6yjqPVwr7CrjAfnE78M/3TddKgFo/dM3oLLvXiduRSHKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2879
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the i.MX8qxp DPU DRM driver.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v2:
* No change.

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 970d9ce..dee4586 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5834,6 +5834,15 @@ F:	Documentation/devicetree/bindings/display/imx/
 F:	drivers/gpu/drm/imx/
 F:	drivers/gpu/ipu-v3/
 
+DRM DRIVERS FOR FREESCALE i.MX8QXP
+M:	Liu Ying <victor.liu@nxp.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
+F:	drivers/gpu/drm/imx/dpu/
+
 DRM DRIVERS FOR GMA500 (Poulsbo, Moorestown and derivative chipsets)
 M:	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
 L:	dri-devel@lists.freedesktop.org
-- 
2.7.4

