Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A342FC0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbhASUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:15:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:56995 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbhASS6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:58:10 -0500
IronPort-SDR: UDGckkfZvI4TxxowEfDGFfle7qrma2qV5IrGEFcP/sUzdCzUSOejQpC4QTx4G6snaQylRlzA6C
 pcRVVppvtn3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="178201958"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="178201958"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 10:57:29 -0800
IronPort-SDR: bd5kC3vb2I9I33abUbPwkEldzCbttRF/nH7rrAQSklip8New4+FBcGRNSI61ezXUCR09cql1TR
 w+Goppj0/+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="353890933"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2021 10:57:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 10:57:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Jan 2021 10:57:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 19 Jan 2021 10:57:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jkd/EYF1D0WqAQuH6RbwUb0raKoDjfeMis52d7bsaIsoOVnUOm0KqGK66hmjqEwEjdNIulyRVT2blg2sUTDfTxiSpmJNFUVYVPC+FsLo8j8ZeNdmP0dLh+PM/HSkgVyZRWyq8FEEO3qZjbKb7pMbhSux+AuiqhkkvqmSuMzKoVWHpmPeUn41oUs4Apd6z2QZdlr11hai+rRjLON1W4Se0zVbW3yBEmVrLF3lD6TdTWkZnI3Ig8exCWU4KJjf2LRchyPJw1k0pmICzcUUD16SO+mkLGmm86GvmdwKCsDabfWfGyzbP2iBBoJ52OE2770zd3xtQ6Gkh9jceKnYrVtuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5eXdmd0YWBN+tRubltpQWg7zyDFdZpYCdX/aq2Ck70=;
 b=eXEm1Y0Hb0CZpSjHDN6o11TKEHJlqeaPRMgEuRTZAF/QMgViKcQb1wep5+1mNwokedN49bCE5SzhbgCeOOLAEImQiRpj8GBw2fFC8BU+u8s8OIYuod/MNRjZCF62lFoiG+ZJNtYypypEVdx0PjPg/QT1M2WC0dT/DFo6SZjpHnP1o0FHQY3/4F8frzgQFZBwdoWBgAX+IvDf6xQmGiM62vFLP3yOmbP4Mxv0q/pLk8MnyebEkuMsgGObnaw/bTz8Itne2WNdTiIkCdiB0Dw5llPVbhaTBorV0FxvZQ8oATrXu9MmxSrUP1lH7r3bVGRJb1MOiu2dNUw4tbpz1HCXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5eXdmd0YWBN+tRubltpQWg7zyDFdZpYCdX/aq2Ck70=;
 b=HZ7hs7C9K360Qi7CP543eNLY2nWQtTnuoMWZGCHiwxF2bS+StnWbsZas30W7LmwR9djiHADmLa0AZalOzgUffwsYTcu6MqjP/IPYnBN0X8Jr4g5nf2qbBskTJ7XCIt0X1fXycfTJ2NSJqi6C/Efthj3tCPgj0VBiQxFUI4oTsXI=
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MWHPR11MB1311.namprd11.prod.outlook.com (2603:10b6:300:2a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 18:57:26 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 18:57:26 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/21] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Thread-Topic: [PATCH v3 05/21] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Thread-Index: AQHW2UTormq3m1yC2UO34PiN5/gVtKoo1SIAgABm4gCABgkoAIAAMiUA
Date:   Tue, 19 Jan 2021 18:57:26 +0000
Message-ID: <EF7FB3DA-868D-4597-B841-F786E094BFCF@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-6-chang.seok.bae@intel.com>
 <20210115133924.GE11337@zn.tnic>
 <E7E5BE72-C3AB-4ABB-93B5-EF040595442E@intel.com>
 <20210119155758.GF27634@zn.tnic>
