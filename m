Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC92DC056
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLPMaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:30:10 -0500
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:20800
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgLPMaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:30:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io2824ahh/Qewl5U/M3koUnI8+a0LQanPb4TI3moxRjB32zEG6h4Rv+JfQc6xhx7qWac1XHDC9nUPpiVaZpyRnO+cQ5rxMe+/Bm/HMrHeVmFz/dpXgeO8MkuO5M3Lukel9S5zFKARtKRUh5AheVKOVGzPkZrereWuHB89y/1r0WszGY1yc2DTtBOrzhEe6HFDQ9iNh8cTBJXVS+HOQpKK9ng+7Whcg/dM8w0j0Q1FLqPicGLP0UhjMHJjOI5Kp9yhGLOGzwreeWFBE5FIDQB9IrpXTR4ZtblJuQ+u0/j3fMF8K0h750V2O8Sl9wKjfUZErmXuZI8No8fP23l823IkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L19Gef/QLfo8rrMFoB7XjmJK7/9AQAC13+CVZjUSpG0=;
 b=mbgjAeoP7kRoIzsWhKwuI1BycveBrsZ9YQoKkJ7h/L562WUZJrx6AITAfdDYX4eQCXyOgZZABoz+1tQLNfMlhO0hIKsxfQF7AYEPJBVdphmvtHV+vJ4yhfPVvmsLYq5wcBk0rjqIv1oTYB9XBQiUohJdvUDxCI7YciM5piY2ho6vXL1e1g/NkQcqmEEEOX3gIuY6Jw/R53HZLkUOYFPdYACKgmxjsvRdFU+N6e/yMKgzr615nvU3rLvGc9jqOfqbxl9q1hED9wX2i5NdROgyiAzvvcwGhgfY64yIz3ODvE1CZrLee8SSsyhqGGef5zUiThRUKwKk3kCoDhTQX+Jkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L19Gef/QLfo8rrMFoB7XjmJK7/9AQAC13+CVZjUSpG0=;
 b=pOzRqBLeJXgbiwNYy7aaKWwpmdlsXmqGTKoFSqzlahuUNw4Xfx3ariaIKkcv3QpnYZDzaiZElett/QWF3UkIo4Q6dFdBLYi8Eg5sPpEY3v5WQ8Wdtcw6/LFZ66bdJY2nAzOUujC/S3oDjbrzcrH5axWbGmVq1eZE7bJOXPFjQjU=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2666.eurprd03.prod.outlook.com (2603:10a6:3:ef::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 16 Dec 2020 12:29:20 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 12:29:20 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus.ainslie@puri.sm" <angus.ainslie@puri.sm>
Subject: Re: [PATCH 1/1] regulators: bd718x7: Add enable times
Thread-Topic: [PATCH 1/1] regulators: bd718x7: Add enable times
Thread-Index: AQHW05tyoY0RX9paika1ZtaJVmaczqn5psMA
Date:   Wed, 16 Dec 2020 12:29:20 +0000
Message-ID: <7d4903f67ff81a9a749e75f24af0aea903213c43.camel@fi.rohmeurope.com>
References: <cover.1608116704.git.agx@sigxcpu.org>
         <d2b3d053d28ea0f35e7526b523287358c8fe20c2.1608116704.git.agx@sigxcpu.org>
In-Reply-To: <d2b3d053d28ea0f35e7526b523287358c8fe20c2.1608116704.git.agx@sigxcpu.org>
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
x-ms-office365-filtering-correlation-id: 471e0b2b-a644-48b6-6606-08d8a1be36a8
x-ms-traffictypediagnostic: HE1PR0302MB2666:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0302MB2666A2771D03FD934F7BB9E8ADC50@HE1PR0302MB2666.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjtAftbZhGLkt0tI9P30aJK8vxlXiE++G/09KVormOl0xgxmZzJTq6IPXoxEz+k70yk5k2oidWjkevGrQy/8Eq2RLSB9iB8siiZX5boz9f4utDuk6dJ8Pp9c7uH8BGGRSSKVbUGAIV3Fm4wq8x0CKblyEMKRUp7mMqwiJY9o91Vkp1p1cpsRIQpSuZ0gkcodnrsCSTLNIFg4SJxIldMRQ2sELWLZgy8fzT7sYQTgRk/1ne4+Z34TfX/M3+d0pFyVrglVmeMBergccuN5/NoM3kSd7ai68W5bWz/hmb1brGJq+4tXuYaUp/NtaBkuRCwqOwLqa/o/C11HsqGvpp4+7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(346002)(396003)(376002)(136003)(316002)(66574015)(3450700001)(2906002)(71200400001)(6506007)(6486002)(6512007)(66556008)(66476007)(5660300002)(83380400001)(66446008)(64756008)(66946007)(2616005)(76116006)(4001150100001)(110136005)(186003)(86362001)(26005)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R3pPMndrS0U5ZTRTM2pWcGdjeGc3OGtGUFFXN2N5aTV3ZkU5RFljamZUQm9D?=
 =?utf-8?B?MVdyVlpyYzZJOWlSK3Y1WEVYSFArMCs3ZUI3djd3WWJtV0tFZm1MbmpNQkQz?=
 =?utf-8?B?d2pzZDlDbVdVUVpuc2s3QnNEdVkrTUV1V2hVWENvbTdGc1NZWTBrRGF1Y3Rq?=
 =?utf-8?B?NDZQVkRudy9nVno5YVhFbDRDZmpzcW92dXNReTd2RDEwd2oyWG9XSnBBc2JJ?=
 =?utf-8?B?UjdiT3ZtTmc0S1l0WUxTZTl0d3hkQWpqMW0wZytlakk4U3NwQzFnOVlHNEZW?=
 =?utf-8?B?VTBuU2w4d1R0c1pFcUwwTGd6bGgzbjJCZENqZmJzTlV3dVVpeEFULzBsK3NZ?=
 =?utf-8?B?RitDVk0vQUU1SmlVbCswb2w5NFpFK2tIcGxsOGxkNGFHTlpwSlc3cVRpdWdi?=
 =?utf-8?B?VG5WUUd6UVFYOWVpZ3NXT0xWcDNXbTR6dXlxNzNCeENsNFo3TnFDSVloaE9h?=
 =?utf-8?B?NENyWEt5RjBlV1Vwd1ZNa3RrWjZtR0tkZVlWN0swMGh2VjBKcm96N1JvSnR1?=
 =?utf-8?B?T2lSWjNBSFl0MElNNmZLR2Z3N2Z4VU53STJPN2JFZndLSDFWRjF3dXF5bDB4?=
 =?utf-8?B?N2svbnlWblRYUXJqZ1BQWVovaXRCQmJaRXBwejZ6RndYN0JoRXdZaFBmZFE3?=
 =?utf-8?B?RE12OWJMSXBnNjRUYVB3cUpVRWJxWU9wanlkK3k2clM2S200UElSVlBFd2JD?=
 =?utf-8?B?YzVSNEw0V1hYT09rVTVtSFgrWUdPY0V6MWk3TU80NmFBV3duSEh2eTU0bzJl?=
 =?utf-8?B?QWRGZ09VQnptU2o5WEh0elNCOHBpWXJ1eithbVd2ODlENUJxOTVKSEh5VmZB?=
 =?utf-8?B?TERkOXVROTZqUW5VYlBxZWkxSHFzUklXZ3NVSDNuQjNQajZDeEpua2pVUlVT?=
 =?utf-8?B?UjU3Y1U3bDlEbGNtTHA2Y1BlOE5sSDBJUWlSM3FWSGU3Q1F6M0ZLUVZ2eEkz?=
 =?utf-8?B?ZDJNWmFKVjdQcXhMdFlZV2pyR3hmSUZFVjFxd0tySms5SHVsc09MbW94VkQ4?=
 =?utf-8?B?V1QvU1A2c09sbVNscDlBTDR2WUkvZ0hDRjhoTERHNkpENjI1aTNlRmZqN2tM?=
 =?utf-8?B?SmdKU0FySG93bFJSYXhJWGNnNE54UkRET0N2S2cveHF2VldpWkkvTklMUXRH?=
 =?utf-8?B?c0NDb2daZUlpb3dlbVhhcldyNDB4VDJYZ3FnU0Y3UVZOcWY3NTZYS1E0VkdP?=
 =?utf-8?B?bGxUV3ppSnkwQUNDa001bFIwNGtScFF1VitqMHluVitQdTl4Zzg0SnN3cVVa?=
 =?utf-8?B?YjJ1d2wrMlpLakw0VzNmeTRzNjlKREFpaDkzME1tc1FZaFk3TGk0UEZTZG56?=
 =?utf-8?Q?vvhTXbCW0RJoqwPdvzYxqTl0/IQho/XGmS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88656F2CAFA8D04C89C3199EF27EBC9B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471e0b2b-a644-48b6-6606-08d8a1be36a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 12:29:20.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9SM898CSMaShtLUFKJLnT3GqvFDItDvFIxW5NTz0bkBrO1kMjsGrmZ2rT5RnnfNr7PokXvuySS5mh3l93vxL2ChCUZCLL3hie3KPx42zJp+XFPlovARS2SsZeKMn88r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2666
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR3VpZG8sDQoNClRoYW5rcyBmb3IgbG9va2luZyBhdCB0aGlzIQ0KDQpPbiBXZWQsIDIw
MjAtMTItMTYgYXQgMTI6MDUgKzAxMDAsIEd1aWRvIEfDvG50aGVyIHdyb3RlOg0KPiBVc2UgdGhl
IHR5cGljYWwgc3RhcnR1cCB0aW1lcyBmcm9tIHRoZSBkYXRhIHNoZWV0IHNvIGJvYXJkcyBnZXQg
YQ0KPiByZWFzb25hYmxlIGRlZmF1bHQuIE5vdCBzZXR0aW5nIGFueSBlbmFibGUgdGltZSBjYW4g
bGVhZCB0byBib2FyZA0KPiBoYW5ncw0KPiB3aGVuIGUuZy4gY2xvY2tzIGFyZSBlbmFibGVkIHRv
byBzb29uIGFmdGVyd2FyZHMuDQo+IA0KPiBUaGlzIGZpeGVzIGdwdSBwb3dlciBkb21haW4gcmVz
dW1lIG9uIHRoZSBMaWJyZW0gNS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1aWRvIEfDvG50aGVy
IDxhZ3hAc2lneGNwdS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTh4Ny1y
ZWd1bGF0b3IuYyB8IDI3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jl
Z3VsYXRvci9iZDcxOHg3LXJlZ3VsYXRvci5jDQo+IGIvZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTh4
Ny1yZWd1bGF0b3IuYw0KPiBpbmRleCBlNmQ1ZDk4YzNjZWEuLmQ2ZDM0YWE0ZWUyZSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTh4Ny1yZWd1bGF0b3IuYw0KPiArKysgYi9k
cml2ZXJzL3JlZ3VsYXRvci9iZDcxOHg3LXJlZ3VsYXRvci5jDQo+IEBAIC02MTMsNiArNjEzLDcg
QEAgc3RhdGljIHN0cnVjdCBiZDcxOHh4X3JlZ3VsYXRvcl9kYXRhDQo+IGJkNzE4NDdfcmVndWxh
dG9yc1tdID0gew0KPiAgCQkJLnZzZWxfbWFzayA9IERWU19CVUNLX1JVTl9NQVNLLA0KPiAgCQkJ
LmVuYWJsZV9yZWcgPSBCRDcxOFhYX1JFR19CVUNLMV9DVFJMLA0KPiAgCQkJLmVuYWJsZV9tYXNr
ID0gQkQ3MThYWF9CVUNLX0VOLA0KPiArCQkJLmVuYWJsZV90aW1lID0gMTQ0LA0KDQpXaGVyZSBh
cmUgdGhlc2UgdmFsdWVzIG9idGFpbmVkIGZyb20/IEkgaGF2ZSBhIGZlZWxpbmcgdGhleSBtaWdo
dCBiZQ0KYm9hcmQgLyBsb2FkIHNwZWNpZmljLiBJZiB0aGlzIGlzIHRoZSBjYXNlIC0gY2FuIHRo
ZSAicmVndWxhdG9yLWVuYWJsZS0NCnJhbXAtZGVsYXkiIGZyb20gZGV2aWNlLXRyZWUgYmUgdXNl
ZCBpbnN0ZWFkIHRvIGF2b2lkIGhhcmQtY29kaW5nIGJvYXJkDQpzcGVjaWZpYyB2YWx1ZXMgaW4g
dGhlIGRyaXZlcj8gQWx0aG91Z2gsIHNhbmUgZGVmYXVsdHMgd291bGQgcHJvYmFibHkNCm5vdCBi
ZSBhIGJhZCBpZGVhIC0gaWYgSSByZWFkIGNvZGUgY29ycmVjdGx5IHRoZW4gdGhlIGNvbnN0cmFp
bnMgZnJvbQ0KRFQgY2FuIGJlIHVzZWQgdG8gb3ZlcnJpZGUgdGhlc2UgdmFsdWVzLg0KDQpJJ2Qg
cHJlZmVyIHdlbGwgbmFtZWQgZGVmaW5lcyBvdmVyIHJhdyBudW1lcmljIHZhbHVlcyB0aG91Z2gu
DQoNCkJlc3QgUmVnYXJkcw0KICAgIE1hdHRpIFZhaXR0aW5lbg0KDQoNCg==
