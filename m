Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856EF27C09B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgI2JMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:12:36 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:42306
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2JMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:12:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnGWinPoAXm6v8uT5RJeHouJV1LPvBx+vk/qhge6v7amRzWaHgAH5YmkzVZKeS0SfgGATEbgdyOk/uxrOiicRTTxAUOAXcAqyDeh5zdquPGnAjDMwQ2+9iWffL9NqdkOa1t/zT5DlMZ6HsMswtHF0anMpGQ4Fo4mvhmQYFednITT5DH0dL1dkzA1AYmcxOfy6d/WrVloJdFZfWt6ElIfcKPG+V2i78Udg4nmsUJgBGzv6BAWPPpcQDMjiw2TlYCoydR5PhdHw8Q9FF9H/qTtfZXRGAy5bo54TIYe/6hZyI6tzIb9b7Ykhhm0ouGvm+DKvPb89HcdOHBCZCyQOnqPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7nyXD2CUIxj5yWIH9ggnkDWFJl3IINt5rejnLDe5V4=;
 b=RAXeijpfRoqhcakUWuMuqi6fngRRsjqyePA5BLsempzmq6JmIkbCTCGFt+7ZR++u6m806+dceDng5l9Tu+DcYF/klqE3rIoZ3QcowTB/8XQKsBxs3i7ocluDyN64ihF3uERVFfc75QqgiSDqj7fJ5yzmp36i7e0AcgrsZPL+a9uG4whAKDnRnGk6skWhJq5IKjhjoS/sxqZXuwmfleUJ86Uz+C2+3aokL765HVU2Stwd6WWUb2UukxNq1qEziQKZ+VCufaGbwBXrWjAqLRr8JfV6z1CstSVahhBamGpJd+ifx+72mkqsKluKsIdcaHAhaKBhOlQXIN+WqQNbpwQmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7nyXD2CUIxj5yWIH9ggnkDWFJl3IINt5rejnLDe5V4=;
 b=XJbaezIPrQGKRqIBpSSX88S6O6x/LennxHaCjDx6U/Dnfq0xHT5pzFFJpA1Vvudfin0TUGiZ030Qegf9fo/rQHU9y13Bzc0xXngFrOryIzQCXZhRFZopQ708r/IRNEgSw53ZwabzoyKdrq4PwxfqTQB/KkiGQm+d8D5nCfEXbTE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 09:12:31 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 09:12:31 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 3/4] misc: vop: add round_up(x,4) for vring_size to avoid kernel panic
Date:   Tue, 29 Sep 2020 17:11:05 +0800
Message-Id: <20200929091106.24624-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929091106.24624-1-sherry.sun@nxp.com>
References: <20200929091106.24624-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 09:12:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69527707-af6b-414e-9546-08d86457cb9d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB475141F04D7ED7395AE9573792320@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4qFlKuBNfuZacQt2r/NJmYhOUjYvNMy9Vf3bRw1MYWGThdMXf/5d0oFc6eyp0O5w2UpYFM1B4VdE0G3SFuFwAQT1f5sRfJRQD7Wr2ra+Li9+jsuAy6ZlhKrBFOMrWdOBkmCOxFYtNa10/DeskC2sDOhcLkV4KaJM0iyPS5gz618YpA3nR3rPF11yAZ8rMMB4ioXIunksIP+qOJIISBcJKgVu5dxiNLLZJkpQavlFhC4ycKG4SLPhkczva/viXhxE3WjiROPTTAU7cQtHc8VhBu27PLHbpRS8fJcNllKsaywLnXQsMIxW5KICYirZUif3zC3lBt6+083ictBb9NsLM7W9FTQ2OS+3E/2EoUlUUEgyRQ9xVT86V63J7nbMWw8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(44832011)(1076003)(26005)(2616005)(16526019)(186003)(4326008)(5660300002)(956004)(6666004)(478600001)(316002)(2906002)(66556008)(66476007)(66946007)(83380400001)(6486002)(36756003)(8676002)(8936002)(86362001)(6506007)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QFbdfvwlg5Anb+fUbZdgg8fk1j4IRVOPQE1Waustdn6i0tL80rcP7AzfCQmuIiw9VQxkvUVRn2QxDGAVZ5cDGpRO06+RLRaOPV0Vf9NBZXXxNLHfJbWjA5VwZ2Xq1gZXwX/hZ6zTcuI5gc98WKGZ9yChMM0I2QKKGISdL/7ZywkO2B/34r0YOC8f10jRozL70tzCwCRjTPvLA5P13wyiI527mhK8gQi3J2yjMG45EZfR+cvB+vIbKk8qdpaDBWSMbrCmlZPTQ9HzxMc0tuYM7lKS0qkMWyUZVOeylZBW64uGG7Q4Js5NiT/g5MC0Bpy+DpreIVv5pTbMoBqty6RYwu9BBiL7ip+JtVfaSOzrOsbRfnBvoO5MFIcn4TutZHcSuO1yge4LnWWrngqz6T/2UNJw+rPgjAIPNLKmonfdj1JRH/AYS79BdsVotmi8argq9JPVcLzSETDoE1kV4dnMqsoVyZMSJBcI01FiYC7I7D3GNPhduHxkcH3Vz5xAgKUBOFy1Nadw3qGYzGSYIXkx/tR/4DMVYwnBd/ELGQ3meHpGyCIvVUaZwDIbtc4MbIUbONcgNqnNzLlq06YROVQHVJ52w56s/IH+W8u9e08cw7iWQ6/pmkX8okDEnreyXHSeRfVAIxmgi56DN+uIMmiGdw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69527707-af6b-414e-9546-08d86457cb9d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 09:12:31.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAt5UHlR29sfceL6aES8lmYJZedqLqcKicQOOpo/0/lwADZ2BtvMhlKwy8851OREGNtk2RERPl3topS9dKhuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since struct _mic_vring_info and vring are allocated together and follow
vring, if the vring_size() is not four bytes aligned, which will cause
the start address of struct _mic_vring_info is not four byte aligned.
For example, when vring entries is 128, the vring_size() will be 5126
bytes. The _mic_vring_info struct layout in ddr looks like:
0x90002400:  00000000 00390000 EE010000 0000C0FF
Here 0x39 is the avail_idx member, and 0xC0FFEE01 is the magic member.

