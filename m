Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899A32DF924
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 07:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgLUGJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 01:09:07 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:29313
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727517AbgLUGJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 01:09:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgEO2HCZlLGiPZG/YD3VHaGnKCYezHghlwu4ZeuYvhlQmzaNCiugEv3n9opoedYg2qQGpu8/zZH674MhMNl3g0xkic2CG2miRIBSxVoTGRa+mGIgXVSFdyDIh+Bnywh1LGpFUatY7YbsZk9siHfuMAsdbXp6/HBlD7BPxOE/hh/dwROJymgJFh58ZsJbxUzfb4JEuHU7KgM+LeHk2ne2y2VwSeXv6MEObp9Axh8mEW/b2fzsdOJFUpvc8cbyp2I2HlymfM/XhEFVWZh9eiC8pYvvyXtgYPL1XSQCZDupfxQ9wFEHf3jCcbq6j1yK2GhwDtUjFiilklxvj4tVMb2+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t1MAX3/57X7C3kLknKbnvezs0AUL1tgADfdC3a53ws=;
 b=D+zZ/H2kDRf6DCBxY78ypTGJAg0MzbYkg9X1aYGroqgWcvd7B7tLx+94npcAoNTNghXYL8zWdwuhdpKhhiRsUM0bCM/D5Sg2PIRazUQQYLEKrbIx4xG4oNVbpLZGQ2zKHhip23ZXKoCZhP66LpJkVZh3i0FlhRr9uWUGXwb+BT4hRY0O4KrkDgSo4t2VJam/2KxwpZSl5iVg8gUO61W+VzlopfUfa8xr2fatRgJUBHCmQ3xMCRmcXteehjGfSLwCD60yEeiy54MI+8l/ZB61qwqSagifTc9x1VW8RN/FMChYMX+ZfDDYOyBIm1GGowwvVQfAaBomfcr7bFifTXUEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t1MAX3/57X7C3kLknKbnvezs0AUL1tgADfdC3a53ws=;
 b=sA5lu7CA9lVhtf02M7TzCGW6mlViyX1oARk7BDiAJuGg0DvtLvlc+EmMLRuD1PUgX5y0uZ8gEzTTNR9Y9Bnk0CE26sGm0GMrAQUchFspaNbAT1TN+dPJtP3F2xEjPI2gTI42bySHW/NuVl1IWM4DqsNumTZGpUvC1Tc3Mx/lkmc=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2812.eurprd03.prod.outlook.com (2603:10a6:3:f6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.29; Mon, 21 Dec 2020 06:08:15 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87%7]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 06:08:15 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>
