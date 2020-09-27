Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3353F279F46
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgI0HXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 03:23:51 -0400
Received: from mail-vi1eur05on2043.outbound.protection.outlook.com ([40.107.21.43]:53856
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbgI0HXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 03:23:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALl2LZEb3jbmiz297gpFHwIe8h7Kv7kZPmCHpr+D/ehFkhZyEio617k1CsLqRuvalnI98S3mCf5J6k/V86aZSNLNK0oRz78or/EOxgahcyKqbvUwncTXaiexFiTO1gEaT7IYRNGGBJG4teoW3VgghAI5qw/jpsxoTlYG+1NEhZdqWY072pKy7+xo2loUvSopfep6MpKdVj1kXgZ1PoL/NLQtY+cCoEJfZlKjgwZJkwSCp0uUDB9vb6FhqtSyGOf8LcDTmn/6OvcUNYwB/UHGy0rWCER8ggSbziplZvST4WHEJFUo/UWx2KgcAhQd4VdBucxgg0V+86PiMb0YX5wOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4s/QDi9aPHxAE8F420OMBaL0h9j5O89FhBPuvv19Tg=;
 b=c9LJkjXuzwSs77A/XImU+HvhCOs37RcMs8WlXu58gVwCPvxDmkoXzcZS02u0Kqka2guAo4aMNluz2S2vG3ADcxSzqqATHhJC31dzCE1Q+4hW6AW2hGoA3k6O5VNKD2W6BKgQfoTrLtVStZQBzsRiCOfGAEdc3QUWlpYLDO101V8MT0xZPBQgUzV+CzqsHr9M/7wGP0G3lvKE/gGtpGBoUs7kg1uxyXheNfukLyJBMbJXR/YjisS+ZIPi4YWHyYV7VQoydtFrFul1ZfX79b7evdQguvCnfqnnI2BlIF+BxsLiRRzMkpF9EOVuJXOYYp4TU9EUoxrFdMQ7dETiFbnjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4s/QDi9aPHxAE8F420OMBaL0h9j5O89FhBPuvv19Tg=;
 b=m7nib6iqW7lbaexim3VM9eD4A5C3eviCekvkWEA+jfWG8dU9Lhh64vsIdaSY2KM8tm+6odVKxT2oAsnUcD6BkoDPHnstAPdFbw3sl+iEhNiGvhSlizaPQ9sjwP4ETeggymR5KEXcKgARTizL+zMx4x3vORBh2O+QsbNpSVQC/sI=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Sun, 27 Sep
 2020 07:23:47 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Sun, 27 Sep 2020
 07:23:47 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/5] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Thread-Topic: [PATCH 3/5] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Thread-Index: AQHWkw1bNUoNcmNKxUmc61ABLBBy4al5RZGAgALRufA=
Date:   Sun, 27 Sep 2020 07:23:47 +0000
Message-ID: <VI1PR04MB49602F8604E8D5048058A20692340@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-4-sherry.sun@nxp.com>
 <20200925121729.GC2680110@kroah.com>
