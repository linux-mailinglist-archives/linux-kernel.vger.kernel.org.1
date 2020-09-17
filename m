Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA77426DFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgIQPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:30:06 -0400
Received: from mail-eopbgr1320080.outbound.protection.outlook.com ([40.107.132.80]:33792
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbgIQP2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHTuuhhAkQ7+qdQhHE17GWUINzuIgq8kT3y9k8tf1P9pJTjlPsn0nnWDwemDt6jv9sGskmhW0HwurrW9rxiIKbDSLTtSfkvAUPvl42Y/B8B79AwdugNb7QpRU1MJEqpGjl2fs5Iy3hifBc/kRFzFBMJnZIKIbpBeueQebgjhCvxresw7c1UpY8INmZdNhIWqC2KeQ+PZZvVwfudl1wnd7x0whghsdyM+Kn82BHOUHCcsyKFx4+yWZdEGn4ot8RWVf8kT1gTdVhTVsbeb3aQOi+A8oWQK6YJeY4+JIwcWccp+1IIxFSxD7PYI4O49tw9DDUOB5NM2Ps74V6m/AbGACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih8BITUqoRBEgMQKT8LoulaEwOok7Old01uQ2xSjdWo=;
 b=EBPF5QUZiVoeaS0+tVY1vJ5mI1kN8Y0BEjo+a18aTdLMQEHlPVkbA7EvIpbW8iwu+VAbT0uz78zmU1mM7FKYofb/LCWJh5x7iLfUX8B24EDecFAPkKrfkSCtxV3KdYgDTwSr9l52bZQPZjEMdXr+ZQ2FciOalGWxDmmdRxXNR8dd7CPoK6hwJn4AoG1Qam+gxKPdRc4UCgYQ3ZyW7dKdqs2uaVAlyNwRit3JvCxWtVMT/aG+UNhh7DpYpX5p1jnB5TAFqd2VAOx0VRrBjbOVeRBxM9oUg8v91vLGuuHMCBCmpBeiA48LfSgHKAUqP5tpGKcK8EUkxTr+nECldcpx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih8BITUqoRBEgMQKT8LoulaEwOok7Old01uQ2xSjdWo=;
 b=u3TIjAtiHiQFeQF0O7LDFtet0X0sheBy1TBol2c1Q472MtoxHsQ9Q1ZKAxrA7Of/2NWjxw6MWhvMqLSWzml4IibM5tSt2iRaQLBMLmen4QEuDElKFcVEdB8IpZEVPkS5QsxAuv7nsCJHO2EDKgUGW3U3lke2K6dsjJStSheNTsA=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB4284.jpnprd01.prod.outlook.com (2603:1096:404:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 15:27:18 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 15:27:18 +0000
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
Subject: Re: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Thread-Topic: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Thread-Index: AQHWjMx2j/0L2wEy/UuRZxbicfqQp6lstMQAgAAZSwCAAAhzAIAAHfMA
Date:   Thu, 17 Sep 2020 15:27:18 +0000
Message-ID: <20200917152717.GA26808@hori.linux.bs1.fc.nec.co.jp>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917113920.GA19898@hori.linux.bs1.fc.nec.co.jp>
 <20200917130948.GA1812@linux> <20200917133959.GA2504@linux>
In-Reply-To: <20200917133959.GA2504@linux>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a3172b-fd70-401e-4bfc-08d85b1e2a12
x-ms-traffictypediagnostic: TY2PR01MB4284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB428426C91CE6E4730F42A9DAE73E0@TY2PR01MB4284.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1E9kzz38TBeY/p7gFHnm8KZsVWW6HSgEYN0wjI8gn9uHLciuCWaXSXS/eqDSQYEkFcoTSFAesdzODgAr4Om6EUhxJm9no8U7jCbGJd8FyiytVdp7GxuSyS5uUwDKJnDCJ8RpNPlXsx3SlWRBRMZbuC3f0XX5PXFKU4pqcp8Fx7k8M3IRHY9Zz/DnxJt9RaTGHDC42EqeRsVT72gy/BUivXeyqHKPacySlg0kBL351UFzcl2P/WRFnZCLNiPuteBnN9uv17O80LRo5ufJ9BHoIkPQcrWtBwQzvT36prR8bVYrQA3HrIcmkA3dwLUXzEEbYhI1T6n6j3MHVRs4IDWzYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6512007)(86362001)(76116006)(1076003)(9686003)(6916009)(6506007)(8936002)(2906002)(54906003)(33656002)(26005)(55236004)(186003)(4326008)(64756008)(66446008)(66946007)(66476007)(8676002)(66556008)(85182001)(5660300002)(498600001)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sxCmmxeqb/X06S6EXs38eFCQLNAt1wp+1/YYFehOJB5xlWvTWj2BiycEUu8X/rkFhroXXJ63xqWlUTZdQoP2PWnAQuBqVhsJ7UeptUdbgXQIM4/Ej3ui9G6/XcjYeg7W/GlOvs0p7R5IAgJ57RQWeplb0oUeSsMAAiB/SuLkTLt2yQD/5SDaSv2zHCn40erSk3WztakQlWyeq17DrY5R0goKI2hdH34N2URCIlBpXdoBqUsvrbm7VuymAarXSt/vHs8xq0BM7lTboOYkHA7qmfAt+N81dc3CN2WNzmL/n1+g4WqqWiYyuA+cQBeC6ha5zeFctSAonkV0RMNXMWo5iPOyAJz1YqMsshXLGJK6ivWtUMv6EWvMtJ0qvF32HqA9uGtdHxCdvp7nJ9r2TuMnujAKclA+C+QDUZO+O7UOiyfQ5WJ9lEa5JV0Y9fo2QaijnHXUkTjilZS4mSV95Y4iwn2oKemGExXFxxSwFgPB6fXUck2Go9h9CyM0dwXEcJN6V1y6LdgnnXJBva9rt6r7QMqN0XoGneHVPdZ0mCkaRzZ9N6pMZCKy7qZZtZB+lHtPIhfUj8G4Rv+Sc4D7dfpUKlvGchdhWMF03jOdS5JuoHIHFyNXqyA3eGyx3B1yb1Ex3x12yDwO4Is+gJJcF92TPA==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4227A18ABFD8174383A6324FB3D3E1A1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3172b-fd70-401e-4bfc-08d85b1e2a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 15:27:18.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCV0l2eJ5wLGzKbTiMb4uEi7kRfoe3TuoR1NthAYSkvZBetxXxmSSwynSNeTjRGaza6Ae9XCYCmUkmeRfN5QYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4284
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:40:06PM +0200, Oscar Salvador wrote:
> On Thu, Sep 17, 2020 at 03:09:52PM +0200, Oscar Salvador wrote:
> > static bool page_handle_poison(struct page *page, bool hugepage_or_free=
page, bool release)
> > {
> >         if (release) {
> >                 put_page(page);
> >                 drain_all_pages(page_zone(page));
> >         }
> >
> > 	...
> >         SetPageHWPoison(page);
> >         page_ref_inc(page);
> >
> > 1) You are freeing the page first, which means it goes to buddy
> > 2) Then you set it as poisoned and you update its refcount.
> >
> > Now we have a page sitting in Buddy with a refcount =3D 1 and poisoned,=
 and that is quite wrong.
