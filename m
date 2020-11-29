Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A646A2C7B19
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 21:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgK2UJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 15:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727695AbgK2UJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 15:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606680509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxI+akPL+TVvqGXQqCSO9a4+uClCIKdg0MUm21BHJok=;
        b=fWVt2NsAHcLuzsadOASqsYvAmXmTPltVxpvhyU6ozjAa/7gUDL1bj3V90yofo4AIIWdrua
        DXSQCZHE4E+CuOjQIOHwaOzemu6GnZPR09YKuzGmCaTWPS6UQ9hY5OaDzEZiRLmwio8TBx
        EMXgMCVC0feLxSNChrZZ9rhzuYpGV4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-CIB60TtIPPOVr8v9PUMeEA-1; Sun, 29 Nov 2020 15:08:27 -0500
X-MC-Unique: CIB60TtIPPOVr8v9PUMeEA-1
Received: by mail-wr1-f70.google.com with SMTP id w17so7076036wrp.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 12:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxI+akPL+TVvqGXQqCSO9a4+uClCIKdg0MUm21BHJok=;
        b=OLCG/hcMfS2jPlBJUl2B58Z/GRltCSQnNRvqIW+wlHDWGanzf0exNJ9oJDqdPwEe5I
         9K2lt3HdqCGokihyek6zM+Vfk6VNx8MdUyCudcMA8HMiSQbaLuSRGfJxTl/jn3jpv2pz
         WIHNBc/mS9TM6zmvtoM+S59xM8aYoNnNulVElUzES6l04m4krFF5j5WAEbjt0jB3fbhv
         SOG95BPvVdxfcJ+uUOqzQiKXu0tOi9z3g4UWxrm8MSE03udHUNHs4RNsW84sVStOpcYF
         BlA46IxtBpQhuA0RMNYgjU3Cxebh2VZLYjQ8EbnbeqNWbI+71GbhOpkJresGIjF9b704
         FIvA==
X-Gm-Message-State: AOAM530a9pE+nR3Vv/mk1nv6uiLqqpPSvQPJ8zZiuwlXyHkT8VHLM6wy
        TbHQXVSTYmUSYsVRU9lZ7iguuO//XOVN5ExQ0WAjQsvW5jV64OA12Gftwc3iTrvvKpmY1ldhdiU
        PsP6PBpdq7AuP3iBTvuw94d5M
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr24089357wrq.52.1606680506281;
        Sun, 29 Nov 2020 12:08:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4Zj8VIghM/MlJoqfcfMhVOHFZnrUyaoXQhAaYqwHPALiKJBGd4W7o8bomBMGnHNhTo+rlKg==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr24089338wrq.52.1606680506079;
        Sun, 29 Nov 2020 12:08:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id 34sm24064412wrh.78.2020.11.29.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 12:08:25 -0800 (PST)
Date:   Sun, 29 Nov 2020 15:08:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201129150505-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129064351.63618-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> We should not try to use the VF MAC address as that is used by the
> regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> generated MAC address.
> 
> Suggested by: Cindy Lu <lulu@redhat.com>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

I didn't realise it's possible to use VF in two ways
with and without vdpa.
Could you include a bit more description on the failure
mode?
Is switching to a random mac for such an unusual
configuration really justified?
It looks like changing a MAC could break some guests,
can it not?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1fa6fcac8299..80d06d958b8b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
>  	if (err)
>  		goto err_mtu;
>  
> -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> -	if (err)
> -		goto err_mtu;
> -
> +	eth_random_addr(config->mac);
>  	mvdev->vdev.dma_dev = mdev->device;
>  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>  	if (err)
> -- 
> 2.26.2

