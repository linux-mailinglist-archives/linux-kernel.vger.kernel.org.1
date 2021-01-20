Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2476D2FDCF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 00:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbhATViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:38:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:41619 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387754AbhATVNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:13:13 -0500
IronPort-SDR: 71c/rb501LxtwXa6axP30g/LR6Sf1/HAqqrHWkpqYptGVlS/eWWSdERdj8O2ybIuH7psw+IILM
 WMDCFweTdvhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175671820"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="175671820"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 13:12:23 -0800
IronPort-SDR: bYw+U+z9wqT8EDOV5HAtttz64i0vtzOSfrj0eQDzTTpikP4tbGMTkacn36v7WLNcDYzaVkbfkC
 JF9X/GBCfcFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="407021913"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2021 13:12:23 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 13:12:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 13:12:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 13:12:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQg7vu34eiK3VGaNNxaPz2ilwghTo7A4Rupi2i4pZm9lI5NrakoxMakkd+rp0b/xzPYeCekgGaiPOrNpiVJliSWVhkGuhQJG53SNKL0YGvMaN7Z8svaBUyK0EetRoOyMQbw9jVXgozRw8BdoBJrCevdhjfDtCEGcwm6UEw8I26rpQAQurdT77CWa/ZCmkCERIiQXTHpa1l19JSm3CJr2DyevYfB3bpAetpzIGR7ehfgrDSGYxjbEKSnq2/5rZjy8Dq8m4CFJVih2/TIv/B9UgsdFSh0006h4oyjq1/2oShLrJmDxDhB2LxeX5pDLkFtS8fEh8zQjvvUSD+p4czti/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFPuXjzCOojBiGc5SdlsPVj1lPD1oMOQAdX+SSf4ECM=;
 b=jVULoDHP+vTF/vePHZ24TylNQcNCY+vMr4LXKEC2RlO/xasplaPUXRRrHZeSwO3RAgRiHXf34t2V5Etx1DYzTJtEY4lVGm6PCqjHDGCSrMjLdV2l3Dk6ehs7kNe97JNo8L26iTMOSwu3IX9B897kgrnTu5UKbCMIue6JUQihmuU1fp5P/Y8sOmwg7Dt+E099mmTYzibDGhJav+iCJ2rR9lfkFnVVHduHeZQG9w7R9fghGJmvHf8FKo6hHXdik1SoTcscCiogHVk5Xkk4F6GoLEk8gOV2wkbsQfGrY5HloCsXVYwaxha7mCjKXYqU/EFBsZ6HufGxQogDataw8RflVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFPuXjzCOojBiGc5SdlsPVj1lPD1oMOQAdX+SSf4ECM=;
 b=FZQxoTsV24cNPcuLu4e4Ba1nk40xV5ijiyuHvQvDNHyQI5u0CJTG6UWeJEtWWYJh0bBsk97VzvuAbl/YS0c0F7RabhsYKJbj0cRCBqHyDxQJzWRBO27bHi1kCHx033UM7Oqn1Ulxy2YdstdMPNIKNyzauUj6MmhTaYhXDh5h9LQ=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 21:12:20 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 21:12:20 +0000
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
Thread-Index: AQHW2UTpqPiXR+Ajm0+sop34hrXbfaoox44AgAat7ICAAbS2AIAABSWA
Date:   Wed, 20 Jan 2021 21:12:20 +0000
Message-ID: <4CE7A300-8DD6-4037-AECE-AB94F75A7D59@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-3-chang.seok.bae@intel.com>
 <20210115125048.GB11337@zn.tnic>
 <F06B741E-25C8-4777-9576-3684FF649F1E@intel.com>
 <20210120205354.GE3467@zn.tnic>
