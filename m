Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83550278184
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgIYH1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:27:42 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:51943
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYH1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:27:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdQSCDyxV64gVMnm6dSRPkBbWlvibNOYt5UUt4xkOvAvgBl2xuE+xE+cD0xuwAyDyiVqJdBZnsh0KbOph/xYpgnJ7JGcwasUjEJAGZq9czk2lNksAqQTrTGSWvm9VFMLn5NP8eh4SXs8ooprCCwa6Zp6xol9wRkExpcpV3XLAYSw9bWb4gcESM48M+JDSayHn3FEPqWx83dItAE/+x/V+2doj6wptgntCk2T7S7lozIH9NJJl9UY6yCsoVckw3OSVrbL43Q2FJuUENhoP4XjYIT3ugPngGR37aXmS/wuJepSkiWAbi+2Vj0vuI0n/qq4rWgJBP+fElw0+ilMvi71wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jyPNd+A5iCYdpWwN3BsjMfcQUF2jKwdbtMuwDVAP8s=;
 b=c61TDS46hOLPUQmboDpdU1b2ya6UBgNwPMKGKSnvCbOuWVcs/bVINi6RbeZbtje5i6aKDhmjkZxtkSrzUn6Z4K9IKgFofeQsd1KrPywfVwCRM2MXPzCi34jpeWPQxmmXQJl7Z5Wd/t9Y9hoMd/gtu6M0eSkV2YVhnQhtefYH0yTPAN7nBQ77n+067kncGgAtFTE8LQ0BRJTZ+g+wlu9yVKaR+p59XWFXOLweOzSQe9eG78VklHaHUL7xEXAjhK4tPec3xrKotBVxoc45w65OAlVnGrFY97WwMFeionOAnvKgKcoVOO+BtTTj3TFnBHjwYFkkUN5a/kW9kPjbigrr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jyPNd+A5iCYdpWwN3BsjMfcQUF2jKwdbtMuwDVAP8s=;
 b=WTGkxrnyhBPDy+dLmrsK6irKTP6qbdzdArTomEoO91IgFvMPBGKP9Mxqqf7RXiFukiSc5lvfB9xOILKtVt7FHATiARlcjcozHtfhcYNG+KS5heURqGUYS3zVM6f4rKHJjF+9PtYvY17c98zwSm8diQjbF2sv9mpRl45VVP4KdAI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5216.eurprd04.prod.outlook.com (2603:10a6:803:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 07:27:36 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:27:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 2/5] misc: vop: change the way of allocating used ring
Date:   Fri, 25 Sep 2020 15:26:27 +0800
Message-Id: <20200925072630.8157-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925072630.8157-1-sherry.sun@nxp.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Fri, 25 Sep 2020 07:27:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d57460aa-0800-4a39-67a0-08d8612479c1
X-MS-TrafficTypeDiagnostic: VI1PR04MB5216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB521620A0B7D339AA0F657FAD92360@VI1PR04MB5216.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRGxStAjp4nno0srLspBqKDTLZCmbR0n0RFb9tjQpqhm+UDZhv3iuf+kRaXTlOgYC6q8I3cF4AChxlkyArzZEdGjjka5/rvpnul/I0ss5NbbXaJJYxKU5XwSNgSdJoIdmm6zMFLTiClyMpZ7/n5nquIARBNYvEjoxjh6xBkaMnwnWiPgtLP8nEcLrrDj5E4UgTb56tcRfLvWwno8icvplqbQEddNhVNAtUCVmiXKQfWIKdHo+ALTFlvKBdLfyCQlbx2uCDllEYWcgR/+5Z1d7F3S4i4Ge8ynuC/W+TKyY1dRMttsE3oByUvtP2N2dyE2r6dtSzp01YIhQfa7HafCvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(2616005)(66476007)(5660300002)(6512007)(66556008)(8676002)(7416002)(44832011)(83380400001)(4326008)(66946007)(8936002)(36756003)(6666004)(86362001)(16526019)(956004)(316002)(6506007)(478600001)(52116002)(1076003)(26005)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2E/h5O8gtmzMbN7prPHCA01RSRPvQzyaKiqVXh/Zy42yE/wZQsG9Q++AT2bH2CwwylnpSwTdJSlHhpOQuyi7h16N4DJufmf6xy/wo4vfi9dlFKDh4XRSjqboKv9xLAbcyXfb0luGWlbz0Zbre7D9KPPGe8t4vTQVls9XX/IOhRfTtXWv9VJYpXen8QNnx+rQtXY7nOisbx8ZzrLZJjUsazqvARMrOk71CeQB8/MM6zsfrWIy1AV7mE6/JWzpYXRZxFpBBSNDtYjqCOe3/M5mR6A9o7Kz5Stowq25quL2xkCm/RDyGfO/VA5NazJPKkaaV6RKx7RQJ5E6UblbFCLIN96f7v8xcvRBqSV4AZf/uA9MGv8HAILnSW95/pqyWDduZLC1aScvtOV9ap9eoh1CkjgD2qtdNOXsTGzcjjyfrAuGSpYkD3dZvczhLYC8hknFensvplOa6OL5ZadC8CG5Dig7jJRf58Yg52AfdnxCIcu9DrkChNUXF8yVShIksRUfHKeIDA3eJkWhl7ObLHzJgZtmS9wjTrNS/9PYFF+YEQIa7vcc3/41bTToQuwafqTFEGo2GZRpqsGPyNRRr456d8j5upjME9dU+jctEPts3GsWtK765Rv9b5Y6fTVVMkQt2emM9UEALv5S3Wgarjnc4Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57460aa-0800-4a39-67a0-08d8612479c1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:27:36.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlywtOCcz7Tdv+M9Fc6AhHxxJ2qyg0MfMBmWnLbne7kURqrr1MxOr3JvSW8YECGmMLXm0EXGEfq22ssHFFSQJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For noncoherent platform, we shouldn't allocate and reassign the used
ring. Since RC has allocated the entire vring, including the used ring.
simply add the corresponding offset can get the used ring address.

