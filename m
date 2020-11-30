Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF52E2C8080
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgK3JCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:02:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgK3JC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606726861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xiPvp6x0gf1L8/yQBHxAgSJCq1BiNj+2S6D9QL93hd0=;
        b=Whb/mUgPFZPfQU/S18NWZZInYqE+cl/VUwy/NN9HmkRIAKNR2U0eEZdmvl/gmHIXY/r9eC
        8ChzTAZlnX+ffMCIMwTRobeuxCXAN78b7FyIpHD6rLnIUgq9qwFPaYmEMzbiwEdCHrq9HM
        4ok9b5sANI5bs+7hfHNQU5tScPm80Vs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-e2VpQ-sONAqTPZY_3tGl-g-1; Mon, 30 Nov 2020 04:00:57 -0500
X-MC-Unique: e2VpQ-sONAqTPZY_3tGl-g-1
Received: by mail-wm1-f71.google.com with SMTP id u123so4127474wmu.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 01:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiPvp6x0gf1L8/yQBHxAgSJCq1BiNj+2S6D9QL93hd0=;
        b=otlcraVossi2cOBlIkiYtI0cEq3U83rQGBJ1MOM21azPP+Zfun6HJYjLhd7QhaVFiS
         nVH7UL1oVxmAWtBh9o0tG7hNbVMaiE7Qad4YNTYfwDrYDWOSP2vq4mrtSmvJtGAH8h6G
         xckwLdxrJo0ROzjSmmDuOB3WaPxjsTfxK+w6FmazsThqu4hO+Q1odPPr8MFagfK0C/7n
         VGtvEAjQEoiWnhJnFsQqZdqBV3r8R6W1CU/WOmDN3xUlH98bs0/am3aBGMZVDS7ETL2W
         XzF8emP96pNM+vL8HzAk5h/YI/qQqjKudhn+thaw1mXkW7mDRuXdSo1fozePZHJ1UF8w
         xi0A==
X-Gm-Message-State: AOAM5334STyAFn5cQfzWOTSKSnaD/OXCrhCAj9CVXPeZS/9BNOxifMyH
        XpSRoMcOKivwBwv6dOibaaJC76pusZwBByk9myIJAE1ggCOJoWgmRYPWJTFSVYyatTiV+GYdIY3
        IUCCj65Bq/OqlUgnE6v/SE9km
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr26864305wrm.36.1606726855413;
        Mon, 30 Nov 2020 01:00:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM4Rcm5MkqH5pqPqXkkHFFYNovJ7rq0TY5MZ8/Ba8lx8HQAvuZuFy84/IfK1fWYLf7ESXbkQ==
X-Received: by 2002:adf:dd0e:: with SMTP id a14mr26864285wrm.36.1606726855207;
        Mon, 30 Nov 2020 01:00:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id q16sm28072755wrn.13.2020.11.30.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 01:00:54 -0800 (PST)
Date:   Mon, 30 Nov 2020 04:00:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130035147-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > We should not try to use the VF MAC address as that is used by the
> > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > generated MAC address.
> > > 
> > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > I didn't realise it's possible to use VF in two ways
> > with and without vdpa.
> 
> Using a VF you can create quite a few resources, e.g. send queues
> recieve queues, virtio_net queues etc. So you can possibly create
> several instances of vdpa net devices and nic net devices.
> 
> > Could you include a bit more description on the failure
> > mode?
> 
> Well, using the MAC address of the nic vport is wrong since that is the
> MAC of the regular NIC implementation of mlx5_core.

Right but ATM it doesn't coexist with vdpa so what's the problem?

> > Is switching to a random mac for such an unusual
> > configuration really justified?
> 
> Since I can't use the NIC's MAC address, I have two options:
> 1. To get the MAC address as was chosen by the user administering the
>    NIC. This should invoke the set_config callback. Unfortunately this
>    is not implemented yet.
> 
> 2. Use a random MAC address. This is OK since if (1) is implemented it
>    can always override this random configuration.
> 
> > It looks like changing a MAC could break some guests,
> > can it not?
> >
> 
> No, it will not. The current version of mlx5 VDPA does not allow regular
> NIC driver and VDPA to co-exist. I have patches ready that enable that
> from steering point of view. I will post them here once other patches on
> which they depend will be merged.
> 
> https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/

Could you be more explicit on the following points:
- which configuration is broken ATM (as in, two device have identical
  macs? any other issues)?
- why won't device MAC change from guest point of view?


> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 1fa6fcac8299..80d06d958b8b 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > >  	if (err)
> > >  		goto err_mtu;
> > >  
> > > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > -	if (err)
> > > -		goto err_mtu;
> > > -
> > > +	eth_random_addr(config->mac);
> > >  	mvdev->vdev.dma_dev = mdev->device;
> > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > >  	if (err)
> > > -- 
> > > 2.26.2
> > 

