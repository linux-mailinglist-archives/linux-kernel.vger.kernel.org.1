Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C6C2F7E91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAOOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:48:57 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:53633
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbhAOOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:48:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQ7lZdKYJktGWr3va9MGTv7NoxDsBjjQ565bVYpmEkm9H5tczOdpnJFYde6xPni6W7Dc0I2owOJMVuIKPqHJshexW9XTy/cSgXSvMGoEEWuxbVO1gZKOXXeA1KQ0A7I+KRp6/7zWBScUScTTX1io05YxpNwdqi7rBHcFgFi+HF59FgA8ijncKkT6FRBJ0Re0VWNbYc1UecVfWaKpLvy3a2zle4TBGj3cWOj6XMjz8+U+6YjQvMLBsRvZXpoLcmk5YFj1XVFERxrwdHPF26yJmrc8AMA1/v79FRPIqZdSiX5xYwteQUj1BV0UyaVzxyKson/FzLkEltqj1KMm4EEO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVM+DD3jJeLFZr1jV6grDI96o8zh59hup9m+xCaDIwo=;
 b=G0CywMiVolGwK6/fRIze9DTwCILIsHeYFYYtWjK3X1K7TjNezu9Zct0llFj5cr4xKb01HYB93U4CK2MfKA03LQdIRQKNqy5iXkdg2lAJ4pJVtsOOxpapJJB9lTZPc8ZORiH6qQIiklXmtcxf+kCZ9Ugn3t10JicVdMTmb26sjyry6HpZywfDuGYB3aQ3FOTaXkoJ+Gp6WBsn6ElGPKAohESPcSlpNnp3ZhCO4C8VMag5tEfq0zqBJIuunCvkhWmhAC/nwKsz0HpU54AcOABoX3RQpUp0LRmsTALN3Cr92EDNip1xqdkzbHAng9qmPbmCK3AWkcM4eihkTngBBRiMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVM+DD3jJeLFZr1jV6grDI96o8zh59hup9m+xCaDIwo=;
 b=bol0rxeXQOlc8W5LXIDW9CXo1JZJL9XWZLuswHtK456VJvQ+y7OJPLWPf4mv3qA+PHON7DL552PCcNm674TeIEdHrcy6frOGm/U0JYhjjzR89+2ncwtDTj1M0UQZyjCYHiBwbrPRmgTKRvM9R+yACOnp7dW3nwBQ9B7OZ23Ni/k=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2396.eurprd03.prod.outlook.com (2603:10a6:3:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 15 Jan 2021 14:48:06 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3%3]) with mapi id 15.20.3742.013; Fri, 15 Jan 2021
 14:48:06 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Thread-Topic: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Thread-Index: AQHW60tsHpKkoGX1hEWdWdcnMeXcSaoownEAgAAB1gA=
Date:   Fri, 15 Jan 2021 14:48:06 +0000
Message-ID: <0f2b2a84818b7c83ce50ff20833c7c77150690ad.camel@fi.rohmeurope.com>
References: <20210115143332.GA721433@localhost.localdomain>
         <20210115144132.GP3975472@dell>
