Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9882B1C10
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKMNre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbgKMNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUSCXqZfVu5qowPNJ7+Usz2GPpNw0QJvHN5TBNVtPXI=;
        b=ZN+yGDgV8jI5n1dsGxqnrMVHHTdSXMiIAeA6DC5eudT5gBdrlrt6gj4oa75vx3r3oSPDig
        t1iK51OW5V2QxOqXYjdALctHAUuoG7h2mLEeC3Ein7amMgEvbZmFdm2imS+/Ejnuzw5JA8
        r8HOm3Gq/2SXbr4X9H9/5SsHcDslJDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259--0QA5k77MY-frLRzGvAyxA-1; Fri, 13 Nov 2020 08:47:25 -0500
X-MC-Unique: -0QA5k77MY-frLRzGvAyxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D55210066FA;
        Fri, 13 Nov 2020 13:47:24 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5310B60C84;
        Fri, 13 Nov 2020 13:47:22 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 01/12] vhost-vdpa: add support for vDPA blk devices
Date:   Fri, 13 Nov 2020 14:47:01 +0100
Message-Id: <20201113134712.69744-2-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

Currently only net devices can act as vDPA backends. Add an
infrastructure for block devices will basic feature list that will be
increased in the future.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 2754f3069738..fb0411594963 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -22,6 +22,7 @@
 #include <linux/nospec.h>
 #include <linux/vhost.h>
 #include <linux/virtio_net.h>
+#include <linux/virtio_blk.h>
 
 #include "vhost.h"
 
@@ -194,6 +195,9 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
 	case VIRTIO_ID_NET:
 		size = sizeof(struct virtio_net_config);
 		break;
+	case VIRTIO_ID_BLOCK:
+		size = sizeof(struct virtio_blk_config);
+		break;
 	}
 
 	if (c->len == 0)
@@ -975,12 +979,13 @@ static void vhost_vdpa_release_dev(struct device *device)
 static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 {
 	const struct vdpa_config_ops *ops = vdpa->config;
+	u32 device_id = ops->get_device_id(vdpa);
 	struct vhost_vdpa *v;
 	int minor;
 	int r;
 
-	/* Currently, we only accept the network devices. */
-	if (ops->get_device_id(vdpa) != VIRTIO_ID_NET)
+	/* Currently, we only accept the network and block devices. */
+	if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
 		return -ENOTSUPP;
 
 	v = kzalloc(sizeof(*v), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
@@ -998,7 +1003,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	v->minor = minor;
 	v->vdpa = vdpa;
 	v->nvqs = vdpa->nvqs;
-	v->virtio_id = ops->get_device_id(vdpa);
+	v->virtio_id = device_id;
 
 	device_initialize(&v->dev);
 	v->dev.release = vhost_vdpa_release_dev;
-- 
2.26.2

