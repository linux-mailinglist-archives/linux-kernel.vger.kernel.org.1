Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAD27816A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgIYHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:22:21 -0400
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:51120
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbgIYHWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:22:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIcRVsZ1Y6W/XoOcHEjYiYa3lSVUCfVm44GduFdSOMEyjhctqMN38g11K/2XSk2jI6NiXuZbsGnnyGdVbX8YCx0SDSXjlxmZnVn1w/oMnrOq19iVpBNArvLTWII3g7HNvPMw1n4yVOGMsMXORdwq/O6UI9Gdtng1OVbasnje9KRB3J+P8Cb96iWS8ZNQL4iaNm8B0YZ/+sYlw22TpT5Q6hXKEbqiqGWDpgV0VyU3KW8tZIeIZWeQKKXWMXW0tJUyamhR9dI7SkKpNy1onQUxVcpwfPKa+YjAN8LbOPQOLYrXH/djixUAcG90vEHc+MA3K9NZ8nolzxMmj1cH4xww3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEAOnhorO7cZq6Y2e5sW2GvJHB0eVIZr4iwORnB9DNI=;
 b=Gf9TxX2EnqHZfpIl+Gh5eMoPbw3uexaYy1/lyHE7yIWsUXeLk/aQpGBadSYqC/WXD7ZaxNzS55YfsSVSBGID+ee0Evjs+GrzMtkQTzJJBsKFHXoXfqCpWwV4FgYDm2uSd2HfIyFX9sT3GUHT9IlWjlz5IjP6rRbJLa0t2dO1b6K4+Jzua26sipwSjMEsHGHOV4BMYE59Xt6+PX50usKcaA0O9j+RdweVpQENtAb313qeePC4DgyGsvmlO2MwE4aHOecljE6yMbfKuVQ4ZWTIZOBvE83YQ4TqScUtMEXp+qQnhLWHaHElFfJxxbKcgQu9ipXOJBkz6Xo2naFbJ2MJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEAOnhorO7cZq6Y2e5sW2GvJHB0eVIZr4iwORnB9DNI=;
 b=ZerRF1UIvXC6kRLQnSAzhyEKcxWMiqpS1rfM4vkCdJ7o/SM0+VRuDpxVC9LgI9FE3h7ovdk0OKZnBQndjleDjTTcdYHpbm62YOs0KfnfpKoFGHKA3S3ivH01nFM9yEt/XFZP2jvhNyE6ChDrZuj309cYMLIu0JzYEZ40oV91zms=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4320.eurprd04.prod.outlook.com (2603:10a6:803:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 07:22:17 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:22:17 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 4/4] mic: vop: copy data to kernel space then write to io memory
Date:   Fri, 25 Sep 2020 15:18:31 +0800
Message-Id: <20200925071831.8025-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925071831.8025-1-sherry.sun@nxp.com>
References: <20200925071831.8025-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0118.eurprd07.prod.outlook.com
 (2603:10a6:207:7::28) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM3PR07CA0118.eurprd07.prod.outlook.com (2603:10a6:207:7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Fri, 25 Sep 2020 07:22:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dda46b5b-853f-4fe4-b57f-08d86123bb1f
X-MS-TrafficTypeDiagnostic: VI1PR04MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4320A51F7764B42FA528B61C92360@VI1PR04MB4320.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIfoixOBLgc954L2OixUIPJUeFhXnRF+5GFtPLuYDYtt8VZXO9GwNa47nWUkNeZFj1z0T8W4TldhQLTdW/l4EQodQhuRUECIChn/JJfgdiVwYXT/5w6Snqsjk6g0tnmcwh9/dGXQoaFcSiG5nuCnJOgYmP4DHVmeJeuF7ugXRQvKa0G7w0Ag7KE5hz4j8iC4W5SHQdj2ffYF8/JZiUL3lLYTfarcR032IjTnTadkSS3f+l3h3IzKI80v8L904wQBfdrZNcVGXDnU7hL8oPyD6NsXXtPIynCupQk+wt61lTdP6YR5tIskUwlZc15S4we7mlk2DV4wVtxWsaX0l4H2uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(16526019)(52116002)(6486002)(6506007)(26005)(83380400001)(86362001)(478600001)(316002)(186003)(2616005)(5660300002)(956004)(2906002)(66946007)(66476007)(1076003)(66556008)(8936002)(6512007)(4326008)(36756003)(6666004)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: e9qM9WocecpbzqcY9xly/oA+GfY2+nhM6GrCM04z3b+xQcwlWYV/VVccQfw9IJOA42FxPvPwUytQIqR1PDXwxLN99zUZTyFyyP9zGIoCJ9a/IFv2Y+BTemSRRnwrPZvY4ANsweUDzAMRzVhT2xfHIffpy9YJ4hNedNE7bG1dceBfaDynWRUWewl6rETtK8bJp+5hHiqpFTUQFUDq3JV/1WGml4zs09m/HZXJ9BhbiekutXaIV78pB3ISvNt1kCsA0Qf2T0E84jFWZZf1IJvi6qZqQ8JvsYOa3cUKv6P4EQrCV0tyEmICmAxMhQFjOrijghY8TnerVJl7yQe9cL61XqtUUl5CkZqPHXKQltWQwsFsqNn+6xX4fc01dWeOtvAAWDYh3rzZurI7PgsqcqFCjvOFQzJfiyVkYsL16EGh0jeryat/kkqJRDAuJUgN4qhYgmLgxmBjg1363NDXso0bd4FFk6e8igvEyHzSpDSF/0wSeZOHiSDrSvPyYyhNN7AC3eBe1SyZnJH+PCWGqa7wWYesienlkgXfQLLcH+FBiCMcIm8trxtnrgMenwyZ1IR3QAr6Dj37QVBpJk5eE0e3Cg7Z/f2Exm1FKygpd9mFyahhJ8cP2r/Gy1N3UScH6w1m54eFeFYZ37vcXQJeDcNZJg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda46b5b-853f-4fe4-b57f-08d86123bb1f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:22:16.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHg6gP28ohVsfMMehNiOzzeV5tlBjCCTndvFOalVHg5NiYu/NLcU442VAvgrSsg7MuvcJOtywa1pSRht80xmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read and write io memory should address align on ARCH ARM. Change to use
memcpy_toio to avoid kernel panic caused by the address un-align issue.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 45fdb394de11..f344209ac386 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -602,6 +602,7 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 	size_t partlen;
 	bool dma = VOP_USE_DMA && vi->dma_ch;
 	int err = 0;
+	void *temp = NULL;
 
 	if (dma) {
 		dma_alignment = 1 << vi->dma_ch->device->copy_align;
@@ -655,12 +656,15 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 	 * We are copying to IO below and should ideally use something
 	 * like copy_from_user_toio(..) if it existed.
 	 */
-	if (copy_from_user((void __force *)dbuf, ubuf, len)) {
+	temp = kmalloc(len, GFP_KERNEL);
+	if (copy_from_user(temp, ubuf, len)) {
 		err = -EFAULT;
 		dev_err(vop_dev(vdev), "%s %d err %d\n",
 			__func__, __LINE__, err);
 		goto err;
 	}
+	memcpy_toio((void __force *)dbuf, temp, len);
+	kfree(temp);
 	vdev->out_bytes += len;
 	err = 0;
 err:
-- 
2.17.1

