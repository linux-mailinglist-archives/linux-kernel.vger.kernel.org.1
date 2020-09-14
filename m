Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A555F268877
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgINJdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:33:39 -0400
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:45633
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgINJdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:33:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Bb5L261vHkT2139hJMsGGh157COytZBy06aMTSZQPm5UkXia06waka9TkTpuEWWpumG4H2YANManmsX43Sm78doMvNYq6KTE/tgoEWZ9DztIrd1bfG5XCRF2O/H+epQm6hhwyZsm/NieQOHEynfz0VqCAEWDJvTVAQFTPyOICTaAwtF2ymK8p5gDRu13i3tYe2pcF28WBmIl3/HWQWW5coT0SHnz6s4h1fTovdWinDSm4N11p1zPt8ZuGuEHbSw2I2nm/U8PqzqOjYBKOW5u8WLXE6/y32ZMA7UdrnY9d0ck5GhPNOqV/zmITVHGRXNq6uruxIoddQau9axTIQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx+fvUeueNs7OsvsFQZr7T8aAABL4CCpTJI7Pg02XHA=;
 b=ezP6BB1aCtajGpXfWkUDGFpTOIYnnYJ/uxqh5RjXPK9MBiF7nsqR/ICofKRx/PrhMzbtyIQNHEQ1pees8ggJfoMoCAVoUfm0ZiSeG5K6+x2Y5kMPKIsqFGo/Q63uAv9o2Ia6S1owv6FnzMCS9H1WsV3kFF/+h0ndoN277ZwOz4NTNGLshV0rFfyABVkQslCxvkBbdH6j/c+WLpT8kJ+FhMpT7Xbvvn4bBbr/RV36lUhipzBLT1W8Wy3a5WZtmC4lL6S+ugDU5PPAaffhrA+TleqZx4KxxpZ0cK6k3bg5LET5R1USARcnbAIcV55Fiy/Y9scgZ7TtHNBBqA/0zmydmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx+fvUeueNs7OsvsFQZr7T8aAABL4CCpTJI7Pg02XHA=;
 b=d3cqzsXY7wdNLf1PfaDKqPLx7kYP3PMflRwR2fB7p1/jTk5SyyDbEln9YZzlWm1EehoAYh/qJe0i+X3AOUfDvOhULwIxTiPSzfVfzHp5Wkm9avYQAq+8RKvkH1hD72Uk81BN51qislxLsp859qeA2ZzOAjbH5/1D5yoKvcJgNk0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB7405.eurprd04.prod.outlook.com
 (2603:10a6:800:1a4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 09:32:46 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 09:32:46 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 3/3] firmware: imx-dsp: Export functions to request/free channels
