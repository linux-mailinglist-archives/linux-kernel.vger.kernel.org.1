Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1182A823C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgKEPbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:31:35 -0500
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:4093
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731272AbgKEPbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:31:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTpUNgBmpHVJLghOXrvJjlUAJvK0eQEB79kR3eJM/Y6kROlqh15MaX6tWcEHbPcp/jPbQThbdZvrNTpOkr+5tRY+Lr+qSQTyE5PyDDiwAQq76EzNdy+AQ5XhRz2nJZgmn89J7WPZeSPTgu9pyWm8IXcpcd1pEJx4gkV0CyvKRT/4go0ZViWyhUdKqz0W8n4aHzdP3oGmcTy4nSibCeA42tbynFs1K3sz+mugtrGIymXQx+9UMvYc81kFCfosALn6MQOyqZAlAhD4k3syzpTf2lAVWLJ2ISgqjXflIVygndfSGWKtb8aNj40ydEL2CZ6t9URgeSaax5PwyhKnWUYaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ihSKSrfVzlscsicDMm/B1wRv7SydQXYhPbQFdOLR8=;
 b=YtQKoO16EtjqKyUatFMuqUrT/efP7cqiOtNppXVmToX0bI4yikAgx8aXyiAepwx1OHztsWEJHeL8tNB0uU/WcvTeXTwpnqNKiILUy4xpJVbFSRHQpXI8/9z/0C5mlUmaY1Tu9UQb3N+AbiLY3u1nP12o200CS+fiZ9WZHXbVItm4DIkGmGgIapT5kbtJDEtetk6VhKBTIp1LrcKlBA9o5nTbxDQJojf8FlHLV7Nr+4h4Km9OZ4aoOys51uUH/T3vrGf/2W/fhqu1pXElNuNNe7EgaGXqQpxDpt1AD30FTSPx1ohnIaPIHB+Gshmd0hraC029QGSdZiLgVgj5Xh/x/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ihSKSrfVzlscsicDMm/B1wRv7SydQXYhPbQFdOLR8=;
 b=oNo00lrppmdig1LAmKwJ9msLyWJmOgC/FXvCU6dHQ/EGzhcXGNcTz2fJeMIdr8g28trqzX4Vg6XdpWjO7M/6hDh2eSCHe0bXWkf5CC62LLb1sXWVjCSISTwb4by3cNauxGFJeCXqefmubd9DAdzNSsZU6r5xjExSEdMqDtjDtMs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4895.eurprd04.prod.outlook.com (2603:10a6:803:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 15:31:30 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3%2]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 15:31:30 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     diana.craciun@oss.nxp.com, ioana.ciornei@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 2/2] bus: fsl-mc: make sure MC firmware is up and running
