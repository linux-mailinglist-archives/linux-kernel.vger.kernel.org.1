Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11F2C8669
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgK3OQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:16:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgK3OQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606745707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3gBLWLKl7W4Xq6wM+ZxQ2x038DmE926WYCMQCHr66g=;
        b=GaGFfpJxm1WnAgoI5nbvOs66GaNZ6OlATTQ2/6asz1Bxcq1cRe3PZnq3H+oKKp7i/hMdbr
        yGlKHlge38VowqiVXBRQKZeT9Wbqex2H1G2WCCRIm49Pp38xTqkgFMqO9GTqgGuu6VFd/w
        bE9wi1XnMWIRTmHtu3rQJe57Xp3eTc8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-VAU6V7SAOGeEcxbkTELB3A-1; Mon, 30 Nov 2020 09:14:57 -0500
X-MC-Unique: VAU6V7SAOGeEcxbkTELB3A-1
Received: by mail-wm1-f71.google.com with SMTP id k128so7484226wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J3gBLWLKl7W4Xq6wM+ZxQ2x038DmE926WYCMQCHr66g=;
        b=ms8Vl+O6BN0sQ56Ms7Xj/h2Mj2eWbyr6dzeOGKcNDD6A6WLXuQomIzeApVG6SZj4Ls
         RGDbiZBC0O1vj+fNVJY8MMnZEjDgSONYKxd0BP+wb5IAokNmUXbywe0+jAuxhYCKwE11
         8U/d+a3qBgL7i0W88HLg0w2/S8kMBnbBrdzoWn+67lkFI9+mY6yqTo9QZVhxz7caGIWv
         huJg7mDG4M/t5l+6KWEqiIh81O95qXtxk7UElb8wV8s0LmZ/x1xSnhyp361WOzle4MVx
         yfWZVDeFO9GQP6eI91U9xh7sI8qNz1PopQwA+AIYojQc4Vlxo3fn9zcLsDcKqOauFjgQ
         ToLw==
X-Gm-Message-State: AOAM531UMKt0n5P5FlV+iiMiWeNufaF3WWR8zGfnCuDMbm1uMQ/MP8OU
        wxrAbD9qSjxG25X6MS1Vi17w1qeaxW7GfwkoTLMurdVp43bKpI4vVrQOsHp32M8LqtsrD+01zYC
        /Tvd71O6u3Tjr66PJUcdv9HA/
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr4415242wmc.117.1606745696697;
        Mon, 30 Nov 2020 06:14:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcKrJpx3nrREkeE45HL6YslRFXos8EHDtmO3OikwsemUZ2+z0sSoboa+Itjc1V17186xvQOg==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr4415222wmc.117.1606745696434;
        Mon, 30 Nov 2020 06:14:56 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id q16sm29246641wrn.13.2020.11.30.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:14:55 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:14:53 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 12/17] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
Message-ID: <20201130141453.jobe76loyfy4qrdw@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-13-sgarzare@redhat.com>
 <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:25:31AM +0800, Jason Wang wrote:
>
>On 2020/11/26 下午10:49, Stefano Garzarella wrote:
>>The get_config callback can be used by the device to fill the
>>config structure.
>>The callback will be invoked in vdpasim_get_config() before copying
>>bytes into caller buffer.
>>
>>Move vDPA-net config updates from vdpasim_set_features() in the
>>new vdpasim_net_get_config() callback.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 33 +++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>index c07ddf6af720..8b87ce0485b6 100644
>>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>@@ -58,6 +58,8 @@ struct vdpasim_virtqueue {
>>  #define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
>>  				 (1ULL << VIRTIO_NET_F_MAC))
>>+struct vdpasim;
>>+
>>  struct vdpasim_dev_attr {
>>  	u64 supported_features;
>>  	size_t config_size;
>>@@ -65,6 +67,7 @@ struct vdpasim_dev_attr {
>>  	u32 id;
>>  	work_func_t work_fn;
>>+	void (*get_config)(struct vdpasim *vdpasim, void *config);
>>  };
>>  /* State of each vdpasim device */
>>@@ -520,8 +523,6 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>>  static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>-	struct virtio_net_config *config =
>>-		(struct virtio_net_config *)vdpasim->config;
>>  	/* DMA mapping must be done by driver */
>>  	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>>@@ -529,15 +530,6 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>  	vdpasim->features = features & vdpasim->dev_attr.supported_features;
>>-	/* We generally only know whether guest is using the legacy interface
>>-	 * here, so generally that's the earliest we can set config fields.
>>-	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
>>-	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
>>-	 */
>>-
>>-	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>>-	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>>-	memcpy(config->mac, macaddr_buf, ETH_ALEN);
>>  	return 0;
>>  }
>>@@ -593,8 +585,12 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>-	if (offset + len < vdpasim->dev_attr.config_size)
>>-		memcpy(buf, vdpasim->config + offset, len);
>>+	if (offset + len > vdpasim->dev_attr.config_size)
>>+		return;
>>+
>>+	vdpasim->dev_attr.get_config(vdpasim, vdpasim->config);
>>+
>>+	memcpy(buf, vdpasim->config + offset, len);
>>  }
>
>
>I wonder how much value we can get from vdpasim->config consider we've 
>already had get_config() method.
>
>Is it possible to copy to the buffer directly here?

I had thought of eliminating it too, but then I wanted to do something 
similar to what we do in QEMU (hw/virtio/virtio.c), leaving in the 
simulator core the buffer, the memory copy (handling offset and len), 
and the boundary checks.

In this way each device should simply fill the entire configuration and 
we can avoid code duplication.

Storing the configuration in the core may also be useful if some device 
needs to support config writes.

Do you think it makes sense, or is it better to move everything in the 
device?

Thanks,
Stefano

