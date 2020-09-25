Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8A278182
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgIYH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:27:37 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:57319
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYH1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3JEEU9ZMdQosdov+FNUO9LHKpIuprSvecSIsJyyDWD9/s3ViYk1DlnUA/8RzFGKj41qlfyC1ugOIJAgQe40b52q0Q5T/56fnLmcNxFvvO4NDHHEnaxqhy8N1RCIxqx1XGYjF6WfHLyXypRXKC3b7soOIqpEa6okHND2x0/aFjRCDtqRYtFjCshI1jcTWhtVpTN+pQ7rAszUfeJd5XOV1t+oIk0s3mQCBgvP19pVd0yK6UY3ozEHRUf2u6LXTqA3KKMqiDxWsM8zh3i/fFLadNPDTTuMN8chuxTcCKcpN6RcrTiA8x3AOo4e7XeWucboWN3/KVE8AHvbcWo61XJ1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F75y2TRhGzl5D5fg54N9IW7IrIABRgsWRlVIIDC5EJI=;
 b=D8uV2IW1fOpznaB9Ols0VAUOGilROR/n6v4EbxXrNmhr/2u0WrzT88c35zqBuhrS+P9Y+Px4LSQvDWzvog60r8ZlEb4VD3o+6iF4IU0MsDZjM+bIiEy0WcDBYkF5LWk8jU7yk2N767AG+7nexMX4MsB/wjdqLWFIxdExn5B/jGoiD2xPp+mmCeZYi+PmPWPx4Nsg92UwC9DvXxankt4WfUs/M9lyp3zPZ/RTdguNAvX6bFyFkHYG4XkwrlQ+a4TaS5chHdPEZCnI2rb4P2vitIL7hoGZnRH6E9MUDhhC13Td7ummhzD1MQPcy1ctNRQzZP6WCQ0QRKIXycCIjDU0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F75y2TRhGzl5D5fg54N9IW7IrIABRgsWRlVIIDC5EJI=;
 b=J5xV1r7zMopEqwzbt09IA/pbZd3Fs/CIC8QZlxrEmGWL6SolvmFyC2NHekrYFCsgkFlWitltu2PiRPmYVqnzg9A438/pNx7g6v5JNrp+WEFdoDpLrx89/aFhavf+bhybi9UIZqH7hEJBtj2pzu9qcU4FVI9oC8FIoeoPMUcDyXQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5216.eurprd04.prod.outlook.com (2603:10a6:803:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 07:27:31 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:27:31 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 1/5] misc: vop: change the way of allocating vring for noncoherent platform