In-Reply-To: <20210120205354.GE3467@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b300726a-49be-4c0f-8639-08d8bd88132f
x-ms-traffictypediagnostic: PH0PR11MB5158:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB51580D12AF45A5ED0470C191D8A29@PH0PR11MB5158.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+KhoJ4ExLx/KcX5HdpxbYGsz8CBIbDbgbzuUuBqZ+vcaQEqqLESDKs21hyWpbXSOkr8HcDiDLPUCt5qSJiWjm0RHxqN/JNs0oZHsCVQm+VmyFpBDYcx0lwwCrOVcZjzhNHwdPCtBqq2I0ukC1+4EaF3CekCve6K/gzqRMj45FamNlxfg5maPfyhlIgdc4YyvAOqSyhac0Q57x/AtWL4h4Skq9k17bXabEQY5uol/IcgsUt7+U1z0nrzPEpbxCt/Bvb6QGHH7KxW/W0EIMofO5NbChuLbohBWhzpr2Ezm39nnhNXiDmvoxjo8QroAyKAyA2Se5BvEEKvKcVnQHkGDA94R+rcmF8Pq0Vb7KKLOGiJOtCYj/i/fdpU4pLlWMbCMYtecDj3B0TL3E3lNGxNbkZAVCnC+EwqtOWFwQ5HlVRzI8VkmKD2l1MTyavuqwGo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(8676002)(6486002)(54906003)(6506007)(8936002)(4326008)(76116006)(66476007)(86362001)(66946007)(71200400001)(478600001)(2906002)(33656002)(66556008)(64756008)(66446008)(6916009)(316002)(6512007)(36756003)(26005)(53546011)(186003)(4744005)(5660300002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c0JNRzNoalRmOU40R3VNVk9jdTlTZncxL0g3SnZWU0l5aGtvTFBpSWpqU28w?=
 =?utf-8?B?UTh6Umx5QUNvN3h1QUREQU1YZFJ5ZS9mV0F4bVFoYlJsTWFiMFZhdUo3VlRa?=
 =?utf-8?B?VjJyWXFYMzdMM00xTHZSMGR5OVBnekwrbWswS09MTGpoaGUxblRjZHRHRVRt?=
 =?utf-8?B?WHFpSkl4UzkyU1NweVY3ekdyN3ZSMkVBRXZwcjBuRVM2M3VFd2hRZkx1ZUJW?=
 =?utf-8?B?elN0TUUzaDdTQnRmQnBPYzd0TWdYK3ZFUitNOGlndEEzbDVwQTlMdTh4d2E5?=
 =?utf-8?B?T1dIMWVWd2lkWTlLSmR3UjZSRFhqM09iUC9jQTd3bFYvUzhXRXhPSnJqdnVj?=
 =?utf-8?B?UzhpYjVaY1d1WW10ZmtMOU1qTEowdldVMVFYQUdZMk5xemNPRjZBSWsvZ3h3?=
 =?utf-8?B?a1hqS3QxSUc0UnZHbXM5QTU4UytnYU56QTY5Q3dFVkZWQnBYb3UxQTliWnFX?=
 =?utf-8?B?Mm5XRVEvbWMxMjdYR21sSzNSWkoxelVZT3dFV09uclVDcWhFQnl6WS9pdnEr?=
 =?utf-8?B?ckd1c2N3bnd6U3dBb3c5MHgwQkRPUTQvUnBMUnZzRGJKTTEzYzhJRXdZeC9o?=
 =?utf-8?B?WkFVYXNmMldjYmNsWjgrVFNDd3Q5elpwS1JtR2ZFclVTdnlZLzE5blBvVVBC?=
 =?utf-8?B?RVN5WTAxdnhZTXF6RUxmRFJ6S1hxaTlWNlV3VU5MNExZSHh5RXRnek5PcnNW?=
 =?utf-8?B?WWFZMU1ZbUpSWDg5N01ORmFZUDNPdlBkS1dxdUcvNzRoV1lQSFBTRnZLd2Rn?=
 =?utf-8?B?UVlyekEzZmxrS29BaFZSZGtUYU9TN0pxWHpTNUJGYS9XWFpQSTZkMWhmNnZC?=
 =?utf-8?B?YktQMkt5cEw1VlNUOG5TZ2JDazNadlhQaEJKOGtPcURwUXZtM1A1T3pGY21V?=
 =?utf-8?B?TGF6Wm9hTDFocGV3ZHpZNTlPaldXUnl4TWhaN1RYV2lOQ1hJbit6Szhpem01?=
 =?utf-8?B?YW5VVzZ6elhiL2ozUFNGeFJJb1BseWh0bkFxQlViRW9CQ2htb2JPUXRacEVt?=
 =?utf-8?B?eE9HOC9VeVhQRVR4OUhrUCtZTTdHbXNJY3Y4bThkNnp6SUg2MkkzQkdoK2Q4?=
 =?utf-8?B?YURHQ0ViczYwWVlDaVd3R1I3d1krWDBsWUF3U0NoSEpUNGJRQ1VHTFI3bjdH?=
 =?utf-8?B?NThrRmJGVERmVTg3Q3U0OWhzdnR2VWN0a0I3UkRWV2FPSXhibDlMVjQ1UitK?=
 =?utf-8?B?NHR0alNMWmJVaFFFWXZzT2hFNW5qZm9RaW96UVJodUpWWWNFRnRXUU1LRUFs?=
 =?utf-8?B?TnVEajFQbTdEMEhpZUpHdnpQMmhuR3poelpIMFc5VjBaTjlHNmVzWEZXeWRX?=
 =?utf-8?Q?Z8HJYmqH6pbUb9tptOm1tJnC6lbzYtwKhR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C3EDC983B5C6E4287476757D4141716@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b300726a-49be-4c0f-8639-08d8bd88132f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 21:12:20.6296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6deCwmeiHUV8tucQRYB+ez6+FDVUtdFA1ehAVLsu83qG1NAXPOS9oTkOZ7OfgSirVuD2f9SDztk4i+oisF9+AOOG0irPWgrWEuiEI1bslJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSmFuIDIwLCAyMDIxLCBhdCAxMjo1MywgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gVHVlLCBKYW4gMTksIDIwMjEgYXQgMDY6NTA6NTJQTSArMDAwMCwgQmFlLCBD
aGFuZyBTZW9rIHdyb3RlOg0KPj4gSSB3aWxsIGFkZCBhIHNlbnRlbmNlIGxpa2UgdGhpcyBpZiBs
b29rcyBmaW5lOg0KPj4gDQo+PiAiVGhlIGNvcHkgZnVuY3Rpb25zIHVzZWQgdG8gaGF2ZSDigJh4
c3RhdGUnIGluIHRoZSBuYW1lIGFzIHRoZXkgdG9vayBhIHN0cnVjdA0KPj4geHJlZ3Nfc3RhdGUg
KiBwb2ludGVyLiINCj4gDQo+IFdoYXQgZm9yPw0KPiANCj4gSSB3YXMganVzdCBwb2ludGluZyBv
dXQgd2hhdCB0aGUgbmFtaW5nIGxvZ2ljIHdhcyBhbmQgdGhhdCB5b3UncmUNCj4gY2hhbmdpbmcg
dGhhdOKApg0KDQpPaCwgSSB0aG91Z2h0IHlvdSBtZWFudCBpbiB0aGVyZS4gT2theSwgSSB3aWxs
IG5vdCBhZGQgaXQuIA0KDQpUaGFuayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhpcy4NCkNoYW5nDQoN
Cg==
