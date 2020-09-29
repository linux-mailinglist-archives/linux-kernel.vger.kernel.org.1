Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8027C09C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgI2JMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:12:41 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:42306
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727879AbgI2JMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ/4843/ltmSf6MfwhkxIgJtcs95NIW4vh7JwH0QAIY7g879C4MwShLqjqC4r1dCBAufHMwHE8OjqLd5zb83nh0COUZc2kL4UsMp8lRbIXJ0WMv6UXyuM4mnsDfXsjiCoxuJvabCDPnU+GPOb4vazP3m/cvGxFt1k74KRQwQqTUeym+PY3Ncp4qZ5pe1KV0TqUK8kR7Py9YPUAgxUqTup9+oOyuzZI2y0oXDv+JyEzgxpNin8LWZH0TZIZ8xNevgutjVuwLlbK0cL/rB38DK33XsNJnQqJvXIrnKUD+F+3RjWesjLnKbPzD+K3aTTpMAG9p6y4OasgdhqHzYF2nhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEAr8H/39w4MsHa/60f6W1cBWRmjJuHGV0CM/qi50k4=;
 b=cmIbh1ycnJXIANVxjzf8WkmfLRNV+aYKLcbnZW6YMRGGoiFMuwtE41paUTqrB5omLJ84a7VqpMpH90bn71SXe5ML0dljczPRVLml17uso3bnSIRCuheSczwhV+4RS6DdWVQySgCXOJELXQtPKzVTVVu8YXp564P+i4V+IGTvqzLvWFXUhI6az7k+xR3GYJCXqVtEsXSlHdOK2Ms2LYkVDayS5Ahgu5DwBNpMwJc62Ls/EX2iOVlgWyn4ktXQwVViuudn2w92ZTu3+EyIg2TpG54/uhYoAWNIxs1iuUE/jmgweCyUD9gTs2b/REL0Vrddw/OQtYyLTtdNNQ/tACWR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEAr8H/39w4MsHa/60f6W1cBWRmjJuHGV0CM/qi50k4=;
 b=T6sZ11mTDmfsjnRr25bYowVXs4h+hw9xWgMNqn6TdQeqpU1mV+riPr3U/jkpJMTXEwOa3pQyD0H8Q3enSa1sYgGEZBO/oaotq7deWhVHevmcLESIUkDnCmNlvc4YBNqWlHmXMKAc7Lkdp1qP8eYwEz5zQag9FTHstwgQOEkGsC4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 09:12:35 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 09:12:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 4/4] mic: vop: copy data to kernel space then write to io memory
Date:   Tue, 29 Sep 2020 17:11:06 +0800
Message-Id: <20200929091106.24624-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929091106.24624-1-sherry.sun@nxp.com>
References: <20200929091106.24624-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 09:12:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7df28d9c-1e68-4b9e-3b80-08d86457cdad
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB47513CEF50D529ED9159C94392320@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej6ZB0WDG2Zz+PQf2Z5caEPUt8rSjfEfI2ewnvPH5clq3aYmspkVwDRLoNBzHfhPawX7cokP+UFZYaAGL0gwy0F+TXshIupDR0e+MyhSLYk/z9PZMnlT4UJwA0ywWOJJg77Oi1W5Kag5bPGHvRjsOHq6g2IRxRptnCqVXQUG/xslW8KPRckvguQ9kJn0Z756FqBtXCG7TVwUImbJPt/AvlO7mBJooRS3QUPsFvyrIXK1JaukyA2Vn7WG9hilMhG00XhAONu42xog04P9a4cde3xsI+FnJUNO7kffUsgKdFUasSkd0nbIilT6D4cYeQ2wd9DawpKPIn3LO1Ynfy7/sCWOXpw4OkDVRMjrn5eo9Fz08Uf3344Vlm1v1OaWBiCu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(44832011)(1076003)(26005)(2616005)(16526019)(186003)(4326008)(5660300002)(956004)(6666004)(478600001)(316002)(2906002)(66556008)(66476007)(66946007)(83380400001)(6486002)(36756003)(8676002)(8936002)(86362001)(6506007)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zEiIHbvxpRlXy7kJLOl0ruumYMEtTzghgc/yNpYeyCLS5uJlMzYxh30ckq6djdSYJ87M1t3aStKMOAHv8Kc5knU4MwupiqulHloMMmqye+Dav1NijKo8gS/0M/g1e/9gX0XphzqQqQ79U8CO+6PbS6oD1C5q3zXUxgzhuOHhgvpJXkW3JhJ/12bOKUv9dQ/o1cR11DSC746JHNl/SO7rXOTksYIlOHjP+dwotzlBeG5WzUyrZy9DuWZvDKi4htcwaG8ItnAPqXLrH0oYvGvPktkwfmh5XyFqKFGZWGuk8pxmKghBMfjQxQlhf4IPEf2pxc+ypbB8eGMKg+DT8/DJa6ai/kImjWQrkHqEkCS4yEeU1qFB/9FVriHmMITM/uEdP6h4tsJF888fCt8UWXdl/hRG06AOBVbD6WC6CYIfCTyFfxc3VINp1wXWp8/fGXIaXeIym6H4wbFfEcWpqDBQVzcDU+BHSxgzLUugd5ZoEqzTTsUmvbOUQ5MnvAbcCnd/Z9Sx1CG8UBFVROnbVMan+NLX/TtO1kuVNdDYI7Dti/vuZMHhxhCySOoQsaUC+cWTpG3bRaQEBBwA1xx2G0YDR8O3QcBRKP60xnW40AXRIh5YT9LW20Nz79LAQWCFRHoceMECGaFSYM/8648FFaRGzw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df28d9c-1e68-4b9e-3b80-08d86457cdad
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 09:12:35.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLynfwPIVc2qSYIcReZ1Lvj0um4HGJJtWOEUlhwutH1p06EKQzVJEmh/2Yc6FkALrNOGZVCM2jRjnzXScP+XWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read and write io memory should address align on ARCH ARM. Change to use
memcpy_toio to avoid kernel panic caused by the address un-align issue.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 45fdb394de11..7014ffe88632 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -602,6 +602,7 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 	size_t partlen;
 	bool dma = VOP_USE_DMA && vi->dma_ch;
 	int err = 0;
+	size_t offset = 0;
 
 	if (dma) {
 		dma_alignment = 1 << vi->dma_ch->device->copy_align;
@@ -655,13 +656,20 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 	 * We are copying to IO below and should ideally use something
 	 * like copy_from_user_toio(..) if it existed.
 	 */
-	if (copy_from_user((void __force *)dbuf, ubuf, len)) {
-		err = -EFAULT;
-		dev_err(vop_dev(vdev), "%s %d err %d\n",
-			__func__, __LINE__, err);
-		goto err;
+	while (len) {
+		partlen = min_t(size_t, len, VOP_INT_DMA_BUF_SIZE);
+
+		if (copy_from_user(vvr->buf, ubuf + offset, partlen)) {
+			err = -EFAULT;
+			dev_err(vop_dev(vdev), "%s %d err %d\n",
+				__func__, __LINE__, err);
+			goto err;
+		}
+		memcpy_toio(dbuf + offset, vvr->buf, partlen);
+		offset += partlen;
+		vdev->out_bytes += partlen;
+		len -= partlen;
 	}
-	vdev->out_bytes += len;
 	err = 0;
 err:
 	vpdev->hw_ops->unmap(vpdev, dbuf);
-- 
2.17.1

