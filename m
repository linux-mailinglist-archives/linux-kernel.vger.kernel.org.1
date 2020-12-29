Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345E52E7089
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgL2MLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:11:32 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:43563
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgL2MLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:11:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7vTxKDBFx1WkFSgmXuY3/J/ZG0xXT7qqs2ndVevpRu+fHcVRHv+K/+KTtRvhIQ5y3+ukCcV3cQyPcFsc/FNleN0sai0vjkh0zWip5bBCiteuWLEArvhhRPLTXqKoBliG42YNTCDjFKGO20jTZqGRKI4v6G7jBXyWTtIRkq+6G1HN3/TuminpbTjThHEUWrerX0JpJoFrheTHb+4e0Sx48U8wvzUOTR3a/QE1PgQnsaog9vlYSzsFdWRBoab4zoHhX/EZ0jBZLuIdml3xAID99UleWpar7YQqkkkYDGve6IBuq6cUCxmOXYEtJzcjv6jlbU7NXBpzUwume7M2TYdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6li1FgkbQ4HM5vDTVOGRkPjq+Lyeoq5nWpLP7Yc6FI=;
 b=H8uhMk6CSxOivj0Oogac2WgrRflCjwhvaspL3LxfVKW+2Se9By/IFE/0ITY6foedZsBQqcvYlUo7pgQ7fE5n6my7UscQ/eCIaiMXtQL0SUSeOKMbnGHNTRMRA2OUSmRw1miGdLfaNeW1Vf3RYf+WUdg3aW/leC8ZapLltXBCYk7zY5/LgmUH2I+GAO64RL2FXnajyoFoxqJr3HFRVQTeCFulEi5W49W0VCanVROQb5nIEGaicZjULXsQl+hNySLo0pm8rLfgqvndfskI8bqptk4f8bYMsdJFT+hI+ZBH/ziz+d4hDeaWD/iEEqYZMRbnCLu2dxJ3LWDYC6QWVpuUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6li1FgkbQ4HM5vDTVOGRkPjq+Lyeoq5nWpLP7Yc6FI=;
 b=m4sOWf8y1BwCCs0cFZfmAXxGR8SNnoCgiLPHLwoHJhJUjoX5nm09hag/C8IhPwM+4Z3JX6mum7N4i/T0KHVQPRKVeN2DcNHxdFafsfti+2PVgZ6liJAW8ZHST8Gw1Sw3YDd7krjRqOojtz/KPTnkdYcTsoGBO9iK+CuHjEh+Ub8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4089.eurprd04.prod.outlook.com (2603:10a6:5:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 12:10:06 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 12:10:06 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] arm64: dts: imx8mn: add spba bus node
