Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207622CB3A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgLBEBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:01:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:29848 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgLBEBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:01:07 -0500
IronPort-SDR: W7poaFm75gAOJ0g72q/H1GYdZpzg1M1uM79nExtOEG3ap/xpSMlwJQ8LAFxHKqgfmyPYzXnf20
 25HwrdXid7oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169447029"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="169447029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 20:00:20 -0800
IronPort-SDR: dOel0IYDXNr0EDTQ6k2yFppzx+MAay0k3q3qNmUBGQDSj571HLUpFt2i24U1q8wt5FbP9bD3wY
 91FAT5Qrp4dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="365113358"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 01 Dec 2020 20:00:18 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Dec 2020 20:00:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Dec 2020 20:00:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 1 Dec 2020 20:00:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 1 Dec 2020 20:00:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S60J7Ql7N2KLJmLHPRzvIfwTcGi4vKzbhWJctHrZeZd6WlWZ794EJXBOuPPDgtz+kHK2IAAFj71o1qcPtZdWmQvACErCd/YqI1PivshjtZA9YkO9nThdjZT7hFTLDmnvfbLwp/uMbmkc9QMEtmvf4j5k8RKfPPDC1772CHW83sNzUrR3u2tmGsqEfxsCz6Vfsu+sWzWpuVzgPqSOSCRa/FntEXu/dV+LrjCjzPdkZGNQJi3p1HeydT6baAplGG1K3wQiNprbkCjkj7Q9tN42dd/kzDvbuXtZ1GuAKxcS3wDx59n8iaeCsYT6dDpJr6i0ZDXaus+oENP4qIbsczAl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM0HklOBHSnRAMX2A+swtrjKuUuluc5CFAJeeXKRo88=;
 b=j7gYaDeS9imRegqy92pX0+g0hQyg7kyTEeMlyxp431hjzgkwRM8q7JyS7NOsQEtDCI8pTSXaCZXGI2RG0f1l0W5VwER0kqpmK9B1hkfyjb41QslpS033PljHaqsOC6c4g6qLeVXRFEcT93fi21cEuP3uQNwoulNdI8Ua8/IzCI/m4cG5OMQn177ZWvMVt4YrMJRiH1TJ3f/ynfgMI8Q1SO/3C/aD/vI46LH52YIydhdh12XFyvMb6A4UAa3GQHkc6exvgM+k6CNpln3FddNIdyizWChULY0PN8pshWtvrsAGsODtHMXL6eCK6KvFcc1AKoHIJ5QrJ1CnLKZLkoarSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM0HklOBHSnRAMX2A+swtrjKuUuluc5CFAJeeXKRo88=;
 b=zqApGCjOo5smmXscmYqSkmmkloNgRGU7fxJq7wQQOFP9llVNr3c3vL+4Q6lzFn2At8Vx4QtVUvm5JsrxItJW6FIIS0ZcqTrrJkVQ1uM82CzJNPiieR7uwSbzgL75e/z4cXg6rdIqNuKmnSOn3y7fQOml6bfnEboXLrGZoUbjKRo=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4449.namprd11.prod.outlook.com (2603:10b6:a03:1cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 04:00:15 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 04:00:15 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
Thread-Topic: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
Thread-Index: AQHWvsznQG60NzoojESgLM5m/NNfkqnQeGSAgAcnjACAAAMugIALno4A
Date:   Wed, 2 Dec 2020 04:00:15 +0000
Message-ID: <A7AD8A0D-0346-4B25-A2C8-283E59D422EF@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-16-chang.seok.bae@intel.com>
 <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
 <246DCF46-D7F4-4F68-ADF8-2F694FEFD2AC@intel.com>
 <CALCETrXjgB_QXumQr+AgZx5O5SDv25yiVuDkFuCk9ZRDP6VoKQ@mail.gmail.com>
In-Reply-To: <CALCETrXjgB_QXumQr+AgZx5O5SDv25yiVuDkFuCk9ZRDP6VoKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [112.148.21.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9f62102-5da3-4580-6712-08d89676c68f
x-ms-traffictypediagnostic: BY5PR11MB4449:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4449FFF189CF2A46F0F35D87D8F30@BY5PR11MB4449.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaEtKoT4yy8ItXDn36Nvs4lrKNZ6oMOFBsowkQMWUVpz2m1wkBlH88tcl8g/o8Qe4I9bebgWfh2jmX+7/2qN6cgLnwEY01VbZquNOM9B3E3beBu9b8jdL26BVTGFGc6crXKi6PIWR2i2zRqQ14F39/6KmqqKwJ9CT0sPzlP9wTv5GivljVdaNdDM2mOGhRIE8jLjTt/DSNfYdCfxPpoq/V93jHAEG1AvIsINtquwZmI+HLlGTeQd+LqYdjeI8U3EonrGe+BdnXeqA3NWCB/C7cYJvjD1fPyxwU5eA9rS/OhiVJJOoeiDuRRro0yyyePY80cb4LuK1MNEOae7kdJFDZZqp6vT6JFrMcDeAub8OyeXSjW0wCNUGLjsOyHxiwNmHT2qRT5EA2PLWF7dSkpaayzz9TIix4UVlAQhUDedUBQMHjLxOsgWN3zdY5Xn4eOjUSMZ2gqOtREAZPu1wl9Wjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(76116006)(6486002)(64756008)(66556008)(66446008)(5660300002)(36756003)(71200400001)(6512007)(66946007)(6916009)(66476007)(33656002)(316002)(54906003)(8676002)(2906002)(83380400001)(8936002)(186003)(53546011)(6506007)(2616005)(26005)(86362001)(966005)(4326008)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eEltWWEyc0R5TnRGZ2JZOUU5OEVabEhMeGpjczVMS0VlbHhFQjZ5YklUREwv?=
 =?utf-8?B?UUFQQXVSK1VWQ1QzbURKTUEwWmU5OGtQa0oxN2hXV3VEQ295OVNtNitOVnNH?=
 =?utf-8?B?aW9IQ0FzZW5TTWZMNkE0TGJPNUMzVCtzbXNFTU5MWUJINzBtbXVITWtQaDhU?=
 =?utf-8?B?c1FLQ3dCeFJ2UmFDQ0xvdGNrV2RIV3ozWXg1QjVsR2t1QytQdHNPRnN0M1A1?=
 =?utf-8?B?aVV1d0tWUG9Ha1JJY1pqS2FRL1dlRXAwR1R1ZktIYTVHaWNSaEFvN2VIWGtJ?=
 =?utf-8?B?QVNEMXlGSFhqbnAxM0lRNzF5OWJ4aDB4NUtFSkx1Q0R6WkxEU0JDN09kVWRR?=
 =?utf-8?B?NnduaEo1dEtzQ0tGWk1GU1NBVExML2xEWXY2YWZDZm9JVXgrRHJCc3Zna0wy?=
 =?utf-8?B?T2QzcVJXZ0VjbHVyZkdvY0I5OTJuVmxQYTRrd21Rd0hrdFdrdU5mNDJmZEFq?=
 =?utf-8?B?YXZQbTVRazl3SEdDS2R2ajNveGdCbUkwREQzaFhWeGEvQmJlL09KYjNyTVFw?=
 =?utf-8?B?MnpOQ1VOVVpIMVdEb1Q1bloxVHNFOG1NVXVpdm4wcjhiQkV4TmxwaW9zcGhL?=
 =?utf-8?B?OVc0ZCtjK0o3dE1venBPUk8yWW9hb1NSSXdZWjgyUEZZeGQwVXQzN09zM1Iv?=
 =?utf-8?B?b2kvSXMvb2VsS0ZBbjJONzJaTnY2WHB6Zy9qS2xweEdiaVlSWDF0NjF6NGtH?=
 =?utf-8?B?aWpxNU5XUnRkSWtBNnQwQ0lQUkd4QWF4VjVmZG11SkdEMVFGaHJFTDN6aEZ5?=
 =?utf-8?B?Y1M1MFdpWmZPU0JKemIwUHZqdWJaa28vOTFYMVl6WnFBcXplWVAvTFdwZitE?=
 =?utf-8?B?T1grbnNxUHZ0VWlweTcrM0RkaFdGM1BPVFdiNWs1aGVSSXZGNTREQk0vM1l6?=
 =?utf-8?B?bHBRSHVUWENTNTVXYUxzQXQ0MHVVeXlPakVIQVFxMGlqekJEMTBOa240b0pO?=
 =?utf-8?B?aitTWkdMd3V6c216b0RHdGZRR2Frb0cxa3RDTEx0QVNKSGpsNHFLU0RJSHlv?=
 =?utf-8?B?OVgyRVQwUXFTU2JhdGlzZUQ1UW13VVIyREtCYmpxTGlpVzI3M1RXWkZNTElK?=
 =?utf-8?B?NVVHRkVVRGlpSDNvVk9GNzB2djdzZE84c0FqODByZFZhU0RhSXFTNGk0OHI0?=
 =?utf-8?B?NzRJRUtrV1Fad1NQY3Y0em15UFVwU25Gd2VMeGZndU1sR2dyNTB0SnNHdG1T?=
 =?utf-8?B?UEZyZERnS214VkNDSUxFYWVBY25IYm1zaEpOYWhUR0I1OHZLdTZXcWhQSDFr?=
 =?utf-8?B?VEoxbVdCdGJKa214Mi9TVlZCQTloUTkxaVZCYUMrZ1NLVjQ3K1Z3NzIxL0dx?=
 =?utf-8?Q?XVDE5cYf8K3kxptx2iv8qFb4TdlaeHM5Bm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5515CEDB3D968445B7FDDE399B0901E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f62102-5da3-4580-6712-08d89676c68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 04:00:15.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IVM7m1NAauXLCraC6M9vI02zstsUtzeoJCZTPylSHcCUZeMp/MIoWyRwnfNU9CRKbJ7fNbTNZc3MloPIEDVwp867lfgPiiJTGD/zDZJKYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4449
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE5vdiAyNSwgMjAyMCwgYXQgMDM6MzMsIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTm92IDI0LCAyMDIwIGF0IDEwOjIyIEFNIEJh
ZSwgQ2hhbmcgU2Vvaw0KPiA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+IA0K
Pj4gDQo+Pj4gT24gTm92IDE5LCAyMDIwLCBhdCAyMTowNywgQW5keSBMdXRvbWlyc2tpIDxsdXRv
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFRodSwgTm92IDE5LCAyMDIwIGF0IDM6
MzcgUE0gQ2hhbmcgUy4gQmFlIDxjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20+IHdyb3RlOg0KPj4+
PiANCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5j
IGIvYXJjaC94ODYva2VybmVsL2ZwdS9yZWdzZXQuYw0KPj4+PiBpbmRleCA4ZDg2MzI0MGI5YzYu
LjZiOWQwYzBhMjY2ZCAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2ZwdS9yZWdz
ZXQuYw0KPj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5jDQo+Pj4+IEBAIC0x
MjUsNiArMTI1LDM1IEBAIGludCB4c3RhdGVyZWdzX3NldChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRh
cmdldCwgY29uc3Qgc3RydWN0IHVzZXJfcmVnc2V0ICpyZWdzZXQsDQo+Pj4+IA0KPj4+PiAgICAg
ICB4c2F2ZSA9IF9feHNhdmUoZnB1KTsNCj4+Pj4gDQo+Pj4+ICsgICAgICAgLyoNCj4+Pj4gKyAg
ICAgICAgKiBXaGVuIGEgcHRyYWNlciBhdHRlbXB0cyB0byB3cml0ZSBhbnkgc3RhdGUgaW4gdGFz
ay0+ZnB1IGJ1dCBub3QgYWxsb2NhdGVkLA0KPj4+PiArICAgICAgICAqIGl0IGR5bmFtaWNhbGx5
IGV4cGFuZHMgdGhlIHhzdGF0ZSBhcmVhIG9mIGZwdS0+c3RhdGVfcHRyLg0KPj4+PiArICAgICAg
ICAqLw0KPj4+PiArICAgICAgIGlmIChjb3VudCA+IGdldF94c3RhdGVfc2l6ZShmcHUtPnN0YXRl
X21hc2spKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgb2Zmc2V0LCBzaXpl
Ow0KPj4+PiArICAgICAgICAgICAgICAgc3RydWN0IHhzdGF0ZV9oZWFkZXIgaGRyOw0KPj4+PiAr
ICAgICAgICAgICAgICAgdTY0IG1hc2s7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgICAgICAgIG9m
ZnNldCA9IG9mZnNldG9mKHN0cnVjdCB4cmVnc19zdGF0ZSwgaGVhZGVyKTsNCj4+Pj4gKyAgICAg
ICAgICAgICAgIHNpemUgPSBzaXplb2YoaGRyKTsNCj4+Pj4gKw0KPj4+PiArICAgICAgICAgICAg
ICAgLyogUmV0cmlldmUgWFNUQVRFX0JWICovDQo+Pj4+ICsgICAgICAgICAgICAgICBpZiAoa2J1
Zikgew0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICBtZW1jcHkoJmhkciwga2J1ZiArIG9m
ZnNldCwgc2l6ZSk7DQo+Pj4+ICsgICAgICAgICAgICAgICB9IGVsc2Ugew0KPj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSBfX2NvcHlfZnJvbV91c2VyKCZoZHIsIHVidWYgKyBvZmZz
ZXQsIHNpemUpOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4+ICsgICAgICAg
ICAgICAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgICAgICAgIG1hc2sgPSBoZHIueGZlYXR1
cmVzICYgeGZlYXR1cmVzX21hc2tfdXNlcl9keW5hbWljOw0KPj4+PiArICAgICAgICAgICAgICAg
aWYgKCFtYXNrKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IGFsbG9jX3hz
dGF0ZV9hcmVhKGZwdSwgbWFzaywgTlVMTCk7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IGlmIChyZXQpDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCj4+Pj4gKyAgICAgICAgICAgICAgIH0NCj4+Pj4gKyAgICAgICB9DQo+Pj4+ICsNCj4+PiAN
Cj4+PiBUaGlzIHdob2xlIGZ1bmN0aW9uIGlzIGdhcmJhZ2UuICBUaGUgY291bnQgcGFyYW1ldGVy
IGlzIGVudGlyZWx5DQo+Pj4gaWdub3JlZCBleGNlcHQgdGhhdCB0aGUgYmVnaW5uaW5nIG9mIHRo
ZSBmdW5jdGlvbiBjb21wYXJlcyBpdCB0byB0aGUNCj4+PiBjb25zdGFudCBrbm93biBzaXplLiAg
Tm93IHRoYXQgaXQncyBkeW5hbWljLCB5b3UgbmVlZCB0byBhY3R1YWxseQ0KPj4+IHZhbGlkYXRl
IHRoZSBjb3VudC4gIFJpZ2h0IG5vdywgeW91IHdpbGwgaGFwcGlseSBvdmVycnVuIHRoZSBidWZm
ZXIgaWYNCj4+PiB0aGUgbWFzayBpbiB0aGUgYnVmZmVyIGlzbid0IGNvbnNpc3RlbnQgd2l0aCBj
b3VudC4NCj4+IA0KPj4gSW4gcHJhY3RpY2UsIGNvcHlfe2tlcm5lbHx1c2VyfV90b194c3RhdGUo
KSBpcyB0aGUgY29weSBmdW5jdGlvbi4gSXQgYWN0dWFsbHkNCj4+IHJlbGllcyBvbiB0aGUgbWFz
ayBbMV0sIHJhdGhlciB0aGFuIHRoZSBjb3VudC4gSWYgdGhlIHN0YXRlIGJpdCBub3Qgc2V0IGlu
IHRoZQ0KPj4gbWFzaywgdGhlIHN0YXRlIGlzIG5vdCBjb3BpZWQuDQo+PiANCj4+IFRoaXMgcGF0
aCBtYXkgYmUgYmV0dGVyIHRvIGJlIGNsZWFuIHVwIGZvciByZWFkYWJpbGl0eS4gV2UgY2FuIHRy
eSB0byBjbGVhbnVwDQo+PiBpbiBhIHNlcGFyYXRlIHNlcmllcy4NCj4+IA0KPj4gQWxzbywgSSB0
aGluayB0aGUgc2VyaWVzIG5lZWRzIHRvIGVuYWJsZSBYRkQgb25seSB3aXRoIFhTQVZFUyAtLSB0
aGUgY29tcGFjdGVkDQo+PiBmb3JtYXQgdXNlZCBpbiB0aGUga2VybmVsLg0KPiANCj4gSSBkaXNh
Z3JlZS4gIEJlZm9yZSB5b3VyIHBhdGNoLCBpZiB5b3UgcGFzc2VkIGluIGEgZml4ZWQtc2l6ZSBi
dWZmZXINCj4gd2l0aCBhcmJpdHJhcnkgZGF0YSwgdGhlIHdvcnN0IHRoYXQgY291bGQgaGFwcGVu
IHdhcyBjb3JydXB0aW9uIG9mIHRoZQ0KPiB0YXJnZXQgcHJvY2Vzcy4gIFdpdGggeW91ciBwYXRj
aCwgaWYgeW91IHBhc3MgaW4gYSBmaXhlZC1zaXplIGJ1ZmZlcg0KPiB3aXRoIHRvbyBtYW55IG1h
c2sgYml0cyBzZXQsIHRoZSBzeXNjYWxsIHdpbGwgb3ZlcnJ1biB0aGUgYnVmZmVyLg0KDQpUcnVl
LCB1c2VyIHNwYWNlIHByb3ZpZGVzIGEgZml4ZWQtc2l6ZSBidWZmZXIgaW4gYW4gdW5jb21wYWN0
ZWQgZm9ybWF0DQotLSB0aGUgc2l6ZSBzaG91bGQgYmUgZW5vdWdoIHRvIGNvdmVyIHN0YXRlcyBz
ZXQgaW4gWENSMCBbMV0uIA0KDQpIZXJlLCB0aGUgY29kZSBvbmx5IGNhcmVzIHN0YXRlcyBzZXQg
aW4gWENSMDsgdGhlIG1hc2sgYml0cyBub3Qgc2V0IGluIFhDUjAgZG8NCm5vdCB0cmlnZ2VyIHRo
ZSBleHBhbnNpb24uIEkgZG9u4oCZdCBnZXQgdGhlIGJ1ZmZlciBvdmVycnVuLg0KDQpUaGFua3Ms
DQpDaGFuZw0KDQpbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC94ODYva2VybmVsL2ZwdS9yZWdzZXQu
YyNuMTIw
