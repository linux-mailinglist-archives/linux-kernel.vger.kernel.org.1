Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4452EF079
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbhAHKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:12:48 -0500
Received: from mail-eopbgr1300079.outbound.protection.outlook.com ([40.107.130.79]:19253
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725984AbhAHKMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:12:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWIo+p8N58yOTqwC/HUi5qqjrbydIduaSNlebhi3E5h+vr9dQv1JjZTYLPTAz7Imx9oYHWKqYS2iLnYB7Km4CyS8HyyDoazmKR8XtiPaV7QqukC6Zfv4oPF5k6+vNNV+q5aVY9rU6umw3OuczqBd3HmuPLCyPi6Yfgv5YeYNi633IZ3GCvyHXgVzN/IwfeCZLtz9LikpNz3x3//ycXD24764tEx8hX9T/xvW0pQMryHXxNACpOnHR6UQX/dQ0cywlTBQ515tTzez69DVYEKW/TxsHz9+/dyvwW+I8/6QZ+Hh8z2eTPccQsM/y5jI82cEoTIeD36Xoie4BuynsVrNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Zk9dWZYUpGh2aBUJPb/Oup3gmYlrsx1hgFqWtRo4w=;
 b=lc4LLiHBhOh0IUJTOSk1P8mKy65dBMO9S5LHI002qXmy79C0UARR2rHJPfMpmvm86W3scjnJohTz2+brqsUR8GrPk63Q+ybgPx+FJVlhErZDKvkXG42IAXg1P9b8XqUYP2pn1OZ8iyjwoaNbyp/FJqNw9Ro7js859tIaRT0oVQfa/OFuxeoolDpsRXRNC93ba1F/V3OHzlBGPNy7dJ2HpxWtmcFE16Dwzr7B7btqYON5kBcQz0dN/Yt3l8dRZPbDxa1oXn8bZ9XXctmRoU+OHYoBDdID5LHN7frYxzIXH9vOCGNQv932GwfcYjKFuzGRl5o3egWwreJOlkd4uO0cEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Zk9dWZYUpGh2aBUJPb/Oup3gmYlrsx1hgFqWtRo4w=;
 b=j1KihTiKB3ycjDTZgd5uOiY1Nmh0FUt2lP9hqHTvuXGWT/qkPM8H/0PC9jtnDv6AEGPZs1O12ubb+8FWRY0+6JTtrnRWVNAeEMZs1fqYwlNYGP9rXQu24mXTeekWY++0QNUkt3QdN7kEn9IUfJAfaBGg5eu9y+O07XjD+BFuriU=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB2890.jpnprd01.prod.outlook.com (2603:1096:404:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 10:09:42 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244%7]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 10:09:42 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,hwpoison: Fix printing of page flags
Thread-Topic: [PATCH] mm,hwpoison: Fix printing of page flags
Thread-Index: AQHW5ZuXSXhapE6dK0GzLtlr+1Qn0qodgYwA
Date:   Fri, 8 Jan 2021 10:09:42 +0000
Message-ID: <20210108100942.GA8370@hori.linux.bs1.fc.nec.co.jp>
References: <20210108085202.4506-1-osalvador@suse.de>
In-Reply-To: <20210108085202.4506-1-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efdbe778-5ebd-4aab-e5eb-08d8b3bd8478
x-ms-traffictypediagnostic: TY2PR01MB2890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB28902341FEBF6C76C963C871E7AE0@TY2PR01MB2890.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXZD4UdWDugBJVprQdgGAvTlH05b/bwluusYyOLC/zxo2EkJJfYIxLCIXWrdIMsBBn1qnl1ceIG0PQoAXlHM2Y7Mijsy0xEv0vCN8W9Myhh2tkcNJ6X1Ai0oSO4/v3QoSJponlm+jUqGOicOTp9TL4wAt3G6vA8uemeWEgn36ieyPIPKc+dC3vodnRI76YiZ7UysYsPNOUgAZJb1x5bsGXLTKgX1VL/frigmnxrimiO+0CqvB8gj9Q8+v+ILJD01xHcAiMazkrrFt1XTFLvZwD2oU2no0cMN5J1ndxBMl/8qTo8Qk8wuuLn7bvBvzU1pF932Xx4PdDKoCryFUcKDyv54/catxVIu5av4m58fFLHfiQBKfobAYs4DS409yJ0beCYr6MPgS1FJGcrmp1TvMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(26005)(33656002)(6486002)(76116006)(55236004)(4326008)(6512007)(66476007)(66556008)(6506007)(64756008)(1076003)(9686003)(316002)(54906003)(66446008)(66946007)(6916009)(71200400001)(186003)(85182001)(86362001)(8936002)(8676002)(478600001)(558084003)(5660300002)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?WHRTNFRmY2IzdGtiQ1VwUWNTbjZjdEV5a3FidkwrV01nYUJnVHlzNk9n?=
 =?iso-2022-jp?B?MU45blh5WDdSMXBIRGlBeHlhdWZ4MWhZNjMvMXpIUVl6UXUzVUxDOEdt?=
 =?iso-2022-jp?B?NXM4SVJ4Y2Y3akUrUmFGaHFKOVJVd3N1K2FZZHZRRlk2SjhCVFQ1RWpW?=
 =?iso-2022-jp?B?aTB2VVhDaytMVEhlb29OdFkrcGtRSzk1WG9kQzVsVVNhUC9GS0FZUDJL?=
 =?iso-2022-jp?B?b05lUm53TGNRUlBYSUZLd0M0UGgwOTUweGczYStRUjNVVFZaMjZyRE5o?=
 =?iso-2022-jp?B?ellya1ZIV1pKN3NJbFB5TEZLbGhkS055TTdZbHFTSUx6S2VOdjg5b0FT?=
 =?iso-2022-jp?B?NFhZR0RxcC81ZWZtQU8zRVprL0MrZmR1NE5RYnROTFBoL1drTTl2MFcv?=
 =?iso-2022-jp?B?VDFvTHJGdks3WnZ3cHhwYWZlR3R6bUNadTdzOERxd0ZpNUh6UmNhVEd3?=
 =?iso-2022-jp?B?NUpKZkFmZkxmWlJyMFN1K1FudHV3WktXSmNDcEJKREsyQ2ZGc0hhRktE?=
 =?iso-2022-jp?B?WGVJTUtKYzh5ZjNkaUNsb3BJbnpvMDBmQjVRa1o0K2FFQjRaU3JkZzUz?=
 =?iso-2022-jp?B?dUovU0Y0TldDS0NQcEJiSXlIOUR2Y0ZsKzgzSVNpZG9CTlZqUjBXMmNm?=
 =?iso-2022-jp?B?cDJhaE8vcytlY3ptZEdTTlBzTXFISWVnNlVuWE5HS1FNeThOWHJFakJs?=
 =?iso-2022-jp?B?RzFrRzYxWEpWZEYwbFdjYk83alJkWXlWMDJsOTUraFlVdHdoNDdJSUhp?=
 =?iso-2022-jp?B?VVBlRGxsb0ZIS2hSeWV5OW96aytZNGJOOEYyUFBxa3pEcE1QMkRhMzlS?=
 =?iso-2022-jp?B?ekN0Ym5SUk9iTkc4eWpFbi9FbzZTZ0gwNVRkVFozeXVRL2xVbnN5Q2dN?=
 =?iso-2022-jp?B?WUNVeEZYSDdOUk1NcGRCOWRBUlFlNFk0eFRQWGd3L2s1bm1MVlZpb01X?=
 =?iso-2022-jp?B?ejZjT1lEYk9lL0JIbHkxUWN0eWpobnM0NDZyc042ZHgyQngrcVNRYXEy?=
 =?iso-2022-jp?B?SUQvUVhOZ0hVQ2xDWWxmV2hvNkN0ZThuR0NRSHo5a1RhVTVZdkRiYVgx?=
 =?iso-2022-jp?B?SThKaXlOQVVrbkJNSzdyK29KQWRJQW80ZEdXVHg1S0lFSTBPa0d3SlBO?=
 =?iso-2022-jp?B?QlpRenA3T21kS1lkYmFNSGs5cGsyV0J1eldBbW9lTlBvMWx1ZG5saUMr?=
 =?iso-2022-jp?B?blJ6eGlqZjEyaDUvM1hibVN3QkVCeEczNTBMV3ByYmZuU2NnK2tBM1dy?=
 =?iso-2022-jp?B?ZGxSNERGM0kyV0pkQ0VTUDZibGxSdno0OXNHRFVWL041ZFEzN3JaTkpN?=
 =?iso-2022-jp?B?V2F2Y3BTMFdlU2VwZXJ0V250UUdXbWJCazVKOGUxS3NBclp1RlRNUEtN?=
 =?iso-2022-jp?B?c3FzQUxuclVmVWJVYi92aThjWDNIR1IxSVo2WVFUUTltRVBzRDdpL0FN?=
 =?iso-2022-jp?B?cUlyaisxbFJFdUNlc2Z5ZQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <115658BF5277A24FAC0F8F43F023C443@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdbe778-5ebd-4aab-e5eb-08d8b3bd8478
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 10:09:42.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXPRMKCAH9h0uHqlFf1+y53pEZPcKZg4QpNoyLacfjnnsvZqjH0+1i9+d35mypd5Nubpz5RoTEnO7xJQ6FPFjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:52:02AM +0100, Oscar Salvador wrote:
> Format %pG expects a lower case 'p' in order to print the flags.
> Fix it.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Fixes: 8295d535e2aa ("mm,hwpoison: refactor get_any_page")

Thank you!

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
