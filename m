Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7CE268874
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgINJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:33:13 -0400
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:45633
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbgINJct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVfVvp9sJVBdAx/Dt/JkXtuwCQxBj8AZBNTCAHSZOv1wU29Rca1meONXztBlLQynvQ8jrqLBallgtJtNAERMyZyk9+Ie0dUWMmLASVYbA2Si00m9ke8M/cc62Gdbl+k4PAEDpcEzWQwhjEoPwhcWKHTq37YHVE+r3pCBgYxlaD618QfztJ136+YXs3KXksnGOd4t1TWlkVllIpuLGcml+HNTtBXfPxp0Zh0QAIrgfIivbH40bd54xuxOpbO5xr5vsu1mgJ9mhkwiE3C0L75SrDjZ9dXHuy7kgG/Sm38/wB1G8mqlULQRFVaRUbh+AgpYJ3ggeoTuzwYdPdC3YNoHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/tYqyR7AHVcgpgMKDqvpjZ5oCafQgTOGvuoxdkO7XA=;
 b=Eg52mE/5dsyPVi+4Bdtb57XW97UZOkZM1cKKzLTBlrqCLtMUEmtGPYtX+g+szqrJNGrWt+XkRuMEOD/X9oLo1YXGBmwt5Z3fxkU/wqsIseGOjsA0I+FQ3zEtowO8rINEPjDM4t6s3UFtB2SK5o9DbyM8P7gfLBMumqEWWb0dmmRIuL33xRnhfkIWkicW3B+qVXBCn4QVOtWrb70PTyuCeaPmEsEYvtGNAzbkYpSG8+x5DKVUbCqnv1ogRqKDziFZ9mPbW85ZmnRZmm9YNkWnNAOE+PLBbDryQdIjHJW63dff6K4/EM+v5PZtTm2p9vZBTcnq9DMZJ8WCkwrHNzGzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/tYqyR7AHVcgpgMKDqvpjZ5oCafQgTOGvuoxdkO7XA=;
 b=JeZlEstNfEuc5BnD4Bo3LtNBokVtT9cdZAUI7LWebtI+LqrLvVVIHDNotUC3eQtrJCM5L8/btmrhYCn9dVG8FNLMfqrLsHL+5oRZB5TTGukePqzpECoMIcNYV+JTPwgmh2i+5WNZjfe6zFsgKiHNJDJC3swa0772w2PsYbD/e6E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB7405.eurprd04.prod.outlook.com
 (2603:10a6:800:1a4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 09:32:45 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 09:32:45 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/3] firmware: imx: Save channel name for further use
Date:   Mon, 14 Sep 2020 12:32:26 +0300
Message-Id: <20200914093227.5094-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093227.5094-1-daniel.baluta@oss.nxp.com>
References: <20200914093227.5094-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::38) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR06CA0133.eurprd06.prod.outlook.com (2603:10a6:208:ab::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 09:32:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2bddc46a-b989-4e7c-10a1-08d8589122fd
X-MS-TrafficTypeDiagnostic: VE1PR04MB7405:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB740535744F961F0546465B85B8230@VE1PR04MB7405.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iq3RShwvdz0nCx/ZHKAw3vDit34hQ2xDrZGuY0oRCJyPoA0LI3SxuHSqI4a+PxWn3svzIrwOk5h3Hs79OLYpdsX9An9JDR39s7Ih3arbvq0gG7RMBqu1Lsn5YQEJPo/1jobrbfAZuLbOzn0O9E0CqO4Dvkf2UaqBFSJIOB6MvIKmXwHAAwBRgmpw2SDVFDMBpFeD67XYbhCLQOAPaqaWsNinRk4KrfhAxtb5MMoqrRxuKRrWsH+B1m8LGTYp9ojuVNjWZHV/mGxWSCT//4e4MY0oVaViCbA89lpF98573QRnn3e2ZL7DfaSHcvseXbceJ/O514X6gQ6HvKBWVaVl5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(376002)(136003)(396003)(6486002)(16526019)(86362001)(5660300002)(83380400001)(26005)(6666004)(66556008)(66946007)(66476007)(6512007)(1076003)(2906002)(52116002)(6506007)(316002)(8936002)(186003)(4326008)(956004)(2616005)(44832011)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NP46LHhP1wzU/9S93aCxXeGHJhuBrUwM83XVkYaoqYfJbz0KVkCxKgbWAp4nHoax4Gl4b30jZwO72O9F5pg34jZm/FEXVW1Jh/YvKg5FCdH2VZtjVr01jN84oGmY0CZ4MaWlNnvv+uIC6XxWDjiCrg5rO9Iw0MAGMbiA1EY5lqmBhn9ElMXOzxu1FU/Y+feYmbLJQ1PywRmA9Vk8T0LHWn8dCQtuZmxFGTyv617Z71vjSnHt0BvqJqJiQJ3HFKGSgEpMuwvx4OCq3R9f0j2PWRdOm7WzdtPFxoZF2oNWpi8BAwhPukKaFnKyoh27WeU0As3C3ca0rpvsxN8DUMDLOlt8oRdtPbls2kX7vE0F1APzdEjKc96RiMq7ndM0MlZLkf10UQd30p/BImhmPM32UyhfsYNtNeSktIc23tPKyOrX6Hhd7X6C9n1YCveG10eZalrvZJ+3JCAIvYvICyS5w1Ro7VP4PR7hi/VcjbQm26xOKbCRiuuAhUk0jNLoXYZzLZT7RFMjV2+xjioXI2JkuFHo4lSX/MOctkpmHScssuYD5yUF7vcZbDwq9IJoTPlgGcwbZ/Z1Rv2o1dgTtfDXBY5dGBr4fE5+Q2i93tsauPh48P5dgwCLBCPI0RatRBr+0sN3Gx3/xuzRKy5rp3+C5A==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bddc46a-b989-4e7c-10a1-08d8589122fd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 09:32:45.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcOm6V6q1UxYdCmkso5lCXn7dhrHfxZ15rHzoEFM5tlqNEvybpcQbg37Ao3RZ6HVDO8r0c9BmmA7+afQXuoGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We want to request / free channels on demand later in order
to save power.

For this for each channel we save the name and use it to
reference the channel later.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/imx-dsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index a3a018c87b52..b6e95d6d34c0 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -79,6 +79,7 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 			return -ENOMEM;
 
 		dsp_chan = &dsp_ipc->chans[i];
+		dsp_chan->name = chan_name;
 		cl = &dsp_chan->cl;
 		cl->dev = dev;
 		cl->tx_block = false;
@@ -97,16 +98,14 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 		}
 
 		dev_dbg(dev, "request mbox chan %s\n", chan_name);
-		/* chan_name is not used anymore by framework */
-		kfree(chan_name);
 	}
 
 	return 0;
 out:
-	kfree(chan_name);
 	for (j = 0; j < i; j++) {
 		dsp_chan = &dsp_ipc->chans[j];
 		mbox_free_channel(dsp_chan->ch);
+		kfree(dsp_chan->name);
 	}
 
 	return ret;
@@ -147,6 +146,7 @@ static int imx_dsp_remove(struct platform_device *pdev)
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
 		dsp_chan = &dsp_ipc->chans[i];
 		mbox_free_channel(dsp_chan->ch);
+		kfree(dsp_chan->name);
 	}
 
 	return 0;
-- 
2.17.1

