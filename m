Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90752E310C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 13:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgL0MT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 07:19:27 -0500
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:16402
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgL0MT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 07:19:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMgu3QSTm/Uc8uXREuarb6nDcWwQsoXPWeN6locdvGii6MSbp8gnQEUUgqCAC2bBlbtULw708GeVbFsl/VRe6I+0bJ/JK+wFktQGhfW08Kh16t9hFsK0PgkfIL8Phug1hGkNBpcnEYBFDOybmKg3C/SsQj0gd50Rsvzi4KsgSjv6cfiF7LuvC8LQbTNsFTInZ+KBOm3F1yh09DkMcC8cB6s7GfHksMF/EPHAHl7YBfzqvGLd2UQBUWdCo6osZMDKAchIgRB97Pg5sAUpF4idAJpriVNk2CHzsDw/+cHFx9cnvqocQ9y3LSG+RbcBAC0v+pk2sokskf3zU5RYpLHt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P70vTScefYtgL2fAJ/vLjg1f8vTGRyR4dwKF+jHkT5g=;
 b=TPf6Xt4VKghW62Eesd7rjbgTeBT4WHLN2t2Jwfhb4X/WBtQFpb6T/ONdngnIsXZNOO76vFKPHlHgBrMbjIxC0+RfhnvNI+8nlE1ohyn9vgCIKZHZQKF+2n591q0G/dq9yD6l2L2ChZHBW+g+J48pq2xBFirNSKuAmgEZjkQH6HAr4kN6BzJNhZREnR+guheWZnGK62EjJiO1CK99ioVWKo9Hs1xeAvhQYDbmb21D9jwAr6fo0DDBtxQNiVUcMpvJ0XLmBr8fzi6j4IylVvALgAMitjF7Xmbn47faKeODmRNwvotuhfv+Zn+sglGINaUWeLpFC4S6TaTHe0jillIhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P70vTScefYtgL2fAJ/vLjg1f8vTGRyR4dwKF+jHkT5g=;
 b=WKPVcQXZdWUE3qDcdQxcs5QfZ/hbMuCND1sJGWdz0H17VG17zI3LPYzA0RywEW8gxofuZVNP6o5V+azruGWxhqSQXagx+lb8r4Dqt+MJ/FlmrYrrUMxqhq852qR77E5zLgt7FcH3g5CIKsiPZd96MdiTJqrOO06kofHOxLd/SLA=
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Sun, 27 Dec
 2020 12:18:16 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%5]) with mapi id 15.20.3700.031; Sun, 27 Dec 2020
 12:18:16 +0000
From:   "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH] regmap: debugfs: fix a memory leak when calling
 regmap_attach_dev
Thread-Topic: [PATCH] regmap: debugfs: fix a memory leak when calling
 regmap_attach_dev
Thread-Index: AQHW2rkvRF8s09LoMU2+gWDmIMyIv6oJba8AgAFr8qA=
Date:   Sun, 27 Dec 2020 12:18:16 +0000
Message-ID: <PH0PR11MB507734E4DF73DF015AD601EB95DA0@PH0PR11MB5077.namprd11.prod.outlook.com>
References: <20201225122613.3810458-1-xiaolei.wang@windriver.com>
 <737e8b89-5748-2ef5-5294-8e65421931b9@web.de>
