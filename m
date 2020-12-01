Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE842C9D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbgLAJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390923AbgLAJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606814639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHXtAhLA69YQ8pdXKl7mp9XY6rD8BGspbq869Muqv/8=;
        b=dlG/y2YAATj9M7T7wbhOBFf6dcMWvNRUaXVom78kiRch38OF1SEZtlLUR5vF3Asd5wcLP3
        xc8stbs5zeDZ/n96ZlqDtZZr72yLtZ711DUPnJ8YDscOYw4uWaOL2gd5pkx+EcwEYC1KD7
        O+Ngqdv4ggri9juo4gkZUlwtfieyWvo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-nZdXbSBFOHmmLVGihqxXfA-1; Tue, 01 Dec 2020 04:23:56 -0500
X-MC-Unique: nZdXbSBFOHmmLVGihqxXfA-1
Received: by mail-pj1-f72.google.com with SMTP id e21so794775pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 01:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EHXtAhLA69YQ8pdXKl7mp9XY6rD8BGspbq869Muqv/8=;
        b=QZlyW/d73YEgqekYS0E2V0lVCkAhir/Hze/dnWANfBFEnm+0sF3iQyuMFK5X2CqCp2
         H1E79Rgmd2gUK9iK7HA4Iifp3vS/DIDDnSnpLq52cIw3wDidDw1qOsJXxQr+beSXCGSF
         If/RKqLSGIG5xORMFsrfI5OiAAnJ6ItX8iblw2TufzDKE4zuMXdxFIbzteUXS5h3V+Tb
         hdRZak+B9/3LQVamrkxEL1Ev+509YwST3+qVyzxU5KjTF6HNycixhv5ZiLB6QQigEZPS
         mOokR4gWc8IF/t3uMrkYdPCBdHXvo/OQh9SCOA28e3JHOP+QSxD51Z8G+WQDSjMTY3pO
         YpgQ==
X-Gm-Message-State: AOAM533ErDV5b8JryVlnBpMQg8TKiMdbk5Ay11rwQ2ba6jn8+RmKnhhJ
        Nl3sdqEz4tdDNI/CXKXZN260Lpi/WF8bLpjL+qzBAM+zWqvedvT7DcD3QHrEiIEF6OHM95UMnBw
        jY4PrlDBBJIpS91k0ElF7ZMdplI1/tH3O/V/JLVRz
X-Received: by 2002:a17:90a:9381:: with SMTP id q1mr1803279pjo.127.1606814634934;
        Tue, 01 Dec 2020 01:23:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBO6xb5gfmuTIyudttctOOhWn98D2GmCZ1DxfuKu+UK4qjNnp3TyXW76pCjCS7LsujIN4/h01G+w+PqaPxgdU=
X-Received: by 2002:a17:90a:9381:: with SMTP id q1mr1803261pjo.127.1606814634669;
 Tue, 01 Dec 2020 01:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20201129064351.63618-1-elic@nvidia.com> <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx> <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx> <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com> <20201130103142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201130103142-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 1 Dec 2020 17:23:18 +0800
Message-ID: <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wr=
ote:
> > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > > > We should not try to use the VF MAC address as that is used=
 by the
> > > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a=
 random
> > > > > > > > generated MAC address.
> > > > > > > >
> > > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for suppor=
ted mlx5 devices")
> > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > >
> > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > with and without vdpa.
> > > > > >
> > > > > > Using a VF you can create quite a few resources, e.g. send queu=
es
> > > > > > recieve queues, virtio_net queues etc. So you can possibly crea=
te
> > > > > > several instances of vdpa net devices and nic net devices.
> > > > > >
> > > > > > > Could you include a bit more description on the failure
> > > > > > > mode?
> > > > > >
> > > > > > Well, using the MAC address of the nic vport is wrong since tha=
t is the
> > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > >
> > > > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > > > >
> > > >
> > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > >
> > > > > > > Is switching to a random mac for such an unusual
> > > > > > > configuration really justified?
> > > > > >
> > > > > > Since I can't use the NIC's MAC address, I have two options:
> > > > > > 1. To get the MAC address as was chosen by the user administeri=
ng the
> > > > > >    NIC. This should invoke the set_config callback. Unfortunate=
ly this
> > > > > >    is not implemented yet.
> > > > > >
> > > > > > 2. Use a random MAC address. This is OK since if (1) is impleme=
nted it
> > > > > >    can always override this random configuration.
> > > > > >
> > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > can it not?
> > > > > > >
> > > > > >
> > > > > > No, it will not. The current version of mlx5 VDPA does not allo=
w regular
> > > > > > NIC driver and VDPA to co-exist. I have patches ready that enab=
le that
> > > > > > from steering point of view. I will post them here once other p=
atches on
> > > > > > which they depend will be merged.
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/netdev/patch/2020112023033=
9.651609-12-saeedm@nvidia.com/
> > > > >
> > > > > Could you be more explicit on the following points:
> > > > > - which configuration is broken ATM (as in, two device have ident=
ical
> > > > >   macs? any other issues)?
> > > >
> > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_addre=
ss().
> > > > It's not breaking anything yet is wrong. The random MAC address set=
ting
> > > > is required for the steering patches.
> > >
> > > Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> > > dependency of a new feature.
> > >
> > > > > - why won't device MAC change from guest point of view?
> > > > >
> > > >
> > > > It's lack of implementation in qemu as far as I know.
> > >
> > > Sorry not sure I understand. What's not implemented in QEMU?
> > >
> > HI Michael, there are some bug in qemu to set_config, this will fix in =
future,
> > But this patch is still needed, because without this patch the mlx
> > driver will give an 0 mac address to qemu
> > and qemu will overwrite the default mac address.  This will cause traff=
ic down.
>
> Hmm the patch description says VF mac address, not 0 address. Confused.
> If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> use a random value ...
>
hi Michael=EF=BC=8C
I have tried as your suggestion, seems even remove the
VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
default address in  VM,
this process is like
vdpa _init -->qemu call get_config ->mlx driver will give  an mac
address with all 0-->
qemu will not check this mac address and use it --> overwrite the mac
address in qemu

So for my understanding there are several method to fix this problem

1, qemu check the mac address, if the mac address is all 0, qemu will
ignore it and set the random mac address to mlx driver.
2. mlx driver checks the mac address and if this mac is 0, return fail
to qemu, but this need to change the UAPI.
3. mlx driver it shelf should get an correct mac address while it init.
4. add check in qemu get_config function  , if there is not F_MAC Then
ignore the mac address from mlx driver

not sure which method is more suitable ?

Thanks
Cindy



> > > > >
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vd=
pa/mlx5/net/mlx5_vnet.c
> > > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_=
core_dev *mdev)
> > > > > > > >       if (err)
> > > > > > > >               goto err_mtu;
> > > > > > > >
> > > > > > > > -     err =3D mlx5_query_nic_vport_mac_address(mdev, 0, 0, =
config->mac);
> > > > > > > > -     if (err)
> > > > > > > > -             goto err_mtu;
> > > > > > > > -
> > > > > > > > +     eth_random_addr(config->mac);
> > > > > > > >       mvdev->vdev.dma_dev =3D mdev->device;
> > > > > > > >       err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > > >       if (err)
> > > > > > > > --
> > > > > > > > 2.26.2
> > > > > > >
> > > > >
> > >
>

