Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80822BA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGWXhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 19:37:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:53544 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgGWXhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:37:09 -0400
IronPort-SDR: E8Nem53cDG7BLUtuGbH1Fl0e7iHd55ghxFkK+cpwpHgVhzyhGPXJzPsoVLFCq2DBNwjKVqjxEV
 Gg+A7e6wsK8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148129130"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="148129130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 16:37:08 -0700
IronPort-SDR: Aa3PeUdwhcF9fjYuxs2gLqfNC/tsLchsMuchqGDQ6gXp5VNtiOycI+Pz7/yCWqj3YYrvyXuxcu
 gCVZaVNha6oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="271190345"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2020 16:37:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jul 2020 16:37:08 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Jul 2020 16:37:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jul 2020 16:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP4NKacQRLmxGa1DN5/2kPbst8/xv1eQuqnbXa1EPoNopN3BzjBgEWUXULO5AQNE414ppHNY58UcjBmcQRN6pBELZ/vnhfvI+a7SuKeJYYMELUCyCbb55CZGiapxwHuT7+kutFFZ1URXJiRxCberSJ7aSjw0HrXhxHOjbqn6yHQk8wD2qbfN38UfCstkkhFxkJxfyM2FBXlE8SucbEpMj+w5Q6/r1DdMmUKlZ/eZmAE9yAfwlJBC7aLosKtHbIP5ymR1ecy6R8K7RwuxeEQsi6/BZSTVny+2/kSNZIkyt17nAGn8XUHpdeQrodSKbgo47TKmlfVurZdMCXWpkLxBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DvkAOOGDKiSzmeTJa1ruO00GaH+B80rbalOh4beMUg=;
 b=VwNAgd+sHWfes0HnNnZnRPMfdIGM/N8NHeUYx7ljShD/xp9re1TJqULfrfJxjXE3kEhuUAWnYpv8ntmTKRY+J7J2p/tSUofhvtwOhNUqSnW345asP+TJGhRKZF6Jf4733+AykiMmqWvSjQSKrIa16k1vQ855hcIX3HfWACzahgTPVS1ljLemv+4c4iGJ0iujG18Svz+8D4506Vefh3YJDKl8VS/U9jD98T/I0MGlOOeN/qkfnAAE05ZmU1eSKRW3CqGm7X+52PGlwCQ1QybmpGbetPaYN3gmuX034E1dgZzXvzDPa/86w8ryFYPwfHewZ0vlxNXFUZAPDJTdnebSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DvkAOOGDKiSzmeTJa1ruO00GaH+B80rbalOh4beMUg=;
 b=h5HNvtYZkg4TXAtZ1na+QUwHJQICLTg3y1qHqFSD6Ccyr+27vc4I5Cu1EHmzs6JVBb4v+LEtb4nJlFy/zuVWVtE4A7oXj8vFLs2SnyBq9j34xAPjKu2mF7l0//ikOYnH76ibAlEU5HKvnJHYUOYscncxhB3gRe2ddZZbl7W3zRA=
