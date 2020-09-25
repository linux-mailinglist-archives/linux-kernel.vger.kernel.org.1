Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63188278185
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgIYH1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:27:48 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:49538
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYH1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:27:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBnDsaPAzp6COaZmeoc33tMEr/wZfnm7aUyQu3bMtB6A7aLCflfxW+A9kmE/GGxh0BYKizzgX/uzmsrGq78/ee34lMyeGh0jJndfgU17Icj8SFNR1GNpJ79TrKrXIRiFiwgbGezueelli+uDwoTw2xwjGH7fHkoQj+tocXKCcmp1V72h9tXgqtlY31cJWTcdXU82WTQTik6OPSh0pXyakmHDSbN4wO4YRKISv2WYknNbTu5nVYC0ZgQZ+CubnLqRYXCwIcMwptRNF6167XxExy3Y3LdgCDEM+o2XAwJGI6Bab/NRaXxwLmJBlXiIeuscJiK+cqfryQkVQQcH+NOx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTIBHq3HZDOsyQdukFI/QfMqbfgX46gMlchmeKLN/8A=;
 b=gx64on2b0AaGQqu0QPOFsesfwYRJEeF3T7N0NzsKan93KnZGRLpA57IFv3N5r944xk8kitM/IY1JRmqnE1Bfoq3QhTszFAY3NB1FWxWYjFYRkNNiQIh68YUGElE3Q8JPTOKv92Ocv3aM9zhPurEKNY2peltF/n77w1e/MbiaZDGHKBkvp8KArhGrys8FYEx9wAioVFdmCH8TQ1yRom2TnE4J8E/SsaOqcznYNCrJFPx7lNyQAyJ6oWj1BD9H9+cNiqlj7E6vFpuzEHM90QKN4QWsbrjlzRI0ibjP+6xoo8f31AD9GOWRob5hB+TQAxNWF4MB33dPEAvNOeoS5dEE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTIBHq3HZDOsyQdukFI/QfMqbfgX46gMlchmeKLN/8A=;
 b=bMIJfGqDazPA3FYf2Eoqbu1G4/BcOKg7St6979JwKNF7rWUMpOqEBTkE/YQWik50av1nwr4BsWppIdLZHIkLaWPpQrbGZtPaGPBDI8HRbfPVpvmdIqO/bRB2y4FcGqXIGgODEvC6/cx4L2h6Ydbpo357qLC93L1Zla/3I+V2CPw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5216.eurprd04.prod.outlook.com (2603:10a6:803:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 07:27:42 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:27:42 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 3/5] misc: vop: simply return the saved dma address instead of virt_to_phys
Date:   Fri, 25 Sep 2020 15:26:28 +0800
Message-Id: <20200925072630.8157-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925072630.8157-1-sherry.sun@nxp.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Fri, 25 Sep 2020 07:27:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1af32e16-91c7-4a6c-4778-08d861247d37
X-MS-TrafficTypeDiagnostic: VI1PR04MB5216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5216DD7A6F1ED16B8838FE8092360@VI1PR04MB5216.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4gljMOGRkMhrTaknX/Ezj6+s3vUwwryyuRJ5iNLnAR1ShwiaIeSj2Uimsb8so0Squ3KEVt4vPsWy84qC3/pV1krHBBGCbOYZ0yonTt42vZEaixe8tXkw34j4fmC/MH84Us05X3Zt2YeZtmb3gXkUQcsI4jvOL16mqmtG7XMIvb/cVcGL5e/p2FSCDHbt5hxThKyj1tcZyZDcqHY5N6pRKLp+ayuf/JWYhlkhv3ONwTGeSuO1yequyeUvHLpPZm2w9nzgO6vtnpehEO76ynbNVis7xB0Mo4PfpLXUPNaVJytLcMbNDFiUB90lvTP9dDXGjrTSKpRy/8DfPUVUVImFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(2616005)(66476007)(5660300002)(6512007)(66556008)(8676002)(7416002)(44832011)(83380400001)(4326008)(66946007)(8936002)(36756003)(6666004)(86362001)(16526019)(956004)(316002)(6506007)(478600001)(52116002)(1076003)(26005)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fpEikHJ2pHv1WDhsVQ5tX/K9UVA0N8qH3hC2/bpVBeB5SaAiArPqBmCZ4EDCHRTgVruAbuPzE7A/spAlzsXdACwTQ5jcfA9j43sXtl6cwfx2pBCkT/W+0s91eNcN8/Bf1ij+UH5q3Pl3rHe11FDOvLz4AZoxiAuOZhOcIzQMr3o4rwu+BMLmeAq1vZyuXGbCuQ289nzc0zBahOyWw9Nyn3fun2YDO8xQZFteM1RceQKQ1FUgCjjE4JIQGTEjT/hbEjW6LdVMFoDYjJzvZlSjFvzwYWaIMnhxbENDR0ntFSsy9WRcFk0j3al9Nu1ZhBIaAB6AGGyVuYf8Oa/rrP68n9OS2KxSWfP9TAXxHpr/3ulyQPxJY588a/NCsnGFdxwwp89lRgDsEmmeNKfaIEZHB2YHjTZeI44UPT6a3T92lDRCmv6WmLlUl5jYGNrCGv6br+JhMpP38s+JmXNor2ChB/BkTNqxn4ehQ+3yXp1FTAQQMCIS3cPlOjz2ovLHwiimx0lto17Hy6aSEfWh4Z03+Bt7Jtv6b6WyPkD4bHez3Mrwjxcunrkrxre+dXZqmjqOdxGZHAMU6uAhFQKjznwj+IZAdI7DCsq3y0mOfKFpagilqzb0hK4zeOE2HL0smK4lHJRsIjVHkTAIQqpvtEKoOA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af32e16-91c7-4a6c-4778-08d861247d37
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:27:42.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k19ci+hs5tHwC4RQR72fTCcOTO9L/fcDYfgSq1jhzERklH+H7ouY+LFo1GG5Du8ZN5jxq33QQUf3gqpzyAlEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For noncoherent platform, the device page and vring should allocated by
dma_alloc_coherent, when user space wants to get its physical address,
virt_to_phys cannot be used, should simply return the saved device page
dma address by get_dp_dma callback and the vring dma address saved
in mic_vqconfig.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/bus/vop_bus.h    |  2 ++
 drivers/misc/mic/host/mic_boot.c  |  8 ++++++++
 drivers/misc/mic/vop/vop_vringh.c | 12 ++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/bus/vop_bus.h b/drivers/misc/mic/bus/vop_bus.h