In-Reply-To: <20200925121729.GC2680110@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6eced355-d31a-49b6-27c3-08d862b6465e
x-ms-traffictypediagnostic: VI1PR04MB5389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB538943262863CA36D5FEE71192340@VI1PR04MB5389.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7rJP1i9pdHb0VZHzcZZYaiETbm491rSfJ1WU8SWMg6BQmowPihvZIvwyigRgCxaf3a8uMl98NOwwKAs6NNsLWbQpZJ+y6tBH7vwnykh6pokwypQT1b0/641e9xrzKMjCz1h2i/7lxTUbOb7y/srHfTvK1/0ng/+Vyzk6fAfzLCy6bYS145kPkgWdi7lljavjQG5PtuHkeS2/2kxQz0N8LGlvfnX0E9KtSFZjRLIU352x/PVjcKodqZ17NDD88i5uf3k4tPnTXHbB8EL4x8d70y5qPwWfptKVrEmVKcQrw+q8AG3UGpG82CE/F0eye4m5EKiXa4d9yEP7w+bvvHJRfcQ74vQseHiGhDPbyIonXr0vrXUJNTuMHi50+Jy4iEiJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(55016002)(2906002)(186003)(9686003)(44832011)(8676002)(5660300002)(7696005)(4326008)(6506007)(26005)(66946007)(6916009)(76116006)(52536014)(86362001)(66446008)(8936002)(64756008)(478600001)(33656002)(54906003)(316002)(66556008)(83380400001)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jNWjYJ26ti7f0uFHkX9bLtrGL0L2cuTYGu/YwJeFVnM3mmRsvfj0CivtG8yrX6EMuYz+nc8gZ6ilLF7E4vv3kDlKYA+6ZuY7SmL+lkCllVsNCT/s+CfWJQJUnJCM9qbsAkaf7lUoioJHTh+I/qJR/bNl++dPAt/ugqSo2uJatT6czZF5IcI4Wv74m5obuO/t6JaD1sn2+m2A+ejiK7LwaKEARcs4W5rVqcWkhb9rVE0fBVNR+SHnFE+Py24uL1edqsJP+6wMzZ8XLQKizXb0AgcWMMZatT4ff5jSfqU2NiOhfHDQy6Dx6atueAEpZNyuXyjeWyXDgXla14p/8048FoecwQbuGpD1JG0FY78kwGLEVKnmx6kbBIW59j3kBW7vg/XSCCOUjhzhScYe5Erxz3izbNH4C2MSjklLxMnW54GeXgxTbsWqnK67j5tXfNoCQyot3rK1voIRr3Nm7+atXKgKTy4KmgTzWAllAdFNXDqvpmYzh6dvjkpzobXbPjvMYMhFUDpvbS00gJCdYPWMYX+2VHlibjlBik330WLZqBj1LsNOLvENxNmWtbTAWIPfYn/9xnjZUsdSrupIsqguTa2uVDU461UNISiRH5jXTnPLKWhBEXGPlUM3cX8S9Xw0kXbyWUp2obwkOokyEX/WUw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eced355-d31a-49b6-27c3-08d862b6465e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 07:23:47.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRNbSnf0ZTlPUFq2LLO36HO2Zzx4R0rpyjkqcFgXCHUnM5vBy9YJ4ZrWb82esmZzapNfP6Q9t4/LKizyAgHXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5389
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> On Fri, Sep 25, 2020 at 03:26:28PM +0800, Sherry Sun wrote:
> > For noncoherent platform, the device page and vring should allocated
> > by dma_alloc_coherent, when user space wants to get its physical
> > address, virt_to_phys cannot be used, should simply return the saved
> > device page dma address by get_dp_dma callback and the vring dma
> > address saved in mic_vqconfig.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > ---
> >  drivers/misc/mic/bus/vop_bus.h    |  2 ++
> >  drivers/misc/mic/host/mic_boot.c  |  8 ++++++++
> > drivers/misc/mic/vop/vop_vringh.c | 12 ++++++++++--
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/mic/bus/vop_bus.h
> > b/drivers/misc/mic/bus/vop_bus.h index 4fa02808c1e2..d891eacae358
> > 100644
> > --- a/drivers/misc/mic/bus/vop_bus.h
> > +++ b/drivers/misc/mic/bus/vop_bus.h
> > @@ -75,6 +75,7 @@ struct vop_driver {
> >   *                 node to add/remove/configure virtio devices.
> >   * @get_dp: Get access to the virtio device page used by the self
> >   *          node to add/remove/configure virtio devices.
> > + * @get_dp_dma: Get dma address of the virtio device page.
> >   * @send_intr: Send an interrupt to the peer node on a specified doorb=
ell.
> >   * @remap: Map a buffer with the specified DMA address and length.
> >   * @unmap: Unmap a buffer previously mapped.
> > @@ -92,6 +93,7 @@ struct vop_hw_ops {
> >  	void (*ack_interrupt)(struct vop_device *vpdev, int num);
> >  	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
> >  	void * (*get_dp)(struct vop_device *vpdev);
> > +	dma_addr_t (*get_dp_dma)(struct vop_device *vpdev);
> >  	void (*send_intr)(struct vop_device *vpdev, int db);
> >  	void __iomem * (*remap)(struct vop_device *vpdev,
> >  				  dma_addr_t pa, size_t len);
> > diff --git a/drivers/misc/mic/host/mic_boot.c
> > b/drivers/misc/mic/host/mic_boot.c
> > index fb5b3989753d..ced03662cd8f 100644
> > --- a/drivers/misc/mic/host/mic_boot.c
> > +++ b/drivers/misc/mic/host/mic_boot.c
> > @@ -88,6 +88,13 @@ static void *__mic_get_dp(struct vop_device *vpdev)
> >  	return mdev->dp;
> >  }
> >
> > +static dma_addr_t __mic_get_dp_dma(struct vop_device *vpdev) {
> > +	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> > +
> > +	return mdev->dp_dma_addr;
> > +}
> > +
> >  static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)  {
> >  	return NULL;
> > @@ -119,6 +126,7 @@ static struct vop_hw_ops vop_hw_ops =3D {
> >  	.ack_interrupt =3D __mic_ack_interrupt,
> >  	.next_db =3D __mic_next_db,
> >  	.get_dp =3D __mic_get_dp,
> > +	.get_dp_dma =3D __mic_get_dp_dma,
> >  	.get_remote_dp =3D __mic_get_remote_dp,
> >  	.send_intr =3D __mic_send_intr,
> >  	.remap =3D __mic_ioremap,
> > diff --git a/drivers/misc/mic/vop/vop_vringh.c
> > b/drivers/misc/mic/vop/vop_vringh.c
> > index fc8d8ff9ded3..aa2dd240c11e 100644
> > --- a/drivers/misc/mic/vop/vop_vringh.c
> > +++ b/drivers/misc/mic/vop/vop_vringh.c
> > @@ -1076,6 +1076,7 @@ vop_query_offset(struct vop_vdev *vdev,
> unsigned long offset,
> >  		 unsigned long *size, unsigned long *pa)  {
> >  	struct vop_device *vpdev =3D vdev->vpdev;
> > +	struct mic_vqconfig *vqconfig =3D mic_vq_config(vdev->dd);
> >  	unsigned long start =3D MIC_DP_SIZE;
> >  	int i;
> >
> > @@ -1088,7 +1089,14 @@ vop_query_offset(struct vop_vdev *vdev,
> unsigned long offset,
> >  	 * ....
> >  	 */
> >  	if (!offset) {
> > -		*pa =3D virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> > +		if (vpdev->hw_ops->get_dp_dma)
> > +			*pa =3D vpdev->hw_ops->get_dp_dma(vpdev);
> > +		else {
> > +			dev_err(vop_dev(vdev), "can't get device page
> physical address\n");
> > +			WARN_ON(1);
>=20
> Don't crash kernels that have panic_on_warn set for things you can recove=
r
> from.
>=20

Do you mean that we should avoid to use WARN_ON here?

> > +			return -1;
>=20
> Use a real error value, do not make them up.

Ok, will change it. Thanks.

Best regards
Sherry

>=20
> thanks,
>=20
> greg k-h