Date:   Tue, 29 Dec 2020 20:00:44 +0800
Message-Id: <1609243245-9671-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0161.apcprd03.prod.outlook.com
 (2603:1096:4:c9::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0161.apcprd03.prod.outlook.com (2603:1096:4:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.12 via Frontend Transport; Tue, 29 Dec 2020 12:10:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e5a1b5a-7e5d-476d-1161-08d8abf2adec
X-MS-TrafficTypeDiagnostic: DB7PR04MB4089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB408966B90690ED2B131E333988D80@DB7PR04MB4089.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUoDdfQ3iDaPJ6rpuGdq+q0AjpQ5sGAsUKIoz8K7zxvWCgkvslPOfHhMi8TsnimuI0rsU3LEzop+OBENTm/9dScSDu5dl8aL+9PKJCo9AqNSu1Vuxim5OreJUhXkk9/C2MZb+VfPOV4amIxmROb6hNeEi82sepmIn8i4O+rERAys394M+rIT3z96GyE4c5P47PdfsfiDD9qb9IunV53FK/2ZP2uqUcLMa4F8rr6Yj9DOXLo2nY/ipwFep4uhKFJgO4FPBGNcn447nM8onjmgS2AkOHiXmnL1bPCRdcuDiKCEow9ykWZr/cWnkZyGqCN3f6egBdN3U1MQ1ITBw49g7zUBNOLxZNu5EGAFHwuMZ3IWtqOxiGMLHmdz8/PlVHqHCUfs4JlIkATTgt3GuPfJcB60uGnyCr5FKC3qtG4N500qhf0ZP9ZZSEW+495w0fMnnktgUz6jzDG0KTAy9iqoZQWFIeZ2ji8XnqhBaNxRn2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(956004)(6666004)(6486002)(83380400001)(86362001)(4744005)(66476007)(36756003)(16526019)(4326008)(2906002)(26005)(52116002)(498600001)(9686003)(8676002)(66946007)(5660300002)(6512007)(6506007)(2616005)(186003)(69590400010)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b+FBGVrvJNX8OT9+qvpK/aRyKEtl9/eEzjCJG2dtu43aJqK9Ns3rUTSQka+U?=
 =?us-ascii?Q?X3lh8d5UndE035Zwa00Bz2gYfYAXvw/I21Dm0jZ9g1kLBD+zuWq+jbD1Tuf0?=
 =?us-ascii?Q?glgWuKiMWV907fthE08OXbEc69BX7K9RlQQ6/upZhx9EHcfUaM5IEN65cxfB?=
 =?us-ascii?Q?47OdZmH4knfrPC+Hy7Z1vvpU4LrBFUwd7IACKwjeFCSMrmce0QUEQLcRZsEM?=
 =?us-ascii?Q?Bcvzjz1PYOrConS+SR1FXfcK8gfqqZoUGwaSvYe/Jx0Tq23NrEBUrBRbwoUE?=
 =?us-ascii?Q?Y1eUp+JHO45/wZWOOZ5rjztegJHRpQeKoF1Wqu0Pg68SScFxw1oA19gYh8P6?=
 =?us-ascii?Q?jd9n9AdumUyLySPvdxNDN/4Ama3o/b6AINXJ6/sSFtlaFHRwT0GEXqefdM2D?=
 =?us-ascii?Q?xhUWc86g/jAuFUvy4R2pRVSTwPZmfDz5lkjon+NDt8JOSwXlp2F9kVOG3N8J?=
 =?us-ascii?Q?ZF1Ibt5uUJ5UawHPPhgJ5+uGDnRGbIVVliBeC2hARA45aBYuTXHJ9xJMOnZ9?=
 =?us-ascii?Q?NhWmN+gw3FkexVybO7AKgRTUncCl3RRlOHkYoWJ0ZEfUmwrUcW8u6RwAdG0Z?=
 =?us-ascii?Q?KxJxtVrhweqqN88cdcfez0Ua9sbSXCCp4ge7JWzzIofpa0LcslpevJ+s0LpD?=
 =?us-ascii?Q?fZatBiHrBOuj9ukFvAI5r368i9TybsFCeMUjiocC6uRYX0vzadu/SbLQcY4C?=
 =?us-ascii?Q?9E98L0szCTfBwAKygxKGda69O/u0GIYd7ElxY8fnVpDJoOQLKAKiZsc7Y1pq?=
 =?us-ascii?Q?NGn5CFZ91+aO1UMwCmnMWooI7V5i2zI2jdSjpHUw1U4gHkCM3ABUgudmxY3i?=
 =?us-ascii?Q?qC/oOPntuLTGI36ya+Sc3sC5WS/i0DFezKQX9KxuGpCOplxNC84dReLwLdC8?=
 =?us-ascii?Q?xOq/xRSZGyX7jRWeCTnqLUmr8iHOtqbSxsdCdOsM/r+V5sMrGN1PdLw1wWtY?=
 =?us-ascii?Q?TMJ2rHqMryPDSlRV95+1uJcxteZwcgdPO9zI5yhjetZS4+5lAIfkvt/4jgMk?=
 =?us-ascii?Q?CmUQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 12:10:06.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5a1b5a-7e5d-476d-1161-08d8abf2adec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2Qyx5jTCpui3mXbV+bJJ/CSjLwaT5f56Eljut8qFEb19quzkTRMrnuG4XkCe1UdLi2J9sUdhS42PFhbCFxFYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM, there is a spba bus inside aips3 and aips1, add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 73602832ccaa..033fa90570ff 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -749,7 +749,7 @@ uart2: serial@30890000 {
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
-			}
+			};
 
 			crypto: crypto@30900000 {
 				compatible = "fsl,sec-v4.0";
-- 
2.28.0

