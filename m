Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA882CB8E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgLBJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgLBJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606901447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjLPsFcz+WE8TE1ZBhguoh9wGhwjdViuzdkm34Mwo5I=;
        b=PZlHG9J52JnIAuEo67hg8b9bf+RwVCa+98akcgcSXFBD6B72TxpiAcmNvspiHyn4W5qCyU
        AlkAzpX9cQcHMz9CyCybyZqADUQ2Vts/7qZclTx7gaapTkPf41lWLxHpI24u6Nh9+gCK5r
        I6OGBMh/MUx34ibWL2V8GpyW2TBDld0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-Hg6g9RkbNwWgYbO-EqKMqA-1; Wed, 02 Dec 2020 04:30:45 -0500
X-MC-Unique: Hg6g9RkbNwWgYbO-EqKMqA-1
Received: by mail-wm1-f70.google.com with SMTP id u123so2466653wmu.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TjLPsFcz+WE8TE1ZBhguoh9wGhwjdViuzdkm34Mwo5I=;
        b=brWnmNhOKxDI+bDl3Xdz58eqghWWGyM7gNK12jgAcHPCx6+TZuO+b2GgtEppQMAnOO
         a/UpIglaMTn5Z7+kHl8UtfDjZJgu68UzJ6K5ixiI93pRyXKJTkuhDBVkWjr84/8pE4dj
         1I2YNK24ldjC8F+Jx7SJpRWE71zZaxX/sFxcXl287tuTsM1txyqqjFO81TiNdqfasNuR
         ZRgWS3i8HJ1kevjwj/asVdA20/L6Cnuy+rNWZTePWqlkZy8YDv7x4tVyvRhGpABcWOaG
         nV1b42gC0MTwDBR/WLG33Pb+g6v1+cLdHJ/sGC4HcBdM9yQVBxALyj9Z56i3Z2YmPDVt
         tYAA==
X-Gm-Message-State: AOAM533K0lDktx4KnKZfgP0hxE2Ww9/8nstWBkh2xlvJbGPgkQyDW3lS
        Mf0Nn7ur9NNo6VqeG2JlyRwPtmzwMmxSuDRijPyqM1OvVLNr8Te1kGBAJMfoIQPF5ktUH44iCX7
        IoetV5/dQrvH3z1Ru5M6NzZwF
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2131567wmq.1.1606901444205;
        Wed, 02 Dec 2020 01:30:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiN9dR4+IEDrtLl07mPw2UeRQRRZOaQE8rDS63WCD6y/aKRT8sOvM3gsGCsPgJH+6xDh6f6w==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2131544wmq.1.1606901443937;
        Wed, 02 Dec 2020 01:30:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id r13sm1309831wrs.6.2020.12.02.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:30:42 -0800 (PST)
