Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B60B2D3B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgLIGDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:03:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19134 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgLIGDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:03:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd0687d0003>; Tue, 08 Dec 2020 22:02:37 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 06:02:35 +0000
Date:   Wed, 9 Dec 2020 08:02:30 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201208164356-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607493757; bh=CPDp5sL2SqKvhZg0mxRiRnuJ0QdXwiHSE4jTazP1OA8=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=E2HAOp86KwUh9tA8J7ATrlKWgvNkwiEHJoxZoJzVkbMivts5jPqfjueHBWrcF1yr3
         7qX/8qZplACyvubWXD93ZhPcbXyBu4lHWGVG6VyPtiTJpzc+Ejz4uZBuRErEEHG6nm
         ZU/2DOROW/CIs6lbN1j07JyuaKtugxv38B3N1P+JFrY4Ly8VTCw3aGh9FFfiR0kDUf
         uPnsToN9PddpqQnWa44Y2RzAxgcd8EspW4Csa7aYL/iCVCLivc5SN5xFgKP5xgxNdV
         cGAJio+sD3XJ1n4Yv7nL34IJF2covzyvq+y42mBjsbW2c2LvzH9cwuygtuaT4bXjrf
         Z7f7GGAn2EGWg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > Make sure to put write memory barrier after updating CQ consumer index
> > so the hardware knows that there are available CQE slots in the queue.
> > 
> > Failure to do this can cause the update of the RX doorbell record to get
> > updated before the CQ consumer index resulting in CQ overrun.
> > 
> > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> 
> Aren't both memory writes?

Not sure what exactly you mean here.

> And given that, isn't dma_wmb() sufficient here?

I agree that dma_wmb() is more appropriate here.

> 
> 
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 1f4089c6f9d7..295f46eea2a5 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> >  {
> >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > +
> > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > +	 * RX doorbell record.
> > +	 */
> > +	wmb();
> >  	rx_post(&mvq->vqqp, num);
> >  	if (mvq->event_cb.callback)
> >  		mvq->event_cb.callback(mvq->event_cb.private);
> > -- 
> > 2.27.0
> 
