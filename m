Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD12CD576
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgLCMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:25:07 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13712 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgLCMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:25:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8d8fa0000>; Thu, 03 Dec 2020 04:24:26 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 12:24:24 +0000
Date:   Thu, 3 Dec 2020 14:24:21 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201203122421.GB38007@mtl-vdi-166.wap.labs.mlnx>
References: <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
 <20201202165932-mutt-send-email-mst@kernel.org>
 <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
 <20201203054330-mutt-send-email-mst@kernel.org>
 <20201203120929.GA38007@mtl-vdi-166.wap.labs.mlnx>
 <20201203071414-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201203071414-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606998266; bh=NwcmaiKNlMitO7tSakJ9HNs7b6P4137S7PCAUu+AePc=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:Content-Transfer-Encoding:
         In-Reply-To:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=aizC9/zXcC8oYC9P31+BOSlHKeLBJzxW/QxET3E6HAhqaP1oBYNz0M/4CezvRlf7F
         0SI8SNduqrjrnPNVL6S0vkDE8a/nL6xHNPh/VPHOXmArWoDEqwXLvr+90ON1fvAOJU
         J8hSuOP9XYWuFNIqKlRkQrQ3EsZDged8W6bDZ2++iCbeoJpKFjgqZ7DA5dgkyjh9XH
         TtwV0LfJbMiBUwdGY18TQtSMQ47kE2G3ldQHvnbspR/WOwggTH6tcjfz7X2dICQpIo
         qswqqQwtDKGn0+d1YUe3RSdHB6P6ElmLpEscFv+pNwFG6q9nhgW91zrF/wx7ZoL+aU
         6Q+rwAWN/5txw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 07:15:37AM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 03, 2020 at 02:09:29PM +0200, Eli Cohen wrote:
> > On Thu, Dec 03, 2020 at 05:44:17AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Dec 03, 2020 at 08:49:28AM +0200, Eli Cohen wrote:
> > > > On Wed, Dec 02, 2020 at 05:00:22PM -0500, Michael S. Tsirkin wrote:
> > > > > On Wed, Dec 02, 2020 at 09:48:25PM +0800, Jason Wang wrote:
> > > > > >=20
> > > > > > On 2020/12/2 =E4=B8=8B=E5=8D=885:23, Michael S. Tsirkin wrote:
> > > > > > > On Wed, Dec 02, 2020 at 07:57:14AM +0200, Eli Cohen wrote:
> > > > > > > > On Wed, Dec 02, 2020 at 12:18:36PM +0800, Jason Wang wrote:
> > > > > > > > > On 2020/12/1 =E4=B8=8B=E5=8D=885:23, Cindy Lu wrote:
> > > > > > > > > > On Mon, Nov 30, 2020 at 11:33 PM Michael S. Tsirkin<mst=
@redhat.com>  wrote:
> > > > > > > > > > > On Mon, Nov 30, 2020 at 06:41:45PM +0800, Cindy Lu wr=
ote:
> > > > > > > > > > > > On Mon, Nov 30, 2020 at 5:33 PM Michael S. Tsirkin<=
mst@redhat.com>  wrote:
> > > > > > > > > > > > > On Mon, Nov 30, 2020 at 11:27:59AM +0200, Eli Coh=
en wrote:
> > > > > > > > > > > > > > On Mon, Nov 30, 2020 at 04:00:51AM -0500, Micha=
el S. Tsirkin wrote:
> > > > > > > > > > > > > > > On Mon, Nov 30, 2020 at 08:27:46AM +0200, Eli=
 Cohen wrote:
> > > > > > > > > > > > > > > > On Sun, Nov 29, 2020 at 03:08:22PM -0500, M=
ichael S. Tsirkin wrote:
> > > > > > > > > > > > > > > > > On Sun, Nov 29, 2020 at 08:43:51AM +0200,=
 Eli Cohen wrote:
