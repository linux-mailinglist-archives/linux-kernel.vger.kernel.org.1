Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D763D2C8271
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgK3Kny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727818AbgK3Knx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606732946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TAOzrB1JNY9m5cJZp5Sd6U0cG3CpY/RY5rrZyGT/PLI=;
        b=HTqeYw1kMQIyysnoZdVbaTXffl6dl/5cmFIOHRv08zxLSXM0hU1ZrDY+pl2Os2bzVj2BIg
        S5NdZGnnRRYBjT8nGmP9SOxLu4kZ8f7TsOIzA11P9n9F3h/bcrklRTykOuqXFOq/MFwi7w
        LFjLffZsBQH2pstDDeGQwKkB5iyhXj8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-skr0V_yfPSC3NbJyZqRRUQ-1; Mon, 30 Nov 2020 05:42:23 -0500
X-MC-Unique: skr0V_yfPSC3NbJyZqRRUQ-1
Received: by mail-pl1-f197.google.com with SMTP id ba3so7457987plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAOzrB1JNY9m5cJZp5Sd6U0cG3CpY/RY5rrZyGT/PLI=;
        b=byi7XxsVpJ6ucoIH4NIjNXz7xvtopDb08oxgx/OihsfyQ4G/eqzHwpv+kjpz/+xGJL
         0vV7p2dVRzI5tpq73m7NxbhWbmgLzebNI82cM7F3woSC9ueqbE9nr81juagEn5OK1MNn
         3oVHpgUuDHASf5SXZOKPMr5QcBckM7r6Rlsg628zRI/dbSuJErnuQs+ntFhDadQzvQGo
         7LqcFo9PJUoHO64/Je2AkD4nrzmKZ43a6oR29QASJws6ejABy57iWxoo4VS9N5fk6Kj2
         qdOrA1PHruZeFN1T80tcCurHaev6ngex9kwXbalN99nV6K6E+uXDqR3MbwSY/kbLG6iU
         N0gg==
X-Gm-Message-State: AOAM532NabskepsCRzIbD+SfQsnUlUT9h5ATLOHbCcMz9V3yPDhqkkoF
        H6odCa6z6jgOMQ/OuZ6O0p/d6xJkRiyQLGUcc+cJGqI2fht1drW7AzJ7URm2hXGg2fpsBeRZzJ0
        G6NaxuUwUnALasp6O2MdcccwP7pjAqOJjXPTRmM7H
X-Received: by 2002:a63:1514:: with SMTP id v20mr17173190pgl.203.1606732942060;
        Mon, 30 Nov 2020 02:42:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLMmCKo2lY01uZqANDDMDZYSfT0+RFaNOGs+jH0YjAE6/iiHA/MZM6xvifVLYPA1JvIPRWELGWgLy55MsWwPs=
X-Received: by 2002:a63:1514:: with SMTP id v20mr17173173pgl.203.1606732941762;
 Mon, 30 Nov 2020 02:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20201129064351.63618-1-elic@nvidia.com> <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx> <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx> <20201130043050-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201130043050-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Mon, 30 Nov 2020 18:41:45 +0800
Message-ID: <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen wrote:
> > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > > > We should not try to use the VF MAC address as that is used by the
> > > > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > > > generated MAC address.
> > > > > >
> > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > >
> > > > > I didn't realise it's possible to use VF in two ways
> > > > > with and without vdpa.
> > > >
> > > > Using a VF you can create quite a few resources, e.g. send queues
> > > > recieve queues, virtio_net queues etc. So you can possibly create
> > > > several instances of vdpa net devices and nic net devices.
> > > >
> > > > > Could you include a bit more description on the failure
> > > > > mode?
> > > >
> > > > Well, using the MAC address of the nic vport is wrong since that is the
> > > > MAC of the regular NIC implementation of mlx5_core.
> > >
> > > Right but ATM it doesn't coexist with vdpa so what's the problem?
> > >
> >
> > This call is wrong:  mlx5_query_nic_vport_mac_address()
> >
> > > > > Is switching to a random mac for such an unusual
> > > > > configuration really justified?
> > > >
> > > > Since I can't use the NIC's MAC address, I have two options:
> > > > 1. To get the MAC address as was chosen by the user administering the
> > > >    NIC. This should invoke the set_config callback. Unfortunately this
> > > >    is not implemented yet.
> > > >
> > > > 2. Use a random MAC address. This is OK since if (1) is implemented it
> > > >    can always override this random configuration.
> > > >
> > > > > It looks like changing a MAC could break some guests,
> > > > > can it not?
> > > > >
> > > >
> > > > No, it will not. The current version of mlx5 VDPA does not allow regular
> > > > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > > > from steering point of view. I will post them here once other patches on
> > > > which they depend will be merged.
> > > >
> > > > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > >
> > > Could you be more explicit on the following points:
> > > - which configuration is broken ATM (as in, two device have identical
> > >   macs? any other issues)?
> >
> > The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
> > It's not breaking anything yet is wrong. The random MAC address setting
> > is required for the steering patches.
>
> Okay so I'm not sure the Fixes tag at least is appropriate if it's a
> dependency of a new feature.
>
> > > - why won't device MAC change from guest point of view?
> > >
> >
> > It's lack of implementation in qemu as far as I know.
>
> Sorry not sure I understand. What's not implemented in QEMU?
>
HI Michael, there are some bug in qemu to set_config, this will fix in future,
But this patch is still needed, because without this patch the mlx
driver will give an 0 mac address to qemu
and qemu will overwrite the default mac address.  This will cause traffic down.

> > >
> > > > > > ---
> > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > > > >       if (err)
> > > > > >               goto err_mtu;
> > > > > >
> > > > > > -     err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > -     if (err)
> > > > > > -             goto err_mtu;
> > > > > > -
> > > > > > +     eth_random_addr(config->mac);
> > > > > >       mvdev->vdev.dma_dev = mdev->device;
> > > > > >       err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > >       if (err)
> > > > > > --
> > > > > > 2.26.2
> > > > >
> > >
>

