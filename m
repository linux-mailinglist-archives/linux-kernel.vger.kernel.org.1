Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA222D0314
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 12:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLFK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:58:10 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14353 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:58:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fccb91a0002>; Sun, 06 Dec 2020 02:57:30 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 6 Dec
 2020 10:57:27 +0000
Received: from vdi.nvidia.com (10.124.1.5) by mail.nvidia.com (172.20.187.12)
 with Microsoft SMTP Server id 15.0.1473.3 via Frontend Transport; Sun, 6 Dec
 2020 10:57:26 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lulu@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ index
Date:   Sun, 6 Dec 2020 12:57:19 +0200
Message-ID: <20201206105719.123753-1-elic@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607252250; bh=Zkkbs03esi6gHdtbZwp7PNxhGdhjxkgmGEXLhNQpLr0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=oxMIbOM1ZGAOqvpIWDghd7V91KJ6tRwv89/wtGHH+4XNWq0RyoK5rRvdDaqtasnPo
         rHcWj5icTYAsa11wqeOJ9Akyddi5FGZADSlkIy8TI+QfkMcufafPp4r3odDYGZk092
         FIIHJlVu/LwOpGAyyRCfBQXeW3bnRp7fXKp+SFJDLlPGOf4YrTFnwMUM8wpACx8mTf
         Qn6Aw9pMsH/0TNbw1JNY35tYgQie2WU0W5bPUhPn4lwi6BwhVamMe09a77B1QBnMJx
         E+5W2E9b0Vv6KrnSSGzLCx48jPDaW+nGALr1OECDcgeL7gVA2P2pqJ/b2UJEnF6p9B
         Aro8pHyJewI3w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to put write memory barrier after updating CQ consumer index
so the hardware knows that there are available CQE slots in the queue.

Failure to do this can cause the update of the RX doorbell record to get
updated before the CQ consumer index resulting in CQ overrun.

Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices=
")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5=
_vnet.c
index 1f4089c6f9d7..295f46eea2a5 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq=
)
 static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, =
int num)
 {
 	mlx5_cq_set_ci(&mvq->cq.mcq);
+
+	/* make sure CQ cosumer update is visible to the hardware before updating
+	 * RX doorbell record.
+	 */
+	wmb();
 	rx_post(&mvq->vqqp, num);
 	if (mvq->event_cb.callback)
 		mvq->event_cb.callback(mvq->event_cb.private);
--=20
2.27.0

