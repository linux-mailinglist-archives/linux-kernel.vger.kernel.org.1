Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531152FF929
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbhAUX6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:58:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:24053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbhAUX6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:58:34 -0500
IronPort-SDR: lqatZo2StZ2yZV/JY/PVvB9j0Sg1pufR1o8J9Lh9LUt85yI+DF0hTJAoXvlAsACgq07xdGUVyr
 ev+lLTd9Sm3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="243444822"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="243444822"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:57:50 -0800
IronPort-SDR: Op+18qhmQDVBJTQigyT+sIXj5NixyTqRqt//2mjr4GbcSWRMK9XMLmsmYEqCWcZXFp6ky07Eow
 BuGQYVE/G6FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="571881458"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2021 15:57:49 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Jan 2021 15:57:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 21 Jan 2021 15:57:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 21 Jan 2021 15:57:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE/PAhkFVlSpLmr5e8pmN7DA+YyGRVaLuIktWSx6cOyAIatxEAx45fjhA55PwI+uqSp1gw0NQro1Z7pW0Hrbl/w/vgL4LS95Ljlk4LxOopN9eJ7OGO35d5b3XAPwYJAz0AKBXN+daEDtkGBmEE3tZRpvKLo9meoG+8lXxO8ve/9P/Vr4XWTu7RxK0nTQ78OOyhUyX7TXmJmIEAmEbZW0UG1kj1ra5z32IG7C9L87vh4k+ejXP9kSSBlhcSif2rh877YDSNrtOOJrDN2+qiB72iQUEpTFEJoV4o7nNYDrL9XfyqTzwinnKTPqg+S5L7epgU+m8o5vtTDa8AZzydLSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR/YpmnalRxlfXrPaJo5GlYWPZUjGo9OJO9qXCfmKnA=;
 b=NNi6iM8yHewnmhdWG19DO5jrE7bMpIDbPVnyEM/flhRX2d+dLPFqZjcn/wPvjBXWUVVdWpwu0M3DiKZyU9YKSayLu1YWlkYVoRBeOMkN9PLOvGbBU8XxLqI+O5iQJcXqBStJlbaE8cC4iNWs7mRLJAPkuHykcc2hmnr4HKfzs6f34ZKMy9Lp/kQUAdQbytHfsvb1P2pyy3ixRmdWBruET/73h1nlzomBP+3yCjNGcGVdqFJDTBQrUFBhAWy4BV6+UTzKydWKiUDulUAeCfSuSJbWSQk4zrn0pnnew6+1hVA15ubTa60vyL2Zujp5BCyKHQv9AvA4dH4ktG2/OezkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR/YpmnalRxlfXrPaJo5GlYWPZUjGo9OJO9qXCfmKnA=;
 b=Ogh0KTOe0UWuK+vGTabZUX4VVr4GJ4t4TQlr1iOPE+qJo45x7hLhkCEXBr/org9bkl4X2b+CvTPJcGMI0+iGR5gJS1zdWUn8koJ2MVvcZNq5qOB8qXz0XI4DpBSkx6FKEWoMaKrqPj7KOwNPLZQ65u3t1JNERjOv+B81kZxTHt4=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3071.namprd11.prod.outlook.com (2603:10b6:805:d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 23:57:48 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::ac4a:f330:44cb:fbf4]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::ac4a:f330:44cb:fbf4%7]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 23:57:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dja@axtens.net" <dja@axtens.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/vmalloc: Separate put pages and flush VM flags
Thread-Topic: [PATCH] mm/vmalloc: Separate put pages and flush VM flags
Thread-Index: AQHW75asTmKzTSCmMEG+p0UOrmrjN6oyEO4AgACyUgA=
Date:   Thu, 21 Jan 2021 23:57:47 +0000
Message-ID: <838bda4c00d1a93e5146cf89ac0f42a64f0fc61d.camel@intel.com>
References: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
         <20210121131932.GO2260413@casper.infradead.org>
