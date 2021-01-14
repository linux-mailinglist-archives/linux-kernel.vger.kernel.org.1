Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB782F5B15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbhANHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:10:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbhANHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610608157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TVFXDqec6pwCzdCIDxRRfvAbooVbruXrA3fULyG3QMk=;
        b=aUmMhBjRSrXAlAE/d48j6dTqWWg7LqIWZRal0qyLFdZTqO70p39TqFiYuD9rc32dQ/r+Gv
        AlAP+P5ofCcDhxYpiTHFKDCWdR2UhsmKAC1ENZ9QrUB9OgwAooisNb5FILoPVQWwFwcckm
        wAM21YingDdOAeZ8fn2RcoD/TCYYWiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-s-iKU53eNSaXWPkBt1_cFQ-1; Thu, 14 Jan 2021 02:09:13 -0500
X-MC-Unique: s-iKU53eNSaXWPkBt1_cFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50CC425C8;
        Thu, 14 Jan 2021 07:09:11 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-100.pek2.redhat.com [10.72.12.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07C9362951;
        Thu, 14 Jan 2021 07:09:06 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     elic@nvidia.com
Subject: [PATCH V2] mlx5: vdpa: fix possible uninitialized var
Date:   Thu, 14 Jan 2021 15:09:04 +0800
Message-Id: <20210114070904.9981-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Werror=maybe-uninitialized, gcc may complains the
possible uninitialized umem. Since the callers won't pass value other
than 1 to 3, making 3 as default to fix the compiler warning.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index f1d54814db97..07ccc61cd6f6 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -703,7 +703,7 @@ static void umem_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
 	case 2:
 		umem = &mvq->umem2;
 		break;
-	case 3:
+	default:
 		umem = &mvq->umem3;
 		break;
 	}
-- 
2.25.1

