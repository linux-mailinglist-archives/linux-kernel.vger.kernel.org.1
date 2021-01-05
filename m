Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1770B2EA5FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAEHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:33:13 -0500
Received: from mail-eopbgr1400057.outbound.protection.outlook.com ([40.107.140.57]:29664
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbhAEHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:33:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpMNaiMnF1YO4xZMhbvYE9gpH96NndXzwU+piVzvReMBO83VeTYKZKp2fBKk+co3tQGTjltSnmpNA/n9tx0kV4NReCwdB94QpQ4iwGt2Nvmyw8GfdgS0zXNo7bsYQbaT09tp6y0CFTrWZ1FvkuysxJaTCuGRucWZa9Yk9sHfuQNs7WmssRhUPNi0d+kbaxO+NoN+yVfZzWhtMwZf/e8jA1fWpWb29siVPQH5MnxBtRN0YAY6QhrpZolifxwkh2hQ8D3GyTh1fX9XIclG+5fU95kxRsD575MM89SpinPkUuwdkJWu3trbCjjQ4aBbCFJcAUvZVHobEtzyczE48FXlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JlBR5J4mrxDrtOMYVL1Tve6gAVEoLCoB8uDg1wQFlE=;
 b=S6t53NhMDqdDWkLb1gCQKDIApedsdfy4D9djBGDiPLxgufdT+6J2CM+HzJBU9scrhr7vpZv0uCzzEQVXsOx18Lipys2bHOPe3C8VKE/N+1tliu5aRt13eDt0LwWY7zPh4ml2HAzImvRpnFYFSXPt39tjN4EcptKX70GJk4atBWhekqPlW+4x/vWPq5oFK2KNmzTMAqCXnkqsSWnfRrKE17ByiIec9ej11f2m/ySpY3/MKnQtb0jjIWbOB/1z/+c/dtbDE5pSPImB4EtmSLiC6zobOj5NdzY07kJeBh8Yku4XPvQyL9LJnDBDa/7LZJv77dHq8XFUqiEIizbVUCcnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JlBR5J4mrxDrtOMYVL1Tve6gAVEoLCoB8uDg1wQFlE=;
 b=jcYItR3ir6LkYXoohnOlSP34AwBRA1wmBlU3LIaRrsP4Vs2NTiaJ1fb3dZrMpgJeyobFSJ6egs1PIQpbdbUsrz8uh2GrJRx4y31qU+mWceOXHzmnCrkgWyg3rTcTb7WDOwYkvR5WXZSfQazklsj2KOLgPWBqGt1fsrIlen9ubKE=
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com (2603:1096:603:2b::11)
 by OSAPR01MB1732.jpnprd01.prod.outlook.com (2603:1096:603:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 07:30:54 +0000
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::497d:f781:2d19:d435]) by OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::497d:f781:2d19:d435%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 07:30:54 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
Thread-Topic: [External] Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
Thread-Index: AQHW4mfELtEsQrbrcUuzzq7DVQdOiKoYlcuAgAAJHoCAAAWuAA==
Date:   Tue, 5 Jan 2021 07:30:54 +0000
Message-ID: <20210105073054.GA10181@hori.linux.bs1.fc.nec.co.jp>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-4-songmuchun@bytedance.com>
 <20210105063757.GA7244@hori.linux.bs1.fc.nec.co.jp>
 <CAMZfGtV7mo=dqUvZBgRzJDwTkZ5qsXLno_UwBOmBUwXGEd4NrQ@mail.gmail.com>