If follow the orginal way to reassign the used ring, will encounter a
problem. When host finished with descriptor, it will update the used
ring with putused_kern function, if reassign used ring at EP side, used
ring will be io device memory for RC, use memcpy in putused_kern will
cause kernel panic.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/vop/vop_main.c | 48 ++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 6722c726b259..d3645122c983 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "vop_main.h"
@@ -249,10 +250,13 @@ static void vop_del_vq(struct virtqueue *vq, int n)
 	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
 	struct vop_device *vpdev = vdev->vpdev;
 
-	dma_unmap_single(&vpdev->dev, vdev->used[n],
-			 vdev->used_size[n], DMA_BIDIRECTIONAL);
-	free_pages((unsigned long)vdev->used_virt[n],
-		   get_order(vdev->used_size[n]));
+	if (dev_is_dma_coherent(_vop_dev(vdev))) {
+		dma_unmap_single(&vpdev->dev, vdev->used[n],
+				 vdev->used_size[n], DMA_BIDIRECTIONAL);
+		free_pages((unsigned long)vdev->used_virt[n],
+			   get_order(vdev->used_size[n]));
+	}
+
 	vring_del_virtqueue(vq);
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
 	vdev->vr[n] = NULL;
@@ -339,8 +343,13 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
 					     sizeof(struct vring_used_elem) *
 					     le16_to_cpu(config.num));
-	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(vdev->used_size[index]));
+	if (!dev_is_dma_coherent(_vop_dev(vdev)))
+		used = va + PAGE_ALIGN(sizeof(struct vring_desc) * le16_to_cpu(config.num) +
+				       sizeof(__u16) * (3 + le16_to_cpu(config.num)));
+	else
+		used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						get_order(vdev->used_size[index]));
+
 	vdev->used_virt[index] = used;
 	if (!used) {
 		err = -ENOMEM;
@@ -357,14 +366,20 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 		goto free_used;
 	}
 
-	vdev->used[index] = dma_map_single(&vpdev->dev, used,
-					    vdev->used_size[index],
-					    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(&vpdev->dev, vdev->used[index])) {
-		err = -ENOMEM;
-		dev_err(_vop_dev(vdev), "%s %d err %d\n",
-			__func__, __LINE__, err);
-		goto del_vq;
+	if (!dev_is_dma_coherent(_vop_dev(vdev)))
+		vdev->used[index] = config.address +
+				    PAGE_ALIGN(sizeof(struct vring_desc) * le16_to_cpu(config.num) +
+				    sizeof(__u16) * (3 + le16_to_cpu(config.num)));
+	else {
+		vdev->used[index] = dma_map_single(&vpdev->dev, used,
+						   vdev->used_size[index],
+						   DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(&vpdev->dev, vdev->used[index])) {
+			err = -ENOMEM;
+			dev_err(_vop_dev(vdev), "%s %d err %d\n",
+				__func__, __LINE__, err);
+			goto del_vq;
+		}
 	}
 	writeq(vdev->used[index], &vqconfig->used_address);
 
@@ -373,8 +388,9 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 del_vq:
 	vring_del_virtqueue(vq);
 free_used:
-	free_pages((unsigned long)used,
-		   get_order(vdev->used_size[index]));
+	if (dev_is_dma_coherent(_vop_dev(vdev)))
+		free_pages((unsigned long)used,
+			   get_order(vdev->used_size[index]));
 unmap:
 	vpdev->hw_ops->unmap(vpdev, vdev->vr[index]);
 	return ERR_PTR(err);
-- 
2.17.1

