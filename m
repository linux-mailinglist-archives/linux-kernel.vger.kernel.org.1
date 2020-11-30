Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEDD2C838C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgK3Lvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:51:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16985 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgK3Lvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:51:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc4dcb80000>; Mon, 30 Nov 2020 03:51:20 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Nov
 2020 11:51:10 +0000
Date:   Mon, 30 Nov 2020 13:51:06 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lulu@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201130115106.GC99449@mtl-vdi-166.wap.labs.mlnx>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201130043050-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606737080; bh=3Yjm2rXCYlzW1B54g8g6dZvWZtd9aaatA3YiUa/pRD8=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=CyW/2lnhXTVaFPN4wgHeQVVFEfwTaybHzWlrbm2nyyF8j1PnCB0UgGxb3hbXTJ9LN
         4s35cGBRJz0nlnahh77YIj89nQPqOGM8e15o4vC2otzEssKQH0qm4NG7AqAGt/zjlB
         zeuOVhtZPkE4xSMWW4O80upiB89k8P6xCjVeCPHEK0puFpoNqNWD0Q1I5teA3yHY4F
         uIC34f08MLTnCKgMWf08sJwD3a5dxHrvm0EYpTENc6UGay3girXBqWw5M78lyIWZre
         ndFRwsdcnp/F14BFaV/kGD0EcPZTCZVqjX/c9FM/Z1hlh8QO4lFrCzuKZ/rcRJpK+V
         cH3NhSiugTxvA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 04:33:09AM -0500, Michael S. Tsirkin wrote:
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

OK, let's leave it for now. I will push along with the steering patches.
The meaning is the the VDPA net device instance is create with a MAC of
all zeros which also mean the link is down. You can set a MAC which will
let the link come up. The vdpa driver will not get a callback as I
stated but since current mode of steering directs all traffic to the
vdpa instance it will work. In the future this must be fixed.

> > > - why won't device MAC change from guest point of view?
> > > 
> > 
> > It's lack of implementation in qemu as far as I know.
> 
> Sorry not sure I understand. What's not implemented in QEMU?
> 

vdpa config operation set_config() should be called whenever the MAC is
changed, e.g. when administrator of the vdpa net device changes the mac.
This does not happen which is a bug.

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
> > > > > >  	if (err)
> > > > > >  		goto err_mtu;
> > > > > >  
> > > > > > -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> > > > > > -	if (err)
> > > > > > -		goto err_mtu;
> > > > > > -
> > > > > > +	eth_random_addr(config->mac);
> > > > > >  	mvdev->vdev.dma_dev = mdev->device;
> > > > > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > >  	if (err)
> > > > > > -- 
> > > > > > 2.26.2
> > > > > 
> > > 
> 
