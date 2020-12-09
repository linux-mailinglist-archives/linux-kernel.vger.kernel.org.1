Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5478F2D3BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgLIG7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:59:48 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12938 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgLIG7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:59:33 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd075ad0000>; Tue, 08 Dec 2020 22:58:53 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 06:58:51 +0000
Date:   Wed, 9 Dec 2020 08:58:46 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209065846.GA59515@mtl-vdi-166.wap.labs.mlnx>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
 <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
 <20201209014547-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201209014547-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607497133; bh=MOtJy7h9i4wRW/N9OU9qcgWzzEZ8HM0BXeRnfJ2Visc=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=C2ps42EYwXfKooOWeiiBSiNDAJqypZn8Azb4IXvA4JhF2uPVHj6mgAY2v7eYuXG1o
         U3BnkZKCpNip8qoZlOxdr5qmftKTb3DiDyiSjNqbH+TZ7FJPzNhVhib/P6che8AL5t
         s6l78+qsub8NrbIiTmpdqn1IwbrGcISZh8HQCZVsQBjp2bqu0vt+xrakGAgLN4dUwm
         CEL+mB0rp0SBjcdn964hIomg5l4kS2wtVwBLsVjmSSKxTqtfdH51picRMJETbHKtSW
         dngCymYH8YFk4dgAVjRB5gcyQA94eV6qkYbAAQBkWKMm0VqN/dsmTL+maENAUEurys
         vE/HPVI2zsweQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 01:46:22AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 09, 2020 at 08:02:30AM +0200, Eli Cohen wrote:
> > On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> > > On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > > > Make sure to put write memory barrier after updating CQ consumer index
> > > > so the hardware knows that there are available CQE slots in the queue.
> > > > 
> > > > Failure to do this can cause the update of the RX doorbell record to get
> > > > updated before the CQ consumer index resulting in CQ overrun.
> > > > 
> > > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > 
> > > Aren't both memory writes?
> > 
> > Not sure what exactly you mean here.
> 
> Both updates are CPU writes into RAM that hardware then reads
> using DMA.
> 

You mean why I did not put a memory barrier right after updating the
recieve doorbell record?

I thought about this and I think it is not required. Suppose it takes a
very long time till the hardware can actually see this update. The worst
effect would be that the hardware will drop received packets if it does
sees none available due to the delayed update. Eventually it will see
the update and will continue working.

If I put a memory barrier, I put some delay waiting for the CPU to flush
the write before continuing. I tried both options while checking packet
rate on couldn't see noticable difference in either case.

> > > And given that, isn't dma_wmb() sufficient here?
> > 
> > I agree that dma_wmb() is more appropriate here.
> > 
> > > 
> > > 
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > > >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > > >  {
> > > >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > > +
> > > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > > +	 * RX doorbell record.
> > > > +	 */
> > > > +	wmb();
> > > >  	rx_post(&mvq->vqqp, num);
> > > >  	if (mvq->event_cb.callback)
> > > >  		mvq->event_cb.callback(mvq->event_cb.private);
> > > > -- 
> > > > 2.27.0
> > > 
> 
