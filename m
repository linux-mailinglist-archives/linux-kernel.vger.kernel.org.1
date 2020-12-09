Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105922D43CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgLIOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:01:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1891 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgLIOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd0d8870000>; Wed, 09 Dec 2020 06:00:39 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 14:00:38 +0000
Received: from vdi.nvidia.com (10.124.1.5) by mail.nvidia.com (172.20.187.12)
 with Microsoft SMTP Server id 15.0.1473.3 via Frontend Transport; Wed, 9 Dec
 2020 14:00:36 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lulu@redhat.com>, <maxime.coquelin@redhat.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v1] vdpa/mlx5: Use write memory barrier after updating CQ index
Date:   Wed, 9 Dec 2020 16:00:04 +0200
Message-ID: <20201209140004.15892-1-elic@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607522439; bh=5/w5thrUbO7coLFa91ISjV5KtPV9HKqfLYeWTRwEtkE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=a4z8z/bzLSAFmd3ybEquqOFl8aAqWlUfWBXDqwLpHw355BFXL8WpAmgHwk37R8ojG
         gt81bVN2tKT6aqokAmRRxO+h/4IjfblR1JSGURRydwMeyoQHiFBx+3N8lj63ShmaW5
         2CibDzHwIlqPk5gq/jUWZXFYBQjf6IyQ7CH8vIqpaNF2b9fta34vsGorGjRaDdOtvb
         aons2by8UWxfLgKXeEu09p333gWz0uErltkP9S6v8Zn2vQ2gSA3lVGgqyarbpQQwOU
         uR1LwGDU+vvQX59vJXTdT4NpcYXqhLFBtlmmq6wjgO5TpnbgA/N9i1atKTSFOopFh0
         Mi0t4vBq4w65w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to put dma write memory barrier after updating CQ consumer
index so the hardware knows that there are available CQE slots in the
queue.

Failure to do this can cause the update of the RX doorbell record to get
updated before the CQ consumer index resulting in CQ overrun.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices=
")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
V0 -> V1
Use dma_wmb() instead of wmb()

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5=
_vnet.c
index db87abc3cb60..43b0069ff8b1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -479,6 +479,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq=
)
 static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, =
int num)
 {
 	mlx5_cq_set_ci(&mvq->cq.mcq);
+
+	/* make sure CQ cosumer update is visible to the hardware before updating
+	 * RX doorbell record.
+	 */
+	dma_wmb();
 	rx_post(&mvq->vqqp, num);
 	if (mvq->event_cb.callback)
 		mvq->event_cb.callback(mvq->event_cb.private);
--=20
2.27.0

