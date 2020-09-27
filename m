Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA92279E87
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgI0Fvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:51:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45808 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgI0Fvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601185892; x=1632721892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q9zHDhTOdzBFTb+QNBGZ/EKhYndqeDMWFhuF6S8aTOY=;
  b=hpTsgx56OMo8xdRxsmBZ6H9IReMri4zGrQqBNf/pRxA+WndFbBDmGL4G
   2hddTLLTphK+IAXHdxJQk7DY1KQNpkd02HPsKQct8ncKj4unAMD3r10mp
   sE6E+qrVlTSkgmz8q89Gm6tnDF+QWO8ApJIdoRDncsKonfY3NIKQ0iiZQ
   1JmgoeaA6cHKREo/DbhuEy6619Iqfqi7DSgiNtAWUfqKLf3RzGNRu06pw
   iyk30fd5AUZU34UuKyNCBU0zEcyF0j3DcetFhT3AH/NOQl6GLUfkAKzUh
   C5ntM7BnSjdevyDkO65Y7lbXK/jGvnh7HrnX47PSBdVD6BaBhwzsEkHei
   w==;
IronPort-SDR: rAYvnrIDg9uT/gL+zBapAQuc0aoBkh09MAdYsWNqPa1okPxxS11fpv2l7IMT+/3+ChOTwF779j
 s1mDxJqys4fnKZUQ2dTaR+db5G10O55Y0QI9xguCUpoiHb/f2MNb7FSCRM3BnJ1u4PSffgysCR
 ba5pukJFfnbOYALwyTzvW1BxCouyCPl4LsF0VvPO7riOjya3G16DKt5oYZ9jQdCYnUr10mVe7E
 LmGXxA7XsfVqy51VGxWP+mrw8EE0CtO0eUvrQuTjDK9TIj7zvyhvXDTA+hmdaiqJ+PlJ/F3/DE
 GZI=
X-IronPort-AV: E=Sophos;i="5.77,308,1596470400"; 
   d="scan'208";a="258081525"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2020 13:51:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzKlATrT7dtun9XrSjsrZAVpwbAe3/nUHuDDoInc8cX/GFQ51yZJbrZ+MZZZtCJII3LE5Wbjl5D9I+lzO2TM351/UUf8wvUEeRyb0+z8/6qxBVqneItrRTaBv/ekH6T7ibSAibWsPTopOaPuq7G6L7zACR2wZJ7mpflNwAW0279J1ya/orXAduyp1mUuiBRDKMbYxmqpjkMfqHHcjV94mihC+S7FawP5lug5N98sDgNaLUZ5rqPy/iMSyAM5vo1nV/1WR7rSPQidujdQ0UvZTHIFkXkqOrtm0nyd+t8bFaqkfrWlkWG10HsItKjJfp2BG85JMf9oA/63/QWcc26wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9zHDhTOdzBFTb+QNBGZ/EKhYndqeDMWFhuF6S8aTOY=;
 b=Ls63vsfE2MNdotXnE/OwMEDWzmp49xfnwpHa6Y8cSVtbFcIkSIYkxymuf271IsmYShE6tOB8JIvOV6EIfVJ7esyiqLPMDLTdVuEmV6227mTbH/aN0cowUn614o52fOsvkm3ZfO3Dz/2yw0yJczm5/H7DwTd1I5wjNnknxWo2BaZ/DzSVG2q4iE0rYflKcIgitsWgzfv8oQbjUvBlnejthEGIynWZwiPmMs6powg0E49BBMhSJI+L6yVHNJfTf/JCCNaLK/pQ+eg0R/ay2ciuV03AzBxs96wX5OsTjR1FD9oYoJq4S/iGYrFMTPFAdC72iDFGqozIynn9k9DHW7hGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9zHDhTOdzBFTb+QNBGZ/EKhYndqeDMWFhuF6S8aTOY=;
 b=DBFxnRJ02o6PtLLDHug64zvKPgIsVaKsiMgmWf99OHkTVXHzcUOFENvrSLzUdno+xkx/0QiTbz1hakaqiwrlAMHmdlAxhp3VUrWZXWh1f41yygK7/beDxIb3zoPlQu2s6SvDmDDCOedeX9RubRYKPW0o2CzeCoahmFbC3cSc0WA=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0568.namprd04.prod.outlook.com (2603:10b6:903:b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Sun, 27 Sep
 2020 05:51:30 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.024; Sun, 27 Sep 2020
 05:51:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3] RISC-V: Check clint_time_val before use
