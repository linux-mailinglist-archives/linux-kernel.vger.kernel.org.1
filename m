Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF02F85B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbhAOTsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:48:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:8695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbhAOTs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:48:26 -0500
IronPort-SDR: sTMQhEa9dKj8Rln8qefw7k33wBAo9VxMUvArhgl+oCG1gylJ0gq4XFKQHr2hHrkLqYkWZItXBS
 DH8IhMEWJG2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="177820526"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="177820526"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:47:45 -0800
IronPort-SDR: UN1Rp+Qf00BQRpr87B68E9Nz5fQGWVrnHSJqyL2fpSD5a3rC3oU3nzTAMnlC2PLPhCHTF8GtdY
 8Dyn0aX/HcRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="500034700"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2021 11:47:45 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 Jan 2021 11:47:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 15 Jan 2021 11:47:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 15 Jan 2021 11:47:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQnRHTZJF71r+Ui4+V6JZ9UOKP6Y/I6N8Kazlur/wKZmFjUQvIyxXwNUmjdWN9r8Oyncc1VTF3BiTdwSVDVEuM/FpSYYU23i9CAxovmIm5FYP3MV1gwt3stWd97xnhBxCxp38R5kyxvk/Sm0tve/wC+sgKUYVzyoTBcOQ9IiCzvYiuaDmrI8e/B/I1GTqIyo406XMsk+ap1ungkt3PcIr7zLjjPDUPb5rwHsPLz6lKotaBxunZ+oUrOV90oytr+snNVT28rihiIg6Z/+Pdhj3BantnYmuUsJxsNQrOGIOU+C1cKdKHi8O0YzIOOLoK02EdA5ow6rTITag0ImE8+T1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT3tTNTKXLHO0dN2z0IQyWyGShgh9AZ/4t5pHrxzpqA=;
 b=BcruIM0ieqPOwp3UBGKsjaTaJoDaSpb3nwSGIXuoIoOEx77GM7c04SJ2NKwaF1B9Rey6bPD6LoD+qATB+whruTb/DdRow2LwWOUBuw3zDpXCylBHK3kco3VOEf3dac89hMQ5RpzsXhdA/9Gjpt6aCMeVOcqCErRi5Y6UOAH8B2foey8X9f2VP/5j5QUgD7x0Xcsj9KMcmXHTz3USuXuukVxGdXHarwnfH5lG5oxpD52jG1pCUvlkOC4KHyN4VtKa8SMD2nVKZOBr38V8FkuCdCluI2s5HGcTzVgYcQ7riJhFWtME9ZtxiLxzj/cDsAE/erK5UBVaHhxdqyMmLMddBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT3tTNTKXLHO0dN2z0IQyWyGShgh9AZ/4t5pHrxzpqA=;
 b=daWCR8EZz0vyVhIY4qAGkgLR304dS+o6Omt6TPHEfR0LGoyH3WU6q05IJezDyhn2u6tjlyVM0yg1Txoa75XE59/EgBbJks4wMRV0LVBDGooMSRAiSF5yjZBMQXvlrYt70HzE9OR3diuqVgChYF/yQ314ACDbPArfCI3DffNBcuc=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 19:47:39 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430%6]) with mapi id 15.20.3763.012; Fri, 15 Jan 2021
 19:47:39 +0000
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
Thread-Index: AQHW2UTormq3m1yC2UO34PiN5/gVtKoo1SIAgABm4gA=
Date:   Fri, 15 Jan 2021 19:47:38 +0000
Message-ID: <E7E5BE72-C3AB-4ABB-93B5-EF040595442E@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-6-chang.seok.bae@intel.com>
 <20210115133924.GE11337@zn.tnic>