Date:   Thu,  5 Nov 2020 17:30:50 +0200
Message-Id: <20201105153050.19662-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105153050.19662-1-laurentiu.tudor@nxp.com>
References: <20201105153050.19662-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM3PR05CA0156.eurprd05.prod.outlook.com
 (2603:10a6:207:3::34) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM3PR05CA0156.eurprd05.prod.outlook.com (2603:10a6:207:3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 15:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51d75d31-9f08-4327-f4e4-08d8819fddff
X-MS-TrafficTypeDiagnostic: VI1PR04MB4895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB48955CBD3B833EB2A7B0785AECEE0@VI1PR04MB4895.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuaI4pzsPNlCQGKIr6gNJ6xIRRu4L4BmXGBqqTOC3Dk/L43SSbCPtf3uKrb99NsB0QLCvM7aUSj5W0wN6XJHVri2837AhHUE7RHOZb/eScUswY6K07i3tGygJ3sYaIFBXJAjgPqN+Djt8gCC6nIMvqMGclWgroGpMWmWYf2f+ZnMg3TpuhCNj+9C1nI4gw9uPqt2p44XLPFGU7S0grsA6qQOEsC6qr79MTpvfEFPCNYEpGrKzOqNVKINfWgOPZNt3mRvf0Vl1h9zZMMcnGpT0fHR2kcMD+xLQBmBn4M7YJdHTpvr8/+njPCOa4XokRG8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(8936002)(956004)(52116002)(66946007)(36756003)(66556008)(66476007)(2616005)(26005)(316002)(5660300002)(6506007)(1076003)(6666004)(4326008)(86362001)(8676002)(2906002)(186003)(44832011)(16526019)(83380400001)(6486002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aZZeY4jrvWWZE0JbaCitlZ1i/aE3bWBsnT5sm7iQXu/+H/ZRoheb2TvcCW6YsPGmZfpse+3bCIyvJkSJG3w4ixOPXEbXOxh9x48OyrJFdR2h6H3AL9XItK2jjlGpMXatXg1lA6izTT2kfnIJ001g8CRyUh2BZeeGGaQRw3GKNINQtBZ5Dw9VkKbNUp0n0AuvYA/y1glzvR37HnQ4JbpndZvXx7wcxb9IOfD8LaxXP5IHUJcvQlM4XXAdUAs2NI5N/VWhGQkMwzuomJAdnfej3AjSF4Ict3/ZMz9ZR2Bc3PaWJ9BtjqMx+LH0FVDD8mBuGmNLY8zsdcPsH92QGIm4UWNmc5e8OGmqYFoHRMzWUsRRxnx7KM5GmjQogc37KJcy9VczOzRU/2ia3kzfgd1D1mQkVqWElmAwWErkyPsytZcWGXIGybLho14gxG741nAQQxkkr629uy1X+WwiIgckMgrosefxhBWbFqpuJFfOTYi6Khcb4QDEytWNv1w0/bnA0X3tQ9T7J6+PRcIHabyhZOsz/j9llUtfIEeNuOC9FcLEhFumzX/8TUlUqUiul5U52B4mzo1XJ48w85gyrO1yWJh77+vt1hHMbTPFK5EGeu9jsHGfINZMVusHzovF1VkbBkCE3/1lxI+zYITfQfXnjg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d75d31-9f08-4327-f4e4-08d8819fddff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 15:31:29.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Bi0xYF7XKScMUAWKhjkAk8Lq/3exdaj9e8g1po0A237WZph9YV7xCSYhUcFtDqcaLNSm4rrTt0OmtUWExbxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4895
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bootloaders might pause the MC firmware before starting the
kernel to ensure that MC will not cause faults as soon as SMMU
probes due to no configuration being in place for the firmware.
Make sure that MC is resumed at probe time as its SMMU setup should
be done by now.
Also included, a comment fix on how PL and BMT bits are packed in
the StreamID.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 42 +++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 806766b1b45f..b8e6acdf932e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -60,6 +60,9 @@ struct fsl_mc_addr_translation_range {
 	phys_addr_t start_phys_addr;
 };
 
+#define FSL_MC_GCR1	0x0
+#define GCR1_P1_STOP	BIT(31)
+
 #define FSL_MC_FAPR	0x28
 #define MC_FAPR_PL	BIT(18)
 #define MC_FAPR_BMT	BIT(17)
@@ -973,21 +976,36 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 			return PTR_ERR(mc->fsl_mc_regs);
 	}
 
-	if (mc->fsl_mc_regs && IS_ENABLED(CONFIG_ACPI) &&
-	    !dev_of_node(&pdev->dev)) {
-		mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
+	if (mc->fsl_mc_regs) {
 		/*
-		 * HW ORs the PL and BMT bit, places the result in bit 15 of
-		 * the StreamID and ORs in the ICID. Calculate it accordingly.
+		 * Some bootloaders pause the MC firmware before booting the
+		 * kernel so that MC will not cause faults as soon as the
+		 * SMMU probes due to the fact that there's no configuration
+		 * in place for MC.
+		 * At this point MC should have all its SMMU setup done so make
+		 * sure it is resumed.
 		 */
-		mc_stream_id = (mc_stream_id & 0xffff) |
+		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) & (~GCR1_P1_STOP),
+		       mc->fsl_mc_regs + FSL_MC_GCR1);
+
+		if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
+			mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
+			/*
+			 * HW ORs the PL and BMT bit, places the result in bit
+			 * 14 of the StreamID and ORs in the ICID. Calculate it
+			 * accordingly.
+			 */
+			mc_stream_id = (mc_stream_id & 0xffff) |
 				((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
-					0x4000 : 0);
-		error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
-					      &mc_stream_id);
-		if (error)
-			dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
-				 error);
+					BIT(14) : 0);
+			error = acpi_dma_configure_id(&pdev->dev,
+						      DEV_DMA_COHERENT,
+						      &mc_stream_id);
+			if (error)
+				dev_warn(&pdev->dev,
+					 "failed to configure dma: %d.\n",
+					 error);
+		}
 	}
 
 	/*
-- 
2.17.1

