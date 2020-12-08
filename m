Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF362D20E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgLHCiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:38:08 -0500
Received: from mail-eopbgr1410053.outbound.protection.outlook.com ([40.107.141.53]:23712
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbgLHCiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:38:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id7P+ILQ7gtW3oDNTkoGJCnBMMUfToxre2lS/v0koermA0ZqkqTYWXKOWGaKLysj+fWuU83V3ufRtSR5dourrZQoMW9vIVuIAF7raH6GsXnUum8bC5kMzJp2dOi7RZdfPonNws100C29eo/NtaFiw+yzxcz/4Bz9o/2JEzthNDEXPPPJSAs3aTG1kiVz7NqGyLAhKKhqRZIto2YkuiK1CSV7bd0YkNOmHKpFzp5r6mSsxPbTGL5vykoBNSeQfqmjMfiEgDSrixv87+lTbDsEZHMxkqfCKrb9qu2uuxPZR9ajKqq1VCmerU92NMA2JQbPCrDbnRGB+tvjPB3z2GQCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRuTnYf6pJm1T26OSkd2zGm5X3ayc5sFWkXmh9zB81E=;
 b=Tn0KLQ9OnlNL9+VZRecc2sH4cyzhYurGnOryiojQX7FONC8O5GlQ8lUtYn8faQ32Qn3qELrcBXUbS4k921S6Pa9rLAx1ajiQ/wzenDYlyeKle/mH3/Ckr0rKILnBV2Yuy8Jk6UWusIzz3wkhc8HQkb+Vyevl0nFov1SXpcHiZ9zmt9RXHUNo5WhQLDQ1Og0jGdGw+S5Icrizok2NIQh4mocvzwSo19IYwTSa0wTa5VYJjYe4blQYLi4iUH6pasQxIQN2ZrEuJwNkC6Ba5briIuuLq3vQhgt9ulAu0AIISvYAhHHD6ASH2IQHaOys0FuoycTB7QLzQHu0pbjqc+Pvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRuTnYf6pJm1T26OSkd2zGm5X3ayc5sFWkXmh9zB81E=;
 b=Rm4CZTphoMAnha4I0MAUSReoUtpyUk+MNfeP9VT8AAdoVA2YLiV5i6SPujyyKQdE8dTLpkP4lpU/9Ucm9mxUGN6QGusyvB25Bfu+5+/aV3vsPS8S43ZMGRfGFLAjcuGhaEEVbUzj377eS9L4NB62TGRGFoxZrFBDngc7JCAaXe4=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5930.jpnprd01.prod.outlook.com (2603:1096:404:8055::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 02:35:14 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 02:35:14 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,memory_failure: Always pin the page in
 madvise_inject_error
Thread-Topic: [PATCH] mm,memory_failure: Always pin the page in
 madvise_inject_error
Thread-Index: AQHWzH4hO9bKFpDJuEiM7pqnWm2hdKnsfIcA
Date:   Tue, 8 Dec 2020 02:35:14 +0000
Message-ID: <20201208023513.GB10757@hori.linux.bs1.fc.nec.co.jp>
References: <20201207094818.8518-1-osalvador@suse.de>
In-Reply-To: <20201207094818.8518-1-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adae0acd-b608-4dbd-ee1d-08d89b21e4a3
x-ms-traffictypediagnostic: TYAPR01MB5930:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5930558DD36F288739505B51E7CD0@TYAPR01MB5930.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaAmOQcx1Hhy+qD5T0auIfohzbiFoW0LakoaFA+V4Q1WuykQ+o3ZJtLl9fE5o40c89Gw8nEGhS0M2x6BNN+NN3lXqmRcc+zu1WlflkMAor/I1Y21ol9Yqb5fSxI0cx/8mqv96pgMUfvAk2SYACdMz88QIYbcIzGbMWzyZvoJT4MXdGQkDuF2c/FMp+nE/kcm4bF5iN+bTfaGUdZC+qarPvkq33+SeOQm1gmkTyQ0xC2FfHwz5LF+HNsjcXNxmZgDMNyy8KabYLYLNg5BxCYHvggxJMvQXZLXImtHu0h/Y4+I+n2O4uvYAIQ3ZICOfRF1CowfdrWqkDDSz6XEMEZN9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(6506007)(66946007)(71200400001)(508600001)(9686003)(86362001)(26005)(55236004)(8676002)(4326008)(6512007)(64756008)(66556008)(1076003)(6916009)(54906003)(66476007)(186003)(8936002)(5660300002)(2906002)(33656002)(66446008)(83380400001)(6486002)(85182001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?dUVuWDNSSFBqWFVtcU1oZFljYUVLVmZndE5uVnZjUmFiOWtEL09BbUps?=
 =?iso-2022-jp?B?NE03RmlpN0tQRWtaNG0rVFl5Smt4MWxKd0dJY0VwSVVhUFV6YThoYzRn?=
 =?iso-2022-jp?B?NmlFMXZuUURlVXpYVEFmbC9Va01UaWxVVXg0elVNVjlidzUvUEg1cnhi?=
 =?iso-2022-jp?B?c1NpN2U2WGwwN3RpWlhuWmZhenpNRy9WQk5nZE1QYWh5UThqLzVQOEJO?=
 =?iso-2022-jp?B?MDVNQUJGbjdtNHdHdDJXanFVRkJKcklvbXc1eUxxR2lsTFRqNHNMRGdK?=
 =?iso-2022-jp?B?VjJvaTdPdU10R3JOK1BOR3VUN2VPZnQvNHgwNXpSZjEzbUdQS3daRnRM?=
 =?iso-2022-jp?B?bUUrZEVpWUJIczlmL2lUS2tCVGxBNUpVWlBCVXRSNnp5THZqMmtNZnBz?=
 =?iso-2022-jp?B?ZWpUbmZQQkwvSkNIMTBuYldtTDZDSjljM2YxL2hnUnhINE9LODcyOXVN?=
 =?iso-2022-jp?B?OFBtL0cydlhNa2JYSHd4WWhjNGJBVmV3bHhOMnM2S082UUU5VzRyczBu?=
 =?iso-2022-jp?B?UVJDdDhacGdQc1dIclZJSFE4SDEvN25NOWFDRjBsdzMvY0M1YXFXRE43?=
 =?iso-2022-jp?B?UnpOY0Yxc3FTL3ppYlZFbVVnREVKS213VlFMQjJFemtDSldUczhEMDR5?=
 =?iso-2022-jp?B?VUNBNXZPa25GU2J4bW5KT09idG9kTDlTNlFCcXUxRml5WjFrMnZ3ZW96?=
 =?iso-2022-jp?B?ZWFOcHFSMGVGWkIraDRBZ213V2F0SXZON3EzaWtxUTQ0QkE5ODNKazJZ?=
 =?iso-2022-jp?B?cnM5MG1ucnBCVVJlTDVOL21BSUwwaU12cmE3RUJlVWhZU0FMK0JGUll3?=
 =?iso-2022-jp?B?eGtUSlhrOXB5a2llbDNKQmxyRXhicTQwYTJyNk1GelM1V0VVT2taa1B4?=
 =?iso-2022-jp?B?TTJLa3MvVWMySDhCL0dZZ3hQRkxwcytVZ1BSZjdsRGdrTnhSblo3SHFE?=
 =?iso-2022-jp?B?MFN0dURYMkVhaG56bHV3b1RndzZ2Q3U5Q2RIOGh2TE5uWkFkSkNjeVJt?=
 =?iso-2022-jp?B?cTc1aENYaytsNHgvV1BqS1FMa3BkNXdWb3FuWmhWdHpWczcxZ2w3UUM5?=
 =?iso-2022-jp?B?NW9MMzRHTGhDVzRHQVM4dGpCYVFNMnUydEJBWTFaMFdNR0kwNlNCem1O?=
 =?iso-2022-jp?B?VzlBQXRxNFlYWkxMYzh3dlpZT3JORGxGSGQzRXJSSEJkMHV1cndFYWEz?=
 =?iso-2022-jp?B?eGZUME44NHFPYUlQOVlnSGVwUmdRNXBpR0NJd29hMXhqVEZoZGhrTHEr?=
 =?iso-2022-jp?B?ZTZpdmpsdnJ2TWYrYnJvaXBxMGtTL2ZnQXlETFlTY29tT2JVL3FxTHEr?=
 =?iso-2022-jp?B?NXdoVWUwY1A5UXlyRjVnVFJWMVZHeWZUa083UUgxdk9nekdCQnhEUERr?=
 =?iso-2022-jp?B?YTZpdmpGUDF1TlFwUUpXaFF4aUJsSWtxM3NQdkZpemJqMWwwbUR5andN?=
 =?iso-2022-jp?B?bnpWQy9oSUh0TGpscy9WSQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <8EA991E89894DB4E83C94B190FAE1487@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adae0acd-b608-4dbd-ee1d-08d89b21e4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 02:35:14.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBQbjsaLhz5Jsr1rJKSsvb1cuj2r3mANAMjNzZd5NLif3jGq6QGgP1U0h/++GVgK55b36fhR0m1WjbyIBNaU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:48:18AM +0100, Oscar Salvador wrote:
> madvise_inject_error() uses get_user_pages_fast to translate the
> address we specified to a page.
> After [1], we drop the extra reference count for memory_failure() path.
> That commit says that memory_failure wanted to keep the pin in order
> to take the page out of circulation.
>=20
> The truth is that we need to keep the page pinned, otherwise the
> page might be re-used after the put_page() and we can end up messing
> with someone else's memory.
>=20
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

Thank you very much.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