In-Reply-To: <20210115133924.GE11337@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0d748f8-6968-476c-6f89-08d8b98e6a24
x-ms-traffictypediagnostic: PH0PR11MB4982:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB498211B79C86F6056B8A6833D8A70@PH0PR11MB4982.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ajTRs4f6cW8aJNEv4GYuUGgXoxqLsL+xw+SHDgoyeVz+rbohpHBU5cS/ObCElVVz+NSqhZJofCMwGMTiyLV/f3upY6bIvf/eEkUeeaAHu4dQPNQFBZG6PnQ01rpn+kURQXr8TvR6bfYSLnvD3G2ESt5WNJcRnbvRvSw0XnTTqTh3gCa6JgPWjXDy6E0IXSsYojXv18weqy/pbeZ9z1afQeki/cfOJtMlns3NIxuirWnsgi5uUh11GRlQivh9NzbQPoodChHF/sVjE4LJ++61OzXwu8/TO30E19h6dLKUX+nJj+rIBwTjIq85uJmWzDSW/fpTY4hbgAa6+AJUEaRDwPmI3zfgVXSaT0xBJyq9KKr7pRTBsCJJ5nudHJWwKCM7/Moi/uZPSzWE0T7ZYumx51/Oq1FPb0EJMTNFZpoVn3+b1zLQNx5vXFHrscWCBszAUtiTOHOYgwADpZnzCmG96RPF5TKl9CrdnFhkUPHVqR6iZ0fZtayftMsUNGc+70nuG4gaaSSfd+BeNS9TqZOYWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(316002)(66556008)(66476007)(4326008)(2616005)(64756008)(2906002)(6512007)(33656002)(66946007)(66446008)(54906003)(71200400001)(6486002)(76116006)(8936002)(966005)(5660300002)(478600001)(53546011)(86362001)(6506007)(6916009)(26005)(186003)(8676002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aVRSdTRTWkRTRXpDc1FWOThmSy8vN3EzQkF4emJrSDFpYk85aW9WMDhobkdL?=
 =?utf-8?B?YzJ1L3cyQk0rV1lsWERMWE8ycGFhN2o1c1htaEdKMU1CcWVlNUhXWVFTbW9Y?=
 =?utf-8?B?ZGkvK09nTXRxamEwMW4yM2NjY1JiWTF6OElYNU9JdHU2QmYyaXoySW5zRk5L?=
 =?utf-8?B?T2crS0w5MVZOVGxlT3BocUdEZHpyMENUVDZ3S1Q5ekd0UUdIU2EvakxEc2gw?=
 =?utf-8?B?YXhjRUVuL2tWOUQ4WDBWdGh0YldOa0VFZkZwS1d0bk9TZWJLdWZtSXhBSGE5?=
 =?utf-8?B?cWJzZDcyLzZETGxkbHo5MCsvSi8wOExKOHMzVFJxcUh3WFBCby9EVzltVkNn?=
 =?utf-8?B?dDhXS0ZSbk1hbnloek8rRE4zc2V3b3FlZGtlZzhQMEdpeTNveVB2SFVBMkgr?=
 =?utf-8?B?eXFwV05BUUVTb2I2OHpYUWhFa0tpOVUyWDJmSE1VSDZyZCsvRkhyNmJBZjds?=
 =?utf-8?B?a3ROTmM5UzlmNE5tOWZ1emNtY2phTkI0RFUvK2h2R2dacmlKSDZFeGdRRDBK?=
 =?utf-8?B?d3g3aWJCUElpcDVpc2hmSCtYM1c4Q1JZVlpxSytqNG9EakUvb3Erejd3OU1Y?=
 =?utf-8?B?aHFaK3d0SWpRaGN4cnRrV1dBdVZyNmNkbjJML2JHMVNQemVxYTNiUldocHk3?=
 =?utf-8?B?L2R3cTZESlBnWnBPYmlCZjM0Ty9uVCtmR09GV1E3c21EUThlWXpyU3ZBVG5p?=
 =?utf-8?B?MTdYU0NGblR5RDFVNjZtQ2FIS1U1RVd1dE5YZlFhY0pCKzRVMHh3YWQyVHFX?=
 =?utf-8?B?V2owejk0RXdYdS9mNVFUZlZOcVpsNFFZaSt3aS90TVNHRWJqTlRkSkZDZDNm?=
 =?utf-8?B?NGZjMjd2WXRScHNWdlNFSnBEc1k0Yy8xUnprMTVKL2p1eUdLQ0FDK2d1bnZ4?=
 =?utf-8?B?UmhiaXZHU3k0V0YrVVhMT2Y4OTdPQUphelRqOGIvdU5ZVEtBbml1MnJGZTdE?=
 =?utf-8?B?VmJnZlVlUklaOFNyb0FFT0pRRVMwMFJoelpwUmJnTU12d3k5ck95VHJkQ3JD?=
 =?utf-8?B?cDIyVW5rQ2ZXVXJMcUMwQzhzbXBzckdnV1VHSzJVS3N6M0FDeEJ3eGtRT2FY?=
 =?utf-8?B?WDBWMm8yRDkwMnlQTzllNStwL0QyWS9aTVNvVE03ckpMMWMxOWsvV1A4K0du?=
 =?utf-8?B?V1JvM0VqbWY5WVhwWElRZEZleVZmcGdpT09UU1hMYVdxcjBxWlVLQW56dkRW?=
 =?utf-8?B?ZDZnKzRPYllKWDNDbG1BdmdsQmRUU1pqaFpaOHFuKzlUUkJ3dEdjR1NBMEUx?=
 =?utf-8?B?T2JBOCtvc2VSaUxQdHdJdm5rVWVvVW1rb2huS2VhUjlkTytMbkQwNSs2a2VX?=
 =?utf-8?Q?0gZi8KtE+ib4Zd5SK6AU15kca8AZybd2M2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB30E300C53A3941A106055DD51A8672@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d748f8-6968-476c-6f89-08d8b98e6a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 19:47:38.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNz44H6kDRFo0ARa7wO4Z16rYesd4PIzpCpgIospAN11gDmCbLMYADw7/8l/ddj+SWj+1gvjhvdifGaBkqw/hzDxkzSIV/5xCtjK1EZzosQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSmFuIDE1LCAyMDIxLCBhdCAwNTozOSwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gV2VkLCBEZWMgMjMsIDIwMjAgYXQgMDc6NTc6MDFBTSAtMDgwMCwgQ2hhbmcg
Uy4gQmFlIHdyb3RlOg0KPj4gVGhlIHBlcmYgaGFzIGEgYnVmZmVyIHRoYXQgaXMgYWxsb2NhdGVk
IG9uIGRlbWFuZC4gVGhlIHN0YXRlcyBzYXZlZCBpbiB0aGUNCj4gDQo+IFdoYXQncyAidGhlIHBl
cmYiPyBJIGhvcGUgdG8gZmluZCBvdXQgd2hlbiBJIGNvdW50aW51ZSByZWFkaW5n4oCmDQoNCk1h
eWJlIGl0IHdhcyBiZXR0ZXIgdG8gd3JpdGUg4oCYTGludXggcGVyZiAodG9vbHMp4oCZIFsxXSBo
ZXJlLiBTb3JyeSBmb3IgdGhlDQpjb25mdXNpb24uDQoNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9mcHUveHN0YXRlLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUveHN0
YXRlLmgNCj4+IGluZGV4IDI0YmY4ZDNmNTU5YS4uNmNlODM1MDY3MmMyIDEwMDY0NA0KPj4gLS0t
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZnB1L3hzdGF0ZS5oDQo+PiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9mcHUveHN0YXRlLmgNCj4+IEBAIC01Niw3ICs1Niw3IEBADQo+PiAgKiAtIERv
bid0IHNldCB0aGUgYml0IGNvcnJlc3BvbmRpbmcgdG8gdGhlIGR5bmFtaWMgc3VwZXJ2aXNvciBm
ZWF0dXJlIGluDQo+PiAgKiAgIElBMzJfWFNTIGF0IHJ1biB0aW1lLCBzaW5jZSBpdCBoYXMgYmVl
biBzZXQgYXQgYm9vdCB0aW1lLg0KPj4gICovDQo+PiAtI2RlZmluZSBYRkVBVFVSRV9NQVNLX0RZ
TkFNSUMgKFhGRUFUVVJFX01BU0tfTEJSKQ0KPj4gKyNkZWZpbmUgWEZFQVRVUkVfTUFTS19TVVBF
UlZJU09SX0RZTkFNSUMgKFhGRUFUVVJFX01BU0tfTEJSKQ0KPiANCj4gSXMgWEZFQVRVUkVfTUFT
S19VU0VSX0RZTkFNSUMgY29taW5nIHRvbz8NCg0KSW5zdGVhZCBvZiB0aGUgbmV3IGRlZmluZSwg
SSB0aG91Z2h0IHRoZSBuZXcgdmFyaWFibGUgLS0NCnhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1p
YywgYXMgaXRzIHZhbHVlIG5lZWRzIHRvIGJlIGRldGVybWluZWQgYXQgYm9vdA0KdGltZS4NCg0K
UEFUQ0gxMy8yMSBoYXMgdGhlIHJvdXRpbmU6DQoNCiAgICAgICAgeGZlYXR1cmVzX21hc2tfYWxs
ICY9IGZwdV9fZ2V0X3N1cHBvcnRlZF94ZmVhdHVyZXNfbWFzaygpOw0KLSAgICAgICAvKiBEbyBu
b3Qgc3VwcG9ydCB0aGUgZHluYW1pY2FsbHkgYWxsb2NhdGVkIGJ1ZmZlciB5ZXQuICovDQogICAg
ICAgIHhmZWF0dXJlc19tYXNrX3VzZXJfZHluYW1pYyA9IDA7DQogDQorICAgICAgIGZvciAoaSA9
IEZJUlNUX0VYVEVOREVEX1hGRUFUVVJFOyBpIDwgWEZFQVRVUkVfTUFYOyBpKyspIHsNCisgICAg
ICAgICAgICAgICB1NjQgZmVhdHVyZV9tYXNrID0gQklUX1VMTChpKTsNCisNCisgICAgICAgICAg
ICAgICBpZiAoISh4ZmVhdHVyZXNfbWFza191c2VyKCkgJiBmZWF0dXJlX21hc2spKQ0KKyAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7DQorDQorICAgICAgICAgICAgICAgaWYgKHhmZWF0
dXJlX2Rpc2FibGVfc3VwcG9ydGVkKGkpKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgeGZlYXR1
cmVzX21hc2tfdXNlcl9keW5hbWljIHw9IGZlYXR1cmVfbWFzazsNCisgICAgICAgfQ0KKw0KDQpU
aGFua3MsDQpDaGFuZw0KDQpbMV0gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvUGVyZl8o
TGludXgpDQoNCg==
