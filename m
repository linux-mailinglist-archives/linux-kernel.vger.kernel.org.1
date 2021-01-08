Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502892EEE8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbhAHI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:26:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbhAHI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610094295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D+IuUwBOwg8hNsyqoX4+8hAWhxTgkK/XQNwgdiHxBek=;
        b=i2dTczA/fCUy1VwBwDIDiSb1FN3j+0MZCNaziiIzOp+KHiT8PAVJOen8jQi015icWp4XK5
        30bOa+M1FwJM4QxBoLP2KntDji/U+Cse6UtcLPeIZLSx9Ails+xNGJxr1cvbRMwQfyj3XH
        0TzejLGvsujoLuRgq+RsT5MMmF6XXLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-daqfk_FRPGiSBT6dZBS_dQ-1; Fri, 08 Jan 2021 03:24:52 -0500
X-MC-Unique: daqfk_FRPGiSBT6dZBS_dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC2E180A08A;
        Fri,  8 Jan 2021 08:24:51 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA055D9E4;
        Fri,  8 Jan 2021 08:24:44 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mlx5: vdpa: fix possible uninitialized var
Date:   Fri,  8 Jan 2021 16:24:43 +0800
Message-Id: <20210108082443.5609-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream: posted

When compiling with -Werror=maybe-uninitialized, gcc may complains the
possible uninitialized umem. Fix that.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index f1d54814db97..a6ad83d8d8e2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -706,6 +706,9 @@ static void umem_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
 	case 3:
 		umem = &mvq->umem3;
 		break;
+	default:
+		WARN(1, "unsupported umem num %d\n", num);
+		return;
 	}
 
 	MLX5_SET(destroy_umem_in, in, opcode, MLX5_CMD_OP_DESTROY_UMEM);
-- 
2.25.1

