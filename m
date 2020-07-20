Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24806225858
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGTHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 03:21:41 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:10157
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbgGTHVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf7/4cPqZ6aPJYQmDgzMJ82XqAQMX39PpP3W7q8NuMenbsgUingDEJZse1ebdIz2tQzj15CFUYlqv2NV3OaulapACwY7W4gCTWeuBUseL6GlNagt+5TEZrhLgoHLTpLt6K1jkkqQHVUAKy9wEXakI+5MRW3FdjQOrMV5ItKEQ50f9KlEQ/t5JyAX6/4Bu/HTDACrl/y0vcPkBlIDWYC2i4siqrYoM8nKq+iG4mASb+lw9g9AXAsOwEFJlDSDy6QvBpy/BeA4/S0IbVS7ELl5ZUt3jd1K11e06ypujZzNUn+yy+gOCxTzcY/fQPZ3lhNzKgA1J13Y+gbu8pbPvnb0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppl+MzYecAUT7GzxbaOvmkNzRp5j3+0dutQZ84AETbc=;
 b=ApmI8YJe2cKCd9HSNWXIpdnz1oTskdnLjbB8ZLVhJs4TJLQqLwavfMTiNtGlNBNR4ZCGUHdoPqcdsD8JN1bMMGa5Eq1EEJgZUE+26YugKgPcZQeETUkc38WdFgWYGUiMhR6TrFKYLttRl54c2dfuXmhUtD0eRoZCfPWaORVZOUNoihbysO5vDSjvkDF1dZX2nWx+pwAcVosTIfqbIKC5F6ZHu1FKCZ2QFEeiI4UpdaUG0QbYIaUEQPHFwf1WLWLUW57G+vBeVqhQOHgbLrlxvge/uDYqsO+mGl0337hxr6inMVlTJSNHlC3bv7Rh/YBJFrtQe7fBficecPGUvSaH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppl+MzYecAUT7GzxbaOvmkNzRp5j3+0dutQZ84AETbc=;
 b=KUjZLHhSVfdEmEbMZ93vyF72mvTCAiKRI0J4zrI6/cPJGT0gPy/zrafXFV7UoEI8T9W6vdl+90v4a0B8ah8PtZ10MKAaV08f5x+3b+pASOkxK2VWpm6cs5zU4NNyAxmBTTtgipJNEwkvLDP6oY/6PF6YjFgN7ABLYTrlJS1Gfy8=
Authentication-Results: alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0402MB3344.eurprd04.prod.outlook.com
 (2603:10a6:803:10::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 07:21:32 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::6888:5014:6c94:6711]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::6888:5014:6c94:6711%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:21:32 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        festevam@gmail.com, shengjiu.wang@nxp.com
Subject: [PATCH 4/7] ASoC: SOF: imx8m: Fix SAI DAI driver for i.MX8M
Date:   Mon, 20 Jul 2020 10:20:43 +0300
Message-Id: <20200720072046.8152-5-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
References: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::36) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR07CA0023.eurprd07.prod.outlook.com (2603:10a6:208:ac::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 07:21:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d298062-8980-4b5f-d930-08d82c7d8731
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3344:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3344DA150ABBF456A81D70E9B87B0@VI1PR0402MB3344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ncil2TGu67XkcJ2/bwRp2Bgm2cCC3SftTbkWRyulmAX/ZbETa1AFdd3gIkJzymopvQxm6imKmGDmkhedw52NQEOtkbaMoZSt9y62tjVS/pUXSp176Gq+MILLttjUs+DtS3yMNZligcVoi6cafxhV6f1XvdT1qJBGqvEFSh4l7S3tgMlrmatMAGmoNPg2tqGya6/kjVYtZc/MnaSiuv5szIzLYU0wvnFzD6cz6EaKXh3VL4HPMonT5Ypkjw3cZVj++nkxzDe+EUToMprCm9I+l5wDLK8P68d84SZ/ghqOUU6FHI5ZWy+gkrvWUpqamRtIKXxaSiMuJH7olcs6sd2d+BUVmlwcJuetqr0qLmczQR7TlruLvWD223kzh5zZNEu1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(316002)(6512007)(66476007)(66946007)(83380400001)(4326008)(66556008)(6666004)(186003)(6486002)(2906002)(52116002)(4744005)(86362001)(8936002)(44832011)(26005)(1076003)(956004)(478600001)(8676002)(16526019)(6506007)(2616005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Q2X24uecKSJyKnxEvEb+PoKY2M5xR3GNYhmcupyp3CwDlILVQuVIbQhI84tCRzRJIiyybpwE7Apzx3r3DJ2jCvFE+PflE0jIwCE1bQIKkQ5aEDO72OjlpudqQBrX48BzfTRJF/y5JfPZelR40KvEjzjSftlCQ0jFpFukYxdhPVzZHbwVQOLMNAioFXCl+aWsZtCGRslEq5lMAXAvGFFvxENlmTJIfKCVK0kBfP1QDy7qgqtp5ymXl9aDIGmzalfl8XRKDlEdKWcAcOp84QgtllhyqmOa3i/3HUd0UgqPPnRR2xYA/+3CjIQ5rMUG/PygdT0bYkKCjXd9lbe140xyvl6LsuOuKfWzApaa5VCiZGr0kmyK2p3wHZI5KazJGsQwdxJVJ9mMsZMkeAFcQ5BDuobiICiM1/yTmlE70trvK3ruzBGWqVkuxDzeVnRTz8hDD/r/GMhNaAfmtym2Ne6J/4lJ0hELACN6QRru4VDUjLk=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d298062-8980-4b5f-d930-08d82c7d8731
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 07:21:32.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1YpaxeoogqEBikH7/sc27xHp2HPpaDYxaohWXmi8+sqKeJGpPuyjUZV4cF/XL20WrIuGOuKtf27cbfZx/4q0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This must match DAI name from topology. Also, sai-port
is too generic. Physical DAI port on i.MX8MP is labeled SAI3.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/imx/imx8m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 067d2424c682..3b9c560cd40f 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -239,7 +239,7 @@ static int imx8m_ipc_pcm_params(struct snd_sof_dev *sdev,
 
 static struct snd_soc_dai_driver imx8m_dai[] = {
 {
-	.name = "sai-port",
+	.name = "sai3",
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 32,
-- 
2.17.1