> > > > > > > > > > > > > > > > > > We should not try to use the VF MAC add=
ress as that is used by the
> > > > > > > > > > > > > > > > > > regular (e.g. mlx5_core) NIC implementa=
tion. Instead, use a random
> > > > > > > > > > > > > > > > > > generated MAC address.
> > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > Suggested by: Cindy Lu<lulu@redhat.com>
> > > > > > > > > > > > > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VD=
PA driver for supported mlx5 devices")
> > > > > > > > > > > > > > > > > > Signed-off-by: Eli Cohen<elic@nvidia.co=
m>
> > > > > > > > > > > > > > > > > I didn't realise it's possible to use VF =
in two ways
> > > > > > > > > > > > > > > > > with and without vdpa.
> > > > > > > > > > > > > > > > Using a VF you can create quite a few resou=
rces, e.g. send queues
> > > > > > > > > > > > > > > > recieve queues, virtio_net queues etc. So y=
ou can possibly create
> > > > > > > > > > > > > > > > several instances of vdpa net devices and n=
ic net devices.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Could you include a bit more description =
on the failure
> > > > > > > > > > > > > > > > > mode?
> > > > > > > > > > > > > > > > Well, using the MAC address of the nic vpor=
t is wrong since that is the
> > > > > > > > > > > > > > > > MAC of the regular NIC implementation of ml=
x5_core.
> > > > > > > > > > > > > > > Right but ATM it doesn't coexist with vdpa so=
 what's the problem?
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > This call is wrong:  mlx5_query_nic_vport_mac_a=
ddress()
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Is switching to a random mac for such an =
unusual
> > > > > > > > > > > > > > > > > configuration really justified?
> > > > > > > > > > > > > > > > Since I can't use the NIC's MAC address, I =
have two options:
> > > > > > > > > > > > > > > > 1. To get the MAC address as was chosen by =
the user administering the
> > > > > > > > > > > > > > > >      NIC. This should invoke the set_config=
 callback. Unfortunately this
> > > > > > > > > > > > > > > >      is not implemented yet.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > 2. Use a random MAC address. This is OK sin=
ce if (1) is implemented it
> > > > > > > > > > > > > > > >      can always override this random config=
uration.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > It looks like changing a MAC could break =
some guests,
> > > > > > > > > > > > > > > > > can it not?
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > No, it will not. The current version of mlx=
5 VDPA does not allow regular
> > > > > > > > > > > > > > > > NIC driver and VDPA to co-exist. I have pat=
ches ready that enable that
> > > > > > > > > > > > > > > > from steering point of view. I will post th=
em here once other patches on
> > > > > > > > > > > > > > > > which they depend will be merged.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > https://patchwork.ozlabs.org/project/netdev=
/patch/20201120230339.651609-12-saeedm@nvidia.com/
> > > > > > > > > > > > > > > Could you be more explicit on the following p=
oints:
> > > > > > > > > > > > > > > - which configuration is broken ATM (as in, t=
wo device have identical
> > > > > > > > > > > > > > >     macs? any other issues)?
> > > > > > > > > > > > > > The only wrong thing is the call to  mlx5_query=
_nic_vport_mac_address().
> > > > > > > > > > > > > > It's not breaking anything yet is wrong. The ra=
ndom MAC address setting
> > > > > > > > > > > > > > is required for the steering patches.
> > > > > > > > > > > > > Okay so I'm not sure the Fixes tag at least is ap=
propriate if it's a
> > > > > > > > > > > > > dependency of a new feature.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > - why won't device MAC change from guest poin=
t of view?
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > It's lack of implementation in qemu as far as I=
 know.
> > > > > > > > > > > > > Sorry not sure I understand. What's not implement=
ed in QEMU?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > HI Michael, there are some bug in qemu to set_confi=
g, this will fix in future,
> > > > > > > > > > > > But this patch is still needed, because without thi=
s patch the mlx
> > > > > > > > > > > > driver will give an 0 mac address to qemu
> > > > > > > > > > > > and qemu will overwrite the default mac address.  T=
his will cause traffic down.
> > > > > > > > > > > Hmm the patch description says VF mac address, not 0 =
address. Confused.
> > > > > > > > > > > If there's no mac we can clear VIRTIO_NET_F_MAC and h=
ave guest
> > > > > > > > > > > use a random value ...
> > > > > > > > > I'm not sure this can work for all types of vDPA (e.g it =
could not be a
> > > > > > > > > learning bridge in the swtich).
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > hi Michael=EF=BC=8C
> > > > > > > > > > I have tried as your suggestion, seems even remove the
> > > > > > > > > > VIRTIO_NET_F_MAC the qemu will still call get_cinfig an=
d overwrite the
> > > > > > > > > > default address in  VM,
> > > > > > > > > This looks a bug in qemu, in guest driver we had:
> > > > > > > > >=20
> > > > > > > > >  =C2=A0=C2=A0=C2=A0 /* Configuration may specify what MAC=
 to use.=C2=A0 Otherwise random. */