In-Reply-To: <CAMZfGtV7mo=dqUvZBgRzJDwTkZ5qsXLno_UwBOmBUwXGEd4NrQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee5ee585-c699-410d-8db9-08d8b14bd62e
x-ms-traffictypediagnostic: OSAPR01MB1732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB1732E1B45BA844213CF6AB59E7D10@OSAPR01MB1732.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFh9sIn2DkWOVPepQcJSmH+NIehItuS5J3X923YUrox3pn+4A9YoTghYXldasnb8cts6HcK0ySYJdMwBsX3nmNDYGaKB75NgymWYV6dr+BJUIlRJV8cYy8IlmD9y9pm+EQUFDAth1PKkeHLghKlW6dOUAW9nQ/OIdnR7eXkEK0GOqs0l+Ry5D2peLbB3VvnYvApPRq8/vNU+fwbxqLfqRxuEAvvbgKRgIfgxVVtSmaAoLjCqXYHFX/hz3Sw/W4HR/MDrDqknRF450lrFYfn7xD/POaF5he/uFrKTatCHR0e7osS8Y2tulrrTvaucvihNQbrYO8WmsgaIna+muwGHjf05d9ORZTZ/1rY30+huw9TK0lPCQp7TziQ9HnEkK8wjq9pl/omfxVR5uT6dInxsurV24Udm0FHytO/VlPdkk/8XfgL03/YYXkJuxeHjIjdM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1843.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(33656002)(6506007)(53546011)(6512007)(6916009)(478600001)(55236004)(86362001)(5660300002)(54906003)(8936002)(9686003)(1076003)(64756008)(186003)(8676002)(66446008)(66476007)(66556008)(66946007)(316002)(4326008)(26005)(76116006)(91956017)(83380400001)(6486002)(71200400001)(85182001)(2906002)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?cFJWbzltWXNaa2hPd002cndNZnBwZEJIMklDcWlQbUREMHNrTmdKMGoy?=
 =?iso-2022-jp?B?SWp6NXYzdUFhM0hwZVFna2hkUTF1REpYV2lEY3hjcGFIV1BNRXlCdnpB?=
 =?iso-2022-jp?B?QXpMRStaZkhpNmFCK21UaHNhMEJPaDJJbC9DUFBZUk15SDhkUXIyVUZh?=
 =?iso-2022-jp?B?ZjQzelBRdldqSFVCMk0yK1pYUnNBQjBEbWhST0N6TkZaVDBtaDhJNXB1?=
 =?iso-2022-jp?B?RkhVR01RZ3FMTHhzc25kWm0yTk9pRTdvMEZ5SU0ybFhVa1VVQ0p2dnNm?=
 =?iso-2022-jp?B?NTFXR2V0aGhVT1NubmdpS3RmYmFHNExncVdUMHNXL1BQNlBiSVlodVM4?=
 =?iso-2022-jp?B?eVFTeEFuMjdKSXBoSGFKZDRBTk9ibnd1N1VEQnc5M2RMbGVLN1RGUDRI?=
 =?iso-2022-jp?B?cUswc0xmQzNVcDd1TTBJa2pKRVRIcnhNbkxrOTczMmFXbDR3WVBKL2o3?=
 =?iso-2022-jp?B?TzNuam4wa3kvR2pDeU1tenBXdndGK1FLL1pJWVZsaHUreEtsbUNSOG9K?=
 =?iso-2022-jp?B?WmNGSjM1eS9NVDMwcEpjbXUzVzNnZjlEWVdDTUtlN2dTZFI5SEhpMFNm?=
 =?iso-2022-jp?B?NkpPc3Z3QXUvckkxOUQvd0NTYnh2UXVWM1pEMG4xdWtONjhtVlAxTy81?=
 =?iso-2022-jp?B?ekppc2hVOUc5K0MxM3ZkUFIzWTJBL3ZHRDAyU1dIaExtWHgrL2tGR0FI?=
 =?iso-2022-jp?B?d04zRHBvQUNmU0xvQ3dISXIrUzZYQWpLd2FJNDIvMmIrcnk0T2taTWVJ?=
 =?iso-2022-jp?B?NkhOTm1tVVhkOWpYeUU0WFVNdk9EV0EyTnhwVlRHNGJoZ3h1eEU1UjZh?=
 =?iso-2022-jp?B?azJDdWdMbEc2N2ZXdGdtVXhhT0lFMERqNTNGblZXb0E0Slo4blJmQWc1?=
 =?iso-2022-jp?B?Z1lxdWxmRUd1RUwrTzlDS1RvdkZvOXhrQVdBMllEUVV0NEhWRVM5QUFU?=
 =?iso-2022-jp?B?M1N6S3dyK2w0eWhldEM3U0tHRXNhQlNYNFJnMVErS1Byc2ZLa1NwL3E1?=
 =?iso-2022-jp?B?TklKdG9ORkMwOEhpaHJiSVVKN3hmSCtzMGQ1NVB3Y1NOeHMwbCtYRlVq?=
 =?iso-2022-jp?B?OUVWVWhZZGRpVWJNb1l1TUMzZ3gzbklSb2xZdDU3bWl6OTdsTTZXN2Ry?=
 =?iso-2022-jp?B?OHVnc0t4QVhPbU9ieWRnRWFjSUE2NkZhNUxvQmNBNXpkRW83UTh4YTNH?=
 =?iso-2022-jp?B?Y2dmL1hxWDVRYWJING5UMm9yc21kZ2VTaU1xTzdPUTc4aUh5NW9CWFV6?=
 =?iso-2022-jp?B?U1o3M1lwOWx6eHBRVk9DSy9YdFduK3MrVEY2ejQvc2xnV0M5aGRLczgy?=
 =?iso-2022-jp?B?eTNDcm5FRWdNa3B5aWpkcENDbUhINnZFNSt6UDkvcjVIcEtiVmVNSVJR?=
 =?iso-2022-jp?B?UEd1RStzRHkrZ2o2ZUpVY0VIaWgxOC8yc1p0anlwUTBkRVY3b1prMWl0?=
 =?iso-2022-jp?B?VWxIWG9jc2lGYlN2Wkx1cg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <FF92BC8DCC259D4C85D4E470E7F510EA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1843.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5ee585-c699-410d-8db9-08d8b14bd62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 07:30:54.5454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FX7i8B9DeOVbOgD51WNn1072XXJdQ5mwOboMKLW0+yt/n/SvUFD4j36blPtG87tR7xGf2LTX0GAvHmgJjonG7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1732
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 03:10:35PM +0800, Muchun Song wrote:
> On Tue, Jan 5, 2021 at 2:38 PM HORIGUCHI NAOYA(=1B$BKY8}!!D>Li=1B(B)
> <naoya.horiguchi@nec.com> wrote:
> >
> > On Mon, Jan 04, 2021 at 02:58:41PM +0800, Muchun Song wrote:
> > > When dissolve_free_huge_page() races with __free_huge_page(), we can
> > > do a retry. Because the race window is small.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/hugetlb.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 72608008f8b4..db00ae375d2a 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate =
*h, nodemask_t *nodes_allowed,
> > >   * nothing for in-use hugepages and non-hugepages.
> > >   * This function returns values like below:
> > >   *
> > > - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in=
-use
> > > - *          (allocated or reserved.)
> > > - *       0: successfully dissolved free hugepages or the page is not=
 a
