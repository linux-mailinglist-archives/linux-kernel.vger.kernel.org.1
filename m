Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AB2A2B25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgKBNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:03:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgKBNDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604322203; x=1635858203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H+W8CHfnp6wxP902b5+WhI7yJTFaK3+x9Cb17RsjYxM=;
  b=YdUdW/svasogmSmBBJ/wnNX+ZphDp6JR9JXqsPQ4kwx9Aq9r+57rOWNI
   crvU0FqkPC04qMWKT21wET3QFU8xVR/C8GbCBxYuj+R7z2ZUL2L2uTICJ
   qGHVGJUBKaXtdawv1MzVdauImaVru1EJNboQv6AqBmNO0pjDPVmS9R+sY
   h7XlGjJ2pk1hyn6IhX6p1WT0XRQj6RWRRMVIyoa2VTC4BbG8b0CzI1PJ2
   YqMuLxJ6nMFVJxTrmyagZpF0AKs3pHzZnFJVGzWHEX5eGhqe2Vl9CPFj0
   XWBaHDv8HYmeicORMMdDPxxvUjqNE/Vy3LhH/bttHloPJSrNaHKrBL7a1
   Q==;
IronPort-SDR: aocmHl4qWxIGdrBWMnbG8gPcfciJgESsRZdehEpv2oHlPJ5eyx/SFhKYERjrEmwniR806Jz/c2
 8BztOWNPZfc71tXtSt1PRdC1jOPJR2a9vSVp+FFnny2YBjf0ptY5Zz98MhqcUL2kIRWW93CaW0
 NVHMJjLmslIgLeozYR7M/+6W3uOwHasPqQ+4hYv/T1MGc1NPdjf2tdfXwGDZwMVSNdp7VCRPyK
 r3B7i6mUkZh54eb9nKWuyaS56vPafTbhw9jJhJEXgkyCgN6D78MKLEz8A3XwR76N+gHESxNSuT
 5cQ=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="261496980"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 21:03:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq0fPnELz1v0eZyO3i9moPhaxlZ865pekFLzNzGynycC4gP/nVFUs2+zNURNYTDFh5JhSsjvIWOb6nbJ/LAHqGti9FihWYcAey5POxWwNYaS2vaBFgQrAwB3nUi7gvQMwB2iQ8hvxAoaUyEmTx+K2b9nzwzKwkvactKa542+rscz+X2DWAOIg1Dyz0XgPtKYx6jIGXsv2B9pFz9DNX/bqEepPMxgM+r/FSeAWu0xrPXBujwnEq/YR7Ux+4ZrXi/LIBxPlReZ9ee7ngoBWA3KvfZIDhjXwUv4UE80BmQuuxljq/rVIPGCersBq7ufg9KR9V8PGWPlUwvx83Ct9rXy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9R5uH+X2o+8fFyzHtnJ3Ta46z60w2J3wl7XJastSYA=;
 b=F7G+MVsbOhhuMd91J119+nQvYVpWCC9F5FSU0Q17/JQ0f9eIuiLDfI94sn29I8PLXGzu3i0np9fehzh3n/p5Oh1zoZtqFZtBy7nOPUsefHttRTNzk0mKCKNn0L8f+sp1vd0vf/oMc94mIuZD1UTccjIL5vHPIfiRrzyzOQFUhCCUTo7QSK5BYytftBaLKCG672usJaT3McqoQSzsMZVasQU6t5asG6Gmd9lcCxMz8/1mkyzfSkUq1KKqu/ejyqed0xAz+/FZzlFKUKyIDUBMih3qPNf7lRFG5/QKyHBgBtbabi4MgPi/pNlwHOOI2M37Xtp8IW/+W80jaQX+bT3ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9R5uH+X2o+8fFyzHtnJ3Ta46z60w2J3wl7XJastSYA=;
 b=yiMPJU/ILPFAZ2ro9Vi1fLjN/08P/joPQuyCioX5UmsCiZHFelwzdqb/LVpU9W+4jm6DS++8QZFImhepOwVpCEgDD6E93o9hzPyVZ1ZgtANXXNQaUoqIMPm8Ucy0MjPE/MYNQv4oa6HrG2rLdjbmpQ/99/J1OBdmEw0j4IqFxM8=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BY5PR04MB6341.namprd04.prod.outlook.com (2603:10b6:a03:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 13:03:21 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::302e:1163:e5bc:b658]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::302e:1163:e5bc:b658%3]) with mapi id 15.20.3455.040; Mon, 2 Nov 2020
 13:03:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lang Dai <lang.dai@intel.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] uio: Fix use-after-free in uio_unregister_device()
