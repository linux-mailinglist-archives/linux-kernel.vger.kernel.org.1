Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C482FAEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437065AbhASC5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:57:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:15141 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388135AbhASC5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:57:25 -0500
IronPort-SDR: kFdYqjrZTyQvo6UkbFAz+6H0iYDvUdda6zpRjwCaDAswU7VCFn0lWBOGGFwNgu8nJv6dnWUbuC
 734i7s0LuGTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158643259"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="158643259"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 18:56:40 -0800
IronPort-SDR: bj91dWxvSyk4qZE7ygcUEHG++rUBISZPXurd7R1aTkqfCkOZPLVCrT8L9sdZu72KaetokhKdmX
 LeGQJ0qbqOUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="570868080"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jan 2021 18:56:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 18:56:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 18 Jan 2021 18:56:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 18 Jan 2021 18:56:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOUckROwkKBRtT8ospNdtjEg92V1Ox8cqJDx+L0GpW5XszLOhiCrOt39K9dq+wr1Kam15G8RjRAWWuTlDOGDVKh4nZHyR+0SrQvEmWIVZTOiZ/t6L0FN9hKbK4+FrKMFmgWlaRWWYVep0Fp1Csye1XZ1mTjwoHiQm8zeZ+FLhN20hWT64UKc2BBsxwwduIU6cxF6T8kSpbyqAnfmRr5SQNJIcNE6i/Z5e4TqlRyyfuB2dHb4UkI5GUUe1AfXjUmpTq1jsXyFL5wTlJxSS3benMAJxL69DHMT14Mmm6JbVzVp+jmQlWKUA2LTUB63zAUE15OlI50AzIeZs2be9Nnpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW8eXrxTPVs8fTGvnrRDX7SyRuThwhxIol30TzuCY0w=;
 b=l9qxUseLi6AbqKVdd5TI9inxo4KZNPpNRgHk9nJqG7a5GI8OHDLtsWJyfuqyekf3RkaCvATjsGJgYiU9kpWtEYPBpwX2H/oCMco/818/DZhiNo0vYwgOyv0kG1E5nV3q98MeelWIKHoAv/jNKqPGB8y41dQXiZa8siN23yl87XS+d6P1AHs8HsGhovsx1+0RZAJyK2EgwaxyoQj0BAV/aSvuRy+5mkxDshoLD23o79GDHg2DSgKnxpKtTf2koruZPsvSrtu+tG3Rzzo5kkjccQCH8sfkoXWyGpH5LF5m4OzFfS6+sG6LvfzDtYM7sFFlgxnywds5e4Gqt6o0SbR2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW8eXrxTPVs8fTGvnrRDX7SyRuThwhxIol30TzuCY0w=;
 b=QG1FLhgpHRVSrnkdGRHM3a4PpqIvustde9h/CULSlHRSaJU/JT2J6MPMnKm0BN8zVhJIYElOHvczE5oaihvjJ9VAqfkAgy01L+kiwEJNgAeEsJD5yIGb4kOhUKk40LZopa4V+43d0eC9JSiXvhpq8ZygDQHNDgu8ozkoq6pC4p8=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB2953.namprd11.prod.outlook.com (2603:10b6:5:6a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Tue, 19 Jan
 2021 02:56:36 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:56:36 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Seow, Chen Yong" <chen.yong.seow@intel.com>
Subject: RE: [PATCH v2 2/2] clocksource: Add Intel Keem Bay Timer Support
Thread-Topic: [PATCH v2 2/2] clocksource: Add Intel Keem Bay Timer Support
Thread-Index: AQHW3m7asVhecswsxk6nGZbrzXIbyqotqAuAgACyd4A=
Date:   Tue, 19 Jan 2021 02:56:36 +0000
Message-ID: <DM6PR11MB4250EB33E23178D211D0411DFBA30@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <2a7038bc170e31a668995c367bbae018bf805dbe.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <73330c8b-4633-4a13-b4b5-7405ff1661fe@linaro.org>
In-Reply-To: <73330c8b-4633-4a13-b4b5-7405ff1661fe@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.176.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0101ea7-e27b-4f89-dc45-08d8bc25d5ef
x-ms-traffictypediagnostic: DM6PR11MB2953:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2953C6D9BEB6936AFB750F91FBA30@DM6PR11MB2953.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t/TeTs0GRS0+wchTDR5vIABuj/scTlBlLNR92t7oqViEXZ3YIUCOoqQmfRCeTCutYxLFKX3bwmriYuSU6aPj4mv66ayP+JJx/uSO23NT9pr/jT80zIQXJ+4mR0Lnm4Y1D8kfV2ug5U2pgyUimlWcSb2KsLLSTvT7GnDmx96I7HA543zqEXb+ireWmccpvJusbQaErtxrAiPKb1xQg74Q+o+UWBARpPw0gNR7Z5ozYspzikqGXrlcGYo1AvXk4k1BQ/yg52W0Smn21se5MvwWHBWQr8VqgjV8fTTQuKOXrmXFkXch2jQcXdrd/qKuAGeAWqB0uDwiWlPiHBfVXzRbQJP2YD2xqAtF26pwFRKgEyniPatKMqRaBV6miWaCVBtfL0Hwp4J13v812YJKeI0/peIDrt/lXzLhWjBbbakZvJU1ddA7xpa0J/ghiIBNaJ24oawuE3w7Ip2pHoHnIK37k9waYCjaTL9w9DmeghpseEUw7rdyfCnLBHmbjNFRFfIVS4F8sPx02KHm/xy52JDTaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(8676002)(66946007)(66476007)(66446008)(76116006)(64756008)(54906003)(66556008)(83380400001)(8936002)(71200400001)(26005)(316002)(33656002)(478600001)(186003)(6506007)(86362001)(7696005)(5660300002)(52536014)(4326008)(9686003)(55016002)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TnhXUmlhR2VUNEtEa3dNYmI0aWV5MlpmR3c2VXU5M0hhU1IwQVppTTRNalIy?=
 =?utf-8?B?c09jN1ROaVRnUTZ1eGZwV3VZSWVtSGVjZDFhc0orQXFhcWZscGhRRHowMi9q?=
 =?utf-8?B?Wm1qcngvYndtZGw1TnlyNGtqUVNTczZxVExPbUFZZS9HYktweHFuTXpHUWNB?=
 =?utf-8?B?eFNqdTMxN1lXOFYwb2d1UzBKdENjZGJoTzFDVUpkSldpNkwyMVNaRkh5b0VU?=
 =?utf-8?B?UzBTbnhNUmxzbnBzYjdkQ1RUWmRrMS9ZTG0za3NXRXRHYzlnM1VvNUhFMzl0?=
 =?utf-8?B?dXBxeGpHRVorMUlWdnpUbjdqMXI1dG9YVUY3OE4vcmdIQ0JnZ0pxZWhzRHJY?=
 =?utf-8?B?UVVkQ0lzYVdGcXpyMFZqalQrdW8yWVRVMFd4ZHZlaWVwVlZqeUhGR00rcGZL?=
 =?utf-8?B?N3JlSm9MaGtQN2thMDQxcUFoWC9DZmFlMHVFWGhzbXVjdWo0Zjg4UTRENTc0?=
 =?utf-8?B?OUg5S2taZDdWUndvQTFna1dkY2tNRUNWUXlwcnZaN1grSTIzZzlSZlJLZnJW?=
 =?utf-8?B?cDBMdC9xMHNsK1ZEeTJGYU5RUTFzamswckx1NnFYc3o1RHNnT2c0QTJUNU80?=
 =?utf-8?B?U3JpM1BsK253QUNZcUJ5T0p4OGFsVjR0UUNqcWVnbjM5MlFKUkJYazVpZ1Nm?=
 =?utf-8?B?cGlOY2JkNkJGR0IvTkx4dGR0MDQ4T2RjV1MzQVF6WGFBZjlMbVJpamZlN2p0?=
 =?utf-8?B?cm0yZHBjL1JaSHZkMHMxUnVYVDdYMktoMVFKN3dZYStFdzhpWkF1eUhiKzZR?=
 =?utf-8?B?ZWdRZWhoSWZwUWdnY05ublduQjhtMmx5MCtSRE54VXdPN1FOMVRrYWpROGZa?=
 =?utf-8?B?enp2OTRiSnBvRkJORU5aSC9zV0FuZUZJdENyYUV3WTRTejhvWkFNZXU3TExk?=
 =?utf-8?B?bEIrYlhqL1M2MGdKQk1BS2hOS3MrNzRneHAxSWw1Ym9BMnRhV1A3Z3NvWmJC?=
 =?utf-8?B?VXNsRUlzTGQ4ZFVmcnFBSzY1S3ljVU9jVnozQ2Y4ellDZ25zTWNxdFVPQWs3?=
 =?utf-8?B?TitUZkxZS2dOMmhrVzVzTlFSeVBpTXR2NXcxbmJJSXN1VjF0bTUvbGlPWlRN?=
 =?utf-8?B?ZWE3WWd3b0dEc281SDJJQ1RNelJ2b2R0ckthbDZ1Rnd6blpEdXRHT1NGMity?=
 =?utf-8?B?UW9EOEtZOXFpTVM2QTJkdlZIYVFtMjV2N3g2dXU5STVmRjU4OWdocFUrUXJE?=
 =?utf-8?B?aXlIUTRmQ0dkVWxCYUVPd3NjTGttUGlxOFV3REtLMitCTzB2aHFUek1xRjJP?=
 =?utf-8?B?dEVnSSt1dWZSeURMNStMS3Q4amRQOXhYTUVya1pmTGp2aDF3WG9OWDA0SEUx?=
 =?utf-8?Q?rk7b+R7ItqkyM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0101ea7-e27b-4f89-dc45-08d8bc25d5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 02:56:36.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baQuqQ6JpBa+4JUVdd8foHOBOZcVoIqlVBgetfIHW7B51xsfHl96/iROKGaXrEjtHFZJzV/vqDTiGaz1k0CLGcCkvo+TECc9oujpX05XOFflS5XDiqhseNGthGJ+MpTF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2953
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IEZyb206IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5h
cm8ub3JnPg0KPiA+IEZyb206IFZpamF5YWthbm5hbiBBeXlhdGh1cmFpIDx2aWpheWFrYW5uYW4u
YXl5YXRodXJhaUBpbnRlbC5jb20+DQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICtzdGF0aWMgc3Ry
dWN0IHRpbWVyX29mIGtlZW1iYXlfY2VfdG8gPSB7DQo+ID4gKwkuZmxhZ3MJPSBUSU1FUl9PRl9J
UlEgfCBUSU1FUl9PRl9CQVNFIHwgVElNRVJfT0ZfQ0xPQ0ssDQo+ID4gKwkuY2xrZXZ0ID0gew0K
PiA+ICsJCS5uYW1lCQkJPSAia2VlbWJheV9zeXNfY2xrZXZ0IiwNCj4gPiArCQkuZmVhdHVyZXMJ
CT0gQ0xPQ0tfRVZUX0ZFQVRfUEVSSU9ESUMgfA0KPiA+ICsJCQkJCSAgQ0xPQ0tfRVZUX0ZFQVRf
T05FU0hPVCAgfA0KPiA+ICsJCQkJCSAgQ0xPQ0tfRVZUX0ZFQVRfRFlOSVJRLA0KPiA+ICsJCS5y
YXRpbmcJCQk9IFRJTV9SQVRJTkcsDQo+ID4gKwkJLnNldF9uZXh0X2V2ZW50CQk9DQo+IGtlZW1i
YXlfdGltZXJfc2V0X25leHRfZXZlbnQsDQo+ID4gKwkJLnNldF9zdGF0ZV9wZXJpb2RpYwk9IGtl
ZW1iYXlfdGltZXJfcGVyaW9kaWMsDQo+ID4gKwkJLnNldF9zdGF0ZV9zaHV0ZG93bgk9IGtlZW1i
YXlfdGltZXJfc2h1dGRvd24sDQo+ID4gKwl9LA0KPiA+ICsJLm9mX2Jhc2UgPSB7DQo+ID4gKwkJ
LmluZGV4ID0gMCwNCj4gPiArCX0sDQo+ID4gKwkub2ZfaXJxID0gew0KPiA+ICsJCS5oYW5kbGVy
ID0ga2VlbWJheV90aW1lcl9pc3IsDQo+ID4gKwkJLmZsYWdzID0gSVJRRl9USU1FUiB8IElSUUZf
SVJRUE9MTCwNCj4gDQo+IElzIHRoZSBJUlFQT0xMIGZsYWcgcmVhbGx5IG5lZWRlZCBoZXJlID8N
Cj4gDQoNCk5vdCByZWFsbHkgbmVlZGVkLiBJIHdpbGwgcmVtb3ZlIHRoaXMgcmVkdW5kYW50IEZs
YWcgaW4gbXkgbmV4dCB2ZXJzaW9uLg0KDQo+ID4gK3N0YXRpYyBpbnQgX19pbml0IGtlZW1iYXlf
dGltZXJfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qg
a2VlbWJheV9pbml0X2RhdGEgZGF0YTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJZGF0
YS5iYXNlID0gb2ZfaW9tYXAobnAsIDIpOw0KPiA+ICsJaWYgKCFkYXRhLmJhc2UpDQo+ID4gKwkJ
cmV0dXJuIC1FTlhJTzsNCj4gPiArDQo+ID4gKwlyZXQgPSBrZWVtYmF5X2Nsb2Nrc291cmNlX2lu
aXQobnAsICZkYXRhKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZ290byBleGl0Ow0KPiA+ICsN
Cj4gPiArCXJldCA9IGtlZW1iYXlfY2xvY2tldmVudF9pbml0KG5wLCAmZGF0YSk7DQo+IA0KPiBJ
cyB0aGlzIG1pc3NpbmcgPw0KPiANCg0KWWVzLiBFaXRoZXIgY2FzZSBpdCBnb2VzIHRvIHRoZSBl
eGl0IHBhdGguIFNvIEkgdGhvdWdodCBvZiBhdm9pZGluZyB0aGlzIGVycm9yIGhhbmRsaW5nIGNv
ZGUuDQoNCj4gCWlmIChyZXQpDQo+IAkJZ290byBleGl0Ow0KPiANCj4gCXJldHVybiAwOw0KPiAN
Cj4gPiArDQo+ID4gK2V4aXQ6DQo+ID4gKwlrZWVtYmF5X3RpbWVyX2NsZWFudXAobnAsICZkYXRh
KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtUSU1FUl9P
Rl9ERUNMQVJFKGtlZW1iYXlfdGltZXIsICJpbnRlbCxrZWVtYmF5LXRpbWVyIiwNCj4ga2VlbWJh
eV90aW1lcl9pbml0KTsNCj4gPg0KPiANCg0KVGhhbmtzLA0KVmlqYXkNCg==
