Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9343B30412D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391560AbhAZO6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:58:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:3468 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405908AbhAZO5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:57:12 -0500
IronPort-SDR: gVIwsPIa5RO1jfW4w5Y5jY8igCye4/43rzQ1ngLS37tov26IsWmS79bVMO17ialF1htalcUwzq
 fHkRHTQ4q8Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="159087419"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159087419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 06:56:44 -0800
IronPort-SDR: MCL26BWkJ6oZ6HqR8Szh7wrjJuQcxFijb+TIg7ZXLDg176zboBLC9KwCsS4fbu4OFWc7hp+FQ6
 8XbZpKb450GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="369127721"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2021 06:56:43 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 06:56:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 26 Jan 2021 06:56:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 06:56:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1byVQUiEqcZQElGWJ09oPCsnVgB8Pd6tKdRUIJB4gYThyrPZlccsDCa6KGUiWjBoBdwOOjqcilpQIgDsB+sjfSRw3SVuzFdSph2gIbF93yQdLUv71FV/HXPUTJdee6jPDgp7E7cSYe3RvDrRJwbK1FqT6sl8HAMEbBRhXMOpIq53L+MijEoEWCF12PpNrECn+yzwpmcQMeCdRrM24TK4Cphe8SHxRoKmoB2DaDfKxB4db6wogLBdTf4Xkw4FjTMyin4BtjQMYIc94ivEF1cZgs9fuHbsZkVkjIqQDdFamuqbjWzLSM951dvHhZ+eeqbiCjEUgrbBdj6oxXI8NnN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IYupP/thsE4nY6rM6Yj/SHoytPaunCotxZKHeFZT3c=;
 b=BviliYiMmrVk9EEIkzuFajK0w5MgHtEx0Mj0hTuv9ew42p2WvFHt/ViOS/S8634fMif7lI31g4HikGe2a6/p4ING+/wY/YlSrTx4vs8WRLRyABv2fsPyfA4lTq3oM9vjQ+gfobR0ugz41ywHSyitaBaR7Uk6zNpJrU9/isbzzIyxx7ZVlyfKzKLbRKEJYdLgltmggzCml9iHuwSi9u2/c+e0YDTWIRbad98XM1z344XXpu8oPop8GMd/tCIftJGdB6uFB9v/rX6s360MNZwvBV/6+lOu4UvJ3FOA/QZyFalBq/kCsY9BsbKpRHdT+TiAFBJcm2QSFVcw36LTpCsQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IYupP/thsE4nY6rM6Yj/SHoytPaunCotxZKHeFZT3c=;
 b=EusPNhNTevh0+Rteef+/THMiuvvD/MfrDJCBNKFeXLyRNNtvrEjxlsfqyN6oxUYCi4l8d8c7R3t4UFKVsLhZEvZPl+rMvsBsem+fNbIL9f3fI+k8ckIBDMWlE3WAVtqE9N2bz6YthW3Zd62WBiPsGHStOF584B1IW1Tmxv90ziE=
Received: from MWHPR11MB1679.namprd11.prod.outlook.com (2603:10b6:301:f::12)
 by MWHPR11MB1999.namprd11.prod.outlook.com (2603:10b6:300:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 14:56:41 +0000
Received: from MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c47e:d3c8:2a2f:8647]) by MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c47e:d3c8:2a2f:8647%10]) with mapi id 15.20.3784.017; Tue, 26 Jan
 2021 14:56:41 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Palmer Dabbelt" <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "C, Udhayakumar" <udhayakumar.c@intel.com>,
        "C@linux.intel.com" <C@linux.intel.com>