>
> Hi Naoya,
>
> Ok, I tested it and with the following changes on top I cannot reproduce =
the issue:
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f68cb5e3b320..4ffaaa5c2603 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -67,11 +67,6 @@ atomic_long_t num_poisoned_pages __read_mostly =3D ATO=
MIC_LONG_INIT(0);
>
>  static bool page_handle_poison(struct page *page, bool hugepage_or_freep=
age, bool release)
>  {
> -	if (release) {
> -		put_page(page);
> -		drain_all_pages(page_zone(page));
> -	}
> -
>  	if (hugepage_or_freepage) {
>  		/*
>  		 * Doing this check for free pages is also fine since dissolve_free_hu=
ge_page
> @@ -89,6 +84,12 @@ static bool page_handle_poison(struct page *page, bool=
 hugepage_or_freepage, boo
>  	}
>
>  	SetPageHWPoison(page);
> +
> +	if (release) {
> +                put_page(page);
> +                drain_all_pages(page_zone(page));
> +        }
> +
>  	page_ref_inc(page);
>  	num_poisoned_pages_inc();
>  	return true;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0d9f9bd0e06c..8a6ab05f074c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1173,6 +1173,16 @@ static __always_inline bool free_pages_prepare(str=
uct page *page,
>
>  	trace_mm_page_free(page, order);
>
> +	if (unlikely(PageHWPoison(page)) && !order) {
> +		/*
> +		 * Untie memcg state and reset page's owner
> +		 */
> +		if (memcg_kmem_enabled() && PageKmemcg(page))
> +			__memcg_kmem_uncharge_page(page, order);
> +		reset_page_owner(page, order);
> +		return false;
> +	}
> +

Sorry, I modified the patches based on the different assumption from yours.
I firstly thought of taking page off after confirming the error page
is freed back to buddy. This approach leaves the possibility of reusing
the error page (which is acceptable), but simpler and less invasive one.

Your approach removes the error page from page allocator's control in
freeing time. It has no possibility of reusing the error page but changes
are tightly coupled with page free code.

This is a tradeoff between complexity and completeness of soft offline,
Now I'm not sure I could persist on my own opinion without providing
working code, and it's OK for me to take your one.

>  	/*
>  	 * Check tail pages before head page information is cleared to
>  	 * avoid checking PageCompound for order-0 pages.
>
>

...
(let me reply to older email here...)
> static bool page_handle_poison(struct page *page, bool hugepage_or_freepa=
ge, bool release)
> {
>         if (release) {
>                 put_page(page);
>                 drain_all_pages(page_zone(page));
>         }
>
>       ...
>         SetPageHWPoison(page);
>         page_ref_inc(page);
>
> 1) You are freeing the page first, which means it goes to buddy
> 2) Then you set it as poisoned and you update its refcount.
>
> Now we have a page sitting in Buddy with a refcount =3D 1 and poisoned, a=
nd that is quite wrong.

This order was correct in my approach. Isolation operation is done
after confirming it's in the free list. This prevents PageHWPoison pages
from being in pcpclists. But the page_ref_inc() may not be necessary in my =
approach.


> # sh tmp_run_ksm_madv.sh
> p1 0x7f6b6b08e000
> p2 0x7f6b529ee000
> madvise(p1) 0
> madvise(p2) 0
> writing p1 ... done
> writing p2 ... done
> soft offline
> soft offline returns 0
> OK
>
>
> Can you try to re-run your tests and see if they come clean?

The test passed in my environment, so this is fine.

> If they do, I will try to see if Andrew can squezee above changes into [1=
],
> where they belong to.

Yes, proposing the fix for mmhwpoison-rework-soft-offline-for-in-use-pages.=
patch
seems fine to me.

Again, sorry for modifying code without asking.

Naoya Horiguchi=
