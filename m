Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44E22A4E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgKCSTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:19:20 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:60762 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604427557; x=1635963557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IXj6XTzfpqHrPGjJWRvZueeoA+ugwaMaONQZQxyElJE=;
  b=r53eoksl7AbHxf1Xxou4E/8JgutEhLw3fEhBzvqzMq2DjRi/+fptk6e/
   VIUZEXNvfmUjJC5Xc/rgCBj/NdeSomtMIYyt35WgbzAHdBT6IlLoYhrVU
   hb3eDjBX7XZxdEGQS1ujWmm2V1T8cCocmrVXFF2iqUI2FcT4BmKTO/YWg
   TiXH047WifkhNe/zHTEgV8KNMyFLL5NuMedeayvMfIg+fTgwoGYSl92P2
   kCAsk0cEeFYLu4rsFNSQ70jK3AOZVUGiWgW9QW90270yoNZLSGJsxncw5
   bsWeUafOizPufwi9Bp2w2Kp39WAJrI8B9tCpd9IaFLsa7zDLXIt5w6l6c
   g==;
IronPort-SDR: TURRtInihp1DCR2MZfA4kVJgTRZwlRwisTJF+6sH/N475xzrXnrnDvu1j2zQSEdBxaFo2qWntd
 u8b+ucAw7PGCZoaMhlJ4mJgC56CkaPxQIE2iYNZ8pdVMKdETgfvTgXu+dpmBV4/U0pYiPkoxmT
 NNkmT5e01HFusvQrCgl3rZtkcg5bXFqQOkttVCjezx4ycOdcINk63V7X7R9hkC9QPP+rj0rW/q
 u+fgNLpslfVPZW6dsy6zrh7dAYbdYDMVkd/tAMlHJekZwOy8rskSK6zvKpy0fJK5MM+Pr1B8gg
 +9g=
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="102022197"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2020 11:19:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 11:19:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 3 Nov 2020 11:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV563Cb+U8NcX+3u8v6AcheOb4G6BymR0CB35qX7v9ucKbXI4rwhdJtHzN3OMAd3tFnb6me1ytPrZWBaZmsDNW7BRCFhv6tJCcpsFUG6EEVYeg1hYwDvXv8jFMkfPsrekfrCryhIJmAozFQwdI55znnRAbGW7K9r92czpRziP7oj0ks1SQb/JluFZdur7IhmXNPgHvqvfbxFtvO7C9bVrpColZep8U+W6vnOVf1sjg9gdixxLn8UWVC81D+9Ezxy9ApLOE2f+qeDNcmwfSIshE5UdLskRF8PzOzU42yx8thGtoNa4o7mw/QczYZP9VO+8VMJFKjTJzYIyIFEQEfHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXj6XTzfpqHrPGjJWRvZueeoA+ugwaMaONQZQxyElJE=;
 b=ML++hixd2LHtGGbmXVDZgQrlti1cG+MKBQlncOvLmCK+4dG/SPkyAhv1/ZyAmvdPDU0KXERFs5+xWIb1yDqHCrwsa80q78gg2Zaf+07wihBUTtT8zGlQFPXd+pFZN2w5oDAtQlWhatODJ4TKY8a4XhUV3jza+phXnP5beh7HEgwKJuzAJXnfiWIfBFDoAb5vOFgsF27hJQxKHJDjNQ41QaPIBq2qvtaPNQAyjCSacQqbx4xb3/MdtoBfoPNTG2jk0qfgPvEN4FB6SboESGPGhKau5KZG57xwO8DYOnRZSE6I7bBgagpBygNcmJd3uXO1oaOHnZpzNIUrlaRtc8/N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXj6XTzfpqHrPGjJWRvZueeoA+ugwaMaONQZQxyElJE=;
 b=huqthp2O1DcRTVGxJo+ZqHCTEKaFGhGtbDsGEs9y95XKZW/iIxgqFiV7xsxq4OhIp07dNNVpwBWweO+z+pA2+FnThF8lE4Xw8iIaO4hZKz1x7/5ICNAljasrA/YiZOujFrmshFDANQ1AGYZyHD/jWQxZoOg4Ue2pXKzd+g5KuOU=
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by DM5PR11MB1386.namprd11.prod.outlook.com (2603:10b6:3:11::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 18:19:15 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::8dfc:4424:3709:9e69]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::8dfc:4424:3709:9e69%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 18:19:14 +0000
From:   <Cyril.Jean@microchip.com>
To:     <bmeng.cn@gmail.com>, <anup@brainfault.org>
CC:     <atish.patra@wdc.com>, <linux-kernel@vger.kernel.org>,
        <aou@eecs.berkeley.edu>, <alistair.francis@wdc.com>,
        <anup.patel@wdc.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>,
        <Padmarao.Begari@microchip.com>, <Daire.McNamara@microchip.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
