Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A52B40A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgKPKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:17:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728477AbgKPKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605521829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8H2Bqogs1J5gueWTa1ZNYeIaGfg76P0inT/06O0WmI=;
        b=eLDw1aLoZSB4FfPOsYEbaV0SfiCTZXs2tKob+tMdZ9sxJq99bBBtUsubmhBnNj39DV7E2d
        B0tbCV6HWB5AAQIyJQllvpZ54HVCONW3bJB1vRVe4RCtpJn3xDA6hkCbBIM2bFJLmep7t6
        pUmQ6H0ZycrA9hOPmKflcPvEEz+8k+8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-33nzB17VO7idjW-6J-EjSA-1; Mon, 16 Nov 2020 05:17:07 -0500
X-MC-Unique: 33nzB17VO7idjW-6J-EjSA-1
Received: by mail-wm1-f69.google.com with SMTP id g3so8480717wmh.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S8H2Bqogs1J5gueWTa1ZNYeIaGfg76P0inT/06O0WmI=;
        b=RlCI4CbpEAvokxHmAMkaVG5kYz6g/lHeMeDhbBEaBcUZ7QHBRJpbWeA50RSqMF5WpC
         a7UzTtWPRnVCJSwg/Fl9TCHvJw09ZEqHwKj4yiiHsOCeaflz+4kmplXYKARy+u/nhSaM
         YyuUZob95yqh32HKDS2hneVFFYX1uHlUTH8ioYvSWAbXMyN71V6sPeWreOMkxiFqj0lG
         x2Thig/iffQws9rafHfaSmFrZigE4hX5RLHzH3YqETyyZLdqpghllafEP7fi7ZUs+Hss
         Vde8u+3GUqFezZ1vfEcz6z/1TyfpSCsU4MQu4CWYFXKVKHkSIa9fe5TAgWmvLxqLOg/3
         MOcQ==
X-Gm-Message-State: AOAM533zP/y+bwDCuB41DZlaH33gjLAFyanavpo890JDlsYHdWqv7YaD
        Ey4yBGBlAOK56TuIF+3eqwxN1i9AgfSYvuhRFQhVedZnNCUrezcxwJIkejkwUkOWVCUNb2Susrm
        K/sVTsdQylFCIi3nRytTM3tDm
X-Received: by 2002:a5d:6286:: with SMTP id k6mr18175663wru.216.1605521826529;
        Mon, 16 Nov 2020 02:17:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx420RhxBNM3R45JOIo3M19vsC37oxfl86iZcNklSUhq2+ppSFKN6ilOZkrtEtxMbhBryd87A==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr18175643wru.216.1605521826323;
        Mon, 16 Nov 2020 02:17:06 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id v19sm23043208wrf.40.2020.11.16.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:17:05 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:17:03 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201116101703.3gdazzatvvgqbc3a@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <061b5093-ef1c-a7d8-495e-1fe338b8b097@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <061b5093-ef1c-a7d8-495e-1fe338b8b097@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:10:19PM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>>This will allow running vDPA for virtio block protocol.
>>
>>Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>[sgarzare: various cleanups/fixes]
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v1:
>>- Removed unused headers
>>- Used cpu_to_vdpasim*() to store config fields
>>- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>>   option can not depend on other [Jason]
>>- Start with a single queue for now [Jason]
>>- Add comments to memory barriers
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 124 +++++++++++++++++++++++++++
>>  drivers/vdpa/Kconfig                 |   9 ++
>>  drivers/vdpa/vdpa_sim/Makefile       |   1 +
>>  3 files changed, 134 insertions(+)
>>  create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>new file mode 100644
>>index 000000000000..386dbb2f7138
>>--- /dev/null
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>@@ -0,0 +1,124 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+/*
>>+ * VDPA simulator for block device.
>>+ *
>>+ * Copyright (c) 2020, Mellanox Technologies. All rights reserved.
>>+ *
>>+ */
>>+
>>+#include <linux/module.h>
>>+
>>+#include "vdpa_sim.h"
>>+
>>+#define VDPASIM_BLK_FEATURES	((1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
>>+				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
>>+				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
>>+				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
>>+				 (1ULL << VIRTIO_BLK_F_MQ))
>>+
>>+#define VDPASIM_BLK_CAPACITY 0x40000
>>+#define VDPASIM_BLK_SIZE_MAX 0x1000
>>+#define VDPASIM_BLK_SEG_MAX 32
>>+#define VDPASIM_BLK_VQ_NUM 1
>>+
>>+static struct vdpasim *vdpasim_blk_dev;
>>+
>>+static void vdpasim_blk_work(struct work_struct *work)
>>+{
>>+	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>>+	u8 status = VIRTIO_BLK_S_OK;
>>+	int i;
>>+
>>+	spin_lock(&vdpasim->lock);
>>+
>>+	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
>>+		goto out;
>>+
>>+	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>>+		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>>+
>>+		if (!vq->ready)
>>+			continue;
>>+
>>+		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
>>+					    &vq->head, GFP_ATOMIC) > 0) {
>>+
>>+			int write;
>>+
>>+			vq->iov.i = vq->iov.used - 1;
>>+			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
>>+			if (write <= 0)
>>+				break;
>>+
>>+			/* Make sure data is wrote before advancing index */
>>+			smp_wmb();
>>+
>>+			vringh_complete_iotlb(&vq->vring, vq->head, write);
>>+
>>+			/* Make sure used is visible before rasing the interrupt. */
>>+			smp_wmb();
>>+
>>+			if (vringh_need_notify_iotlb(&vq->vring) > 0)
>>+				vringh_notify(&vq->vring);
>
>
>Do we initialize vrh->notify anywhere? And This seems duplicated with 
>the following vq->cb.
>
>I think the correct way is to initialize vrh->notify and use 
>vringh_need_notify_iotlb()/vringh_notify() instead of the vq->cb here.

Okay, so I'll set vrh->notify in the vdpasim core with a function that 
calls vq->cb() (the callback set through .set_vq_cb).

>
>And while at it, it's better to convert net simulator to do the same.

Sure.

Thanks,
Stefano