Thread-Topic: [PATCH] uio: Fix use-after-free in uio_unregister_device()
Thread-Index: AQHWsROpKbE90MB/qE28rIdhz8lR3Km0xr+AgAAIK4A=
Date:   Mon, 2 Nov 2020 13:03:20 +0000
Message-ID: <20201102130319.dqkwyr7zarcbwssc@shindev.dhcp.fujisawa.hgst.com>
References: <20201102122819.2346270-1-shinichiro.kawasaki@wdc.com>
 <20201102123405.GA679664@kroah.com>
In-Reply-To: <20201102123405.GA679664@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edd9b383-0b7d-4c5c-daa0-08d87f2fac8d
x-ms-traffictypediagnostic: BY5PR04MB6341:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB63413B543031508B081C7EB5ED100@BY5PR04MB6341.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5RfXN0wblPWLrKn3UuKlbS6dpIxEogGbVG1dOL6wUnYmppHQzz5C1swaEgt1xlg8N0NRZU7g6qG3Obxrbyawr4WarbOBL2kM4WmNroHpeFy/w06hEgedF7YB+fqLuI6HFUQvto651cb/0RRIr9Smy/wQvTYpPmLnZxbrsCGRoHHHUb4eADShCi9aWlhtnV/jSpUZf1J4XYUye1eBwLcchAFe8vhmZa3Blq5wL3WXQllYZmJMSM0X/20BTI8PigmHKU7UVL79W1HHTOBnHMLOSBz40WqhY23V/iqIB2VDiAAMvLMBvvMNGuimDkF7QRaqVgcXHvZg+AfHY59pIBbYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(8936002)(66946007)(2906002)(6486002)(66476007)(9686003)(54906003)(6512007)(5660300002)(6916009)(71200400001)(83380400001)(1076003)(4326008)(76116006)(66556008)(6506007)(8676002)(26005)(316002)(186003)(86362001)(66446008)(64756008)(91956017)(478600001)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DQ1elSaJ5tdbB9NVj55YPmgJ0ZTCdDhaFuRMZeqRlJhal3FPLLUiymAneXn3hOE+VoYmh1swk3mHGagtjHxCR3CFOZd5fipqMFLQ9VqO4Y3SsVwRIDsy8bX8Sq4SWQUWeqdcCOAs57a/M84CVynSPml/AefCeluPzV3DVB71ngb1pcVmuVvzKocRiMk4H+mePOddZy8nlhXghfp3CI3to91KJQpSIofwX5z1NdrGRZvK7xZx3o8BVyejEIB4DRJ7NBsaLuDFwz3FHlzCDDgHWrDdSS3qYU+c65XU7WXZiBIWvZRU41IapDQ4Xh5/GKTbmEc6xbAwxWfiBidLy2k/hPvUMjrPznPJqb8jGavpEpCSrocFgIfpZxnI3jhkOrQW3hJ8oAlDuHZaf+vJWc23ttYWLgWtgxCtmlybXiEgAa2RGnFdcM2h8fhQNCEXbEgvwjZN099Imr112P13/Ru+Zt7vbE9i26AbKT0tS/JexhtMNEFD0/ugtyxqgyOxQf/eb42NHTd8M0bz5qOJlyu/szGQzyIY1/eZehSOoWy/EHo+RCUAIAjq8z2BRdec6yMf2djtU3p44edVRAc6zotI6N4omW+wg8RxVUrdMw7RI9fLSKr3KS6/7176yiTkSisM1jk3duQc0ZRaSo3GsQ4RJg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9173781631B29B48B06F1C9ADCEBD069@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd9b383-0b7d-4c5c-daa0-08d87f2fac8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 13:03:20.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDIlJfQzuSAIsss67H0Xeulk6+VXMNZvTsStnXa6OSj+8hFs2XKFQ5OdF6rSne6d3AKkRRqAy0Yi/PULbIV76tmlyU7wtNXQqBpRNkahNyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6341
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 02, 2020 / 13:34, Greg Kroah-Hartman wrote:
> On Mon, Nov 02, 2020 at 09:28:19PM +0900, Shin'ichiro Kawasaki wrote:
> > Commit 8fd0e2a6df26 ("uio: free uio id after uio file node is freed")
> > triggered KASAN use-after-free failure at deletion of TCM-user
> > backstores [1].
> >=20
> > In uio_unregister_device(), struct uio_device *idev is passed to
> > uio_free_minor() to refer idev->minor. However, before uio_free_minor()
> > call, idev is already freed by uio_device_release() during call to
> > device_unregister().
> >=20
> > To avoid reference to idev->minor after idev free, keep idev->minor
> > value in a local variable. Also modify uio_free_minor() argument to
> > receive the value.
> >=20
> > [1]
> > BUG: KASAN: use-after-free in uio_unregister_device+0x166/0x190
> > Read of size 4 at addr ffff888105196508 by task targetcli/49158
> >=20
> > CPU: 3 PID: 49158 Comm: targetcli Not tainted 5.10.0-rc1 #1
> > Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
> > Call Trace:
> >  dump_stack+0xae/0xe5
> >  ? uio_unregister_device+0x166/0x190
> >  print_address_description.constprop.0+0x1c/0x210
> >  ? uio_unregister_device+0x166/0x190
> >  ? uio_unregister_device+0x166/0x190
> >  kasan_report.cold+0x37/0x7c
> >  ? kobject_put+0x80/0x410
> >  ? uio_unregister_device+0x166/0x190
> >  uio_unregister_device+0x166/0x190
> >  tcmu_destroy_device+0x1c4/0x280 [target_core_user]
> >  ? tcmu_release+0x90/0x90 [target_core_user]
> >  ? __mutex_unlock_slowpath+0xd6/0x5d0
> >  target_free_device+0xf3/0x2e0 [target_core_mod]
> >  config_item_cleanup+0xea/0x210
> >  configfs_rmdir+0x651/0x860
> >  ? detach_groups.isra.0+0x380/0x380
> >  vfs_rmdir.part.0+0xec/0x3a0
> >  ? __lookup_hash+0x20/0x150
> >  do_rmdir+0x252/0x320
> >  ? do_file_open_root+0x420/0x420
> >  ? strncpy_from_user+0xbc/0x2f0
> >  ? getname_flags.part.0+0x8e/0x450
> >  do_syscall_64+0x33/0x40
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x7f9e2bfc91fb
> > Code: 73 01 c3 48 8b 0d 9d ec 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e=
 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 54 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d 6d ec 0c 00 f7 d8 64 89 01 48