> > > - *          hugepage (considered as already dissolved)
> > > + *  -EAGAIN: race with __free_huge_page() and can do a retry
> > > + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is i=
n-use
> > > + *           (allocated or reserved.)
> > > + *       0:  successfully dissolved free hugepages or the page is no=
t a
> > > + *           hugepage (considered as already dissolved)
> > >   */
> > >  int dissolve_free_huge_page(struct page *page)
> > >  {
> > > @@ -1815,8 +1816,10 @@ int dissolve_free_huge_page(struct page *page)
> > >                * We should make sure that the page is already on the =
free list
> > >                * when it is dissolved.
> > >                */
> > > -             if (unlikely(!PageHugeFreed(head)))
> > > +             if (unlikely(!PageHugeFreed(head))) {
> > > +                     rc =3D -EAGAIN;
> > >                       goto out;
> > > +             }
> >
> > If dissolve_free_huge_page() races with __free_huge_page() and we detec=
t
> > it with this check, the hugepage is expected to be freed or dissolved b=
y
> > __free_huge_page(), so is it enough just to return with rc =3D 0 withou=
t retrying?
>=20
> The dissolve_free_huge_page() aims to free the page to the buddy
> allocator not the hugepage pool. So it is not enough just to return 0,
> right? Or did you mean that we set the page temporary here and
> let the __free_huge_page do the freeing later for us? Thanks.

Ah, OK. You're right.
Thank you for the answer (and finding/fixing a few bugs).

- Naoya=
