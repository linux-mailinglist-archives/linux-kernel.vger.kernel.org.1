Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECB2D3431
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgLHUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:32:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:63853 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgLHUcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:32:15 -0500
IronPort-SDR: rjdygps5KDPzZkxGR8iQZGrmpAVOW1gX8wYzxQkiSealPQBw55p2b4Hpsuk4vcKWu8+3tsGmGF
 5MmLdlksV/sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174100977"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="174100977"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 11:12:55 -0800
IronPort-SDR: 8FMTbpv7fnTECzcDTxr68T71zDlyppSgvdbS7tJgR99yjjynXQ0HQkC2X0qaWwTQAiiamZ0hcN
 J8SoKvSKF6ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="542124267"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 08 Dec 2020 11:12:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 11:12:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 11:12:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Dec 2020 11:12:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Dec 2020 11:12:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRUgw8R8HQuSrgqh+LivGXUqp6h0ixz3G7qpKZxr6ANqO+2UMJY/QKDUGo8qs85tTVArtItWwKv7Lwf5wW8fyYEpYAZGLItEZr5c5v5xNhT7haQL/qCWrlxCkJm1MI+HRRAvC3ctu+x5VuuGmKMyLt3dLI3xqtjuHv2PTzOVds43IGXwn3Us1wBgI8wB2ccRWlEMuoA5JS4o5Cnn4409/gsSKyjI7Vv5YTauMA+Tm5aVjO9oXoA1BjIIf6ZHPf1Buqg5KBxn0P0gnu+Kur8d2Dy3oUb1LwmEZSNOOdV7+MsTmv6L/81frahlaxFLXqtmrI5SbTt5AuuGhJMVDgXBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOB6c9hQFNiifsCK8fSUlmoxDZIvjxPfIGGck8PdmlA=;
 b=mDcY6sIo24+JK5E1Z/jbIw4iLIO6O1bl9sSASWbomA/w/xuO4Dkm6MWTFCTRdzGX6omK6xwkel/tiep5Xp5vbA63OWHUsJvH/DGaJhAIED68vWlsIoFGljzcKomk+XIHCHrzmDxcLeWcUxSuCGlEH+7Ulii5BnpuSgQiphnhTabzXSgc/P2I++MKhjxUBGWUfYF3Ere+1SmtaW9gV/FCyQ504Kub9DYrezDKwptX3Z/YGKbsdaY1PqbKLVVgOSZVXc87v1i/IZW73A3Vy5Ya84sJoMSq0AgW1ZVFl7IgSxu0s+6Bp6S9dzF7IovBZJAArYqEoqXaRm41cUkxjFF8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOB6c9hQFNiifsCK8fSUlmoxDZIvjxPfIGGck8PdmlA=;
 b=SKnqtzEhG1aTGTo+fTPsGzxbq1FLce7mxOl5vc2UXh724fd8PcMDolmhnHPpaIIx+Yot+1OTR4kSz3IM6CGwi6EhY3LWIQ/oIJgCkUzDWlPOnOPWZEk6M9cUwcwkO+yHctoOaHONl63XA++EsaaHTW3R2OPcoggrW5HePgLQ2qU=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BYAPR11MB2855.namprd11.prod.outlook.com (2603:10b6:a02:ca::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 19:12:51 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 19:12:51 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
Thread-Topic: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
Thread-Index: AQHWvsznQG60NzoojESgLM5m/NNfkqnQeGSAgAcnjACAAAMugIALno4AgAGjDoCACMi7AA==
Date:   Tue, 8 Dec 2020 19:12:51 +0000
Message-ID: <ffa28f1070749ab00635608262c25bad2f11a185.camel@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
         <20201119233257.2939-16-chang.seok.bae@intel.com>
         <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
         <246DCF46-D7F4-4F68-ADF8-2F694FEFD2AC@intel.com>
         <CALCETrXjgB_QXumQr+AgZx5O5SDv25yiVuDkFuCk9ZRDP6VoKQ@mail.gmail.com>
         <A7AD8A0D-0346-4B25-A2C8-283E59D422EF@intel.com>
         <CALCETrX6=1AOS_G=dUdMyCiCSVRA3ns937nhRS5O1DwvfWtSQA@mail.gmail.com>
In-Reply-To: <CALCETrX6=1AOS_G=dUdMyCiCSVRA3ns937nhRS5O1DwvfWtSQA@mail.gmail.com>
Reply-To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 892e00a1-334c-40d9-9e12-08d89bad426d
x-ms-traffictypediagnostic: BYAPR11MB2855:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2855DA8218BE3C004DD8EDF0D8CD0@BYAPR11MB2855.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNbWoW8i7YrEbkgS5z0aNQKrD4fjXzXeDlEyWBT6z80toDnoDFakgOuIzIA9BfbjKCI/GbOs43PFtMB2tH8yGjL/yCMXUawqjTkJ9qzf9eL6EUg+91mJALMNJSay1PanTfQEX8sNEt66DwlTtE12FKt7QlMH5ym92e3myzRQNFxKZE7YQP8hhZYxdMy2uB5Gl/1GPAhUxkFV/XH0c1lxPJMNwzA80E0PThWqfYFG13aYddMhGJw/GTlOeB1cU1dWeKrcCbteXATSmdkVNWcxLAxGsa4ZZzYO9sXy8klVvWYwz7u8MNFSbipnWFAFi5u+PAGBSfPFhXvKIZbLkW8S1hCIIMQdsa/zVBe+AK9hHn/KCPpTfVSO+ZVC+0aoiHu2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(8936002)(64756008)(6512007)(186003)(76116006)(66446008)(26005)(8676002)(66556008)(5660300002)(66476007)(4326008)(558084003)(107886003)(6506007)(508600001)(54906003)(71200400001)(86362001)(2616005)(83380400001)(3450700001)(6916009)(53546011)(6486002)(66946007)(2906002)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NW1abWU2YnlTMU1XWUNyZ1VnaTJYZmtxbHBRU3BWbmY4UXBxWGJOMWZmYjQv?=
 =?utf-8?B?Nis5TlBYNW5BbEJPUnIvdTd6ZGdQaVBUQUNJdGs0UXZlRzYzeTNmVE9xaWtC?=
 =?utf-8?B?RHhiS0NyVENWSWppeFI5VmhuU0pXYVk2UzFERHdrWkJUS2dtYjdZZzZ3a0Fr?=
 =?utf-8?B?YmMyUFZENy9KUXU2amkxUjQ1dS9Wb3pEeW5oN1psOFVuMTI2TkY3aUh5emt6?=
 =?utf-8?B?d2hxMjNuSll4QStpMERsU3QzY2NTWlhOd1FRRWJDVU5CSEhzdGorbnBpRExD?=
 =?utf-8?B?Z3RHSnZlNG1TV0pnTCthcEtOaTFhSkRFeVViOTAxeUZCcVFMV0ZMMFhROHc1?=
 =?utf-8?B?dGwxZHV4bnh5M1VnN2pXcFVqQlBEM0ZLK3VoMng3NUwycmhSQVJDdnhWcU9V?=
 =?utf-8?B?ZnpLN1A2WTZhYmhtaGdUU0dGcDlRenVLSy91Qmp1N0ZGVmk3clhMNUl5aDly?=
 =?utf-8?B?NDRkcm9RV3BLcEF4UnAybnhwdkdESXZjTXlxOGxrVThFd3NCejA0RDZ5d2Zv?=
 =?utf-8?B?ZzdQZ0JKRkF1VGFWYUZvNGZvajdHSjlUZlYrbWt5dWZMbVhlT1VERnJGdkF1?=
 =?utf-8?B?QVg1aThod3hYOGdZVTJtbWs0RHJUN2RIcnZFME90R1hoajI5SzY5K0VHdzd6?=
 =?utf-8?B?dEJhSDE1SmRDU002WVd1ZFJhbjI1dzNLZFh2azdVWVAzK3VnS2FvZVgyUWFP?=
 =?utf-8?B?NjExOW9KbmV6VnhZMGZCR0tBMExEaCsxTEZQT1QxRzdPQVQ1c3RzSEROZEtN?=
 =?utf-8?B?TSs1cFgxNGFBb1BWL1F6MTFoRUlQSnVIUERzZnBuRUovbUNyYjFyeXZObnZU?=
 =?utf-8?B?dzFtUFNiT0ZXL0RoQzRobmw1cnhHc0RocHVhTUVvL1hiS2tWSkpHOHpsSWVy?=
 =?utf-8?B?SkNWRW5HZkpRM01uSkxpQUpWMDhsdUQxZkNKYWFKRS8vTDFSU3k1TFNkb3VS?=
 =?utf-8?B?NFRTeklsdVo3QWkwRHd2dG91N1BTQS9aNjh4ZXh0d0xkSHBkODB6dDhEdWtS?=
 =?utf-8?B?NnhHRlBLV1FkOXVHTXhoMXEzNFFWRTRLVVRMM0RNcFJJTmUwRHhOVzFtejVJ?=
 =?utf-8?B?KzdoeG44dkVxVURHdTc5WTNHaXQxbkM1bFBMb2RwTU9QaGJQaUZvOUVwZ0JS?=
 =?utf-8?B?N1lFcTlWRUlXY0UwOEgwRkN4ZzN1VzJnVitBcEkreGxaYkpEQ2pCV1VJTXBK?=
 =?utf-8?B?RHJBa0pzRW9obGpkMDFHQWR6RE02TENtcEl1d0xyUXduRVR5RmtRWG9FcDA2?=
 =?utf-8?B?d0twT001bEJuWlZNdVBQVkRETlE0UWoyZHYzUWJITHRSdVRoVlZiRU1aSDJY?=
 =?utf-8?Q?wx3fVhdN8xhUK+rpgYwOK4BF2EFxFlRV64?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9EDF2EA5F524B42AEB1A98DBDB60BE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892e00a1-334c-40d9-9e12-08d89bad426d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 19:12:51.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhN9I8CPTakoqjtxzhGjZo1yVIJ5z7VnJg3xeDeI3PWULvQZPJGXpncgDtGHFGy9zlDcA7S5gUnzFHVoQdJ/UJt14kKJ3CB7x9BXYKfH6u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2855
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMywgMjAyMCwgYXQgMTQ6MDAsIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gDQo+IEhhdmUgeW91IGNvbmZpcm1lZCB0aGF0IHJlYWwgcHRyYWNlIHVz
ZXJzIChnZGI/ICBkb2VzIGFueXRoaW5nDQo+IGFjdHVhbGx5IHVzZSB0aGlzIGNvZGU/KSBjYW4g
aGFuZGxlIHRoZSBodWdlIGJ1ZmZlcnMgdGhhdCB3aWxsIGJlDQo+IG5lZWRlZD8NCg0KWWVzLCB3
ZSB0aG91Z2h0IHRoZXJlIGlzIGFjdHVhbCB1c2FnZSBmb3IgdGhpcy4gV2UgKGNjJ2luZyBNYXJr
dXMpIHdpbGwNCnN1cHBvcnQgaXQgb24gR0RCLg0KDQpUaGFua3MsDQpDaGFuZw0K
