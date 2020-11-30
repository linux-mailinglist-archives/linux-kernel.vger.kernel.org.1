Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18F92C811D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgK3Jeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbgK3Jep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606728798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7wZtjSzGIaF/U+jd9vQGVbaZpJMrOBssW+kZUbY0C4=;
        b=U1kXFQSvw9nxNBHLfGfC833Hqydtj/8pspR3J8iUQULr7kYFBVspkVt6uQwsq6f+mLuBGn
        JidBbl6QU+HsUG9HZHrS+mktwxBsQNR1zCKr3wkUN7wGGRorD/MHVMQuW1DOJWO9dJyxNM
        Qp1mOAHrt49lpAl0+2cqyREQAbBJQkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-gjWxiQtiPb-kvUzH-C-gsA-1; Mon, 30 Nov 2020 04:33:14 -0500
X-MC-Unique: gjWxiQtiPb-kvUzH-C-gsA-1
Received: by mail-wr1-f70.google.com with SMTP id 91so8070297wrk.17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H7wZtjSzGIaF/U+jd9vQGVbaZpJMrOBssW+kZUbY0C4=;
        b=mDInxWp+/sRihf9CIeh/+3DSVeNXnM6kw4tTW6CZ57cwxpIPrXhx3X78i338ngqDRp
         wwlcELfMD3AY3aEDQuztCz7wwUy59gz+R8C8jnaaHHdii6IWiHxhM3DaSFByheDd4/HC
         ItUnGjku4+1YCOmvnO2QdL+drQsrfRp58HsRxXNR8sC+2KWNbYbKLKpPogwR37dRhamd
         o9DEb8RalZjg8jAL4flPrAamiOaeFTxe9Xt4Lw3OWJf8Ey4APPSi7wmdg26sK8JS+ydh
         f5BvpoiBvcQ5qnsubj6i7nAnIlcuHI3ffQe+TDNjlU8K9sBVv279V4c0Z/Cy8lOn6aXM
         A7ZQ==
X-Gm-Message-State: AOAM533kZEWkh3oexom2TvIVXRxczoe6ecyQANhhpJGstmEyk/C8NOD0
        swhwO7DDY7G41lpDAzmMKD4vwQMSbxMseYCvplyW+68r25pmi+qa6y3G9UmVf5IA8VRhOPJDeH4
        EJXt2h7iww2+EUTzoKhxwV+yh
X-Received: by 2002:adf:8143:: with SMTP id 61mr26745546wrm.318.1606728793268;
        Mon, 30 Nov 2020 01:33:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0t6u/3wURWn9N8zkZPiZ95gKJucC/wG875k/KAanJvg4ucGYRlB4rSPrqcgd1Ly+7PQX3lg==
X-Received: by 2002:adf:8143:: with SMTP id 61mr26745520wrm.318.1606728793106;
        Mon, 30 Nov 2020 01:33:13 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id x9sm19438455wru.55.2020.11.30.01.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 01:33:12 -0800 (PST)
Date:   Mon, 30 Nov 2020 04:33:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130043050-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > We should not try to use the VF MAC address as that is used by the
> > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > generated MAC address.
> > > > > 
> > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > 
> > > > I didn't realise it's possible to use VF in two ways
> > > > with and without vdpa.
> > > 
> > > Using a VF you can create quite a few resources, e.g. send queues
> > > recieve queues, virtio_net queues etc. So you can possibly create
> > > several instances of vdpa net devices and nic net devices.
> > > 
> > > > Could you include a bit more description on the failure
> > > > mode?
> > > 
> > > Well, using the MAC address of the nic vport is wrong since that is the
> > > MAC of the regular NIC implementation of mlx5_core.
> > 
> > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > 
> 
> This call is wrong:  mlx5_query_nic_vport_mac_address()
> 
> > > > Is switching to a random mac for such an unusual
> > > > configuration really justified?
> > > 
> > > Since I can't use the NIC's MAC address, I have two options:
> > > 1. To get the MAC address as was chosen by the user administering the
> > >    NIC. This should invoke the set_config callback. Unfortunately this
> > >    is not implemented yet.
> > > 
> > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > >    can always override this random configuration.
> > > 
> > > > It looks like changing a MAC could break some guests,
> > > > can it not?
> > > >
> > > 
> > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > from steering point of view. I will post them here once other patches on
> > > which they depend will be merged.
> > > 
> > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > 
> > Could you be more explicit on the following points:
> > - which configuration is broken ATM (as in, two device have identical
> >   macs? any other issues)?
> 
> The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> It's not breaking anything yet is wrong. The random MAC address setting
> is required for the steering patches.

Okay so I'm not sure the Fixes tag at least is appropriate if it's a
dependency of a new feature.

> > - why won't device MAC change from guest point of view?
> > 
> 
> It's lack of implementation in qemu as far as I know.

Sorry not sure I understand. What's not implemented in QEMU?

> > 
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > >  	if (err)
> > > > >  		goto err_mtu;
> > > > >  
> > > > > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > -	if (err)
> > > > > -		goto err_mtu;
> > > > > -
> > > > > +	eth_random_addr(config->mac);
> > > > >  	mvdev->vdev.dma_dev = mdev->device;
> > > > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > >  	if (err)
> > > > > -- 
> > > > > 2.26.2
> > > > 
> > 

