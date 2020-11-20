Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1556F2B9FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKTBdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:33:07 -0500
Received: from mail-eopbgr1300081.outbound.protection.outlook.com ([40.107.130.81]:43991
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbgKTBdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moKEu12RccXyR2JPEBz9DAqbWNzbi9sLxVSE03QRPDkHSA+QgLgQVQf+5mD6L6GJ3QW4MZQz/ao5wo+VAHBVilONnQjP2erdeuvEAMei+EQSwPC70248S5YIQitZXCjk2gCYGmXVu9W27QmUgSHaBPrh6NGSOyrLhIdMXbIiKYvEkK9DvuQG3Fe0PfTUAs/Oux/+bmUietACgD25DlLIhEFBVnHnfrBsw3eXWdyp+xPSQLDJzXvt//Drdw7Bijc5v8BlnRa67xW/dKZH4yi5Qo/YBaz3qf2hGdhNYR7kC4DkC8ziY5qd0Uu+TvhIYSlAruOhZoSB3zZgw0ZV7PbxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkHA+Ycou/8iAZIJJm3En/yLIzadMq1aylSk1lJg8J0=;
 b=nalBZzjbQCgykohReaJNNow8bE/PDg/8nElERcIwP7lySdqvwi+gnZH7enRLVZC1lD1/t9ktXAORfoN5wHK7zyc7sPv9H+n661PisDDqWdcQ1HKzCZ8DEOud2AVvGPY6McOJetr44gEAt4kzxLsk2LFnukfsIPunKsWtZ5S3p0oNfTGXqGb8nMVJx4zMf9co5CQP1ZwfRH3PTO2VYfUHRMTetAMXqcurY3v7NEKxd4n5/YKD8B7cPLF29PSR0abQ4jWDo5sXz7SrWroCEUfpBI/0UtT78R3pm8ZfNtmRU3xudkSOKdh7/duVXu3JDsPW4C1MyzsxEi6TCbbckOA3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkHA+Ycou/8iAZIJJm3En/yLIzadMq1aylSk1lJg8J0=;
 b=MvGjCtkoMsDuqVIGwj4/pjQ7zlAIDIwLKj4u74Du1elbKk9ozoJ22MsH+kWCVJLFLNCIvEUzTHEzxaAEZ19vjHwD4GxpnyodBR/hjCg7xGK231jsqaeW5gt7xquudc56BxvznqzbwtAjZ/MjQMLrUeJTmeFOmWk64IXfZPXTaYc=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4812.jpnprd01.prod.outlook.com (2603:1096:404:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 01:33:01 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::cc37:aebe:31f4:8753%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 01:33:01 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mm,hwpoison: Refactor get_any_page
Thread-Topic: [PATCH 1/7] mm,hwpoison: Refactor get_any_page
Thread-Index: AQHWvmLM0R3hJ4IFR0OQlcxnyfXRvanQPWWA
Date:   Fri, 20 Nov 2020 01:33:01 +0000
Message-ID: <20201120013301.GA26144@hori.linux.bs1.fc.nec.co.jp>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-2-osalvador@suse.de>
In-Reply-To: <20201119105716.5962-2-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f97538b2-4160-4b94-476b-08d88cf43867
x-ms-traffictypediagnostic: TY2PR01MB4812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB481219A768D212470B67E987E7FF0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3t1jXE77p+D+daYN/VdyxsG/Ms10BXl+vXo5N+efXc0ZfX3RZwwVffU56ulQNdbjKg5WYIeg5wwrq0UrDHzMunDiXOJ9gWJ2vyJ+rehyfd5hCi2hXqIoebPC8lEqrzEatjPMUVgTGjPAczXps1NPiDQ65NRibSKrVb99lVxk+Exx18mGCpRbhVb7r0SpyrjmhxZPYByKbDjtxlr/Q8FSoZjA0U0RMkvLXEc6kzOMASbEiv/wXRDms57Fx1mHT3kBy6uI+vUeSatAjtXRS/VC7ZcgRocoSHWGmml7n5/SPznlM6OgCpyeVeM3rtQ7Oa6Dspj+Irreu+wp6fpfZAXIpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(186003)(6512007)(6486002)(478600001)(66476007)(4744005)(33656002)(26005)(4326008)(55236004)(8676002)(6916009)(2906002)(6506007)(83380400001)(9686003)(66556008)(85182001)(66446008)(76116006)(66946007)(64756008)(1076003)(86362001)(5660300002)(8936002)(54906003)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2yFlk8Ke/OhUr4aj9pFILgVTpJqOtVD8p5MrUfKBfKjPgYxoMeJkP1JNXoIO6KtY6LnCtjX70P7NSO9PkYhtsYdUheKeY3jduqJdOWj6yXkpJmUNQEo3Ar8L2WNlyXmfxRLz9EDV/1y89UrAIv11AO2N0ngNd/5gJvpxJ6cTOJsS/QuVxzxyJefN85htePG1q6Ujiolune8Uc+ugfZV7uBtFclzErkb05jzJIRlS4fK6OTuye3R3QCVmHskWxTxYCOGAUFgETZLK02yTUSEPbPUa0wX7HpEGj3v2v5MM3x/8FkjGpnm0vBVBBe78IQO3d3NUtaBr9Q3DkblgDwaHnAjoIALU3qudkM219Qgitqy5Am1NYZyTqR8bCNY4s/nxGVS6NNsyh2KaF7h6OJIg2uImmxfgr9gWG8pJWw1v/9UtrqbWerlHBdEX224HR7z62/x7rZvOTMpcHAQSzZg7XYb/9zqIITv5zEw0DCMMpxYFIxdkLbOq+s1GacYQqIkK5RFkWKLAikIPQDiF0zYhwF1REFBmo8gDRA9NnKjISe2M8hn0A/CVk6Ot6HcQDoQ20b/slG7dLQOI2DMNwMwGH2n5ygs2UgqG+YPLkNuxj9ZqClIepmC8E3xNvB9yePZx2VeT8g+A4vX0VgG6KtCqlw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D3C1B040CE8616469D2297EFBD3C76F0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97538b2-4160-4b94-476b-08d88cf43867
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 01:33:01.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +u0B08sy8O7KoG2qpwSZ4JMIFNJnsxvzMUBN0c0o139iFRYnWEptqJMTuAftj1tD2isWf0aeMlcrd2rFthhQ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:57:10AM +0100, Oscar Salvador wrote:
> When we want to grab a refcount via get_any_page, we call
> __get_any_page that calls get_hwpoison_page to get the
> actual refcount.
> get_any_page is only there because we have a sort of retry
> mechanism in case the page we met is unknown to us or
> if we raced with an allocation.
>=20
> Also __get_any_page prints some messages about the page type
> in case the page was a free page or the page type was unknown,
> but if anything, we only need to print a message in case the
> pagetype was unknown, as that is reporting an error down the chain.
>=20
> Let us merge get_any_page and __get_any_page, and let the message
> be printed in soft_offline_page.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Looks good to me, thank you.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
