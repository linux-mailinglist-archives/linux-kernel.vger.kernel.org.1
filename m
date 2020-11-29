Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD62C7849
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgK2Goy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:44:54 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7168 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK2Goy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:44:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc3433b0001>; Sat, 28 Nov 2020 22:44:11 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 29 Nov
 2020 06:44:14 +0000
Received: from vdi.nvidia.com (10.124.1.5) by mail.nvidia.com (172.20.187.18)
 with Microsoft SMTP Server id 15.0.1473.3 via Frontend Transport; Sun, 29 Nov
 2020 06:44:12 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lulu@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Date:   Sun, 29 Nov 2020 08:43:51 +0200
Message-ID: <20201129064351.63618-1-elic@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606632252; bh=vnx+QKCDfGuWiwXTibE49Afola6Whl8yGwIrV5dy/uA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=fXiCQCeiyS6nAjQgtUHmkwRkMBMlfVprpksS0XQUtspFr+f6FsLMoSXlGKAdVCCAI
         zFT6TvXLDgOVOW8IMGaBbjm9oMwC58a/rXwt32AWY+BXRWSevOBq+VSEqv2r9tg5fF
         lL5lQwvtlbCJL9qskJ4DU2OwHDrRBL8e/bgvyuaYVQeJ/uMXC+7l/ZYsTDqmmYNxjC
         SpwMBlcU7ukSlqGRNvZh/XHZ0JIo6WYY7lDXpMnDqrIBtpkY/s+vzKXdcDIl3j8nQe
         fHx/NUGii82jw2k5tYvYU4jc4R6MbNZiS1WZbCAz2Rt3BfUlN0jRiebQDzGmDuYYLn
         lvO+GIQDC29wg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not try to use the VF MAC address as that is used by the
regular (e.g. mlx5_core) NIC implementation. Instead, use a random
generated MAC address.

Suggested by: Cindy Lu <lulu@redhat.com>
Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices=
")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5=
_vnet.c
index 1fa6fcac8299..80d06d958b8b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 	if (err)
 		goto err_mtu;
=20
-	err =3D mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
-	if (err)
-		goto err_mtu;
-
+	eth_random_addr(config->mac);
 	mvdev->vdev.dma_dev =3D mdev->device;
 	err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
--=20
2.26.2

