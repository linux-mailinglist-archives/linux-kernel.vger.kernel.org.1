Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B52FC0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbhASUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:22:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:28381 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390547AbhASSwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:52:22 -0500
IronPort-SDR: vGkF9Xp+uaUI9OcmxGDLld/6IqPZXEsXWXr6N3yqrar+oCyvVfY4W01sDCVoAP9E2N9/4HWjSY
 qio2cYeppFWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="263789633"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="263789633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 10:51:38 -0800
IronPort-SDR: SQZ9gSvDl2KSunnVs5GPRlGoyVTjNKFZVm4TQqWV4Hgx49o35DNYMayjShV6QsSTrIBVZ6yQnt
 OxQk9tk6VwXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="426576449"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2021 10:51:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 10:51:37 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 10:51:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Jan 2021 10:51:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 19 Jan 2021 10:51:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYFZ8gD6cWl8WryHuzvkM/NKqfyYWqwhsVbPMJjIbO2Q5K+MvAhl39GkjswgWPxsqovxKnBnQ79Q3E08Pc9exT9FcawwTGpD368FCF8q+TamBEmzcwsNVkryInp0dhmT0R6q5v0hTVU8gg0DgqgujqLqZzwTIQkgW10suQqwcPFjK65+XvWKFwDDoggbd5Qy0Yrf2BsPFZpkaifAG+gpFf2+X4dW5XqMC0CaZ93CVoqDtrSQVpdw6j6s7dilIYmUdxbSBYI/jv3kKRt1ndaljTqES4h8/BPvA8eMEMo8bUtUZg8nUGDwoZzoYd2y3Ki7FlPJbDJbUH+0mbQherXcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKxcswWCnTTAPIwrpIfWi6k/pgk/P0QT3T+8a+Z65ac=;
 b=lbkDl9dEHT5os9OpdrdtDdr63Wl4XzTYBX+qGXRmeNP+b7cDdt/EKMpdCB9/qn0Gqp7CB8S7DJK+G6sKNcFcGWSDFa6+cuxBqM32G9HIR8g+x+IHGKSPlnSzfKjM1EnzY3RLM/TV497Irk2xJ5dnBSqCiSXLusjyYQqL2khMsP2hWU9cIPPdYD4giPRDsk9gV5HFm2jpRJ3vY6GYdaJamJ/DFvL2GffIgF6vjF/FC7P6jg+WQpvWZzDBviYbdrPhKEhwQ1jzazddSXO4UzHrNw3pEob0mN2cAlQEEd/4I/XkXkAWLmua6LW1hgXfBoEfUTjtAcJtMg5By1PyX1vXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKxcswWCnTTAPIwrpIfWi6k/pgk/P0QT3T+8a+Z65ac=;
 b=T+Gy0NY7sKHs00htj+xDh9blREAQ0/H9M9YteyIniU823gzzyI8rxHsxwDim5yLgeSrG1lS+T1yFAFWXYM7yEPNv6cDAA57vTRhMCwkw+9rj8CN5o8HQdQdrvfDxwpYJCmg/2nJOnY83K72LWgjCJ7ZKaMLb2cRRVvkUOOArRtw=
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MWHPR1101MB2109.namprd11.prod.outlook.com (2603:10b6:301:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 18:50:52 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 18:50:52 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/21] x86/fpu/xstate: Modify state copy helpers to
 handle both static and dynamic buffers
Thread-Topic: [PATCH v3 02/21] x86/fpu/xstate: Modify state copy helpers to
 handle both static and dynamic buffers
Thread-Index: AQHW2UTpqPiXR+Ajm0+sop34hrXbfaoox44AgAat7IA=
Date:   Tue, 19 Jan 2021 18:50:52 +0000
Message-ID: <F06B741E-25C8-4777-9576-3684FF649F1E@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-3-chang.seok.bae@intel.com>
 <20210115125048.GB11337@zn.tnic>
