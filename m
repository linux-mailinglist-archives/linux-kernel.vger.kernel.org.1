Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FBB26DB64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIQMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:21:03 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19248 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgIQMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:20:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6353460000>; Thu, 17 Sep 2020 05:15:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 05:15:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 05:15:46 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 12:15:43 +0000
Date:   Thu, 17 Sep 2020 15:15:40 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lulu@redhat.com>
Subject: [vhost next 2/2] vdpa/mlx5: Fix failure to bring link up
Message-ID: <20200917121540.GA98184@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600344903; bh=xNDUVAOiUY33eFNSRyaUWgqKQPOQCmaCt04lCyjdrng=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:MIME-Version:
         Content-Type:Content-Disposition:User-Agent:X-Originating-IP:
         X-ClientProxiedBy;
        b=N8snmDHwUzWH/4rEqkfw024J/57ZCERxZ9AYEi+tDuC+d13qDUOj4q45ITfV+VZ6c
         eYdyGUqiAaADQDFWWvbl+Yu47tfv7KkeosojLswVPLxah0hLg9AFkakdrCYHgcVFBu
         myR0YTJMJW4KNHeo9Vrnkm3QRHFX5RDvsgXA9PKYemBEwTAkDeYJtu0puq6vBlCvuw
         iGQtsRix4H6JJPcbQf7nVNAaYtQiDHkzLmsFsyeQvf2ybUIsaTi8FPzALQVpbHJQPb
         MIHez5fF1SbpzBCfeXwlaFi/FwoTrAXKlPq+dvoNbIXzAGX/TtqoMc365lf+InwYFJ
         F+bKOXqAyphrA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set VIRTIO_NET_S_LINK_UP in config status to allow the get the bring the
net device's link up.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e70ff7dee33d..d0df768f29da 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1533,6 +1533,7 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
 	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
+	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
 	return err;
 }
 
-- 
2.27.0