Date:   Fri, 25 Sep 2020 15:26:26 +0800
Message-Id: <20200925072630.8157-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925072630.8157-1-sherry.sun@nxp.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Fri, 25 Sep 2020 07:27:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59a67649-6a75-4319-0537-08d861247651
X-MS-TrafficTypeDiagnostic: VI1PR04MB5216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5216A25ED306856CA4513A3C92360@VI1PR04MB5216.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WO4BR+gHIG5/pe+Y1GV+7SOfOOL4R36OJGbBEoyHP4tK+qYss1zhSpgthGiS0oOUBVP1gqfR4cR9S/yeSK3miWvMm5UeWnDv0JUFITDp+jfaUOzfotzEzXWMWojTcQHLD55zSdL2d4sZLVF+wWwf4Bcz3CnXSHRuWumGCBsc3W6qCzsNfQWhBTsel2EuRpx1zl0kdpi02LouPrL6JT56kvnVdZlkXGS1F4LpbGNPs9dSYUcGNljYyGtIQNKIOZowPJr8jx4CoLf3P42Af9UGCU0ut+XsE5p4+pjkcDR0Rbjo6IWaJsx6GakX3WheKpHb+VlZUchVL43jR0ZeBIEoUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(2616005)(66476007)(5660300002)(6512007)(66556008)(8676002)(7416002)(44832011)(83380400001)(4326008)(66946007)(8936002)(36756003)(86362001)(16526019)(956004)(316002)(6506007)(478600001)(52116002)(1076003)(26005)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4AZ2qe25Pf8YHS3Y4dkD7G5umd7F2Urihrg7jPmMPftzuQWJ00dVpC/jsB2SLS6irIbVELLsZe8stSAoJIv23pEfVTNDYbyrW2k9aevYLCrzLH8aPSdZ6anzumV4edUbUGMLcozHlje9sLsRsRYshezrEEMpcoY+oxXQu5HjJeSYGVEvUkaxo6JEHQrKkp5Rh6UmnAxUbo5rVfG8CEfiQ53xnRkoXv/klSy1hRvZbqS1q10KGEQ5nmCIROri9tBIIn9vW+qpaiGtPJqwOjhngEbud4l6w5xGQLhoSbFtHbrwczDiSRvvIO5X0L7NWbz2C/wwAWDv4PxDy1xzaznPY/MaTkFYmtHJDi86VkM6lLRf4TTt++FDEEwgPOW40c9EIAzjHGMKgma1inJoFn6ViGE+2dis1MZ6O/nAtvmyvuq5jFyvkHRJ/W6R/7Rvn1bbOGr2OQRU4nGntMFjPbSnr959wCNicOPF+KXzWejYQlIybnzvt2gKtuoiWwkpZq3rtlnE1h9LeCKXeJXHyWIhTXy3/2GRCjOsAqhyskY1b/gys0bp/k//s5Iuv1+BxqGgTIMV9Iasiryw+ltXeMAF+ip7x+haBqnYBhM4pQ5FpNBeOOEsGjapa5jXr9e6Hf8hiAnx5yZAE7tc+Q75TQNtGw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a67649-6a75-4319-0537-08d861247651
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:27:30.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZBhlsMMQwz3TIb/9MhhEYlNn3znhXc5c1+PlHVqQQYuhq53z5fYyCWL/uM0alg2Q4JqN43qHo0Thu9dYz5Vtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For noncoherent platform, we should allocate vring through
dma_alloc_coherent api to ensure timely synchronization of vring.
The orginal way which used __get_free_pages and dma_map_single only
apply to coherent platforms.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 101 ++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 34 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index f344209ac386..fc8d8ff9ded3 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/poll.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 
 #include <linux/mic_common.h>
 #include "../common/mic_dev.h"
@@ -67,11 +68,12 @@ static void vop_virtio_init_post(struct vop_vdev *vdev)
 			dev_warn(vop_dev(vdev), "used_address zero??\n");
 			continue;
 		}
-		vdev->vvr[i].vrh.vring.used =
-			(void __force *)vpdev->hw_ops->remap(
-			vpdev,
-			le64_to_cpu(vqconfig[i].used_address),
-			used_size);
+		if (dev_is_dma_coherent(vop_dev(vdev)))
+			vdev->vvr[i].vrh.vring.used =
+				(void __force *)vpdev->hw_ops->remap(
+				vpdev,
+				le64_to_cpu(vqconfig[i].used_address),
+				used_size);
 	}
 
 	vdev->dc->used_address_updated = 0;
@@ -298,9 +300,14 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		mutex_init(&vvr->vr_mutex);
 		vr_size = PAGE_ALIGN(round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4) +
 			sizeof(struct _mic_vring_info));
-		vr->va = (void *)
-			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					 get_order(vr_size));
+
+		if (!dev_is_dma_coherent(vop_dev(vdev)))
+			vr->va = dma_alloc_coherent(vop_dev(vdev), vr_size,
+						    &vr_addr, GFP_KERNEL);
+		else
+			vr->va = (void *)
+				__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						 get_order(vr_size));
 		if (!vr->va) {
 			ret = -ENOMEM;
 			dev_err(vop_dev(vdev), "%s %d err %d\n",
@@ -310,14 +317,17 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		vr->len = vr_size;
 		vr->info = vr->va + round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4);
 		vr->info->magic = cpu_to_le32(MIC_MAGIC + vdev->virtio_id + i);
-		vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
-					 DMA_BIDIRECTIONAL);
-		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
-			free_pages((unsigned long)vr->va, get_order(vr_size));
-			ret = -ENOMEM;
-			dev_err(vop_dev(vdev), "%s %d err %d\n",
-				__func__, __LINE__, ret);
-			goto err;
+
+		if (dev_is_dma_coherent(vop_dev(vdev))) {
+			vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
+						 DMA_BIDIRECTIONAL);
+			if (dma_mapping_error(&vpdev->dev, vr_addr)) {
+				free_pages((unsigned long)vr->va, get_order(vr_size));
+				ret = -ENOMEM;
+				dev_err(vop_dev(vdev), "%s %d err %d\n",
+						__func__, __LINE__, ret);
+				goto err;
+			}
 		}
 		vqconfig[i].address = cpu_to_le64(vr_addr);
 