In-Reply-To: <20210115125048.GB11337@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e3c8fc8-ce84-4d6e-b6eb-08d8bcab253c
x-ms-traffictypediagnostic: MWHPR1101MB2109:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2109EA83B34B2A6F966FA83BD8A30@MWHPR1101MB2109.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 29swVo06uMMnsD6v0ylu20SFUd0/C8Dw9hliOk/wv+oHS58W+esEz1Qgl/FeIFli4kHciWeovDRPdtjx4G2TRvtCeuNZe7qO1456MUFjtjpcumOAdHapol8Hg36fZQQQn9rWo21jy6+SgtXzc7LHJ9q0roz1HojOiouSKicjDHySnivPwmIFxmicrwccJv/1miNUyxTL5UnZ3SaZBGT6OOxHh6S2eYvsGC3bXAJCyc8ORvuKQzESVp3kuZwFvO96jv7FEQNxqxvQnikEhjlJVENhvJ/vTMe+GlgnmInZntVSZvA6velNx6YFYTuwxORqEh+D7cFHKbFiNgbxofd2NCJIHJM9qKDzHbOImsgXlhv/uTSS9Cxgs1kkH6PmrcpoOIRKBK4QixHSoBVjUR2du2OSQaELPjttAeI/bTW5o9foQlbpGpwFqdNob/YxiVPa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(8676002)(53546011)(4326008)(36756003)(33656002)(6506007)(2616005)(6916009)(26005)(66476007)(478600001)(66556008)(66446008)(8936002)(66946007)(64756008)(6486002)(6512007)(316002)(5660300002)(76116006)(71200400001)(2906002)(86362001)(54906003)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OHJ0NlNDSmJ0SkkyVGxsenVSQTk0c0MvYUNtdDF4YkNwZ0dZYzRTMUl0WU1H?=
 =?utf-8?B?Z3MrTUxJeW4vWW1Ed1Jjcnh0UWlaRVVDQUdRMmlaaDVWQzdGcURnSlRybGxU?=
 =?utf-8?B?THZ4c3ZyRHFjMGNRbGRxUSs2Yi9PRno1Q3hhL2hxUCtCM0RMVS9OTGJabU5r?=
 =?utf-8?B?RWhtQWlXdjVJejluMjRuN28zMjFoZ3R3WmFsYnl0Q0JqWVpwU1pxMkxuR2s4?=
 =?utf-8?B?amh0MzVZNzVsN3pNa2xxNzI3eXRGQzJ5ZmVLVWJXSklwVkVhL3NnbENVV0p5?=
 =?utf-8?B?L3B0OEJONlQ1Ny9JSGJheGd5bTZvNFdmOXB0RG5EU2RkVjdYZWtsdk5ZUWRq?=
 =?utf-8?B?QjhPSnQ0UURlNGJ1R3doTVllcTF0a2xnZFNsYkduVzgyY0x4ekxpcHFjOTFV?=
 =?utf-8?B?SndQWkl4alJGc3QxZ0kzelVhaVFVa0Q1OUtSMWdZQ2lSK2l0WHlhZFc4RStM?=
 =?utf-8?B?a3lBWDNTSERlVmt5OGttYVl1RE0wdnEycmZNNHEveHd0dlIzRldMSEFGVGFF?=
 =?utf-8?B?L2pid1IzVDJzN0pvZGlrL1BvcnJyd211aDRLNUpwcGw5UFdmSjNqOHhkMUI2?=
 =?utf-8?B?TmQ5MmRWTE4vYmdTNHM4WG9ReWt5MFFSVytvUm5HcFY0OHo1dC9Zc1hoR3Rs?=
 =?utf-8?B?aEVNOEdzNFlZSHJUM0U0VDE2NFdPWnUzVDVSRG52VEYwS3ArRlNOZURVdkdm?=
 =?utf-8?B?VDNVUW5MWmZlMmlhbWZCVm1NMVZ6MWpNRWVKWGhHenpJWWYxa3orS1g0cWtn?=
 =?utf-8?B?ZGYraTUxeGV5QmxVcENtVEtjYmVsYnFGUktqRGUzbUM5UGJRUDZLQ01HNThO?=
 =?utf-8?B?ZDFEa3BjTTkrL3BQcHNHVGllTVB6YU1pZ0lIT1R2SGZqQnEwdGhZeXpuL21q?=
 =?utf-8?B?NEdCUmlZUGhTbWFBcnFTVXRXNjg5aDQxTEg4Zit1OE8xR1VHRGl6NEJ0TTdF?=
 =?utf-8?B?Wk0zU25mMStUaWFtUXZ3VG54MU1jQ0FYTEpTckc1L0JKaXpSRFE4aGpTMWhI?=
 =?utf-8?B?aENOaUs5bzJtZUJVU2dNaVN2dzlCdGg5bWt1UVU5NHkxNjN5MTVhbElnSTQy?=
 =?utf-8?B?b2N6MS9Zc1l6UUJFOTFkeEc4T3lXR3RQMUJSeHoxU05oREpyemY1T1lkUUo2?=
 =?utf-8?B?bXB1VEgyNzVIcDZYVWFQdmV5cG9HeHpCY1lQU3NJMnIvaUVPVkJBbmhTQStW?=
 =?utf-8?B?M1hGcjRGTUUyWGwrNmxDdm9kRDh5VjUyUGcrWkpVbWlsWkgrcS93Z3hHSHNY?=
 =?utf-8?B?S05nWElrUjBEL21UNHl4cXFTWWZtVHprV3RPZUxXaDEyeWlWNFgrVEFaUDRl?=
 =?utf-8?B?TDMrTkhoVVlnN2dvTlZKaW0wSVhFaVlaUUovMlN3cDdqK3lMSVcrUEl1emEx?=
 =?utf-8?B?RU1qTWNlQWtQeGRSOTJNYTd0WStYZjV1MG5CQ01sM1M1MUpwTWxxK25tT1pP?=
 =?utf-8?B?d0xsT0dRdmwrMUlNSThWYTZDcCtwRHptdS9vRmFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <964F1E6873EDC649A9EE49CC5ECBBC01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3c8fc8-ce84-4d6e-b6eb-08d8bcab253c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 18:50:52.0810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4FBxW8sZvr8jI6OXwcyGwAcaRDRiCqVyljPo+3yWgvKi3GdKWXxxOVuvF53W7WWu/cbuvecOlroh7Y57iBVVo3x0EcMLL8NftWwwazk7i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2109
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSmFuIDE1LCAyMDIxLCBhdCAwNDo1MCwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gV2VkLCBEZWMgMjMsIDIwMjAgYXQgMDc6NTY6NThBTSAtMDgwMCwgQ2hhbmcg
Uy4gQmFlIHdyb3RlOg0KPj4gDQo+PiAtdm9pZCBjb3B5X3hzdGF0ZV90b19rZXJuZWwoc3RydWN0
IG1lbWJ1ZiB0bywgc3RydWN0IHhyZWdzX3N0YXRlICp4c2F2ZSk7DQo+PiAtaW50IGNvcHlfa2Vy
bmVsX3RvX3hzdGF0ZShzdHJ1Y3QgeHJlZ3Nfc3RhdGUgKnhzYXZlLCBjb25zdCB2b2lkICprYnVm
KTsNCj4+IC1pbnQgY29weV91c2VyX3RvX3hzdGF0ZShzdHJ1Y3QgeHJlZ3Nfc3RhdGUgKnhzYXZl
LCBjb25zdCB2b2lkIF9fdXNlciAqdWJ1Zik7DQo+PiAtdm9pZCBjb3B5X3N1cGVydmlzb3JfdG9f
a2VybmVsKHN0cnVjdCB4cmVnc19zdGF0ZSAqeHNhdmUpOw0KPj4gK3ZvaWQgY29weV94c3RhdGVf
dG9fa2VybmVsKHN0cnVjdCBtZW1idWYgdG8sIHN0cnVjdCBmcHUgKmZwdSk7DQo+PiAraW50IGNv
cHlfa2VybmVsX3RvX3hzdGF0ZShzdHJ1Y3QgZnB1ICpmcHUsIGNvbnN0IHZvaWQgKmtidWYpOw0K
Pj4gK2ludCBjb3B5X3VzZXJfdG9feHN0YXRlKHN0cnVjdCBmcHUgKmZwdSwgY29uc3Qgdm9pZCBf
X3VzZXIgKnVidWYpOw0KPj4gK3ZvaWQgY29weV9zdXBlcnZpc29yX3RvX2tlcm5lbChzdHJ1Y3Qg
ZnB1ICpmcHUpOw0KPiANCj4gSG1tLCBzbyB0aG9zZSBmdW5jdGlvbnMgaGF2ZSAieHN0YXRlIiBp
biB0aGUgbmFtZSBiZWNhdXNlIHRoZXkgdG9vayBhbmQNCj4gQHhzdGF0ZSBwYXJhbWV0ZXIuIEkg
Z3Vlc3Mgbm90IHN1Y2ggYSBiaWcgZGVhbCB5b3UgY2hhbmdpbmcgdGhlbSwganVzdA0KPiBwb2lu
dGluZyBvdXQgd2hhdCB0aGUgbmFtaW5nIGxvZ2ljIHdhcy4NCg0KSSB3aWxsIGFkZCBhIHNlbnRl
bmNlIGxpa2UgdGhpcyBpZiBsb29rcyBmaW5lOg0KDQoiVGhlIGNvcHkgZnVuY3Rpb25zIHVzZWQg
dG8gaGF2ZSDigJh4c3RhdGUnIGluIHRoZSBuYW1lIGFzIHRoZXkgdG9vayBhIHN0cnVjdA0KeHJl
Z3Nfc3RhdGUgKiBwb2ludGVyLiINCg0KVGhhbmtzLA0KQ2hhbmc=