Received: from BY5PR11MB4307.namprd11.prod.outlook.com (2603:10b6:a03:1bd::27)
 by BYAPR11MB3061.namprd11.prod.outlook.com (2603:10b6:a03:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Thu, 23 Jul
 2020 23:37:04 +0000
Received: from BY5PR11MB4307.namprd11.prod.outlook.com
 ([fe80::81b2:faf6:4cc3:261a]) by BY5PR11MB4307.namprd11.prod.outlook.com
 ([fe80::81b2:faf6:4cc3:261a%4]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 23:37:04 +0000
From:   "N, Harshapriya" <harshapriya.n@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "lma@semihalf.com" <lma@semihalf.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        "brndt@google.com" <brndt@google.com>
Subject: RE: [PATCH] ASoC: Intel: boards: eve: Fix DMIC records zero
Thread-Topic: [PATCH] ASoC: Intel: boards: eve: Fix DMIC records zero
Thread-Index: AQHWVgVCJ6cYJwv8qU6GKHbz4TPwQqj/dt+AgBYtr3A=
Date:   Thu, 23 Jul 2020 23:37:04 +0000
Message-ID: <BY5PR11MB430737AAF999E8308B3AD065FD760@BY5PR11MB4307.namprd11.prod.outlook.com>
References: <20200709152526.15764-1-vamshi.krishna.gopal@intel.com>
 <79866874-1ec3-50a1-1034-39bc116264fd@linux.intel.com>
In-Reply-To: <79866874-1ec3-50a1-1034-39bc116264fd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.23.139.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a572af4-44ea-4fda-d19f-08d82f614e84
x-ms-traffictypediagnostic: BYAPR11MB3061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB306113ABAC6F6EBA0DBDAD74FD760@BYAPR11MB3061.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:304;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 015utVZfren+aiYSpIAJhb+ntosA3M2DePDDpbN3tU6RZiDMblrdwalqesV/suSsLBMvAYGBz2okaUv+PufaH6GZK2CzI3WVa+/qrXM6xXSIeBVXAd9F/LdEkjsOzyNdqB1/Ks6EhfKGKhk0fNk+9NJKDfSoha43y786L+FPoHRJnv5vqyRvva0X2nY1uHsu6ffj9VFfKhbNl9GnjK4f/J1/ARcN2/DQyrqrcCQm48bQ82penySornEI+X5Dwy5QBKUqxqxoNllnE2Qu38imj9XnosjkuidrXqYu1omo+aF2T/Xw1wZwiG8g4Mz1GmoDncQqlOnM8iL/AbhwzQgfKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(76116006)(8936002)(8676002)(71200400001)(64756008)(66446008)(66946007)(2906002)(83380400001)(66556008)(66476007)(6506007)(9686003)(33656002)(316002)(54906003)(5660300002)(110136005)(55016002)(52536014)(478600001)(186003)(26005)(86362001)(7696005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: j1Oyu2x1CAmYOPtPET70KSuIv+x6zM3yvBf3Z2E/GFYHf1vXyzo50BLBVuYyA2R+9qpNWYtl3NMmKwWdelfm+mgDOQY58m/GFVrXRKV0V1ROF04u/IPdzD9Vd2lNwrwBfXOVuDDywx7QEvVraHpVVkqA2xuLHvlZ4YFtKLRRDKlWVrOQzyAKcWRQKyqExvh5cJQMTLjoGAkIMdUDACGkL+2+8ce0OsAZxEw6J8tAY9XfVjluCB9B6ghD1CoSe99yj/TgtDiHMLCM5Syf5H7vPpqpWO/b+5/Ns56DmkaWeCbrQdemdLJl3sWrGsJdWvDDB5NT9ehwvH/7uW4b5+7qulpLBL6DkpR5aNJYcNUk8gZpho38Hjjb4vssLoVobQZLyVx76myzH5WeyFvLtwe5IJlOjpVYA1MNRvWnfjc5hI5pb4An9l0IcvE13LWmPliVN12BzmJRXFLmZF1N0OK6NbZ3bLrxae29bRJBnupsNAuyi5K7aQYAD0unEjXmlmHx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a572af4-44ea-4fda-d19f-08d82f614e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 23:37:04.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MFvHOM3+P0jtqdCiHH+z2HBKfcrLzoopVhtdbTySk1xCL0uh6mZf+kBncxuWJ4RzRrW+YqGAthaikjQ5jVFNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3061
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICAgLi4uL2ludGVsL2JvYXJkcy9rYmxfcnQ1NjYzX3J0NTUxNF9tYXg5ODkyNy5jIHwgMTUw
ICsrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEwMiBpbnNlcnRpb25z
KCspLCA0OCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvaW50
ZWwvYm9hcmRzL2tibF9ydDU2NjNfcnQ1NTE0X21heDk4OTI3LmMNCj4gPiBiL3NvdW5kL3NvYy9p
bnRlbC9ib2FyZHMva2JsX3J0NTY2M19ydDU1MTRfbWF4OTg5MjcuYw0KPiA+IGluZGV4IGIzNGNm
NmNmMTEzOS4uNTg0ZTRmOWNlZGMyIDEwMDY0NA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9pbnRlbC9i
b2FyZHMva2JsX3J0NTY2M19ydDU1MTRfbWF4OTg5MjcuYw0KPiA+ICsrKyBiL3NvdW5kL3NvYy9p
bnRlbC9ib2FyZHMva2JsX3J0NTY2M19ydDU1MTRfbWF4OTg5MjcuYw0KPiA+IEBAIC01Myw4ICs1
MywxMCBAQCBzdHJ1Y3Qga2JsX2NvZGVjX3ByaXZhdGUgew0KPiA+ICAgCXN0cnVjdCBzbmRfc29j
X2phY2sga2FieWxha2VfaGVhZHNldDsNCj4gPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGhkbWlfcGNt
X2xpc3Q7DQo+ID4gICAJc3RydWN0IHNuZF9zb2NfamFjayBrYWJ5bGFrZV9oZG1pWzJdOw0KPiA+
IC0Jc3RydWN0IGNsayAqbWNsazsNCj4gPiAtCXN0cnVjdCBjbGsgKnNjbGs7DQo+ID4gKwlzdHJ1
Y3QgY2xrICpzc3AwX21jbGs7DQo+ID4gKwlzdHJ1Y3QgY2xrICpzc3AwX3NjbGs7DQo+ID4gKwlz
dHJ1Y3QgY2xrICpzc3AxX21jbGs7DQo+ID4gKwlzdHJ1Y3QgY2xrICpzc3AxX3NjbGs7DQo+IA0K
PiBUaGUgZGVmaW5pdGlvbiBvZiBhIHBlci1TU1AgTUNMSyBpcyBqdXN0IHdyb25nLiB0aGVyZSBh
cmUgMiBNQ0xLcyByZWdhcmRsZXNzIG9mDQo+IHRoZSBudW1iZXIgb2YgU1NQcywgdGhpcyBzaG91
bGQgYmUgTUNMSzAgYW5kIE1DTEsxLg0KPiANCj4gSXQgcHJvYmFibHkgd29ya3MgaW4geW91ciBj
YXNlIHNpbmNlIHlvdSBoYXZlIDIgU1NQcywgYnV0IHRoZSBTa3lsYWtlIGRyaXZlcg0KPiBleHBv
c2VzIHNzcDIuLjVfbWNsayBjbG9ja3MgdGhhdCBkb24ndCBleGlzdCBpbiBoYXJkd2FyZS4gT2gg
d2VsbC4NCj4gDQo+IElmIHlvdSBkb24ndCBtaW5kIEknZCBwcmVmZXIgaXQgaWYgeW91IHVzZWQg
bWNsazAgYW5kIG1jbGsxIGFuZCBkcm9wIHRoZSBzc3BfDQo+IHByZWZpeC4gWW91IGNhbiBzdGls
bCB1c2UgdGhlICJzc3AwX21jbGsiIGFuZCAic3NwMV9tY2xrIiBzdHJpbmdzIHdoZW4gY2FsbGlu
Zw0KPiBkZXZtX2Nsa19nZXQoKSwgYnV0IHRoYXQgd2F5IGlmIHRoZSBTa3lsYWtlIGRyaXZlciBp
cyBmaXhlZCBhdCBzb21lIHBvaW50IHdlIHdpbGwNCj4gbm90IGhhdmUgdG8gY2hhbmdlIHRoZSBj
b2RlIGluIHRoaXMgZHJpdmVyLCBvbmx5IHRoZSBjbG9jayBuYW1lcy4NClRoZXJlIGlzIGFjdHVh
bGx5IGp1c3Qgb25lIG1jbGsgaW4gdGhpcyBwbGF0Zm9ybS4gT25seSB0aGUgc2NsayByYXRlIHRv
IGJlIGFwcGxpZWQgaXMgZGlmZmVyZW50IGZvciBkaWZmZXJlbnQgY29kZWNzLg0KVGhlIG5hbWVz
IGFyZSBtaXNsZWFkaW5nLiBJdCBsb29rcyBsaWtlIHRoZXJlIGFyZSBkaWZmZXJlbnQgY2xvY2tz
IGZvciBkaWZmZXJlbnQgU1NQLiANCndlIHNoYWxsIHBvc3QgYSBuZXcgcGF0Y2ggZml4aW5nIHRo
aXMuDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBAQCAtNzU3LDYgKzgwMCwyOSBAQCBzdGF0aWMgc3Ry
dWN0IHNuZF9zb2NfY2FyZCBrYWJ5bGFrZV9hdWRpb19jYXJkID0gew0KPiA+ICAgCS5sYXRlX3By
b2JlID0ga2FieWxha2VfY2FyZF9sYXRlX3Byb2JlLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICtzdGF0
aWMgaW50IGthYnlsYWtlX2F1ZGlvX2Nsa19nZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBj
aGFyICppZCwNCj4gPiArCXN0cnVjdCBjbGsgKipjbGspDQo+ID4gK3sNCj4gPiArCWludCByZXQg
PSAwOw0KPiA+ICsNCj4gPiArCWlmICghY2xrKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsNCj4gPiArCSpjbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCBpZCk7DQo+ID4gKwlpZiAoSVNfRVJS
KCpjbGspKSB7DQo+ID4gKwkJcmV0ID0gUFRSX0VSUigqY2xrKTsNCj4gPiArCQlpZiAocmV0ID09
IC1FTk9FTlQpIHsNCj4gPiArCQkJZGV2X2luZm8oZGV2LCAiRmFpbGVkIHRvIGdldCAlcywgZGVm
ZXIgcHJvYmVcbiIsIGlkKTsNCj4gPiArCQkJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQo+ID4gKwkJ
fQ0KPiA+ICsNCj4gPiArCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgJXMgd2l0aCBlcnI6
JWRcbiIsIGlkLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+IA0KPiBuaXQtcGljazogeW91
IGNhbiByZW1vdmUgdGhpcyByZXR1cm4gc2luY2UgeW91IGFscmVhZHkgaGF2ZSBvbmUgdHdvIGxp
bmVzDQo+IGJlbG93Lg0KYWNrDQo+IA0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7
DQo+ID4gK30NCj4gPiArDQoNCg==
