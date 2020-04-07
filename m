Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48A51A0407
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 03:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDGBIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 21:08:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbgDGBH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=Zj40fYoODoxVi4XHTvSdf5tMUxOn5Z1jCVM5YUiFTZgAVX1keAY38q6HXye5XcJMDftBcC
        wNEU1mjVazEQOFe45/U/lGIIDAoZzuQpicRdNsZYcvm3KCN6BA19erKrBHV71V7MKnCnyc
        pq4dlSEDPPtYGWGyMvLl5xBj3JbyAuw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-AsmVnpOLO564BTEIX89pWQ-1; Mon, 06 Apr 2020 21:07:55 -0400
X-MC-Unique: AsmVnpOLO564BTEIX89pWQ-1
Received: by mail-wr1-f71.google.com with SMTP id d4so853910wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=DH7YjLui8kLRylFceQnrXl3sHAhYJPkBpX36YSUqxn+IUZ96kSUDSP0Zm8DHaSj588
         7A8LBr7uyAY365LwnA5kGzs8LPSiDUvDGp7nB+ZlfgenDED8pP1lWi4RQwaZM3wO05bU
         qFkfRxm7lwTtvy5CgDVGw9iY7fD88KfoSonY6GfXhTizvP61ilrp4uvsTxHTH1K52FiF
         EpUDNfO8ofOfLG+W1OARF+WmUktKhMpbXO//GinXUDHPoqySQe5qGpBpvH8IrTATd7pt
         o2fhl6y+TMbPJwv58bWTm7sChC9RIgtE1e0ORFRtGeas0zLWYwui85TkICvLL417D7Vt
         Sr4A==
X-Gm-Message-State: AGi0PuZJJzuH4gbyBvAvJXJc6KwKaAPR9DsWjhmHgnrMWbMDci9A6YGr
        awOwnCUxGJhz/sPm4XZJyHt9ws3NCWy0xSGK+Pc8R57E0+h8HZUi0NEzbxJeVNaPVqqq6KWE4mF
        z27ukMi0X5S/gIekEIlwZ+/Hj
X-Received: by 2002:adf:b64f:: with SMTP id i15mr2141420wre.351.1586221673877;
        Mon, 06 Apr 2020 18:07:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfcRjSa8EBjoFB9rOfrumGltBNTU2RyNzqAtIHJkjB9ul09RYHrNTl2krVquGlGZNCgZMiqA==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr2141409wre.351.1586221673660;
        Mon, 06 Apr 2020 18:07:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id r2sm122541wmg.2.2020.04.06.18.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:53 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 12/19] virtio_ring: switch to virtio_legacy_init/size
Message-ID: <20200407010700.446571-13-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs
that make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d48..2a2b12449bac 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -867,8 +867,10 @@ static struct virtqueue *vring_create_virtqueue_split(
 	}
 
 	/* TODO: allocate each queue chunk individually */
-	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+	for (; num && vring_legacy_size(num, vring_align) > PAGE_SIZE;
+	     num /= 2) {
+		queue = vring_alloc_queue(vdev,
+					  vring_legacy_size(num, vring_align),
 					  &dma_addr,
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
@@ -882,14 +884,15 @@ static struct virtqueue *vring_create_virtqueue_split(
 
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+		queue = vring_alloc_queue(vdev,
+					  vring_legacy_size(num, vring_align),
 					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
 		return NULL;
 
-	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring, num, queue, vring_align);
+	queue_size_in_bytes = vring_legacy_size(num, vring_align);
+	vring_legacy_init(&vring, num, queue, vring_align);
 
 	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				   notify, callback, name);
@@ -2169,7 +2172,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
 
-	vring_init(&vring, num, pages, vring_align);
+	vring_legacy_init(&vring, num, pages, vring_align);
 	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				     notify, callback, name);
 }
-- 
MST

