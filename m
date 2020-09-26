Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE60C27982F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgIZJcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 05:32:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37108 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601112721; x=1632648721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rp+KM8euiO2CDmREVKH+nNH7iTOlNBwC6EqtGEmgHJY=;
  b=BcOGNTbDyLudGC4WR2eg5jTDaNMy9ZWedITacXJOHhje81uxhCGPVXQ8
   SRwFrawGcCjEDvpdRXttDQy3mxv5hw7Yd5p0mc6nKcFcU1B8APfjI16cv
   6Lmc9OkSI4M+RzcOMTlz532utstcxa0zcqa5gNXLumqvHXr9h2Pm4Mvea
   lNRH54o1niMa17luGOiuf5e4pu5vwf5sKQ+9AKGhJnCimIZP+d4SqWXDx
   /+1/RShQhE7ONe3prOugc2MrJ7PPbYnhodk3VBjAn2uAz8eZ5BeMFpqgb
   1FzKwhfaxJwFq18W4mi50G9f+zUMDpebCZwr0dRcHv0hC9u8oJE4WgBDq
   g==;
IronPort-SDR: Tw35iGcOzNW+9h1k8K84Q6n+DGc1SpgXfaxN1whMDqK9ma2Z7scGs6kMQjqieoiWKDDc0suGrs
 lZ2Y0J1HprpdnpUT4rXD0Q/kGHEOExOnSTA/0Ki1UdCN5Iw2Zs018Fc15PjZi2ARbCxi1fRFmT
 svl9sUQsoVwcszk4A4tHvEiiZDnum7wr71mMA2nBhROu/v1QssOTtcYDA9kX1gi8BArk+IbRM4
 ZskR143u+EoowW67lYxCYEDaT1PvxU1clNI6t6DnTWYi5LunAqBLtu26e7NBn/wJpRCTTZ31qs
 Z6E=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="149555903"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 17:32:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fReIwBFjxk5PVjv9TkYT66VngPK/jZbz267pkTMDxWQG+bWWvkewWSmLG/hwuwvneFt3CKZdKtKNr7o6pCMUZx5gQ01i7Rcm3OwYT0e4F50mDLUvRt7uczrdGKq3T1mH771s7bGaMjD6e3o/qux1Iu3jTGMj04W8lP4bOfFTFMoqUe4sbADX1jHWo/x4x+NyxAIMxBGXnM0rZ5stRbnLdD8rj8xDEsulU2eTwqPi1Cu7XC9hkixogZI1XZF82aSCI13t/w1bxq4TEtuNaAArhZDmtvMTNQmnlzepOjDFe6AtyzyMwsXGSjNxWG0eUHrOz/ZPtwY0WkxfRr9OXnd8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp+KM8euiO2CDmREVKH+nNH7iTOlNBwC6EqtGEmgHJY=;
 b=FiGPP31n/ZYfm9u/6K0+snfedIYtpLG2hH5PR2Sv+dvCjgLJugchhz5obw7Cw2drOUYkVPz+8qrdBk1tjhkdQcJu4ltlnNRezicZ3m2LZuv2VHSCjecF+vh6SRseWANpstexfJ0iSYw02zoo5smMar58U3GGhkCh34b36I2mUnrgaWshfKtD/EDcG0FYfrDoiLMJiA14IkasCx9K4+T0bwf3FrjikzBEiYrZKXLDkICsTJ8zJQvzwRoQXP2eC+73igPYVmPK53pKXgvP5gVg2WwUWduzM+SlbUPePh0cBWPBocPbbx5/b2TgCTMJfz6pCsHntGGjJFAA+U26Fr6YnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp+KM8euiO2CDmREVKH+nNH7iTOlNBwC6EqtGEmgHJY=;
 b=WSZeLz4aqWkQzt4QlJSQ8yx4VmsY5cju/rAs+ltHc/If80Sk+SBAkeOqYZLmQhw1ggxzKYwefRXGA21lDFpgXfS8yjh4JZATS76mlcxAWN23eGvTnu4fUQFAyK8Rn50RAV8oRJL8KajdRDd7hwLzmDdegRc6+nu57HerMo86tcM=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6494.namprd04.prod.outlook.com (2603:10b6:5:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Sat, 26 Sep
 2020 09:31:57 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3391.020; Sat, 26 Sep 2020
 09:31:57 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RISC-V: Check clint_time_val before use
Thread-Topic: [PATCH] RISC-V: Check clint_time_val before use
Thread-Index: AQHWk9aXpjplWP6NWE6N/VtUxnpMtKl6pkWAgAABk0A=
Date:   Sat, 26 Sep 2020 09:31:57 +0000
Message-ID: <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200926072750.807764-1-anup.patel@wdc.com>
 <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>
In-Reply-To: <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [122.179.126.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9b53e17-7f5f-4f1b-ebd5-08d861ff0342
x-ms-traffictypediagnostic: DM6PR04MB6494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6494EC64FF1A78CF83CD13298D370@DM6PR04MB6494.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQpBoT2bwvMsC0TNR9Q3Po9RgrVxRQjndeeHOK85Wmxu406HX0D37fOvuVUFCk/1Uc9a3ASlNGVUtqa8iTlPosIXyOWm0FN4zsDn3w4fGEqfXQve9t1W+jEWqT/k+oSIZpCTwVC1tRYx31iyuCxB1ldzSE7js7I0baoQVvDtMLV51JDcTDW93OXMGSb7VP+Gxl4jntjp7Njfuwi2fT+OnMtdqamSux8Sp31ZhfLpMLFujAokOoHTSRD46Hj6HFTDZxMGv7sTqlt7AtHBRDASYbHJcazSCfXSZZ7s4G8gAuXNbp4UExPM05Dk0qJ/056g+0M+7ESbOm/wF4DUzM81aVJSYt6aJuzKNzuA/u2tIpB0zbm0pBgncpBGM9JsaqGD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(33656002)(316002)(8936002)(8676002)(83380400001)(2906002)(53546011)(66446008)(26005)(186003)(6506007)(66476007)(66556008)(64756008)(86362001)(55016002)(478600001)(7696005)(54906003)(71200400001)(76116006)(4326008)(9686003)(5660300002)(66946007)(52536014)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uPfkTeP9Pd6iIwgQH1zI8OKvL7CPb515JVYAp7XgW0/DtRPwA82ytIExE6L3JZrXREokJt0d7GPschVpR8UkILON1viL6MiFQS0dqh3fW35Od3TDhu9hcxjmx6wttafVuZs5pZyb2pzJNjvvGvG3lYd/D4iFa3wJGkVMf6ryIQPMXuQTn5E+8eWx5Mz32CnZS3KuJtUUmPlUm4lQyXJ9vLaSqaCrNrle2pP+RxZefZGFFZIyc8J8BHbe+oI+4gYCg/nBjR3IMuQb+U8Ir9vqABK1qgSmLAT0JVbnxLxtT6o1E48EjgAK0euRcKHT6VZma5RI9rtChG1gjvPz/s/pNxLTkfbkX91nIFu1UFNhVMFUsHQ400E5q+Q1FPfw3KrM1hS5w5vSqJU4E87u6jHslfi3VuDjVRZhRKB6iw8qcCkbmx0BXcQk2fHgDqYZyeRi0wI8zfERHXnTTkqjZGhUMA4WV5Hrc7ftMD5Isdq3VkidnvYcJ8uf44tnMJGdRtCSD2NwApu+o2y1ZemfUvHBUPuu4DuTIEnIwebVM4NkBRhtlfJTHpEmO/oxR3oUGlNLb9E00hzgzx4q8v3KaGegVQPHkQgOpOBglzmWnswv/mSoeIwgG+Tkh7JH6TE/4JJ38dH/ICWOrbmWYsQFI5uzzA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b53e17-7f5f-4f1b-ebd5-08d861ff0342
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 09:31:57.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5C3ffUdzsVJ4Ck1UvZiPSdRt+aM711ZlJZTB2QPXddyTDPtiUbdnLyOi0XtGgf+wzc25YL5htprWccd8jyJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6494
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFtaWVuIExlIE1vYWwg
PERhbWllbi5MZU1vYWxAd2RjLmNvbT4NCj4gU2VudDogMjYgU2VwdGVtYmVyIDIwMjAgMTQ6NTUN
Cj4gVG86IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiBw
YWxtZXJkYWJiZWx0QGdvb2dsZS5jb207IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT47
DQo+IGFvdUBlZWNzLmJlcmtlbGV5LmVkdQ0KPiBDYzogYW51cEBicmFpbmZhdWx0Lm9yZzsgbGlu
dXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQXRpc2ggUGF0cmENCj4gPEF0aXNoLlBhdHJh
QHdkYy5jb20+OyBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBS
SVNDLVY6IENoZWNrIGNsaW50X3RpbWVfdmFsIGJlZm9yZSB1c2UNCj4gDQo+IE9uIFNhdCwgMjAy
MC0wOS0yNiBhdCAxMjo1NyArMDUzMCwgQW51cCBQYXRlbCB3cm90ZToNCj4gPiBUaGUgTm9NTVUg
a2VybmVsIGlzIGJyb2tlbiBmb3IgUUVNVSB2aXJ0IG1hY2hpbmUgZnJvbSBMaW51eC01LjktcmM2
DQo+ID4gYmVjYXVzZSB0aGUgZ2V0X2N5Y2xlcygpIGFuZCBmcmllbmRzIGFyZSBjYWxsZWQgdmVy
eSBlYXJseSBmcm9tDQo+ID4gcmFuZF9pbml0aWFsaXplKCkgYmVmb3JlIENMSU5UIGRyaXZlciBp
cyBwcm9iZWQuIFRvIGZpeCB0aGlzLCB3ZQ0KPiA+IHNob3VsZCBjaGVjayBjbGludF90aW1lX3Zh
bCBiZWZvcmUgdXNlIGluIGdldF9jeWNsZXMoKSBhbmQgZnJpZW5kcy4NCj4gPg0KPiA+IEZpeGVz
OiBkNWJlODlhOGQxMTggKCJSSVNDLVY6IFJlc3VycmVjdCB0aGUgTU1JTyB0aW1lciBpbXBsZW1l
bnRhdGlvbg0KPiA+IGZvciBNLW1vZGUgc3lzdGVtcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQW51
cCBQYXRlbCA8YW51cC5wYXRlbEB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL3RpbWV4LmggfCAxMiArKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RpbWV4LmgNCj4gPiBiL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vdGltZXguaCBpbmRleCA3ZjY1OWRkYTAwMzIuLjUyYjQyYmIxNjAyYw0KPiA+IDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGltZXguaA0KPiA+ICsrKyBiL2FyY2gv
cmlzY3YvaW5jbHVkZS9hc20vdGltZXguaA0KPiA+IEBAIC0xNywxOCArMTcsMjQgQEAgdHlwZWRl
ZiB1bnNpZ25lZCBsb25nIGN5Y2xlc190OyAgI2lmZGVmDQo+ID4gQ09ORklHXzY0QklUICBzdGF0
aWMgaW5saW5lIGN5Y2xlc190IGdldF9jeWNsZXModm9pZCkgIHsNCj4gPiAtCXJldHVybiByZWFk
cV9yZWxheGVkKGNsaW50X3RpbWVfdmFsKTsNCj4gPiArCWlmIChjbGludF90aW1lX3ZhbCkNCj4g
PiArCQlyZXR1cm4gcmVhZHFfcmVsYXhlZChjbGludF90aW1lX3ZhbCk7DQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiAgfQ0KPiA+ICAjZWxzZSAvKiAhQ09ORklHXzY0QklUICovDQo+ID4gIHN0YXRpYyBp
bmxpbmUgdTMyIGdldF9jeWNsZXModm9pZCkNCj4gPiAgew0KPiA+IC0JcmV0dXJuIHJlYWRsX3Jl
bGF4ZWQoKCh1MzIgKiljbGludF90aW1lX3ZhbCkpOw0KPiA+ICsJaWYgKGNsaW50X3RpbWVfdmFs
KQ0KPiA+ICsJCXJldHVybiByZWFkbF9yZWxheGVkKCgodTMyICopY2xpbnRfdGltZV92YWwpKTsN
Cj4gPiArCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gICNkZWZpbmUgZ2V0X2N5Y2xlcyBnZXRfY3lj
bGVzDQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSB1MzIgZ2V0X2N5Y2xlc19oaSh2b2lkKSAgew0K
PiA+IC0JcmV0dXJuIHJlYWRsX3JlbGF4ZWQoKCh1MzIgKiljbGludF90aW1lX3ZhbCkgKyAxKTsN
Cj4gPiArCWlmIChjbGludF90aW1lX3ZhbCkNCj4gPiArCQlyZXR1cm4gcmVhZGxfcmVsYXhlZCgo
KHUzMiAqKWNsaW50X3RpbWVfdmFsKSArIDEpOw0KPiA+ICsJcmV0dXJuIDANCj4gPiAgfQ0KPiA+
ICAjZGVmaW5lIGdldF9jeWNsZXNfaGkgZ2V0X2N5Y2xlc19oaQ0KPiA+ICAjZW5kaWYgLyogQ09O
RklHXzY0QklUICovDQo+IA0KPiBBcHBseWluZyB0aGlzIG9uIHRvcCBvZiByYzYsIEkgbm93IGdl
dCBhIGhhbmcgb24gS2VuZHJ5dGUgYm9vdC4uLg0KPiBObyBwcm9ibGVtcyB3aXRob3V0IHRoZSBw
YXRjaCBvbiB0aGUgb3RoZXIgaGFuZC4NCg0KTm90IHN1cmUgYWJvdXQgdGhlIGlzc3VlIHdpdGgg
S2VuZHJ5dGUgYnV0IEkgZ2V0IGEgY3Jhc2ggb24NClFFTVUgdmlydCBtYWNoaW5lIHdpdGhvdXQg
dGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNCkFudXANCg==