Date:   Mon, 14 Sep 2020 12:32:27 +0300
Message-Id: <20200914093227.5094-4-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093227.5094-1-daniel.baluta@oss.nxp.com>
References: <20200914093227.5094-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::38) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR06CA0133.eurprd06.prod.outlook.com (2603:10a6:208:ab::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 09:32:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a21a4737-770c-4031-1b3c-08d8589123a9
X-MS-TrafficTypeDiagnostic: VE1PR04MB7405:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB740541546F22C864DCD01A4BB8230@VE1PR04MB7405.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPKlE2TTh0vHOhN6c5yGjfpia4/AR0qYmar4AWL3+l+fQwLIISo+5ds+cCOtTO04MjmNPfwKQxekiEJTOh2Okdgv5vMIhbFp5alqoAXpVunBVsYwMrHHx5b8pjn8bq66ow2Yt6OxHvYjUkg8CUH4UfXSk5jJ3I/IO7oAtdRmlxAgWSrCpOJuZcCNcAGSmEIXqZZQhVWO0KRHU6hpf6ZpIdRkrUKgmGDeBi/q5JkTdqQ5EaDAyeKebCubZBup6p2JnxZumxDCC9dirxX3skHJhRqp5ZOMc6yoRGMDfj4Bj01TbCn81zbMp8Pr2IzFSWjmEAZwcQyuOVa4HK+WBKL7EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(376002)(136003)(396003)(6486002)(16526019)(86362001)(5660300002)(83380400001)(26005)(6666004)(66556008)(66946007)(66476007)(6512007)(1076003)(2906002)(52116002)(6506007)(316002)(8936002)(186003)(4326008)(956004)(2616005)(44832011)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ly19g6qMjvS7SQXJHOs4Cya5+j/hyY7wrR+KQBcJECl4OWKC0+lkYSmGMzrIiZitEVVsgFvn+QO2XMsKIhNEZTvxXZNNamJWpZp/6h9Q/+lwieARDKBQsm1q4vgBj86LTJU1Vju1iRumT/LvAg/Um7KDRljgH7mpg0jS0gfrbWA7sPjBkaMSRXnsmZXvUsSuNNpG6AxNb9Y4/L3k5AQcATi4vNi81JfF/xyyMBr8zbaNxtiLldsGhLEz5ApMNUDoQbWeAzGGlPQxCa7IaDpi8EJZ/gC0e/Ov2GcMgrUUx1gVt/I7ZYrpfa84LmqwUyv2k31ar06lNmu9ZRJGW+Uo9BqeLMS3SbWDksflESctt+3yM1CcLnL3aktftrwRMiqRH3bLi1ZE/6NEpe1n4DdUY68rgrxcTME9vAdTY2V/X5pSiQ0ke3/OwAL6LeV3+Lf+8C6YHR+S59moYn/qdWNqdW3tOkhQREBqy9DE2SuSHgoDW/zIJfokNowlBuY9dz2PqiGybCvsDElkn54tp6SM8F2uYhsNNlSDk0+WHJHqDC6WJS2FsKEGPHKGAHXBmHGty0GqemA1W1S2xOPUBykBzcuIw8aAq1P1uuzbfnUI5TxzFDZZA9RkZrHzCDkHAATJzOy9XiSoRmaocvd9TjGviA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21a4737-770c-4031-1b3c-08d8589123a9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 09:32:46.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtfvVe7Y6gI7MoaqavqdWBFq3HE2jBjO/Xnx7QkcU6GKQ/kguwxvB2itsVOrPGK726JEeA8O8nL8EFnpkGFVZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

In order to save power, we only need to request a channel
when the communication with the DSP active.

For this we export the following functions:
	- imx_dsp_request_channel, gets a channel with a given index
	- imx_dsp_free_channel, frees a channel with a given index

Notice that we still request channels at probe to support devices
that do not have PM callbacks implemented.

More explanations about why requesting a channel has an effect
on power savings:
 - requesting an mailbox channel will call mailbox's startup
   function.
 - startup function calls pm_runtime_get_sync which increments device
   usage count and will keep the device active. Specifically, mailbox
   clock will be always ON when a mailbox channel is requested.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/imx-dsp.c   | 25 +++++++++++++++++++++++++
 include/linux/firmware/imx/dsp.h | 10 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index b6e95d6d34c0..a6c06d7476c3 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -60,6 +60,31 @@ static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
 	}
 }
 
+struct mbox_chan *imx_dsp_request_channel(struct imx_dsp_ipc *dsp_ipc, int idx)
+{
+	struct imx_dsp_chan *dsp_chan;
+
+	if (idx >= DSP_MU_CHAN_NUM)
+		return ERR_PTR(-EINVAL);
+
+	dsp_chan = &dsp_ipc->chans[idx];
+	dsp_chan->ch = mbox_request_channel_byname(&dsp_chan->cl, dsp_chan->name);
+	return dsp_chan->ch;
+}
+EXPORT_SYMBOL(imx_dsp_request_channel);
+
+void imx_dsp_free_channel(struct imx_dsp_ipc *dsp_ipc, int idx)
+{
+	struct imx_dsp_chan *dsp_chan;
+
+	if (idx >= DSP_MU_CHAN_NUM)
+		return;
+
+	dsp_chan = &dsp_ipc->chans[idx];
+	mbox_free_channel(dsp_chan->ch);
+}
+EXPORT_SYMBOL(imx_dsp_free_channel);
+
 static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 {
 	struct device *dev = dsp_ipc->dev;
diff --git a/include/linux/firmware/imx/dsp.h b/include/linux/firmware/imx/dsp.h
index 7562099c9e46..4f7895a3b73c 100644
--- a/include/linux/firmware/imx/dsp.h
+++ b/include/linux/firmware/imx/dsp.h
@@ -55,6 +55,9 @@ static inline void *imx_dsp_get_data(struct imx_dsp_ipc *ipc)
 
 int imx_dsp_ring_doorbell(struct imx_dsp_ipc *dsp, unsigned int chan_idx);
 
+struct mbox_chan *imx_dsp_request_channel(struct imx_dsp_ipc *ipc, int idx);
+void imx_dsp_free_channel(struct imx_dsp_ipc *ipc, int idx);
+
 #else
 
 static inline int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc,
@@ -63,5 +66,12 @@ static inline int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc,
 	return -ENOTSUPP;
 }
 
+struct mbox_chan *imx_dsp_request_channel(struct imx_dsp_ipc *ipc, int idx)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+void imx_dsp_free_channel(struct imx_dsp_ipc *ipc, int idx) { }
+
 #endif
 #endif /* _IMX_DSP_IPC_H */
-- 
2.17.1

