Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8342B3C10
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgKPESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKPESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605500312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTd99pYLjkoSdfa6jBaQQPlI7Y9KTeBcUMLVgsiGWEo=;
        b=GQnO5sR95yhCCQogM7n4dl1h/yld6WfGMKepegW9JEX8+FjIfFXbqYuRC2mFmkHVn+W7ya
        /0gHa/N+/kcPoXbfPP81KLVTM/RyVzpAkZpe+qyUSb3yGC5hyAH67E831igMj0vIGUpBJq
        NLmz9YIjxmGL1kRFR14EJtuncunjFnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-JSAuC__3Nue-2LvjnMZ9HA-1; Sun, 15 Nov 2020 23:18:30 -0500
X-MC-Unique: JSAuC__3Nue-2LvjnMZ9HA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A134E8030A0;
        Mon, 16 Nov 2020 04:18:29 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA90D1002C10;
        Mon, 16 Nov 2020 04:18:20 +0000 (UTC)
Subject: Re: [PATCH RFC 07/12] vdpa_sim: move config management outside of the
 core
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-8-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6ee3e73b-257a-3c02-db32-e890cfacae64@redhat.com>
Date:   Mon, 16 Nov 2020 12:18:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-8-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> In order to simplify the code of the vdpa_sim core, we move the
> config management in each device simulator.
>
> The device must provide the size of config structure and a callback
> to update this structure called during the vdpasim_set_features().


Similarly, I suggest to do this before patch 2, then there's no need for 
the conversion of blk device.


>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.h     |  5 +++--
>   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 29 +++++-----------------------
>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 27 ++++++++++++++++----------
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 12 ++++++++++++
>   4 files changed, 37 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 76e642042eb0..f7e1fe0a88d3 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -10,8 +10,6 @@
>   #include <linux/vdpa.h>
>   #include <linux/vhost_iotlb.h>
>   #include <uapi/linux/virtio_config.h>
> -#include <uapi/linux/virtio_net.h>
> -#include <uapi/linux/virtio_blk.h>
>   
>   #define DRV_VERSION  "0.1"
>   #define DRV_AUTHOR   "Jason Wang <jasowang@redhat.com>"
> @@ -42,8 +40,11 @@ struct vdpasim_virtqueue {
>   
>   struct vdpasim_device {
>   	u64 supported_features;
> +	size_t config_size;
>   	u32 id;
>   	int nvqs;
> +
> +	void (*update_config)(struct vdpasim *vdpasim);


Let's use set_config/get_config to align with virtio/vhost.

Other looks good.

Thanks


