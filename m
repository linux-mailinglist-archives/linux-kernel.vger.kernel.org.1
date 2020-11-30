Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24342C7D23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgK3DJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbgK3DJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606705695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clkfvuFNq2hdJY744R66AkCZTfv6bN3GZv0TvqZ3EpY=;
        b=JXVS5jGnqy+3VY/Nh/fxV9W270xQezU22KtGB68kk9Bl/73weVWFBhq0NtB4KJTFRwRL6Z
        wXwljNF25LLT58mOVTQJSvSiEoR2eYJzYGChOxPbLEyU8KReEUgZr9WZkrK2e0XGZD44H7
        hqRW2ecsK3gpeoArlsfh8MkZgQCdCGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-6ZjAUzukNdCXz1y0d7gwmg-1; Sun, 29 Nov 2020 22:08:12 -0500
X-MC-Unique: 6ZjAUzukNdCXz1y0d7gwmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741EA1E7ED;
        Mon, 30 Nov 2020 03:08:11 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EC5D60C4D;
        Mon, 30 Nov 2020 03:07:59 +0000 (UTC)
Subject: Re: [PATCH v2 05/17] vdpa_sim: rename vdpasim_config_ops variables
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-6-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <aa1f23e3-585c-55c1-1529-f17853f13b17@redhat.com>
Date:   Mon, 30 Nov 2020 11:07:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-6-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> These variables stores generic callbacks used by the vDPA simulator
> core, so we can remove the 'net' word in their names.
>
> Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 40664d87f303..62204e064841 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -331,8 +331,8 @@ static const struct dma_map_ops vdpasim_dma_ops = {
>   	.free = vdpasim_free_coherent,
>   };
>   
> -static const struct vdpa_config_ops vdpasim_net_config_ops;
> -static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
> +static const struct vdpa_config_ops vdpasim_config_ops;
> +static const struct vdpa_config_ops vdpasim_batch_config_ops;
>   
>   static struct vdpasim *vdpasim_create(void)
>   {
> @@ -342,9 +342,9 @@ static struct vdpasim *vdpasim_create(void)
>   	int i, ret = -ENOMEM;
>   
>   	if (batch_mapping)
> -		ops = &vdpasim_net_batch_config_ops;
> +		ops = &vdpasim_batch_config_ops;
>   	else
> -		ops = &vdpasim_net_config_ops;
> +		ops = &vdpasim_config_ops;
>   
>   	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
>   	if (!vdpasim)
> @@ -657,7 +657,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>   	kfree(vdpasim->vqs);
>   }
>   
> -static const struct vdpa_config_ops vdpasim_net_config_ops = {
> +static const struct vdpa_config_ops vdpasim_config_ops = {
>   	.set_vq_address         = vdpasim_set_vq_address,
>   	.set_vq_num             = vdpasim_set_vq_num,
>   	.kick_vq                = vdpasim_kick_vq,
> @@ -684,7 +684,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
>   	.free                   = vdpasim_free,
>   };
>   
> -static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
> +static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>   	.set_vq_address         = vdpasim_set_vq_address,
>   	.set_vq_num             = vdpasim_set_vq_num,
>   	.kick_vq                = vdpasim_kick_vq,

