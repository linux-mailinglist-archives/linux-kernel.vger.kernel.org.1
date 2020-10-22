Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922DB295999
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507555AbgJVHuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:50:04 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:52833
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442534AbgJVHuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:50:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmS/b+O8uVu2IV8L9V3hSfnX26pwJV0Qxid/bBnikmy6PWuki4pt2+6ul/e/b68MhA+mO0y1y3aAQMtqYLFS5shWOO/GTEmkR7tsruvx5KazvC8Gb29MxAdAyTRt0VzfNx0VL7aRlIV+9C82MG2v6HnEx0BpsunUKst6vtIFW88SHm3cwZd5+Gu5U1LxBROCa8NZj0hv6Vtb90VyTXJA84CIQyCTxUY2EN8qMs5WFWuiHAk5aDR1uthz0sEsWJn8RcLHT0pYq+2l0YeQBykibPmulnd8et6cv+5eH0MLGdgnUMWe0l21CXcB6K6cYcE5UK/JXPCzshNsK54bWFkunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxnKeFPk+ivLhz6ZWfA5yHjkSK8GaQVbndAIQaum2TM=;
 b=BOvHF6wc0MSVEeqWgOXkWXuiIYaDMG9ZMin+4xQQ2glPX+RC1hVumjQ7xujPkmC3eBiH64NCHCoX7jO1fJ1agjkkNwBPahULL6VMLm0d7DwHVhRavfrm1Q0RA4edHOmuVCeIMDcHZo6XafHZ/XxQEcxYTpDKv4lbjWBR2vzK4Y2kqT+d00oLPfA2r7vNL91bpc/tyk45vW41Ps56tstfKghllbMdIp8BbFIaKqpteeLKQTNBSDbH4FMLJZ670AYUAH4g51y5RnTi9dFLPGRM8UACL4N+SCglVcdLI6QEFH9/pXMRQmajxLR6dPgEPhDFzKL6Sl+gR3TW5sHenUDA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxnKeFPk+ivLhz6ZWfA5yHjkSK8GaQVbndAIQaum2TM=;
 b=NkG6QCCBsgKhTKGu9vBMx69Z1ya9IpMC8jV3U9UplXRBcOCBtcKBlAHHHuza9Vbwju3Y35Ib7cSt79zbi1eOGGm3+2KvDA2WbcJp0tAy8TiNm+Mx3VpaGNXy0sWmst2PloF8keD3GMKGQm5GlmgQXVxi8woSxlAr18svf3QHXE4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Thu, 22 Oct
 2020 07:49:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 07:49:59 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        srinivas.kandagatla@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] nvmem: imx-ocotp: add support for the unaliged word count
