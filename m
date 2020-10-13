Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B1F28D6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgJMXAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:00:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:64264 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgJMXAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:00:20 -0400
IronPort-SDR: LS4apg2c52bDZwt5rhlXoaeCxjLpq+YHDKJUb6F9Ds6Sh1+Q1SYud83vicFWD0RBS1yH2azrYx
 AWVc4SHpDQ7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145862296"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="145862296"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 16:00:15 -0700
IronPort-SDR: FkQZgwoNjz0b9z4mqNn80ZkJZts77ZCbAiraqSXnpvaL32BpHC6NJOBC9c8niiULW8ZWapq4Vu
 /nd6WyQlEHww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="346339760"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2020 16:00:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 16:00:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 16:00:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 13 Oct 2020 16:00:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 13 Oct 2020 16:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJhVx4dyxBDz1bFn57mbWQVt9YhL8oXCWnrLVNmyXqQFsFLU+bnYgh3JLPBtXeFmcVYxZ5dGwCZoolBhq1bwHLKZN4XZ2lMh8GHvP/A8UxEYbnIaAnM8usvOMEgDQa2pt/EjHANkxHpx9WqgQinjamYDiv9DYxqPpE+WbWhRfn8tu/yx4phaVAhpg6cjMCGJh2EvxJ4P44J7AJEaTiVEgLo2kn9r56bhTUGFrxwjGPdhUSG/zo4GjTAoNJbR4RN2vgc7+F1xc+ErGSjqInEVwZ2LIYXbkHIvypBupCUqnz+EM1R5FduiBimn3tCOfInsAFrQGb39PiMvIK6bx97ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgL8Trb+MIT4YTWs3pgmais9eOisgS8M26zEH7WDoeA=;
 b=VV35E0tx82v1Bl5W75yXI6VN+6wj8Wyj5YCZDcFy/i4+eDY5cmlWLnCPn4UNvKPChrciULVVMORQegVuyxR7M0KO8tVmK/SfFUHorsiGqGzJEjfp1ZYnxIjo9HPZr1xC4gxFAFi/z1Tv0hN95c6vIXoO5Zhijl+cTrQd5tFONeeyyvsnUMWuLEJKbaFxATZ3dmRnywqC92Rgq4Q/G1tAqx2ecYkjqYXim/8Ez+ACw+aNSPhEYHxxnr2yFNjywk01wHHr/vTCkxdt3DxB6LLf5qecfIYCdLtol5ENuGggMF1zATXm8spwBNf3YLLxEea87NwXJ8UMpERp5sJlNDQomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgL8Trb+MIT4YTWs3pgmais9eOisgS8M26zEH7WDoeA=;
 b=w2EgKzR2xlzdR1SlQAPctj/sWLS4a/NThUZorXha1EubcNuzf3oWo9UqnVBdOSAvPMbODOgL4Ecs44jhT+D/nO21vvccaB2TChf6hd+9EcS3BJSTsQuWDoilNvRWFNml1WblSIYf3aH6Id0GL2BT7EzaWg6hI+HHpOSNEBsLdRA=
Received: from BYAPR11MB3463.namprd11.prod.outlook.com (2603:10b6:a03:1e::16)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.29; Tue, 13 Oct
 2020 23:00:06 +0000
