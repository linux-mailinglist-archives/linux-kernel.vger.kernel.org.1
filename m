Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063352FD67C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbhATPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:47:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:47281 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732906AbhATPnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:43:33 -0500
IronPort-SDR: PRtgN3QjHjp9LtKG2ok21zxToTY6Nth0uVR2hR7Y/LV1cl5oRAu4nihTKZgnMNdrUqdk2M50r2
 VBPKxbkrjY3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="176553810"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="176553810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 07:42:42 -0800
IronPort-SDR: TXDQUlSzkvCgA4d4w+Xj6UdtNbPRCKbOsBjAOMYCZ5/oEFBR80SL+11okvMykUoyQo0suegKO8
 uCGN30Gnktlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="402776904"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2021 07:42:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 07:42:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 07:42:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 07:42:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 07:42:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFwu//dt4MuZjU29drHB+tTSrkY7C/Es3Ys0q7y6RISGXP4v0uCBWH+LibanNuRRHtLAJ21BOJfcn2AX1DMG6jhTtl39fqOgfsX6V5N29RZqCw4uKGMXZgzxeVyA+K0A8qJglPTiLlBBa1I/4jr1hgxzHc0t8qS/gfvVVDjq3wk/o8DDUkd5lYQ7LZKCGHj+KpyIBBBe+c9UV6Eu0IpcEkthhNowGQO4GAAXkwHfWd49mDG8vBEhmDwwABnQVw7wtDbgtEL17wF6PZP8tgBfxURjyTFIem8Gat1ibQ8Zt8YHgiTI8ftz5mPqHXKGviTl+rlQlOatw4olB1YF3gNnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7PBC7YrTZRQd2yc9rm2+ddj14q2RBGO3BnFQkVy/g0=;
 b=HKJ4zkJeAq/1UMKCoFPe5ASJTQPO6VWCXY7RSPgfrxcERDc4f2GeWot0hqGc9zZuVquJt95A7d2umUg+f4w1Nt8Xc1+Otj+wm9GTXdqUsHkgDajeUQ2JXqisKhQj3ht9foy8kI2cziDu1fJF2YU2lYHmlQHba5dRkd3R32zJh2kE7IfD+gQHDSf1ezJplvPTpd6VRTM+SgsdAZGJGgXhRyGqg5ChOn3x9dAxyvyvX5UpJm8LnKo3bqqHiQ6BpYOvaRgICy8frXOwFQzbgcZbXkYIiDo9ADA3cBFPG6INpi0XsT/yxqgv2/PkTApoLHpgCasl+bfzV9Ud7IVY4FyfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7PBC7YrTZRQd2yc9rm2+ddj14q2RBGO3BnFQkVy/g0=;
 b=vRDqCG9kEwKd0eL6sq71AsQij8W4lm3FdShO4T9lMiygRFQA/6/D7PMvu3RA7sfgCk0VhhLiXXvRXcPmGwMgfpyRrX4UiAhv31lmdDdBtAcy/0SUnWoo4wSR7MQuCf3zw0pTElUGKOic7in+uj4aLbMnO+cjfmyRzfQ0zpGRbFs=