Subject: Re: [PATCH v2] regulators: bd718x7: Add enable times
Thread-Topic: [PATCH v2] regulators: bd718x7: Add enable times
Thread-Index: AQHW1WzxkVLUUep6gEioRpxLDc8nrKoBFHQA
Date:   Mon, 21 Dec 2020 06:08:15 +0000
Message-ID: <7c8457166ec3a69d7999f751fef54413c5c2ed5f.camel@fi.rohmeurope.com>
References: <41fb2ed19f584f138336344e2297ae7301f72b75.1608316658.git.agx@sigxcpu.org>
In-Reply-To: <41fb2ed19f584f138336344e2297ae7301f72b75.1608316658.git.agx@sigxcpu.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8379d40e-e3e8-4f24-6e33-08d8a576ce2b
x-ms-traffictypediagnostic: HE1PR0302MB2812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0302MB2812FAC74D9C3FDB4870BEF3ADC00@HE1PR0302MB2812.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ulTbZwzTMZfUTKtpjiUzx6jS+MHosnStoI2LuQduVLsnli129JDsIF6YKYmrPakQUtrG5iYpa0VPou2fG96h+PeIiXHbk0bE2a7T6eDslh6osXQ/aNhhfPVsFT67f3t7rUrDpkhmW9S7KXMRdPkakilzUVMBdrAaMt+WPzL9z7s92oIWk5moPKsL680J3HWr8ZTCK7yf51TNz9KrenWl8cKH+1RAhXPj6VvSMmWzF5mNEvZOahsanfVx5rW/Kthvs4skSHvE20aD0L/b5mK9uxCZUNXnIDctiF4Xz2iXCIp+f1z/mK607T4zSaPiJ1BfnyEFt2FzVnL4Xti2w1tmtn0ppb2Ak7Ad+5kCj+VVIyYXyXNZ/p69migUXen6Yo3ygITB/N+dcBThQC4qhdhCq3IhIbUpeOkSm823qGxNjfrqGi5M7naFLfA5cGOKo3rOh3pPKznrGkOTjA4Ukfp2gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(966005)(8936002)(6506007)(26005)(478600001)(110136005)(86362001)(186003)(3450700001)(4001150100001)(71200400001)(316002)(6512007)(66476007)(66556008)(64756008)(8676002)(66946007)(2616005)(2906002)(5660300002)(83380400001)(76116006)(66446008)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SFA1Qk8xaUtXTUJiYk8wRVF3K3NHNlAwMjNabjk1eXF3M1pNcHBvZUdQNmFC?=
 =?utf-8?B?Y0hlYmUwZnhzTzNvY2ZvekNUbFprb1djcGNWcEpKSFBNd1B4R09RVTlCZ1ZL?=
 =?utf-8?B?Z0wrRS84RXRJd1laM3BiSlgweG1PRHk3SEV3bVh4UXhiSnVtOHBDYks5R1By?=
 =?utf-8?B?dFJ0a29zNXFWTkhZMVpGMXkzTGRhbTEyajN2WXNiZGJ6czNRd1k0VjVCaG85?=
 =?utf-8?B?aXB3OUh5dEdqdmY4Unc1MkhLbExBR3docEZrd1BqOVdWKzVrZ2VhN2ZQckcv?=
 =?utf-8?B?K1d5OWFyejJoZTFnUmt0Q1VEQWxzVEQxVStKazhPbXN0YTJDaFBEakhPTCsv?=
 =?utf-8?B?L3ZIS29odCszNlhKdkNBcWR1RmhyMWgvUFBlMzh6OGxLbTJnZUJKT2x3N1JQ?=
 =?utf-8?B?R2xTVnEvOTVXRW5abWtNdkVsUGhPdTlaTitJUDRVcXc5bitGbmk0TzZydERu?=
 =?utf-8?B?WWFkQ3FTSnFyVHdSbTdlSHZoL0U4d3cvWVZRWmMvZlBqOUdGcDVJeGM5cWpZ?=
 =?utf-8?B?OGE2cWZ4ZDJnT2ZyelR0Y3F2eGRwK2NQQzRUNGpmVmJmUlRaSDZYdk5WY25E?=
 =?utf-8?B?YWluRDdobnJFOFdhUFlJbVZtSFp4MlowOTVlbWNQYnBNaDF1d0NsMUJDUlZv?=
 =?utf-8?B?R1p2b1pwMVZ2N2dFNUV4RDJYVkdxR3AyOGF5Mm9ZV0Q2blpqSnRZTnZVZnRV?=
 =?utf-8?B?VEprWUpYZy9QSFRGOUxDdU0zQ2g2RDlIbjJ0OTVpVjAxQUh4S0cvc0daME8x?=
 =?utf-8?B?RStrR1ZXR3JmUENGQlJZN2JyT3o3NXo0SElpbDhEWmg0Qjg5ZnZoUjNmbjhJ?=
 =?utf-8?B?M2szb0RxWWN1OTQ4ejNkU0N1U0I2Wm5jWXlaeHVYS0p6YlZvRVQ2Z2RDLzh2?=
 =?utf-8?B?WTlCeXozVWJaTFVheDE0cm5TdnJ3WnBoMWJpc2xuUDRaelZwS21UNGZNZE5I?=
 =?utf-8?B?RC9GZ0M2cnVaY3M1eWNzM2xqdDExNEdYaUN3aHhsWFh2aHdRRFpNeUpaQjlV?=
 =?utf-8?B?alNvRVVKRnRaYTNmNlhyT0dPaDVYN1dMSXQ3RVlWTk0ybFVJT096dWJBNnFv?=
 =?utf-8?B?c0cwRjVsM2dnSUJqNmRNeVBGYkhCbDJVbFhHNytkME1kR1haRnV4RGJVTUZP?=
 =?utf-8?B?ODB2NHc1MGhkdXZ6ZEY1UGU2K3ZwRDY2emtKOVcrejhlRWZkUlJNS3A1N1JT?=
 =?utf-8?B?UEhWNFVUaVNhQUhjem5OWmZVM1k1MWZlaFFwSW56V1Bad1VPZGplTnZ6Ykht?=
 =?utf-8?B?RHhtc0tGNzdjRDNmNSsrRGJpM0NJYnByTTN6YjNOMkxuNWdVT2c3NkRoeTBR?=
 =?utf-8?Q?hNTKtZYn8qU3GnXEUNtKLlgdjt61sCHIkr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38453FC3834EA24F8022FB1653E05D11@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8379d40e-e3e8-4f24-6e33-08d8a576ce2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 06:08:15.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Et8xVZ9BrhI0qgNiCwKnnfPFInltiMASHDRkjLjTQGgMMHVVNJOva17hM2K5LKd9JIFGA4NU5i8cWkSdazS7agq0nsF5O79rAuIfvcOwR0TgDANtAbRK8Bv6vQxBb2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMTItMTggYXQgMTk6MzggKzAxMDAsIEd1aWRvIEfDvG50aGVyIHdyb3Rl
