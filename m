Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBC27525C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIWHjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:39:15 -0400
Received: from mail-eopbgr1410055.outbound.protection.outlook.com ([40.107.141.55]:4608
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgIWHjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/mObyJA25bv8ajr3JXNHGCAAD8eBvNQS6Rz3fa0E2yk/ez5Sf2lIi6FGVCu90moyUqJyOJY/OCs6s08GpibkPtWYCixIjMkLOO3D6avYOpSIiapi1zfbh3ezX91OioOWuyyDbT8f2gY5imdG14mLT+Lu9cUiTdV1QOQsCU2kuOzK+60YljHHecoXP4dVuqMm5DjXlSJJJJQbfweCPKUg+8CjSX0/1YF/DK2dXwP91KRo+GKG6vv5BAfi/52C4N+J91dXqyIAOWcq2bsOdgMwYiW7HXACfAnegHeDoHp2st2wP0AU1rriYwLl8aefyJP0j78uMJprZjQln/58lzhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pqPo7v7M3mgGZO0CBrPSIwG+UQny/guxajWNWI6KPU=;
 b=VMY4SigQWVsNEM8S+TlWqvIAXA75m10uN8zHcRhTC8hOZYIhpBhMzWXEuVHnYLFB/VIr1aE+Lz5pHpyOrkFgLDYt8WkTLMB/vmivmf0xjnPu+OJbGOYA9bvhDxz+sBZjVB3sKbuFRkTQfhC7HAoqlmDOHW5Z8QlAe4lFAmlRSbbnTEb8IJlD1EZHYBDFdFFfCdwRRMyuRMfrEvZLc39QMc1QrU8qz+5TFgelfPAZgvfAtFgmJ2yzhwVAwgZw/17iDN5MXtQ5IriUYXkWrb8SB71wPZU6JhVCDh2SgEJc9VQ0wyGt58vVDdDPWXyRbpuaNKDY0epCUi1fSEJis6VGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pqPo7v7M3mgGZO0CBrPSIwG+UQny/guxajWNWI6KPU=;
 b=j8Z6pu04i0otdekEuGls+MDjSITfotTYZTZWT1yM5+ao15iO9ZzhncILmz48fThBf9acVsjb3Fh+jv55wB5AyBZ++TZ9RiWPPciFj91/4vBJkyQvb0/Z8xmL/Cc6Z8gTNy39jx/em+CU+aIXBWibcANJszI2bgeeKfPf2gB5Hgk=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY1PR01MB1820.jpnprd01.prod.outlook.com (2603:1096:403:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 07:39:10 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:39:10 +0000
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
Subject: Re: [PATCH v7 11/14] mm,hwpoison: return 0 if the page is already
 poisoned in soft-offline
Thread-Topic: [PATCH v7 11/14] mm,hwpoison: return 0 if the page is already
 poisoned in soft-offline
Thread-Index: AQHWkOhHJHZAD244AE6v69TwDgaKTql1126A
Date:   Wed, 23 Sep 2020 07:39:10 +0000
Message-ID: <20200923073909.GD15221@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-12-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-12-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e7c987f-efdb-40b5-719a-08d85f93c2a2
x-ms-traffictypediagnostic: TY1PR01MB1820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB18203C40575AA068D4A84976E7380@TY1PR01MB1820.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfjoLq0Ev3bB2luZTquXRoLB6SLQle6VPu0oEPw7TdwqUJgze13z3mvXTKkRJX3mAxEQa66pL8mrYC/8mmXVKOSQlAwMkz3JOn8piOoDurHFYSfvHcICiFFQaHwqx9l5+Kez+Zs4qpZwm6fHjZ/GcJfUikJNTeC4iG+CtGiKreDfMREC0Vx2DsJoJBBQCrfBwTO7gSRD+tSHgYfV1XtrgaFCz160Di2/u4hMPhRzo4gXKQ4syiIZ2swrB26h0fv7J6onsG5w13bfAXk1cexfU2/QuqSSex/0pAcGjZuy+v5s39y+GTF7FfyY4LgKu6c0kOtVC8lVvsGuEkz+s7yCc/junzTrwJz9/4PGHdXccF/fAeS1EvXZIUhMUfpTBZaQjuo4C7RzA8YdgYEeIyuDCiPay/h/wyUDvS7zp5PlcO8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(86362001)(6506007)(85182001)(55236004)(54906003)(71200400001)(478600001)(6486002)(83380400001)(33656002)(26005)(5660300002)(6916009)(66446008)(9686003)(8676002)(6512007)(66946007)(76116006)(4744005)(66476007)(66556008)(64756008)(1076003)(186003)(8936002)(2906002)(4326008)(316002)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ic4lCWxJCPoNPC+SqPIx5LdHGVN/EwC/kbed2xDE7hU06E2MhHJKyBXXC++bHN1XBWWUrva4RGRpsaBlbIFyYtSLtJ29VwiO2xR+3gGp7EyElHCoktS/7F9+v2v/X7uRtENGSXe3NfEsL29Ynnp+Dz8fOAfaIbXj6f5K4Ud21B/ZTY3sGL8VT/5p4bo7OAZPS6CG9agFYLBCr2y1R5qgsbKpY3TLOK2kE/+EpsE32vn3IVzEhGwLBctXWrEUtVPOSAQvygasJiVtDd/EU3YASP/AfwEDAvgDZHAjOMlEUKAaXViqAKPrEutcKwhmG8o5nbfBv636nF5FlncFUzlQN8dObnlWZuaSH06KC42Zu4x5txdvrGDztjDHf/8nTdL1NIjoZfgef7HpZL3j3EzuiyE0BVJatHXYDxRedLzyhhfzPLcQ41KrYj4xPdC1+IPymuH3j6vmOJadysbUWIegCyKR5lTJu2Lc9Z3xoAijikPAF8suPnAJpGtlNDp1AI5/dydvzr+KiFDLrL6qz83rUGXBWy95+PnVsgBZIeb3vX/t8UnzEsrICWg7wQurkitkAwEOgMDVT9Nouqm4xJdFrTdItgq2jxvJbdh2bv6P2gykG60PdZrb6c+dXrtTTanQuMOviCk/EMZkHut1Rgbikg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BFF6453E19F56848BE6D930E4660BA14@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7c987f-efdb-40b5-719a-08d85f93c2a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:39:10.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iH7YLcN0hc0fyOmlcsO9o4STb+SevVDdBbcHCdXy4Z+obiqUm5I/bkdUzzN5Csg1DmG5P2dL2UQIhpCCx+4XWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1820
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:47PM +0200, Oscar Salvador wrote:
> Currently, there is an inconsistency when calling soft-offline from
> different paths on a page that is already poisoned.
>=20
> 1) madvise:
>=20
>         madvise_inject_error skips any poisoned page and continues
>         the loop.
>         If that was the only page to madvise, it returns 0.
>=20
> 2) /sys/devices/system/memory/:
>=20
>         When calling soft_offline_page_store()->soft_offline_page(),
>         we return -EBUSY in case the page is already poisoned.
>         This is inconsistent with a) the above example and b)
>         memory_failure, where we return 0 if the page was poisoned.
>=20
> Fix this by dropping the PageHWPoison() check in madvise_inject_error, an=
d
> let soft_offline_page return 0 if it finds the page already poisoned.
>=20
> Please, note that this represents a user-api change, since now the return
> error when calling soft_offline_page_store()->soft_offline_page() will be
> different.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
