Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507092CB2CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 03:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgLBC3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 21:29:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgLBC3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606876064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w11V4bmvhWru2IiQcOjCMFc2jaajSUpY7gF7ScGtZGE=;
        b=RZ9HVxkIRp7KLhaEXMgPmEX7y9o1a7nNyqeUE1Rcq3BzNK3PI4XHKJPhsplGZ/7FP7PmQq
        S+3A23cddCrvuRpZ959peZAhchYYmkVRtbn854Vr3tSpcM6rK0o9JEGRWwywSAHUcSYQkt
        RWlPtKCO9Vi/5ozl5MwoJSojtPBvLZI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-wgZzBt9EPE24PoqPrCCuew-1; Tue, 01 Dec 2020 21:27:40 -0500
X-MC-Unique: wgZzBt9EPE24PoqPrCCuew-1
Received: by mail-pg1-f199.google.com with SMTP id o17so34285pgm.18
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 18:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w11V4bmvhWru2IiQcOjCMFc2jaajSUpY7gF7ScGtZGE=;
        b=LExiG8K7feMYf4TrRd5KWepAuYXe7AAPvJiJqEv2efH8qC4fl5LndJSU2C83KiT3it
         wB9dESvQ0468nQv93JcOnre1QQuKFJ0GXHjD0315zIVi+jvItaWBmFWvVpVIcmzdm7Lm
         E3kxWPT3yp3KF+10wREfePMWFoIUhlstobs1cejYN1ypVwCeWFGAEaA4FTs25LiZsDog
         8SGMa4WXMaw91UWIFeAGKACwRU5zNFsXZY+Ch9vAkPdEGxwPw6Wkfgf002BDY097QILL
         3FrAah6rjysNmq5rsMLP45jt6TZKLB60P/761DdOYEOViuhLM/FbEM8qaAVTJMhqRxPm
         JuJg==
X-Gm-Message-State: AOAM531ubIgTH+FL+kv9GCB1hL8PheSK61lNMe+u6BUGyKjPtueH9Tbs
        vXlp3vTWdkJWm6gAhch2qLIlqkjArqf1qLkp1U2F8SRN/BcO1Gj0KLbHGTm80Rc1xvrvZ+YIZ/0
        MmbObRlJdodnqFGv/GJ0/JhgRNNpr5P7gkXhYkWNb
X-Received: by 2002:a63:1514:: with SMTP id v20mr576245pgl.203.1606876059374;
        Tue, 01 Dec 2020 18:27:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSJ8R0B92O5F3oBauIq411KXta9R2sA3A1MD3U3rRfyZtoJjnNKARUpPkOxjr1Guuriz8gsSvh4ObPZcysvGU=
X-Received: by 2002:a63:1514:: with SMTP id v20mr576227pgl.203.1606876059014;
 Tue, 01 Dec 2020 18:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20201129064351.63618-1-elic@nvidia.com> <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx> <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx> <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org> <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <20201201063124-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201201063124-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Wed, 2 Dec 2020 10:27:02 +0800
Message-ID: <CACLfguUvb-04584jKBnh+9y0KHNn7eqxSAjK6y1OqZMGTsvMKQ@mail.gmail.com>
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

On Tue, Dec 1, 2020 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 01, 2020 at 05:23:18PM +0800, Cindy Lu wrote:
> > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > >
> > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > > >
> > > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wr=
ote:
> > > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirki=
n wrote:
> > > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote=
:
> > > > > > > > > > We should not try to use the VF MAC address as that is =
used by the
> > > > > > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, u=
se a random
> > > > > > > > > > generated MAC address.
> > > > > > > > > >
> > > > > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for su=
pported mlx5 devices")
> > > > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > > >
> > > > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > > > with and without vdpa.
> > > > > > > >
> > > > > > > > Using a VF you can create quite a few resources, e.g. send =
queues
> > > > > > > > recieve queues, virtio_net queues etc. So you can possibly =
create
> > > > > > > > several instances of vdpa net devices and nic net devices.
> > > > > > > >
> > > > > > > > > Could you include a bit more description on the failure
> > > > > > > > > mode?
> > > > > > > >
> > > > > > > > Well, using the MAC address of the nic vport is wrong since=
 that is the
> > > > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > > > >
> > > > > > > Right but ATM it doesn't coexist with vdpa so what's the prob=
lem?
> > > > > > >
> > > > > >
> > > > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > > > >
> > > > > > > > > Is switching to a random mac for such an unusual
> > > > > > > > > configuration really justified?
> > > > > > > >
> > > > > > > > Since I can't use the NIC's MAC address, I have two options=
:
> > > > > > > > 1. To get the MAC address as was chosen by the user adminis=
tering the
> > > > > > > >    NIC. This should invoke the set_config callback. Unfortu=
nately this
> > > > > > > >    is not implemented yet.
> > > > > > > >
> > > > > > > > 2. Use a random MAC address. This is OK since if (1) is imp=
lemented it
> > > > > > > >    can always override this random configuration.
> > > > > > > >
> > > > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > > > can it not?
> > > > > > > > >
> > > > > > > >
> > > > > > > > No, it will not. The current version of mlx5 VDPA does not =
allow regular
> > > > > > > > NIC driver and VDPA to co-exist. I have patches ready that =
enable that
> > > > > > > > from steering point of view. I will post them here once oth=
er patches on
> > > > > > > > which they depend will be merged.
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/netdev/patch/202011202=
30339.651609-12-saeedm@nvidia.com/
> > > > > > >
> > > > > > > Could you be more explicit on the following points:
> > > > > > > - which configuration is broken ATM (as in, two device have i=
dentical
> > > > > > >   macs? any other issues)?
> > > > > >
> > > > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_a=
ddress().
> > > > > > It's not breaking anything yet is wrong. The random MAC address=
 setting
> > > > > > is required for the steering patches.
> > > > >
> > > > > Okay so I'm not sure the Fixes tag at least is appropriate if it'=
s a
> > > > > dependency of a new feature.
> > > > >
> > > > > > > - why won't device MAC change from guest point of view?
> > > > > > >
> > > > > >
> > > > > > It's lack of implementation in qemu as far as I know.
> > > > >
> > > > > Sorry not sure I understand. What's not implemented in QEMU?
> > > > >
> > > > HI Michael, there are some bug in qemu to set_config, this will fix=
 in future,
> > > > But this patch is still needed, because without this patch the mlx
> > > > driver will give an 0 mac address to qemu
> > > > and qemu will overwrite the default mac address.  This will cause t=
raffic down.
> > >
> > > Hmm the patch description says VF mac address, not 0 address. Confuse=
d.
> > > If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> > > use a random value ...
> > >
> > hi Michael=EF=BC=8C
> > I have tried as your suggestion, seems even remove the
> > VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
> > default address in  VM,
> > this process is like
> > vdpa _init -->qemu call get_config ->mlx driver will give  an mac
> > address with all 0-->
> > qemu will not check this mac address and use it --> overwrite the mac
> > address in qemu
>
> Right but guest will ignore it then, right?
>
I have tired, but guest will use it, here is some information from guest
[root@localhost ~]# cat /sys/bus/pci/devices/0000\:00\:04.0/virtio0/feature=
s
1110010000011000111100010000000010000000000000000000000000000000
[root@localhost ~]# ifconfig -a
eth0: flags=3D4098<BROADCAST,MULTICAST>  mtu 1500
        ether 00:00:00:00:00:00  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
For my understanding, this NIC should have MAC address by default ,
and this should not depend on
any other function/use case,for driver itself it's incorrect to give
an mac address with all 0 to  qemu without error/fail

Thanks
Cindy
> > So for my understanding there are several method to fix this problem
> >
> > 1, qemu check the mac address, if the mac address is all 0, qemu will
> > ignore it and set the random mac address to mlx driver.
> > 2. mlx driver checks the mac address and if this mac is 0, return fail
> > to qemu, but this need to change the UAPI.
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
> > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/driver=
s/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct m=
lx5_core_dev *mdev)
> > > > > > > > > >       if (err)
> > > > > > > > > >               goto err_mtu;
> > > > > > > > > >
> > > > > > > > > > -     err =3D mlx5_query_nic_vport_mac_address(mdev, 0,=
 0, config->mac);
> > > > > > > > > > -     if (err)
> > > > > > > > > > -             goto err_mtu;
> > > > > > > > > > -
> > > > > > > > > > +     eth_random_addr(config->mac);
> > > > > > > > > >       mvdev->vdev.dma_dev =3D mdev->device;
> > > > > > > > > >       err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > > > > >       if (err)
> > > > > > > > > > --
> > > > > > > > > > 2.26.2
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

