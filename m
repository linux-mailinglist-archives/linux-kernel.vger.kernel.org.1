Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903432B1C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKMNsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbgKMNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xii9EkSNI++swzQsAddzZFhZQHEvE4PS5MaY9kGEHbw=;
        b=BWRcB+LEGOc0ue8jUP7QwWPs67BR7PF4VqVu4KJeOuudDGMhlH/mXDFJVOHOdM88QcZNAZ
        GHA6dE/Dtn9Nkqk4WU4aArWBD4WQqTkdp5KQXr53Iodbsf8UVM94VXB4Jjk2WLyCbriWo7
        uQf/D1R2J9q6bAGiKMYPgaRylg36APg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-c_y0XwUIOzK2hbMJV5l9Pw-1; Fri, 13 Nov 2020 08:48:43 -0500
X-MC-Unique: c_y0XwUIOzK2hbMJV5l9Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EDED8030A0;
        Fri, 13 Nov 2020 13:48:42 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C57C55D9F3;
        Fri, 13 Nov 2020 13:48:40 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 09/12] vdpa_sim: make vdpasim->buffer size configurable
Date:   Fri, 13 Nov 2020 14:47:09 +0100
Message-Id: <20201113134712.69744-10-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow each device to specify the size of the buffer allocated
in vdpa_sim.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index f7e1fe0a88d3..cc21e07aa2f7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -49,6 +49,7 @@ struct vdpasim_device {
 
 struct vdpasim_init_attr {
 	struct vdpasim_device device;
+	size_t buffer_size;
 	int batch_mapping;
 
 	work_func_t	work_fn;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index bd034fbf4683..3863d49e0d6d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -223,7 +223,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
-	vdpasim->buffer = kvmalloc(PAGE_SIZE, GFP_KERNEL);
+	vdpasim->buffer = kvmalloc(attr->buffer_size, GFP_KERNEL);
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index f456a0e4e097..122a3c039507 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -100,6 +100,7 @@ static int __init vdpasim_blk_init(void)
 	attr.device.update_config = vdpasim_blk_update_config;
 
 	attr.work_fn = vdpasim_blk_work;
+	attr.buffer_size = PAGE_SIZE;
 
 	vdpasim_blk_dev = vdpasim_create(&attr);
 	if (IS_ERR(vdpasim_blk_dev)) {
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index b9372fdf2415..d0a1403f64b2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -124,6 +124,7 @@ static int __init vdpasim_net_init(void)
 
 	attr.work_fn = vdpasim_net_work;
 	attr.batch_mapping = batch_mapping;
+	attr.buffer_size = PAGE_SIZE;
 
 	vdpasim_net_dev = vdpasim_create(&attr);
 	if (IS_ERR(vdpasim_net_dev)) {
-- 
2.26.2

