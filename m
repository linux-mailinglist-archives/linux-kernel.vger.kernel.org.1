Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B12CBCCE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgLBMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbgLBMTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606911466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUJo5xnMG2jdLE87UZGUrLJZWNTaM3erUF8JxZlMs9I=;
        b=Q9mIwRa4tgGJcazjVjj6QWsadHqOxxlKJwoxGdAYia3X2iXaYaN8CdjqVfoYBe8Mh0TbUH
        BF3H9XNQvwH372meCCDKsEcMF9EAiYMjjqb3pjrZMXdwPmvAPLYZWG17k+K1/td5tjcXry
        VqwRFel7AntbutTyF4CAN6UxiRQYTcc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-D2Y6nxBgOf29hCf6k1jrUw-1; Wed, 02 Dec 2020 07:17:41 -0500
X-MC-Unique: D2Y6nxBgOf29hCf6k1jrUw-1
Received: by mail-wm1-f69.google.com with SMTP id n18so3485529wmk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fUJo5xnMG2jdLE87UZGUrLJZWNTaM3erUF8JxZlMs9I=;
        b=j+2ll5MT9MxC+hoPKrSHXvR8qSsZDm7YcuwqNmQQysxUes3NtQp+y03BUS7oG4EAbA
         mHGfFf7BHPU3eXKcmte8tsJjpa9wPqYiKwtzVMUebDOO2QrJYKQYbwob/tW/npErWt05
         JiaR4fA3Ciw/PVujqZhcnxFn9F+LZ+Luw5QJBR1IG3/8hFTvXS+n6fLYcJ0/KiouJEfU
         OgvFJguHBKG3CmkG9aLC2VMkvtQOSZA21EKv6HsF9F6pqpSoOFL1YLx68h2DWFfJPGen
         AVmzL/tpGmzHhLEcBzIpeIxHUhBJe/XwSmxMmuzs2c5XTHpBu7RBRQDhyQj1OUnrrL74
         u9Xw==
X-Gm-Message-State: AOAM530s+b/ggudv4evGkgvuA5wav4iGth+gAw805Ll0L1D6Pkd0v4le
        68AW6wv5ssS1LvC1ZPCsweCOySbD0qWxpA1oE5IYwplwQ5xpLHS8/eYrR3Uvzeyul6nsvOlHXFt
        /6jGjGFiV/OAeA/61TGCtV7G2
X-Received: by 2002:adf:90d0:: with SMTP id i74mr3202613wri.288.1606911460026;
        Wed, 02 Dec 2020 04:17:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4mxVfhoTxQ4xn1sGyNK7XSiXawRsZEp5pp6ly/FkEAIQlnMUr2cG3xHE/D21LFpqeqInt9A==
X-Received: by 2002:adf:90d0:: with SMTP id i74mr3202580wri.288.1606911459692;
        Wed, 02 Dec 2020 04:17:39 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id u26sm1916230wmm.24.2020.12.02.04.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:17:38 -0800 (PST)
