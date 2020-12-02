Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272292CB4C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgLBF6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:58:01 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18567 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgLBF6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:58:00 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc72cc00000>; Tue, 01 Dec 2020 21:57:20 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 05:57:18 +0000
Date:   Wed, 2 Dec 2020 07:57:14 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
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
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606888640; bh=S/I3nyXsabZgTsPwG212nfh812Q6Bj5OdbYCvgzL54o=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:Content-Transfer-Encoding:
         In-Reply-To:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=IcRYpFi0stHxwtxOoFzrz2nS8c7zYT3qWwdUZzLndGhVgBEhudWzgRzbdSS7R80Op
         5rKPpBxWuXKIlo1k476iOPCKMafGx68/tROiwfZyLfwdpU/AHFvi6J3fLIGIrGhTGR
         CM9hfvP8q28tijfckW+31D48CW49oe7K45M6niwTNmcXYM5flFNsSNxt54+Un8nQ/T
         iyaAk7s9/9niah+fAsCIpaE7nheVxy54CnHhjlWOA58xFlGHOjuxIjyn2HVJ3ZqANe
         7/yjFvgoPDJTBUl+6+sFz8sqN32C4J0aEYuv9p1WZmwdIH5veJfXHoHE3HDSgm7BfZ
         JON0eu//OpoDw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:18:36PM +0800, Jason Wang wrote:
>=20
> On 2020/12/1 =E4=B8=8B=E5=8D=885:23, Cindy Lu wrote:
> > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
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
> > > > > > > > > >=20
> > > > > > > > > > Suggested by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for su=
pported mlx5 devices")
> > > > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > > > I didn't realise it's possible to use VF in two ways
> > > > > > > > > with and without vdpa.
> > > > > > > > Using a VF you can create quite a few resources, e.g. send =
queues
> > > > > > > > recieve queues, virtio_net queues etc. So you can possibly =
create
> > > > > > > > several instances of vdpa net devices and nic net devices.
> > > > > > > >=20
> > > > > > > > > Could you include a bit more description on the failure
> > > > > > > > > mode?
> > > > > > > > Well, using the MAC address of the nic vport is wrong since=
 that is the
> > > > > > > > MAC of the regular NIC implementation of mlx5_core.
> > > > > > > Right but ATM it doesn't coexist with vdpa so what's the prob=
lem?
> > > > > > >=20
> > > > > > This call is wrong:  mlx5_query_nic_vport_mac_address()
> > > > > >=20
> > > > > > > > > Is switching to a random mac for such an unusual
> > > > > > > > > configuration really justified?
> > > > > > > > Since I can't use the NIC's MAC address, I have two options=
:
> > > > > > > > 1. To get the MAC address as was chosen by the user adminis=
tering the
> > > > > > > >     NIC. This should invoke the set_config callback. Unfort=
unately this
> > > > > > > >     is not implemented yet.
> > > > > > > >=20
> > > > > > > > 2. Use a random MAC address. This is OK since if (1) is imp=
lemented it
> > > > > > > >     can always override this random configuration.
> > > > > > > >=20
> > > > > > > > > It looks like changing a MAC could break some guests,
> > > > > > > > > can it not?
> > > > > > > > >=20
> > > > > > > > No, it will not. The current version of mlx5 VDPA does not =
allow regular
> > > > > > > > NIC driver and VDPA to co-exist. I have patches ready that =
enable that
> > > > > > > > from steering point of view. I will post them here once oth=
er patches on
> > > > > > > > which they depend will be merged.
> > > > > > > >=20
> > > > > > > > https://patchwork.ozlabs.org/project/netdev/patch/202011202=
30339.651609-12-saeedm@nvidia.com/
> > > > > > > Could you be more explicit on the following points:
> > > > > > > - which configuration is broken ATM (as in, two device have i=
dentical
> > > > > > >    macs? any other issues)?
> > > > > > The only wrong thing is the call to  mlx5_query_nic_vport_mac_a=
ddress().
> > > > > > It's not breaking anything yet is wrong. The random MAC address=
 setting
> > > > > > is required for the steering patches.
> > > > > Okay so I'm not sure the Fixes tag at least is appropriate if it'=
s a
> > > > > dependency of a new feature.
> > > > >=20
> > > > > > > - why won't device MAC change from guest point of view?
> > > > > > >=20
> > > > > > It's lack of implementation in qemu as far as I know.
> > > > > Sorry not sure I understand. What's not implemented in QEMU?
> > > > >=20
> > > > HI Michael, there are some bug in qemu to set_config, this will fix=
 in future,
