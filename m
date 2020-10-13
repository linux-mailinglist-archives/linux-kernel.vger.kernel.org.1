Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61E28D717
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgJMXii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:38:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:2816 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgJMXih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:38:37 -0400
IronPort-SDR: Q9QlslrAg/ViWDkP6xLM53UL2GVwDk2/e34zYp8H5/KrFVjQbyQ00N9gqDZO6RZHUF0q0Svdvj
 WThTZr4ISC3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145866931"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="145866931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 16:38:37 -0700
IronPort-SDR: J3Gq3x1lse/IQDd11myo+2Kti7U1egGEJFd/DG5hteQkSQKCzefBiL6fUXXPrfZZK7DsJQqSGK
 C39pUzowWHtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="356439506"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2020 16:38:37 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 16:38:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 16:38:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 13 Oct 2020 16:38:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 13 Oct 2020 16:38:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hePPL6yRs9DQs6VEiG7cSaXlynqsLZT4aICu9tEdm7yoxUCWXDG7gJqYptatxL2O8y2pf+S+rnTU41Zqczknxjl+yqCnaDFiF1DbABqldr7zoBJfrU+JsIwCTTHpDezK6unVvS5ACi8M5phTKCGeDmRDMowLgZ3/zegauvroz0Tn0otpQ88HNUH+GyqU/4dAvewcpIKcAPJfS6Y5RP85GhCRo9BCtOnvGofydI9j0GOWffKgFg7nYOqkAigbFXBMCUeUL+w55MtwcHk7j4Q0uMOWQ+ZBYhNmYYcdlv1eEJVUfL1bXZdleKPYnJREurgJ6Krb+T0PNeeeDAlo+K4uPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pd+FpfVtQM6Az+oGcuyz8XI4gdklCYfwiFaiUE6cnc=;
 b=NbovPyq3ce8jCmyv2p3vjQYZVsPEBXALswmzwnqzTdiz+4JbO8A4gjxF91OTIqbLYq9CDELksSBzRzUgz4rys4cQZdwwASDek307jCzcMCytftnRqx6Pd8PZCnzROkJC8qslYpNya94yw64pt6o8gF2tA/QBX7z8IHshYS4kVZFWjyC3au1ZXcIKDjgEm9Ud5h68iOgp5UVFFRy4IErK9e3vbJQFPKlPYExcTTxPQ/jWq/mgGeESCaIOPcHMKJOHSwGNSkblXgNklwJs+Jjx7hSPiBKrx0LpehxF7ikFXj2lzzxCMR10XREKoa9fR0s30qDz0m+P+zWpVlFCDpXlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pd+FpfVtQM6Az+oGcuyz8XI4gdklCYfwiFaiUE6cnc=;
 b=vlZ49GjXjwUD+xey7y3+YJAFzItmYMFVv89i99u3ybk+4oipWFBuPOy60YX6mH4omLMCNQKvzTALSzoMv+U4PpkH2y7SPnqjAasHIgHfZ9eNpuLfAmfuNndJOEp0dEE0N7iqwdeKvDHbLgVSsZ2VPrbdS12ILAxrgtsQyQz/zX8=
