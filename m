Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC372AEF56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKKLNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:13:41 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:15499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbgKKLMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPFeYYfzFayxcgIoN+n5kg6+dIdZY+Rtr4UdUnWmBCNuCRcFA70QzGE8SOk4TXkB4NHEQBm94QybXsSxoviZDCC3sJtY7+COUbkwyDgx/cnOCkEowM7KGJJ3xpNT3gZn0cbKU07Bi0r8Wdy65QAXKICGS92O2hkDvXA87bnqmLUuyrrSikU6lN50/EkGp8aWO9g+nxIO9RhnmKvYQa82rXVBitzxfusJAAj/Qpro5PsVc7mxudGgFjHdPi6qqoqwOfi9wU5ii/dEkgiI4ifz9yWTdX8bIwTYXaShLr5vgcxXDF5xM8xO0kp+n+PGPzbBL3S6an0UB4Ce2C25AIwb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqujLPZcdGxiqmste7of0HWz0DlohAIIIzg+XUcF/Tc=;
 b=BdhHIMIjc1J66OH7nAjJWo/z/4k82JN8ZrkrYAfe8QBH4xogg3lvLtNx72xXbNarp/2pgwZwpnnMKdNfrWZ2q2+Zm70+6GR9xLj5vamK5dmSRom9r//z8Lv5xmgp0lKrIHklD0SYIcJEdltRO3HoxZQvhk25DalEqhQ9bLcwTTUWAg+G0XEBNmTeLj4qwzi3YivRmVut6aAg6fp39pLqiWop3iBh+743yn4BW523YHsIahCM/ss1AOWRF7gZKeiyCV+mz2UZfnmIamBmL6OS1J+ZQsHeFxZ8VfbKIfkjXHBECPm+u9UXjGRXi5Aw0htlK+cIbj+bvVWwBWNwTzJdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqujLPZcdGxiqmste7of0HWz0DlohAIIIzg+XUcF/Tc=;
 b=dGUcXSAgq31O/V4UgMb9VP/1kAqksf1/lGcd+b2wCZqVa7wUksS6jcnzoPHLwlBWGTaWblcHgx6sf9XifYuYqRMAdzmFnBFpO5zjMoEBgxQ7fBl4dhtw518ngKqWZF3Nd4TIyvlMtSPl+OIttAn+zMAnslIYKZWgQMZWpJ4r/sk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR04MB5774.eurprd04.prod.outlook.com
 (2603:10a6:803:eb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 11:11:49 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 11:11:49 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        shengjiu.wang@nxp.com
Subject: [PATCH RESEND 3/3] firmware: imx-dsp: Export functions to request/free channels
Date:   Wed, 11 Nov 2020 13:11:18 +0200
Message-Id: <20201111111118.21824-4-daniel.baluta@nxp.com>
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
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 11:11:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80fbc043-7a10-46f2-4078-08d8863295bb
X-MS-TrafficTypeDiagnostic: VI1PR04MB5774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB57744591A6289C4761404C09F9E80@VI1PR04MB5774.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWQFsMec6cKvEsGjfSIgz4J6USNC/1XzsyI/TfqnZPH65iXApj39KuUjviHHxczPjhcqiMRt2TXX++sjnh0DA2jWNM2F50iNmqyzacuXU49isDtBoZBOqfAot2X8aXFCGZDUd3quOFNCOtHgZNddl33c1sMWBvf4IE2t5Hn5JV5KmIbaHd7xuw1TSFbEKPV/aXXN5Yd+zUbKSdq0c5MRDn4Y6RTeZJACaT0tbONiG62sm8tl9xejrUba8E3GBKggXHSI9BG23iwhmMF8uqizcvICxYY10amsagEG+x/III7EeGGmauxLKh8hHpYLGhmUAtDmHWR9JYSAyGog9ccDnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(8676002)(66946007)(52116002)(8936002)(86362001)(2616005)(956004)(7696005)(478600001)(4326008)(44832011)(66556008)(6486002)(5660300002)(66476007)(186003)(26005)(6666004)(1076003)(16526019)(6916009)(36756003)(83380400001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xkLQuE2Vz57Y8u0L34AktucSFNIp8dmZVbC7QPaszJP3+n4n8R0VvCxVEJIBYBXCDTqmwqnZpIFgunS6Nzq6krIqY6hfhbQc6SH6mHW9Cko45lbEnNg7FIO9PhcaDuyM2AKSom5uYIacwMQs/kDRQR+fpgTADVwhK5rwh7Cf6PY1QUgIIc8WHh9YKT+ob8ILuSpV4KnaSF6Ul1Vu3vu6gN8WDYlXwH98dZeLx+eXdC9CmjfZUBPbprU2ZNEG1FvhEAwS34b0l+Z+c1gXFSwJ22//NQdtKag3UkBRGpPQy3LHud+Q0ShaKFD4LixoC82NlnRmV9yuE8o+tPNywrSU/pOd0uF0xHVL3REZmwltDdCNO6BAD3poucfdC2+bZFFPWOKtOWE/28wJMvjnsuF+h4nXSYgPma+brd+xF6y3LeQ6JjikuRqY8FdRKhjiw/LBd4V7Xi6Lbgu9AMVbi9UFksKbwMgFnMH/hYUxMPOElnSWTyVFWYH17PRR3qK4sc4m1KjnUg68DqLa7Njr/kfZ7ofbEfK6Gifa1DPny3p/mXBGQXhz4ixQTe3Mr4CxA/dW+4mxlZYD1GHv8Bbpzucfvx2Y+CBCCVJR/fKT+VaGgj7uZX7thqCX7MzCcvHxCA7VJsQeaXMC/3aASAGUuNpuXOFSlE6F903xDPg0QP8Ybx0SIoZDqF0KkgrGs/UbJh/LUPCNEWMmpVgAhfIwzqbyj1czaQdMj0EoYjdLhHvKMS9Lmx8+mEhbs9YYA13JQWo4A1OBG8yvCD9vLEYr0228gUyfRS0gRgd7t2dWhrg7c/129k1V1oJvOn6GUyT93dD6iWm7IICFTurQl82f4ucvNmlautZsFFRRc0A3F+o4Uqm2Xf2baf8g7ot4JpQwvHDkN3G1dEs8SQrZa9xJsyjA0w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fbc043-7a10-46f2-4078-08d8863295bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 11:11:49.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU4X/Bfir6sCqbnihoy4bGcMBtW9WrIzbjX1KPK7toZXc5ErUyMFfjlIvkJ/x3L87TRKL6HbY93ytxfgTPd/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5774
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