In-Reply-To: <20210121131932.GO2260413@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f343dfe-f631-4218-45fa-08d8be685ac2
x-ms-traffictypediagnostic: SN6PR11MB3071:
x-microsoft-antispam-prvs: <SN6PR11MB3071D6521003DA5809FDBE72C9A10@SN6PR11MB3071.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4SbpfhD9sdMZDoIPkI+cI7Qu7cjHimuYNudA7F8FwY8dm/wbfXe9ootcZfihsoeYuuHa6+Vu14NoOAIrPN96EeZVWfBKvapc+l3tq/F9JyBDoXCnSHvAEbDrVOFEbQg5/TRk8cVLJURAe8unSqVa/40t4R67xyqF97klovPT3LoDmGs4/2Jzp7dFI3fcwwYrFiLp6Ua7lMQa2y15v1aHLqrCqXG9YFL/bMxR/uvrTF2AsE1HX8HusUZ+cr8qaVqqxt3i9iRjbA0YxqRJDJzrXRKZAyeNfrtf+6VULeQBTJFT94YR3FY3TvqiDdLU/cQTdEwROjO6jDTsArLugQriMljrhJ9NOovu3Q//MNPflZF/sy6AY7P4jZ7qi5weRYW9QFXxZg4agwnbrYURWDQ0ttFk2LT/i3F4gpaeYEh0fCREjpbQzHr/6DXnu2W3APsnPd42Yn484bd9BRHSpyQwgTbskZPdhLlrjJgKKKUQVq+IGmeY03fkocDJiGfTeib81qPFv1Ru03U4NO+nwfvmNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(66946007)(66476007)(86362001)(66556008)(6916009)(478600001)(26005)(6512007)(8936002)(36756003)(66446008)(316002)(54906003)(8676002)(71200400001)(91956017)(4326008)(64756008)(186003)(4744005)(5660300002)(2616005)(6486002)(76116006)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NmUrdjgwVVN3WkJRcThXUitWeEFmaWNaSkZ1d1BvUWIrYkYyem8ySERHb1hk?=
 =?utf-8?B?YTljK2d5SXlVZDJzSjM1VjZOc0tzVzFXQklpVXdMKzByL3paT0hFK3NnZDIw?=
 =?utf-8?B?WXdmNnhxMko4Qk1pcHF1M3lXaU5LNVM0UDA4b0lHMlc2U3cwbUp1aU9PMjQ3?=
 =?utf-8?B?a1Jpc21JcEVXTWlvYmdveTl5MDA5Y3RmaEVaalR4NWVIeXJFMi9nWjUwUGpL?=
 =?utf-8?B?Q09wbHZjUnhYUVBNL04wMU9nbElWeXRIZHA0YjBab3RsY1liaXplWlhEZXBX?=
 =?utf-8?B?aUsyTXUwcEtKSzcyOWtUZ2JyREt2cGs0RlZ2MEQybkFTYWFTUXZnNC9veS9J?=
 =?utf-8?B?RHpvS3Q5aS93dDYxeU44RFp3YWJMUmY3dGE4TzZtcDl6a1Vlb1ZZSlluaTYx?=
 =?utf-8?B?WHQwL05YYjVOY2pOY3ZaMm9pVzBLcXBUaVJQL1orOVlmMFdDZ1NLVUVlK2Q4?=
 =?utf-8?B?VzVhOG9TbnVZODRZR1lJckl3eHU4cGtiZTRmb21rV3dsRHJaQkFBMkltSUoz?=
 =?utf-8?B?YUhMNFJQak5ieUgyeGZpOHl6U0llYUZ4Z1ZFQ3JZM1FFVVdGNTc0K1IrMnRK?=
 =?utf-8?B?b21nQloxZm9KMjNtZ0JpVktLQ1VEdlhoemNuWnhaZjVQOUtnT2Q3S3M0aCtO?=
 =?utf-8?B?SGo3YzZ1Wk52VmRlRmU5WWVpdTIzWDJYdGpEaEpvSTJJdlI3Z214VTFmSGYr?=
 =?utf-8?B?OUMrVkcyakVGL0poREhvWUJJQlV0NDZQMjdLZEZXWjZ1SERGL2xLUGhHeEFO?=
 =?utf-8?B?TkdVZ2krUEtaajdYbHNZd0dBRnN1ZXJZVk9zRFBQTitPSnQxRVNuQ3dRMSt5?=
 =?utf-8?B?c0Z1LzExUVJGSHVzR2dSM3B2cEV6cVIrREdhdWFSdFUvMjR2V1ZDTFFWeXF0?=
 =?utf-8?B?ZlpURTFaNHNqVWxUYTlsRTcxV0VTaVNaTllLOUJxZVRJU3lKSkE5M09uckVp?=
 =?utf-8?B?c3kvWHZtbC9ibzVnMU9sWlB6bkhEUFRPM3U0WWNqMTU4Mm44UkpZcUwvZFY4?=
 =?utf-8?B?bGIxbktrdWo1VWpFa3ZyTnJuNXBPNGdrWFh3QjRGUGE2QVE4VjhxWnA5dm90?=
 =?utf-8?B?eDZOMW9WaXMySnVtbUpYMGVBWFJGejNrUjZ0WnZzQkxpTEFqK0JqQ1VEMklR?=
 =?utf-8?B?eGhaZnhTcWtWb1R0MGtUU0c2OEJjRFNOOStaVW9nVjFVTUZUeTUzdVJZQmw5?=
 =?utf-8?B?REZtMlljbjhGcldzUWd3RXZCaGV1bUxFUXNFNGZEL0VFTkw5ajVSSmR5TXIy?=
 =?utf-8?B?TGFZMTI2YTRYWE50RWlSQjlkMlQxVGFDaVIwR3NGQU85VFViQ3h1Vm14MHhE?=
 =?utf-8?B?TVI5S2UvWWVhcm5JNlh3b0xSazBPLzMzY015Q0h3Ynpic3gxdUp0UGFpKzd3?=
 =?utf-8?B?MXRsV3RiQi9Jc3FPUHFnd1VuR3NiWHRIYmRvYUUwbXRGcm1FMWlxc29La29l?=
 =?utf-8?Q?w1WIRuD4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF313B4BED8F87478020F26C62985D32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f343dfe-f631-4218-45fa-08d8be685ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 23:57:48.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fq4lafedsw5cqlplezSATjzWvoAdy1GWELx0czzMkpSFvO+it4K5ofIQERqScuh25W8MDYUlGBjEE1kpI2vaO15hy1m2WlaQVIqispCSov4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3071
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTIxIGF0IDEzOjE5ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gV2VkLCBKYW4gMjAsIDIwMjEgYXQgMDU6NDE6MThQTSAtMDgwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gV2hlbiBWTV9NQVBfUFVUX1BBR0VTIHdhcyBhZGRlZCwgaXQgd2FzIGRl
ZmluZWQgd2l0aCB0aGUgc2FtZSB2YWx1ZQ0KPiA+IGFzDQo+ID4gVk1fRkxVU0hfUkVTRVRfUEVS
TVMuIFRoaXMgZG9lc24ndCBzZWVtIGxpa2UgaXQgd2lsbCBjYXVzZSBhbnkgYmlnDQo+ID4gZnVu
Y3Rpb25hbCBwcm9ibGVtcyBvdGhlciB0aGFuIHNvbWUgZXhjZXNzIGZsdXNoaW5nIGZvcg0KPiA+
IFZNX01BUF9QVVRfUEFHRVMNCj4gPiBhbGxvY2F0aW9ucy4NCj4gPiANCj4gPiBSZWRlZmluZSBW
TV9NQVBfUFVUX1BBR0VTIHRvIGhhdmUgaXRzIG93biB2YWx1ZS4gQWxzbywgbW92ZSB0aGUNCj4g
PiBjb21tZW50DQo+ID4gYW5kIHJlbW92ZSB3aGl0ZXNwYWNlIGZvciBWTV9LQVNBTiBzdWNoIHRo
YXQgdGhlIGZsYWdzIGxvd2VyIGRvd24NCj4gPiBhcmUgbGVzcw0KPiA+IGxpa2VseSB0byBiZSBt
aXNzZWQgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEVyIC4uLiBJIHRoaW5rIHRoZSBwcm9ibGVtIHdh
cyB0aGF0IFZNX0ZMVVNIX1JFU0VUX1BFUk1TIHdhcyBwdXQgYXdheQ0KPiBmcm9tDQo+IGFsbCB0
aGUgb3RoZXIgZmxhZ3MhDQoNCldlbGwgaXQgd2Fzbid0IHRoYXQgZmFyIGF3YXkgYXQgdGhlIHRp
bWUsIHRoZSBWTV9LQVNBTiBjb21tZW50IGFuZA0Kd2hpdGVzcGFjZSBnb3QgYWRkZWQgbGF0ZXIu
IEJ1dCB5ZXMgbm90IGlkZWFsLg0KDQo+IFdoeSBub3QgdGhpcz8NCg0KMTI4IGNoYXIgbGluZSwg
YnV0IGxvb2tzIGJldHRlciB0byBtZS4NCg==
