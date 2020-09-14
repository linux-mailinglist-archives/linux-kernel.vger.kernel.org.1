Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7314D2689A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:55:54 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:56899
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgINKzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzdwK9SRPPobtbxwjK2zKdf3WRYNd4zIOrf1icqEQtBapFJN7QQaICtIAW1ACkindVTNhmNO9s7TiCPp3nlS02xrkWh8IplexC4g/InK/BjAVFJAMZeXB7K56ejvyCzpTn+gFTZETpKuJ2g2pXUMfTJhqgxDioECy3RwPfD0zFk/tL10cExq4EFyTvFjaItuGtMJjCnMlzJ6m41OS+EWlx1FXiZDjCw7qk9it1pulgOoanvz6EO8w8p7wm0uoQarI513pFmcvbmPLjeq1oxgG7JW4XeMavIf0MmeeKomDcNKtnImWl08WSi12AUYlQyAZfjY9KF7e4cPey3/M/mhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o48Vss/Qb1rUveWnj69uJxr5bDW4eJdP4dAt6x/FooY=;
 b=SS5vYvpsStWl4gBCXGI2zKmhzX/PtQ+cfrIZ263FwcccUkme3/jN+GSZZG6CQAhOxxykGnQAwQsiKSLVW6vjEujgq9J7OX6ffOQBE86DCK5GynziaS10Lcw88YizBchdUfdYZV4HwXwLsOB/M2Xc4sn+izUWFp9DQt17ccuwDrds6YETMwmfve/LhLk4P+Mq+iF4bsFHHr6GgtTCN0ytRG4GFWCZJwogglMB6pFC0F8RPIbJYpziP7KEp/tUiUiE3ZOR0p4rt+x0nvA7+WRH0ifPQ2FQRaR1K8ncOBUF5ViWpgQo82mpyAjq56XKPTiBysnUid9TctMcugFi+Vog2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o48Vss/Qb1rUveWnj69uJxr5bDW4eJdP4dAt6x/FooY=;
 b=gzuVhCONh5JcnSlgE4bWu2tODsriZrUDuYxu8gVpEdsPfObhY7U9XS9Qf9jDnsctIhlASV2QUuLTgRVu3z4wbmjwqmKJRKMMlGze2CDTf1gbKBA8G1gjlG0qIliOJ0vg0Z4xE0pgDnJcptVzOvq7jkidm7gMYE5TU0/d8yUqbG8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB3134.eurprd04.prod.outlook.com (2603:10a6:802:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 10:55:11 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 10:55:11 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com,
        anda-alexandra.dorneanu@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 2/2] bus: fsl-mc: MC control registers are not always available
Date:   Mon, 14 Sep 2020 13:54:59 +0300
Message-Id: <20200914105459.27448-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914105459.27448-1-laurentiu.tudor@nxp.com>
References: <20200914105459.27448-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::29) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 10:55:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2d0fb7c-5de4-49b9-62f5-08d8589ca6ae
X-MS-TrafficTypeDiagnostic: VI1PR04MB3134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB313425EDD989E6704F37D318EC230@VI1PR04MB3134.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFlm/czlyn7lBj+A60FnnCMlVMEyAsefR+gcY+NFjyET+gZQ7fD9ISxTtMpwpXaTHdSCnRIG+ZB4tNef2YiVbssb66R3B/LF94s7OKtNBWF/FhfLH7llRe5o8wjjWBvtQZ7G5z/D7TyGYSxPo5i/8Pg22631Y28wZZMZl2G1u+9yx71se4qM9lfv5WQT1eEyOC3zpitXyvKr211UnE6HdlH7HPqJdI+cirZrDPv39ta46Lfw/FcuADn7XgeFUKrD8122dRYeryryzM8+HPC19hdDyjuqjYsDpgJcLEJDIu89PoM+4hVQ31tB5Nqd1gV/PZjT/m5z1WOF4jv3j16KNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(6512007)(36756003)(2906002)(1076003)(83380400001)(186003)(8936002)(316002)(4326008)(8676002)(16526019)(6666004)(86362001)(478600001)(2616005)(6506007)(44832011)(26005)(5660300002)(52116002)(66556008)(6486002)(956004)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GLCW+YkjwitRk+wjcXWtB40WOecycao2QWC33Dx6cuwtJhZNzRSDU6HSaPml6WTRSPBEFYAV8U7KoYpGJ1RQyl8N1JfLnfN8qvGaG/auGSqE2sAIR37lfen+mMKf7DYcRQMxIWOf4jPXwan59o7G76YYCkYGmgBftNtUsSwFIVl6uWDLD5FUNLWI2jdKMdjUSarRy942O+KT/Vhh4Bb2mDbMW4jgxA5uVNqiSai/JiTSB/dxaouvyV2ok1XKe+DpbZionKfHjrtmct43VgqcD0qpaIcxTVvk/zdcJk0Am5gs9F1LxjMQ3d4g+oV7G1GWtXXaAj/cBeGC9/4G68nacpTL1aKUh+xTVRNZsFPlxIekRXUHLBrYYg0tHtusHaiTHDabtFAYZg3g3xRMYyiG9fzLQvrTf8iVnbuK/ZL/oZb720dhtbiQ9Kv72j1yxmD9gBTbCLv29xnKgtjNX7xWNlD9WEbCYshtzkZu6SDLYqTyw3kxgl6C9pLmAMj8vx4B6LbHis4vHuH0WMI7g1YwYfXRVGgsh30oqo3/51463K0Zz+a9qF/dhqADsBr0JAqzFRlI1CixFR7gy3RF8GwFgnh/dhomRNGWFqbymywGtAducx/4FkyHcU8Ts9M11q+dk8CUF5upsYUGG7kLwGxBpQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d0fb7c-5de4-49b9-62f5-08d8589ca6ae
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 10:55:10.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLGuOvLJNzjbEmEpbQnSKsRITxU5tQXBTOsXNtcWDdru0dTsTGo5TCC0jQFhOtuQU4vQlR8pIbNg4+ux2SefCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the device tree binding, in certain scenarios such as
virtualization scenarios, the MC control registers are not
available so don't error out if they are not present.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index b0449df117e8..7345ecef93f8 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -915,11 +915,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mc);
 
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
-	if (IS_ERR(mc->fsl_mc_regs))
-		return PTR_ERR(mc->fsl_mc_regs);
+	if (plat_res)
+		mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
 
-	if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
+	if (mc->fsl_mc_regs && IS_ENABLED(CONFIG_ACPI) &&
+	    !dev_of_node(&pdev->dev)) {
 		mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
 		/*
 		 * HW ORs the PL and BMT bit, places the result in bit 15 of
-- 
2.17.1

