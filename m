Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD672CA175
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgLALdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727378AbgLALdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606822341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Svz+1xyDUI6OILOu+XfjM4sFd1o5nMwo/UZKflYJ9Nc=;
        b=EzcgZGGMunoGV4Kf+FHydRu6AZK5tidqtZa4Tnx80HY/hGBAxrdGBNbovfKahqtAO41fwT
        bO5b9q33fIQt94tr1Ab2JB9BjfNYUYFYt497hdONWVIp3yVpftNqkLI7dDOnnw/o7dpRkP
        zbHRtobYGbe1elL+SssXwmX6o8c4uL8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-7BiDawGgN3i_wPYpMHk2Ng-1; Tue, 01 Dec 2020 06:32:17 -0500
X-MC-Unique: 7BiDawGgN3i_wPYpMHk2Ng-1
Received: by mail-ej1-f72.google.com with SMTP id f2so1053755ejx.22
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 03:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Svz+1xyDUI6OILOu+XfjM4sFd1o5nMwo/UZKflYJ9Nc=;
        b=m3B5P4mHYVOwn0rfSIKVqya410PtoYuq0wc+tiDvJrX1T4vN+S6VWJtw/hgqpO2Sss
         umiohFKucffZUzzWtABaMHJts9CzMdQJEKCOeNKgZBDiA+YPSCX7V4Xl0VsTnoI57jFk
         zIScqr8L5Qe3UNbUhuVtqpY4r7JP8niu2DAW2bL+0T37+6s5eebMRyd3t00MC/SHbs1Q
         9UHZV6B++jLPPsqqEC9cL6Ww1RI1A51DwFA2LlpdeXjcJ21pcsJlIKZ7OUdBeFONuLpE
         u1T2AU/DyufQuX78Fu2IUwEicp96JzrEmYJf1OZt+dR8wZL/50ekSsz2kNZfv3E1aNQ/
         9pUA==
X-Gm-Message-State: AOAM5319HcWrMHQiiD6/p62Rnz6/izsRCVlbcQqh/SxTDBPwx09qvjlh
        MeIWYx3nq4fEBJbOVITM2sKbDy5awApouapKodPanmyzfRNn0pLmRR7lHwbxdoMdMRpCjdU62Ss
        4YUekScUIfXgwVRv+vpql6ELu
X-Received: by 2002:a17:906:7aca:: with SMTP id k10mr2445569ejo.215.1606822336239;
        Tue, 01 Dec 2020 03:32:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiPe9/KoxYRLDVWSQQVvL+gdJ6By20pYTiP3sMl7OyF7YkInMq7HsnWLqYI/1YenfxYufnBQ==
X-Received: by 2002:a17:906:7aca:: with SMTP id k10mr2445552ejo.215.1606822335923;
        Tue, 01 Dec 2020 03:32:15 -0800 (PST)
Received: from redhat.com ([147.161.9.150])
        by smtp.gmail.com with ESMTPSA id i21sm676575edt.92.2020.12.01.03.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 03:32:15 -0800 (PST)
Date:   Tue, 1 Dec 2020 06:32:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201201063124-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:23:18PM +0800, Cindy Lu wrote:
> On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > > > generated MAC address.
> > > > > > > > >
> > > > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > >
> > > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > > with and without vdpa.
> > > > > > >
> > > > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > > > several instances of vdpa net devices and nic net devices.
> > > > > > >
> > > > > > > > Could you include a bit more description on the failure
> > > > > > > > mode?
> > > > > > >
> > > > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > > >
> > > > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > > >
> > > > >
> > > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > > >
> > > > > > > > Is switching to a random mac for such an unusual
> > > > > > > > configuration really justified?
> > > > > > >
> > > > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > > > >    NIC. This should invoke the set_config callback. Unfortunately this
> > > > > > >    is not implemented yet.
> > > > > > >
> > > > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > > > >    can always override this random configuration.
> > > > > > >
> > > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > > can it not?
> > > > > > > >
> > > > > > >
> > > > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > > > from steering point of view. I will post them here once other patches on
> > > > > > > which they depend will be merged.
> > > > > > >
> > > > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > > >
> > > > > > Could you be more explicit on the following points:
> > > > > > - which configuration is broken ATM (as in, two device have identical
> > > > > >   macs? any other issues)?
> > > > >
> > > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > > > It's not breaking anything yet is wrong. The random MAC address setting
> > > > > is required for the steering patches.
> > > >
> > > > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > > > dependency of a new feature.
> > > >
> > > > > > - why won't device MAC change from guest point of view?
> > > > > >
> > > > >
> > > > > It's lack of implementation in qemu as far as I know.
> > > >
> > > > Sorry not sure I understand. What's not implemented in QEMU?
> > > >
> > > HI Michael, there are some bug in qemu to set_config, this will fix in future,
> > > But this patch is still needed, because without this patch the mlx
> > > driver will give an 0 mac address to qemu
> > > and qemu will overwrite the default mac address.  This will cause traffic down.
> >
> > Hmm the patch description says VF mac address, not 0 address. Confused.
> > If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> > use a random value ...
> >
> hi Michael，
> I have tried as your suggestion, seems even remove the
> VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
> default address in  VM,
> this process is like
> vdpa _init -->qemu call get_config ->mlx driver will give  an mac
> address with all 0-->
> qemu will not check this mac address and use it --> overwrite the mac
> address in qemu

Right but guest will ignore it then, right?

> So for my understanding there are several method to fix this problem
> 
> 1, qemu check the mac address, if the mac address is all 0, qemu will
> ignore it and set the random mac address to mlx driver.
> 2. mlx driver checks the mac address and if this mac is 0, return fail
> to qemu, but this need to change the UAPI.
> 3. mlx driver it shelf should get an correct mac address while it init.
> 4. add check in qemu get_config function  , if there is not F_MAC Then
> ignore the mac address from mlx driver
> 
> not sure which method is more suitable ?
> 
> Thanks
> Cindy
> 
> 
> 
> > > > > >
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > > > > > >       if (err)
> > > > > > > > >               goto err_mtu;
> > > > > > > > >
> > > > > > > > > -     err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > > > > -     if (err)
> > > > > > > > > -             goto err_mtu;
> > > > > > > > > -
> > > > > > > > > +     eth_random_addr(config->mac);
> > > > > > > > >       mvdev->vdev.dma_dev = mdev->device;
> > > > > > > > >       err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > > > >       if (err)
> > > > > > > > > --
> > > > > > > > > 2.26.2
> > > > > > > >
> > > > > >
> > > >
> >