When EP use ioread32(magic) to reads the magic in RC's share memory, it
will cause kernel panic on ARM64 platform due to the cross-byte io read.
Here read magic in user space use le32toh(vr0->info->magic) will meet
the same issue.
So add round_up(x,4) for vring_size, then the struct _mic_vring_info
will store in this way:
0x90002400:  00000000 00000000 00000039 C0FFEE01
Which will avoid kernel panic when read magic in struct _mic_vring_info.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/vop/vop_main.c   | 2 +-
 drivers/misc/mic/vop/vop_vringh.c | 4 ++--
 samples/mic/mpssd/mpssd.c         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 55e7f21e51f4..6722c726b259 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -320,7 +320,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	/* First assign the vring's allocated in host memory */
 	vqconfig = _vop_vq_config(vdev->desc) + index;
 	memcpy_fromio(&config, vqconfig, sizeof(config));
-	_vr_size = vring_size(le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN);
+	_vr_size = round_up(vring_size(le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN), 4);
 	vr_size = PAGE_ALIGN(_vr_size + sizeof(struct _mic_vring_info));
 	va = vpdev->hw_ops->remap(vpdev, le64_to_cpu(config.address), vr_size);
 	if (!va)
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 30eac172f017..45fdb394de11 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -296,7 +296,7 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 
 		num = le16_to_cpu(vqconfig[i].num);
 		mutex_init(&vvr->vr_mutex);
-		vr_size = PAGE_ALIGN(vring_size(num, MIC_VIRTIO_RING_ALIGN) +
+		vr_size = PAGE_ALIGN(round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4) +
 			sizeof(struct _mic_vring_info));
 		vr->va = (void *)
 			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
@@ -308,7 +308,7 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 			goto err;
 		}
 		vr->len = vr_size;
-		vr->info = vr->va + vring_size(num, MIC_VIRTIO_RING_ALIGN);
+		vr->info = vr->va + round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4);
 		vr->info->magic = cpu_to_le32(MIC_MAGIC + vdev->virtio_id + i);
 		vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
 					 DMA_BIDIRECTIONAL);
diff --git a/samples/mic/mpssd/mpssd.c b/samples/mic/mpssd/mpssd.c
index 51d03545869e..c03a05d498f0 100644
--- a/samples/mic/mpssd/mpssd.c
+++ b/samples/mic/mpssd/mpssd.c
@@ -403,9 +403,9 @@ mic_virtio_copy(struct mic_info *mic, int fd,
 
 static inline unsigned _vring_size(unsigned int num, unsigned long align)
 {
-	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (3 + num)
+	return _ALIGN_UP(((sizeof(struct vring_desc) * num + sizeof(__u16) * (3 + num)
 				+ align - 1) & ~(align - 1))
-		+ sizeof(__u16) * 3 + sizeof(struct vring_used_elem) * num;
+		+ sizeof(__u16) * 3 + sizeof(struct vring_used_elem) * num, 4);
 }
 
 /*
-- 
2.17.1

