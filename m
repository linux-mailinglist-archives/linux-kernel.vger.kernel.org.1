Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706162CD531
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgLCMKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:10:16 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8075 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387983AbgLCMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:10:15 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8d57f0000>; Thu, 03 Dec 2020 04:09:35 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 12:09:33 +0000
Date:   Thu, 3 Dec 2020 14:09:29 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201203120929.GA38007@mtl-vdi-166.wap.labs.mlnx>
References: <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
 <20201202165932-mutt-send-email-mst@kernel.org>
 <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
 <20201203054330-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201203054330-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606997375; bh=pVqN5SNT846fKrKSf6t+/xOvyhCYYlNVhd8b5CxCMAo=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:Content-Transfer-Encoding:
         In-Reply-To:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=hpZBK7VfTsHmRNmL4oAl6UhRpQlzuOixtc/4KXcAef4iaFv5ldVqz4MJuNGWx95aW
         W74achJEB7QHxGoL/7djGuVMREZmOcTQFOhuVQIUkys5awhJOnWW/nRhcrIkrHTqzA
         ArHmVModb1Z61Abu0K18o/KLUPu6N7X8PuMlgLpuQHZpbX2ggyHxnkyFaySOqXMy74
         IS7rH26Z0E/s7Ee0wXwgA0c2vp6miMvqvnmRh2Rtv9vOdsFTl25ZCjqq+nKVAYfMqK
         dOudw8ndD1Fg3Np5zMUL/jgr0i67nK08kq5ZCsrd8O3iZGGTEjqITDJGFuEhoq6fgy
         IBufh2XAEWp2w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 05:44:17AM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 03, 2020 at 08:49:28AM +0200, Eli Cohen wrote:
> > On Wed, Dec 02, 2020 at 05:00:22PM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Dec 02, 2020 at 09:48:25PM +0800, Jason Wang wrote:
> > > >=20
> > > > On 2020/12/2 =E4=B8=8B=E5=8D=885:23, Michael S. Tsirkin wrote:
> > > > > On Wed, Dec 02, 2020 at 07:57:14AM +0200, Eli Cohen wrote:
> > > > > > On Wed, Dec 02, 2020 at 12:18:36PM +0800, Jason Wang wrote:
> > > > > > > On 2020/12/1 =E4=B8=8B=E5=8D=885:23, Cindy Lu wrote:
> > > > > > > > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin<mst@red=
hat.com>  wrote:
> > > > > > > > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wrote:
> > > > > > > > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin<mst@=
redhat.com>  wrote:
> > > > > > > > > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Cohen w=
rote:
> > > > > > > > > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Michael S=
. Tsirkin wrote:
> > > > > > > > > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli Coh=
en wrote:
> > > > > > > > > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, Micha=
el S. Tsirkin wrote:
> > > > > > > > > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli=
 Cohen wrote:
> > > > > > > > > > > > > > > > We should not try to use the VF MAC address=
 as that is used by the
> > > > > > > > > > > > > > > > regular (e.g. mlx5_core) NIC implementation=
. Instead, use a random
> > > > > > > > > > > > > > > > generated MAC address.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Suggested by: Cindy Lu<lulu@redhat.com>
> > > > > > > > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA d=
river for supported mlx5 devices")
> > > > > > > > > > > > > > > > Signed-off-by: Eli Cohen<elic@nvidia.com>
> > > > > > > > > > > > > > > I didn't realise it's possible to use VF in t=
wo ways
> > > > > > > > > > > > > > > with and without vdpa.
> > > > > > > > > > > > > > Using a VF you can create quite a few resources=
, e.g. send queues
> > > > > > > > > > > > > > recieve queues, virtio_net queues etc. So you c=
an possibly create
> > > > > > > > > > > > > > several instances of vdpa net devices and nic n=
et devices.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Could you include a bit more description on t=
he failure
> > > > > > > > > > > > > > > mode?
> > > > > > > > > > > > > > Well, using the MAC address of the nic vport is=
 wrong since that is the
> > > > > > > > > > > > > > MAC of the regular NIC implementation of mlx5_c=
ore.
> > > > > > > > > > > > > Right but ATM it doesn't coexist with vdpa so wha=
t's the problem?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > This call is wrong:  mlx5_query_nic_vport_mac_addre=
ss()
> > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Is switching to a random mac for such an unus=
ual
> > > > > > > > > > > > > > > configuration really justified?
> > > > > > > > > > > > > > Since I can't use the NIC's MAC address, I have=
 two options:
> > > > > > > > > > > > > > 1. To get the MAC address as was chosen by the =
user administering the
> > > > > > > > > > > > > >      NIC. This should invoke the set_config cal=
lback. Unfortunately this
> > > > > > > > > > > > > >      is not implemented yet.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 2. Use a random MAC address. This is OK since i=
f (1) is implemented it
> > > > > > > > > > > > > >      can always override this random configurat=
ion.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > It looks like changing a MAC could break some=
 guests,
> > > > > > > > > > > > > > > can it not?
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > No, it will not. The current version of mlx5 VD=
PA does not allow regular
> > > > > > > > > > > > > > NIC driver and VDPA to co-exist. I have patches=
 ready that enable that
> > > > > > > > > > > > > > from steering point of view. I will post them h=
ere once other patches on
> > > > > > > > > > > > > > which they depend will be merged.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/netdev/pat=
ch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > > > > > > > > > > Could you be more explicit on the following point=
s:
> > > > > > > > > > > > > - which configuration is broken ATM (as in, two d=
evice have identical
> > > > > > > > > > > > >     macs? any other issues)?
> > > > > > > > > > > > The only wrong thing is the call to  mlx5_query_nic=
_vport_mac_address().
> > > > > > > > > > > > It's not breaking anything yet is wrong. The random=
 MAC address setting