In-Reply-To: <737e8b89-5748-2ef5-5294-8e65421931b9@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [192.103.52.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 543ae2fc-6fc0-47cd-adfc-08d8aa617d80
x-ms-traffictypediagnostic: PH0PR11MB5096:
x-microsoft-antispam-prvs: <PH0PR11MB50960D9BDFEB782D9B81D25D95DA0@PH0PR11MB5096.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:115;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbxV6CLRtPnTU5UZgYZ9K8zHFSP0CvhBDgwmCg6Xoxx7S1LpS+5Q9dYNN76NlOV6k8MW3cgbCkwh9UrbyzeCeSLq6ChcsBHjUwn5oSNu6Pq3GmEBZ6qVXbKdpTTo1KtQSyz7ZfF8O2yCe+E1TcHa60NO9gzilntNNdczq9cWxiD/gnYkL1hirOoh2a/m95AgF/a4qbW8A554owKGqDn8kG1Pj4bWkfTsuTq/LRw9JJnHC0xWbpdSiBdjvaxqVIsfqkvpYtFZ8ekh+EAgB8CvzoXgefaWpOpnnG2YcUWgUWPnxyRKPuOpcSjx97Z7grefv3uuAVJAF7hhShDjTMEwG23kW2sZyAzvW98EWgLkoZDcI3XkwBIXt8ogSJd+lGv7S49Zha3BhrPKHjQ6Sk89hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39830400003)(366004)(4326008)(8676002)(66446008)(86362001)(66476007)(66556008)(52536014)(64756008)(66946007)(8936002)(33656002)(26005)(71200400001)(55016002)(2906002)(53546011)(76116006)(6506007)(5660300002)(110136005)(54906003)(316002)(7696005)(9686003)(186003)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZjJoRVMyUDZMd0ZzR1pzUWpic0N4K3QwWVRhS2lOUHozZkJEQjlEb053eXU4?=
 =?utf-8?B?alhmSklTSmlzc3ArZkFvdU0vRExrL2M2TElEZWF1c0dSTnZMTXZ1Smc0Z1R5?=
 =?utf-8?B?Y05PdWt4MkJBb3BJcGVNd1IwSEx3aURRWEdydVJZNzdPcVpjZm1tNXlnemZs?=
 =?utf-8?B?QnNTNXl4bnJadDFLclBRcVVYcGRsaTRQZkFsamU5ODdMN3FNR2lYZzJwdFpk?=
 =?utf-8?B?WmZ5Wm0yZzFXOE04ZXJWTzFCUk1lSWRJZ0hVQWlQT2poVU9zUGJQQkVObEJ4?=
 =?utf-8?B?Z2VzbExuR3Z5SkxyWU1CaE10OUR5MEtBQ0lRemx3aWRBNTRBbGpMQVRZKyt6?=
 =?utf-8?B?Z3FlYzNKdWNFaW9GbDlTZDJIcjVNdHMweTRqMjU5ZGx5dDZ4eU1BMnVheVly?=
 =?utf-8?B?NndRMDNaTGpJeks1NW5OYWRHYkVVNTRoR2ZBSXhSUDZQbFpLbzBsRU0yYzJR?=
 =?utf-8?B?Rk1TUE1aVWVXZkJhcDJ0cHhGM2pWNHVxRlpHcGZzVklnUVcrZitkMmVmZ3pF?=
 =?utf-8?B?Tm5zc1Rna2czekRPMWR4eDdNMDFoYkxMTlNQMXdZcS8yUGlVOEhDNGMzU2lT?=
 =?utf-8?B?WU9hRXVnMTRRSGJOZ1NZYllvaGdwN0VlRzhrSGlrU1JCNy9ZR29lTkdKUmxj?=
 =?utf-8?B?TWhER3dIdVJISEJpMURSODMwUXhqWDhNSVl5bTlDQkc0cW5RNWdjK2hRTklX?=
 =?utf-8?B?TXJVZTg3anA3alN0T0RGS2U0d1VNSXZ1alNreGZRVUJHUjNxTStsTXNGbFNi?=
 =?utf-8?B?RkJrSlZ3S2R4cXVBWjZZcW1hOCtoS2x6M0dqbC9xMHlUZGdYMWE1WlpkU3cy?=
 =?utf-8?B?OThNUFF5bWd5Vmt4WDZnbVpGNXU5MlhPVDhSTmNnTDVRMmVvd1NLMGNWRlhB?=
 =?utf-8?B?T0xZYWZlem9vSStVVWlhbU1lNm0yTUt0WjFpNUJjOUtFNUJlY09XU2NlMGY5?=
 =?utf-8?B?enBuc2VBekMxM0ZobHlmL09DcUFlYUF1R1VIZ3JPb3N0MWNvbmdxVGpUdC9s?=
 =?utf-8?B?Tlh0QWxobVF4UDNuRkFRbUtibW1LY3dwTkdxYjUwL0xwbHQvRnZKMGhycUhv?=
 =?utf-8?B?bEl2bjNoWG1XLzlTTXdyN3RQWkFOcjk3Y2puU0ZoQlh5Qk9uVjVuamdRK2Iy?=
 =?utf-8?B?TGUwckl2bzZYa0hQT1NQdUVEMmlNdDlLelNQaXBsYzBXdUxzZzcrU1VTL2JC?=
 =?utf-8?B?ZS9YVUkySXg5Y0JoTy9hODlpZklTOHZ5a1JEc2RySHpmeTJrM2xrVnBEVnov?=
 =?utf-8?B?V2pVbk1tR01pU3laMUlMMXJKWWNBSUFRRWx5RXVUM1k4cWlvci9xTnd1akxL?=
 =?utf-8?Q?/4+wVHkbmlphA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543ae2fc-6fc0-47cd-adfc-08d8aa617d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2020 12:18:16.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwh+wdQeW5nYJHKKmPKWqKxuCXYotnwljHk0bShp1Mv0m7i3XLa8i116/28UzqKiXAGFOIHCQ7MLR870Nzlx1ZiOtrBexsubENKYUkaqdE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzDQoNCj4gVGhpcyBzaG91bGQgYmUgY2F1c2VkIGJ5DQo+IGNvbW1pdCA8OWI5NDdh
