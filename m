Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E104F2D3CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgLIIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:07:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgLIIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607501148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8XGWI5wSao3/PxGjyLqO/yukXOyTn0nluQXLKuxJ7t0=;
        b=WVM/4Cyx19l7YERcgxnpdzrWNc1yMcbiqyLOwi2NKtI9/R2yIaWmXhBpRCqMQJMq4N0ys7
        qjTneYnKdZZQdFxVU0sHv42U4kfpflB15z3L47C0UjhnEPbfoetdfcjpQgsFSeKdPHBFZM
        WSbjGhu4vyl3oFManpsR+zzC31rb8DY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-j_yWmRSlNCSoRiEt4W0fWw-1; Wed, 09 Dec 2020 03:05:47 -0500
X-MC-Unique: j_yWmRSlNCSoRiEt4W0fWw-1
Received: by mail-wm1-f70.google.com with SMTP id 4so79072wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 00:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8XGWI5wSao3/PxGjyLqO/yukXOyTn0nluQXLKuxJ7t0=;
        b=ZTgbPR8hkBcZKzhMGjgYFLW834hsISpPuVbDslmU+FF4vPklr8mNpERaEmBhZfvvUn
         R+HqaW1H7VnZUmad1qjI+hZ1R9VO3kStRUIpOcZMr+4D5QVkRMGP6uaMPZRiTgSjIzh5
         v4yd8ITBeaR/sUDnZPAQ6MPK3Jyz6R6OjFt9YTfCmr1MkfEl0AoZN4JlJ2/WU6oRhnbq
         GW2DtwKSOjfrYsLNP2UYNnjBn821k140WwD8VdcM2E+ugaYSeZGElh9TTqE93YrCRi3A
         4uwvkLRxUBQ5lYiF//DfwxUW2vKzppwJ5YTJaGmVSZyLYG3KND+lnJzY3kJFnGFpfeSE
         lF0g==
X-Gm-Message-State: AOAM531jZJtCulU3IlSGtVNPZQpDNALMRge/SCvjlFVG6Bdlb1w91qX1
        nn8v+o/XS8XpOg3hTqGweESsKv+0fRhcMJg7bQ9oQIIuHIseE9jaIS+/9ad5v69bnD1gChI/FXc
        dfmYU5lF1gNu6dugg65Emw5ZK
X-Received: by 2002:adf:e80d:: with SMTP id o13mr1187769wrm.293.1607501145705;
        Wed, 09 Dec 2020 00:05:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJIAu1vWBA+r2wX4ZJfAzo706Nz5I/D16aUvlbJX00UPorHTDuUbdtBWsTwD92l77bMHDKBA==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr1187741wrm.293.1607501145512;
        Wed, 09 Dec 2020 00:05:45 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id e17sm1564481wrw.84.2020.12.09.00.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:05:44 -0800 (PST)
Date:   Wed, 9 Dec 2020 03:05:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209025712-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
 <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
 <20201209014547-mutt-send-email-mst@kernel.org>
 <20201209065846.GA59515@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209065846.GA59515@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:58:46AM +0200, Eli Cohen wrote:
> On Wed, Dec 09, 2020 at 01:46:22AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 09, 2020 at 08:02:30AM +0200, Eli Cohen wrote:
> > > On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> > > > On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > > > > Make sure to put write memory barrier after updating CQ consumer index
> > > > > so the hardware knows that there are available CQE slots in the queue.
> > > > > 
> > > > > Failure to do this can cause the update of the RX doorbell record to get
> > > > > updated before the CQ consumer index resulting in CQ overrun.
> > > > > 
> > > > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > 
> > > > Aren't both memory writes?
> > > 
> > > Not sure what exactly you mean here.
> > 
> > Both updates are CPU writes into RAM that hardware then reads
> > using DMA.
> > 
> 
> You mean why I did not put a memory barrier right after updating the
> recieve doorbell record?

Sorry about being unclear.  I just tried to give justification for why
dma_wmb seems more appropriate than wmb here. If you need to
order memory writes wrt writes to card, that is different, but generally
writeX and friends will handle the ordering for you, except when
using relaxed memory mappings - then wmb is generally necessary.

> I thought about this and I think it is not required. Suppose it takes a
> very long time till the hardware can actually see this update. The worst
> effect would be that the hardware will drop received packets if it does
> sees none available due to the delayed update. Eventually it will see
> the update and will continue working.
> 
> If I put a memory barrier, I put some delay waiting for the CPU to flush
> the write before continuing. I tried both options while checking packet
> rate on couldn't see noticable difference in either case.


makes sense.

> > > > And given that, isn't dma_wmb() sufficient here?
> > > 
> > > I agree that dma_wmb() is more appropriate here.
> > > 
> > > > 
> > > > 
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > > > >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > > > >  {
> > > > >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > > > +
> > > > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > > > +	 * RX doorbell record.
> > > > > +	 */
> > > > > +	wmb();
> > > > >  	rx_post(&mvq->vqqp, num);
> > > > >  	if (mvq->event_cb.callback)
> > > > >  		mvq->event_cb.callback(mvq->event_cb.private);
> > > > > -- 
> > > > > 2.27.0
> > > > 
> > 

