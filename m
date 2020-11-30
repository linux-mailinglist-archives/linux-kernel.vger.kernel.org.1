Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D02C833C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgK3L2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:28:55 -0500
Received: from mail-eopbgr30126.outbound.protection.outlook.com ([40.107.3.126]:40594
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbgK3L2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:28:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blHZO6Kq25axb2k3Uv4MbgLFFECmK+WgMqHAigYwEcVRNmxAihq+8tK928movmTKhUOFgP0WroLFVURuwDTpPJy5PBRjWsYgtbBeF8d9pfEbUz2BeI+cY78C6e23G6h9BGpitDZ7VFk7CfO+Vp8PYRUEuXIF/oL8Z4+oxiIC96uxzcbG0qyqhYDSrifssVlsHdI+YvGjPo11MnT11qI9akyVTHeH+VlEH+POodxaGyO4vgS+c5z/B+IomS8iyJu1/Ww/F8MLR6jctoZPJ4OuwFXy605E814GWgLQ65mFGJlh53mQkWF8s5VzGtcN7QYHDly776YkN92rCEH/DsP2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdJDwZDIjetX3zTVOCefEZO8SiRjsvWguiPcB0XDgnM=;
 b=O15OPaV+XLFBSIaAL7Xts+dMF76TmgtMcRLcPk83vipvO4keAaOX525MDP6abF0lU+hAxHhWUtrfo1RINRGdDKewE2QbZS2kdB6x9wmjQa8n2ggZq5XGP5EZa1sglrrG/uUTxExZbs0xMsMNuMRb/KWWSJfMDQMfTNrfF+YRcUR2Ybv+VqM2K6KU2oImWD2lG3xWHzSwlGQxETBLIhxs6TXORbO9Yp6yxDlaUt3XczGT6YWWFHyjdHgStDMfBzDYm3cbbVeVcgeotjS9fMtMBUfJggIYGQPbeYpBqXDnKKNdmy7t2c9dy3chekg9IeE977Xj/n1n3P7qTysuwsjcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdJDwZDIjetX3zTVOCefEZO8SiRjsvWguiPcB0XDgnM=;
 b=nbKUXtytPWNihyrnGDhuu8I0O9P1DjjJxw08dbRqmNy19rz+h7RTH5J+7Tc2eXrFH3ErI4akZpSwmdDG8yomcdG/Tth7Nw2xqNeWgu8bZH4wnmYqEtDiduf7lx41gr7ul083DeQ47zWNcRUUkDSiPuKhww3eHmkHVbCFFaKOPws=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=leica-geosystems.com;
Received: from DB6PR0602MB2886.eurprd06.prod.outlook.com (2603:10a6:4:9b::11)
 by DB6PR0601MB2455.eurprd06.prod.outlook.com (2603:10a6:4:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 11:27:41 +0000
Received: from DB6PR0602MB2886.eurprd06.prod.outlook.com
 ([fe80::49c3:4b5b:289c:d62c]) by DB6PR0602MB2886.eurprd06.prod.outlook.com
 ([fe80::49c3:4b5b:289c:d62c%12]) with mapi id 15.20.3611.025; Mon, 30 Nov
 2020 11:27:41 +0000
From:   Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, krzk@kernel.org,
        olof@lixom.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Nishanth Menon <nm@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: drop unused POWER_AVS option
Date:   Mon, 30 Nov 2020 11:27:31 +0000
Message-Id: <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain
X-Originating-IP: [193.8.40.112]
X-ClientProxiedBy: ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::10) To DB6PR0602MB2886.eurprd06.prod.outlook.com
 (2603:10a6:4:9b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 11:27:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bfc924a-3ec3-42db-6bc7-08d89522f2fb
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0601MB24554CEF47FF980A33B81DFCA6F50@DB6PR0601MB2455.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt6+DJrklWhTe9L8hDazJtKwUqDfNv4d4rgVsxsqo8jarpkQylLjha/35FX0iOiVG63GUnDMsGe96BZ9FThW9wI+ZgDbTlpA0xAiZo9L3RyfiD2rbWdrbAKTasnZbfVunyeq37dwc8mWo7jooBitCZlXyzqP6DwKFeNvsXe4sgxdd98/MM9vzXhfxbGXbe9CJSEx0Io3XXCkjPgoskDBwNH4EA1yAeQyIrYY9yTVjW9hmPRGo4pl3ivvkxRsm+Dm8gvwnVnddPFekNFAd5Q1CKq0tTwhMy0PkibvaALoJnAYx1DEd1zQi57h24GsjxjBP5+4L1kzTrbcvMS0QTF7Pv9TxKazLXZmh363NLt8SzhoSfoupxpaXmSV1Az1p1mB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0602MB2886.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(6486002)(86362001)(83380400001)(6512007)(66946007)(186003)(26005)(66556008)(66476007)(921005)(16526019)(7416002)(1076003)(6666004)(44832011)(956004)(54906003)(2616005)(2906002)(4326008)(52116002)(5660300002)(8676002)(6506007)(8936002)(316002)(36756003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JC06uCG0KVfQeLsk04RZcxW5CqHsDJDbJL2WRjzuBQjGpgEzd7p1MuJ+zaXh?=
 =?us-ascii?Q?z3BwjwGDtk4IayUFhC3L2dfMB5GTlO2HsCq2piTaZfZ/2xc4iKKlOwbk+9Rs?=
 =?us-ascii?Q?y1m2XRWDf6u8bhZR7Vlh8PAIQ7fBFX3mBcBMz0EpeQFFICiF/s2DUEYiY7Dj?=
 =?us-ascii?Q?y5Q3kPbAMXIICeSvLCZ52ddhgILA4tJlW71QDhw4oTNYOjdSMQZqoRjGGCGI?=
 =?us-ascii?Q?RknLJcvsAq4iIBmlrEwPK9tv+6R4iDkuLJuLlulVCurJYCvXAIUTTBPsIzuD?=
 =?us-ascii?Q?KunUkctULCqQTPrbyyzYLfmXYxaglr4hX4X3m6zPlXgFofW0ida5VlW2UWgK?=
 =?us-ascii?Q?/ETLXKQ3wx4/aE8E+aIazMzwhd81lcZeLpbuThWMAZuxU1OCL9OugskJQlbg?=
 =?us-ascii?Q?vejffq0UAjRPIYKbVjbIF9NvwektOzZkx4i6EN4kYw8irVjSERCVMnXhxZa0?=
 =?us-ascii?Q?2bFMdV1t9xlWb09s1djBq8ClUA6toCSIi3wh9JbAn5tMPidOh+bWD8UAotvu?=
 =?us-ascii?Q?0eunJeQ/0lxYF1tkRTgq7PG7EeeTCBlpM9Dh2Yv+i/1yx0rjSnjw9H/Z4od0?=
 =?us-ascii?Q?4A1uNUKlU0KeYc6VcLDGH0Sl/qap01Y6Y3n5KXQbNVsHeNo49CxJC+KxVQzG?=
 =?us-ascii?Q?FkTYBo/dngIoCt/BZL0tLK6B/qWqfrujNyI9hfAz94QZdJjBM23e3kYp/2RH?=
 =?us-ascii?Q?QlL76fTIsh8y4u2pg/yrwFZqqwSvwrj4fCGvffTccMZ/aTp3QJEVBCNcmNcM?=
 =?us-ascii?Q?VPC/WD6qZZul6VDMg5wTCVgn+AusGNHKgRQ9qn4iFDf/0C3AoAhp/kFkX5o5?=
 =?us-ascii?Q?JGjLE+Zd5+J/UCxqWu1Cw7Fv1A9PDK1D4UEJGsA6HTbt/TXU1r6fzMK2uic7?=
 =?us-ascii?Q?VMIMckt0rmAShLpm20zX8Gu4vcU//I2TfJQBie78qgr5E9tzGYpWNcqh9Fxi?=
 =?us-ascii?Q?OAV3LFtbbqLmnM+pyCv5sl1y1op/nJ0ogsneTitrbWyHLvNjPPm8YqsKoyRH?=
 =?us-ascii?Q?Z2eA?=
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfc924a-3ec3-42db-6bc7-08d89522f2fb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0602MB2886.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 11:27:41.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2XT/LfWqU1rbbhxq99fxTyxaC6MXkLfRNRlCJIie4HaXA+7piLpMywKqJFIgYlACM9ts+sridNk6uM2+7VyMfP2hr1ke6KOeEL3DXOCAb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
corresponding Kconfig") moved AVS code to SOC-specific folders, and
removed corresponding Kconfig from drivers/power, leaving original
POWER_AVS config option enabled in multi_v7_defconfig file.

Remove the option, which has no references in the tree anymore.

Fixes: 785b5bb41b0a ("PM: AVS: Drop the avs directory and the corresponding Kconfig")
Cc: Nishanth Menon <nm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a611b0c1e540..91752d918d34 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -466,7 +466,6 @@ CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_GPIO_MXC=y
-CONFIG_POWER_AVS=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
-- 
2.17.1

