Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64C2D3587
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgLHVql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:46:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgLHVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607463913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+efrBz8AmXzGUD15XyQRufBjSK+9yNQ71jf2nuJyarI=;
        b=BI210s679FMc+mNO/1OtYor4b29rrx9Tb2MkB04aUQ1zb+tFrmKid/sZTS4LUiSNwjjjBr
        /l9XrzwEm1Thl/A7DWc/rd6NxrsTJ1eeYXWpEU3gt7+Shjfn7dNYUQmykrDZxvX55pGVDC
        sk+ZaNS1kSSFEgyAsrsJzkU4Iolm4wY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-H1KRSczlM5uRerJ57jIJkQ-1; Tue, 08 Dec 2020 16:45:11 -0500
X-MC-Unique: H1KRSczlM5uRerJ57jIJkQ-1
Received: by mail-wr1-f72.google.com with SMTP id r8so4533904wro.22
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+efrBz8AmXzGUD15XyQRufBjSK+9yNQ71jf2nuJyarI=;
        b=RtfGG8VgT+QU25TOIV1Vs9qW1Y/xpQnAvm0GEde79oa6UW3X1kP3V64aqwg0YY/xNk
         kTm1OqyKhmPxwm6Cltwjc9DCya3I7y1a8sGW2HF/emmmmqUHOCqKzVEAoiY0jxlUetAw
         5YUs8DpfEW6GaheC9WN0SXwCKJa115lmG8YkyVqy5ozsUJo2VNVOMTT/NxQL/eEjDYQa
         l8jSmJD2WCQOMLOJZk2Ju1eDcIvaytySc2TAMUndzFDV/COuy/DWw4duJPK9UV1wxa5d
         dFdvYhaiqs2SECGwmc3+zuH7Rsa3BBhtcauCQv2Y6YZRoO7lrxEIlOZVDcIfqlLguxZV
         mEHA==
X-Gm-Message-State: AOAM5332SwZj9N5u5hfuj4sYSKCWpu3qDrYNDb6xe2xE3gwU84aAECTl
        dI2Oj+uw4NQK1xEEpm/TrqNuhGMK0ms/XYu7XhMngtx2+11g9jr1Ep7JCYR6X5hYzVTM+KFRDWV
        hQLTONqNmOMHoQt0jO2MDBWCc
X-Received: by 2002:a5d:6902:: with SMTP id t2mr104773wru.214.1607463908413;
        Tue, 08 Dec 2020 13:45:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXGvbxAcbO5BFwkDYJ7jC95TKxqn9gNikXqZCE7BFMQOriT1WGuoUMulzEYkt3Yx0aZc7tWA==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr104763wru.214.1607463908279;
        Tue, 08 Dec 2020 13:45:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id n17sm99784wmc.33.2020.12.08.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:45:07 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:45:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201208164356-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206105719.123753-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> Make sure to put write memory barrier after updating CQ consumer index
> so the hardware knows that there are available CQE slots in the queue.
> 
> Failure to do this can cause the update of the RX doorbell record to get
> updated before the CQ consumer index resulting in CQ overrun.
> 
> Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Aren't both memory writes? And given that, isn't dma_wmb() sufficient
here?


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1f4089c6f9d7..295f46eea2a5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
>  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
>  {
>  	mlx5_cq_set_ci(&mvq->cq.mcq);
> +
> +	/* make sure CQ cosumer update is visible to the hardware before updating
> +	 * RX doorbell record.
> +	 */
> +	wmb();
>  	rx_post(&mvq->vqqp, num);
>  	if (mvq->event_cb.callback)
>  		mvq->event_cb.callback(mvq->event_cb.private);
> -- 
> 2.27.0