> > > > But this patch is still needed, because without this patch the mlx
> > > > driver will give an 0 mac address to qemu
> > > > and qemu will overwrite the default mac address.  This will cause t=
raffic down.
> > > Hmm the patch description says VF mac address, not 0 address. Confuse=
d.
> > > If there's no mac we can clear VIRTIO_NET_F_MAC and have guest
> > > use a random value ...
>=20
>=20
> I'm not sure this can work for all types of vDPA (e.g it could not be a
> learning bridge in the swtich).
>=20
>=20
> > >=20
> > hi Michael=EF=BC=8C
> > I have tried as your suggestion, seems even remove the
> > VIRTIO_NET_F_MAC the qemu will still call get_cinfig and overwrite the
> > default address in  VM,
>=20
>=20
> This looks a bug in qemu, in guest driver we had:
>=20
> =C2=A0=C2=A0=C2=A0 /* Configuration may specify what MAC to use.=C2=A0 Ot=
herwise random. */
> =C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 virtio_cread_bytes(vdev,
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0 offsetof(struct virtio_net_config, mac),
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0 dev->dev_addr, dev->addr_len);
> =C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 eth_hw_addr_random(dev);
>=20
>=20
> > this process is like
> > vdpa _init -->qemu call get_config ->mlx driver will give  an mac
> > address with all 0-->
> > qemu will not check this mac address and use it --> overwrite the mac
> > address in qemu
> >=20
> > So for my understanding there are several method to fix this problem
> >=20
> > 1, qemu check the mac address, if the mac address is all 0, qemu will
> > ignore it and set the random mac address to mlx driver.
>=20
>=20
> So my understanding is that, if mac address is all 0, vDPA parent should =
not
> advertise VIRTIO_NET_F_MAC. And qemu should emulate this feature as you d=
id:

Thinking it over, at least in mlx5, I should always advertise
VIRTIO_NET_F_MAC and set a non zero MAC value. The source of the MAC can
be either randomly generated value by mlx5_vdpa or by a management tool.
This is important becauase we should not let the VM modify the MAC. If
we do it can set a MAC value identical to the mlx5 NIC driver and can
kidnap traffic that was not destined to it.

In addition, when VIRTIO_NET_F_MAC is published, attempts to change the
MAC address from the VM should result in error.


>=20
> 1) get a random mac
> 2) advertise VIRTIO_NET_F_MAC
> 3) set the random mac to vDPA through set_config
> 4) advertise the random mac to emulated config to guest
>=20
>=20
> > 2. mlx driver checks the mac address and if this mac is 0, return fail
> > to qemu, but this need to change the UAPI.
>=20
>=20
> uAPI is probably fine since ioctl can fail.=C2=A0 We can change the to al=
low the
> set_config to fail but virito spec doesn't have a way to advertise the er=
ror
> in this case. Anyway, the driver only risk itself for setting a wrong val=
ue,
> so we're probably fine.
>=20
> Thanks
>=20
>=20
> > 3. mlx driver it shelf should get an correct mac address while it init.
> > 4. add check in qemu get_config function  , if there is not F_MAC Then
> > ignore the mac address from mlx driver
> >=20
> > not sure which method is more suitable ?
> >=20
> > Thanks
> > Cindy
> >=20
> >=20
> >=20
> > > > > > > > > > ---
> > > > > > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
> > > > > > > > > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/driver=
s/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > index 1fa6fcac8299..80d06d958b8b 100644
> > > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct m=
lx5_core_dev *mdev)
> > > > > > > > > >        if (err)
> > > > > > > > > >                goto err_mtu;
> > > > > > > > > >=20
> > > > > > > > > > -     err =3D mlx5_query_nic_vport_mac_address(mdev, 0,=
 0, config->mac);
> > > > > > > > > > -     if (err)
> > > > > > > > > > -             goto err_mtu;
> > > > > > > > > > -
> > > > > > > > > > +     eth_random_addr(config->mac);
> > > > > > > > > >        mvdev->vdev.dma_dev =3D mdev->device;
> > > > > > > > > >        err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > > > > > > > >        if (err)
> > > > > > > > > > --
> > > > > > > > > > 2.26.2
>=20
