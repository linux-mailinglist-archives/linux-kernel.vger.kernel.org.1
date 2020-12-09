Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC32D3EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgLIJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:39:22 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15552 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgLIJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:39:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd09b210001>; Wed, 09 Dec 2020 01:38:41 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 09:38:39 +0000
Date:   Wed, 9 Dec 2020 11:38:36 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209093836.GA62204@mtl-vdi-166.wap.labs.mlnx>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
 <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
 <20201209014547-mutt-send-email-mst@kernel.org>
 <20201209065846.GA59515@mtl-vdi-166.wap.labs.mlnx>
 <20201209025712-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201209025712-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607506721; bh=Z5+c0f4H/JFqW0cesUT+R7QjXdwvYDH7MFyx2zflVVY=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=MBsFEGztIAQ4P97fvFVRaezB7DegQ3S5VRh7/JtpXMA7w/tyviXvT7VDevwQBKWZ3
         rgOXLdSBtrZBjHQk9Bv0q+u1ZS4HU4nrCyhpYYseykP0LK7WFyPSUDQW8XveoC/mwm
         7HwPSiYLtzRYfRCJZsZhzKVtz6tcibIsjadBFVleTf84T7yxbX4IcICuQk9yD15FoD
         93oZ8eYBVwIyZAzQ472LKICaeCrfOMkLJHcctZmJDMOep8/hTDc1HLkCSAXpFgYWcO
         ZbNwbsQVCvnYFFbFobv8aXHHQtPxr2JqNRVog13dfi+9Mgiuhc39ZGnuxNRhwrCibN
         HE6va6U9hyTOA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 03:05:42AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 09, 2020 at 08:58:46AM +0200, Eli Cohen wrote:
> > On Wed, Dec 09, 2020 at 01:46:22AM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Dec 09, 2020 at 08:02:30AM +0200, Eli Cohen wrote:
> > > > On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> > > > > On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > > > > > Make sure to put write memory barrier after updating CQ consumer index
> > > > > > so the hardware knows that there are available CQE slots in the queue.
> > > > > > 
> > > > > > Failure to do this can cause the update of the RX doorbell record to get
> > > > > > updated before the CQ consumer index resulting in CQ overrun.
> > > > > > 
> > > > > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > 
> > > > > Aren't both memory writes?
> > > > 
> > > > Not sure what exactly you mean here.
> > > 
> > > Both updates are CPU writes into RAM that hardware then reads
> > > using DMA.
> > > 
> > 
> > You mean why I did not put a memory barrier right after updating the
> > recieve doorbell record?
> 
> Sorry about being unclear.  I just tried to give justification for why
> dma_wmb seems more appropriate than wmb here. If you need to
> order memory writes wrt writes to card, that is different, but generally
> writeX and friends will handle the ordering for you, except when
> using relaxed memory mappings - then wmb is generally necessary.
> 

Bear in mind, we're writing to memory (not io memory). In this case, we
want this write to be visible my the DMA device.

https://www.kernel.org/doc/Documentation/memory-barriers.txt gives a
similar example using dma_wmb() to flush updates to make them visible
by the hardware before notifying the hardware to come and inspect this
memory.


> > I thought about this and I think it is not required. Suppose it takes a
> > very long time till the hardware can actually see this update. The worst
> > effect would be that the hardware will drop received packets if it does
> > sees none available due to the delayed update. Eventually it will see
> > the update and will continue working.
> > 
> > If I put a memory barrier, I put some delay waiting for the CPU to flush
> > the write before continuing. I tried both options while checking packet
> > rate on couldn't see noticable difference in either case.
> 
> 
> makes sense.
> 
> > > > > And given that, isn't dma_wmb() sufficient here?
> > > > 
> > > > I agree that dma_wmb() is more appropriate here.
> > > > 
> > > > > 
> > > > > 
> > > > > > ---
> > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > > > > >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > > > > >  {
> > > > > >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > > > > +
> > > > > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > > > > +	 * RX doorbell record.
> > > > > > +	 */
> > > > > > +	wmb();
> > > > > >  	rx_post(&mvq->vqqp, num);
> > > > > >  	if (mvq->event_cb.callback)
> > > > > >  		mvq->event_cb.callback(mvq->event_cb.private);
> > > > > > -- 
> > > > > > 2.27.0
> > > > > 
> > > 
> 