> > > > > > > > > > > > is required for the steering patches.
> > > > > > > > > > > Okay so I'm not sure the Fixes tag at least is approp=
riate if it's a
> > > > > > > > > > > dependency of a new feature.
> > > > > > > > > > >=20
> > > > > > > > > > > > > - why won't device MAC change from guest point of=
 view?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > It's lack of implementation in qemu as far as I kno=
w.
> > > > > > > > > > > Sorry not sure I understand. What's not implemented i=
n QEMU?
> > > > > > > > > > >=20
> > > > > > > > > > HI Michael, there are some bug in qemu to set_config, t=
his will fix in future,
> > > > > > > > > > But this patch is still needed, because without this pa=
tch the mlx
> > > > > > > > > > driver will give an 0 mac address to qemu
> > > > > > > > > > and qemu will overwrite the default mac address.  This =
will cause traffic down.
> > > > > > > > > Hmm the patch description says VF mac address, not 0 addr=
ess. Confused.
> > > > > > > > > If there's no mac we can clear VIRTIO_NET_F_MAC and have =
guest
> > > > > > > > > use a random value ...
> > > > > > > I'm not sure this can work for all types of vDPA (e.g it coul=
d not be a
> > > > > > > learning bridge in the swtich).
> > > > > > >=20
> > > > > > >=20
> > > > > > > > hi Michael=EF=BC=8C
> > > > > > > > I have tried as your suggestion, seems even remove the
> > > > > > > > VIRTIO_NET_F_MAC the qemu will still call get_cinfig and ov=
erwrite the
> > > > > > > > default address in  VM,
> > > > > > > This looks a bug in qemu, in guest driver we had:
> > > > > > >=20
> > > > > > >  =C2=A0=C2=A0=C2=A0 /* Configuration may specify what MAC to =
use.=C2=A0 Otherwise random. */
> > > > > > >  =C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_NET_F=
_MAC))
> > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 virtio_cread_bytes(vde=
v,
> > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0 offsetof(struct virtio_net_config, mac),
> > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0 dev->dev_addr, dev->addr_len);
> > > > > > >  =C2=A0=C2=A0=C2=A0 else
> > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 eth_hw_addr_random(dev=
);
> > > > > > >=20
> > > > > > >=20
> > > > > > > > this process is like
> > > > > > > > vdpa _init -->qemu call get_config ->mlx driver will give  =
an mac
> > > > > > > > address with all 0-->
> > > > > > > > qemu will not check this mac address and use it --> overwri=
te the mac
> > > > > > > > address in qemu
> > > > > > > >=20
> > > > > > > > So for my understanding there are several method to fix thi=
s problem
> > > > > > > >=20
> > > > > > > > 1, qemu check the mac address, if the mac address is all 0,=
 qemu will
> > > > > > > > ignore it and set the random mac address to mlx driver.
> > > > > > > So my understanding is that, if mac address is all 0, vDPA pa=
rent should not
> > > > > > > advertise VIRTIO_NET_F_MAC. And qemu should emulate this feat=
ure as you did:
> > > > > > Thinking it over, at least in mlx5, I should always advertise
> > > > > > VIRTIO_NET_F_MAC and set a non zero MAC value. The source of th=
e MAC can
> > > > > > be either randomly generated value by mlx5_vdpa or by a managem=
ent tool.
> > > > > > This is important becauase we should not let the VM modify the =
MAC. If
> > > > > > we do it can set a MAC value identical to the mlx5 NIC driver a=
nd can
> > > > > > kidnap traffic that was not destined to it.
> > > > > >=20
> > > > > > In addition, when VIRTIO_NET_F_MAC is published, attempts to ch=
ange the
> > > > > > MAC address from the VM should result in error.
> > > > > That is not what the spec says though.
> > > > > VIRTIO_NET_F_MAC only says whether mac is valid in the config spa=
ce.
> > > > > Whether guest can control that depends on VIRTIO_NET_F_CTRL_MAC_A=
DDR:
> > > > >=20
> > > > > 	The VIRTIO_NET_CTRL_MAC_ADDR_SET command is used to set the defa=
ult MAC address which rx
> > > > > 	filtering accepts (and if VIRTIO_NET_F_MAC_ADDR has been negotia=
ted, this will be reflected in mac in
> > > > > 	config space).
> > > > > 	The command-specific-data for VIRTIO_NET_CTRL_MAC_ADDR_SET is th=
e 6-byte MAC address.
> > > >=20
> > > >=20
> > > > Consider VIRTIO_NET_CTRL_MAC_ADDR_SET is not supported now. What El=
i
> > > > proposed here should work?
> > > >=20
> > > > Thanks
> > > >=20
> > >=20
> > > We can have management set a MAC address. Randomizing it in kernel
> > > does not seem like a reasonable policy to me ...
> > >=20
> >=20
> > This manangement should be the VDPA tool that Parav is pushing. We can
> > use it to set a MAC chosen by the user. The mlx5 vdpa driver can then
> > use that MAC instead of randomizing a value. If no admin value is given
> > we can use a random MAC.
>=20
> IIUC in this model devices are created by this tool, right?
> Why not require the MAC when device is created?
>=20

It is mentioned in Parav's patchset that this will be coming in a
subsequent patch to his vdpa tool.=20

> > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > >=20
>=20