Date:   Wed, 2 Dec 2020 04:30:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202042328-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:18:36PM +0800, Jason Wang wrote:
> 
> On 2020/12/1 下午5:23, Cindy Lu wrote:
> > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > > > > > generated MAC address.
> > > > > > > > > > 
> > > > > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > > > with and without vdpa.
> > > > > > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > > > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > > > > > several instances of vdpa net devices and nic net devices.
> > > > > > > > 
> > > > > > > > > Could you include a bit more description on the failure
> > > > > > > > > mode?
> > > > > > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > > > > 
> > > > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > > > > 
> > > > > > > > > Is switching to a random mac for such an unusual
> > > > > > > > > configuration really justified?
> > > > > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > > > > 1. To get the MAC address as was chosen by the user administering the
> > > > > > > >     NIC. This should invoke the set_config callback. Unfortunately this
> > > > > > > >     is not implemented yet.
> > > > > > > > 
> > > > > > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > > > > > >     can always override this random configuration.
> > > > > > > > 
> > > > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > > > can it not?
> > > > > > > > > 
> > > > > > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > > > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > > > > > from steering point of view. I will post them here once other patches on
> > > > > > > > which they depend will be merged.
> > > > > > > > 
> > > > > > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > > > > Could you be more explicit on the following points:
> > > > > > > - which configuration is broken ATM (as in, two device have identical
> > > > > > >    macs? any other issues)?
> > > > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > > > > > It's not breaking anything yet is wrong. The random MAC address setting
> > > > > > is required for the steering patches.
> > > > > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > > > > dependency of a new feature.
> > > > > 
> > > > > > > - why won't device MAC change from guest point of view?
> > > > > > > 
> > > > > > It's lack of implementation in qemu as far as I know.
> > > > > Sorry not sure I understand. What's not implemented in QEMU?
> > > > > 
> > > > HI Michael, there are some bug in qemu to set_config, this will fix in future,
> > > > But this patch is still needed, because without this patch the mlx
> > > > driver will give an 0 mac address to qemu
> > > > and qemu will overwrite the default mac address.  This will cause traffic down.
> > > Hmm the patch description says VF mac address, not 0 address. Confused.
> > > If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> > > use a random value ...
> 
> 
> I'm not sure this can work for all types of vDPA (e.g it could not be a
> learning bridge in the swtich).
> 
> 
> > > 
> > hi Michael，
> > I have tried as your suggestion, seems even remove the
> > VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
> > default address in  VM,
> 
> 
> This looks a bug in qemu, in guest driver we had:
> 
>     /* Configuration may specify what MAC to use.  Otherwise random. */
>     if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
>         virtio_cread_bytes(vdev,
>                    offsetof(struct virtio_net_config, mac),
>                    dev->dev_addr, dev->addr_len);
>     else
>         eth_hw_addr_random(dev);
> 
> 
> > this process is like
> > vdpa _init -->qemu call get_config ->mlx driver will give  an mac
> > address with all 0-->
> > qemu will not check this mac address and use it --> overwrite the mac
> > address in qemu
> > 
> > So for my understanding there are several method to fix this problem
> > 
> > 1, qemu check the mac address, if the mac address is all 0, qemu will
> > ignore it and set the random mac address to mlx driver.
> 
> 
> So my understanding is that, if mac address is all 0, vDPA parent should not
> advertise VIRTIO_NET_F_MAC. And qemu should emulate this feature as you did:
> 
> 1) get a random mac

To me this looks like a spec violation.

If the driver negotiates the VIRTIO_NET_F_MAC feature, the driver MUST set
the physical address of the NIC to \field{mac}.  Otherwise, it SHOULD
use a locally-administered MAC address (see \hyperref[intro:IEEE 802]{IEEE 802},
``9.2 48-bit universal LAN MAC addresses'').

While not said explicitly, the assumption I think is that the local
MAC is not a local one.


> 2) advertise VIRTIO_NET_F_MAC
> 3) set the random mac to vDPA through set_config

that part looks wrong to me. Setting mac through set_config was
a pre-virtio-1.0 way to send mac to device. In 1.0 we have
VIRTIO_NET_CTRL_MAC_ADDR_SET for that:


	When using the legacy interface, \field{mac} is driver-writable
	which provided a way for drivers to update the MAC without
	negotiating VIRTIO_NET_F_CTRL_MAC_ADDR.




> 4) advertise the random mac to emulated config to guest
> 
> 
> > 2. mlx driver checks the mac address and if this mac is 0, return fail
> > to qemu, but this need to change the UAPI.
> 
> 
> uAPI is probably fine since ioctl can fail.  We can change the to allow the
> set_config to fail but virito spec doesn't have a way to advertise the error
> in this case. Anyway, the driver only risk itself for setting a wrong value,
> so we're probably fine.
> 
> Thanks
> 
> 
> > 3. mlx driver it shelf should get an correct mac address while it init.
> > 4. add check in qemu get_config function  , if there is not F_MAC Then
> > ignore the mac address from mlx driver
> > 
> > not sure which method is more suitable ?
> > 
> > Thanks
> > Cindy
> > 
> > 
> > 
> > > > > > > > > > ---
> > > > > > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > > > > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > > > > > > >        if (err)
> > > > > > > > > >                goto err_mtu;
> > > > > > > > > > 
> > > > > > > > > > -     err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > > > > > -     if (err)
> > > > > > > > > > -             goto err_mtu;
> > > > > > > > > > -
> > > > > > > > > > +     eth_random_addr(config->mac);
> > > > > > > > > >        mvdev->vdev.dma_dev = mdev->device;
> > > > > > > > > >        err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > > > > >        if (err)
> > > > > > > > > > --
> > > > > > > > > > 2.26.2

