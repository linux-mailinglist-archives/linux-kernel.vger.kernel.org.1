Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A32278169
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgIYHWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:22:17 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:13894
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbgIYHWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejKTXmXcHYs184RSLUnLrkWHOiIPW+5fZiWx3/KmvrFT+8AZ7Pc1mrpbPU3whD8ZwdE76WM0HyPFz9aovNtLx6yxJvVJjDi1LYZurdgnTHihlyJpySoPgdBqkEmCxqA105Uev7VJbMhAz9/u8eWvKi31wPqKrdB5pB9WVXJFR6AbVdcgCc8vA5SH8c8hoMhrsLFuVYrVyhDBmVTeW3JaT+tAXRK73AGiyrhv2WisKdJXNdnh3KcHeDXKUN/8uq5qLibar1vIvfkn6DCXSXRvPFC039H5M3OMqNQUtaTXEBi8vRqwUnwTIBpUd8rnCnfZJmeSwVbWXyMlimJ37GIJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7nyXD2CUIxj5yWIH9ggnkDWFJl3IINt5rejnLDe5V4=;
 b=DYeA4X+7u/BjrgA8a1/PUd24nljgA+qZe2bJEj+XnyTNf+z0Ztd2brYAMhdKYyht7TycXXYBR8WbJqQHhg5FquxYnOIpCP+p3U/yrlr3yaHG2u5UOCeIGFUO7wmBjV2Pd0j0mfvAkHre41tVL22YAnuDhMmw68cKNm4uSQm+qTsPqBU3pWhGtCH4Us5+c2joQOYZRfED3uFS/Gdike3sTsKJHA/UmTWSIhKP3I8HFBBRm4qeNXUu7K0mrTkeHQiijWVW2ahQcA8VZ6osVwvPh3V7nVhsYHDmYOtLjtWRTUua1bQN6/c+9UE7TzGx2lIeITTRGQA0FXLvYCwY/91pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7nyXD2CUIxj5yWIH9ggnkDWFJl3IINt5rejnLDe5V4=;
 b=ds7Qzly44VTl3NrR+rFblwLHXsLs5mGrSFW1tdaaajR8iUEqXw/jsXCCrojCUGT/zz7R0RT31xXbiXHmGMi1rRDWCVmYKFbZyVPhy3gwBYRiDws7YERxSCx6MsOCz7JkPpy/4ewJXCfiRyWE3w0F77HnT8ss3NEi+vjaFRnbauA=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4320.eurprd04.prod.outlook.com (2603:10a6:803:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 07:22:11 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:22:11 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 3/4] misc: vop: add round_up(x,4) for vring_size to avoid kernel panic
Date:   Fri, 25 Sep 2020 15:18:30 +0800
Message-Id: <20200925071831.8025-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925071831.8025-1-sherry.sun@nxp.com>
References: <20200925071831.8025-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0118.eurprd07.prod.outlook.com
 (2603:10a6:207:7::28) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM3PR07CA0118.eurprd07.prod.outlook.com (2603:10a6:207:7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Fri, 25 Sep 2020 07:22:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97b6b98d-aa80-4c2f-44c1-08d86123b7d0
X-MS-TrafficTypeDiagnostic: VI1PR04MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4320D07B1A1CDFAF0A3B2D5C92360@VI1PR04MB4320.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7EZgG0oMfDa5Jvkkqw0K4sMSKCiImEeAF0erqRoKV4Jp279BAUhIABgLX9isb4edRwlNj7vxjPcpQ8boSyaEnRYcyARNA8OmR7rgkeXdcWrASqklJPvM39af3CSYN1ivbDqvL5QzJhvEd4UToKMPza+03Wnne+HlK5Z4+AZqUz12aM5iUay5CgpNZ1LzzGt1agyQuJ30B1qAxd38LoYkQY951WGIcpoteRHaSH4zT7YI16DgnzdnFJvSoP+cgbpzagDyG4XVP1Tn6vg/Aigfw3J6Ti4LwhNug93lShp6c3C0y5aLcozi6lTX+4+evJGVa5u8cGoH/wy9UbRuqn+Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(16526019)(52116002)(6486002)(6506007)(26005)(83380400001)(86362001)(478600001)(316002)(186003)(2616005)(5660300002)(956004)(2906002)(66946007)(66476007)(1076003)(66556008)(8936002)(6512007)(4326008)(36756003)(6666004)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7Qa1/Yip7hZUrWRid/vGcgiA/P6+g0iqLOBBj/U/fYUxSmzaDZk0nLxYZJ3a/kz8//+J/LmAlbGcgRw4/kbi6lDlnbCZDRc8WxKmmKuXio+TP68qqmFkP7bYJdfw3jlBa/OJR5F2Nh1xrUKTw/IKZtfe2JUgBtSVSWxbudCohao2QHLk0OL1f/ORz1O/B2JXbnZfZszrmy/79Ywy/KRlK0/b3+hir/12EsqFOGnEjJmEcL+4Ip6VEd9Au1CLM8EZO8Y4V9E+kxbnbTF0/6zYU2ALMRQmNEDcECoIj9DJtPr0nnWcjkVmrYUJb6fVNIOLWExUvvJMbYxaWKkbatRyWDDrv3GIvARlwbNEyVS6QB1q5Ob0tku7hsiORc5HEt2xRRqkwCfLuc7w9UWhXAgRwDztMFg00N30eH9y0ZVGka5k9bLL6cCwtEFErgTySjjL0i9oMp3ShC2TtlCNNm58330XPUQJLl2n/qcdmkNLVQwm0ltVVTni6iwJrYuNm7pnyNzCHwQp06tZIFzbteMaMWONR0LiVOqKnOF32kE2ojCF4QdNVN+gmEm391BvLa5TCQ6i0kKRH49eLDazbWIHmsLgoIvrcX5ZnYg1Q7wDxm4IoXXle6J9VhcJi9ZeEUMmrORaotM3PjqHg1VzYfi7VQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6b98d-aa80-4c2f-44c1-08d86123b7d0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:22:11.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W8y1YvXGauXdRGaQ6kxX4YupHjhpwlsZGtEZrZ1wsjfrFDr65lQsJeL93wHWSuc/SUooqk+mFP2lubQMBEbuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4320
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