index 4fa02808c1e2..d891eacae358 100644
--- a/drivers/misc/mic/bus/vop_bus.h
+++ b/drivers/misc/mic/bus/vop_bus.h
@@ -75,6 +75,7 @@ struct vop_driver {
  *                 node to add/remove/configure virtio devices.
  * @get_dp: Get access to the virtio device page used by the self
  *          node to add/remove/configure virtio devices.
+ * @get_dp_dma: Get dma address of the virtio device page.
  * @send_intr: Send an interrupt to the peer node on a specified doorbell.
  * @remap: Map a buffer with the specified DMA address and length.
  * @unmap: Unmap a buffer previously mapped.
@@ -92,6 +93,7 @@ struct vop_hw_ops {
 	void (*ack_interrupt)(struct vop_device *vpdev, int num);
 	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
 	void * (*get_dp)(struct vop_device *vpdev);
+	dma_addr_t (*get_dp_dma)(struct vop_device *vpdev);
 	void (*send_intr)(struct vop_device *vpdev, int db);
 	void __iomem * (*remap)(struct vop_device *vpdev,
 				  dma_addr_t pa, size_t len);
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index fb5b3989753d..ced03662cd8f 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -88,6 +88,13 @@ static void *__mic_get_dp(struct vop_device *vpdev)
 	return mdev->dp;
 }
 
+static dma_addr_t __mic_get_dp_dma(struct vop_device *vpdev)
+{
+	struct mic_device *mdev = vpdev_to_mdev(&vpdev->dev);
+
+	return mdev->dp_dma_addr;
+}
+
 static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
 {
 	return NULL;
@@ -119,6 +126,7 @@ static struct vop_hw_ops vop_hw_ops = {
 	.ack_interrupt = __mic_ack_interrupt,
 	.next_db = __mic_next_db,
 	.get_dp = __mic_get_dp,
+	.get_dp_dma = __mic_get_dp_dma,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
 	.remap = __mic_ioremap,
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index fc8d8ff9ded3..aa2dd240c11e 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -1076,6 +1076,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 		 unsigned long *size, unsigned long *pa)
 {
 	struct vop_device *vpdev = vdev->vpdev;
+	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
 	unsigned long start = MIC_DP_SIZE;
 	int i;
 
@@ -1088,7 +1089,14 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 	 * ....
 	 */
 	if (!offset) {
-		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
+		if (vpdev->hw_ops->get_dp_dma)
+			*pa = vpdev->hw_ops->get_dp_dma(vpdev);
+		else {
+			dev_err(vop_dev(vdev), "can't get device page physical address\n");
+			WARN_ON(1);
+			return -1;
+		}
+
 		*size = MIC_DP_SIZE;
 		return 0;
 	}
@@ -1097,7 +1105,7 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
 		if (offset == start) {
-			*pa = virt_to_phys(vvr->vring.va);
+			*pa = vqconfig[i].address;
 			*size = vvr->vring.len;
 			return 0;
 		}
-- 
2.17.1