Date:   Wed, 2 Dec 2020 07:17:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202071414-mutt-send-email-mst@kernel.org>
References: <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <20201202121241.GA228811@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201202121241.GA228811@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 02:12:41PM +0200, Eli Cohen wrote:
> On Wed, Dec 02, 2020 at 04:23:11AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 02, 2020 at 07:57:14AM +0200, Eli Cohen wrote:
> > > On Wed, Dec 02, 2020 at 12:18:36PM +0800, Jason Wang wrote:
> > > > 
> > > > On 2020/12/1 下午5:23, Cindy Lu wrote:
> > > > > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > > > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > > > > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > > > > > > > generated MAC address.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > > > > > > with and without vdpa.
> > > > > > > > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > > > > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > > > > > > > several instances of vdpa net devices and nic net devices.
> > > > > > > > > > > 
> > > > > > > > > > > > Could you include a bit more description on the failure
> > > > > > > > > > > > mode?
> > > > > > > > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > > > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > > > > > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > > > > > > > 
> > > > > > > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > > > > > > > 
> > > > > > > > > > > > Is switching to a random mac for such an unusual
> > > > > > > > > > > > configuration really justified?
> > > > > > > > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > > > > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > > > > > > > >     NIC. This should invoke the set_config callback. Unfortunately this
> > > > > > > > > > >     is not implemented yet.
> > > > > > > > > > > 
> > > > > > > > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > > > > > > > >     can always override this random configuration.
> > > > > > > > > > > 
> > > > > > > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > > > > > > can it not?
> > > > > > > > > > > > 
> > > > > > > > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > > > > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > > > > > > > from steering point of view. I will post them here once other patches on
> > > > > > > > > > > which they depend will be merged.
> > > > > > > > > > > 
> > > > > > > > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > > > > > > > Could you be more explicit on the following points:
> > > > > > > > > > - which configuration is broken ATM (as in, two device have identical
> > > > > > > > > >    macs? any other issues)?
> > > > > > > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > > > > > > > It's not breaking anything yet is wrong. The random MAC address setting
> > > > > > > > > is required for the steering patches.
> > > > > > > > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > > > > > > > dependency of a new feature.
> > > > > > > > 
> > > > > > > > > > - why won't device MAC change from guest point of view?
> > > > > > > > > > 
> > > > > > > > > It's lack of implementation in qemu as far as I know.
> > > > > > > > Sorry not sure I understand. What's not implemented in QEMU?
> > > > > > > > 
> > > > > > > HI Michael, there are some bug in qemu to set_config, this will fix in future,
> > > > > > > But this patch is still needed, because without this patch the mlx
> > > > > > > driver will give an 0 mac address to qemu
> > > > > > > and qemu will overwrite the default mac address.  This will cause traffic down.
> > > > > > Hmm the patch description says VF mac address, not 0 address. Confused.
> > > > > > If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> > > > > > use a random value ...
> > > > 
> > > > 
> > > > I'm not sure this can work for all types of vDPA (e.g it could not be a
> > > > learning bridge in the swtich).
> > > > 
> > > > 
> > > > > > 
> > > > > hi Michael，
> > > > > I have tried as your suggestion, seems even remove the
> > > > > VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
> > > > > default address in  VM,
> > > > 
> > > > 
> > > > This looks a bug in qemu, in guest driver we had:
> > > > 
> > > >     /* Configuration may specify what MAC to use.  Otherwise random. */
> > > >     if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > > >         virtio_cread_bytes(vdev,
> > > >                    offsetof(struct virtio_net_config, mac),
> > > >                    dev->dev_addr, dev->addr_len);
> > > >     else
> > > >         eth_hw_addr_random(dev);
> > > > 
> > > > 
> > > > > this process is like
> > > > > vdpa _init -->qemu call get_config ->mlx driver will give  an mac
> > > > > address with all 0-->
> > > > > qemu will not check this mac address and use it --> overwrite the mac
> > > > > address in qemu
> > > > > 
> > > > > So for my understanding there are several method to fix this problem
> > > > > 
> > > > > 1, qemu check the mac address, if the mac address is all 0, qemu will
> > > > > ignore it and set the random mac address to mlx driver.
> > > > 
> > > > 
> > > > So my understanding is that, if mac address is all 0, vDPA parent should not
> > > > advertise VIRTIO_NET_F_MAC. And qemu should emulate this feature as you did:
> > > 
> > > Thinking it over, at least in mlx5, I should always advertise
> > > VIRTIO_NET_F_MAC and set a non zero MAC value. The source of the MAC can
> > > be either randomly generated value by mlx5_vdpa or by a management tool.
> > > This is important becauase we should not let the VM modify the MAC. If
> > > we do it can set a MAC value identical to the mlx5 NIC driver and can
> > > kidnap traffic that was not destined to it.
> > > 
> > > In addition, when VIRTIO_NET_F_MAC is published, attempts to change the
> > > MAC address from the VM should result in error.
> > 
> > That is not what the spec says though.
> > VIRTIO_NET_F_MAC only says whether mac is valid in the config space.
> > Whether guest can control that depends on VIRTIO_NET_F_CTRL_MAC_ADDR:
> > 
> > 	The VIRTIO_NET_CTRL_MAC_ADDR_SET command is used to set the default MAC address which rx
> > 	filtering accepts (and if VIRTIO_NET_F_MAC_ADDR has been negotiated, this will be reflected in mac in
> > 	config space).
> > 	The command-specific-data for VIRTIO_NET_CTRL_MAC_ADDR_SET is the 6-byte MAC address.
> 
> Two questions here:
> 1. Now we don't have support for control virtqueue. Yet, we must filter
> packets based on MAC, what do you suggest to do here?

How about an ioctl to pass the mac to the device?
Maybe mirroring the control vq struct format ...

> 2. When control virtqueue is implemented, which admin entity is allowed
> to change the MAC filtering table?

It's up to the hypervisor: if VIRTIO_NET_F_CTRL_MAC_ADDR
is enabled this means hypervisor trusts the guest with full
access to NIC network.
If it's clear then mac must be set by hardware or the hypervisor.

> > 
> > 
> > 
> > 
> > > 
> > > > 
> > > > 1) get a random mac
> > > > 2) advertise VIRTIO_NET_F_MAC
> > > > 3) set the random mac to vDPA through set_config
> > > > 4) advertise the random mac to emulated config to guest
> > > > 
> > > > 
> > > > > 2. mlx driver checks the mac address and if this mac is 0, return fail
> > > > > to qemu, but this need to change the UAPI.
> > > > 
> > > > 
> > > > uAPI is probably fine since ioctl can fail.  We can change the to allow the
> > > > set_config to fail but virito spec doesn't have a way to advertise the error
> > > > in this case. Anyway, the driver only risk itself for setting a wrong value,
> > > > so we're probably fine.
> > > > 
> > > > Thanks
> > > > 
> > > > 
> > > > > 3. mlx driver it shelf should get an correct mac address while it init.
> > > > > 4. add check in qemu get_config function  , if there is not F_MAC Then
> > > > > ignore the mac address from mlx driver
> > > > > 
> > > > > not sure which method is more suitable ?
> > > > > 
> > > > > Thanks
> > > > > Cindy
> > > > > 
> > > > > 
> > > > > 
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > > > > > > > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > > > > > > > > > >        if (err)
> > > > > > > > > > > > >                goto err_mtu;
> > > > > > > > > > > > > 
> > > > > > > > > > > > > -     err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > > > > > > > > -     if (err)
> > > > > > > > > > > > > -             goto err_mtu;
> > > > > > > > > > > > > -
> > > > > > > > > > > > > +     eth_random_addr(config->mac);
> > > > > > > > > > > > >        mvdev->vdev.dma_dev = mdev->device;
> > > > > > > > > > > > >        err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > > > > > > > >        if (err)
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.26.2
> > > > 
> > 