MTNlN2Y2PiAoIjxyZWdtYXA6IHVzZSBkZWJ1Z2ZzIGV2ZW4gd2hlbiBubyBkZXZpY2U+IikNCg0K
PiBJIHN1Z2dlc3QgdG8gb21pdCBhbmdsZSBicmFja2V0cyBmcm9tIHN1Y2ggaW5mb3JtYXRpb24u
DQoNCg0KPiAqIFdpbGwgYW5vdGhlciBpbXBlcmF0aXZlIHdvcmRpbmcgYmVjb21lIGhlbHBmdWwg
Zm9yIHRoZSBjb21taXQgZGVzY3JpcHRpb24/DQoNCj4gKiBIb3cgZG8geW91IHRoaW5rIGFib3V0
IHRvIGFkZCB0aGUgdGFnIOKAnEZpeGVz4oCdPw0KDQpEbyB5b3UgbWVhbiBzbz8NCg0KY29tbWl0
Og0KICAgICAgICAgOWI5NDdhMTNlN2Y2ICgicmVnbWFwOiB1c2UgZGVidWdmcyBldmVuIHdoZW4g
bm8gZGV2aWNlIikNCg0K4oCmDQo+ICsrKyBiL2RyaXZlcnMvYmFzZS9yZWdtYXAvcmVnbWFwLWRl
YnVnZnMuYw0K4oCmDQo+IEBAIC01ODIsOCArNTgyLDEwIEBAIHZvaWQgcmVnbWFwX2RlYnVnZnNf
aW5pdChzdHJ1Y3QgcmVnbWFwICptYXApDQo+ICAJCWRldm5hbWUgPSBkZXZfbmFtZShtYXAtPmRl
dik7DQo+DQo+ICAJaWYgKG5hbWUpIHsNCj4gLQkJbWFwLT5kZWJ1Z2ZzX25hbWUgPSBrYXNwcmlu
dGYoR0ZQX0tFUk5FTCwgIiVzLSVzIiwNCj4gKwkJaWYgKCFtYXAtPmRlYnVnZnNfbmFtZSkgew0K
PiArCQkJbWFwLT5kZWJ1Z2ZzX25hbWUgPSBrYXNwcmludGYoR0ZQX0tFUk5FTCwgIiVzLSVzIiwN
Cj4gIAkJCQkJICAgICAgZGV2bmFtZSwgbmFtZSk7DQo+ICsJCX0NCuKApg0KDQo+IEkgcHJvcG9z
ZSB0byBhZGQgYW5vdGhlciBudWxsIHBvaW50ZXIgY2hlY2sgdG9nZXRoZXIgd2l0aCBjb3JyZXNw
b25kaW5nIGV4Y2VwdGlvbiBoYW5kbGluZy4NCg0KV2hpY2ggb25lIGRvIHlvdSBtZWFuIGJ5ICJh
bm90aGVyIG51bGwgcG9pbnQiPyBEbyB5b3UgbWVhbiB0aGF0IGlmIHRoZSBjYWxsICJyZWdtYXBf
ZGVidWdmc19pbml0IiBmdW5jdGlvbiBpcyByZXBlYXRlZCwgaXQgcmV0dXJucyBkaXJlY3RseT8N
Cg0KUmVnYXJkcywNClhpYW9sZWkNCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPiANClNlbnQ6IFNhdHVy
ZGF5LCBEZWNlbWJlciAyNiwgMjAyMCAxMDoxNiBQTQ0KVG86IFdhbmcsIFhpYW9sZWkgPFhpYW9s
ZWkuV2FuZ0B3aW5kcml2ZXIuY29tPjsga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZw0K
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+
OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQpTdWJqZWN0OiBSZTogW1BB
VENIXSByZWdtYXA6IGRlYnVnZnM6IGZpeCBhIG1lbW9yeSBsZWFrIHdoZW4gY2FsbGluZyByZWdt
YXBfYXR0YWNoX2Rldg0KDQo+IFRoaXMgc2hvdWxkIGJlIGNhdXNlZCBieQ0KPiBjb21taXQgPDli
OTQ3YTEzZTdmNj4gKCI8cmVnbWFwOiB1c2UgZGVidWdmcyBldmVuIHdoZW4gbm8gZGV2aWNlPiIp
DQoNCkkgc3VnZ2VzdCB0byBvbWl0IGFuZ2xlIGJyYWNrZXRzIGZyb20gc3VjaCBpbmZvcm1hdGlv
bi4NCg0KDQoqIFdpbGwgYW5vdGhlciBpbXBlcmF0aXZlIHdvcmRpbmcgYmVjb21lIGhlbHBmdWwg
Zm9yIHRoZSBjb21taXQgZGVzY3JpcHRpb24/DQoNCiogSG93IGRvIHlvdSB0aGluayBhYm91dCB0
byBhZGQgdGhlIHRhZyDigJxGaXhlc+KAnT8NCg0KDQrigKYNCj4gKysrIGIvZHJpdmVycy9iYXNl
L3JlZ21hcC9yZWdtYXAtZGVidWdmcy5jDQrigKYNCj4gQEAgLTU4Miw4ICs1ODIsMTAgQEAgdm9p
ZCByZWdtYXBfZGVidWdmc19pbml0KHN0cnVjdCByZWdtYXAgKm1hcCkNCj4gIAkJZGV2bmFtZSA9
IGRldl9uYW1lKG1hcC0+ZGV2KTsNCj4NCj4gIAlpZiAobmFtZSkgew0KPiAtCQltYXAtPmRlYnVn
ZnNfbmFtZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiJXMtJXMiLA0KPiArCQlpZiAoIW1hcC0+
ZGVidWdmc19uYW1lKSB7DQo+ICsJCQltYXAtPmRlYnVnZnNfbmFtZSA9IGthc3ByaW50ZihHRlBf
S0VSTkVMLCAiJXMtJXMiLA0KPiAgCQkJCQkgICAgICBkZXZuYW1lLCBuYW1lKTsNCj4gKwkJfQ0K
4oCmDQoNCkkgcHJvcG9zZSB0byBhZGQgYW5vdGhlciBudWxsIHBvaW50ZXIgY2hlY2sgdG9nZXRo
ZXIgd2l0aCBjb3JyZXNwb25kaW5nIGV4Y2VwdGlvbiBoYW5kbGluZy4NCg0KUmVnYXJkcywNCk1h
cmt1cw0K
