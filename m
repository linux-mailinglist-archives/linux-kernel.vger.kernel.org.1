Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6862C7E37
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgK3G2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:28:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11717 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgK3G2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:28:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc490e50000>; Sun, 29 Nov 2020 22:27:49 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Nov
 2020 06:27:50 +0000
Date:   Mon, 30 Nov 2020 08:27:46 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201129150505-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606717669; bh=ep9xTG9sNfYfcrW8BqNPTsulOQslIrId4k0wujUhtZc=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=oy2DY1XEi3jJ/CrspVcFyjYYePbBTPpX94JbePeIm2YqNzfVKnmk/u1hJKDOFc3LF
         Qp5gN75HaR2mvIoG7TCm94ATfcCA/yOSwaSa2nYc1i0sV1Zj6Pk2PEYsDnyEvVzhZ1
         UjKsmz/zScxxyb9YbDE9cP8hVz/zZLylZO1f7weMmcyw2g8EOtbEiKjvBaBa53F2bY
         44smooH0EzWebhxskwDvTSyEIJm/UUp36l4s9mGtQ0IJncwaLzo+9qeKvTuucc8clM
         7vrousy9j5cUNSmLmj6CzvYUoYi0JyBZEx6SHqN5kyKSKHz9xj6baqrXvkpC4TzJL8
         WxaR1QBMMj9iw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 03:08:22PM -0500, Michael S. Tsirkin wrote:
> On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> > We should not try to use the VF MAC address as that is used by the
> > regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> > generated MAC address.
> > 
> > Suggested by: Cindy Lu <lulu@redhat.com>
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> 
> I didn't realise it's possible to use VF in two ways
> with and without vdpa.

Using a VF you can create quite a few resources, e.g. send queues
recieve queues, virtio_net queues etc. So you can possibly create
several instances of vdpa net devices and nic net devices.

> Could you include a bit more description on the failure
> mode?

Well, using the MAC address of the nic vport is wrong since that is the
MAC of the regular NIC implementation of mlx5_core.

> Is switching to a random mac for such an unusual
> configuration really justified?

Since I can't use the NIC's MAC address, I have two options:
1. To get the MAC address as was chosen by the user administering the
   NIC. This should invoke the set_config callback. Unfortunately this
   is not implemented yet.

2. Use a random MAC address. This is OK since if (1) is implemented it
   can always override this random configuration.

> It looks like changing a MAC could break some guests,
> can it not?
>

No, it will not. The current version of mlx5 VDPA does not allow regular
NIC driver and VDPA to co-exist. I have patches ready that enable that
from steering point of view. I will post them here once other patches on
which they depend will be merged.

https://patchwork.ozlabs.org/project/netdev/patch/20201120230339.651609-12-saeedm@nvidia.com/
 
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 1fa6fcac8299..80d06d958b8b 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
> >  	if (err)
> >  		goto err_mtu;
> >  
> > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > -	if (err)
> > -		goto err_mtu;
> > -
> > +	eth_random_addr(config->mac);
> >  	mvdev->vdev.dma_dev = mdev->device;
> >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> >  	if (err)
> > -- 
> > 2.26.2
> 