> > > > > > > > >  =C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vdev, VIRTIO_N=
ET_F_MAC))
> > > > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 virtio_cread_bytes=
(vdev,
> > > > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 offsetof(struct virtio_net_config, mac),
> > > > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 dev->dev_addr, dev->addr_len);
> > > > > > > > >  =C2=A0=C2=A0=C2=A0 else
> > > > > > > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 eth_hw_addr_random=
(dev);
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > this process is like
> > > > > > > > > > vdpa _init -->qemu call get_config ->mlx driver will gi=
ve  an mac
> > > > > > > > > > address with all 0-->
> > > > > > > > > > qemu will not check this mac address and use it --> ove=
rwrite the mac
> > > > > > > > > > address in qemu
> > > > > > > > > >=20
> > > > > > > > > > So for my understanding there are several method to fix=
 this problem
> > > > > > > > > >=20
> > > > > > > > > > 1, qemu check the mac address, if the mac address is al=
l 0, qemu will
> > > > > > > > > > ignore it and set the random mac address to mlx driver.
> > > > > > > > > So my understanding is that, if mac address is all 0, vDP=
A parent should not
> > > > > > > > > advertise VIRTIO_NET_F_MAC. And qemu should emulate this =
feature as you did:
> > > > > > > > Thinking it over, at least in mlx5, I should always adverti=
se
> > > > > > > > VIRTIO_NET_F_MAC and set a non zero MAC value. The source o=
f the MAC can
> > > > > > > > be either randomly generated value by mlx5_vdpa or by a man=
agement tool.
> > > > > > > > This is important becauase we should not let the VM modify =
the MAC. If
> > > > > > > > we do it can set a MAC value identical to the mlx5 NIC driv=
er and can
> > > > > > > > kidnap traffic that was not destined to it.
> > > > > > > >=20
> > > > > > > > In addition, when VIRTIO_NET_F_MAC is published, attempts t=
o change the
> > > > > > > > MAC address from the VM should result in error.
> > > > > > > That is not what the spec says though.
> > > > > > > VIRTIO_NET_F_MAC only says whether mac is valid in the config=
 space.
> > > > > > > Whether guest can control that depends on VIRTIO_NET_F_CTRL_M=
AC_ADDR:
> > > > > > >=20
> > > > > > > 	The VIRTIO_NET_CTRL_MAC_ADDR_SET command is used to set the =
default MAC address which rx
> > > > > > > 	filtering accepts (and if VIRTIO_NET_F_MAC_ADDR has been neg=
otiated, this will be reflected in mac in
> > > > > > > 	config space).
> > > > > > > 	The command-specific-data for VIRTIO_NET_CTRL_MAC_ADDR_SET i=
s the 6-byte MAC address.
> > > > > >=20
> > > > > >=20
> > > > > > Consider VIRTIO_NET_CTRL_MAC_ADDR_SET is not supported now. Wha=
t Eli
> > > > > > proposed here should work?
> > > > > >=20
> > > > > > Thanks
> > > > > >=20
> > > > >=20
> > > > > We can have management set a MAC address. Randomizing it in kerne=
l
> > > > > does not seem like a reasonable policy to me ...
> > > > >=20
> > > >=20
> > > > This manangement should be the VDPA tool that Parav is pushing. We =
can
> > > > use it to set a MAC chosen by the user. The mlx5 vdpa driver can th=
en
> > > > use that MAC instead of randomizing a value. If no admin value is g=
iven
> > > > we can use a random MAC.
> > >=20
> > > IIUC in this model devices are created by this tool, right?
> > > Why not require the MAC when device is created?
> > >=20
> >=20
> > It is mentioned in Parav's patchset that this will be coming in a
> > subsequent patch to his vdpa tool.=20
>=20
> So I think kernel has two options:
> - require a mac when device is created, we supply it to guest

Yes, the driver should always set VIRTIO_NET_F_MAC and provide a MAC -
either random or whatever configured using the vdpa too.

> - allow guest to set a mac
>=20

This cannot work today. Moreover, if's a problem to allow the guest to
set the MAC becuase it can take over the regular mlx5 NIC's address.

> it's ok to support both ...
>=20
>=20
>=20
> > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > >=20
> > >=20
>=20