Received: from BYAPR11MB3463.namprd11.prod.outlook.com (2603:10b6:a03:1e::16)
 by BY5PR11MB4055.namprd11.prod.outlook.com (2603:10b6:a03:18b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 23:38:33 +0000
Received: from BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6]) by BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6%4]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 23:38:33 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: RE: [RFC PATCH 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
Thread-Topic: [RFC PATCH 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
Thread-Index: AQHWmDN7aItv7L4uQkiAxQ/hdrUB16mEjrwAgBGqGaA=
Date:   Tue, 13 Oct 2020 23:38:33 +0000
Message-ID: <BYAPR11MB3463F69505402CB76C650A13E0040@BYAPR11MB3463.namprd11.prod.outlook.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
 <20201001203913.9125-23-chang.seok.bae@intel.com>
 <CALCETrVToTrLQEbmXugja_Aif8LcZ7kX8Shu0Gg-FOx6w0p48A@mail.gmail.com>
In-Reply-To: <CALCETrVToTrLQEbmXugja_Aif8LcZ7kX8Shu0Gg-FOx6w0p48A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [75.100.89.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b69da45-86db-41b8-8b76-08d86fd11920
x-ms-traffictypediagnostic: BY5PR11MB4055:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4055E2E6C5F3311511F3C680E0040@BY5PR11MB4055.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSfcASp5Odu9sxXE3DcFClX5svHcURm08rDRxA3UMo+h+4dT8khH4ZDCFdngR8XhblqVcOX8IG+2Qz8qqHsipvN+szm2Qssyq2Uf8g7PsA1YmAlU+VF13k7CWM2+0Gzax8cJAw03V7ScZShtEQgU5vTm+D9SZ4kaZsXHDwpU/E6zWA9dOZkDN5nJw7Nx+dXTepnxMPtwzZDd+H75t7DGfX81MhzC7dhuYRdyFAHKC1+mi8/Jfg3ghA/IDDNmqdOsplcSk7d23n/Cc3gNBkzO1S5nH1mMVe4yUPWomhJsffORLKYbHQp7N1qvzx84zwPCt5JlONadOimh68+HlzJAfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(8676002)(33656002)(4326008)(66946007)(6636002)(5660300002)(110136005)(54906003)(316002)(52536014)(26005)(6506007)(53546011)(478600001)(7696005)(8936002)(71200400001)(76116006)(86362001)(66446008)(66556008)(64756008)(66476007)(55016002)(186003)(83380400001)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pdChBFTJtPy52e0TD8Zn6HHh/2OGZZhmkgBBVmf+EL4d9IEt23ZaguJJ70JfX14LNPqGhkqdoRuVd3hoAFr02r3pqrYItrFztPvvfd7gSvEv7lletOuNXD16PzzYrELu7jyML3XxakMm4V4G3vzZNYhbmPv07C9K6KJNG3HKFde0umaFqdPvUYcM/DKur28EOcGew09XorW4TWNLvM/QdQeSOkYh3rTr4p9PMYbwkeVXyMrkBVMDFtPo9toZyu5Ow22p2cZIDC5Pir9HFsPKCdwWboyezEavUGPg3xtMedKBhJj4C0X/eyb4Fz5ncqfrnnG5KV8gWsWcMBI7DLkLPyehS0xaBDuWJFZNBgQ0le+cHA81h8Z6Q1IFJqanS2s2SXAn6WNrUQ/oGDY7dUrhrpeDeE2G4OO19LzeVQkHGVOA4Wh2wZIiVgJfTV2VswKIjbFOZaT3YiWy91LBUSFgPCw4yjt69XlCkykYBLNYYLcEAaxXps2hlhHzJNZ+yhA8NykITRXE4IcdYO2DrzqP72IP41yTEhLkB6gb6jPLFUNwCCgd6QRBD5sK2BYCLl/M2oBYNObgrD9r4OY4qFsAF689lzTbls5AcenkkktDU9XM5iingHYqBvPNmcVMdFLQK2Q/U/sRDPqWMZqLaX92qQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b69da45-86db-41b8-8b76-08d86fd11920
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 23:38:33.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLd+pd3N9/prwkOcIF0OeSdtEdvJ9ALgWiZ9kqdmsjkMMJe5yTQFe/klaMSwfYpz5+vkkn1krpRh1swoBFor2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4055
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gDQoNCj4gT24gVGh1LCBP
Y3QgMSwgMjAyMCBhdCAxOjQzIFBNIENoYW5nIFMuIEJhZSA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwu
Y29tPiB3cm90ZToNCg0KPiA+ICJ4c3RhdGUuZGlzYWJsZT0weDYwMDAiIHdpbGwgZGlzYWJsZSBB
TVggb24gYSBzeXN0ZW0gdGhhdCBoYXMgQU1YIA0KPiA+IGNvbXBpbGVkIGludG8gWEZFQVRVUkVf
TUFTS19VU0VSX1NVUFBPUlRFRC4NCg0KPiBDYW4gd2UgcGxlYXNlIHVzZSB3b3JkcyBmb3IgdGhp
cz8gIFBlcmhhcHM6DQoNCj4geHN0YXRlLmRpc2FibGU9YW14LHptbQ0KDQpZZXMsIEkgdGhpbmsg
aXQgaXMgcmVhc29uYWJsZSB0byBhZGQgc3VwcG9ydCBmb3Iga2V5d29yZHMgZm9yIHRoZSBmZWF0
dXJlcyB0aGF0DQphcmUgYm90aCBzdXBwb3J0ZWQgYnkgdGhlIGhhcmR3YXJlIGFuZCBrbm93biBi
eSB0aGUga2VybmVsLg0KDQpIb3dldmVyLCB3ZSBuZWVkIHRvIGNvbnRpbnVlIHRvIHN1cHBvcnQg
bnVtZXJpY2FsIHN0YXRlLWNvbXBvbmVudCBiaXRtYXAgZm9ybWF0Lg0KT3RoZXJ3aXNlLCBpdCB3
b3VsZCBub3QgYmUgcG9zc2libGUgdG8gY29lcmNlIGEgbGVnYWN5IGtlcm5lbCAoZWcuIGEgZGlz
dHJvIGtlcm5lbCkNCnRvIGVuYWJsZSBhIGZlYXR1cmUgb24gYSBuZXcgbWFjaGluZSB1bnRpbCBp
dCBoYXMgYmVlbiB1cGRhdGVkIHRvIGtub3cgdGhhdCBrZXl3b3JkLg0KDQo+IGFuZCBtYXliZSBh
ZGQgYSBsaXN0IGluIC9wcm9jL2NwdWluZm8gb3Igc29tZXdoZXJlIGluIC9wcm9jIG9yIC9zeXMg
dGhhdCBzaG93cyBhbGwgdGhlIGN1cnJlbnRseSBlbmFibGVkIHhzYXZlIHN0YXRlcy4NCg0KQWdy
ZWVkLCBpZiB3ZSBpbnZlbnQga2V5d29yZHMsIHRoZSBsaXN0IG9mIHN1cHBvcnRlZCtrbm93biBr
ZXl3b3JkcyBzaG91bGQgYmUgYXZhaWxhYmxlIG9uIHRoZSBzeXN0ZW0uDQoNCkkgZG8gbm90IGFk
dm9jYXRlIC9wcm9jL2NwdWluZm8gLS0gd2hpY2ggaXMgYWxyZWFkeSBhbiBvdXQgb2YgY29udHJv
bCBwYXJzaW5nIG1lc3MuDQoNCldlIGNvdWxkIGFkZCB0aGUga2V5d29yZHMgdG8gZG1lc2csIHNp
bmNlIHdlIGFscmVhZHkgcHJpbnQgdGhlIHN1cHBvcnRlZCBYU0FWRSBCVjoNCg0KWyAgICAwLjAw
MDAwMF0geDg2L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDAxOiAneDg3IGZsb2F0
aW5nICBwb2ludCByZWdpc3RlcnMnDQpbICAgIDAuMDAwMDAwXSB4ODYvZnB1OiBTdXBwb3J0aW5n
IFhTQVZFIGZlYXR1cmUgMHgwMDI6ICdTU0UgcmVnaXN0ZXJzJw0KWyAgICAwLjAwMDAwMF0geDg2
L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDA0OiAnQVZYIHJlZ2lzdGVycycNClsg
ICAgMC4wMDAwMDBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwODogJ01Q
WCBib3VuZHMgcmVnaXN0ZXJzJw0KWyAgICAwLjAwMDAwMF0geDg2L2ZwdTogU3VwcG9ydGluZyBY
U0FWRSBmZWF0dXJlIDB4MDEwOiAnTVBYIENTUicNCg0KT3IgbWF5YmUgYSBzeXNmcyBhdHRyaWJ1
dGUgb3IgYSBtb2RwYXJhbSB0aGF0IHNpbXBseSBsaXN0cyB0aGVtIGFsbC4NCg0KV2Ugd291bGRu
J3QgYmUgYWJsZSB0byBkeW5hbWljYWxseSAgX3dyaXRlXyB0byB0aGF0IGF0dHJpYnV0ZSwgc2lu
Y2UgdGhlIGNtZGxpbmUgaXMgYm9vdC10aW1lIG9ubHkuDQoNCj4gPiAieHN0YXRlLmVuYWJsZT0w
eDYwMDAiIHdpbGwgZW5hYmxlIEFNWCBvbiBhIHN5c3RlbSB0aGF0IGRvZXMgTk9UIGhhdmUgDQo+
ID4gQU1YIGNvbXBpbGVkIGludG8gWEZFQVRVUkVfTUFTS19VU0VSX1NVUFBPUlRFRCAoYXNzdW1p
bmcgdGhlIGtlcm5lbCBpcyANCj4gPiBuZXcgZW5vdWdoIHRvIHN1cHBvcnQgdGhpcyBmZWF0dXJl
KS4NCj4NCj4gVGhpcyBzb3VuZHMgbGlrZSBpdCB3aWxsIGJlIHF1aXRlIGNvbmZ1c2luZyB0byBh
bnlvbmUgcmVhZGluZyB0aGUga2VybmVsIGNvZGUgdG8gZGlzY292ZXIgdGhhdCBhIGZlYXR1cmUg
dGhhdCBpcyBub3QgIlNVUFBPUlRFRCIgaXMgbm9uZXRoZWxlc3MgZW5hYmxlZC4NCg0KUmlnaHQg
bm93LCB0aGlzIGNtZGxpbmUgd2lsbCBvbmx5IGFsbG93IGEgbmV3IGtlcm5lbCB0byBlbmFibGUv
ZGlzYWJsZSBrZXJuZWwgc3VwcG9ydCBmb3IgQU1YDQpvbiBoYXJkd2FyZSB0aGF0IGFsc28gc3Vw
cG9ydHMgQU1YLiAgQnV0IHdlIGhvcGUgdG8gcmUtdXNlIHRoaXMgWFNUQVRFIGNvZGUgLS0gdW5j
aGFuZ2VkIC0tDQpmb3IgZnV0dXJlIGZlYXR1cmVzIHRoYXQgcmVxdWlyZSBqdXN0IHRoaXMgc2lt
cGxlIHN0YXRlIG1hbmFnZW1lbnQgc3VwcG9ydCBmcm9tIHRoZSBrZXJuZWwuDQoNCldlIGFudGlj
aXBhdGUgYSBmdXR1cmUgaGFyZHdhcmUgZW51bWVyYXRpb24gbWVjaGFuaXNtIHRvIGlkZW50aWZ5
IHN1Y2ggcXVhbGlmaWVkIGZlYXR1cmVzDQp0byBhc3Npc3QgdGhlIGtlcm5lbCBpbiBkZWNpZGlu
ZyB3aGV0aGVyIHRvIHN1cHBvcnQgYSBmZWF0dXJlIG9yIG5vdCwgYnkgZGVmYXVsdC4NClRoZSBr
ZXJuZWwgY2FuIHVzZSB0aGUgY29tYmluYXRpb24gb2YgaXRzIGJ1aWxkLXRpbWUgY29uZmlnIHdp
dGggYWR2aWNlIGZyb20gdGhpcyBib290LXRpbWUNCmVudW1lcmF0aW9uIHRvIGRlY2lkZSBpZiBp
dCB3YW50cyB0byBlbmFibGUgYSBwYXJ0aWN1bGFyIGZlYXR1cmUgb3Igbm90Lg0KQW5kIGF0IHRo
ZSBlbmQsIGEgdXNlciBpcyBlbXBvd2VyZWQgdG8gb3ZlcnJpZGUgdGhhdCBkZWZhdWx0IHVzaW5n
IHRoaXMgY21kbGluZS4NCg0KVGhhbmtzLA0KLUxlbg0KDQo=
