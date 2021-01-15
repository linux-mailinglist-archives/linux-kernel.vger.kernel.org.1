Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE72F7DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbhAOOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:11:25 -0500
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:46735
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730741AbhAOOLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:11:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd6INRYAitgTjAqeq/QIBnkd9VDPMaVwl7lBFMqv6HNolvu6nSy+pRpLfLzA7o3gtINbNOQ5oAMVgEmavWzYEZo1CwfesxwJ7He9f8ZDtdvTQO413j/7DclHhilVPsxg4Oo3nAlZrwDG1n5AmB6baJm2/QVJk/Bn2KnRHxnjK2BPzZ7k9QTxPqVZkl2dpP4XiJHPeoEyuPreZyezVnvEmpkwAfalmGe8zDboEaNM/4/6VqwQzG98rmke3UBkWjCXPETkB6RWeUoT1yCHvTQLq7tFSAZo7FbNEqYGC7DzzRkkr/fJry4/cT0i8qK3CP3Kp18VnqRkxTlNQ2DDt91JBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22+OJbjkSjrG4EIim7T9v+h7hfnVZ2qWPxOuoU41Xp4=;
 b=izgZ1rwUE/u6LcWHV4fMZHOgCIGbQvbXl2otrlDeqfqQd+oPzvBaK2QrozbxU7DQQ/AgGty981r8R3uwWUwTZExMaKJWooC3XqzkBLDUYlqZqXn823qjrXn2lNcsuMqXa1Z4MM/mKDQnFjPCFAHHq9irQK0yk0eKB0hhLf4F7E8nl7IDnewhxC4arB5fABeUDWvDuMAzXqNy5IWi9i/gsQGAaquDX337fBgRI0KMyFXdRODBWJSXPeUUQZWhWppdKSVnLKPQOLDxSalq5YGNbphBviw5U9UdCXvM1QNlV+SJxoEUtlEBpH59p6uco4Y5UbkrW7FPpvrJ7xHuox3DMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22+OJbjkSjrG4EIim7T9v+h7hfnVZ2qWPxOuoU41Xp4=;
 b=EQnrk9/2GFMJLUQgiRfeg88k18TW4WMQam2sVYH+zJQyI7Tl95RfY5DaRTK0l1f/hIphPadaFjpfhBGVH9tM46l0kGVMsUJ7VoXRmOwfu1PiR2V7X4STFYJBXmeYJBt064FerlQatcrBlDVpekxDMTpj/vKEJ6fruB8V8pO7SQ0=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2395.eurprd03.prod.outlook.com (2603:10a6:3:6d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 15 Jan 2021 14:10:35 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3%3]) with mapi id 15.20.3742.013; Fri, 15 Jan 2021
 14:10:35 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Thread-Topic: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Thread-Index: AQHW6z/YDFGjg11i50CIpjP09bUH1Koos1aAgAAGiwA=
Date:   Fri, 15 Jan 2021 14:10:34 +0000
Message-ID: <83dfb3b1672512b00ae28cbeeb16a9946f61da74.camel@fi.rohmeurope.com>
References: <20210115131040.GA633776@localhost.localdomain>
         <20210115134709.GM3975472@dell>
