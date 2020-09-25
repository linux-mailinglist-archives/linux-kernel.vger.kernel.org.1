Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59375277DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 04:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgIYCWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 22:22:18 -0400
Received: from mail-eopbgr1400051.outbound.protection.outlook.com ([40.107.140.51]:8608
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgIYCWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHZR20E5u4HMNYwAHnUaKhhCKThMIcrNi+0J2nXl4QQRPPrxKhU93of9z6gQZxxdVG3XVuonucNtGpFS6BFUHUS9w6PFsiKN9ucr+qyZ1WHbWlglryb5GLRzlpx+xinYUFdS5YmUC77Z91SrpUdCSpjGVHT13NODnr9lnKHH1hLpFUZV9YvwB2MPnvwhzaV74UwX02ZoYwMNwNyg14issLP57KRZtdUi63VkjLhOwiJHidhFNruM2NZJd+5uvLwUBSA3ct/tyzcY6PvrrbKl5oN9iNoqGiepgAHN426+RcaLmuTnXRy3DTzzFMkm8aJrZrSGR55wmflOd/kjKu1kbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE1MuuI9RZZKz4RGEsHthjTUmgDs6x8zC7m3bk4LhRs=;
 b=TSRih5Hc8EAbB+yo6nq8aBAKtDNZLuQ66LlwfbJrc/dPVrz8/fKwtVzIyijZKEFSUTeMfMIAuf211GC/xpxjqgEQIaBmrR260HbqwIOHrFKKmOpwe5qHB9b2qD7EZFR85hfHEqOn9WigZvNH/1PGy4pupc7+er5hsUUYMIo4g8vD659kKU46XNojFA4wlLAGVb1HGsdfxV/+E8VN2UsThZiLjU/QdSwPZ7CPks980pqrR1+4TwdGbdxCg6uka5sHu0RsXmbJ23Dy3Dh8cfE8ARTZ2eX29z4YJJ6/tp6oUaM6elzfh5TflLVLuj+tOmUzcf2cqWyu6obKTwqVlYdCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE1MuuI9RZZKz4RGEsHthjTUmgDs6x8zC7m3bk4LhRs=;
 b=Y7eWg/4pafNJ89V4gluJm89HyJJ0EIpMz+udAptvGwvZbX8f/M+iIPoQ46T+ebena+DeUz/l/bZ2bT1oxtP6bngT/QS1/6AoWsD7948jy/NJr/w/MXdqjAZcEt4NsRYCrtUS+ZKou6kG8DopCBIlFbkoQGy+y+F8Ofv68cO+hEg=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYBPR01MB5486.jpnprd01.prod.outlook.com (2603:1096:404:802d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 02:22:15 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 02:22:15 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aris@ruivo.org" <aris@ruivo.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 1/7] mm,hwpoison: take free pages off the buddy
 freelists
Thread-Topic: [PATCH v4 1/7] mm,hwpoison: take free pages off the buddy
 freelists
Thread-Index: AQHWjMx3crVad5fTGEWr4+KBqX/ffal4q8WA
Date:   Fri, 25 Sep 2020 02:22:15 +0000
Message-ID: <20200925022214.GA31132@hori.linux.bs1.fc.nec.co.jp>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917081049.27428-2-osalvador@suse.de>
In-Reply-To: <20200917081049.27428-2-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a89d541-fde7-472f-6cd9-08d860f9d204
x-ms-traffictypediagnostic: TYBPR01MB5486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB54860102FFBA4548591CA576E7360@TYBPR01MB5486.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzH/SXSU+yD3JC1x1rnGSb+GsV4dW310yIRlt9GBHT1v8YsjKYEtVdmrVa9r2WE3yfMFqDUvIHFplWzeUdSkrbnV1HqGiLyfdzgwaI4JxR7K40tZB/OqICnvvaDZKacI4BqO0GU6WeTlKpsc0gLYiLEWU2jwwh55H4YV69BBMaBTv2o0tykuGv7MGOf/etEfFRdePXPA1lZDeUvfKTr86pHU6/WMreVSwHMf2pNt+FwdleOw2NmTSpij2kLuIA51CbtSF6T0OYlXD+yvoXu22HnWHAMzzIFyFs2O06j3JqpEBEnHv1fwbdHRFsie+uCJWqmLEmZridOKntXCol2AXUNpimI9At0WhglwtZzIiZeHF4kisyXh9pi+oD8TgVqtjpFNoaptyNQcU4d4QNuPCs3rANSIGHIJSnV+2z4KOhMU/M8NFQ3QRnPm6HPy1ERrbndv9Jio7ojTz4HUGRtFowDFP7rd0GjbCHL5qk/BsfUCuCPX5kyqZ/3/ZnMynFEI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(186003)(66946007)(71200400001)(26005)(85182001)(4326008)(55236004)(66476007)(316002)(66446008)(1076003)(66556008)(2906002)(76116006)(8936002)(6512007)(966005)(9686003)(64756008)(5660300002)(8676002)(6506007)(83380400001)(6916009)(478600001)(33656002)(54906003)(86362001)(6486002)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /9ZpA3SnUsZalh4jSli5blHDoEOYQP9npRzlOF9Ec7H052gxWBVgGJVzi3AvZjCrvGPenEgaEBFJL9/27D5NO0AL5Uj2nCdIL09ciKXH4o6DJ7VegsGAYNiDUB9BKgqdteM7G3jCKvFObEz0dPSctkWdE6k1auhfln5KVGl3LDrXjux1n/RzuJSnC709+4oD9m8A3xyZ1cx7BH73JnCk8FWbMNk56CmcG/wUNV8ql35iVEET22w7nD3O7IA9fZzlqYoG8HjFsJX1yi5VgnJUdqqMbCdPyYGc3nxdb9/VJAJZDixuFE6m5vAx7nMIGKZGM0qeyEvsgavcoQT7+SL1YM0Hso9TvaUt5X0rG/UvQ/icK/bI2XaMYJHKbFgbz1AyduFCCmzrJcP+p+fIuwWAb9+Qpo65NTVDfsT3lIeYSHMEEdRprT9ttaAv4JW+a88MqUQ4SkEI+XRVvvC4vQdD0DC5lYQDKEpWTk3F4D5rVbSm4iUX6QZk+KzorAqhRbV78ZyHW4c0lEXw3MzIhzOzxxHg+KjHDpiESMEXbLZdMUMxlnzyU7V95aIrx32OpFUlC+0O9hHXT5A3R38m1VQ9SLJluSpD27y5EiIMxjvm3rwiiNiJHxfa4HXyhBrBZMYsJfndOg8kZ50t5b+tg6wuNA==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E4A8C6559884064CBF814021959C21E0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a89d541-fde7-472f-6cd9-08d860f9d204
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 02:22:15.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oAEh7cduqO+vKSvVetXWopyVBhOkKdBFD5xJmc7iHvAHrrygd0Wn+mAYqyA6Ao7RW9NcryC/f1sRrX7wKWDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5486
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:10:43AM +0200, Oscar Salvador wrote:
> The crux of the matter is that historically we left poisoned pages in the
> buddy system because we have some checks in place when allocating a page
> that a gatekeeper for poisoned pages.  Unfortunately, we do have other
> users (e.g: compaction [1]) that scan buddy freelists and try to get a
> page from there without checking whether the page is HWPoison.
>=20
> As I stated already, I think it is fundamentally wrong to keep HWPoison
> pages within the buddy systems, checks in place or not.
>=20
> Let us fix this we same way we did for soft_offline [2], and take the pag=
e
> off the buddy freelist, so it is completely unreachable.
>=20
> Note that this is fairly simple to trigger, as we only need to poison fre=
e
> buddy pages (madvise MADV_HWPOISON) and then we need to run some sort of
> memory stress system.
>=20
> Just for a matter of reference, I put a dump_page in compaction_alloc to
> trigger for HWPoison patches:
>=20
> kernel: page:0000000012b2982b refcount:1 mapcount:0 mapping:0000000000000=
000 index:0x1 pfn:0x1d5db
> kernel: flags: 0xfffffc0800000(hwpoison)
> kernel: raw: 000fffffc0800000 ffffea00007573c8 ffffc90000857de0 000000000=
0000000
> kernel: raw: 0000000000000001 0000000000000000 00000001ffffffff 000000000=
0000000
> kernel: page dumped because: compaction_alloc
>=20
> kernel: CPU: 4 PID: 123 Comm: kcompactd0 Tainted: G            E     5.9.=
0-rc2-mm1-1-default+ #5
> kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1=
.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> kernel: Call Trace:
> kernel:  dump_stack+0x6d/0x8b
> kernel:  compaction_alloc+0xb2/0xc0
> kernel:  migrate_pages+0x2a6/0x12a0
> kernel:  ? isolate_freepages+0xc80/0xc80
> kernel:  ? __ClearPageMovable+0xb0/0xb0
> kernel:  compact_zone+0x5eb/0x11c0
> kernel:  ? finish_task_switch+0x74/0x300
> kernel:  ? lock_timer_base+0xa8/0x170
> kernel:  proactive_compact_node+0x89/0xf0
> kernel:  ? kcompactd+0x2d0/0x3a0
> kernel:  kcompactd+0x2d0/0x3a0
> kernel:  ? finish_wait+0x80/0x80
> kernel:  ? kcompactd_do_work+0x350/0x350
> kernel:  kthread+0x118/0x130
> kernel:  ? kthread_associate_blkcg+0xa0/0xa0
> kernel:  ret_from_fork+0x22/0x30
>=20
> After that, if e.g: someone faults in the page, that someone will get
> killed unexpectedly.
>=20
> While we are at it, I also changed the action result for such cases.
> I think that MF_DELAYED is a bit misleading, because in case we could
> contain the page and take it off the buddy, such a page is not to be used
> again unless it is unpoisoned, so we fixed the situation.
>=20
> So unless I am missing something, I strongly think that we should report
> MF_RECOVERED.
>=20
> [1] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u
> [2] https://patchwork.kernel.org/patch/11694847/
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
