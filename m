Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B800A2D426D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgLIMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731188AbgLIMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607518057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t5/QC77pLL7q6oLDtS15hQa633CfWuWBmAY6OEIwT1U=;
        b=EKpw/R8zYE1vd3a8myzQSv4t0a4TIiGLy2xRLhGEDIYULIE94z3P9Wri+mkuPQsxPVtAtC
        mDpTUm3HRbb5X+JHi0AY7LXORmUelGqe+FfHfRU+Bc99n6A480cutV5tqQvpAtfBAq8Xrx
        6Ys75M7BbNZ1Bp5O3cpGrIACi1XG0CE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-PkbJig8JMsuwmM6-OIeULA-1; Wed, 09 Dec 2020 07:47:35 -0500
X-MC-Unique: PkbJig8JMsuwmM6-OIeULA-1
Received: by mail-wr1-f71.google.com with SMTP id o12so610587wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 04:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t5/QC77pLL7q6oLDtS15hQa633CfWuWBmAY6OEIwT1U=;
        b=f2qc91XyPCzNCZa6pFGhdi4VEAdWUuVhuZoDNytC+ptOV/VIeT95xiJlwL3jb61AFD
         Xiu4gGbAdeqfdTkpuoS1rXlKd0pboMQ7XnuGe570UwzoMmwcYOKaycMWcC7MPp8kLbKt
         ScxoZ5xRrqABZo7r03/sDS/whb6kYcNUWwEOseTf7s1Gj/hNFqr1G3rIrKzQx0A4OSyE
         /z61X4R/9wZ5J4kNYY2IO1bLGZYb2NtyBCcUbCTjAoyQ5OBP9XO2OO/01Z4w5VPMpMSf
         2IDHFbihqlEbnUGOxYHdGnbwhM+mombaB5GOxmApO+/gzewJBYOSmfSC5v0wHw2TiFVQ
         wdlQ==
X-Gm-Message-State: AOAM531Paq35T8BCeKGtgjOmJrj89Sd8c5hLvvBbMYfK0F1t2f/9BsK0
        pAHzPeCR1zPLOzv8gCaxnIXg0q8CGWhOlXp2EoEZX0+M8cm0pncMN1Q7hSr7kPR+qpC5wqhrx4G
        lHRqr9FxNRvANRRw9nybYhuGt
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2676756wml.155.1607518053506;
        Wed, 09 Dec 2020 04:47:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0xGiVf4PphEDlh5fmvmna9OBjQj5phL3O8OvQlmZbwiqsSHc0XXcX9/n8UGHxS+qcdiceqA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2676744wml.155.1607518053325;
        Wed, 09 Dec 2020 04:47:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id d187sm3476873wmd.8.2020.12.09.04.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 04:47:32 -0800 (PST)
Date:   Wed, 9 Dec 2020 07:47:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209074703-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
 <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
 <20201209014547-mutt-send-email-mst@kernel.org>
 <20201209065846.GA59515@mtl-vdi-166.wap.labs.mlnx>
 <20201209025712-mutt-send-email-mst@kernel.org>
 <20201209093836.GA62204@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209093836.GA62204@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:38:36AM +0200, Eli Cohen wrote:
> On Wed, Dec 09, 2020 at 03:05:42AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 09, 2020 at 08:58:46AM +0200, Eli Cohen wrote:
> > > On Wed, Dec 09, 2020 at 01:46:22AM -0500, Michael S. Tsirkin wrote:
> > > > On Wed, Dec 09, 2020 at 08:02:30AM +0200, Eli Cohen wrote:
> > > > > On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> > > > > > On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > > > > > > Make sure to put write memory barrier after updating CQ consumer index
> > > > > > > so the hardware knows that there are available CQE slots in the queue.
> > > > > > > 
> > > > > > > Failure to do this can cause the update of the RX doorbell record to get
> > > > > > > updated before the CQ consumer index resulting in CQ overrun.
> > > > > > > 
> > > > > > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > 
> > > > > > Aren't both memory writes?
> > > > > 
> > > > > Not sure what exactly you mean here.
> > > > 
> > > > Both updates are CPU writes into RAM that hardware then reads
> > > > using DMA.
> > > > 
> > > 
> > > You mean why I did not put a memory barrier right after updating the
> > > recieve doorbell record?
> > 
> > Sorry about being unclear.  I just tried to give justification for why
> > dma_wmb seems more appropriate than wmb here. If you need to
> > order memory writes wrt writes to card, that is different, but generally
> > writeX and friends will handle the ordering for you, except when
> > using relaxed memory mappings - then wmb is generally necessary.
> > 
> 
> Bear in mind, we're writing to memory (not io memory). In this case, we
> want this write to be visible my the DMA device.
> 
> https://www.kernel.org/doc/Documentation/memory-barriers.txt gives a
> similar example using dma_wmb() to flush updates to make them visible
> by the hardware before notifying the hardware to come and inspect this
> memory.

Exactly.

> 
> > > I thought about this and I think it is not required. Suppose it takes a
> > > very long time till the hardware can actually see this update. The worst
> > > effect would be that the hardware will drop received packets if it does
> > > sees none available due to the delayed update. Eventually it will see
> > > the update and will continue working.
> > > 
> > > If I put a memory barrier, I put some delay waiting for the CPU to flush
> > > the write before continuing. I tried both options while checking packet
> > > rate on couldn't see noticable difference in either case.
> > 
> > 
> > makes sense.
> > 
> > > > > > And given that, isn't dma_wmb() sufficient here?
> > > > > 
> > > > > I agree that dma_wmb() is more appropriate here.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > > > > > >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > > > > > >  {
> > > > > > >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > > > > > +
> > > > > > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > > > > > +	 * RX doorbell record.
> > > > > > > +	 */
> > > > > > > +	wmb();
> > > > > > >  	rx_post(&mvq->vqqp, num);
> > > > > > >  	if (mvq->event_cb.callback)
> > > > > > >  		mvq->event_cb.callback(mvq->event_cb.private);
> > > > > > > -- 
> > > > > > > 2.27.0
> > > > > > 
> > > > 
> > 

