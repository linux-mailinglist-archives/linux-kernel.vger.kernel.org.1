Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE02EA585
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbhAEGkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:40:16 -0500
Received: from mail-eopbgr1410041.outbound.protection.outlook.com ([40.107.141.41]:22992
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbhAEGkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:40:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/9/Asy6BMuOMlfzfZLrVwyDtuYlKeqOiu0dIa7wBVfExBJLHWiWJ9hhTjKGeruaGq6IfvDf95kvjS8dD4WaMFD/0592EkSRTPvgR2RlTDYePepwpX2UWLOCGluIya3Hl7JOfUtCGW03VxJt7en3nTot65Mtf/rZjIO2f9IZrWppFsA2HsTkTvdZ/687braV8ygolmcLz3smbNgC/Go7xsSyJJ92t14MJ8XbaUjZ6iMFSUdAu7s7QAL49oU8RYMMrbg+vOLwvXD189Q1exLtd2eDsJe3ZeIs78cMKIAqZhveayV0+g6dYNgCDRlBF/xzktCtBKVT8RkJ/aPF7lGipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuOafm+VOQ2MeCTaHop9fxMWbPFX9N928IzB9wMQOi0=;
 b=HYF8G49JZv39Umbyoa9rQXQ72FDr4Av1pLmdATjvJexWWvdtOv9CqDcibdV7A+smMWpqFffauVLonss9E1y8qii8g/z5LWrhO3dJx0iN+qopVGLdf8baNEp2mk3NOll+jA+DLw4lHoPs/DO8d2J2DwzvDWdDaADdNlnwo5tiP94In7DT0JGyKtW1b1/HtQVcsYxZNigyRmzdcTDMV3Hck5yUOlRdlRK+7JfHNRaRjufAIcmrgd4v8pAeq8kr2ESrXACPwfNmfWTm8C0yrwZUGWPd0Mk1CVyDFNAyNspkjiu7cAuuJ3U2t90BPVnDt0w3qX6Xfxq4EmethluTJ9nfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuOafm+VOQ2MeCTaHop9fxMWbPFX9N928IzB9wMQOi0=;
 b=E7AFg16+XsSSxkabKZkKsDEyrbrw6wmvnACBug9q5mee6soH96PrOwUwL3d8yWxoXZ90FWxqsbNvNAs63ZnBnwHJ3eyovyhef/A+w9HTAtHteYcAuHs1AEmxmCLGteLJuLvDy7ddcobz7MC2qXBOr8BpVgivqubwSWjrhqkEhH4=
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com (2603:1096:603:2b::11)
 by OSBPR01MB3591.jpnprd01.prod.outlook.com (2603:1096:604:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 06:37:57 +0000
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::497d:f781:2d19:d435]) by OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::497d:f781:2d19:d435%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 06:37:57 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hillf.zj@alibaba-inc.com" <hillf.zj@alibaba-inc.com>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
Thread-Topic: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
Thread-Index: AQHW4mfELtEsQrbrcUuzzq7DVQdOiKoYlcuA
Date:   Tue, 5 Jan 2021 06:37:57 +0000
Message-ID: <20210105063757.GA7244@hori.linux.bs1.fc.nec.co.jp>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-4-songmuchun@bytedance.com>
In-Reply-To: <20210104065843.5658-4-songmuchun@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d77dbc5-0bbc-410c-a6ed-08d8b14470ae
x-ms-traffictypediagnostic: OSBPR01MB3591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB35914DF1DB312F67403951AFE7D10@OSBPR01MB3591.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mauByS8DnqMl/Q/QX5DemDHd+jwTT0MTn1ZdyOHDDPk84w6fj06Gk+N4DhGYi7WBdGwTnkB9LuDzWbuHfQyZEXe0PdiVOUrRszn/OZpqohMSTHHQwAfCk3yDtCV6zfff+K23VoDalmJkzaMLLb7q1rwVShaf2AxYCywfbOtb6miUur4kVoGqLDubVALF4YSfe29nmo7TIKogmWAYYiH7SMPtL7xhuMA6jvO8/uaqwWCM+K0zueEVNJSLxka5FJxK1Zo6L5dVsm4/bYYuh3VHZnS5VFkR7Ee4OmZf5Jrz7Jtmgy4JF0H96acbtBvWP5dhwuhDi5eIsA1tlxpluzC590H47MT+Qd0aSEhXp4aJUdRokIhMLOefUm+yLQrqooiv0q0BuASAtekORZczLLEGyfrWwTprtpLs9uzoGdJRrvcGDFLd3tFYc5ZI2BTGyI7J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1843.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(1076003)(5660300002)(66556008)(8936002)(6916009)(83380400001)(316002)(71200400001)(9686003)(8676002)(33656002)(7416002)(76116006)(26005)(64756008)(6506007)(66946007)(6486002)(66476007)(186003)(91956017)(86362001)(4326008)(85182001)(6512007)(478600001)(66446008)(55236004)(2906002)(54906003)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?UDB5MXNIUGIrcmN5eloyd3RLemdwNExsZTlrQW5GK3M2VWRsckNpRktp?=
 =?iso-2022-jp?B?U1RaZUhqMkdxYXIzcEMrMGJ1bGVuY0dLSGxzVjRIRldyRkpaM3MveVRM?=
 =?iso-2022-jp?B?RXRpcFNPTXE0L2o2MFBTb25hK1g2RmlaWkpTdi9aTFpram1BUWJzVlZ6?=
 =?iso-2022-jp?B?ZndScklSdnA4UzVHcWVac1NKU2NkdXFKWTJ6WXZWaXhWcGdUb05DZUhY?=
 =?iso-2022-jp?B?UFJreGd2QTJpNGthbEtpejIxN0tyTG05ak94TG12MTlWRWtQcDJlbWh4?=
 =?iso-2022-jp?B?OE1OcVNhaUw3ZGp4emxwMk92QzloTUcwdXJHdE85T2FTRHhvWlY0UGN2?=
 =?iso-2022-jp?B?K3hZb1ptNXYrYzBmeXR2VkpnaEIwVUFSK2ZrY1k5UUFNM3BQbitHc2dP?=
 =?iso-2022-jp?B?Y3lUN3BaUFY4eUJHZkh1MEJxcXFhWkFXVG1jWlBuOG9yZk9SV2xoYkV2?=
 =?iso-2022-jp?B?YVpRaGM3cjRYQ3MwaWRZVUlSekJ6dnY3dU10TkhuZ1NqMGZhZEkvaS83?=
 =?iso-2022-jp?B?cE12UEd4TDFSUDZqVkNvbFo5clBpNGlmWExrQXFVRkRIRzV0S3ZVNzNj?=
 =?iso-2022-jp?B?WEdBQ0ZUZEtwS0YvRk5mVVBjNFlDSFVEcWdNSURxeVMxbDUyd0RGNlds?=
 =?iso-2022-jp?B?Y1Z5RDl0SnlHQm1iUGs0SEtPVWtkdDBVVzRHTWhQeHpEQ2p3U0NsNzJR?=
 =?iso-2022-jp?B?Mnd2M0t6Ny9ON1FQMnBzUjhVRmlBaGEvY09haVh6WEZadHZkZUZWMEZY?=
 =?iso-2022-jp?B?N1NVUTlsU2RYZTFIT3pRZDNvY0xzUnUvS0xHejlDVjVFVzFIVzh6VGlx?=
 =?iso-2022-jp?B?UnEwSGFiNE1Sby9vRGVlSzEyN25iOFhraDBwR25VMG1CSVdGYUVucWpW?=
 =?iso-2022-jp?B?WTJWVWRpVVNJeGYvMHlVOGhWSlBXK296VUo3OFZQWFl5YVI2TmRZbXU1?=
 =?iso-2022-jp?B?czBSMkhJV2oycjNObkR6emVFc0ZMZlNHaExhL0gvNFRkdit0NzR1dXVF?=
 =?iso-2022-jp?B?QjhRaitZaUtyd01UeEgza0Y4RzFSQUlYZ2xKdzN4Sy9kM1JHcGd4NXhE?=
 =?iso-2022-jp?B?cHZEbTBERjR1aHFnYWlacnhvVENRREpHanRjNTgwcjJOem1SNUVBdW9T?=
 =?iso-2022-jp?B?ZjArczZNb3RuVUZyUlNFcG1hcFNBRnNBa01sazMzYXhuSW5UTk1yQ3RU?=
 =?iso-2022-jp?B?bzMvNG1PQzY5dG9UZXJUNHV5YlRuM0ppakQ4NGdCOFhHQmpDeENzWlAx?=
 =?iso-2022-jp?B?UFZRZWFNdnRTTld6T3VCZTQyK2RGc1FOVGNvQ2ZNcG5HRDBic2ZBLzhY?=
 =?iso-2022-jp?B?d2hMTlVDZCtzNkRneWNvZENCYTc1VnBrN21xQk5mWENBVi9FSy9rZFNq?=
 =?iso-2022-jp?B?MlJkN0hBRk1DNFVrSXYweFBqSldEMkJWczFuM3B5TTR2bkhCRUZhS2xJ?=
 =?iso-2022-jp?B?dDFUSkxvN0M1bnVxVlNlRg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <F59F1EC8280523489D121CA19BC23652@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1843.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d77dbc5-0bbc-410c-a6ed-08d8b14470ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 06:37:57.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avVmiq/mQjGvBF9DbtDH8dYOb3L9wxOd1Bks8qHcZ29hMkLhqFRvA8DTmORR2JZgLA/EM3DcxykDh8MsLu73jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3591
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:58:41PM +0800, Muchun Song wrote:
> When dissolve_free_huge_page() races with __free_huge_page(), we can
> do a retry. Because the race window is small.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 72608008f8b4..db00ae375d2a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate *h, =
nodemask_t *nodes_allowed,
>   * nothing for in-use hugepages and non-hugepages.
>   * This function returns values like below:
>   *
> - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> - *          (allocated or reserved.)
> - *       0: successfully dissolved free hugepages or the page is not a
> - *          hugepage (considered as already dissolved)
> + *  -EAGAIN: race with __free_huge_page() and can do a retry
> + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-us=
e
> + *           (allocated or reserved.)
> + *       0:  successfully dissolved free hugepages or the page is not a
> + *           hugepage (considered as already dissolved)
>   */
>  int dissolve_free_huge_page(struct page *page)
>  {
> @@ -1815,8 +1816,10 @@ int dissolve_free_huge_page(struct page *page)
>  		 * We should make sure that the page is already on the free list
>  		 * when it is dissolved.
>  		 */
> -		if (unlikely(!PageHugeFreed(head)))
> +		if (unlikely(!PageHugeFreed(head))) {
> +			rc =3D -EAGAIN;
>  			goto out;
> +		}

If dissolve_free_huge_page() races with __free_huge_page() and we detect
it with this check, the hugepage is expected to be freed or dissolved by
__free_huge_page(), so is it enough just to return with rc =3D 0 without re=
trying?

Thanks,
Naoya Horiguchi

> =20
>  		/*
>  		 * Move PageHWPoison flag from head page to the raw error page,
> @@ -1857,7 +1860,10 @@ int dissolve_free_huge_pages(unsigned long start_p=
fn, unsigned long end_pfn)
> =20
>  	for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D 1 << minimum_order) {
>  		page =3D pfn_to_page(pfn);
> +retry:
>  		rc =3D dissolve_free_huge_page(page);
> +		if (rc =3D=3D -EAGAIN)
> +			goto retry;
>  		if (rc)
>  			break;
>  	}
> --=20
> 2.11.0
> =
