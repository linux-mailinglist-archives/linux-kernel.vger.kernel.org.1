Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204B62D0935
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgLGChg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:37:36 -0500
Received: from mail-eopbgr1300087.outbound.protection.outlook.com ([40.107.130.87]:58048
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbgLGChf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:37:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU3jX2qnvy4sr7cCCsNd+FjbdJjbZUDsRkXgEdO0Xoc76qxoVl88mLNQv8ZF1Ue0kYKmpOC4TnC6vuksTrb26VAnt0z8iTtM8Cky9mV2sMSQsCVfpDBXMcPazsPmwZCAAhWJZjj3IKjc0HTjBqlY/h2khbC2JLz6aX0KnC9aX+Ed822HnZRYuw/UO1nv1cmpmV6eZQl4w3dPTzBIjYRZnLJsfRCssxamoTVx7pnBbM/H+G/ux7f0E1cn7WYVE9reBshos8ev/1zL8/IYQiRux01mKusDx48hb7voPV7MwkbAVtSzQGYU/+V4b64xYrO671hft1AcXZ2nBvH6+o/fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP1daIz6j/1sMjqueMqdv5Y0SSqMW+aNZ/v6qEqs/uY=;
 b=MQhgSnJ8s8M8iluXW9ljZ3FZiv6mkM8/CHpMqq++aiHz8N4DqZWgErZ9ec3j+mz8QSMIzPAYtr4lCzHckZWMcVkVcOLFssGVl7P4SjNPR1lu1QUbCJ1WIRt6sGWJ4vDrQxhaK09h5Urq4aF9l2/MNPCCft4Sv8I8bHaTqzf09vMLhMLdK9Rck0QBp2dc1TWvVNczLOevnScIMbvCBb/QEi6GtfSWqODYl9RXIlaBbznT9nlORXyAs4MQyQ1G3VtV0YFjAhyfUzs8eWkWvzuK2GKYCjzVyFlbGna5+NPSwLuJbtSVBl0Qnc7jkAG8kY7ANEOIQHobCpRs+IoxjKL4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP1daIz6j/1sMjqueMqdv5Y0SSqMW+aNZ/v6qEqs/uY=;
 b=JmMknSPrU5lC0vfzZBYcS341mjEQ7wWCrS0GFy1YsjBxPoYsjh0CpfmJe2z7LfHS2iMTJIFtTwhhcIWRuE6tlTdKfvDvB56+GvsapxoEM532u9tBrO/ulTXpEa9zCumr+SkXVEETStLuN8zAY5R9PF+l6dKxronthuU/qUgciPQ=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4396.jpnprd01.prod.outlook.com (2603:1096:404:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 02:34:30 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 02:34:30 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/7] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
Thread-Topic: [PATCH 3/7] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
Thread-Index: AQHWvmLJ76AT6X3370mxadDtz0hQcqnZMo2AgAj8wQCABRjagIABc0iAgAJKw4A=
Date:   Mon, 7 Dec 2020 02:34:30 +0000
Message-ID: <20201207023429.GA8986@hori.linux.bs1.fc.nec.co.jp>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-4-osalvador@suse.de>
 <2aa4bf71-443b-9b9b-b761-12761263dfec@suse.cz> <20201201113511.GA22242@linux>
 <840d4669-ae3f-b7c4-6132-e20d1bf9e952@suse.cz>
 <20201205153423.GA4108@localhost.localdomain>
In-Reply-To: <20201205153423.GA4108@localhost.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90df4066-2ec8-4751-560c-08d89a58a000
x-ms-traffictypediagnostic: TY2PR01MB4396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB43960A5409A21C09F0A9C5C8E7CE0@TY2PR01MB4396.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dp350KgFHg+3TTgnNR3C/rT6XKPjq/6S8FzZx0iG2l4iG4Toncxt9vTGSmiiVt/fw3Sa2MecgxMiBM7e7lDXPio2otKjP4Ez+C/MyiBnE6mc/E3q0Q6PrWwt0v30jU3xGQhgZoPH9vmlem3L1JAeOl6BkVq0pk3vjnTZktzG4+nXagYgo5n2YRVhdY8tU0Nik657WyAQ0UqdtgyDSm1OLzjA5wXNELZG8fW0oWeZMOR9tdL1VO7kWoqppJfBqAVLZFReWb53SZnTn13qhkeGUuumfVfRMkX4QsAIT842nwbq4S0PgsMpVIHR0blb7mBfVaN2rv09doEfiCSaYkNq5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(1076003)(66476007)(66946007)(316002)(4326008)(6916009)(76116006)(71200400001)(66446008)(54906003)(6512007)(64756008)(33656002)(55236004)(86362001)(186003)(9686003)(8936002)(6506007)(6486002)(5660300002)(8676002)(2906002)(66556008)(478600001)(83380400001)(26005)(53546011)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?NUZDdW1UM2d1cUs1VjhkRXlGYkJaQmFPN3AremtESk1JelM2UGkzZnhy?=
 =?iso-2022-jp?B?cTljZXdzWnJ6ZmRIdGQ2Q2FaVTN6M0NFMUw2Zkt1VjBKakFEdHQzN3Vv?=
 =?iso-2022-jp?B?Z2FVbGNRZmJ2NkNLWHc1KzQvdDR3WGNvSG9kMENsNW1QcmRnL1crSXFH?=
 =?iso-2022-jp?B?enovTStBUDhHSTRMUVgwckNzcW8yR1d0T0VzbFV5dy9yZFRpc0NLVmg0?=
 =?iso-2022-jp?B?dHNNcTRSeFU5NktocmJ3MkIrb1dobGsxQlpmZ3ZOcjBsekpWUU5LTDNm?=
 =?iso-2022-jp?B?VmZOQlI3aFFGeUpRR0ZzUngzdHNzdUg2UENnMEl0YjVwNHhZNEdIYlZz?=
 =?iso-2022-jp?B?NmxORi9Tc21yMHBHVEMwUllSRUxyY3RWTTZtaW8wL2tlcC9NR2p1bXZQ?=
 =?iso-2022-jp?B?VFZ2WkM2R1F6TmdGaDREYWdxc3AwV1d4WmpaRHdWSzZzeTVmbWtsems3?=
 =?iso-2022-jp?B?WG5hSW02T0xJRURyRjhycEpSQ0FHYTA4dGZrS2RIMjhtU3NTMXNiUXBV?=
 =?iso-2022-jp?B?bDZtK2svbVdDR1FDVTNaRW1zSEJHMVM0Qm1keWVGOHhwZTNEY0ZFYklh?=
 =?iso-2022-jp?B?SkZqYk5GMVRsWDB5dzJWdWs5V0VMYkF4UnhlWklkTHZ0UXZ2WmJtcCto?=
 =?iso-2022-jp?B?ak12Z3JoTUtsTXFWVlg1NTE3amEzNXp4am0xL0VzTFhLTmx1cVdkVGlM?=
 =?iso-2022-jp?B?R0psVHlzYTRhU2F4aXQzYktTSkJWSHZGNWlqL0JuWVZIbVpTRDhBdUZ4?=
 =?iso-2022-jp?B?QjlvNVNVa0VEL3oxdFNPTndxcVFQeU5WbzFlVkNNOUtHNTZnSzZzcTFV?=
 =?iso-2022-jp?B?dnJ2Y1dBenM3WFVqcEQ1RlJYNlBubzllZEI3QkRlczk5aWJ1QXptMWNp?=
 =?iso-2022-jp?B?TkRkL1RoYk5HYzQ4MnZ3ei9mdFhhQVo2bm85aUVQemxDbkluejIwZHUz?=
 =?iso-2022-jp?B?ZTlpaUxUME9OckhGaTBjc3d3ck81bUw4UTVWQUxpa3AwOUtGSCt1LzIw?=
 =?iso-2022-jp?B?S2tGdUVTWWMwM1FJS0RMNE5qd2RnTnJ4ZVNIOGF4QTkvQWNvOWQ0RFpm?=
 =?iso-2022-jp?B?UDN5M1ZwU0s4TjBsZHF2NXFmTDVVZXI4WHlwaGUvbmVVRERjVCttTHNp?=
 =?iso-2022-jp?B?R2xQRFNSU0hsZmdLbnl6a1oyaVlPbllCbE1vdEZVcXNTV3dNWVVUWW4r?=
 =?iso-2022-jp?B?SGtWNE92S3dmQWNrb3VOaXJWeXFVUnJVeXJ6V05GRlBQWG0rUDdLaFZr?=
 =?iso-2022-jp?B?VVFLRDBDd1lhckNtWlpFL2h2ZU1ua0FVN21lWlNBd2RmSUhPWGdNVW9B?=
 =?iso-2022-jp?B?VVl3aWp6aTJKa2Z5SzkrSnNwbEpXWEdKNkxHL1RuazZIN2s3T3VBampM?=
 =?iso-2022-jp?B?b0hoOGY0Ti9yU1pBNHZJd3NyRGdwRll5SFd6cS9HbU15OE9ZYS9CN0N2?=
 =?iso-2022-jp?B?NTA0UGpuZ29abU9rekg2OQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6DBA15CF023F0E4DA78997BDE771B5B5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90df4066-2ec8-4751-560c-08d89a58a000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 02:34:30.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jv5Wlhb5GtGkQTCqxotq3jK4RRnn7KBrRXJYbSJEpZzO2jte92APvfkJq110T0QMQvgq2ClSjKS3AZXWerkRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4396
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 04:34:23PM +0100, Oscar Salvador wrote:
> On Fri, Dec 04, 2020 at 06:25:31PM +0100, Vlastimil Babka wrote:
> > OK, so that means we don't introduce this race for MADV_SOFT_OFFLINE, b=
ut it's
> > already (and still) there for MADV_HWPOISON since Dan's 23e7b5c2e271 ("=
mm,
> > madvise_inject_error: Let memory_failure() optionally take a page refer=
ence") no?
>=20
> What about the following?
> CCing Dan as well.

Hi Oscar, Vlastimil,

Thanks for mentioning this. I agree with that direction.

>=20
> From: Oscar Salvador <osalvador@suse.de>
> Date: Sat, 5 Dec 2020 16:14:40 +0100
> Subject: [PATCH] mm,memory_failure: Always pin the page in
>  madvise_inject_error
>=20
> madvise_inject_error() uses get_user_pages_fast to get the page
> from the addr we specified.
> After [1], we drop such extra reference for memory_failure() path.
> That commit says that memory_failure wanted to keep the pin in order
> to take the page out of circulation.
>=20
> The truth is that we need to keep the page pinned, otherwise the
> page might be re-used after the put_page(), and we can end up messing
> with someone else's memory.
> E.g:
>=20
> CPU0
> process X					CPU1
>  madvise_inject_error
>   get_user_pages
>    put_page
> 					page gets reclaimed
> 					process Y allocates the page
>   memory_failure
>    // We mess with process Y memory
>=20
> madvise() is meant to operate on a self address space, so messing with
> pages that do not belong to us seems the wrong thing to do.
> To avoid that, let us keep the page pinned for memory_failure as well.
>=20
> Pages for DAX mappings will release this extra refcount in
> memory_failure_dev_pagemap.
>=20
> [1] ("23e7b5c2e271: mm, madvise_inject_error:
>       Let memory_failure() optionally take a page reference")
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Fixes: 23e7b5c2e271 ("mm, madvise_inject_error: Let memory_failure() opti=
onally take a page reference")
> ---
>  mm/madvise.c        | 9 +--------
>  mm/memory-failure.c | 6 ++++++
>  2 files changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c6b5524add58..19edddba196d 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -907,14 +907,7 @@ static int madvise_inject_error(int behavior,
>  		} else {
>  			pr_info("Injecting memory failure for pfn %#lx at process virtual add=
ress %#lx\n",
>  				 pfn, start);
> -			/*
> -			 * Drop the page reference taken by get_user_pages_fast(). In
> -			 * the absence of MF_COUNT_INCREASED the memory_failure()
> -			 * routine is responsible for pinning the page to prevent it
> -			 * from being released back to the page allocator.
> -			 */
> -			put_page(page);
> -			ret =3D memory_failure(pfn, 0);
> +			ret =3D memory_failure(pfn, MF_COUNT_INCREASED);
>  		}
> =20
>  		if (ret)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 869ece2a1de2..ba861169c9ae 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1269,6 +1269,12 @@ static int memory_failure_dev_pagemap(unsigned lon=
g pfn, int flags,
>  	if (!cookie)
>  		goto out;
> =20
> +	if (flags & MF_COUNT_INCREASED)
> +		/*
> +		 * Drop the extra refcount in case we come from madvise().
> +		 */
> +		put_page(page);
> +

Should this if-block come before dax_lock_page() block?
It seems that if dax_lock_page returns NULL, memory_failure_dev_pagemap()
returns without releasing the refcount.
memory_failure() on dev_pagemap doesn't use page refcount (unlike other
type of memory), so we can release it unconditionally.

Thanks,
Naoya Horiguchi=