Date:   Thu, 22 Oct 2020 15:44:43 +0800
Message-Id: <1603352683-23918-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 07:49:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: caf179ac-41c8-494c-c645-08d8765f1347
X-MS-TrafficTypeDiagnostic: DB8PR04MB7050:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB70501507219DE6D7775D1DB1881D0@DB8PR04MB7050.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yiFBsGGIpR8wCFP4wj/DejR+V7+gwyLbQueZYhGGlxoZooHdU3515Tz6wmRm1VWCiw/0JqgRKgv1ENJ3evjhsuzmBEiQTOFTZ1M9VyoTQNQUo7ToRgTLp4Y/2GWtbI5zp4ApyDeRn/n0mtptEoQWAeTNYhinaRoacE/+yP6SGCebi/htJeAyQ7Z65XdcZ/f9K0eGLNP3sHB2C9Qu0E1/wdkoazfipg80JYR0yjkkUwkGq3rAJExohPtgnelyWGA8+NSSDkOgj1U2cd8WFczP2i/gitW1iwcdfjB1jCYOZ/4MExc/1CjxM6OFgjzBnfXQzGF4ZGV9SdV4WYBoY4Iemvw2Czt7DqMk4GrC4LQd4/xnyS9OscoGMfJOcO33dqy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(6486002)(6506007)(66556008)(86362001)(2616005)(6666004)(8676002)(956004)(4326008)(8936002)(36756003)(316002)(69590400008)(66946007)(2906002)(66476007)(6512007)(478600001)(186003)(9686003)(52116002)(83380400001)(5660300002)(16526019)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: THNT9BoyYdCSSP7qM7aHLx1WMUHAn7GumowlpQVKbJ8irbxCEYG/+CdgeSXdqrx67ao8Yy2GQ/aUmekOGHTtAFPwpBPIiYvE1JrWrQ3j7vOYoJDzxpKaSaA2nQjFrIyl+MUTGZfbJMIVIK6IwosQWC1TwJqFawXcka6Y3/2mUC6wbnXy5hrCd1xHxSzyT7f+aoPP6npza0U8F0f+IBx+fitH/KQyTdNmKZTnh346vq8QA2kkQrM5qocYSRWwuBESBuQsvmSt1Xqoma32Xtqx3hl9tIeoIo/fRRRdUJlyiDAPs0bTxz5e9HT0yM+l2j8VLNR4bJiAzEtnbjQaKd2tKo8cDDAEU8CWFPcKT6HA8Lnsvllldr/Z+jgKpFkOLitc2EjiZ7dTmKmuVKbsdRgustJcJPokHPW6qcNcbvlaTnRKfYzizTVMJvA8MIUfcxOLalR/BfuZhpau7nYUJKfyiNTb6fTwP+x90aPkHZXezCGHw54c9CLCwk8qBbh8RGKNIEVd4v1AvZlbWe8h256OIjR34QcyAItr/5Z8ySLACYlH0OOv1DJcgRSUzry1ghRp6RzLHHsYDcGYCpH81RBYlzwUWElF510en8KpDr6RJ57QlRFAkWLaPuhudd+1JOeGY4W4d+WVOSOHaEdHpt5DIg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf179ac-41c8-494c-c645-08d8765f1347
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 07:49:59.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVc6YF8zXC83H71L3U1L/c5aZ0/nCEGyqGoWCwBhXfyN6kxfKanwH6uSHC7UbR/28H8tLQZv7kbYiL6eBz9hVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When offset is not 4 bytes aligned, directly shift righty by 2 bits
will cause reading out wrong data. Since imx ocotp only supports
4 bytes reading once, we need handle offset is not 4 bytes aligned
and enlarge the bytes to 4 bytes aligned. After reading finished,
copy the needed data from buffer to caller and free buffer.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 7a1ebd6fd08b..08f41328cc71 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2015 Pengutronix, Philipp Zabel <p.zabel@pengutronix.de>
  *
+ * Copyright 2019 NXP
+ *
  * Based on the barebox ocotp driver,
  * Copyright (c) 2010 Baruch Siach <baruch@tkos.co.il>,
  *	Orex Computed Radiography
@@ -158,22 +160,30 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 {
 	struct ocotp_priv *priv = context;
 	unsigned int count;
-	u32 *buf = val;
+	u8 *buf, *p;
 	int i, ret;
-	u32 index;
+	u32 index, num_bytes;
 
 	index = offset >> 2;
-	count = bytes >> 2;
+	num_bytes = round_up((offset % 4) + bytes, 4);
+	count = num_bytes >> 2;
 
 	if (count > (priv->params->nregs - index))
 		count = priv->params->nregs - index;
 
+	p = kzalloc(num_bytes, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
 	mutex_lock(&ocotp_mutex);
 
+	buf = p;
+
 	ret = clk_prepare_enable(priv->clk);
 	if (ret < 0) {
 		mutex_unlock(&ocotp_mutex);
 		dev_err(priv->dev, "failed to prepare/enable ocotp clk\n");
+		kfree(p);
 		return ret;
 	}
 
@@ -184,7 +194,7 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	}
 
 	for (i = index; i < (index + count); i++) {
-		*buf++ = readl(priv->base + IMX_OCOTP_OFFSET_B0W0 +
+		*(u32 *)buf = readl(priv->base + IMX_OCOTP_OFFSET_B0W0 +
 			       i * IMX_OCOTP_OFFSET_PER_WORD);
 
 		/* 47.3.1.2
@@ -193,13 +203,21 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 		 * software before any new write, read or reload access can be
 		 * issued
 		 */
-		if (*(buf - 1) == IMX_OCOTP_READ_LOCKED_VAL)
+		if (*((u32 *)buf) == IMX_OCOTP_READ_LOCKED_VAL)
 			imx_ocotp_clr_err_if_set(priv);
+
+		buf += 4;
 	}
 
+	index = offset % 4;
+	memcpy(val, &p[index], bytes);
+
 read_end:
 	clk_disable_unprepare(priv->clk);
 	mutex_unlock(&ocotp_mutex);
+
+	kfree(p);
+
 	return ret;
 }
 
@@ -447,7 +465,7 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 	.name = "imx-ocotp",
 	.read_only = false,
 	.word_size = 4,
-	.stride = 4,
+	.stride = 1,
 	.reg_read = imx_ocotp_read,
 	.reg_write = imx_ocotp_write,
 };
-- 
2.28.0