> > RSP: 002b:00007ffdd2baafe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
> > RAX: ffffffffffffffda RBX: 00007f9e2beb44a0 RCX: 00007f9e2bfc91fb
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f9e1c20be90
> > RBP: 00007ffdd2bab000 R08: 0000000000000000 R09: 00007f9e2bdf2440
> > R10: 00007ffdd2baaf37 R11: 0000000000000246 R12: 00000000ffffff9c
> > R13: 000055f9abb7e390 R14: 000055f9abcf9558 R15: 00007f9e2be7a780
> >=20
> > Allocated by task 34735:
> >  kasan_save_stack+0x1b/0x40
> >  __kasan_kmalloc.constprop.0+0xc2/0xd0
> >  __uio_register_device+0xeb/0xd40
> >  tcmu_configure_device+0x5a0/0xbc0 [target_core_user]
> >  target_configure_device+0x12f/0x760 [target_core_mod]
> >  target_dev_enable_store+0x32/0x50 [target_core_mod]
> >  configfs_write_file+0x2bb/0x450
> >  vfs_write+0x1ce/0x610
> >  ksys_write+0xe9/0x1b0
> >  do_syscall_64+0x33/0x40
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >=20
> > Freed by task 49158:
> >  kasan_save_stack+0x1b/0x40
> >  kasan_set_track+0x1c/0x30
> >  kasan_set_free_info+0x1b/0x30
> >  __kasan_slab_free+0x110/0x150
> >  slab_free_freelist_hook+0x5a/0x170
> >  kfree+0xc6/0x560
> >  device_release+0x9b/0x210
> >  kobject_put+0x13e/0x410
> >  uio_unregister_device+0xf9/0x190
> >  tcmu_destroy_device+0x1c4/0x280 [target_core_user]
> >  target_free_device+0xf3/0x2e0 [target_core_mod]
> >  config_item_cleanup+0xea/0x210
> >  configfs_rmdir+0x651/0x860
> >  vfs_rmdir.part.0+0xec/0x3a0
> >  do_rmdir+0x252/0x320
> >  do_syscall_64+0x33/0x40
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >=20
> > The buggy address belongs to the object at ffff888105196000
> >  which belongs to the cache kmalloc-2k of size 2048
> > The buggy address is located 1288 bytes inside of
> >  2048-byte region [ffff888105196000, ffff888105196800)
> > The buggy address belongs to the page:
> > page:0000000098e6ca81 refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x105190
> > head:0000000098e6ca81 order:3 compound_mapcount:0 compound_pincount:0
> > flags: 0x17ffffc0010200(slab|head)
> > raw: 0017ffffc0010200 dead000000000100 dead000000000122 ffff88810004304=
0
> > raw: 0000000000000000 0000000000080008 00000001ffffffff ffff88810eb55c0=
1
> > page dumped because: kasan: bad access detected
> > page->mem_cgroup:ffff88810eb55c01
> >=20
> > Memory state around the buggy address:
> >  ffff888105196400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888105196480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff888105196500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                       ^
> >  ffff888105196580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888105196600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >=20
> > Fixes: 8fd0e2a6df26 ("uio: free uio id after uio file node is freed")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  drivers/uio/uio.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> > index 6dca744e39e9..be06f1a961c2 100644
> > --- a/drivers/uio/uio.c
> > +++ b/drivers/uio/uio.c
> > @@ -413,10 +413,10 @@ static int uio_get_minor(struct uio_device *idev)
> >  	return retval;
> >  }
> > =20
> > -static void uio_free_minor(struct uio_device *idev)
> > +static void uio_free_minor(unsigned long minor)
> >  {
> >  	mutex_lock(&minor_lock);
> > -	idr_remove(&uio_idr, idev->minor);
> > +	idr_remove(&uio_idr, minor);
> >  	mutex_unlock(&minor_lock);
> >  }
> > =20
> > @@ -990,7 +990,7 @@ int __uio_register_device(struct module *owner,
> >  err_uio_dev_add_attributes:
> >  	device_del(&idev->dev);
> >  err_device_create:
> > -	uio_free_minor(idev);
> > +	uio_free_minor(idev->minor);
> >  	put_device(&idev->dev);
> >  	return ret;
> >  }
> > @@ -1042,11 +1042,13 @@ EXPORT_SYMBOL_GPL(__devm_uio_register_device);
> >  void uio_unregister_device(struct uio_info *info)
> >  {
> >  	struct uio_device *idev;
> > +	unsigned long minor;
> > =20
> >  	if (!info || !info->uio_dev)
> >  		return;
> > =20
> >  	idev =3D info->uio_dev;
> > +	minor =3D idev->minor;
> > =20
> >  	mutex_lock(&idev->info_lock);
> >  	uio_dev_del_attributes(idev);
> > @@ -1062,7 +1064,7 @@ void uio_unregister_device(struct uio_info *info)
> > =20
> >  	device_unregister(&idev->dev);
> > =20
> > -	uio_free_minor(idev);
> > +	uio_free_minor(minor);
>=20
> Why not just move this call to uio_free_minor() up one line to be above
> device_unregister()?  That should solve this issue and make the change
> much smaller and more obvious.

I thought that the commit 8fd0e2a6df26 intended to move uio_free_minor()
after device_unregister(). Do I misunderstand the intent? If so, I will
simplify the patch as you commented.

--=20
Best Regards,
Shin'ichiro Kawasaki=