Received: from BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6]) by BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6%4]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 23:00:06 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>, "bp@suse.de" <bp@suse.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [RFC PATCH 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
Thread-Topic: [RFC PATCH 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
Thread-Index: AQHWmDN7aItv7L4uQkiAxQ/hdrUB16mDkc4AgBKfsOA=
Date:   Tue, 13 Oct 2020 23:00:05 +0000
Message-ID: <BYAPR11MB346391F798B3D13FD2863A18E0040@BYAPR11MB3463.namprd11.prod.outlook.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
 <20201001203913.9125-23-chang.seok.bae@intel.com>
 <5e9b73bf-5334-189e-753e-f1f766375024@infradead.org>
In-Reply-To: <5e9b73bf-5334-189e-753e-f1f766375024@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [75.100.89.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 234e61c6-14c3-409b-925a-08d86fcbb9f3
x-ms-traffictypediagnostic: SJ0PR11MB4831:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB48311553422B5B40E0F8698DE0040@SJ0PR11MB4831.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsCK06+RBRQTuRb84cPIruCzG2eAEGeZq5xTUIa9o8CyMIa6qWoqBfa0TD79oA0qBi/bQ4zKzXT/HzER6HijhHQRnGChWTZzUTmfifIfymT5++Fq6dcjLD9rrviKlwWEyxS2i5ovMAgAdRVT7i0f6CIK0AXPlWzXQkLWe8uZAMvjMaVwVT5psVrJtWmGw4fn2GHL4fbwd6p5A6Buc/vcpv8FsbIk4SkKuG8pDwGx7q9sdxtRroRdgCW5la2pivL76UnXHyxwvAkDhh35vGkWByYP9vJ/3d9+4kL4FfcxEP1U/0QJMOZRnRUb0kZr62VlWLkJNm4S+11Zfh9wNdn9wdwuF14dwS4DfmkKUL/pzEZhf6jBVpQo0APKCvxSjrasfZ4wFEsEUM64x4L5PNzCfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(86362001)(9686003)(71200400001)(66476007)(83080400001)(76116006)(26005)(66946007)(6506007)(8676002)(186003)(33656002)(4744005)(4326008)(8936002)(2906002)(7696005)(110136005)(55016002)(966005)(5660300002)(64756008)(66446008)(66556008)(54906003)(316002)(478600001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: N4gQihdZyo7n++JGXIyfziLXjTujqmDLahRPCvr1tyQWWtJQhLL/bVwDOET9wFhgPUcUzzvCVKC5KgiKMalxVf5QcTOrENpUWI2sJpA+19c+nbEGFv0fOxQIoC1ME9exlEy9qVHWhbSw3tEJE4KUS4ReEQt8HbzHpTNrBaEfa31R2zjKDEroQ1ZnBcmQYdbNuWOZpOXNacnWpyKIlds5WrHidTqqEdJqbV3g4gaNu1/N85MbEmPc9YOjPrSQuUzAq4Do3AcW5mZN2SQyVZC4hd3cfMtNFdw+crWi1fbh+MmT+kwl3o5in/5Z3BhdUKXD7jVIuGq7Ek24ToWDhCblqoSnLuGBMdeyofc/by4NV3TtB2/pQIeU5D8lCtBzFJqlWnNjntl3Yt7Q1nHHTS2JzjH77fmhkouvRauSlgpD3Aj9isqAouqbZcc49uSOUjlZf7oquvHx7I5ZDBj6CLeVsdAJwwSynKmNQffpTgANevFjC47M1gY0oo5fLZvOkR+zhw+PAvsWiGIk1HoEDBxwoZMVK2qgQfBcCwtWnjYVyqyrr0RqwvWCk6nWYEZnGfTHVsKoMjXts1enQMEYRxOHTT2uZ/iCPL6Shi3Q+EoTPJQbUAWlA4UkPh48nNdcHr5Pr4BS+/heoLBf9PIRdzJ3LQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e61c6-14c3-409b-925a-08d86fcbb9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 23:00:05.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0VuPszcQbkJiVplP620G7kzP0gXkeCqyD4o0Ea1nLSlH+QyEqA5ad8Sm4FAekDdLZkq66C1AVwGcemH+UpOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZyb206IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPiANCg0KPiBXaGF0
IGRvIHRoZXNlIGJpdG1hc2tzIGxvb2sgbGlrZT8gIHdoYXQgZG8gdGhlIGJpdHMgbWVhbj8NCj4g
V2hlcmUgZG9lcyBhIHVzZXIgZmluZCB0aGlzIGluZm8/DQoNClRoZSBYU0FWRSBzdGF0ZSBjb21w
b25lbnQgYml0bWFwcyBhcmUgZGV0YWlsZWQgaW4NCnRoZSBJbnRlbCBTb2Z0d2FyZSBEZXZlbG9w
ZXIncyBNYW51YWwsIHZvbHVtZSAxLCBDaGFwdGVyIDEzOg0KIk1hbmFnaW5nIFN0YXRlIHVzaW5n
IHRoZSBYU0FWRSBGZWF0dXJlIFNldCIuDQoNCmh0dHA6Ly9pbnRlbC5jb20vc2RtDQoNCkluIHRo
ZSBrZXJuZWwgc291cmNlLCB0aGV5IGFyZSBlbnVtZXJhdGVkIGluIHhzdGF0ZS5jDQphbmQgeW91
IGNhbiBvYnNlcnZlIHRoZW0gaW4gZG1lc2c6DQoNClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6IFN1
cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwMTogJ3g4NyBmbG9hdGluZyBwb2ludCByZWdpc3Rl
cnMnDQpbICAgIDAuMDAwMDAwXSB4ODYvZnB1OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgw
MDI6ICdTU0UgcmVnaXN0ZXJzJw0KWyAgICAwLjAwMDAwMF0geDg2L2ZwdTogU3VwcG9ydGluZyBY
U0FWRSBmZWF0dXJlIDB4MDA0OiAnQVZYIHJlZ2lzdGVycycNClsgICAgMC4wMDAwMDBdIHg4Ni9m
cHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwODogJ01QWCBib3VuZHMgcmVnaXN0ZXJz
Jw0KWyAgICAwLjAwMDAwMF0geDg2L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDEw
OiAnTVBYIENTUicNCg0KVGhhbmtzLA0KLUxlbg0KDQo=