Received: from DM5PR11MB1690.namprd11.prod.outlook.com (2603:10b6:3:15::11) by
 DM6PR11MB3915.namprd11.prod.outlook.com (2603:10b6:5:19c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10; Wed, 20 Jan 2021 15:42:34 +0000
Received: from DM5PR11MB1690.namprd11.prod.outlook.com
 ([fe80::8929:bef9:ffe:569e]) by DM5PR11MB1690.namprd11.prod.outlook.com
 ([fe80::8929:bef9:ffe:569e%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 15:42:34 +0000
From:   "Metzger, Markus T" <markus.t.metzger@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "tdevries@suse.com" <tdevries@suse.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: gdbserver + fsgsbase kaputt
Thread-Topic: gdbserver + fsgsbase kaputt
Thread-Index: AQHW6EXGGSDS0D32IEu+vSvpt9UFe6oizxgAgAAJLICAABKQAIAAmVKAgABFJ3CAAG0rgIAAAXewgAAD8oCADHOucA==
Date:   Wed, 20 Jan 2021 15:42:34 +0000
Message-ID: <DM5PR11MB1690E8B8831D6758F03EE646DEA20@DM5PR11MB1690.namprd11.prod.outlook.com>
References: <20210111200027.GH25645@zn.tnic>
 <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <5B5C1F0A-9780-4E42-BC65-742BAEE920BF@intel.com>
 <DM5PR11MB1690CB5004CADCE5E9D5A221DEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
 <CALCETrUzsx2gpJGwz4fwLTLTKG4i=izaGRYL-3dLrn389JV17w@mail.gmail.com>
 <DM5PR11MB16906085295875E670FC163CDEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
 <CALCETrU5aHtJdJ29xSNCrXdycYMW=gsT7WzBT3-+GJqCEMM-dA@mail.gmail.com>
In-Reply-To: <CALCETrU5aHtJdJ29xSNCrXdycYMW=gsT7WzBT3-+GJqCEMM-dA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.89.55.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02149659-de73-498d-9842-08d8bd5a01e1
x-ms-traffictypediagnostic: DM6PR11MB3915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB39153F88B6FED335C375436CDEA20@DM6PR11MB3915.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5n8uz7Zt/knc7A9eyCtPa8tKUMXtePsRvEK0wah/9eWyIJU/+KVOzXegInwCHkXlOfLuBL1nB7eKRnwOBR961Qr4RadSZk3Gme7bIOU79wXF+bkY/CV7ug29xUTXF8nxSulz9132cJ0XMIdbsTqBgancGuD3fZlyvZaPgcovAbf4mLzgMSp7xlVJHLX8lxLwan2lCm71nxtU/hl9KS//aEpl4tMBSnprqIOi9qTNkAHjKfRg8iKPJxA48j/ZLr1Xz9/uuD1zHJjqjjn4lCkz8gnHPDUKeOur1jbHKe+azO7bJWu1mfRcHHeJ1ahjdobf484QhjSx5DXLjrzTzBmacowOS0xNXmYxv0+JP/XPbokP3X8CMk0BNqNlAwAGHKmXX9ZDWvH3oeClw09x3APzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(52536014)(33656002)(4326008)(316002)(9686003)(55016002)(6916009)(186003)(2906002)(8936002)(26005)(53546011)(71200400001)(7696005)(478600001)(6506007)(83380400001)(8676002)(54906003)(76116006)(66946007)(86362001)(66476007)(64756008)(66556008)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZXluQnRUTWZ6cHJSekx3cDVHeHRMRC80N3dveTFHSjdya2Q3TU1ERnBJSEYr?=
 =?utf-8?B?WlByTm5QREhpMktSdEMwYnhuK3krOGhkUDdBQ2xwYy9ra1JvL3NKUzdpblo4?=
 =?utf-8?B?Wk94ZGp6b1A2QTcrSm9pbm10eFZ3bkhGbXFlQ3c0VTltc0hLNHIxRjMvQ0Zs?=
 =?utf-8?B?V3BJTW5YcWMwOFNINXdNVlhHcEhYdXFodzZOUUs0a2lmODlpcWsxR0J6cmhq?=
 =?utf-8?B?bFcwTTFBeDBGNnZ1bmRUSGVEcjR2OHhRUnhxSHN4WllaNnQ5cWl3VDNWYkpz?=
 =?utf-8?B?ejNhSTIyRWVHTjVEOFhNdlRzSGNiVEtHdE91UWs5MUtlYTRiNVNBVHZZYUFq?=
 =?utf-8?B?OUk3RGRuQUlQa1dQbTRGM2czd1F4dWNlWDk1ZG1jeGIwVmdhRFJtemlxVlZX?=
 =?utf-8?B?M1pMeWRMUEo4TzUxcWRzbGFtSTNJTVBDSXYrcXdQNnp3MmdhNkNTTGRwVDI3?=
 =?utf-8?B?R1d6Q2J6YVUzbEEwMXVZanZvTkI4WWllS3pzb0tON3crZDNwYTlFTXlFb1R1?=
 =?utf-8?B?dEl4L3hjNGRuc0dWejVFNk9IUnJqdmxjOGRIK3FHdExNOUZhc0YxZC9YQk51?=
 =?utf-8?B?ZS9ZUHVwNjYyd3ZWRUQycXRONng3SEY4Q1R1WXpuV0J6eXk0c2FvWkpia1Y5?=
 =?utf-8?B?QnQrMEh4bldGRmwrK1A0MVRmODFNMDNhU24zN3piNjgyL0NieCtISENMYzBh?=
 =?utf-8?B?d0ovNFo2SkZaWUpTQlVZYTdWTHdqRDdXYytqY1hEbGowek1SMlBtSTNMWkRz?=
 =?utf-8?B?MERSckNEcGp0R29nbGVNbU1wd2tnWmNVaVZScjdGcWU0NThvTytFZ004TTJY?=
 =?utf-8?B?akNWWEo5VlNWaHdMN0EvUlJqZUtIQ1dpT1dzR1VEVzNDeU1RQVFyR3FldHBN?=
 =?utf-8?B?QTlNRTBpWm1BTEtudFpkV1BDYXV3cVJLbXNYMWFkRGx5VlZMNXFtYmtiRzJk?=
 =?utf-8?B?UkQ1enV3UyszYUdZQU9sRVZmU2cvL0UvTmg0b2FxcEJNSGFuS3I0NlpyYytY?=
 =?utf-8?B?NzhXLzVNaGhjMzBZM0RhYzBkZWZpdWF0SFJzT014RzZxYzdKbWl3OWtZOTR2?=
 =?utf-8?B?ZitlY0NCY3N2cHBwUEpFcm4vNTVTQmlVallYdjBSYmtJeHMxbEoraTFFZnJw?=
 =?utf-8?B?NkN6ZHNPMUtPSEcxWHd0QVpsbmVVbkFlSE0wNmI4ZHkzalJ6Vk5rTlR1c1o3?=
 =?utf-8?B?dU94eUNOdysvQU13cjBmK05wamVtSkYyd1ZMMUlzUTZOaXluR3pIOW9tdzY4?=
 =?utf-8?B?YWNaLzE4SG9nMTZKN1EyYUIzbXhHd0hVWU9GQ0E3UGorWjdXZzkvVW1rQ1I0?=
 =?utf-8?B?RitURGEvczVwc1NVdmRGMzVuckpzbWJDdituRi9qcW1SWTh6VEdaZmpkcm5I?=
 =?utf-8?B?WkRpcE5MUThzOHViaEZwZFVXRHR3YXo5cXJidFhIbi92eGd2SmYwZ2lxcENW?=
 =?utf-8?Q?affQKEja?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02149659-de73-498d-9842-08d8bd5a01e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 15:42:34.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJaBN5KjvzxpmDLQdSS8OrsGoV1CeK+57/t868uTaHgev2IN+tcQy0HZ93jRBlTj5R40es68e/IsogkplLMa1bqpSc1XjmuQAo2hvm/Sa0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3915
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gDQo+IE9uIFR1ZSwg
SmFuIDEyLCAyMDIxIGF0IDk6MDIgQU0gTWV0emdlciwgTWFya3VzIFQNCj4gPG1hcmt1cy50Lm1l
dHpnZXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gWyAgIDI2Ljk5MDY0NF0gZ2V0cmVn
OiBnc19iYXNlID0gMHhmN2Y4ZTAwMA0KPiA+ID4gWyAgIDI2Ljk5MTY5NF0gZ2V0cmVnOiBHUz0w
eDYzLCBHU0JBU0U9MHhmN2Y4ZTAwMA0KPiA+ID4gWyAgIDI2Ljk5MzExN10gUFRSQUNFX1NFVFJF
R1MNCj4gPiA+IFsgICAyNi45OTM4MTNdIHB1dHJlZzogY2hhbmdlIGdzYmFzZSBmcm9tIDB4Zjdm
OGUwMDAgdG8gMHgwDQo+ID4gPiBbICAgMjYuOTk1MTM0XSBwdXRyZWc6IHdyaXRlIEdTPTB4NjM7
IG9sZCBHU0JBU0U9MHgwDQo+ID4gPiBbICAgMjYuOTk2MjM1XSBQVFJBQ0VfU0VUUkVHUyBkb25l
DQo+ID4gPg0KPiA+ID4gVGhhdCdzIGdkYnNlcnZlciByZWFkaW5nIEdTIGFuZCBHU0JBU0UgYW5k
IHRoZW4gdGVsbGluZyB0aGUga2VybmVsIHRvDQo+ID4gPiBzZXQgR1MgdG8gdGhlIHNhbWUgdmFs
dWUgYW5kIEdTQkFTRSB0byAwLg0KPiA+ID4NCj4gPiA+IEkgY2FuIGNvbWUgdXAgd2l0aCBob3Jy
aWJsZSBrZXJuZWwgaGFja3MgdG8gdHJ5IHRvIHdvcmsgYXJvdW5kIHRoaXMsDQo+ID4gPiBidXQg
Z2Ric2VydmVyIGlzIHJlYWxseSBnaXZpbmcgdGhlIGtlcm5lbCBiYWQgaW5zdHJ1Y3Rpb25zIGhl
cmUuDQo+ID4NCj4gPiBJIGFncmVlIHRoYXQgdGhpcyBsb29rcyBsaWtlIGEgR0RCIGJ1ZyByYXRo
ZXIgdGhhbiBhIGtlcm5lbCBidWcuICBHREINCj4gPiBzaG91bGQgcHJlc2VydmUgdGhlIEdTX0JB
U0UgdmFsdWUgaWYgaXQgZG9lc24ndCBpbnRlbmQgdG8gY2hhbmdlIGl0Lg0KPiANCj4gSW5kZWVk
LiAgQnV0IHdlIGhhdmUgdGhpcyBwZXNreSBuby11c2Vyc3BhY2UtcmVncmVzc2lvbnMgcG9saWN5
IGluIHRoZSBrZXJuZWwuDQo+IA0KPiBTbyB0aGUgcXVlc3Rpb24gSSBoYXZlIGlzOiBpcyB0aGlz
IGVub3VnaCBvZiBhIHJlZ3Jlc3Npb24gdGhhdCB3ZSBuZWVkDQo+IHRvIGhhY2sgYXJvdW5kIGl0
IGluIHRoZSBrZXJuZWw/ICBUaGUgc3BlY2lmaWMgYnJva2VuIHVzZSBjYXNlIHNlZW1zDQo+IHF1
aXRlIG5pY2hlOiA2NC1iaXQgZ2Ric2VydmVyIHRhcmdldGluZyAzMi1iaXQgdXNlcnNwYWNlLiAg
SXQncyB0YWtlbg0KPiB0d28tYW5kLWEtaGFsZiBrZXJuZWwgcmVsZWFzZXMgZm9yIGFueW9uZSB0
byBub3RpY2UsIGJlY2F1c2Ugc2Vuc2libGUNCj4gcGVvcGxlIHVzZSBwbGFpbiBnZGIgZm9yIGxv
Y2FsIGRlYnVnZ2luZyBhbmQgZ2Ric2VydmVyIGZvciBkZWJ1Z2dpbmcNCj4gVk1zLCBlbWJlZGRl
ZCB0YXJnZXRzLCBhbmQgc3VjaC4NCg0KSU1ITyBJJ2QganVzdCBmaXggR0RCIGFuZCBsZWF2ZSBp
dCBhdCB0aGF0LiAgVGhlIGtlcm5lbCBjaGFuZ2VzIGV4cG9zZWQgYSBidWcNCiBpbiBnZGJzZXJ2
ZXIuICBUb20gYWxyZWFkeSBzdWJtaXR0ZWQgYSBmaXguDQoNCkknbSB3b25kZXJpbmcgd2h5IHdl
J3JlIGNvbnNpZGVyaW5nIHNvbWUgdWdseSBoYWNrcyBpbiB0aGUga2VybmVsIGZvciB3aGF0J3MN
Cm9idmlvdXNseSBhIGJ1ZyBpbiB1c2VyLXNwYWNlLCB5ZXQgaWdub3JlIGNoYW5nZXMgdG8gR0RC
IGZ1bmN0aW9uYWxpdHkgKGZvciBjaGFuZ2luZw0KRlMvR1MgZnJvbSB3aXRoaW4gR0RCKSB3ZSBo
YWQgYmVlbiBkaXNjdXNzaW5nIGEgeWVhciBhZ28uDQoNClJlZ2FyZHMsDQpNYXJrdXMuDQpJbnRl
bCBEZXV0c2NobGFuZCBHbWJIClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMC0xMiwg
ODU1NzkgTmV1YmliZXJnLCBHZXJtYW55ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVs
LmRlCk1hbmFnaW5nIERpcmVjdG9yczogQ2hyaXN0aW4gRWlzZW5zY2htaWQsIEdhcnkgS2Vyc2hh
dwpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUKUmVnaXN0
ZXJlZCBPZmZpY2U6IE11bmljaApDb21tZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVu
Y2hlbiBIUkIgMTg2OTI4Cg==