Subject: RE: [PATCH v2 29/34] Intel tsens i2c slave driver.
Thread-Topic: [PATCH v2 29/34] Intel tsens i2c slave driver.
Thread-Index: AQHW5gTnLFBoJK3IPESbgTEHtdoBd6ojmUQAgBWBXoCAAIemgIAAeB6A
Date:   Tue, 26 Jan 2021 14:56:41 +0000
Message-ID: <MWHPR11MB1679E3F08F2AFC45FFF549C88EBC9@MWHPR11MB1679.namprd11.prod.outlook.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-30-mgross@linux.intel.com>
 <fe1aad31-a536-4f0b-e817-b795890f4b45@infradead.org>
 <20210125233935.GA13745@linux.intel.com>
 <CAK8P3a0V5wFYypYDXbVFQvzbjL5K0Gp0j+Zfg_7-5vML1B1-Cg@mail.gmail.com>
In-Reply-To: <CAK8P3a0V5wFYypYDXbVFQvzbjL5K0Gp0j+Zfg_7-5vML1B1-Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26263ccd-a3d2-4d42-0342-08d8c20a971b
x-ms-traffictypediagnostic: MWHPR11MB1999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1999BFDCDB04DD45CE753CDE8EBC9@MWHPR11MB1999.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2eO234+kIxl6eipoxsYuVyEr2mc4ui3ELdOvvW6kKSZe4VGQybM5f8tOLBRUddheMiimUr4j2AFnyWYalmMn//t7DiGWkziBX9IeisIHR628xzc2+8ohCZtfJm9IEdnoqj9lqVSkY+GZ5sot5S/073b+Dqh2O7Z909Dzub0UzoY20JUlhBsQIvvPDoyTnwpHLq3IcAxaOStG2J/cfBvyT4Ef+/myCubghh6E5ZGsqfUMLqjCQZNUs69d9lXu4qCX6I/AlQX5hleA711TJOGX6DjplHgKSMUMHb0cH/4qbNR7+63UdrBs4cURupZ2GJhKBkZx83xfCMD8k1N40Hn0Nn9INu0FN/EdWV+3q7kONx000/LZ0cP7K8ULrLEl9r4XJ+Zf20sAuu/DM2KbIU8Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1679.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(83380400001)(33656002)(71200400001)(478600001)(54906003)(186003)(5660300002)(8676002)(7696005)(52536014)(110136005)(4326008)(316002)(6506007)(7416002)(53546011)(64756008)(66556008)(66446008)(55016002)(66476007)(9686003)(2906002)(66946007)(8936002)(76116006)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SHZLei9pcUhiY296ZDFJeTJQYkV5MHlIbEZpdEFFTFdkMVJ4dWlKMTdiTEJ3?=
 =?utf-8?B?YTdlbzExMzAybGxNT1BLYmZreUhDbVlHSUJGeGlpZ3FDRVZFTURDUXE1dVZY?=
 =?utf-8?B?TFYwTmR2MFMwK2plQVFsQytzNzl0Q0tXZHdXZmltMjNPSVRVbGR4eUF1eGp6?=
 =?utf-8?B?ekp6RnJpMEFiYmNPR1loV1N6Qjl5L3pUY2xKL3Qrc2svR2lLcUNDSFBpR0ZU?=
 =?utf-8?B?KytxaHlNM1FkbDVUZ1dnV011L1BxRnRoUFhpQkNCVjZ1eHhyU2Rla3JQaWNt?=
 =?utf-8?B?b05jUW5qU1VUeCttNE55TGRxcEp6azNaak9wekU0d2xsbDRpcDlqTlhYU2NI?=
 =?utf-8?B?SnhULzZLS1JyTXNFakQxbnpNQ1YxK0p0emV3ZHdqVkt1NW8wSzY5dUw5d09j?=
 =?utf-8?B?SmNCeGNVQlNGY2QxQmFNa0liaVpLY2sxYmQxVlJZRmFWYnlzRERzTlZpM0hn?=
 =?utf-8?B?a09BRTFYVWFSZHdLenJNV0tSWHNiR0VYRmhOVmhpMyt5YmQ2NEplWHUzV0FF?=
 =?utf-8?B?TEJzOWRJUzcvWnN1R2dYd2tKc3VCUWg2R0U4TEJoU0x3TUtIeE5QYjJPUjhB?=
 =?utf-8?B?TCtxdHowNTF5Ryt6SUpieVU3eG8vUWFJdStzK0lRQmdtTlFaWGg3cWtKNitL?=
 =?utf-8?B?OVVLbkIyR2g3WkRxWXRVOHo2azNMUE5KRjBIRkQ5T2NCWktaMzl2SGpnWlVB?=
 =?utf-8?B?NTVTZmNqaEV0aHVKZDlSeGVmcUFFeWJLTEVlcTVycHZrdGpJOEd2SkhOdjFV?=
 =?utf-8?B?Y1hnc2NITG1OblEzaVdBYUkwUmQvS0xBaG1lYkhVQVN4RkM0OTR2QVRhL2J3?=
 =?utf-8?B?Q0dzTkZwa2dScWh2VGFpbkIzWHNaaDMwRWtCQkxFWE9WN3g1c3FqY0NydC9F?=
 =?utf-8?B?dDJyVHRYcnk0cnhYVTZWd3NlRUZZVkd2Wi9kV0NOSVd1MXBvOXBvZ1JZcEpv?=
 =?utf-8?B?YnZHcmF2WWxsSHVrTGZQdjhEbkVpM1F0cmhldVFmcEdwaGJ3N0JuRFY3RXdZ?=
 =?utf-8?B?WHV1M0tpVzlXRFJZSnhYTkxRRjdJdGJ4UWtnVnJKczJUWjdRTjFZd2l6Vjd1?=
 =?utf-8?B?T3VreFl1cHFrQ3R3c0dzb0J2UkRqMTdHWlNzVE9LMTJPWXhnYWN3Q0duZ0h4?=
 =?utf-8?B?VTZzMmR4V0ovVTVvTGJRM1czeEsra2RNMFlCSXhtRUw5VVBxU01iLzhWeWEv?=
 =?utf-8?B?UDRheUNOeHh2UDEyaWdkVHhEYWhOdVFQaFFxZ2ViZzRRaDQvZGN5VXJPTkJk?=
 =?utf-8?B?UHpDcS9EenBncWZyYjBaNit4UVZOVkd4WWtScXdxdzJFZ2FDb0VXMWhUZ3lG?=
 =?utf-8?B?OXBwZVo2SGd5cHpUa2xMSXcvSlBEeTRWdFZiQ0pkblZWTTRGaTBkcnAwNWNW?=
 =?utf-8?B?SlFLMGlaSzR2cXZuSXVzR3ByUEJ3aGxHS214ZUl3NjA1eEhiUUdjRUFhSHRL?=
 =?utf-8?Q?tLP5U5Ag?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1679.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26263ccd-a3d2-4d42-0342-08d8c20a971b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 14:56:41.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8m5G/aIufH9ELOEj9fuIwSWvglfU+FUkCBB6/qq82bH25/WS1bv1yG7K1BQIW9PrUyRkvJpBgciPyyNSsmdtZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1999
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjUsIDIwMjEgMTE6NDUg
UE0NCj4gVG86IG1ncm9zc0BsaW51eC5pbnRlbC5jb20NCj4gQ2M6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPjsgbWFya2dyb3NzQGtlcm5lbC5vcmc7IEFybmQNCj4gQmVyZ21h
bm4gPGFybmRAYXJuZGIuZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+OyBEYW1pZW4g
TGUgTW9hbA0KPiA8ZGFtaWVuLmxlbW9hbEB3ZGMuY29tPjsgRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2Fu
LmN2ZXRpY0B4aWxpbnguY29tPjsgZ3JlZ2toDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz47IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBMZW9uYXJkDQo+IENyZXN0ZXog
PGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsgUGFsbWVyIERhYmJlbHQNCj4gPHBhbG1lcmRhYmJl
bHRAZ29vZ2xlLmNvbT47IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47
DQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz47IFNoYXduDQo+IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IEphc3NpIEJyYXIg
PGphc3Npc2luZ2hicmFyQGdtYWlsLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBDLCBVZGhheWFrdW1hciA8dWRoYXlha3VtYXIuY0BpbnRlbC5jb20+Ow0KPiBDQGxpbnV4
LmludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDI5LzM0XSBJbnRlbCB0c2VucyBp
MmMgc2xhdmUgZHJpdmVyLg0KPiANCj4gT24gVHVlLCBKYW4gMjYsIDIwMjEgYXQgMTI6MzkgQU0g
bWFyayBncm9zcyA8bWdyb3NzQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBN
b24sIEphbiAxMSwgMjAyMSBhdCAxMToxNTowNlBNIC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6
DQo+ID4gPiBPbiAxLzgvMjEgMToyNSBQTSwgbWdyb3NzQGxpbnV4LmludGVsLmNvbSB3cm90ZToN
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9pbnRlbF90c2Vucy9LY29uZmlnDQo+
ID4gPiA+IGIvZHJpdmVycy9taXNjL2ludGVsX3RzZW5zL0tjb25maWcNCj4gPiA+ID4gaW5kZXgg
OGIyNjNmZGQ4MGMzLi5jMjEzODMzOWJkODkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
bWlzYy9pbnRlbF90c2Vucy9LY29uZmlnDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9pbnRl
bF90c2Vucy9LY29uZmlnDQo+ID4gPiA+IEBAIC0xNCw2ICsxNCwyMCBAQCBjb25maWcgSU5URUxf
VFNFTlNfTE9DQUxfSE9TVA0KPiA+ID4gPiAgICAgICBTYXkgWSBpZiB1c2luZyBhIHByb2Nlc3Nv
ciB0aGF0IGluY2x1ZGVzIHRoZSBJbnRlbCBWUFUgc3VjaCBhcw0KPiA+ID4gPiAgICAgICBLZWVt
IEJheS4gIElmIHVuc3VyZSwgc2F5IE4uDQo+ID4gPiA+DQo+ID4gPiA+ICtjb25maWcgSU5URUxf
VFNFTlNfSTJDX1NMQVZFDQo+ID4gPiA+ICsgICBib29sICJJMkMgc2xhdmUgZHJpdmVyIGZvciBp
bnRlbCB0c2VucyINCj4gPiA+DQo+ID4gPiBXaHkgYm9vbCBpbnN0ZWFkIG9mIHRyaXN0YXRlPw0K
PiA+IEJlY3Vhc2UgdGhlIEkyQyBkcml2ZXIgZGVwZW5kcyBvbiBhIGZpbGUgc2NvcGVkIGdsb2Jh
bCBpMmNfcGxhdF9kYXRhDQo+ID4gaW5zdGFuY2lhdGVkIGluIHRoZSBJTlRFTExfVFNFTlNfTE9D
QUxfSE9TVCBEUklWRVINCj4gPiAoaW50ZWxfdHNlbnNfdGhlcm1hbC5bY2hdKQ0KPiA+DQo+ID4g
VWRoYXlhLCB3b3VsZCB5b3UgY2FyZSB0byBjb21tZW50IGZ1cnRoZXI/DQo+IA0KPiA+ID4gPiAr
ICAgZGVwZW5kcyBvbiBJTlRFTF9UU0VOU19MT0NBTF9IT1NUDQo+ID4gPiA+ICsgICBzZWxlY3Qg
STJDDQo+ID4gPiA+ICsgICBzZWxlY3QgSTJDX1NMQVZFDQo+IA0KPiBQbGVhc2UgbWFrZSB0aGlz
ICdkZXBlbmRzIG9uIEkyQz15ICYmIEkyQ19TTEFWRScgaW5zdGVhZCBvZiAnc2VsZWN0Jw0KPiBp
biB0aGlzIGNhc2UuIEEgcmFuZG9tIGRyaXZlciBzaG91bGQgbmV2ZXIgZm9yY2UtZW5hYmxlIGFu
b3RoZXIgc3Vic3lzdGVtLg0KV2lsbCBkbywgdGhhbmtzIGZvciB0aGUgZmVlZGJhY2shDQoNCi0t
bWFyaw0KDQoNCg0K
