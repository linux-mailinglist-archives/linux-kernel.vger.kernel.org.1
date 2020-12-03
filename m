Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672902CDBEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgLCRJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgLCRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u41/nZpJoK5Ju4QGFm7nipqpEf+2JFEaUGjz0pmi+Lk=;
        b=OoLSatlqGbXD1KXEwB7GykEp/b9kKBWjAdKR46J+trFlWRCq2It/QLX8rIpt8O7C3ediQw
        7tDP/7Bv7cdvSF3bbAcvOJv/c9s+5AzmtIZ9yAZsssxhyLYv7b2R1ZoWkiZWOug8GNXW6+
        zMqZdOC53x+Tr3Qp59UW9E5I9sFhbA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Q_XRWSj3OTuUmlZIoEP-kw-1; Thu, 03 Dec 2020 12:08:03 -0500
X-MC-Unique: Q_XRWSj3OTuUmlZIoEP-kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11CD4858180;
        Thu,  3 Dec 2020 17:08:02 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7219C18A9E;
        Thu,  3 Dec 2020 17:07:52 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 16/19] vdpa_sim: use kvmalloc to allocate vdpasim->buffer
Date:   Thu,  3 Dec 2020 18:05:08 +0100
Message-Id: <20201203170511.216407-17-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch will make the buffer size configurable from each
device.
Since the buffer could be larger than a page, we use kvmalloc()
instead of kmalloc().

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 1243b02488f7..fb714d88e77f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -410,7 +410,7 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
-	vdpasim->buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	vdpasim->buffer = kvmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
@@ -699,7 +699,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	cancel_work_sync(&vdpasim->work);
-	kfree(vdpasim->buffer);
+	kvfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
 	kfree(vdpasim->vqs);
-- 
2.26.2

