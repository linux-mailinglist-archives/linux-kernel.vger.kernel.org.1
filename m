Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6492C867F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgK3OSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbgK3OSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606745795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nk3PwbgnWPBsA8dJTlZWHGE9bPoVI0JdWk0TDjCsPaU=;
        b=OOiuG/jASpN1snBBoOXx78xN637caA6TPsGx6CBR6Wkwh5v3A8fzXfJ/5w0oAMDxhr/xcC
        swvIUhFo+47RQ9Opf42dufr+1XgY7P6cqkWPmnuPXFbkQ9DqqcJZ2he/uF6rFjRTpdnaxq
        LCa1DM/DB9no+vKDCdnID3PX2l482BM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-_-8pQPRnMHGw-Pt80VEaqQ-1; Mon, 30 Nov 2020 09:16:32 -0500
X-MC-Unique: _-8pQPRnMHGw-Pt80VEaqQ-1
Received: by mail-wr1-f72.google.com with SMTP id n1so8497162wro.22
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nk3PwbgnWPBsA8dJTlZWHGE9bPoVI0JdWk0TDjCsPaU=;
        b=c9Eeu01RO+dG0s01xBkpmGmgXGLqZSpAbowDtfDAo5up7aifFUg7DgP5C7l9B03pmf
         yNf/QvQKZ5M8J6ZN8Vz4RBWun81+zQNKe0Klw/NEh/p9jBv12DF4fiDu2mlQxl7hg+5n
         rXgrAvoRePd6sN70AuIbHULiyuLSPKrbi1J3d3lDCAjh1y8C4YH/+uRTyxdeoWZ+8oIS
         xSnmSozmxOzFI05HbqBWoNV5endVbe0znl8k3JbTQFcLQDpqnLUULFEUDSxlXk4Xs4Qm
         7b+VBYiS/Q7//p1Rdw1mM68+/+sKwuOBnpow3S9SK6I/kK09+qtQLKcYTtwrRJ+02FNh
         cuGQ==
X-Gm-Message-State: AOAM53178yqOMqgORzXBBu0pauVhkSGfmThoBvDu+o1/IlM4URgYvg2C
        4XlAU8pi/lCN7mhoQU/lAdu/eMA3na7t2hgGqZB14F/r6d2s/NqH64oEfjBkOoRN6p0nN877LtZ
        tcC4HHhAUoipmLjLhiS8vT9pA
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr23625728wmh.110.1606745790540;
        Mon, 30 Nov 2020 06:16:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjRy9tynfMnBGRMaIbuZ6bUgN4vno7cZV4YkNrWOD0VSIz+J6N442hYHa81mtCWHg4WmBcew==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr23625712wmh.110.1606745790353;
        Mon, 30 Nov 2020 06:16:30 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id t136sm25228625wmt.18.2020.11.30.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:16:29 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:16:27 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 13/17] vdpa_sim: set vringh notify callback
Message-ID: <20201130141627.4gjsoiwg5byt3ujx@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-14-sgarzare@redhat.com>
 <5569e198-22be-514a-744a-1bef9a3b95ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5569e198-22be-514a-744a-1bef9a3b95ce@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:27:51AM +0800, Jason Wang wrote:
>
>On 2020/11/26 下午10:49, Stefano Garzarella wrote:
>>Instead of calling the vq callback directly, we can leverage the
>>vringh_notify() function, adding vdpasim_vq_notify() and setting it
>>in the vringh notify callback.
>>
>>Suggested-by: Jason Wang <jasowang@redhat.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>index 8b87ce0485b6..4327efd6d41e 100644
>>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>@@ -120,6 +120,17 @@ static struct vdpasim *dev_to_sim(struct device *dev)
>>  	return vdpa_to_sim(vdpa);
>>  }
>>+static void vdpasim_vq_notify(struct vringh *vring)
>>+{
>>+	struct vdpasim_virtqueue *vq =
>>+		container_of(vring, struct vdpasim_virtqueue, vring);
>>+
>>+	if (!vq->cb)
>>+		return;
>>+
>>+	vq->cb(vq->private);
>>+}
>>+
>>  static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>  {
>>  	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>>@@ -131,6 +142,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>  			  (uintptr_t)vq->driver_addr,
>>  			  (struct vring_used *)
>>  			  (uintptr_t)vq->device_addr);
>>+
>>+	vq->vring.notify = vdpasim_vq_notify;
>
>
>Do we need to clear notify during reset?

Right, I'll clear it.

>
>Other looks good.
>

Thanks,
Stefano