Og0KPiBVc2UgdGhlIHR5cGljYWwgc3RhcnR1cCB0aW1lcyBmcm9tIHRoZSBkYXRhIHNoZWV0IHNv
IGJvYXJkcyBnZXQgYQ0KPiByZWFzb25hYmxlIGRlZmF1bHQuIE5vdCBzZXR0aW5nIGFueSBlbmFi
bGUgdGltZSBjYW4gbGVhZCB0byBib2FyZA0KPiBoYW5ncw0KPiB3aGVuIGUuZy4gY2xvY2tzIGFy
ZSBlbmFibGVkIHRvbyBzb29uIGFmdGVyd2FyZHMuDQo+IA0KPiBUaGlzIGZpeGVzIGdwdSBwb3dl
ciBkb21haW4gcmVzdW1lIG9uIHRoZSBMaWJyZW0gNS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1
aWRvIEfDvG50aGVyIDxhZ3hAc2lneGNwdS5vcmc+DQo+IA0KPiAtLS0NCj4gdjINCj4gLSBBcyBw
ZXIgcmV2aWV3IGNvbW1lbnQgYnkgTWF0dGkgVmFpdHRpbmVuDQo+ICAgDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvYmViYTI1ZTg1ZGIyMDY0OWFhMDQwZmMwYWU1NDk4OTVjOTI2NWY2
Zi5jYW1lbEBmaS5yb2htZXVyb3BlLmNvbS8NCj4gICBVc2UgZGVmaW5lcyBpbnN0ZWFkIG9mIHBs
YWluIHZhbHVlcw0KPiAtIEFzIHBlciByZXZpZXcgY29tbWVudCBieSBNYXJrIEJyb3duDQo+ICAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMTIxNjEzMDYzNy5HQzQ4NjFAc2lyZW5h
Lm9yZy51ay8NCj4gICBEcm9wIGNvdmVyIGxldHRlcg0KPiAtLS0NCj4gIGRyaXZlcnMvcmVndWxh
dG9yL2JkNzE4eDctcmVndWxhdG9yLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IGluY2x1ZGUvbGludXgvbWZkL3JvaG0tYmQ3MTh4Ny5oICAgICAgfCAzMCANCg0KVGhhbmtzIGFn
YWluIEd1aWRvLg0KSSBtaWdodCBoYXZlIHByZWZlcnJlZCBoYXZpbmcgdGhlIGRlZmluZXMgaW4g
YmQ3MTh4Ny1yZWd1bGF0b3IuYyBhcw0KdGhleSBhcmUgbm90IGxpa2VseSB0byBiZSB1c2VkIG91
dHNpZGUgdGhpcyBmaWxlLiBUaGF0IHdvdWxkIGhhdmUNCnN0cmljdGx5IGxpbWl0ZWQgdGhlIGNo
YW5nZSB0byByZWd1bGF0b3Igc3Vic3lzdGVtLiBIYXZpbmcgdGhlbSBpbiB0aGUNCmhlYWRlciBp
cyBzdGlsbCBmaW5lIHdpdGggbWUgaWYgaXQgd29ya3MgZm9yIE1hcmsgJiBvdGhlcnMuIChJIGRv
bid0DQp0aGluayB0aGVzZSBkZWZpbmVzIG5lZWQgbXVjaCBvZiBjaGFuZ2VzIGluIHRoZSBmdXR1
cmUpLg0KDQpSZXZpZXdlZC1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmku
cm9obWV1cm9wZS5jb20+DQoNCg0KQmVzdCBSZWdhcmRzDQogTWF0dGkgVmFpdHRpbmVuDQoNCg==