In-Reply-To: <20210115144132.GP3975472@dell>
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
x-ms-office365-filtering-correlation-id: e01b7294-b463-4d9e-b71a-08d8b96491c7
x-ms-traffictypediagnostic: HE1PR0301MB2396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB2396F1A1AE0743F84925D544ADA70@HE1PR0301MB2396.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02MgtPebuUPdx1GU0Lghnx/9FtbG1wud7nyAkgnh0+CXFXJ8g9oe6Zq+G0X9TfXmuRXQfJ+tetzXKqh6WI5oMQbH8s4LeJzoIB4sTV88BxgHdUT/PCViwBD1t37nthzhr7B3qFOPo9d+Wr5fhRsLWoACLXbTXE9KxYbkABUS1fg+sEEHh5bL5mxrCuMu3Ar5HjEzWbPqD3y1u4UZ5yakawF60xzg6izMYyyQ/NlDDeLjvCO/oTdYwsqVa1yLAN/O7UBfu24md6GjlWUhKf6BdWd5QHj+xKQ4hofpE7JuV5bqAghUbiKiHVY69taB9Moc61jebO+vz4jD97KbVX7H8qjS9CQfJLfA6snK5H68QVX07mHkoY7khGMoxfzVRcnWK6oHSGqfAUtvjmRtiEX8bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39830400003)(366004)(136003)(2906002)(71200400001)(478600001)(6486002)(54906003)(66556008)(3450700001)(66946007)(6506007)(8936002)(6512007)(316002)(8676002)(76116006)(2616005)(64756008)(5660300002)(86362001)(6916009)(26005)(4326008)(66446008)(66476007)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VUxDdDFYUEozMXdYL2Y3MGFhYndTNUEyeStzVStCaTNMd3hvd05oWm1SVWpH?=
 =?utf-8?B?MlJxbXVIT3ZqTlJMZnp0QWg4WUdSRmh0NXFBRnpFUThJQUhiQXFMMXVrZG5n?=
 =?utf-8?B?aHpNK2ZIaXZEY0N6OTQrMllUazJnOVFPOXBYTmVycVdGL2MyaTdyVUt0azRZ?=
 =?utf-8?B?V21jNUZPM3pVWmw5WUx1U3ZrOWhLZFowOGY3OEdYbFhTbTN2b2ZHUUEyNnpZ?=
 =?utf-8?B?Tjh6dmlESjdTdHpMQi9pZkVoQjUxNVVxdDVkQm1URWFpTWNVMnkyWVkvY2Nj?=
 =?utf-8?B?T29WUnNXS0J1Sk02eVpDY2JnS0syaGNUckhzNURvY21Nai9jL3BtRVRBc1Fh?=
 =?utf-8?B?QXRsd0FWbkZ2cWZ4ekIvNlUvQnIvVUgvOHJiV20rQmxXQ05uS1ZGaDlVaUFV?=
 =?utf-8?B?bmUxalU2V0U4eEFqMWtFVnBvTGRVZFhPU0J3Q3JZNW10WGFhd2J3UjdrT3R2?=
 =?utf-8?B?SDdGT21OakZYTHVwcFpZU0d4MjdUZDFQMHRTblZQbGg5UWZnQWZBZEZSUnl0?=
 =?utf-8?B?eTltSDZyR1BWQ1FwVGUxNWljKzJwaEZCZmM3NHV4Q0FWcWVPU0xkVjZRYVpG?=
 =?utf-8?B?NjkrenlBcjJhNWw5RjJDd1VhdzV6K0dib25MeUtTb202cUQ5K1NmTmlOcml0?=
 =?utf-8?B?VUh5b1VHTHlKcmp6T1AxZStSLzU5dXJUNnMrR1c3NDRiL3FRUzBSNDFRNTdZ?=
 =?utf-8?B?Rmt2SklWRXhVQWF0UUVXbXp5REZIOGdET1N2N0JFbXRGRzFUYS9uNHdWUFZs?=
 =?utf-8?B?SVJSSDJwcE1ML2YxeFBWL1M2ZGhjMlJQNVdhd3hHMEtGU1lZNEV1ZkNXR1dk?=
 =?utf-8?B?MC9lbkxnUkhLU3EzNnBHU0VLQmlPQlk4M2tvVjhCZWxGV1paa1BUQXR6L2Ns?=
 =?utf-8?B?TlJjL3dMdzhKUzZYak5aNWhmL092T2Q1aWtVdnVnRGh6K1RUd0E0UWtVT29r?=
 =?utf-8?B?NjRuVDBUSzFYd2llUldDTG50QkJnTzBCWmJhQWlCbkFUd0xNWnlQZ05CSXI2?=
 =?utf-8?B?MS9JNGRKTjdkSTMxOXVncnNBMXhLbE1JN2hFWWZmT2haMTR6cmdwbUd6N1Jh?=
 =?utf-8?B?RE5IVnhqOTdId0w2aVdCRVdDLzBLdk1HSXIwTGErcUcxQWxKWUxtaStaZ2hF?=
 =?utf-8?B?VGN4enN4Y1E2ZHRCMkZGaVBNWVhUSFczVzhCeTU5Z2N0NGpkdVlHVEprTUJR?=
 =?utf-8?B?UnpMNTNQTzBXSi9PQWNtdHZDSllUR3dXZ3l2SytmemVxa0tKdnYwcUEvSFRB?=
 =?utf-8?B?L3pxeE1DU2QzUW1pMVY2UnllVnBlbUd0Q3ZybnVsT0ZXTklTQXBkRTVJZmVw?=
 =?utf-8?Q?zoI0ehGRQCzw9C7lxTmW5i5wze1cnK2qNB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99A8768FF018764F974A62F7FA4925CD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01b7294-b463-4d9e-b71a-08d8b96491c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 14:48:06.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0chDbk+L0m+tooPu3NL4ripYbizhMugLZvehmeiQejOmIQQsdoXkacS50X/QJDKqL3Mh6+oOKjJwUNSNKL852peGo5CE7mqrOEWElBsqVskZNQ5Upv6MqjL1ZtUQ6M8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2396
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjEtMDEtMTUgYXQgMTQ6NDEgKzAwMDAsIExlZSBKb25lcyB3cm90ZToNCj4g
T24gRnJpLCAxNSBKYW4gMjAyMSwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiANCj4gPiBUaGUg
Uk9ITSBCRDcxOHg3IGFuZCBCRDcxODI4IGRyaXZlcnMgc3VwcG9ydCBzZXR0aW5nIEhXIHN0YXRl
DQo+ID4gc3BlY2lmaWMgdm9sdGFnZXMgZnJvbSBkZXZpY2UtdHJlZS4gVGhpcyBpcyB1c2VkIGFs
c28gYnkgdmFyaW91cw0KPiA+IGluLXRyZWUgRFRTIGZpbGVzLg0KPiA+IA0KPiA+IFRoZXNlIGRy
aXZlcnMgZG8gaW5jb3JyZWN0bHkgdHJ5IHRvIGNvbXBvc2UgYml0LW1hcCB1c2luZyBlbnVtDQo+
ID4gdmFsdWVzLiBCeSBhIGNoYW5jZSB0aGlzIHdvcmtzIGZvciBmaXJzdCB0d28gdmFsaWQgbGV2
ZWxzIGhhdmluZw0KPiA+IHZhbHVlcyAxIGFuZCAyIC0gYnV0IHNldHRpbmcgdmFsdWVzIGZvciB0
aGUgcmVzdCBvZiB0aGUgbGV2ZWxzDQo+ID4gZG8gaW5kaWNhdGUgY2FwYmlsaXR5IG9mIHNldHRp
bmcgdmFsdWVzIGZvciBmaXJzdCBsZXZlbHMgYXMNCj4gPiB3ZWxsLiBMdWNraWx5IHRoZSByZWd1
bGF0b3JzIHdoaWNoIHN1cHBvcnQgc2V0dGluIHZhbHVlcyBmb3INCj4gPiBTVVNQRU5EL0xQU1Ig
ZG8gdXN1YWxseSBhbHNvIHN1cHBvcnQgc2V0dGluZyB2YWx1ZXMgZm9yIFJVTg0KPiA+IGFuZCBJ
RExFIHRvbyAtIHRodXMgdGhpcyBoYXMgbm90IGJlZW4gc3VjaCBhIGZhdGFsIGlzc3VlLg0KPiA+
IA0KPiA+IEZpeCB0aGlzIGJ5IGRlZmluaW5nIHRoZSBvbGQgZW51bSB2YWx1ZXMgYXMgYml0cyBh
bmQgdXNpbmcNCj4gPiBuZXcgZW51bSBpbiBwYXJzaW5nIGNvZGUuIFRoaXMgYWxsb3dzIGtlZXBp
bmcgZXhpc3RpbmcgSUMNCj4gPiBzcGVjaWZpYyBkcml2ZXJzIGludGFjdCBhbmQgb25seSBhZGRp
bmcgdGhlIGRlZmluZXMgYW5kDQo+ID4gc2xpZ2h0bHkgY2hhbmdpbmcgdGhlIHJvaG0tcmVndWxh
dG9yLmMNCj4gPiANCj4gPiBGaXhlczogMjFiNzIxNTZlZGU4YiAoInJlZ3VsYXRvcjogYmQ3MTh4
NzogU3BsaXQgZHJpdmVyIHRvIGNvbW1vbg0KPiA+IGFuZCBiZDcxOHg3IHNwZWNpZmljIHBhcnRz
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBm
aS5yb2htZXVyb3BlLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiBPbmUgbW9yZSBhdHRlbXB0IHRv
ZGF5LiBJIGRpZCB0ZXN0IHRoZSBkcml2ZXIgaXMgbm90IGNhdXNpbmcgYQ0KPiA+IGNyYXNoDQo+
ID4gd2hlbiBsb2FkIGJ1dCBubyBmdXJ0aGVyIHRlc3RzIGNvbmNsdWRlZCBhcyBJIGRvbid0IGhh
dmUNCj4gPiBCRDcxODM3LzQ3LzUwDQo+ID4gYXQgaG9tZS4gVGhpcyBsb29rcyBub3cgdHJpdmlh
bCB0aG91Z2ggc28gSSBkZWNpZGVkIHRvIGdpdmUgaXQgYQ0KPiA+IGdvLg0KPiA+IFNvcnJ5IGZv
ciBhbGwgdGhlIHRyb3VibGUgdGhpcyBmYXIgLSBhbmQgYWxzbyBmb3IgdGhlIG1pc3Rha2VzIHRv
DQo+ID4gY29tZS4NCj4gDQo+IFdoeSBkb24ndCB5b3Ugd2FpdCB1bnRpbCBuZXh0IHdlZWsgd2hl
biB5b3UgY2FuIHJ1biB0aGlzIG9uIHJlYWwgaC93DQo+IHdpdGggc29tZSBwcmV0dHkgZGVidWcg
dG8gZW5zdXJlIGl0IGRvZXMgdGhlIHJpZ2h0IHRoaW5nPw0KDQpJIGZpcnN0IHRob3VnaHQgSSB3
b3VsZC4gVGhlbiBJIGRpZG4ndCB3YWl0IGJlY2F1c2UgLSBhcyBJIHNhaWQgLSB0aGlzDQpsb29r
cyBwcmV0dHkgdHJpdmlhbCB0byBtZSBub3cgLSBhbmQgYmVjYXVzZSBJIHRob3VnaHQgaXQgbWln
aHQgZ2V0DQptZXJnZWQgcXVpY2tseS4gSWYgeW91IHNlZSBpdCByaXNreSwgdGhlbiBwbGVhc2Ug
ZG9uJ3QgbWVyZ2UuIEkgd2lsbA0KdGVzdCB0aGlzIG5leHQgd2VlayBhbmQgY2FuIHJlc2VuZCBh
ZnRlciB0aGF0IGlmIG5lY2Vzc2FyeS4NCg0KU29ycnkgZm9yIHRoZSB0cm91YmxlIGFnYWluLg0K
DQpCZXN0IFJlZ2FyZHMNCi0tTWF0dGkNCg==
