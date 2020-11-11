Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13E32AEF57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKKLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:13:43 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:15499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbgKKLL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:11:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqT2ItgY6RlTDyIzbbOE/r7jrLEvPYXmB/4HZ9gd249u3FbxrRtNtfqpiIxu4F1DBWnJgUkFxeLbWisAi+nFGABp4Cp5nCgg22FsZ9wIB7VrcPr0AuQaSbZKhoM3YfGedgiQ75OYq9YYY+jyaBD664cpS/6lOXZGKZtS+UuIyw/0yLrg05WAquBgTRSh1JxhIAzFgQNRlgSEGvnUXGKYGKqqFhQ3N7uFnrUZRL+lzWdT6Z6NjQHVRUislbD/GyM9/2PmDS/lN8rqMjyC0j+e87+D9Op3JVThdzam7IDvzC0XeZT0cj/ZVF/1cdc2mml9YdHqKgWVwWC3WrklBaP+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0WQRLCswfFmHIwbS9PaFC7gyky0f+NMzmelxEMPkTo=;
 b=VAL9rkEkX3tYfo5QH3bu4H3b70MzCCMr8sbsiySfxzv/vKZtQ0PXvhNtbU9awKYOmqpTXupE4WrZBY0ytdgV2jlaSOTmOuZ0yDrehxMC3ga4y1EuGV8qOAaMcciHIfmbD7++STEtVfB2HAtWCTPfLnBD3QyQhYu2KSgo4dkHfkNSsirzziwH6tB689n8ykyXh2v5hCwJpq3YJ3xzK2fLX40mgewEPM6qgg+4A9I8S3W5RGM6FxlJcVMji2yseZt3DO4sX1HSw2ZR1NbNl2QyC3to/D3cqgvMZgocfSl7mSzmCmVH7oS3m8mzscIQvz/hXj5GAQ3jNWUyllESpyxBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0WQRLCswfFmHIwbS9PaFC7gyky0f+NMzmelxEMPkTo=;
 b=d2cdz8wTJ+YYxRcklo7ptFXPkmiSvpvnFiTko8xARyvmordr62IxFwbdNqR77maCPUTFpm8WZqk0zpi0XpIFlNpUipRPkVsyJ/1R7J5+7uwRkx6kuXCGl7oaQFd0j8H1XEoIHfhzmnaoXkCzQjS/g0oK3lweUeuduLfnQypYTek=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR04MB5774.eurprd04.prod.outlook.com
 (2603:10a6:803:eb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 11:11:48 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 11:11:48 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        shengjiu.wang@nxp.com
Subject: [PATCH RESEND 2/3] firmware: imx: Save channel name for further use
Date:   Wed, 11 Nov 2020 13:11:17 +0200
Message-Id: <20201111111118.21824-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111111118.21824-1-daniel.baluta@nxp.com>
References: <20201111111118.21824-1-daniel.baluta@nxp.com>
Content-Type: text/plain
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 11:11:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ae745e2-1d1e-415d-5977-08d8863294f6
X-MS-TrafficTypeDiagnostic: VI1PR04MB5774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB57749C134E484E4D3DD39DBEF9E80@VI1PR04MB5774.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmZIcUz/JN29Uz929fr2X6Q6qPtZBMGu4ovl024BlIjpJBWvhFr6pLJCeunur7Lg7cPj2jFedZzpBXACZEgzKAABs6tDKgH30fSIq50qqhSdYGwZNlv4B7t/N0d2zsyVko0sxEvLfVst/9vjunsQIlJ/oc22NK72eOf5Lf+nZzUut96MfCJEvRR7WWqVEdZOKMLVMEHIb9s/W3xP5ZgDna6xLkLT7xo/k16UC57Vit02g2N37HSC7EeaLC/yMIwNxF+GbjQ+Gs6CY7tmtvts5AWz1zHVEQCz30AVpqrBKl3YchSYTO+3OxCLP+1MeoqHkAmVgU3W/aDjFo6sjxb1JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(8676002)(66946007)(52116002)(8936002)(86362001)(2616005)(956004)(7696005)(478600001)(4326008)(44832011)(66556008)(6486002)(5660300002)(66476007)(186003)(26005)(6666004)(1076003)(16526019)(6916009)(36756003)(83380400001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WAs3EJ8sCm3IbzWcIs9xaoWDbCAtlvhdxEUPHvEWx/vOLBMdau4xcOFiK6tuPQf38AcUNX83uSFi9x3GmGkUQRSuzfG9PegYU6oZZmrJrbSezIDh3UQI6EHt0bwTxI3aBJRKKBOLtERwFUADUr7oVbtRq7w3mKZ7a3qYUEC5M6B96CnPk9VypETjSZmDcet9J9KQL2nUY5LEL9CajIWA2AwmG6LR+9NQj375mjIFA/M7QeEgvgL/sNntFL7NBlgF8c+b9JdYbP9dJep4ef+gnaaKG6pO9C6+TbrsRlm0sPSxv1LyPhYllV+Yv8F1AUqcJKeMSryeI/XeHPL+edsFjsnWryJ88jRtl7Vjgig7QqHoqvbeGRDiVbfEA2TDDzIIS4wj+LG/Sz5mrwrJ7+yUtExAM+K6hcx3B/OGkXSbTpQoWDZgOcr8x/MLxGuzPjipEACMPCE3upsU6wsn4GzRHJBzZYDSUavbchvS4uGDRAlnT6a3wBZwDhS6Nht6GL2cq6NftdWMGRFfP+wxy3rmr+ooSXlfROR+dsNmWFMN56aD7Qh0jXWg+1whc5sBdY8pyT8EaciKOGOrDZW7muw7h+tb6oNjMf9Rt57dY4qmVVaIAQTQ710m+zVS4dzlwDkGyEKZlX0zTSTnQxoYs3Qz28hlA4eOs3YPi0stntoE/lqV0/FBrU93gI04Ik7zDXiRm4p/gmmRwDUrgF/ZNW0GFthw1B76oDKNjDPQc2UWSry8o2lwJLg7aENVIxhJH/6P3v9E/A9Qa482U+dCEREL44hq4OsSeripNk9k6KAdSfMn7ZlGZJWj23x6/4cfgg+xdmiAOoB93w9r21+3MHER2Chv/fgPl2f+/Agma2rzHuoEPZvzspNCi4zPH+L5vjJgXswMsIgXbtHyRw6DEJ2RPw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae745e2-1d1e-415d-5977-08d8863294f6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 11:11:48.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvWF0rDDICl4wzQfgezfNjLqeQ+mrsxi6cKqfB3+Bowh6b/VxHGryr4Po3dxNHlNkrAfamvFD1xMRkiI+lOQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5774
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

