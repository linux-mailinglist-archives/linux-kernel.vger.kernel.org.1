Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5727525E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIWHk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:40:26 -0400
Received: from mail-eopbgr1410040.outbound.protection.outlook.com ([40.107.141.40]:15349
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbgIWHk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaUsCeK5w+MBwvsHL6rvfEnWn8PbBwm6SsR1Z+Hwzm9gO93zjaxkWcb4DkPtXzfj4J20Uc6nOHrpqIG1e09ogyiu7uv1QTeJuAm1MqPskBinOwLspUTY61vaZuOOm/ZjNarmt3r5S9kySV1zU1GbVbwBrYLcKmiF1uw1XReePYdpAydzyHbLPIYd2066GEG0erOGqYVdzvQ3rdIqmW/pk3ub+ecEvPFmkX7G6A6LZIDt2MpxMxLMv0cHVtbIWeJ4jkBMy/V+ZBW+uLnRcYSlgaX6VRvDcrlD3i+L5Ni3fCGWbc3So+J2hs+NszG+gmxu8QyHy8MAkACwxtNRn8Vl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saDDX6+q7roWfH/zpnfenFFyUzUwVhiiw/4Myfqt+C8=;
 b=kT1TdwqstfztwptrTjR4yOjLYyPKhDxhOVaOuvYHYOGRZw/EakjoXE/C7ThUn4BzFS2kSvHR9F5vq5nSaMK4tH7cuG6/R7XBrHZsUkMp9GVKtSC3PQkHacjLkZquAhwtHM4ubJwfDNTkVLdVsR1WgM30IuF4T6k74WSML2j4OK+lXCEbHLWjgSIaM3xE52xX15zIUpvRmgk56w2T9oRrvXEh9DhACk5x9PhCKqyF02xf1ljOrfWR1AMzMNqNIutcUQ23RStBE9Gik10m6jkMMfYDgb53evnYOUrpVRoT6taxVuleRCvigFcD4Rd7Bn65pK8KaeLwbKpFOXFolNJ7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saDDX6+q7roWfH/zpnfenFFyUzUwVhiiw/4Myfqt+C8=;
 b=TRHH52+xp4EN36x1BMSZTVwJdgwoS/4nWmiUbAPgM+4pFBCRguHkyiMZgYhmzw9fJjJgirpwv+KmQneGA07hvOwCV1xJ+LTDvWxutsLoWv3Ls1/txg4fyYApCHS1i8zXzTzhmo01MJf3sYIGKT9N/z/MNXtTp4pU2dJzfVL8ac4=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY1PR01MB1820.jpnprd01.prod.outlook.com (2603:1096:403:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 07:40:21 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:40:21 +0000
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
Subject: Re: [PATCH v7 14/14] mm,hwpoison: Try to narrow window race for free
 pages
Thread-Topic: [PATCH v7 14/14] mm,hwpoison: Try to narrow window race for free
 pages
Thread-Index: AQHWkOhI+VqEs7V6tkit9AfJcUADzql118IA
Date:   Wed, 23 Sep 2020 07:40:21 +0000
Message-ID: <20200923074020.GE15221@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-15-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-15-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0da4b89b-d1a5-4525-620b-08d85f93ed16
x-ms-traffictypediagnostic: TY1PR01MB1820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB18205989C4BB114CF671B49DE7380@TY1PR01MB1820.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22C939JlC/hcNO/AnM11wLr8OYlh3LzH63HBmyrLjgfax8ERTlKl+1Eujg85Zl/2knVKYj73vai0zPWWdSqdAoRbzAH+oTAlVs4wtiu7efiM3XeSjPSCdF5V40xxNWeZNxwXL1K0Xivj2Fsu+GR3INk4948uHRmnxOGMNg5PT3wqGOyEvC3dHmZ5zB4BgXUxLPonUskBXG0HwPd1Hi7lz4i2TpyToljmpkTeSCQPzLE65GhJf2/U6Wt07F90eXC4lT96lAAXLbUgkzDNph/z71CLRB4vX4JlfQJKbX+u/1j+dlDKxSF6mpAT9osV+VlPN+KGUP7e7hDGz+SeSKPSOR4JDa4bCO0Xsmj6oVrvfTDQxuXaYBCWjEk9H873fwbf9yIzCl2M0TEYnIAPTb8ItO0nVa/fgXXOUM1BWnJvcHTi0DhnccSpYhXNyao2mNGC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6506007)(85182001)(55236004)(54906003)(498600001)(71200400001)(6486002)(83380400001)(33656002)(26005)(5660300002)(6916009)(66446008)(9686003)(8676002)(6512007)(66946007)(76116006)(66476007)(66556008)(64756008)(1076003)(186003)(8936002)(2906002)(4326008)(142933001)(4533004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6H24Dfja2FrReAVB+4gXTzNoWioer4KBssSJwXYiwceZviTFufhM/cI+S3+fLfkbuiDklyi2IXQsbZdAR+RsomFQguxGabyRgzEMHxcZGa0aEL1TqFoI7YCoWcYvWMVfoz/WbaudUL12ITbDoaN25B9N5BI7zLbF/T8chkxVXsdqdckuaurCcXC0Dv4YNGOpUSAXDWA5PQXTU6kqqsLwmUViCDpZWsXRxPGy65th1ROQB337/dlmJeWeGgy499/DvnAc50+ccCE762Gh2wujIqFmU7NGPUKy3MddWTlpKQuhV/1jeF18hidp9RvYbj1kW/iridfENzRTtMi+9xtZwilYsvKMhJ252cYin4pSm13kBNjpXGuXx7R975pP4NGJPVr191lSzCf2fis3v7CMbzXR7mHJ/mI8f8QxN/Req3rCnLiS/ZOLcDHa8sZ/mLaniNBR6Y80073sjJQ6idbcSTrMVaa6GXPKmpkRq/0u5vehkRCviFpccFT7yGoRg3HNLBGal3hdFxV0ayqrU9C+9oKZz3WbUhP5FQ1mnX1atXla5KqcYArOEVU8kARL1pbOky6imYIesK0D0ujlLifQXH9ZaGjGXS4OvpT52M5Ja6RzL8P4p26VH1FA6wzZbZ4aznwuuYZoEc4kK05SR1w6Mg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6931F602FB5A69439A66B8F1D9A6335B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da4b89b-d1a5-4525-620b-08d85f93ed16
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:40:21.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRLl8TCDDN+4U8RTS3AiJQgFkq9IRSiVoYA69H1Q75oh4aOwHnrHfS25TNImtDi5TNqRBfjAbJ6lZNokPgVm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1820
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:50PM +0200, Oscar Salvador wrote:
> Aristeu Rozanski reported that a customer test case started
> to report -EBUSY after the hwpoison rework patchset.
>=20
> There is a race window between spotting a free page and taking it off
> its buddy freelist, so it might be that by the time we try to take it off=
,
> the page has been already allocated.
>=20
> This patch tries to handle such race window by trying to handle the new
> type of page again if the page was allocated under us.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reported-by: Aristeu Rozanski <aris@ruivo.org>
> Tested-by: Aristeu Rozanski <aris@ruivo.org>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> ---
>  mm/memory-failure.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 46b1821d2817..8f23d3c7a0a2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1903,6 +1903,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>  {
>  	int ret;
>  	struct page *page;
> +	bool try_again =3D true;
> =20
>  	if (!pfn_valid(pfn))
>  		return -ENXIO;
> @@ -1918,6 +1919,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>  		return 0;
>  	}
> =20
> +retry:
>  	get_online_mems();
>  	ret =3D get_any_page(page, pfn, flags);
>  	put_online_mems();
> @@ -1925,7 +1927,10 @@ int soft_offline_page(unsigned long pfn, int flags=
)
>  	if (ret > 0)
>  		ret =3D soft_offline_in_use_page(page);
>  	else if (ret =3D=3D 0)
> -		ret =3D soft_offline_free_page(page);
> +		if (soft_offline_free_page(page) && try_again) {
> +			try_again =3D false;
> +			goto retry;
> +		}
> =20
>  	return ret;
>  }
> --=20
> 2.26.2
> =
