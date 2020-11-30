Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C522C8815
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgK3Peg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgK3Peg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606750389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LgmtIu6NywG32ioz0iysYLpbYawJ9kmk2cBjeIzMVD4=;
        b=EtVyn+8mGUmXjNMkD3AWxp/KVGmCrneCGoIq2p5ThJu+pNJerHU0kZBvoxc7+TWBaue31J
        7/KVRUlr6cu7EXk3EgPqN/bqKIG7hT92+1ndlsI1/QuIpzRQoszeOMAFtQ1tR82l9PLUeM
        MSWFQQMbmJJReniZifKai3p1ZBeaBiQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-IH9qqTh2OAiAHzyj3hjFhw-1; Mon, 30 Nov 2020 10:33:05 -0500
X-MC-Unique: IH9qqTh2OAiAHzyj3hjFhw-1
Received: by mail-wr1-f70.google.com with SMTP id z13so8495690wrm.19
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LgmtIu6NywG32ioz0iysYLpbYawJ9kmk2cBjeIzMVD4=;
        b=hGVTU5qKBc2FZb0BdsElvosviet5AUQzoZsRbcX0t1TxcQusBw2udsODe2TeI6W++Q
         xfw2aZl+Dakq0Tm5KYB0l+3pUE+JwaUhdZ7fldBVW2VJFjtbxBNOuc8+pm0VUMUEcXIC
         bmG9mANpTVAClRkNICHx2f1KMIHjbHprJMjw6vF5VF8ErWZXioEVFE9LxLa25dcYAQkh
         gCey66OGq3Ckc1vfGRYqsdHjFir3oDQS84oGOlFRLFBpF0D5afIKYPy+RndUfdlFBrRV
         LKcWM3g1hu3jXfKQ1Sy3NTMT3SCYRGNkp+u/8z/PjVioXHygAwIy13IQBRmQXIF8FPjC
         uwYA==
X-Gm-Message-State: AOAM533969aGiY0lzWAqV6PN8oyMTaXAF78sXcPie3IoDx+1WOHpabf8
        2Sw6v25Te0xu2wNfvy/1hNHJAL4tt9+VIpaDH1bFzznRh0EGuff6iIHvavosFz5nkUvXOsSec6W
        Vrscoqc3aC4PR5ssTo7N9wuMJ
X-Received: by 2002:a5d:6805:: with SMTP id w5mr29233203wru.266.1606750383875;
        Mon, 30 Nov 2020 07:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywMuYeSVYDjXV3EOxn3sApgn14cOXuE9z8SSQHXhUh2qp2qnZeHPucW8U3SaHg2j+lsQKsoA==
X-Received: by 2002:a5d:6805:: with SMTP id w5mr29233185wru.266.1606750383678;
        Mon, 30 Nov 2020 07:33:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id r13sm22228346wrm.25.2020.11.30.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:33:02 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:33:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130103142-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
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
> > > > - why won't device MAC change from guest point of view?
> > > >
> > >
> > > It's lack of implementation in qemu as far as I know.
> >
> > Sorry not sure I understand. What's not implemented in QEMU?
> >
> HI Michael, there are some bug in qemu to set_config, this will fix in future,
> But this patch is still needed, because without this patch the mlx
> driver will give an 0 mac address to qemu
> and qemu will overwrite the default mac address.  This will cause traffic down.

Hmm the patch description says VF mac address, not 0 address. Confused.
If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
use a random value ...

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
> > > > > > >       if (err)
> > > > > > >               goto err_mtu;
> > > > > > >
> > > > > > > -     err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > > -     if (err)
> > > > > > > -             goto err_mtu;
> > > > > > > -
> > > > > > > +     eth_random_addr(config->mac);
> > > > > > >       mvdev->vdev.dma_dev = mdev->device;
> > > > > > >       err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > >       if (err)
> > > > > > > --
> > > > > > > 2.26.2
> > > > > >
> > > >
> >

