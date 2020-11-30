Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A52C880F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgK3PcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbgK3PcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606750256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mSq1E62E7wz6JRt2Y3RxWKfynONuZ8BYJwR+me11tnw=;
        b=eJreeo7e2n0X+dYZjlXyviz9k7m0obN44m+719CZAzSQMqAGZSOJ4qS3zqko+9/LFxtIHY
        1OeGEMtGaPv3gZFR9HP2ZCyrGQ9J++w+BOoNXTIN/O/x7+XRcqyMi3QAJ7JYrb7MZgUkmj
        I9Yia9EfBo8BRNKPHAy8pToBmnZNVWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-2G-2Xp0kOLaVKKmJ2BDD1Q-1; Mon, 30 Nov 2020 10:30:47 -0500
X-MC-Unique: 2G-2Xp0kOLaVKKmJ2BDD1Q-1
Received: by mail-wm1-f72.google.com with SMTP id y187so7568212wmy.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mSq1E62E7wz6JRt2Y3RxWKfynONuZ8BYJwR+me11tnw=;
        b=IgIjZGLsXsNP44Vp1kUd3vWjVvqdGMEDpeebWwvwpcm76+x2VAsZq5KL4YEN2jjNJY
         IZ0+kdUXLSgSTxTCgoDwKZxZqYIR+C7Q8xD26N873sVARFY2HCm6PO+RdQ15cOV5aHBV
         YZnlJJnsCOZHKbr8PsczZTmbKbnh5tzJGmi5DywCQ0QM1OI6uSpCu+xCK5e16XoAuPtO
         UzQfFwhSV19kWVUqMZLRrLVOgJ3y+m6iWpABgSNSZPqLbcrWp2tgo7nxCfm4FFgLLant
         9ypEIDbkzyRdPxwB3tGo1V1WMwK0Gf32j5kOdp0MwgCbH5DVgJDxa8WHLKBtiMHRYJr3
         yJHg==
X-Gm-Message-State: AOAM530IckeC80YPqop6BsMccnhG3QSbCShKbFfttp/rCxXx2EF9gdrK
        qG2DNYYPibWfaxptglqUzwH/vTDMr6Vtn+w9Tcw+5IO1OLLnwWIDU7K3iE1BJoe2ddWZoNZOYMF
        nnyx5q21EAtVGGO94Ew/1YLHd
X-Received: by 2002:a5d:5222:: with SMTP id i2mr30380243wra.247.1606750246464;
        Mon, 30 Nov 2020 07:30:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLfsWdwn+ngcuaGhodnrBSo95VO8/Fqkp8mEji2+ltAV+F81gZF2wnOT7/jRgqO+l3faOIEw==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr30380223wra.247.1606750246129;
        Mon, 30 Nov 2020 07:30:46 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id q4sm3852657wmc.2.2020.11.30.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:30:45 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:30:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130102633-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <20201130115106.GC99449@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130115106.GC99449@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 01:51:06PM +0200, Eli Cohen wrote:
> On Mon, Nov 30, 2020 at 04:33:09AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > generated MAC address.
> > > > > > > 
> > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > 
> > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > with and without vdpa.
> > > > > 
> > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > several instances of vdpa net devices and nic net devices.
> > > > > 
> > > > > > Could you include a bit more description on the failure
> > > > > > mode?
> > > > > 
> > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > 
> > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > 
> > > 
> > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > 
> > > > > > Is switching to a random mac for such an unusual
> > > > > > configuration really justified?
> > > > > 
> > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > >    NIC. This should invoke the set_config callback. Unfortunately this
> > > > >    is not implemented yet.
> > > > > 
> > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > >    can always override this random configuration.
> > > > > 
> > > > > > It looks like changing a MAC could break some guests,
> > > > > > can it not?
> > > > > >
> > > > > 
> > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > from steering point of view. I will post them here once other patches on
> > > > > which they depend will be merged.
> > > > > 
> > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > 
> > > > Could you be more explicit on the following points:
> > > > - which configuration is broken ATM (as in, two device have identical
> > > >   macs? any other issues)?
> > > 
> > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > It's not breaking anything yet is wrong. The random MAC address setting
> > > is required for the steering patches.
> > 
> > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > dependency of a new feature.
> > 
> 
> OK, let's leave it for now. I will push along with the steering patches.
> The meaning is the the VDPA net device instance is create with a MAC of
> all zeros which also mean the link is down. You can set a MAC which will
> let the link come up.
> The vdpa driver will not get a callback as I
> stated but since current mode of steering directs all traffic to the
> vdpa instance it will work. In the future this must be fixed.

So at the moment the MAC is in the config space and that is read during
probe.  So I guess userspace will do that before passing device to
guest.

> 
> > > > - why won't device MAC change from guest point of view?
> > > > 
> > > 
> > > It's lack of implementation in qemu as far as I know.
> > 
> > Sorry not sure I understand. What's not implemented in QEMU?
> > 
> 
> vdpa config operation set_config() should be called whenever the MAC is
> changed, e.g. when administrator of the vdpa net device changes the mac.
> This does not happen which is a bug.

I am not sure that's a good interface for that, I think set_config
is for guest writes into config space.
Will let Jason comment once patches are posted.

> > > > 
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > > > >  	if (err)
> > > > > > >  		goto err_mtu;
> > > > > > >  
> > > > > > > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > > -	if (err)
> > > > > > > -		goto err_mtu;
> > > > > > > -
> > > > > > > +	eth_random_addr(config->mac);
> > > > > > >  	mvdev->vdev.dma_dev = mdev->device;
> > > > > > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > >  	if (err)
> > > > > > > -- 
> > > > > > > 2.26.2
> > > > > > 
> > > > 
> > 

