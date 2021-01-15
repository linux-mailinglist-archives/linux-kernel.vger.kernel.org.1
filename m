Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577F72F74F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbhAOJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:11:13 -0500
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com ([40.107.21.46]:27806
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbhAOJLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:11:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW+QLKO/xjLDKwJhCPa4ytYGU918ede6U4kUv8CRRxJbjdJ38te2MtUvjIlR2Sy9zArjEwXodR5R/TSL/x9W8JbcCQzIlmZmR6gBLaDcC1U2MXV4RAtdETJdVvTaCWfDlZsyMlRWeCUU6QxHzT0b4fATyMmWcM8LCpqkcWxpSlcdBa09dZXO3tXAEAK459uEk6suEOQYB9yo8uKAP1VieNfknJxMTT7zU1gyqsbk4scUI5M346p2O3rMpUEtlYnCqPBBvnRFlCstTev88kkGphf5BkMTZwHKNmkJQEKkWJgvkDU3nucO1nzE+wZT3pQJuT6I9MWZTq6G+jWl68NcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrhOPff/kQRbfiOVFyT7a6r3sxjFnR9lbuAVbMWZt7w=;
 b=Peak1fNluI93N50xws3P88DNa0fut56qreKlj7ebB1zpI79caM6LObz0Z9EfLOJfQJBVnX9Cl0BAW8rFgksJEOu2QzdFhPniRMu4mG1woACMs3rhsOaomON7dDTGSO7LgDbvwCwiqwfRtiRJH/j0xZyWbSIRiDpDfCaLA5R5F9ig8XdOcVWHGCB1lXf0VHw7v//WLqLAbHiHCPSR3D/LdITFKoNKXUKz9EgGVBgb+ntnEQOA8JuBdrM9Smfr18oNQ5hgHzM+XG0pyjdHWl8Ce1AMu8fUX5b4SgyPY7bBFr0uR/nTj8aAcct/RpEUd07+60irUA3+bDGt7N4mAcsfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrhOPff/kQRbfiOVFyT7a6r3sxjFnR9lbuAVbMWZt7w=;
 b=F9TvyjcMNPcv772Wc7BFjxZt3afdzM1DHvCCUwT9Jfj1mVboIM+Fu63fNhobwc5oTYvaMlo+RNRJZrinetp6r5RD7327PRo63c1JHzWQA1ElMmA16H15d8za3/PPUgs8kLMfySstZDQY8ehIHZL1tovYrHxaH+AtVRtcfiimE6E=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3068.eurprd03.prod.outlook.com (2603:10a6:7:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Fri, 15 Jan 2021 09:10:19 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3%3]) with mapi id 15.20.3742.013; Fri, 15 Jan 2021
 09:10:19 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/15] regulator: rohm-regulator: SNVS dvs and linear
 voltage support
Thread-Topic: [PATCH 11/15] regulator: rohm-regulator: SNVS dvs and linear
 voltage support
Thread-Index: AQHW5cQiMhov2t0mN0aU39ggnMM9+qooZL4AgAAMNgA=
Date:   Fri, 15 Jan 2021 09:10:19 +0000
Message-ID: <d5918dd3f7c39306dce17d0ec82823186e9ea0ed.camel@fi.rohmeurope.com>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
         <f0af653b3d3d56bd1852468502518a54b31b1f10.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
         <20210115082636.GF3975472@dell>
