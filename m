Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2AD2D3BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgLIGsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:48:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgLIGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607496390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWegwtDJ2omVRz2Kp6FHFNujjEo+eYTsjLuIyLZ+Tmg=;
        b=RrKhhwk2BZZKdUur+g/oi6un9ZRdnfcEzLso7rP8hOE2eAU4Wvp9GHWBbB3vEXc1fbr1B8
        Fw9mc7MoVRHGeiJ4wQq2oYMHoKpcaRfdSiuu2IaaDGbfozOOo6SDrX0GdJwIcXLdlmnNM/
        TB7a+IONKavJzmchVKXENSpu9eO6EvY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-4_03uNudNxaAPWNcjxvmCA-1; Wed, 09 Dec 2020 01:46:28 -0500
X-MC-Unique: 4_03uNudNxaAPWNcjxvmCA-1
Received: by mail-wm1-f70.google.com with SMTP id a205so36325wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 22:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JWegwtDJ2omVRz2Kp6FHFNujjEo+eYTsjLuIyLZ+Tmg=;
        b=i3uO3GngmzHYrA7NRkF9SVk5HQNGyYeZu6n+qIueeD15smBnq/3Cay/Sx7rS+pVfx7
         /KgRteIn/oD9tSm+60c9hXuDEzwbenvlO42N2SYBjaW8eTrBi80fjr47ZdGkw7bgSsVg
         rQ/d9rxx1tFJZGumOCa/To9JiSeik3UxEWiVqfqhsFXNmKhqTh90F8cdDOF8w15q4LFW
         7GKtSZm9t4oIqYak34/0Y6AcI1mgVX92RTFFTJSzkQ4l/KVwOZYa4pLRExyUqYVGlX38
         3uBxUTrQ8CLabeU5HEwKUkYbfUyBDQOqoJ+WR/jdAcz4J56Yc56zPgos31swiinmVCON
         2Exg==
X-Gm-Message-State: AOAM5318tmDSd1chSZQaowSNn+gr3aIqCpWjvDU+Ov4xmX/v+rKGIyip
        jEbLRf3NIZ0dReKlnnUc5MVPcI6GY5MxLfMudRq5LTScxu333atONwiR5cYWvFXGHq/4eQPFPZq
        IQRRhE584bf0FGcwtxFOl28i1
X-Received: by 2002:a5d:4d88:: with SMTP id b8mr903705wru.134.1607496387253;
        Tue, 08 Dec 2020 22:46:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnALlGGbRyalUyQiiAMD7PPni/fY1a6aRhLxMF3Q+mP8mccZfLMhdqrEwUXVX4ohHXuNvquQ==
X-Received: by 2002:a5d:4d88:: with SMTP id b8mr903690wru.134.1607496387039;
        Tue, 08 Dec 2020 22:46:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id j13sm1379338wmi.36.2020.12.08.22.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 22:46:25 -0800 (PST)
Date:   Wed, 9 Dec 2020 01:46:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209014547-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
 <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:02:30AM +0200, Eli Cohen wrote:
> On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > > Make sure to put write memory barrier after updating CQ consumer index
> > > so the hardware knows that there are available CQE slots in the queue.
> > > 
> > > Failure to do this can cause the update of the RX doorbell record to get
> > > updated before the CQ consumer index resulting in CQ overrun.
> > > 
> > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > Aren't both memory writes?
> 
> Not sure what exactly you mean here.

Both updates are CPU writes into RAM that hardware then reads
using DMA.

> > And given that, isn't dma_wmb() sufficient here?
> 
> I agree that dma_wmb() is more appropriate here.
> 
> > 
> > 
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > >  {
> > >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > +
> > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > +	 * RX doorbell record.
> > > +	 */
> > > +	wmb();
> > >  	rx_post(&mvq->vqqp, num);
> > >  	if (mvq->event_cb.callback)
> > >  		mvq->event_cb.callback(mvq->event_cb.private);
> > > -- 
> > > 2.27.0
> > 

