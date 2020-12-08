Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766D02D2C49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgLHNyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:54:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgLHNyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607435590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgttXohI58ly0IwuQFIF9zckHLyniRrGoi9yyh9birA=;
        b=bwaG4jQwmx5q7JcYFm99CUk1Ro7NoswyOfiHeeBCf+dfRRvsXx/yrqgx++kJ8ngIbmlNI3
        AtFkAJXYGrkma6GYARCEY3O+/E9LtcBPPJQiToi8gJ2/bL09z3PekX/Ny5rc1xSUbim5q7
        K3pYoACryn3vz4vvwFGo9xnk/r2p014=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-P0-ZKwkZPaaVRvLRzH6Q2A-1; Tue, 08 Dec 2020 08:53:08 -0500
X-MC-Unique: P0-ZKwkZPaaVRvLRzH6Q2A-1
Received: by mail-wr1-f69.google.com with SMTP id v1so6198757wri.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 05:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xgttXohI58ly0IwuQFIF9zckHLyniRrGoi9yyh9birA=;
        b=rZqn1roYZoa4SNN1HRbI3qmxfWMb61N4NaCklE7otJxotiJj3NWtaBPhyjs/0xIgqq
         0nWkpCvpvs0sRZ+PgY0R+eDOH6/tOuV57aN38+CBhebtNhGNXmwtY2/eIh+12nw1WZWg
         d2GUdUgsZcKrKVpP1of61BSzwnycOvbfh7H006wndFMSKErSs/F+xdmyFt2K7LhZ1H4l
         zctz/oxiLLmoZYbHqk0P8yQ7UdbYHae1WP/wuGQq+qkA9YjhsRIqx9JHC5S9bEw8LvrG
         5kfBie7+CupefPdctqXbexTV8ZaxC6U1lbldTix0RnC7Xpi5DD4Bo6YrvLv4LQb+FWzm
         FpMw==
X-Gm-Message-State: AOAM533ErG1SgvdKsle4ZTQEODCGMMXjcl2okX1IXfKzY1Kxnra8NZ9S
        9Fa2104BQBNgw3y6OHX7MVYvmHI3SBzZ79WL9j4KpRO2d++Q8VeBmmU4vHIxT3CPii6B2d8r9xB
        3SnBh5URodYYMYsEgNqpe8KSi
X-Received: by 2002:adf:d082:: with SMTP id y2mr25455648wrh.301.1607435587160;
        Tue, 08 Dec 2020 05:53:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAfIXTZJCRf/Q3bbTBapHs82MJ7TFf6yBgLCgiqWbVjBm2eGDCt/dMwlmmDGlBu3CRVjaXDg==
X-Received: by 2002:adf:d082:: with SMTP id y2mr25455634wrh.301.1607435586953;
        Tue, 08 Dec 2020 05:53:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id n189sm3573019wmf.20.2020.12.08.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 05:53:05 -0800 (PST)
Date:   Tue, 8 Dec 2020 08:53:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201208085255-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
 <dd7cde10-2e75-1bd3-68ad-f4988274b37d@redhat.com>
 <20201208091500.GA17763@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208091500.GA17763@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:15:00AM +0200, Eli Cohen wrote:
> On Mon, Dec 07, 2020 at 10:51:44AM +0800, Jason Wang wrote:
> > 
> > On 2020/12/6 下午6:57, Eli Cohen wrote:
> > > Make sure to put write memory barrier after updating CQ consumer index
> > > so the hardware knows that there are available CQE slots in the queue.
> > > 
> > > Failure to do this can cause the update of the RX doorbell record to get
> > > updated before the CQ consumer index resulting in CQ overrun.
> > > 
> > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> 
> Michael, I left this gerrit ID by mistake. Can you remove it before
> merging?

No problem.

> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > >   static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > >   {
> > >   	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > +
> > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > +	 * RX doorbell record.
> > > +	 */
> > > +	wmb();
> > >   	rx_post(&mvq->vqqp, num);
> > >   	if (mvq->event_cb.callback)
> > >   		mvq->event_cb.callback(mvq->event_cb.private);
> > 
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > 

