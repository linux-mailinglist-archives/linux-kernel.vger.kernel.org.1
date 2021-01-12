Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961802F3674
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbhALRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:02:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:20703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391414AbhALRCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:02:48 -0500
IronPort-SDR: CcxofnbyZYJwzO9k7IVZKKmAk8S1QFRbfmbLEZqsvqiDvgXEdqlCFQFwn/kjHBBpyb5/kAFd0/
 tHWebHg/vNAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="177297241"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="177297241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 09:02:04 -0800
IronPort-SDR: FPF1VjrBiykhE+6juMGRl63I9VDB1r/Fq7ClOgXD8SQOfLHWVlQB13R//ZggKFEt+gALcb24Jk
 00B0m1mQOtDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="345264082"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2021 09:02:04 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 09:02:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 09:02:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Jan 2021 09:02:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 12 Jan 2021 09:02:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufa4utfQ+JQCVtlQLHtz2flVIUxXTGxBft3+zG7iZ0MtgXEdN+ekVf0OAJ+NuTNmaBtKfhepJAeDfz7hhndQwD05EBSsr/SH6+obzr5WHJ2KgqZjl1Qfv5CVVVpy9Z7Rzx70uVcgsx1KGzfXn8yFMQ46X3OZzJ+0j1cvncYQFsKYYlFsYome2PU+CEEJQKfT9sQ1ZiQL3C3NGX5MwxfYSNXWq2kQrv0Te2xrs6ZaSO9T+QShFgCowThzN1sFGyj/N+83X2alSnLtgxZu9NuCskRVbin7UPXYYxEBHbVE1rWuXehoQQGWpo4ucF6NDrZ3OlWD3HcES/emrpvThay+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijoJbVU89Q/XBE0eVLq2uH3zAOHVx4ynjIVI67bJO1I=;
 b=H4w9BvdoBLC19/Zbehz/VZgTLP/8Ge+7RURnskMDDXrhVl6SmyyN+ZyzxlAA02NkZbT60dQiY7nalBEpI/JwDeklgv8YPwStY2xoyZi3dgVzQ8QyfpxubB7if1z0cgN34j7P5TrnQvRCuy+l0QR/dIO+KkrfvNyGMcU2L7/JRD+AUgCtt8lKoULac4jLI3FwyO7xh+04K7JcwuzM0+66oDNTD6WZs8/hmYRzknP5jt6XI4RjkNBPKujnbGDPF1Ap4QLMaiZpV3p7QBtCozblUI8IW6r3OC1qFVO7GJCA2eZP69e6H5QnDlVbUT2rHx6dHvxZaGnf8iLk/m6KQoMPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijoJbVU89Q/XBE0eVLq2uH3zAOHVx4ynjIVI67bJO1I=;
 b=EtmhRTvatqTk0AgxrpnyssnF+kXC2n7RwreqXUTKDyXlS32cdxxtZajE5LOrtgzLEbzpKBRksjsuAsBwKZZFmx7TIJCbFrDq4D4pVR9yxY1yD0+LOonWDLdR7payRWsWKZDn6YtbnHwfODl7QjJ7DePKyMDi4YqSMRgQE2w32+g=