In-Reply-To: <20210119155758.GF27634@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c9614fc-9bac-4a11-2d47-08d8bcac1057
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB13110213F3F345D252CECDE0D8A30@MWHPR11MB1311.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:256;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLZfhnzB9bGgE04CPXvoPrun/28cm/wTMEyZyQflfwo/1OpgMJNZDfTY1RA4T6lnc8fxX618oI7Kb8W5NaqC1VPAj2YsAV1ofzxvPFtcC29s3rocZJ7pB4pO6hSDvAq0+fOqc5EEH0cYSS/4PHRIXfOgKHj7NuskhbutxVwQ4aFDoQK0zHG8xphT9CkLp/ayA+NyssXjjb7cV6CBsZbRgc5bt1jCM6vCOKCn5vI6WsYrcABM/mka1r1kVYOqZq1KXqy62YEtMNyqkdm5wv5ZqHFnSbrCh+LZR86kFMXqYXdJvMB5viBNptLVDf/hP+ugq9qC5z+QWHt69fOsp1wuh06wel9NF7BNKx1ax2hMb6Ohe+46xzow1oDPHdO0hjLPJio7qM70Oklf18f/01VFJFq26uiQEIVF+4nlholnKqUvo4SbkOKdNtmrxVTBKe0AS21+GD0JqfLxm2sEjiYlyqYuH7+y+NgnUbci9LvJ7Hts8ZDq++Pzj1D6S9MUAFgW1CeCU50UEY+HZFJij1ONzA11E/8g9eQ8wx33OlfOc5q/btNOkBlnoEWZcP9qTK2gGJxMVLSObndV+LwaMdUE1acRsLAoaxIdkkbzqd3ahAJQaa15rfkvnYyeT5h4V5YxMLdHwJt3tIInqF9lIec9Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(6506007)(4326008)(5660300002)(8936002)(66476007)(76116006)(316002)(966005)(53546011)(54906003)(83380400001)(66446008)(6916009)(2616005)(26005)(66946007)(6486002)(186003)(2906002)(6512007)(86362001)(64756008)(33656002)(478600001)(36756003)(71200400001)(66556008)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VVRUUU45cmtveUp6a2FSdm16K01kcDR4QlQ3RXVQM1FBUVRpTit0SG9VdkdS?=
 =?utf-8?B?R0lTZzBSWDVpT1VRYXUvb3A2M1E4Z09wWWlnS3JUeUZhNzgrL3FrVnpXcXJR?=
 =?utf-8?B?bm1VdlNKTVcrRnJMM3Z1ZzVTQ0tuS1YwSlF4aFBDK09HVEt0Z3NRZ3d2NXdq?=
 =?utf-8?B?eE1JS21QaVB4Zld0L1pHNzJQbk5saEVTWllOaHhZY0tRN1NSOTczbGpzOU5l?=
 =?utf-8?B?TnE1RmdIalJQQVh1S0F4QmJlOHExWUxNOHFXWlg4Mm9IbE91ZFdTbDVkeVdC?=
 =?utf-8?B?a2U1enVmOGlCa21tUGFhRXFNanQzZHRTRVlzSHVSdjd0V0NDSE52bmppQUlN?=
 =?utf-8?B?cllnekdlbEgwb3BCNElReGNMRFV3ZU5lbEhVUE5paFErb1RuL0M3dHVOM3Jx?=
 =?utf-8?B?blg3VmU3RmdocEozLzBWT0xpcTZha3FrY1JWZzkxaE9QekpubnM5Z2poYkIw?=
 =?utf-8?B?aVBJS0h4Q1NkV3pKMENKWXQrSUFmT0Z6d3ZyRUtZZmNrYnBTWjAzSVpYZ1Nl?=
 =?utf-8?B?YzRIMjZJNjc3RGUrWU1WNW1vU0N1SExkVGJOU0NUS1d6TC8zaXRiV1FXVFJH?=
 =?utf-8?B?clRkWi9CUUhrR0l3SFNuYklyQXpSeDMzRTkvQXU1RWtjenNaWFgvV2xTajN6?=
 =?utf-8?B?bEtWUUZLZS8vMTk1aElnL1FSMzdobG4rVk9wRHZ6Q2J3Q1U5UjlXcWtnUWxo?=
 =?utf-8?B?MFhoQ05FK3Y1VWlYT2FYTlhqTmRFdjVoMGJ0ZkFSOW5kdUt0RXVnbEJqMWJE?=
 =?utf-8?B?dHl6aXhGNWxqK3hHejVJYU5UYUp2dVlhTVNvY213d3gxWnNVUys4VzVoUmFP?=
 =?utf-8?B?SnNwdWZtaXA4TnpmUjFnVXNCY1cyZkQrMzdITjZqRnlwdDRFeGErM2VkK0x3?=
 =?utf-8?B?RzNrTjl6WndNbWtLM3IxUnZ6alRhdTNrY0xKZFhaQkxCV0Zrb1JyL1M1RVFw?=
 =?utf-8?B?eGxBSFQvcnRqcUpYbHJWL3owNUtXSklSVmc2dW4ySU4wYVg4Wk9OZnJnUGkx?=
 =?utf-8?B?SnVPeGtXaWJDb3dsa3ZOclJOUFdvSGZyR1VWTE1xNVZLNXNtdXJwU21MK0E2?=
 =?utf-8?B?RW5XSkN5YngwOGJ6aGJrc2JSYUFRc3ZsVldNOUFqTU9aS2x5bEJzMHhIdHp2?=
 =?utf-8?B?cEJKeTg2OERtQjRXMHh1R24vZGxhVTFDTHl2VWVKVEpPOUlRU0pEbFlZNDJW?=
 =?utf-8?B?VlRYc2RXd1daQXk5ekdPaUkwNHZxelJUZG0ydlA2SzdHdVRFdHMzOXlMeUJ5?=
 =?utf-8?B?UnB3blNqOWRuRVhoQXZ2ZVFPbVVZVTRuVUphblc5TTZ2OFZ5WFN3aklCTkly?=
 =?utf-8?B?NnM1NTJXZ3dHQ01lUFMzcGlmVHlCVnRRSWxuY0gzUjUxcWRMdU1mVEJVQ3pm?=
 =?utf-8?B?OXJQcmtKTVc2OFh4cDhzc3ZEWGMxVVIvYlhjRys4ODgyckFjckdLZHdKam01?=
 =?utf-8?B?YW0xT3dIRHUvOTRDbC9sOWRFYUQvVWJreWtESzlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <410FED22CA80A74DA9E41855E383F66E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9614fc-9bac-4a11-2d47-08d8bcac1057
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 18:57:26.5539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbDl/Y2Q80hqc7uSu4fVOzJv6pnmvJvmQw+8Ir5eZCtiV1lFaPDAD2rkzgcDiyD/fQ8b2maOLh9JT/2Lvo+fv9pH6vz98Nn43NSkyd8AvxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSmFuIDE5LCAyMDIxLCBhdCAwNzo1NywgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gRnJpLCBKYW4gMTUsIDIwMjEgYXQgMDc6NDc6MzhQTSArMDAwMCwgQmFlLCBD
aGFuZyBTZW9rIHdyb3RlOg0KPj4gT24gSmFuIDE1LCAyMDIxLCBhdCAwNTozOSwgQm9yaXNsYXYg
UGV0a292IDxicEBzdXNlLmRlPiB3cm90ZToNCj4+PiBPbiBXZWQsIERlYyAyMywgMjAyMCBhdCAw
Nzo1NzowMUFNIC0wODAwLCBDaGFuZyBTLiBCYWUgd3JvdGU6DQo+Pj4+IFRoZSBwZXJmIGhhcyBh
IGJ1ZmZlciB0aGF0IGlzIGFsbG9jYXRlZCBvbiBkZW1hbmQuIFRoZSBzdGF0ZXMgc2F2ZWQgaW4g
dGhlDQo+Pj4gDQo+Pj4gV2hhdCdzICJ0aGUgcGVyZiI/IEkgaG9wZSB0byBmaW5kIG91dCB3aGVu
IEkgY291bnRpbnVlIHJlYWRpbmfigKYNCj4+IA0KPj4gTWF5YmUgaXQgd2FzIGJldHRlciB0byB3
cml0ZSDigJhMaW51eCBwZXJmICh0b29scynigJkgWzFdIGhlcmUuIFNvcnJ5IGZvciB0aGUNCj4+
IGNvbmZ1c2lvbi4NCj4gDQo+IFdlbGwsIEknbSBhbHNvIGNvbmZ1c2VkIGFzIHRvIHdoYXQgZG9l
cyB0aGUgcGVyZiBidWZmZXIgaGF2ZSB0byBkbyB3aXRoDQo+IEFNWD8NCg0KVGhpcyBzZXJpZXMg
YXR0ZW1wdHMgdG8gc2F2ZSB0aGUgQU1YIHN0YXRlIGluIHRoZSBjb250ZXh0IHN3aXRjaCBidWZm
ZXIgb25seQ0Kd2hlbiBuZWVkZWQgLS0gc28gaXQgaXMgY2FsbGVkIG91dCDigJhkeW5hbWlj4oCZ
IHVzZXIgc3RhdGVzLg0KDQpUaGUgTEJSIHN0YXRlIGlzIHNhdmVkIGluIHRoZSBwZXJmIGJ1ZmZl
ciBbMV0sIGFuZCB0aGlzIHN0YXRlIGlzIG5hbWVkDQonZHluYW1pYycgc3VwZXJ2aXNvciBzdGF0
ZXMgWzJdLiBCdXQgc29tZSBuYW1pbmcgaW4gdGhlIGNoYW5nZSBoYXMg4oCYZHluYW1pY+KAmQ0K
c3RhdGUgb25seS4NCg0KU28sIHRoZXNlIHR3byBraW5kcyBvZiBkeW5hbWljIHN0YXRlcyBhcmUg
ZGlmZmVyZW50IGFuZCBuZWVkIHRvIGJlIG5hbWVkDQpjbGVhcmx5Lg0KDQo+Pj4+IC0jZGVmaW5l
IFhGRUFUVVJFX01BU0tfRFlOQU1JQyAoWEZFQVRVUkVfTUFTS19MQlIpDQo+Pj4+ICsjZGVmaW5l
IFhGRUFUVVJFX01BU0tfU1VQRVJWSVNPUl9EWU5BTUlDIChYRkVBVFVSRV9NQVNLX0xCUikNCj4+
PiANCj4+PiBJcyBYRkVBVFVSRV9NQVNLX1VTRVJfRFlOQU1JQyBjb21pbmcgdG9vPw0KPj4gDQo+
PiBJbnN0ZWFkIG9mIHRoZSBuZXcgZGVmaW5lLCBJIHRob3VnaHQgdGhlIG5ldyB2YXJpYWJsZSAt
LQ0KPj4geGZlYXR1cmVzX21hc2tfdXNlcl9keW5hbWljLCBhcyBpdHMgdmFsdWUgbmVlZHMgdG8g
YmUgZGV0ZXJtaW5lZCBhdCBib290DQo+PiB0aW1lLg0KPiANCj4gV2h5IGlzbid0IHRoYXQgaW4g
eW91ciBjb21taXQgbWVzc2FnZT8NCg0KSSB3aWxsIGFkZCBpdCBvbiBteSBuZXh0IHJldmlzaW9u
Lg0KDQo+IEFsbCBJIHNlZSBhIHBhdGNoIGRvaW5nIGEgYnVuY2ggb2YgcmVuYW1lcywgc29tZSB1
bnJlbGF0ZWQgYmx1cmIgaW4gdGhlDQo+IGNvbW1pdCBtZXNzYWdlIGFuZCBJIGhhdmUgbm8gY2x1
ZSB3aGF0J3MgZ29pbmcgb24gaGVyZSBhbmQgd2h5IHlvdSdyZQ0KPiBkb2luZyB0aGlzLiBZb3Vy
IGNvbW1pdCBtZXNzYWdlcyBzaG91bGQgY29udGFpbiBzaW1wbGUgZW5nbGlzaCBzZW50ZW5jZXMN
Cj4gYW5kIGV4cGxhaW4gKndoeSogdGhlIGNoYW5nZSBpcyBuZWVkZWQgLSBub3QgKndoYXQqIHlv
dSdyZSBkb2luZy4gVGhlDQo+ICp3aGF0KiBJIGNhbiBzZWUgZnJvbSB0aGUgZGlmZiBpdHNlbGYs
IGZvciB0aGUgKndoeSogSSBuZWVkIGEgY3J5c3RhbA0KPiBiYWxsIHdoaWNoIEkgY2FuJ3QgYnV5
IGluIGFueSBzdG9yZS4NCj4gDQo+IFNvIGhvdyBhYm91dCBleHBsYWluaW5nIHRoZSAqd2h5Kj8N
Cg0KSG93IGFib3V0IHRoZSBjaGFuZ2Vsb2cgbWVzc2FnZSBsaWtlIHRoaXM6DQoNCiINClRoZSBj
b250ZXh0IHN3aXRjaCBidWZmZXIgaXMgaW4gcHJlcGFyYXRpb24gdG8gYmUgZHluYW1pYyBmb3Ig
dXNlciBzdGF0ZXMuDQpJbnRyb2R1Y2UgYSBuZXcgbWFzayB2YXJpYWJsZSB0byBpbmRpY2F0ZSB0
aGUgJ2R5bmFtaWMnIHVzZXIgc3RhdGVzLiBUaGUgdmFsdWUNCmlzIGRldGVybWluZWQgYXQgYm9v
dCB0aW1lLg0KDQpUaGUgcGVyZiBzdWJzeXN0ZW0gaGFzIGEgc2VwYXJhdGUgYnVmZmVyIHRvIHNh
dmUgc29tZSBzdGF0ZXMgb25seSB3aGVuIG5lZWRlZCwNCm5vdCBpbiBldmVyeSBjb250ZXh0IHN3
aXRjaC4gVGhlIHN0YXRlcyBhcmUgbmFtZWQgYXMgJ2R5bmFtaWMnIHN1cGVydmlzb3INCnN0YXRl
cy4gU29tZSBkZWZpbmUgYW5kIGhlbHBlciBhcmUgbm90IG5hbWVkIHdpdGggZHluYW1pYyBzdXBl
cnZpc29yIHN0YXRlcywNCnNvIHJlbmFtZSB0aGVtLg0KDQpObyBmdW5jdGlvbmFsIGNoYW5nZS4N
CuKAnA0KDQpUaGFua3MsDQpDaGFuZw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8xNTkzNzgwNTY5LTYyOTkzLTIxLWdpdC1zZW5kLWVtYWlsLWthbi5saWFuZ0BsaW51eC5pbnRl
bC5jb20vDQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNTkzNzgwNTY5LTYyOTkz
LTIyLWdpdC1zZW5kLWVtYWlsLWthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20vDQoNCg0K
