Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD012FAF23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbhASDbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:31:32 -0500
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:7264
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727967AbhASDa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:30:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIltWIF3Hsp/rD1xpYHyj6dDhvViL4CAjkqcF/jiNTLzWznQncH54sCo2Btk+02m0b6Qz6/G7Q3tGb6Y6S7FgFLcBgpJdF9Y9dO7k5pr8fqwpA4o62L0v4yVUFQKSAjxrSfivenEPvFHFwcvAJrEpM7TYv3NXbqWJhMUwoZGnteWkPs1WV0VKH5NqIBDzxa7KA9+TWbPUVUDsj+U22RxQOVkyadGkmPLQuNVkCeB/8g0GtQeTAg4MxuesNZy7V52xqQF6XWfU+wy7zBQ6L2Htpp/8OXdOhw40mguY/dRRpBaUcTP1cAddtnCgKaDxgfN1x6O61Rvr8NoIxyt5VwEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOGqIKC54qLWgpR1uPbtCJ4dSXwmhxXSeLmzfWzQc1o=;
 b=lE4KZpnlilzs0b/9SFRfvkbEk+suqkTBXVEFE1fdr0LWVzryKzIIIcWwbVj04/YETMBsfQx/FihvpifjSC+VBSus6xBg67x5MOcckAwy3zZtkdvZDTeMCh+7fSLLqLF384xmd0NCsGktNHrWfBhmBs3Rt9GBsCy9sHhZKAfT9EeyEcHYM8qKBWSXmDfecoPa5M3qYJTJc0D7+7DhzlhYAeg6Q2uu0ae/IGfP2duiIyV7Iv4fPbO2nceg4kuNFI+UbG4tgnUoIxWNiRBc+xebGCtPnZKYkVEcHcBKr3VBUDM56mGlsNtIZWduhdWwh+IaqieGJSA9Tj8MeaQG4h+d/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3649.apcprd06.prod.outlook.com (2603:1096:203:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 03:29:19 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 03:29:19 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Joel Stanley <joel@linux.ibm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrewrj@au1.ibm.com" <andrewrj@au1.ibm.com>,
        BMC-SW <BMC-SW@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>
Subject: RE: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for
 ast2600-A2
Thread-Topic: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for
 ast2600-A2
Thread-Index: AQHW7YHZdhH4w0G0EUiHJl1Fb3UNq6ouOC+AgAAL2OCAAAIggIAABT0Q
Date:   Tue, 19 Jan 2021 03:29:19 +0000
Message-ID: <HK0PR06MB33802278B7E3179B3229390BF2A30@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210118100813.30821-1-ryan_chen@aspeedtech.com>
 <20210118100813.30821-2-ryan_chen@aspeedtech.com>
 <02b792c847ea1841603629ba0377cfdfff479882.camel@linux.ibm.com>
 <HK0PR06MB3380AC1A1DF9C0883E83F752F2A30@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CACPK8XfuiN_Nxfwf89ig5tgEo1dmiV_k092TVu527w4fYVFE0Q@mail.gmail.com>
In-Reply-To: <CACPK8XfuiN_Nxfwf89ig5tgEo1dmiV_k092TVu527w4fYVFE0Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec1fbb21-8129-46b8-375f-08d8bc2a682f
x-ms-traffictypediagnostic: HK0PR06MB3649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB3649F8C59ABE2ADFE7EAEA06F2A30@HK0PR06MB3649.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5W8Gp+W9rHLOGRW9v95x29zVWiutR5yWBnwi4eNrcj4NxSe1Njm/97e/yLNWJopIy+n31ZLnFVG6YznI0Ui2lr5s0bRoQbvKpq4+fXyxfnhPVsO8IjP2XX3hOnKrxCQqa4CDcfZuje0OW9Is9Ba8iS0zm4Fc8VzpzqmjJKw9DvXNxZ8mIFdF5oJcA6UeAycEh16OLLN994pS0Xe6tws+q/37tLxzK1x1uB+ZqHYnEtQ8tMJnpIYGMyZ6L4gKMmaVPJH6pLAx9/VJUbr5Sh1KhagIkpCuQPsSOHh6LcZvclL3Cls+H1urtPJzLVPGRirHFl8sBHRhUT71wvfX6Jq4uzOxS5SCi1ruAjIVovvAb6Y269QG79OF6WeIgVQMlPZNFq0aVnpFmUMbAwRR1J+qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39840400004)(376002)(346002)(76116006)(66556008)(66476007)(8676002)(33656002)(66446008)(66946007)(316002)(54906003)(7696005)(8936002)(64756008)(9686003)(53546011)(55016002)(478600001)(52536014)(86362001)(2906002)(71200400001)(4326008)(6506007)(83380400001)(55236004)(5660300002)(186003)(26005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QmFxZ0N2K215clBwcHJoSkdhVHRGSmlVOWRKaXY3YTZzWFhVd1d0K0YwNEUr?=
 =?utf-8?B?cmtCTUpRQ2g3V2JtWUJXOUp6OVZEZFpBaStIVTdXZE1uMm5pQU1HbmMvZVQw?=
 =?utf-8?B?Um5zWGw4bW4rU0l0MW1qM1BpRTNvSzIyTXIvK3FnZ0hxQzhTbHhza0IydXdE?=
 =?utf-8?B?MUVpR0pKb0VhWFhJVTN3M2h6UUt6bmdRcllIN0F5MlRKbGU5ajlwdWNTbisv?=
 =?utf-8?B?UlRQVnlEOFJGOUFYZW1uOVhOT1kzYTFwYUk2MFFESHpqVGxFdEpVTkJEQVk2?=
 =?utf-8?B?anMveGJCa3U5QlJ2MzljbVVCbWtCbEhmNy9lM0Z1V2JGaEw0dUpGejc0enBQ?=
 =?utf-8?B?U01WOWhnNGFrUWx1MTdVVXh0a01nRXRMU1ZpR2kxOFlCaVdwTFRhMmprZlMz?=
 =?utf-8?B?U2Y5L0p0cU80YjEwdzVlRThPVHdiVkRuZ1plMGlmUFMrb0crbVRJUHorNkMw?=
 =?utf-8?B?eElIMlNzRDJGcFZXZ2FHdm04Vk5tQ2d6SlRBQzBLWXFUL3FSblpuczdtdjJN?=
 =?utf-8?B?UkFVUkVFQ1BJK01rVFdndjBYVFhZenlNTUdxa0h0U0pyUGtFckVBOGRWbW0y?=
 =?utf-8?B?UVpJRjZnZHhhcVdsZTJPbnF6aWRldVFUZDgrdE1FNTdKS21CV04rOXR0Rnda?=
 =?utf-8?B?UlRGeU1VeVM5OVV1VlpwWEpyT0dNeXRDRGZCSG8xbHJ5YkxvN1ZXTENtY20r?=
 =?utf-8?B?UHVVUG1IT0NCYjlaeG9PN0xRdURZYllXSUMra21MVjFNRi8rWGUwN1owcVJi?=
 =?utf-8?B?LzJHVUtkLysxZk45RzB3K29lQUF1RUh2YWZReGZzby9rRC83SHZWdDltdDc5?=
 =?utf-8?B?eFY4MnpGc0hJQW1LVXNiVHA3aGVBN295ZjZrZUkvNHl0ZGE0OUN6U29TV01x?=
 =?utf-8?B?ZnRRaWQzRDdJOGNKc3k2aXNaS1RkUHB1bmdoRVpwVnhhUWtJaS9LR2JhVHA1?=
 =?utf-8?B?akhvNW9DTzI5YVlUU21YUWtjRTFzcS9UVk5LTXU3bW1TVExBaElXTzhUMnB2?=
 =?utf-8?B?b3IzS0w4OXVVdGpxak5EWG5wSzJ2b2J6QkdjVnhSRmxXSDJiTHNzODhYczhK?=
 =?utf-8?B?ajRkZ2JWUXdQK2FUQmpuZ0xzM0tQK1pHZVNtaUpHaDh1UCtDMDdaWTFIUTdl?=
 =?utf-8?B?bzF5TUE4M3Z2VHdVRFYzckFOb0t2K2RjOVd4WHJrWlgvUi9NN29hc0RsNmd1?=
 =?utf-8?B?dVFUM0VMdS91MEpmbFNxL1dDL0x6cnBBWGppei9rYW1sMDBWNjNjS1dGT1V1?=
 =?utf-8?B?KzVvRkRteHRxcFVabXFBTW1pbTZhVEVPb3B0Y2xtUUc0VkkzL0grSEduTkxF?=
 =?utf-8?Q?VV2NluQ1I+CfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1fbb21-8129-46b8-375f-08d8bc2a682f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 03:29:19.4924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHZjt9MSiHS1G5dNjkLrGQTH+P09g8U97PhjS5GUOpRktY+NezLzXQWhtF0Y11kFmhT0IDoKYK8Dz/sLrPTn880ZxehtXAt3nXf6sRuIApM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
am1zLmlkLmF1Pg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE5LCAyMDIxIDExOjEwIEFNDQo+
IFRvOiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gQ2M6IEpvZWwgU3Rh
bmxleSA8am9lbEBsaW51eC5pYm0uY29tPjsgTWljaGFlbCBUdXJxdWV0dGUNCj4gPG10dXJxdWV0
dGVAYmF5bGlicmUuY29tPjsgU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsNCj4gbGlu
dXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
YW5kcmV3cmpAYXUxLmlibS5jb207IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPjsgQW5k
cmV3DQo+IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAx
LzFdIGNsazogYXNwZWVkOiBGaXggQVBMTCBjYWxjdWxhdGUgZm9ybXVsYSBmb3IgYXN0MjYwMC1B
Mg0KPiANCj4gT24gVHVlLCAxOSBKYW4gMjAyMSBhdCAwMzowNCwgUnlhbiBDaGVuIDxyeWFuX2No
ZW5AYXNwZWVkdGVjaC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSm9lbCBTdGFubGV5IDxqb2VsQGxpbnV4LmlibS5jb20+
DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE5LCAyMDIxIDEwOjIwIEFNDQo+ID4gPiBU
bzogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0
ZQ0KPiA+ID4gPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgU3RlcGhlbiBCb3lkIDxzYm95ZEBr
ZXJuZWwub3JnPjsNCj4gPiA+IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBhbmRyZXdyakBhdTEuaWJtLmNvbTsgQk1DLVNXIDxC
TUMtU1dAYXNwZWVkdGVjaC5jb20+DQo+ID4gPiBDYzogam9lbEBqbXMuaWQuYXU7IEFuZHJldyBK
ZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0g
Y2xrOiBhc3BlZWQ6IEZpeCBBUExMIGNhbGN1bGF0ZSBmb3JtdWxhIGZvcg0KPiA+ID4gYXN0MjYw
MC1BMg0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgMjAyMS0wMS0xOCBhdCAxODowOCArMDgwMCwgUnlh
biBDaGVuIHdyb3RlOg0KPiA+ID4gPiBBU1QyNjAwQTEvQTIgaGF2ZSBkaWZmZXJlbnQgcGxsIGNh
bGN1bGF0ZSBmb3JtdWxhLg0KPiA+ID4NCj4gPiA+IFRvIGNsYXJpZnksIG9ubHkgdGhlIEEwIGhh
cyB0aGUgb2xkIGNhbGN1bGF0aW9uLCBhbmQgYWxsIHN1YnNlcXVlbnQNCj4gPiA+IHJldmlzaW9u
cyB1c2UgdGhlIG5ldyBjYWxjdWxhdGlvbj8NCj4gPiA+DQo+ID4gPiBJZiB0aGlzIGlzIHRoZSBj
YXNlLCBkbyB3ZSBuZWVkIHRvIHN1cHBvcnQgQTAgaW4gbWFpbmxpbmUgbGludXgsIG9yDQo+ID4g
PiBzaG91bGQgd2UgZHJvcCBzdXBwb3J0IGZvciBBMCBhbmQgb25seSBzdXBwb3J0IEExLCBBMiBh
bmQgb253YXJkcz8NCj4gPiA+DQo+ID4gQTAvQTEgaXMgdXNlIG9sZGVyIGNhbGN1bGF0ZSBmb3Jt
dWxhDQo+ID4gQWZ0ZXIgQTIgaXMgbmV3IGNhbGN1bGF0ZSBmb3JtdWxhIGFzIHRoZSBwYXRjaC4N
Cj4gDQo+IFRoYW5rcyBmb3IgY2xhcmlmeWluZy4gSSBzdWdnZXN0IHlvdSBjaGFuZ2UgdGhlIGNv
bW1pdCBsb2cgdG8gc2F5IHNvbWV0aGluZw0KPiBsaWtlIHRoaXM6DQo+IA0KPiBTdGFydGluZyBm
cm9tIEEyLCB0aGUgQS1QTEwgY2FsY3VsYXRpb24gaGFzIGNoYW5nZWQuIFVzZSB0aGUgZXhpc3Rp
bmcgZm9ybXVsYQ0KPiBmb3IgQTAvQTEgYW5kIHRoZSBuZXcgZm9ybXVsYSBmb3IgQTIgb253YXJk
cy4NCj4gDQo+ID4NCj4gPiA+IFlvdSBzaG91bGQgYWRkIGEgbGluZSB0byBpbmRpY2F0ZSB0aGlz
IGlzIGEgZml4Og0KPiA+ID4NCj4gPiA+IEZpeGVzOiBkM2QwNGY2YzMzMGEgKCJjbGs6IEFkZCBz
dXBwb3J0IGZvciBBU1QyNjAwIFNvQyIpDQo+ID4gPg0KPiA+IEdvdCBpdC4gc28gc2hvdWxkIEkg
c2VuZCBuZXcgcGF0Y2g/DQo+IA0KPiBZZXMsIHBsZWFzZSBjb25zaWRlciBhZGp1c3RpbmcgdGhl
IGNvbW1pdCBtZXNzYWdlIGFzIEkgc3VnZ2VzdGVkIGFib3ZlLCBhbmQNCj4gYWRkIHRoZSBmaXhl
cyBsaW5lLg0KPiANCj4gPiA+ID4gKyAgICAgICB1MzIgY2hpcF9pZCA9IHJlYWRsKHNjdV9nNl9i
YXNlICsgQVNQRUVEX0c2X1NJTElDT05fUkVWKTsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICBp
ZiAodmFsICYgQklUKDIwKSkgew0KPiA+ID4gPiAtICAgICAgICAgICAgICAgLyogUGFzcyB0aHJv
dWdoIG1vZGUgKi8NCj4gPiA+ID4gLSAgICAgICAgICAgICAgIG11bHQgPSBkaXYgPSAxOw0KPiA+
ID4gPiArICAgICAgIGlmICgoKGNoaXBfaWQgJiBDSElQX1JFVklTSU9OX0lEKSA+PiAxNikgPj0g
Mikgew0KPiANCj4gV2lsbCB0aGlzIHRlc3QgYmUgdHJ1ZSBpZiB0aGVyZSBhcmUgZnV0dXJlIHZl
cnNpb25zIG9mIHRoZSBjaGlwIChBMywgZXRjKT8NClllcywgaXMgYWxzbyBzdXBwb3J0IGZvciBB
My4gDQo=