In-Reply-To: <20210115134709.GM3975472@dell>
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
x-ms-office365-filtering-correlation-id: b4a5ae82-2815-41aa-8926-08d8b95f53c5
x-ms-traffictypediagnostic: HE1PR0301MB2395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB239529D1A010F905DE5F5CA8ADA70@HE1PR0301MB2395.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgC1E+MzFrCXbXH/M3w8BJhBudOd7zhjHfTnpSe+gg6/4cOQV9FiS5a4fhhDTXKXb4wqZwPrrmAH+rSe8Czj1CyDWYhEKnOpMcE1+aUPYbkGXZ9r9oTkNs20Ov+H5d/LmTD+L5KrWChjurr6rLrZh0LqyRQn2OLB8J7obmK2IBnyiPT0HLhVg3iIXu9qg6cEd7OruCLJh6u3cyW6peZUxksg6LId3NdgjltpB42RCfPoXlNQAqPnHIgRBEiNCqckhp7PF7Emt6IeWrua5qcU746yyYekgw7M41yJcHv4aiarayMoyPxpplzerhi9pK6WnEEpHqdP9FVxNRA2Q3jw892dGrI2HW7JUhtBZYMrpfLIrVjeD/AqLROYQthqOnlN3OBtbmm2WUdAbREiqca+Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(71200400001)(316002)(2616005)(8936002)(2906002)(66446008)(8676002)(6506007)(54906003)(64756008)(5660300002)(478600001)(4326008)(186003)(6916009)(26005)(3450700001)(6486002)(66476007)(6512007)(83380400001)(66946007)(66556008)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZXpmc2g5a2tlT0psa1RJTGJhRlJweUYxbWM2NksxMW5CckpXUmVxWlYranJp?=
 =?utf-8?B?c0dFdlJscFNOUVUvdTZ3VEJpS2Rsa2JoaWJvdW1QL1d6Z2VpTEprcGNKbWNa?=
 =?utf-8?B?TGJieDFhbkpnYmJOaDVZb0JGeGN0cGIyc200ZWwrUloveDhNUzJma3djRjNN?=
 =?utf-8?B?ME90b2FNb0ZYMjRFWUF0bWxWMlZkQXMyWG94WnJLU0k2WVBxazF1QXdBR01h?=
 =?utf-8?B?bmdPeFZQUkVOZ1VXYUdXVnM4OE53cHRGVDNWKzVnZ09OWFc3bG5NdkQxRGd4?=
 =?utf-8?B?YnhkajhEYjhjVU5kRGYxcGNkUGlYNE0zUFZoTnB6aVhMTUtsbkpVSFJZNWJ5?=
 =?utf-8?B?WlRLeVpYbDhEYjFHMlhsWWdzeVJ5a2MxT1RCSVVQYjJnUEM4eUlwOVB0dmdI?=
 =?utf-8?B?L3RFcXl0S3Y2b2lFVFRLTy9JaUZhcmJOaUFZSFVkWkpwM3FIOHhoYzVxWFZp?=
 =?utf-8?B?WEl3cFAzQ0VaQ3B0Tm0vNUduaXMzNmpnMERrQUcyc0VUbGt1THJpUzlsN2J4?=
 =?utf-8?B?dElFOHJPWlNBSThqaDA4K20yZmRvd21PTXhRc3lFc1cvQ3Y0MUZ6TEdhNjJl?=
 =?utf-8?B?YXVsVVAzditpVVFOWmJXR2ZtYVN5eG5CYjR6dkViNmpBekVuRW1LdHdWQXV3?=
 =?utf-8?B?Y2VPaHlVWkJ4eXA0Y3Q5RkxmNDJJclFSS1RZNjk2RVNPdW95TW5iZHVaVTQv?=
 =?utf-8?B?YWhXVnVDVjQrd01XV2JqaUV6eVBQWHBCMFlxM21aMmlkcTh6bnlTQ0FqSUMr?=
 =?utf-8?B?WXRQVVhQc1lyMG9HU1dRbkM1S1FvcEQwSFJoY25sdURmTSs5cThublBJbDZ4?=
 =?utf-8?B?N0J3RFFZbDZXOTFOQ2JCWGhVTXk1ZW1pMUlUM3BMVEMvZllrenhGSkp2Smdu?=
 =?utf-8?B?SDRIZWZ1aG5PK1UrejZOQkdLaklFMUt3QkY3U0FRSTlvait1dEloK0FDVUlT?=
 =?utf-8?B?RXpYcldubnhSemJZbjI0R2dtZ1ZDZ05LOXRsMy9ub2djcGQzd3h4ejJja1NB?=
 =?utf-8?B?UnZjTTZxakZjV3IvM0M5cHYzbmJ1dDM5WHE0Um4vUW54MitHcHc2MDNoWGRV?=
 =?utf-8?B?bisvamV1eURUMFVkM25tS3dSUGJkL3NVM0dpMmg0YUNTTmVWcldXQ2hLVS9a?=
 =?utf-8?B?TklhUmxzMXBnNkZBVkJmMDlDN1Rhd1ZKajFsOHp2dFlUVjlHWlBLRlN2bVJi?=
 =?utf-8?B?VmRwU3QwWGNhNlpxZWRuUGIrcEN0SmVBbXFhWG0zdTBaQmYxWDY2bFhLTWVQ?=
 =?utf-8?B?T1RjbVA5Z2U3cytxNlFPUDFpdFNkNzNoMGlVVHlQdnpKUUdsL2lUenBGUXRX?=
 =?utf-8?Q?cpyuj6iSf1g/kFMGJj9aF8HhcuD53TGYlV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BBA2FFD3EB7D449B2E61BE1EDA2EDE3@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a5ae82-2815-41aa-8926-08d8b95f53c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 14:10:35.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRVWfHPEq5CYH8YniLc77SW7layDMiPsWt4snoCgGO7rZuTFRfXcct8wGopHAgACg8jYOzMBiHBOf0xczFUz1fLac/EmCdEQMP8EQl9GqbkzSeNg3p46NGND3R/Zbetc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2395
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjEtMDEtMTUgYXQgMTM6NDcgKzAwMDAsIExlZSBKb25lcyB3cm90ZToNCj4g
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
aS5yb2htZXVyb3BlLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZWd1bGF0b3Ivcm9obS1y
ZWd1bGF0b3IuYyB8ICA4ICsrKystLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvbWZkL3JvaG0tZ2Vu
ZXJpYy5oICAgfCAyMiArKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcmVndWxhdG9yL3JvaG0tcmVndWxhdG9yLmMNCj4gPiBiL2RyaXZlcnMvcmVn
dWxhdG9yL3JvaG0tcmVndWxhdG9yLmMNCj4gPiBpbmRleCAzOTkwMDIzODNiMjguLjk2Y2FhZTdk
YmVmNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9yb2htLXJlZ3VsYXRvci5j
DQo+ID4gKysrIGIvZHJpdmVycy9yZWd1bGF0b3Ivcm9obS1yZWd1bGF0b3IuYw0KPiA+IEBAIC01
NSwyNSArNTUsMjUgQEAgaW50IHJvaG1fcmVndWxhdG9yX3NldF9kdnNfbGV2ZWxzKGNvbnN0IHN0
cnVjdA0KPiA+IHJvaG1fZHZzX2NvbmZpZyAqZHZzLA0KPiA+ICAJZm9yIChpID0gMDsgaSA8IFJP
SE1fRFZTX0xFVkVMX01BWCAmJiAhcmV0OyBpKyspIHsNCj4gPiAgCQlpZiAoZHZzLT5sZXZlbF9t
YXAgJiAoMSA8PCBpKSkgew0KPiA+ICAJCQlzd2l0Y2ggKGkgKyAxKSB7DQo+ID4gLQkJCWNhc2Ug
Uk9ITV9EVlNfTEVWRUxfUlVOOg0KPiA+ICsJCQljYXNlIF9ST0hNX0RWU19MRVZFTF9SVU46DQo+
ID4gIAkJCQlwcm9wID0gInJvaG0sZHZzLXJ1bi12b2x0YWdlIjsNCj4gPiAgCQkJCXJlZyA9IGR2
cy0+cnVuX3JlZzsNCj4gPiAgCQkJCW1hc2sgPSBkdnMtPnJ1bl9tYXNrOw0KPiA+ICAJCQkJb21h
c2sgPSBkdnMtPnJ1bl9vbl9tYXNrOw0KPiA+ICAJCQkJYnJlYWs7DQo+ID4gLQkJCWNhc2UgUk9I
TV9EVlNfTEVWRUxfSURMRToNCj4gPiArCQkJY2FzZSBfUk9ITV9EVlNfTEVWRUxfSURMRToNCj4g
PiAgCQkJCXByb3AgPSAicm9obSxkdnMtaWRsZS12b2x0YWdlIjsNCj4gPiAgCQkJCXJlZyA9IGR2
cy0+aWRsZV9yZWc7DQo+ID4gIAkJCQltYXNrID0gZHZzLT5pZGxlX21hc2s7DQo+ID4gIAkJCQlv
bWFzayA9IGR2cy0+aWRsZV9vbl9tYXNrOw0KPiA+ICAJCQkJYnJlYWs7DQo+ID4gLQkJCWNhc2Ug
Uk9ITV9EVlNfTEVWRUxfU1VTUEVORDoNCj4gPiArCQkJY2FzZSBfUk9ITV9EVlNfTEVWRUxfU1VT
UEVORDoNCj4gPiAgCQkJCXByb3AgPSAicm9obSxkdnMtc3VzcGVuZC12b2x0YWdlIjsNCj4gPiAg
CQkJCXJlZyA9IGR2cy0+c3VzcGVuZF9yZWc7DQo+ID4gIAkJCQltYXNrID0gZHZzLT5zdXNwZW5k
X21hc2s7DQo+ID4gIAkJCQlvbWFzayA9IGR2cy0+c3VzcGVuZF9vbl9tYXNrOw0KPiA+ICAJCQkJ
YnJlYWs7DQo+ID4gLQkJCWNhc2UgUk9ITV9EVlNfTEVWRUxfTFBTUjoNCj4gPiArCQkJY2FzZSBf
Uk9ITV9EVlNfTEVWRUxfTFBTUjoNCj4gPiAgCQkJCXByb3AgPSAicm9obSxkdnMtbHBzci12b2x0
YWdlIjsNCj4gPiAgCQkJCXJlZyA9IGR2cy0+bHBzcl9yZWc7DQo+ID4gIAkJCQltYXNrID0gZHZz
LT5scHNyX21hc2s7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWZkL3JvaG0tZ2Vu
ZXJpYy5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4L21mZC9yb2htLWdlbmVyaWMuaA0KPiA+IGluZGV4
IDQyODNiNWIzM2UwNC4uYTU1Nzk4ODgzMWQ3IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvbWZkL3JvaG0tZ2VuZXJpYy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvcm9obS1n
ZW5lcmljLmgNCj4gPiBAQCAtMjAsMTUgKzIwLDI1IEBAIHN0cnVjdCByb2htX3JlZ21hcF9kZXYg
ew0KPiA+ICAJc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiArLyoN
Cj4gPiArICogRG8gbm90IHVzZSB0aGVzZSBpbiBJQyBzcGVjaWZpYyBkcml2ZXIgLSB0aGUgYml0
IG1hcCBzaG91bGQgYmUNCj4gPiBjcmVhdGVkIHVzaW5nDQo+ID4gKyAqIGRlZmluZXMgd2l0aG91
dCB0aGUgdW5kZXJzY29yZS4gVGhlc2Ugc2hvdWxkIGJlIHVzZWQgb25seSBpbg0KPiA+IHJvaG0t
cmVndWxhdG9yLmMNCj4gPiArICovDQo+ID4gIGVudW0gew0KPiA+IC0JUk9ITV9EVlNfTEVWRUxf
VU5LTk9XTiwNCj4gPiAtCVJPSE1fRFZTX0xFVkVMX1JVTiwNCj4gPiAtCVJPSE1fRFZTX0xFVkVM
X0lETEUsDQo+ID4gLQlST0hNX0RWU19MRVZFTF9TVVNQRU5ELA0KPiA+IC0JUk9ITV9EVlNfTEVW
RUxfTFBTUiwNCj4gPiAtCVJPSE1fRFZTX0xFVkVMX01BWCA9IFJPSE1fRFZTX0xFVkVMX0xQU1Is
DQo+ID4gKwlfUk9ITV9EVlNfTEVWRUxfVU5LTk9XTiwNCj4gPiArCV9ST0hNX0RWU19MRVZFTF9S
VU4sDQo+ID4gKwlfUk9ITV9EVlNfTEVWRUxfSURMRSwNCj4gPiArCV9ST0hNX0RWU19MRVZFTF9T
VVNQRU5ELA0KPiA+ICsJX1JPSE1fRFZTX0xFVkVMX0xQU1IsDQo+ID4gKwlST0hNX0RWU19MRVZF
TF9NQVggPSBfUk9ITV9EVlNfTEVWRUxfTFBTUiwNCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCBo
b3cgdGhpcyBpcyBzdGlsbCBub3QgYnJva2VuLg0KPiANCj4gSSB0aGluayB5b3UgZWl0aGVyIG5l
ZWQgdG8gY2hhbmdlIHRoZSBmb3IoKSBsb29wIHRoYXQgY29uc3VtZXMgdGhpcw0KPiB0bw0KPiB1
c2UgIjw9IiBvciBwdXNoIHRoZSBNQVggZW51bSB0byB0aGUgbGFzdCBsaW5lIChvbiBpdHMgb3du
KS4NCj4gDQo+IFRoZSBsYXR0ZXIgd291bGQgYmUgbXkgcGVyc29uYWwgcHJlZmVyZW5jZS4NCg0K
QmFoLiBPY2Nhc2lvbmFsbHkgZ2V0dGluZyBpdCByaWdodCBpcyBqdXN0IGhhcmQuIFRoZSBmb3Ig
bG9vcCBjb25kaXRpb24NCmlzIGFsbHJpZ2h0IG5vdyBhcyBpdCBkb2VzIGFzIGl0IHdhcyBvcmln
aW5hbGx5IGludGVuZGVkIGFuZCBzY2FucyB0aGUNCmFtb3VudCBvZiB2YWxpZCB2YWx1ZXMuIFN0
YXJ0aW5nIGF0IDAsIHVzaW5nIGNvbmRpdGlvbiBpIDwNClJPSE1fRFZTX0xFVkVMX01BWCBndWFy
YW50ZWVzIHdlIHByb2Nlc3MgYWxsIHZhbGlkIHZhbHVlcyBfa25vd2luZ18NCnRoYXQgdmFsdWUg
MCBpcyAnaW52YWxpZCcuDQoNCkJ1dCBub3cgSSBtYWRlIGEgbmV3IGVycm9yIGluIGZvbGxvd2lu
ZyBpZi1jb25kaXRpb24uIEkgZGlkbid0IHRha2UNCmludG8gYWNjb3VudCB0aGUgZmFjdCB0aGF0
IGxlZnQtc2lmdGluZyB0aGUgMSBieSBfUk9ITV9EVlNfTEVWRUxfUlVODQpmb3IgZmlyc3QgdmFs
aWQgdmFsdWUgKFJPSE1fRFZTX0xFVkVMX1JVTikgbWFrZXMgdGhlIGZpcnN0IHZhbGlkDQpiaXRt
YXNrIHRvIGJlIDIgbm90IDEuIFNvIHRoZSBpZi1jb25kaXRpb24NCg0KaWYgKGR2cy0+bGV2ZWxf
bWFwICYgKDEgPDwgaSkpDQoNCmZvbGxvd2luZyB0aGUgZm9yIGxvb3AgaXMgbm93IGJyb2tlbi4g
SXQgd291bGQgcHJvYmFibHkgd29yayBpZiBpdCB3YXMNCjIgPDwgaS4gQW55d2F5cyAtIHdlJ3Jl
IG5vdyB3YXN0aW5nIG9uZSBiaXQgb3V0IG9mIDMyIGZvciBpbnZhbGlkIG1hc2suDQoNCkkgdGhp
bmsgeW91J3JlIGNvcnJlY3QgdGhvdWdoLiBJdCBuZWVkcyBhIGNoYW5nZS4gVGhpcyBpcyBxdWl0
ZSBnb29kDQppbmRpY2F0aW9uIHRoYXQgdGhpcyBsb29wL2NoZWNrIGlzIG92ZXJseSBjb21wbGV4
IDopIFNvIHBsZWFzZSBmb3JnZXQNCnRoaXMgcGF0Y2ggLSBJIHdpbGwgZG8gYmV0dGVyIGF0IG5l
eHQgd2VlayB3aGVuIEkgZ2V0IHRvIHRoZSBvZmZpY2UgYW5kDQpjYW4gYWxzbyB0ZXN0IHRoaXMg
d2l0aCBhIGJyZWFrLW91dCBib2FyZC4gDQoNClNvcnJ5IGZvciB3YXN0aW5nIHRoZSB0aW1lIGFu
ZCB0aGFua3MgZm9yIHRoZSByZXZpZXcgYWdhaW4uDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZh
aXR0aW5lbg0KDQo=