@@ -339,11 +349,17 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		dev_dbg(&vpdev->dev,
 			"%s %d index %d va %p info %p vr_size 0x%x\n",
 			__func__, __LINE__, i, vr->va, vr->info, vr_size);
-		vvr->buf = (void *)__get_free_pages(GFP_KERNEL,
-					get_order(VOP_INT_DMA_BUF_SIZE));
-		vvr->buf_da = dma_map_single(&vpdev->dev,
-					  vvr->buf, VOP_INT_DMA_BUF_SIZE,
-					  DMA_BIDIRECTIONAL);
+
+		if (!dev_is_dma_coherent(vop_dev(vdev)))
+			vvr->buf = dma_alloc_coherent(vop_dev(vdev), VOP_INT_DMA_BUF_SIZE,
+						      &vvr->buf_da, GFP_KERNEL);
+		else {
+			vvr->buf = (void *)__get_free_pages(GFP_KERNEL,
+							    get_order(VOP_INT_DMA_BUF_SIZE));
+			vvr->buf_da = dma_map_single(&vpdev->dev,
+						     vvr->buf, VOP_INT_DMA_BUF_SIZE,
+						     DMA_BIDIRECTIONAL);
+		}
 	}
 
 	snprintf(irqname, sizeof(irqname), "vop%dvirtio%d", vpdev->index,
@@ -382,10 +398,15 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 	for (j = 0; j < i; j++) {
 		struct vop_vringh *vvr = &vdev->vvr[j];
 
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[j].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+		if (!dev_is_dma_coherent(vop_dev(vdev)))
+			dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr->vring.va,
+					  le64_to_cpu(vqconfig[j].address));
+		else {
+			dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[j].address),
+					 vvr->vring.len, DMA_BIDIRECTIONAL);
+			free_pages((unsigned long)vvr->vring.va,
+				   get_order(vvr->vring.len));
+		}
 	}
 	return ret;
 }
@@ -433,17 +454,29 @@ static void vop_virtio_del_device(struct vop_vdev *vdev)
 	for (i = 0; i < vdev->dd->num_vq; i++) {
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
-		dma_unmap_single(&vpdev->dev,
-				 vvr->buf_da, VOP_INT_DMA_BUF_SIZE,
-				 DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->buf,
-			   get_order(VOP_INT_DMA_BUF_SIZE));
+		if (!dev_is_dma_coherent(vop_dev(vdev)))
+			dma_free_coherent(vop_dev(vdev), VOP_INT_DMA_BUF_SIZE,
+					  vvr->buf, vvr->buf_da);
+		else {
+			dma_unmap_single(&vpdev->dev,
+					 vvr->buf_da, VOP_INT_DMA_BUF_SIZE,
+					 DMA_BIDIRECTIONAL);
+			free_pages((unsigned long)vvr->buf,
+				   get_order(VOP_INT_DMA_BUF_SIZE));
+		}
+
 		vringh_kiov_cleanup(&vvr->riov);
 		vringh_kiov_cleanup(&vvr->wiov);
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[i].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+
+		if (!dev_is_dma_coherent(vop_dev(vdev)))
+			dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr->vring.va,
+					  le64_to_cpu(vqconfig[i].address));
+		else {
+			dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[i].address),
+					 vvr->vring.len, DMA_BIDIRECTIONAL);
+			free_pages((unsigned long)vvr->vring.va,
+				   get_order(vvr->vring.len));
+		}
 	}
 	/*
 	 * Order the type update with previous stores. This write barrier
-- 
2.17.1

