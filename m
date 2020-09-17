Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9418E26DB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgIQMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:19:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13532 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgIQMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:19:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6352cf0003>; Thu, 17 Sep 2020 05:13:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 05:14:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Sep 2020 05:14:31 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 12:14:29 +0000
Date:   Thu, 17 Sep 2020 15:14:25 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lulu@redhat.com>
Subject: [vhost next 1/2] vdpa/mlx5: Make use of a specific 16 bit endianness
 API
Message-ID: <20200917121425.GA98139@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600344783; bh=Gm7fDFmdmeHC1jE5J6cDxE0734gQN4RktvZ+yaNHL44=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:MIME-Version:
         Content-Type:Content-Disposition:User-Agent:X-Originating-IP:
         X-ClientProxiedBy;
        b=O3bN5jbQBJwlep3AR/nHMiBHjJrEGDyMdTGvK4DxrfumZwQxc+gI/TWzk22nJpFQu
         dNDu4XzBPkBq317qK2P4DAwCieIFZ4jsqksV6o2iXbeO5DSKpjcz2wyTQZObrqX6UN
         2IV4IACSBoEuuOVX0jQ8EZG6zrV79EhVUxnYMEysVKUd9zuiQEUeqfjSsenRvXMTLf
         ClhInH4lYEwl+I8+oRHonnXL71D6yoQCxYmQZzGxak2DISpAyqnkVB7Ys4m1okZjrQ
         Y/j3FzYnblb21CEDFyFvDYeLFTf4cvF7bnbrLKlr65GFVdO66dqpDAph7Y7owXMjBC
         mAMZCeB8b9jHg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a dedicated function to be used for setting 16 bit fields per
virio endianness requirements and use it to set the mtu field.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 70676a6d1691..e70ff7dee33d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1514,6 +1514,11 @@ static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
 		(mvdev->actual_features & (1ULL << VIRTIO_F_VERSION_1));
 }
 
+static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
+{
+	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
+}
+
 static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -1527,8 +1532,7 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 		return err;
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
-	ndev->config.mtu = __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev),
-					     ndev->mtu);
+	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
 	return err;
 }
 
-- 
2.27.0