Thread-Topic: [PATCH v3] RISC-V: Check clint_time_val before use
Thread-Index: AQHWlJCbTT3SAnzKQkepz4y0A+6P2ql7+ggAgAABU4A=
Date:   Sun, 27 Sep 2020 05:51:29 +0000
Message-ID: <8aa476f17abde08d22862b2acdad091116aca54d.camel@wdc.com>
References: <mhng-0fd4eb79-05f0-49cd-8527-e5c74c65b7b1@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-0fd4eb79-05f0-49cd-8527-e5c74c65b7b1@palmerdabbelt-glaptop1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b51b280-1a4a-461e-e4ce-08d862a96184
x-ms-traffictypediagnostic: CY4PR04MB0568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0568825248668378FBB41420E7340@CY4PR04MB0568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57q6pC6YPzBaofPMMiCEYG+CLrKifMAzX2iwWT3KHNNrbbBMs0FtDySlnwtGDzKuDk+sjBzODpogresF4S5N4iH7tCQEIal3QafIGgyIKYNfCG3g2TaFKraX2mcOMGvg4SDSAPE83v1p+1Tkod89wRFYeWPCiHDpf5gsf/nHAhYtaz5h2YReis7KEhv9VZ/RLSvHTQXf7bJ4kpdLtZ8kVpEPBTgk0/8EQ5knAJhuaJLiTl81mWel0izk/BfmJ0L7uLlqqTEbY87OfSLQc/JwMKOFASiJgi9QOyCnc6BRSKJFe5vZKfH36LiA7+Cj2prE2wVx0caei6JA3SSxpCgveRTpJ1BW4uj7nw2jwRiWYS0AWnJC0upioKh2STiquGda
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(346002)(376002)(366004)(66946007)(66446008)(5660300002)(64756008)(86362001)(71200400001)(66476007)(66556008)(8936002)(8676002)(91956017)(76116006)(83380400001)(2906002)(6486002)(6506007)(54906003)(2616005)(110136005)(316002)(36756003)(186003)(6636002)(478600001)(6512007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JbRG50EMpqe2relkVLKFH0U4/yKuCld7UNf3Y4Xun7D50h9nTZLO+dzHrtFJKRTSCLqu0lrkW7kTPRmtAO0VA4bvHGNrM5J7J76CsmwOhERN8qXbHwPY2E+u7B+9k+86tA7DEKwPd1j8B2KP0XIfsi8YPUDspq6A88xJNRgCYshSqUXYOhpHnR8ZM6nTLvJbp+uOL4feFDTOgFD9mKiHHTsXOmwjTdJvTYxxjagg9mZ/wwg5XaipBF+hhnr8MhrSf2JOGovJHpdhShGAlfyw28BfCpEDQzmfn65S3QMaSYRFQew0jNe3UHZ04IAQeDrFnXVVrgFbPSkiX8yg4FOU6iYgN8RqnHqRlIbQGifTo3uw4S4W8bS8W1ybUsOT9/QjNW75ulrKXeVmPA7lcacWrzy0ZOTR+kigC+wNyk4UGz+LEbt/Zazud7dfZDOZ6qjxX3b5entnGF/f5XcsmN8gT2thMpSnsZh3+FJUvS46kb1+akEx5dK84D+8rJ5osuRAVAr1qUM64F79hOrtUzp44R7FQGNBLjcxqlBv/1tamk3x6YKP4PhVaQTDI0QcruolqXRaZvHJR2akRwxTK/hVhQMCEvqA6YgEf9syGpyGmOzzCz9Zypm2aOXBE5xWRG+q8zUQY9m1SLTlVPOU+xnk7RQ7paxVrnWDegsUukGoYWzZSqGip4VO/nI8FhEKMy6Bvy3KWNWWnkTA4kx+Mtyr9w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2798F362D3D0474482CFF322AE4D23D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b51b280-1a4a-461e-e4ce-08d862a96184
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 05:51:29.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9Mpjm6bBW2h/zUAmaQSJECxyGNGz4Z9W7PfSrhG7Ldkpq/o1oyp0hed94xojciYisTij7+wWtcA+8+iV6ejdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0568
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA5LTI2IGF0IDIyOjQ2IC0wNzAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gT24gU2F0LCAyNiBTZXAgMjAyMCAyMjozOToxNiBQRFQgKC0wNzAwKSwgQW51cCBQYXRlbCB3
cm90ZToNCj4gPiBUaGUgTm9NTVUga2VybmVsIGlzIGJyb2tlbiBmb3IgUUVNVSB2aXJ0IG1hY2hp
bmUgZnJvbSBMaW51eC01LjktcmM2DQo+ID4gYmVjYXVzZSBjbGludF90aW1lX3ZhbCBpcyB1c2Vk
IGV2ZW4gYmVmb3JlIENMSU5UIGRyaXZlciBpcyBwcm9iZWQNCj4gPiBhdCBmb2xsb3dpbmcgcGxh
Y2VzOg0KPiA+IDEuIHJhbmRfaW5pdGlhbGl6ZSgpIGNhbGxzIGdldF9jeWNsZXMoKSB3aGljaCBp
bi10dXJuIHVzZXMNCj4gPiAgICBjbGludF90aW1lX3ZhbA0KPiA+IDIuIGJvb3RfaW5pdF9zdGFj
a19jYW5hcnkoKSBjYWxscyBnZXRfY3ljbGVzKCkgd2hpY2ggaW4tdHVybg0KPiA+ICAgIHVzZXMg
Y2xpbnRfdGltZV92YWwNCj4gPiANCj4gPiBUaGUgaXNzdWUjMSAoYWJvdmUpIGlzIGZpeGVkIGJ5
IHByb3ZpZGluZyBjdXN0b20gcmFuZG9tX2dldF9lbnRyb3B5KCkNCj4gPiBmb3IgUklTQy1WIE5v
TU1VIGtlcm5lbC4gRm9yIGlzc3VlIzIgKGFib3ZlKSwgd2UgcmVtb3ZlIGRlcGVuZGVuY3kgb2YN
Cj4gPiBib290X2luaXRfc3RhY2tfY2FuYXJ5KCkgb24gZ2V0X2N5Y2xlcygpIGFuZCB0aGlzIGlz
IGFsaWduZWQgd2l0aCB0aGUNCj4gPiBib290X2luaXRfc3RhY2tfY2FuYXJ5KCkgaW1wbGVtZW50
YXRpb25zIG9mIEFSTSwgQVJNNjQgYW5kIE1JUFMga2VybmVsLg0KPiA+IA0KPiA+IEZpeGVzOiBk
NWJlODlhOGQxMTggKCJSSVNDLVY6IFJlc3VycmVjdCB0aGUgTU1JTyB0aW1lciBpbXBsZW1lbnRh
dGlvbg0KPiA+IGZvciBNLW1vZGUgc3lzdGVtcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUGFsbWVy
IERhYmJlbHQgPHBhbG1lcmRhYmJlbHRAZ29vZ2xlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bnVwIFBhdGVsIDxhbnVwLnBhdGVsQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5j
ZSB2MjoNCj4gPiAgLSBUYWtlIGRpZmZlcmVudCBhcHByb2FjaCBhbmQgcHJvdmlkZSBjdXN0b20g
cmFuZG9tX2dldF9lbnRyb3B5KCkgZm9yDQo+ID4gICAgUklTQy1WIE5vTU1VIGtlcm5lbA0KPiA+
ICAtIFJlbW92ZSBkZXBlbmRlbmN5IG9mIGJvb3RfaW5pdF9zdGFja19jYW5hcnkoKSBvbiBnZXRf
Y3ljbGVzKCkNCj4gPiAgLSBIb3BlZnVsbHkgd2UgZG9uJ3QgcmVxdWlyZSB0byBzZXQgY2xpbnRf
dGltZV92YWwgPSBOVUxMIGluIENMSU5UDQo+ID4gICAgZHJpdmVyIHdpdGggYSBkaWZmZXJlbnQg
YXBwcm9hY2ggdG8gZml4Lg0KPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gIC0gRXhwbGljaXRs
eSBpbml0aWFsaXplIGNsaW50X3RpbWVfdmFsIHRvIE5VTEwgaW4gQ0xJTlQgZHJpdmVyIHRvDQo+
ID4gICAgYXZvaWQgaGFuZyBvbiBLZW5kcnl0ZSBLMjEwDQo+ID4gLS0tDQo+ID4gIGFyY2gvcmlz
Y3YvaW5jbHVkZS9hc20vc3RhY2twcm90ZWN0b3IuaCB8ICA0IC0tLS0NCj4gPiAgYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS90aW1leC5oICAgICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3RhY2twcm90ZWN0b3IuaCBi
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3RhY2twcm90ZWN0b3IuaA0KPiA+IGluZGV4IGQ5NWY3
YjJhN2YzNy4uNTk2MmY4ODkxZjA2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVk
ZS9hc20vc3RhY2twcm90ZWN0b3IuaA0KPiA+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20v
c3RhY2twcm90ZWN0b3IuaA0KPiA+IEBAIC01LDcgKzUsNiBAQA0KPiA+IA0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvcmFuZG9tLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC92ZXJzaW9uLmg+DQo+ID4g
LSNpbmNsdWRlIDxhc20vdGltZXguaD4NCj4gPiANCj4gPiAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcg
X19zdGFja19jaGtfZ3VhcmQ7DQo+ID4gDQo+ID4gQEAgLTE4LDEyICsxNyw5IEBAIGV4dGVybiB1
bnNpZ25lZCBsb25nIF9fc3RhY2tfY2hrX2d1YXJkOw0KPiA+ICBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIHZvaWQgYm9vdF9pbml0X3N0YWNrX2NhbmFyeSh2b2lkKQ0KPiA+ICB7DQo+ID4gIAl1bnNp
Z25lZCBsb25nIGNhbmFyeTsNCj4gPiAtCXVuc2lnbmVkIGxvbmcgdHNjOw0KPiA+IA0KPiA+ICAJ
LyogVHJ5IHRvIGdldCBhIHNlbWkgcmFuZG9tIGluaXRpYWwgdmFsdWUuICovDQo+ID4gIAlnZXRf
cmFuZG9tX2J5dGVzKCZjYW5hcnksIHNpemVvZihjYW5hcnkpKTsNCj4gPiAtCXRzYyA9IGdldF9j
eWNsZXMoKTsNCj4gPiAtCWNhbmFyeSArPSB0c2MgKyAodHNjIDw8IEJJVFNfUEVSX0xPTkcvMik7
DQo+ID4gIAljYW5hcnkgXj0gTElOVVhfVkVSU0lPTl9DT0RFOw0KPiA+ICAJY2FuYXJ5ICY9IENB
TkFSWV9NQVNLOw0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L3RpbWV4LmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RpbWV4LmgNCj4gPiBpbmRleCA3ZjY1
OWRkYTAwMzIuLmFiMTA0OTA1ZDRkYiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL3RpbWV4LmgNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RpbWV4LmgN
Cj4gPiBAQCAtMzMsNiArMzMsMTkgQEAgc3RhdGljIGlubGluZSB1MzIgZ2V0X2N5Y2xlc19oaSh2
b2lkKQ0KPiA+ICAjZGVmaW5lIGdldF9jeWNsZXNfaGkgZ2V0X2N5Y2xlc19oaQ0KPiA+ICAjZW5k
aWYgLyogQ09ORklHXzY0QklUICovDQo+ID4gDQo+ID4gKy8qDQo+ID4gKyAqIE11Y2ggbGlrZSBN
SVBTLCB3ZSBtYXkgbm90IGhhdmUgYSB2aWFibGUgY291bnRlciB0byB1c2UgYXQgYW4gZWFybHkg
cG9pbnQNCj4gPiArICogaW4gdGhlIGJvb3QgcHJvY2Vzcy4gVW5mb3J0dW5hdGVseSB3ZSBkb24n
dCBoYXZlIGEgZmFsbGJhY2ssIHNvIGluc3RlYWQNCj4gPiArICogd2UganVzdCByZXR1cm4gMC4N
Cj4gPiArICovDQo+ID4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyByYW5kb21fZ2V0X2Vu
dHJvcHkodm9pZCkNCj4gPiArew0KPiA+ICsJaWYgKHVubGlrZWx5KGNsaW50X3RpbWVfdmFsID09
IE5VTEwpKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsJcmV0dXJuIGdldF9jeWNsZXMoKTsNCj4g
PiArfQ0KPiA+ICsjZGVmaW5lIHJhbmRvbV9nZXRfZW50cm9weSgpCXJhbmRvbV9nZXRfZW50cm9w
eSgpDQo+ID4gKw0KPiA+ICAjZWxzZSAvKiBDT05GSUdfUklTQ1ZfTV9NT0RFICovDQo+ID4gDQo+
ID4gIHN0YXRpYyBpbmxpbmUgY3ljbGVzX3QgZ2V0X2N5Y2xlcyh2b2lkKQ0KPiANCj4gUmV2aWV3
ZWQtYnk6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJkYWJiZWx0QGdvb2dsZS5jb20+DQo+IA0KPiBJ
J20gZ29pbmcgdG8gd2FpdCBmb3IgRGFtaWVuIHRvIGNoaW1lIGluIGFib3V0IHRoZSBOVUxMIGlu
aXRpYWxpemF0aW9uIGJvb3QNCj4gZmFpbHVyZSwgdGhvdWdoLCBhcyBJJ20gYSBiaXQgd29ycmll
ZCBzb21ldGhpbmcgZWxzZSB3YXMgZ29pbmcgb24uDQo+IA0KPiBUaGFua3MhDQoNCkZvciBLZW5k
cnl0ZSwgbm8gcHJvYmxlbXMuIEJvb3RzIGNvcnJlY3RseS4NCg0KVGVzdGVkLWJ5OiBEYW1pZW4g
TGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEB3ZGMuY29tPg0KDQoNCg0KLS0gDQpEYW1pZW4gTGUgTW9h
bA0KV2VzdGVybiBEaWdpdGFsDQo=