In-Reply-To: <20210115082636.GF3975472@dell>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e822a965-40c5-4e67-9d5a-08d8b9356180
x-ms-traffictypediagnostic: HE1PR03MB3068:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR03MB30687A340BB9C822686122C7ADA70@HE1PR03MB3068.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxce6o05u1fUTH0WYQEglubMasYAp5uJHgY16AZlClkRcLn3852jAp0tASfMFj0mAyqFTpOEkrFysGJB+iAFvBwyQmmHlRX0OY4yTy7+FUNFSXawUTu46jXrAmyh5DhjLSbhEVmcUqY8zVWvKLbl0TEjfWPz8NTN1ERAxN5JOfS24TEOS7o5S1nByAF0vocCF/Sp7bwzClcjg5TCqenNw2/urtUMTLr2ILRdnfpHfkxtu340tE88MfNWE18uM4l+U9oj1njd4sK4ceQG8FuaHZrg425O15a/fLYnc9vUAzUxiY/G0LYkJpOYgn6p9ve665l9gGDZ9DScmU/g4mQCRJB8kAampAOGMcEn58ppfJTbM248J1kR4oMPsdZPGP2a+HKBR5bklECJkn7hMOfJ0PQrMhg10xTPu+DFkwiMvZGMFA+B7dUmZZIrdTcqkvODoUnMUVQWMRGSyvEbMORwgvPjlgsf66+ldTN4wHp4r9nMEL7idlWFpBVSfO7bRTJfIz7J1KcGqg0FwDBZWB0Fsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39840400004)(346002)(376002)(5660300002)(6486002)(76116006)(86362001)(71200400001)(6506007)(8936002)(6512007)(83380400001)(26005)(66446008)(64756008)(186003)(2616005)(2906002)(8676002)(3450700001)(54906003)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Nmg0eU1mYUNoQ0Y3VFduYmhEZ3R0RGdJdWRlYlF3bVZWb250UTd6WlpZUzNE?=
 =?utf-8?B?QXExZngxWDluemYycUZGc3RmYlZ0Nm5yMlNDSk0xeDN6bXovYXdvZjR4cmtV?=
 =?utf-8?B?WSt0ZjB2MndwcGxCUXp5U3pSZ0JGaWh1K3BWbmJlTU5yd01VajgrT3ZRSy93?=
 =?utf-8?B?UVBCYW5nd0wzYVFwaW53NkUrUmMvNlF5ZFRzTkhvbVZPZytFVFh1ZXd4Mmps?=
 =?utf-8?B?RGMwZC81TDNsSkFvcC9CVFQ0bWVuaThSbGl5SmY5WjVDMlVPSDhYVUUwdE5t?=
 =?utf-8?B?Zk1HaldMSGpVcjhybXBGaVgxdzdaTkxKa3EwcWgzdmZKSndKd2pyakR6NlV1?=
 =?utf-8?B?eXh0WXY2MGpGR1JyVFZIYVNvUWdWelVBdzJFT3VxR0VDYmRyZkFGMlBHeGVI?=
 =?utf-8?B?bjVpbkJEVXNRTmc0TWN5dVN2SHp2ZEFkQzFPbTRCS1lWSlVVQWkvOW1MUjJS?=
 =?utf-8?B?M3RGNmNWN1c4VktuZDdRaU1TUGFHZHh3bTZpTkJCK1ZraERQNHZaRVFKdWgy?=
 =?utf-8?B?cFVuL1llUjV2WDZJQkd6QzBTcFFzS2lDbGhhUHh5SFpNd2tBMU1BTFJkcEdJ?=
 =?utf-8?B?NUEvT24wZ1N1dGpGWEw3LzVXZzhtWkhNL0xaTkNMQW05Nnd5bkdSTmxXNWl3?=
 =?utf-8?B?ZmI1eDFTM1Zad2E5T1RvaGxEZEs3Zm8yTU9zOXJCbndjdGlZNmIwRHo5UGsw?=
 =?utf-8?B?dDZ0QVFLV2hyOHRrMkZOMUs1NWRkT0xFMVVRbld1aWNiSkppbWtHd1lpUDNB?=
 =?utf-8?B?L0pySk0vYkoyZzJTQXhGZUxRQm9CNW9aMjc2enFpcjJWRzl0VS92OHlGbFFs?=
 =?utf-8?B?YnlYQjVZNnRqZjFkZHNRdTNwRnVvN0JkOFdYWkRXb1d4ZjVXNGg2RzRxK0xX?=
 =?utf-8?B?YjZ5M21oZ2FRcmovRlpJRUZZYTMyZ1UySDdFcmx3ZzdCZUZkUEJjVG1EQzh6?=
 =?utf-8?B?RE5NYWdja3h4N2Z1SlR2dE1NMVRiSzB4S282dzhaRXlKd1FYbTY5UW83Uk9S?=
 =?utf-8?B?V2ljZ1VFZXBKZ0lMOW15RXp4UU1nYTEyVHpVVUMvMEczVUNHOFNFcDluV3hH?=
 =?utf-8?B?aW1ZQTJaQk1jVTEycTNtajBzYTIyN0ZZQzllN3VjdkxheUIxeWxRQWVuTDNp?=
 =?utf-8?B?V2NVc3NYS3R0RU9IdTZyOVRLR0RQU2Y4dmtYYVlxNUhwZjlRMnZ0Wkp6VFRn?=
 =?utf-8?B?S0hYT2EwWDZLZVBtTmp0Z1hyM0VwL3BvNFZLQXBnbHozQjRtS1NqS0hGemd3?=
 =?utf-8?B?NENwNjMyNXlXOG9GVWtBcTNwMVNrYUo2QTVaZ1R0OGFYMlg4eVNLUlh5d2JX?=
 =?utf-8?Q?l9BdsDWWYM7jlhrG+01FCVHkWu0J7TIH40?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <710ED99ED9191E4D89DF142684250766@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e822a965-40c5-4e67-9d5a-08d8b9356180
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 09:10:19.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Un9swsnqBT3os1+g1MqDKyawCf1P83YIna78Da0hyFYzgHCilJcLLs9EUrYJQJPXR+fiFNhNuMrhVJlji64G/0F7i77WaJGWu+1hbNKzv1M/wbyEp0r0CDL5nU0f8hm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGVlLA0KDQpUaGFua3MgZm9yIGNhcmVmdWxsIHJldmlldyEgSSBkbyBhcHByZWNpYXRl
IHRoaXMhDQoNCk9uIEZyaSwgMjAyMS0wMS0xNSBhdCAwODoyNiArMDAwMCwgTGVlIEpvbmVzIHdy
b3RlOg0KPiBPbiBGcmksIDA4IEphbiAyMDIxLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+IA0K
PiA+IFRoZSBoZWxwZXIgZm9yIG9idGFpbmluZyBIVy1zdGF0ZSBiYXNlZCBEVlMgdm9sdGFnZSBs
ZXZlbHMNCj4gPiBjdXJyZW50bHkgb25seQ0KPiA+IHdvcmtzIGZvciByZWd1bGF0b3JzIHVzaW5n
IGxpbmVhci1yYW5nZXMuIEV4dGVuZCBzdXBwb3J0IHRvDQo+ID4gcmVndWxhdG9ycyB3aXRoDQo+
ID4gc2ltcGxlIGxpbmVhciBtYXBwaW5ncyBhbmQgYWRkIGFsc28gcHJvcGVyIGVycm9yIHBhdGgg
aWYgcGlja2FibGUtDQo+ID4gcmFuZ2VzDQo+ID4gcmVndWxhdG9ycyBjYWxsIHRoaXMuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmku
cm9obWV1cm9wZS5jb20+DQo+ID4gLS0tDQo+ID4gQEAgLTI3LDcgKzI3LDggQEAgZW51bSB7DQo+
ID4gIAlST0hNX0RWU19MRVZFTF9JRExFLA0KPiA+ICAJUk9ITV9EVlNfTEVWRUxfU1VTUEVORCwN
Cj4gPiAgCVJPSE1fRFZTX0xFVkVMX0xQU1IsDQo+ID4gLQlST0hNX0RWU19MRVZFTF9NQVggPSBS
T0hNX0RWU19MRVZFTF9MUFNSLA0KPiA+ICsJUk9ITV9EVlNfTEVWRUxfU05WUywNCj4gPiArCVJP
SE1fRFZTX0xFVkVMX01BWCA9IFJPSE1fRFZTX0xFVkVMX1NOVlMsDQo+ID4gIH07DQo+IA0KPiBE
b2VzIHRoaXMgYWN0dWFsbHkgd29yaz8NCj4gDQo+IFRoZSBjb2RlIHRoYXQgY29uc3VtZXMgaXQg
bG9va3MgbGlrZToNCj4gDQo+ICAgICBmb3IgKGkgPSAwOyBpIDwgUk9ITV9EVlNfTEVWRUxfTUFY
ICYmICFyZXQ7IGkrKykNCj4gDQo+IFNvIGl0IHdpbGwgbG9vcCB0aHJvdWdoIGxpa2U6DQo+IA0K
PiAwIChST0hNX0RWU19MRVZFTF9JRExFKQ0KPiAxIChST0hNX0RWU19MRVZFTF9TVVNQRU5EKQ0K
PiAyIChST0hNX0RWU19MRVZFTF9MUFNSKQ0KPiAzIChST0hNX0RWU19MRVZFTF9TTlZTKQ0KPiAN
Cj4gVGhlbiBicmVhaywgc2luY2UgJ2knIHdpbGwgYmUgKD09IDQpIG5vdCAoPCA0KS4NCj4gDQo+
IFNvIHRoZSBmb2xsb3dpbmcgd2lsbCBuZXZlciBiZSB1c2VkOg0KPiANCj4gNCAoUk9ITV9EVlNf
TEVWRUxfTUFYID0gUk9ITV9EVlNfTEVWRUxfU05WUykNCj4gDQo+IFVubGVzcyBJJ20gbWlzc2lu
ZyBzb21ldGhpbmcsIEkgdGhpbmsgTUFYIHNob3VsZCBiZSB0aGUgbGFzdCBlbnRyeS4NCg0KR29v
ZCBjYXRjaC4gSSB0aGluayB5b3UgYXJlIGNvcnJlY3QuIEkgd2lsbCByZXZpc2UgdGhpcyBmb3Ig
bmV4dA0KdmVyc2lvbiAoYW5kIGFkZCBhbHNvIGZpeGVzIHRhZyBhcyBpdCBzZWVtcyB0aGUgY3Vy
cmVudCBjb2RlIGlzIGJyb2tlbg0KZm9yIExQU1IpLg0KDQo+IA0KPiA+ICAvKioNCj4gPiBAQCAt
NjYsNiArNjcsOSBAQCBzdHJ1Y3Qgcm9obV9kdnNfY29uZmlnIHsNCj4gPiAgCXVuc2lnbmVkIGlu
dCBscHNyX3JlZzsNCj4gPiAgCXVuc2lnbmVkIGludCBscHNyX21hc2s7DQo+ID4gIAl1bnNpZ25l
ZCBpbnQgbHBzcl9vbl9tYXNrOw0KPiA+ICsJdW5zaWduZWQgaW50IHNudnNfcmVnOw0KPiA+ICsJ
dW5zaWduZWQgaW50IHNudnNfbWFzazsNCj4gPiArCXVuc2lnbmVkIGludCBzbnZzX29uX21hc2s7
DQo+ID4gIH07DQo+ID4gIA0KPiA+ICAjaWYgSVNfRU5BQkxFRChDT05GSUdfUkVHVUxBVE9SX1JP
SE0pDQoNCg==
