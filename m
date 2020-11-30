Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4774A2C80FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgK3J2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:28:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9737 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgK3J2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:28:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc4bb270001>; Mon, 30 Nov 2020 01:28:07 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Nov
 2020 09:28:02 +0000
Date:   Mon, 30 Nov 2020 11:27:59 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201130035147-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606728487; bh=66t5Ep5UUnJXYMkoN5x+IuwgmV4CIg+W0P0Dbmf+nL8=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=YcKvw2FIXTXudztF3CQSzBJmSwX6YHtdaSb2Nj0K1GFMnaZGIrqNuL14amGz4pctY
         NRchWnV1XLOuaaKUvpF7PMpM23eG19lV47LocsaaYdTSA3r0aKg7L4+pXnIGsaQIGw
         QGAxrQtvtKmuKGRXqeDrAyuSrMZ3CdOhO5f1YHCJaLmoBVLgeo3QaudDVFv7dGTg2G
         0g+Tr61zsP9W4xQXXH8mTIrxFMQqo44TV3hLJocGFTA14O2Of0enkzVxEbxsF8psnr
         POZHWErs9ssyatXCti9/5r6MDpt5zRqHd0AfzD5GTVuQ3HMHNi1aziP9BTy5vno83+
         sZZl5n3aiGO5g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Cohen wrote:
> > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > > > We should not try to use the VF MAC address as that is used by the
> > > > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > > > generated MAC address.
> > > > 
> > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > 
> > > I didn't realise it's possible to use VF in two ways
> > > with and without vdpa.
> > 
> > Using a VF you can create quite a few resources, e.g. send queues
> > recieve queues, virtio_net queues etc. So you can possibly create
> > several instances of vdpa net devices and nic net devices.
> > 
> > > Could you include a bit more description on the failure
> > > mode?
> > 
> > Well, using the MAC address of the nic vport is wrong since that is the
> > MAC of the regular NIC implementation of mlx5_core.
> 
> Right but ATM it doesn't coexist with vdpa so what's the problem?
> 

This call is wrong:  mlx5_query_nic_vport_mac_address()

> > > Is switching to a random mac for such an unusual
> > > configuration really justified?
> > 
> > Since I can't use the NIC's MAC address, I have two options:
> > 1. To get the MAC address as was chosen by the user administering the
> >    NIC. This should invoke the set_config callback. Unfortunately this
> >    is not implemented yet.
> > 
> > 2. Use a random MAC address. This is OK since if (1) is implemented it
> >    can always override this random configuration.
> > 
> > > It looks like changing a MAC could break some guests,
> > > can it not?
> > >
> > 
> > No, it will not. The current version of mlx5 VDPA does not allow regular
> > NIC driver and VDPA to co-exist. I have patches ready that enable that
> > from steering point of view. I will post them here once other patches on
> > which they depend will be merged.
> > 
> > https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
> 
> Could you be more explicit on the following points:
> - which configuration is broken ATM (as in, two device have identical
>   macs? any other issues)?

The only wrong thing is the call to  mlx5_query_nic_vport_mac_address().
It's not breaking anything yet is wrong. The random MAC address setting
is required for the steering patches.

> - why won't device MAC change from guest point of view?
> 

It's lack of implementation in qemu as far as I know.

> 
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> > > >  	if (err)
> > > >  		goto err_mtu;
> > > >  
> > > > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > -	if (err)
> > > > -		goto err_mtu;
> > > > -
> > > > +	eth_random_addr(config->mac);
> > > >  	mvdev->vdev.dma_dev = mdev->device;
> > > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > >  	if (err)
> > > > -- 
> > > > 2.26.2
> > > 
> 