Thread-Topic: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
Thread-Index: AQHWrYIX44xaU0n+lU+FVu/TfSg/namv3J0AgAZYq4CAAIteAA==
Date:   Tue, 3 Nov 2020 18:19:14 +0000
Message-ID: <e9bad05c-db34-ba2c-df5c-ff2f7f53e15b@microchip.com>
References: <20201028232759.1928479-1-atish.patra@wdc.com>
 <20201028232759.1928479-3-atish.patra@wdc.com>
 <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
 <CAEUhbmUm6EyP33FU1n4LhEk-xcBtR13-xS+Tpt76ug1HQv8CEg@mail.gmail.com>
In-Reply-To: <CAEUhbmUm6EyP33FU1n4LhEk-xcBtR13-xS+Tpt76ug1HQv8CEg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.40.244.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc111bcb-46cd-4f44-4530-08d88024f885
x-ms-traffictypediagnostic: DM5PR11MB1386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB13864421CC560F4D458014509E110@DM5PR11MB1386.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5LbxqxB51hq0Rou/ODDogjojGgVEfTHTy1c7BHnNAhDe8NoQJqjjPk7PwMPk98eqldEbjCYEuYi7zqgLgM+lSbQdtkLjMoEvYPWnfeql5KgAXvRypOfI5UKLVk9w5e5xoMWPSpF/VfQR/MJZN0bOgE+vizcumc9DfXB/OZqpBxmAk8XGs8Xf38tukMFaMQ29cQ5olPSxCbS9m1bUrOJ8Dzz9034CC5q4Gs2+hsP5TwrVZ8/oED0a0xY2gq9ByHjxU0tNvmAMv6FmObBXTmvtFPmBkrN+53i+NjoEbPdgZowzz0uBKDPDHe9p00qrH2VH3UNRMPgwmKmBUc4JgqkhEL5/mVg5mBjE2K468bwH2f985DGxvranVdvA3rv6rRNe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39850400004)(366004)(2906002)(478600001)(36756003)(4326008)(86362001)(31686004)(316002)(4744005)(186003)(7416002)(110136005)(54906003)(71200400001)(8936002)(83380400001)(31696002)(6486002)(26005)(8676002)(2616005)(5660300002)(6512007)(107886003)(6506007)(91956017)(76116006)(66446008)(66946007)(66476007)(66556008)(64756008)(53546011)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HIZX24S4e/KGOkvI8Lt3VVuyEH6XUipuVCMyV3/rY2AxkWHRoqebqPmBNyTbJJBleReou8QXW6487du8Q8xJsTM467kfO+/yzKrnrmetEgvwfbufcO8TPh1Idgto9zWh7SxA9YnR3y7/SFfmRy5uYJOtlT9A9+FuNc2bppAIjNPGW/cPBFqb0R38SAECjjzuDAENc6Mzaco8lXVrGUNUJK02ymuoAB6YFcgcCkI5RgGkaRm0LM9b5PX3cFhZf2MWk+H62cLGWdoURQGBVH6vQkqNlnKeTreiZM/b2HuSgFqOfsc0WpMmHgjA9YvNyInvzjBxcHcBk2mzSeqtyVyjTQwBMZ80Cs91sBuDk3zvRPFF0rBRGHnpR3mZOyZ7SRH97NSoYIAC+Y0yr1Mt5APhHJnITBQA3UNQVJKVgajdzz5dfUxm/gNsCTNMO0Xm316RlBB6PlBvr8nIlqHAFxNOA9ksmxXS59I1sgtJf7pQRqrWtMdwsCRsolyVl18LtnXZQk7OQ20JQQXqKgABRntUyQwJJ8Qo1BBKZu111ljM2gSejSKmWvdD+o7y1FbPIHBdXfnm2bwb5xwMOnfmehu9E3EUOSq+mH9xmivUSuL4Xmi61sQTNO8YqIWqS34GO0Tf1nPyGBOibibeicphgM2vZw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B899B950803CC84A8CFEE5D1426A3BD3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc111bcb-46cd-4f44-4530-08d88024f885
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 18:19:14.9166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MThLvFPaKsI/Xy+QSWJCZlTGoFZ/O3zHAbincCQyELmEstbyeDBl3FPYREx34Lpwwd5DJ2uX/TPf4clCG4kPXR1U+iDr/+kyN1b0JkcO7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1386
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMy8yMCAxMDowMCBBTSwgQmluIE1lbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBGcmksIE9jdCAzMCwgMjAyMCBhdCA1OjA4IFBNIEFu
dXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+IHdyb3RlOg0KPj4gT24gVGh1LCBPY3QgMjks
IDIwMjAgYXQgNDo1OCBBTSBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4gd3JvdGU6
DQo+Pj4gQWRkIGluaXRpYWwgRFRTIGZvciBNaWNyb2NoaXAgSUNJQ0xFIGJvYXJkIGhhdmluZyBv
bmx5DQo+Pj4gZXNzZW50aWFsIGRldmNpZXMgKGNsb2Nrcywgc2RoY2ksIGV0aGVybmV0LCBzZXJp
YWwsIGV0YykuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0
cmFAd2RjLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+Pj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3Jv
Y2hpcC9NYWtlZmlsZSAgICAgICAgfCAgIDIgKw0KPj4+ICAgLi4uL21pY3JvY2hpcC9taWNyb2No
aXAtaWNpY2xlLWtpdC1hMDAwLmR0cyAgIHwgMzEzICsrKysrKysrKysrKysrKysrKw0KPj4gSSBz
dWdnZXN0IHdlIHNwbGl0IHRoaXMgRFRTIGludG8gdHdvIHBhcnRzOg0KPj4gMS4gU09DIChtaWNy
b2NoaXAtcG9sYXJmaXJlLmR0c2kpDQo+PiAyLiBCb2FyZCAobWljcm9jaGlwLWljaWNsZS1raXQt
YTAwMC5kdHMpDQo+IEkgYWxzbyBkb3VidCB3aGF0IGlzIHRoZSBjb3JyZWN0IGJvYXJkIG5hbWUu
IEkgc3VzcGVjdCB0aGUgLWEwMDAgY29tZXMNCj4gZnJvbSB0aGUgU2lGaXZlIGJvYXJkIG5hbWUg
Y29udmVudGlvbiwgYnV0IGRvZXMgbm90IGFwcGx5IHRvIHRoZQ0KPiBJY2ljbGUgS2l0IGJvYXJk
Lg0KPg0KPiBAQ3lyaWwsIHBsZWFzZSBjb25maXJtLg0KPg0KQ29ycmVjdC4gU29ycnkgUGFkbWFy
YW8sIEkgbWlzc2VkIHRoYXQgb25lLg0KDQoNClJlZ2FyZHMsDQoNCkN5cmlsLg0KDQoNCg==