Received: from DM5PR11MB1690.namprd11.prod.outlook.com (2603:10b6:3:15::11) by
 DM5PR1101MB2154.namprd11.prod.outlook.com (2603:10b6:4:4e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Tue, 12 Jan 2021 17:02:02 +0000
Received: from DM5PR11MB1690.namprd11.prod.outlook.com
 ([fe80::8929:bef9:ffe:569e]) by DM5PR11MB1690.namprd11.prod.outlook.com
 ([fe80::8929:bef9:ffe:569e%6]) with mapi id 15.20.3763.009; Tue, 12 Jan 2021
 17:02:02 +0000
From:   "Metzger, Markus T" <markus.t.metzger@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "tdevries@suse.com" <tdevries@suse.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: gdbserver + fsgsbase kaputt
Thread-Topic: gdbserver + fsgsbase kaputt
Thread-Index: AQHW6EXGGSDS0D32IEu+vSvpt9UFe6oizxgAgAAJLICAABKQAIAAmVKAgABFJ3CAAG0rgIAAAXew
Date:   Tue, 12 Jan 2021 17:02:02 +0000
Message-ID: <DM5PR11MB16906085295875E670FC163CDEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
References: <20210111200027.GH25645@zn.tnic>
 <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <5B5C1F0A-9780-4E42-BC65-742BAEE920BF@intel.com>
 <DM5PR11MB1690CB5004CADCE5E9D5A221DEAA0@DM5PR11MB1690.namprd11.prod.outlook.com>
 <CALCETrUzsx2gpJGwz4fwLTLTKG4i=izaGRYL-3dLrn389JV17w@mail.gmail.com>
In-Reply-To: <CALCETrUzsx2gpJGwz4fwLTLTKG4i=izaGRYL-3dLrn389JV17w@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 7db90467-745e-4e74-6475-08d8b71bc820
x-ms-traffictypediagnostic: DM5PR1101MB2154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB21544185A412D66983C290F8DEAA0@DM5PR1101MB2154.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2tWdfNlxHi1xtD6Bnu1EcmsLuWMuoEpLkpWNilPQL0/xDhCtg06hEaTQk4a1D5v5yjCHfiA5P0nc6TgNtM95cVleaDFtVRce+AQsPdwwHOloOjR3ABKqzqZBnrhrkdWzHoqCE9Vu/8CFoiVEOLOfW0x/uH0x2ModUROwKza7XnHY5F4c3jUYl1S6zCvqfCPwgZVRFBlW7CVjgLz6oGSITBbN7ev/m765w0Marp4t8ciAqbVHOU2W8Yi2ZGPdPp1dK2656WxQpPUs1F8YPTugKetne7vMy+F332fLjVKAbduhHon/iySdFgqQaHjQhr1XiKg3wvQYYQ6wsbRI3EsE285sPnNlWxCEYqboTFZmYvcJw229+ylXQjDtDyTkXoFbATSPiRKlVKbtedgI2tCp2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(6916009)(5660300002)(52536014)(55016002)(4326008)(6506007)(64756008)(71200400001)(66946007)(66446008)(76116006)(66476007)(186003)(33656002)(66556008)(26005)(478600001)(2906002)(8936002)(7696005)(86362001)(9686003)(4744005)(54906003)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bFYvZHByS00yV3l6TVkvMzBuNjZrUUVmaGJsM2tyV1dYZ2VPZWV0OEg1THJj?=
 =?utf-8?B?WjdQS1RxOVVGRVlyL0pyd1hSUzhGQ1ZlOGVXU2w1T1FMb0dBZlZVUDVybmVN?=
 =?utf-8?B?L2ZHamMzaWNvTUc2bXNUdktma0Z5bnZSME9PMm0wYWcyWTFtMFhJUG9JUHd5?=
 =?utf-8?B?T094bGFqSmNOeDVIK0ZHcC9Hb05NL1BjVTRQN3VzQWo0WlVSRmgxd1FieVhZ?=
 =?utf-8?B?NDI2ZUlSVU9FTFhjaFpYRDhvWGJ6WjUvMHVCbnZMTVZQUlRWMit5d3pIOE1h?=
 =?utf-8?B?RU1WSjlYdEpISTg1UFUydy9ZRU9HZ0ZUcFcybVBMVmZMdlk2bXI0c1VKL0U1?=
 =?utf-8?B?dnBFT0pjcjlEWVJkQ0xrK0pOV0FlTGErMVVYZ2FuS0FxMndZc3J2OGkwdUFD?=
 =?utf-8?B?OFkrdURyOGN5QmxOZTVCL0duRWxsbkdpRmZxa0E2bmpvRGp0Wm9zZFFIaFpD?=
 =?utf-8?B?WkU4TzhnbGV6TEpIcVk3b24xSitNd2s3V3Y3ZkszcEwyK0RCTU5WaS92a1Bl?=
 =?utf-8?B?eXh3T3pQYWtWYnlSQkhzcG1XYlJML1ZBUzd4Nit5RlRnVmI5b2xGME9HZ1lD?=
 =?utf-8?B?RFFpVlNnckpZalN3ZkVpVEo2LzE4anUvZlUwcDRqTkhWVTZhV2lQbU9hNWda?=
 =?utf-8?B?QkRLQmxVdUQ0ZldsTUdVcEI0elV3V1ZnTHB6N0dtZThabWJaa2E2U01LSzZX?=
 =?utf-8?B?Q3JldnB3YlkyR3FNWTQ3WWhMZzh2a2w1QUt4cThUVXpQRHNkUklISGEvemNB?=
 =?utf-8?B?ZGJRcDV6THZrcjRWbUtteVRXQnR1VHc3V2NpNlBXZmpMUkpGM09uRjJvU0lY?=
 =?utf-8?B?V08zYzZNb2JCK1dvUnRma2h2YnFSNmhpS25ucDhtUnNqWWl0Yytma2RuOFZD?=
 =?utf-8?B?YVRqL1JEVnZ1SFJjcGdzenZLc0pBWWNwS3RhZHA2NHFDY0lxSjluQ2RCMEFz?=
 =?utf-8?B?Qi9ZelM2UHdQUHJtR0FQaC9LYWlmYndKTlZGcmV2Mnd1eHgvRkNlUm9oZVYv?=
 =?utf-8?B?ZjNkZU5PZmlQZEptdzVvbTkxRkVDQ2t1RVBxUXFiWk1tVStNT2FHQWszdHpo?=
 =?utf-8?B?TXZRSld0NjR5MmQvLzlyYnV2eG43c2NCbUl2cWJSWHJuYTBLRlJKMzBiOWky?=
 =?utf-8?B?aG5ML1IwZXo0YVlKNXo4c09jb3dTbHZOVlFtd1ljYktzSzFyTWNOMkdIamdu?=
 =?utf-8?B?U2R5UFlEbXZoVmNWSW1PUTYvZys2ZWlwTjZTeXJCblpsUFBFOW5kTXNnT3Ja?=
 =?utf-8?B?a3Bhc2ZScm1yQm53QXRINERjS1JnS2Z0MkpOWTFiVFpLeDZNM0VvWG42VkZR?=
 =?utf-8?Q?s4uAd8k5tiDWs=3D?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db90467-745e-4e74-6475-08d8b71bc820
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 17:02:02.1271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENbP/cJK+4hfVl2eIEe4TVTCxFhlAKuh6t+1RGfc6IGc8AT93jwCa/zk5aRGETKYib1qslrGhZXFNX2Sxl14upGM/Iw0myVNvKALLOESWGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2154
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBbICAgMjYuOTkwNjQ0XSBnZXRyZWc6IGdzX2Jhc2UgPSAweGY3ZjhlMDAwDQo+IFsgICAyNi45
OTE2OTRdIGdldHJlZzogR1M9MHg2MywgR1NCQVNFPTB4ZjdmOGUwMDANCj4gWyAgIDI2Ljk5MzEx
N10gUFRSQUNFX1NFVFJFR1MNCj4gWyAgIDI2Ljk5MzgxM10gcHV0cmVnOiBjaGFuZ2UgZ3NiYXNl
IGZyb20gMHhmN2Y4ZTAwMCB0byAweDANCj4gWyAgIDI2Ljk5NTEzNF0gcHV0cmVnOiB3cml0ZSBH
Uz0weDYzOyBvbGQgR1NCQVNFPTB4MA0KPiBbICAgMjYuOTk2MjM1XSBQVFJBQ0VfU0VUUkVHUyBk
b25lDQo+IA0KPiBUaGF0J3MgZ2Ric2VydmVyIHJlYWRpbmcgR1MgYW5kIEdTQkFTRSBhbmQgdGhl
biB0ZWxsaW5nIHRoZSBrZXJuZWwgdG8NCj4gc2V0IEdTIHRvIHRoZSBzYW1lIHZhbHVlIGFuZCBH
U0JBU0UgdG8gMC4NCj4gDQo+IEkgY2FuIGNvbWUgdXAgd2l0aCBob3JyaWJsZSBrZXJuZWwgaGFj
a3MgdG8gdHJ5IHRvIHdvcmsgYXJvdW5kIHRoaXMsDQo+IGJ1dCBnZGJzZXJ2ZXIgaXMgcmVhbGx5
IGdpdmluZyB0aGUga2VybmVsIGJhZCBpbnN0cnVjdGlvbnMgaGVyZS4NCg0KSSBhZ3JlZSB0aGF0
IHRoaXMgbG9va3MgbGlrZSBhIEdEQiBidWcgcmF0aGVyIHRoYW4gYSBrZXJuZWwgYnVnLiAgR0RC
DQpzaG91bGQgcHJlc2VydmUgdGhlIEdTX0JBU0UgdmFsdWUgaWYgaXQgZG9lc24ndCBpbnRlbmQg
dG8gY2hhbmdlIGl0Lg0KDQpNYXJrdXMuDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIClJlZ2lzdGVy
ZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMC0xMiwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55ClRl
bDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlCk1hbmFnaW5nIERpcmVjdG9yczogQ2hy
aXN0aW4gRWlzZW5zY2htaWQsIEdhcnkgS2Vyc2hhdwpDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2
aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUKUmVnaXN0ZXJlZCBPZmZpY2U6IE11bmljaApDb21tZXJj
aWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==

