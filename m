Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8786D2DAF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgLOOqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:46:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729619AbgLOOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wArsqgzCWDcvwgGpOlHJ94D+i7gVf5ZKVnJlx27P+T8=;
        b=QORALRUnEinFrNANjB6PDE3ZiL5reP8b58JLMwB+CuguMGB40bg7G1q9O2HBxMcEFf1N5b
        TOJPQEZ5LkkbOdO6tnF/Tq4i2di02Uay001sD1ti00AODtXI65bNCXLDfcVfJOP97QdYRV
        G1uqEtOJb5KsIH9VX5yBCDWxJjUQY38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-Hgu1okhiObSZaxV51CZP-Q-1; Tue, 15 Dec 2020 09:43:47 -0500
X-MC-Unique: Hgu1okhiObSZaxV51CZP-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11FCA107ACF5;
        Tue, 15 Dec 2020 14:43:46 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CFEB19C44;
        Tue, 15 Dec 2020 14:43:36 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Oren Duer <oren@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shahaf Shuler <shahafs@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 04/18] vdpa_sim: make IOTLB entries limit configurable
Date:   Tue, 15 Dec 2020 15:42:42 +0100
Message-Id: <20201215144256.155342-5-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may require a higher limit for the number of IOTLB
entries, so let's make it configurable through a module parameter.

By default, it's initialized with the current limit (2048).

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 07ccc8609784..d716bfaadb3b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -31,6 +31,11 @@ static int batch_mapping = 1;
 module_param(batch_mapping, int, 0444);
 MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
 
+static int max_iotlb_entries = 2048;
+module_param(max_iotlb_entries, int, 0444);
+MODULE_PARM_DESC(max_iotlb_entries,
+		 "Maximum number of iotlb entries. 0 means unlimited. (default: 2048)");
+
 static char *macaddr;
 module_param(macaddr, charp, 0);
 MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
@@ -371,7 +376,7 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim->vqs)
 		goto err_iommu;
 
-	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
+	vdpasim->iommu = vhost_iotlb_alloc(max_iotlb_entries, 0);
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
-- 
2.26.2

