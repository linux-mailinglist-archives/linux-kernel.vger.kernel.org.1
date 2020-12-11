Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71F2D6DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbgLKB4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:56:14 -0500
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:40512
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728784AbgLKBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:55:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATs3oGYzGWbiRte05RklO2FWL39Vars/gSVhWwf8W/YlR2PTOumm8GPeP2sF1DSTapONHJSgSmmOjnTGfMm4uMCZf83cTs2AtHT0aKBPhdRlzRKVVaXkXikC8GggKR7Ye9x8lt0Ri1X5PJGKOFygE39EHPEjzASpELjQupr9YCxOSe68DSwgH/AAI1hv/yRORgsZ55lTZ9gZCBiJxUDfaL3EDTfQcQtsO0nPSENx2vMVgxcUgUbJ6aSASG8/FaXLDfg/G9DpxtXjmqn8xM/JwnT0t5WvMuZ5ve2adCvRSshkK/laQGZliLJJyTHhxgtqP/sIthLtEFaOZQ161I+uZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC86KoH3wlxsXwcy+lYW7cA6YGyblupeW24O0ThV7Y0=;
 b=jrW8COBBbFfSRHsRTApVBxLmkLZv51ypPYtcdSs5LqqH4b1As1RV5msWXP1tRUM28Ex2eJEWP/k/UWZSfn7XN2J+NZgE8QNFnZmIMiatc6dsEb8VeQiZabpzLgq+9SgyJ+76eENgzCJMp0l5m5gSzdNtfEI/L/bC29xugBAsJ/049BOl65BCrcA03xeq6+elRnuTGZZirsYGz9hhehYDzFk6g0jS/0761aGEPN+244hBiR9D3KtlqwdBXyI2+cl5vC7R9RPSfhCLgxCJZmJCJPAe516g9FaIxq2bgrumcTT5aCGabe1D84arokGA1cq+I80ZUcOQdSE+rJ+5Mj9l6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC86KoH3wlxsXwcy+lYW7cA6YGyblupeW24O0ThV7Y0=;
 b=c1k37B0cZVMrHChieBhsEexkPhUiDSvgqghHgfJqEEOhCYU8If1eHpq1Xss0310AmdS51iTKqgXvv1Vjsbdn712Acrg1FYiedun7PuF3Gu4iC1Avk53YSvAUuqFUj7zB2b4r9QBVuxu2D3v4tNTLYy4w5JL1/TahLZ5y+nyoc1M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0402MB3952.eurprd04.prod.outlook.com (2603:10a6:803:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 01:54:54 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 01:54:54 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: [PATCH v3 2/5] phy: Add LVDS configuration options
Date:   Fri, 11 Dec 2020 09:46:19 +0800
Message-Id: <1607651182-12307-3-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3676.5 via Frontend Transport; Fri, 11 Dec 2020 01:54:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2442d012-9fe8-4559-82d7-08d89d77c153
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB395219F2A57B899A4D7F206398CA0@VI1PR0402MB3952.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8qkN84mSV4sy9/v3O3Cn2751/sozrcxo3fgyixzm8MtFAOJP2Ed97Ok/Nn29Z7LKv67EjkhLeyvUshF35aeWFTiYQBbVGrpZNo7LcK5fUxJ9jRR5DUBC7ETCHRsWKn+dPne7B16jVtNyXeddDS1LlSDI4YMh6MuMlqJ7hzebRZchh1DdFbksu0NY0ugwZZ7ieTyuLeR7thVxCphwRxO/w7TeSFA5DU7YEi3sHcnMe6L61+WZ4p8Qogrjb9B9+VabvKTNfCiwEAa/s41BzJsnYnsYyzbcvgsOCwh1z2EbQ+HdrkAUlPDVXMj7RPBIOTN/7UKsoi7AVDROA4nwGOEZ5b9Xv0dt+UNo7HWShw/s4mH8ORdhLcM4fgGUssBMVXp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(52116002)(316002)(956004)(69590400008)(2616005)(5660300002)(66556008)(4326008)(66476007)(2906002)(66946007)(6512007)(7416002)(8676002)(16526019)(26005)(186003)(8936002)(6486002)(36756003)(478600001)(86362001)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hpYX5s26RqPZYxgXd94mUSNCABPqkWJcNnhHhDO5XnavFeZChMQeFp22T7/b?=
 =?us-ascii?Q?0aHI6y4bkjzRo8FGfCcl5QeTZdNwEFQcmwvqvT9Ptbh6s6iefewNO0spEi4R?=
 =?us-ascii?Q?0bOgb5FQyl/XcmWuYlLAt5DvFvkxj7HhwAEML3Iy+agKrNAN2goH8rK3E+JN?=
 =?us-ascii?Q?vbkdm4jNBHkipcttwGKkwIojBkebrkJuP3I+GNbDLZBPKaefeJ63m3fKGIFw?=
 =?us-ascii?Q?x37thP9T/hEG3bBxjG7wz9bLOF7yBBpNbL68rmRzohgtzmW793krR84r/68U?=
 =?us-ascii?Q?ZAebapgfWrHi2bX1pPiPDayh2SZmNnmKD0aE2Vl4+JsD8rzTkCkoArwe0V38?=
 =?us-ascii?Q?DliNQHvfhsuFRTgrKxRY9MLF4CGAbH43BDiS3tci2Acbn33QA7KHyuAEutqq?=
 =?us-ascii?Q?uZzJBb6FoFwczTC5q3ihg1CzOE2rSRLVwqFZx9THwePZEX/Cx7ksV85SA6A/?=
 =?us-ascii?Q?Kd3k5/Bsx2nUwb2ENmBk9+itEPn68YGfdd+IgOkpsrfyETfMLGP6r1SHj4EP?=
 =?us-ascii?Q?41AF82Pol8Jrl6GW6epURH3LTBXgCYoG4eDSZI3HE9TEAQBz5hBi7fuxFtyt?=
 =?us-ascii?Q?pmd9dkLwwa9whUJbZIxDkrt9HgsUqleenldw7NafLyzMOfFLH4Dv0P0TMZjq?=
 =?us-ascii?Q?Q7lvLWePLhqDFqPctcgm1ddLicI4YkKgBgtMXKcqDHj1MesXLX8lLf/PBbPS?=
 =?us-ascii?Q?ZSdTkB3t8Fe/Qu/X9COUnPkhNOXZnLv82kd87h1mrS/eeq3tmVtzWghtkLuC?=
 =?us-ascii?Q?7hIrW27BT6a5hmy06wDKCAxQLXsHO3KC/J9dLjX1SypadV8SrN83af0hRlXS?=
 =?us-ascii?Q?+sN3mKm/33Ic3WUf9dV/T9XBCncNGysIBFRPiGt7XrwcXnhz7/qlb+LDiusS?=
 =?us-ascii?Q?UbYQd2k6LMwUKYiuZIpPlQ6FbiS+CAQ+emYFIw11B8TcrvvIQuDSimMjEqZ+?=
 =?us-ascii?Q?9QgbeQR+FUAT5XDYiqU3y8XAWLH18WpZWp+bRIp4axICrp/AW6Syv+eK+pPS?=
 =?us-ascii?Q?B0Ra?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 01:54:54.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 2442d012-9fe8-4559-82d7-08d89d77c153
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5nYxN60quRGfNzjUnfVQiLXGqmcNI6FRMl1NMWkfTU2r8/5WzI39zfi4MVoAzifqxNMH1MmLW11yb3D67cIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3952
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows LVDS PHYs to be configured through
the generic functions and through a custom structure
added to the generic union.

The parameters added here are based on common LVDS PHY
implementation practices.  The set of parameters
should cover all potential users.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* No change.

v1->v2:
* No change.

 include/linux/phy/phy-lvds.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h      |  4 ++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/linux/phy/phy-lvds.h

diff --git a/include/linux/phy/phy-lvds.h b/include/linux/phy/phy-lvds.h
new file mode 100644
index 00000000..1b5b9d6
--- /dev/null
+++ b/include/linux/phy/phy-lvds.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020 NXP
+ */
+
+#ifndef __PHY_LVDS_H_
+#define __PHY_LVDS_H_
+
+/**
+ * struct phy_configure_opts_lvds - LVDS configuration set
+ *
+ * This structure is used to represent the configuration state of a
+ * LVDS phy.
+ */
+struct phy_configure_opts_lvds {
+	/**
+	 * @bits_per_lane_and_dclk_cycle:
+	 *
+	 * Number of bits per data lane and differential clock cycle.
+	 */
+	unsigned int bits_per_lane_and_dclk_cycle;
+
+	/**
+	 * @differential_clk_rate:
+	 *
+	 * Clock rate, in Hertz, of the LVDS differential clock.
+	 */
+	unsigned long differential_clk_rate;
+
+	/**
+	 * @lanes:
+	 *
+	 * Number of active, consecutive, data lanes, starting from
+	 * lane 0, used for the transmissions.
+	 */
+	unsigned int lanes;
+
+	/**
+	 * @is_slave:
+	 *
+	 * Boolean, true if the phy is a slave which works together
+	 * with a master phy to support dual link transmission,
+	 * otherwise a regular phy or a master phy.
+	 */
+	bool is_slave;
+};
+
+#endif /* __PHY_LVDS_H_ */
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index e435bdb..d450b44 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <linux/phy/phy-dp.h>
+#include <linux/phy/phy-lvds.h>
 #include <linux/phy/phy-mipi-dphy.h>
 
 struct phy;
@@ -51,10 +52,13 @@ enum phy_mode {
  *		the MIPI_DPHY phy mode.
  * @dp:		Configuration set applicable for phys supporting
  *		the DisplayPort protocol.
+ * @lvds:	Configuration set applicable for phys supporting
+ *		the LVDS phy mode.
  */
 union phy_configure_opts {
 	struct phy_configure_opts_mipi_dphy	mipi_dphy;
 	struct phy_configure_opts_dp		dp;
+	struct phy_configure_opts_lvds		lvds;
 };
 
 /**
-- 
2.7.4

