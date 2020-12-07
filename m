Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407C82D0A37
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgLGFbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 00:31:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLGFbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607319021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLCSsW2WyIt+KlApOoAFf7MXLlpWsBt0oMrOXDYlAl8=;
        b=dv3adhlC/jzYPkDICH5TcP/ON4Z/rcBzS6QFTR/KdWUhoc3gXOv4iy2+R34fb5S8Ak+SrD
        Q6YFxBqs+/tRZA0pvBMUBAfk23IIMa3mLf7wbNnPgPLCG/WoS8ZtOi9UH1oL4BU+XtClIc
        3ITk3+gP4ZBABzOzDZzdJyshmqeTN80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-ntKxMNUnNEeKEVNGn6I3XA-1; Mon, 07 Dec 2020 00:30:19 -0500
X-MC-Unique: ntKxMNUnNEeKEVNGn6I3XA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E73100C600;
        Mon,  7 Dec 2020 05:30:18 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6E0C60BE2;
        Mon,  7 Dec 2020 05:30:06 +0000 (UTC)
Subject: Re: [PATCH v3 14/19] vdpa_sim: add set_config callback in
 vdpasim_dev_attr
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-15-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d3bc9f2f-52c2-b770-40ff-76a31209c967@redhat.com>
Date:   Mon, 7 Dec 2020 13:30:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-15-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 上午1:05, Stefano Garzarella wrote:
> The set_config callback can be used by the device to parse the
> config structure modified by the driver.
>
> The callback will be invoked, if set, in vdpasim_set_config() after
> copying bytes from caller buffer into vdpasim->config buffer.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index f935ade0806b..03a8717f80ea 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -70,6 +70,7 @@ struct vdpasim_dev_attr {
>   
>   	work_func_t work_fn;
>   	void (*get_config)(struct vdpasim *vdpasim, void *config);
> +	void (*set_config)(struct vdpasim *vdpasim, const void *config);
>   };
>   
>   /* State of each vdpasim device */
> @@ -598,7 +599,15 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>   static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
>   			     const void *buf, unsigned int len)
>   {
> -	/* No writable config supportted by vdpasim */
> +	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +
> +	if (offset + len > vdpasim->dev_attr.config_size)
> +		return;
> +
> +	memcpy(vdpasim->config + offset, buf, len);
> +
> +	if (vdpasim->dev_attr.set_config)
> +		vdpasim->dev_attr.set_config(vdpasim, vdpasim->config);
>   }
>   
>   static u32 vdpasim_get_generation(struct vdpa_device *vdpa)

