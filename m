Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0108127524E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIWHa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:30:28 -0400
Received: from mail-eopbgr1400089.outbound.protection.outlook.com ([40.107.140.89]:30160
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgIWHa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:30:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGnHqSWI4cVVBmMQJ1Sx5I9U7JCktib0eqTzZKJ2usUxcB8RrHce06nvVKljnrj0pL8YbFfDfIWfbKtlP4wec/dRbYTk0zi0Knyqyn5VUEioHCAu0vD59/pTTMIjQa/7Vv7MuhDplEjVNEXq3qZgZWfs5T34SeF35X42zr12LEWX+D64AW8T/yD78BeZHWfO9n9isGdZvLQaDfIZ7uHfBOJVggtiPCBXYvMsjSi5qtWF3zzJfCl+xHsiuJ4+AzqLa4mqlJ1xVJ84SswSZ68Zhjib6ZvOAl8FVg3fFH8kRE8RfXFIKjERTNRnf0u50Kh3K1Fj28vFtMWBjkoyjAPB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjt/FmW5S6FktT0amwvWErdD6ZQ52azss7D741Lc6gQ=;
 b=MJvwWnHNq+BXDTXIhakFpBB1cMunnAgdnfK1qU5dv082G0QwetrmIeEjk/+HlseAa9KVvPwGfdvgpBDm76KuFutvNo4/i/097mNknOoY4RFnedQh9yRx+9NbXAGECNrJF+oq05aZs/cBByRa7ekMgPVPdDV8woVnezI+coOaAPgvS1Va5LYqEEV1bmNv3KPkzXubHHDt72/vop6iykTLO4rMSIadUnzu+c4zqjs5XtScJZNY4SxSQ5EdW33DkTGlklOM20ATnRbHnsxm7RPLI4uunbf2v7GsGJ/K8GaXaNTf+Y2+VpFmDxxy5LmBjCNjYaFsCYoG9+ZkXwpuvmHkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjt/FmW5S6FktT0amwvWErdD6ZQ52azss7D741Lc6gQ=;
 b=Wgfo8HXqeNfolfF834W9NWcKwU4kjGD8BDjKDQl0tSdUTmwPO+R09SWbeJrPFHygI5qNRX4+doiraN+u7Q0n0+XPYBVayTFjhnf8FFjK1Gf1FLo9RTiK55AQL3KwRKpYCT2xW4QELpVslB0xLux3X4g8fmdq4kBZLGY4tX6C2mU=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB4237.jpnprd01.prod.outlook.com (2603:1096:404:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Wed, 23 Sep
 2020 07:30:25 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:30:25 +0000
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
Subject: Re: [PATCH v7 09/14] mm,hwpoison: rework soft offline for in-use
 pages
Thread-Topic: [PATCH v7 09/14] mm,hwpoison: rework soft offline for in-use
 pages
Thread-Index: AQHWkOhJvbeKah39Zke1HQNJmAYEbKl11PwA
Date:   Wed, 23 Sep 2020 07:30:25 +0000
Message-ID: <20200923073024.GB15221@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-10-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-10-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c8680ae-4e39-4785-06cc-08d85f9289a4
x-ms-traffictypediagnostic: TYAPR01MB4237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4237EC45ECC237252D0CA011E7380@TYAPR01MB4237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dv0Ya4w9OJ4ittlz0MeUfXhFuoQNHzJOmNr4cUV4hZ09FBQUSm86sQET7EWp1cnZTkUY3NpyLGnPmkFjUg9MqyaorEj+2X7RXSpzNJkDWsgfSCzRDUwOz+KGrevzGxNWmwl3eiAr3ZMq7t+pS/hi9TM7nPJpTI54VPR64Ds9wYO6mBFjVUhHFOFl3RSTUX3eeEOUDi/j9xyLvf1/GdI0mBC6aNET8vrwdQ6I9QP3ylhNOkfh3zSejpdMekiPR73nxLVymShkPpHKHYhyU6hQLX8Y4LvidjPLSu8lJ9OIU9JP+7VQrc2W9nQaMcJqE4CI84ZbMrSDNsN18wdBscVlphPNNTUqYyAHUHtrjE+RZwJcJQz/YqJrMHtu4yAy6q49dENlnCih9CRbEEzufdaydvns5MmTE97pDoxXJx2YGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(76116006)(86362001)(83380400001)(66946007)(66476007)(66556008)(64756008)(66446008)(4326008)(478600001)(2906002)(6486002)(26005)(316002)(186003)(8936002)(6512007)(9686003)(8676002)(5660300002)(1076003)(54906003)(6916009)(6506007)(33656002)(55236004)(71200400001)(85182001)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tvnPkua7U1Ypotfha6XCu7MOS8GOi1fCnDhB5pehkvE4hAZ8TBpi4zrhAUPHPJYgSsu4+sQRTrERTCcP5ZeLy3b375BaV3orO7Y1ZNoYUes2QpH9sIg4YUyXXkN32bomdG+0Lj+NYrnQnq/gH7OKJOA6J5VqLnnZyFnZYoW+lNmXZNypTQEJT2KkNqofCapHkxnuJYE6pKIgUejsUr20uCYKFT3t9/vlycsUJQP7BzHTmK8ZJNlBA+f8ywXPrPcS+UyCkjjfhFP4crbmn6rjdTdJTzNNFy9VPfehhR/3RCHLudt9ZWUo5Ybt1UJM/rMIdH8fpWoRdy5I2S7SicMke/47JNR0MEw1vr53QLUwOOh+DYmgMV+rJdLXQwAvikSXaNMlC4DRG6dVijE9tZeJU7X/SBW09GA690oVW8V7k0AXWUPxDwUR0DwZu6G0251ogFa7v4MAr3C6y1XDxJkcC5xn13QKNMMh2pOGTPd7U+dIXhnNh7hQmYR2U4p5O4FQ59iyDbmac9UoRKowsGw7Hi9SL6A8QGcpkb8LGXVvfnqi9F6ODh80L4/+cjk5Z/qOz8ErIUCLlgE+TMlBPyoo48B+P/y+hLKE7MhkBfsr3ZBmp/aO4NH1wULXpSbrHL69IMRat1JDzrcymKU7kRLO2g==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <10BA60D73D55CF4589246D511931FBA4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8680ae-4e39-4785-06cc-08d85f9289a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:30:25.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lLpxY3oGODcbtKddMKBvEeAy4EJfbTS+9H8EQ+4y/N/wtMlFYloyQDb7lFu9t2g3IQuWPjc/UdDYS1O5fP44w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4237
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:45PM +0200, Oscar Salvador wrote:
> This patch changes the way we set and handle in-use poisoned pages.  Unti=
l
> now, poisoned pages were released to the buddy allocator, trusting that
> the checks that take place at allocation time would act as a safe net
> and would skip that page.
>=20
> This has proved to be wrong, as we got some pfn walkers out there, like
> compaction, that all they care is the page to be in a buddy freelist.
>=20
> Although this might not be the only user, having poisoned pages in the
> buddy allocator seems a bad idea as we should only have free pages that
> are ready and meant to be used as such.
>=20
> Before explaining the taken approach, let us break down the kind of pages
> we can soft offline.
>=20
> - Anonymous THP (after the split, they end up being 4K pages)
> - Hugetlb
> - Order-0 pages (that can be either migrated or invalited)
>=20
> * Normal pages (order-0 and anon-THP)
>=20
>   - If they are clean and unmapped page cache pages, we invalidate
>     then by means of invalidate_inode_page().
>   - If they are mapped/dirty, we do the isolate-and-migrate dance.
>=20
> Either way, do not call put_page directly from those paths.
> Instead, we keep the page and send it to page_handle_poison to perform th=
e
> right handling.
>=20
> page_handle_poison sets the HWPoison flag and does the last put_page.
>=20
> Down the chain, we placed a check for HWPoison page in
> free_pages_prepare, that just skips any poisoned page, so those pages
> do not end up in any pcplist/freelist.
>=20
> After that, we set the refcount on the page to 1 and we increment
> the poisoned pages counter.
>=20
> If we see that the check in free_pages_prepare creates trouble, we can
> always do what we do for free pages:
>=20
>   - wait until the page hits buddy's freelists
>   - take it off, and flag it
>=20
> The downside of the above approach is that we could race with an
> allocation, so by the time we  want to take the page off the buddy, the
> page has been already allocated so we cannot soft offline it.
> But the user could always retry it.
>=20
> * Hugetlb pages
>=20
>   - We isolate-and-migrate them
>=20
> After the migration has been successful, we call dissolve_free_huge_page,
> and we set HWPoison on the page if we succeed.
> Hugetlb has a slightly different handling though.
>=20
> While for non-hugetlb pages we cared about closing the race with an
> allocation, doing so for hugetlb pages requires quite some additional
> and intrusive code (we would need to hook in free_huge_page and some othe=
r
> places).
> So I decided to not make the code overly complicated and just fail
> normally if the page we allocated in the meantime.
>=20
> We can always build on top of this.
>=20
> As a bonus, because of the way we handle now in-use pages, we no longer
> need the put-as-isolation-migratetype dance, that was guarding for poison=
ed
> pages to end up in pcplists.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
