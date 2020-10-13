Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D8B28D670
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 00:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgJMWbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 18:31:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:39213 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgJMWbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 18:31:19 -0400
IronPort-SDR: ENCaiVtNbJKYn7GDkKyEZCzosuWiXGm4Um4SS35cc623QaJyU9oAjlGWa6yxL7XZouaRYUiOhk
 0DsWP9Wg5+og==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="163356950"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="163356950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 15:31:19 -0700
IronPort-SDR: 6zlWli8fEOOOlhrejdo/0pusUh8y3ZLQp78/6Qoz7fY7eovOcF5gVmixAYHoR1ipiwc6SHOdY5
 E3RxQqEcM7pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="345424184"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 13 Oct 2020 15:31:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 15:31:18 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 15:31:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 13 Oct 2020 15:31:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 13 Oct 2020 15:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXLgiZV/DYsSBdZX3Lrwr85GiOJLJsllwztfrGHbxJ1oNMa/FZT/hyqG34602d88fXdtjzylj3W/ZTfgRhj7A/GCBhxnEr0zJa9fGKDs/84NImglytkuFZCfu3TGhPsb6KKc1A1biFUKHTkxAfQRUwtNApRBSTTfz+NenUYK3hv48irMDda/jmbik1olK5TOM5SCnMtoNJPyz9pWhyLWlk6WTbDb4wJTLAyQeBKGmw+fO1B5l++T9SrNv1BYec610CblH6J7kOG6c7HQqDHWzr7V5ntVwwrAcQLzELozmKEm4KhFeGC4q2VI/uJkfs4LwS6hAz8gQbKJEpJpjyL0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oxkbxOc9LVf36hwAn7bFE1JRSDESCQaPVdT+YjWifY=;
 b=Kco6sRjmhukxKzANetGiEFxexYO6CQ6GnG7WwDxQOajf50yoNfEtuD1q55FbwgIXZNhpzMfmXZW0ml/EDGrp51vUbVIwCIhXcqvkOGLJeg7W25VZIzYxmqneW03aSiALbGiu/60WO1aMxzk5nw9dBrByVcSWVhi0rGxUiA7dM5lKyzaMbVGt21RJQp13BEf9IGMdyK0KbCc3XKW8fbiflo6Q73WTaZ0gD0R6ZpntT9D4wk/QTMrBX777PWLRSs1d80vk0Edo1dllaLKIURfEPZbldyewKUx9Fq9bQz3LQHQFf6nBDmGH9xakNmuNqGndRNTZvbZO7cd1vDGxbswxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oxkbxOc9LVf36hwAn7bFE1JRSDESCQaPVdT+YjWifY=;
 b=UQzNXQz8/mBZE7JHsxSwSSsO+X1KxTgNR5OfdvNQMhdzkjadn8t06rAmLEt3weKY1Gh+NFsSlfRQ2gVDB3Gk37jBLEGBI8KnOayY5LW3X9CxY7MbLs3scVlCQkLwp58syVXTqzT3Fl5Sm2szCHHmEZAR5Z3UQPvIcEUvBNyg3ko=
Received: from BYAPR11MB3463.namprd11.prod.outlook.com (2603:10b6:a03:1e::16)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.29; Tue, 13 Oct
 2020 22:31:15 +0000
Received: from BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6]) by BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6%4]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 22:31:15 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
Thread-Topic: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
Thread-Index: AQHWmDN5hF/u0XihekO8k6aCXp2sgamDZ7KAgBLAolA=
Date:   Tue, 13 Oct 2020 22:31:15 +0000
Message-ID: <BYAPR11MB346371298609756EFD2DDA1EE0040@BYAPR11MB3463.namprd11.prod.outlook.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
 <20201001203913.9125-14-chang.seok.bae@intel.com>
 <CALCETrWKMYcuyohpctb1SoDueU1-nwAtrirJbdJTp4tZwCMXZA@mail.gmail.com>
In-Reply-To: <CALCETrWKMYcuyohpctb1SoDueU1-nwAtrirJbdJTp4tZwCMXZA@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 5bdbbcd0-7936-4a24-116c-08d86fc7b269
x-ms-traffictypediagnostic: SJ0PR11MB5072:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB50727A368D08B781A80E949CE0040@SJ0PR11MB5072.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCqqlQ0TbcEGd/4xyOy22Gln+te7WbAm6GtNWWbk9YnpQo7nAhVktmlgpyJpYMbzKYgUt+3v7xINCRXtzA3nKYzTE529Pfdz2lntM1EDfif1G3AkLQ3lMB27sWFLsO2VJTTPo4ZBbCZvSnPrXZ2AmIMpIeyNU/c6aYjRbLHbNMhKoey/G9oogD92YriohJ0K/FWHboeIM/pnwyMEm3ifNy70GvSsVazSWVc9OqQWhjuQGwO2S7SOUO9cYCOYb8xHbYaItUG8fmXfKIdPf3fSbpI/u685KCwVNI+CvUAj4YpoPLgrk46LAb2Euk7nNTyNUuVp3NeUmXKTfXIrxeuDIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(5660300002)(7696005)(52536014)(8936002)(33656002)(4326008)(66476007)(66556008)(76116006)(66446008)(64756008)(66946007)(83380400001)(26005)(110136005)(8676002)(71200400001)(6506007)(55016002)(2906002)(186003)(316002)(6636002)(9686003)(478600001)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uaFpsDvo6Yv1vZ8PHXWnEQsI/qL2GWCZuoA6cYIGFNs6c+DW71yVKwtCodjk3SI+7+UlJOMqi7aQbGYpSa5GXrXsLRNwpC8BS3XVrN6Xcy8bpr+n+EigEtfKkR27ojpCjgZ3MCSGx+Pvb9r6hwvhEj4rQ2fd4f1J4o1Z5LItUfxA4PF+YUiy8Cyj7FN3M9TbsdQmqrH2JwGDJ399hAsv+dhtyr0r5Mb+EK5Ykt+rK9XxPS8Ct9P+sOR4ZNCpJeM6qRa66wCGwBjRrIDX+lK7O8cJ2OI78FcRmnZ5zHAUlywMCTSSGEuVgTKLWCIL68Gjhc3ZbGakuX5qDdI+Prxqq3w3k7drs6Dq1/KxKL3RniWZjOCMzHlQm/rYYS1eQlj2ymuhE8pw2cC/c8LpAhDPNrziWIwPYiC0Dyehzl2G37CBOijvs9Dh1SSYWbHBfzC4ztLCS2IjUJRPk5dn5hi1e4RC3OuTmF3gHKamFD0Q3zoKYBQmUgSom4FkiDiD5448xPu8VYzB6p8+02fXAIxtwi5nkUKYFmkkm4315InrhMzzoPBcYUKeofQgjOL397822BN5/e6skG9whHHJV0hJPEHidN+cP9sZpvfxODXW8JqWhz36Fp+tUaP+XgDsgdlD2Y5zdDNX/LvmN2SEOEpIBA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdbbcd0-7936-4a24-116c-08d86fc7b269
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 22:31:15.3431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itPO6m7SC08d4b4asCCB091w0YB8UIJBzcfFstLAYMmudGCGfb54ls1HstbF9MCOpy8ahT1Zme+xzY2/vav/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gDQoNCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL2ZwdS9jb3JlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L2Nv
cmUuYw0KPiA+IEBAIC01MTgsMyArNTE4LDQwIEBAIGludCBmcHVfX2V4Y2VwdGlvbl9jb2RlKHN0
cnVjdCBmcHUgKmZwdSwgaW50IHRyYXBfbnIpDQouLg0KPiA+ICtib29sIHhmaXJzdHVzZV9ldmVu
dF9oYW5kbGVyKHN0cnVjdCBmcHUgKmZwdSkNCj4gPiArew0KPiA+ICsgICAgICAgYm9vbCBoYW5k
bGVkID0gZmFsc2U7DQo+ID4gKyAgICAgICB1NjQgZXZlbnRfbWFzazsNCj4gPiArDQo+ID4gKyAg
ICAgICAvKiBDaGVjayB3aGV0aGVyIHRoZSBmaXJzdC11c2UgZGV0ZWN0aW9uIGlzIHJ1bm5pbmcu
ICovDQo+ID4gKyAgICAgICBpZiAoIXN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX1hGRCkgfHwg
IXhmaXJzdHVzZV9lbmFibGVkKCkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBoYW5kbGVk
Ow0KPiA+ICsNCg0KPiBNU1JfSUEzMl9YRkRfRVJSIG5lZWRzIHRvIGJlIHdpcmVkIHVwIGluIHRo
ZSBleGNlcHRpb24gaGFuZGxlciwgbm90IGluDQo+IHNvbWUgaGVscGVyIGNhbGxlZCBmYXJ0aGVy
IGRvd24gdGhlIHN0YWNrDQoNCnhmaXJzdHVzZV9ldmVudF9oYW5kbGVyKCkgaXMgY2FsbGVkIGRp
cmVjdGx5IGZyb20gdGhlIElEVEVOVFJZIGV4Y19kZXZpY2Vfbm90X2F2YWlsYWJsZSgpOg0KDQo+
ID4gQEAgLTEwMjgsNiArMTAyOCw5IEBAIERFRklORV9JRFRFTlRSWShleGNfZGV2aWNlX25vdF9h
dmFpbGFibGUpDQo+ID4gIHsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgY3IwID0gcmVhZF9jcjAoKTsN
Cj4gPiAgDQo+ID4gKwlpZiAoeGZpcnN0dXNlX2V2ZW50X2hhbmRsZXIoJmN1cnJlbnQtPnRocmVh
ZC5mcHUpKQ0KPiA+ICsJCXJldHVybjsNCg0KQXJlIHlvdSBzdWdnZXN0aW5nIHdlIHNob3VsZCBp
bnN0ZWFkIG9wZW4gY29kZSBpdCBpbnNpZGUgdGhhdCByb3V0aW5lPw0KDQo+IEJ1dCB0aGlzIHJh
aXNlcyBhbiBpbnRlcmVzdGluZyBwb2ludCAtLSB3aGF0IGhhcHBlbnMgaWYgYWxsb2NhdGlvbg0K
PiBmYWlscz8gIEkgdGhpbmsgdGhhdCwgZnJvbSBrZXJuZWwgY29kZSwgd2Ugc2ltcGx5IGNhbm5v
dCBzdXBwb3J0IHRoaXMNCj4gZXhjZXB0aW9uIG1lY2hhbmlzbS4gIElmIGtlcm5lbCBjb2RlIHdh
bnRzIHRvIHVzZSBBTVggKGFuZCB0aGF0IHdvdWxkDQo+IGJlIHZlcnkgc3RyYW5nZSBpbmRlZWQp
LCBpdCBzaG91bGQgY2FsbCB4ODZfaV9hbV9jcmF6eV9hbXhfYmVnaW4oKSBhbmQNCj4gaGFuZGxl
IGVycm9ycywgbm90IHJlbHkgb24gZXhjZXB0aW9ucy4gIEZyb20gdXNlciBjb2RlLCBJIGFzc3Vt
ZSB3ZQ0KPiBzZW5kIGEgc2lnbmFsIGlmIGFsbG9jYXRpb24gZmFpbHMuDQoNClRoZSBYRkQgZmVh
dHVyZSBhbGxvd3MgdXMgdG8gdHJhbnNwYXJlbnRseSBleHBhbmQgdGhlIGtlcm5lbCBjb250ZXh0
IHN3aXRjaCBidWZmZXINCmZvciBhIHVzZXIgdGFzaywgd2hlbiB0aGF0IHRhc2sgZmlyc3QgdG91
Y2hlcyB0aGlzIGFzc29jaWF0ZWQgaGFyZHdhcmUuDQpJdCBhbGxvd3MgYXBwbGljYXRpb25zIHRv
IG9wZXJhdGUgYXMgaWYgdGhlIGtlcm5lbCBoYWQgYWxsb2NhdGVkIHRoZSBiYWNraW5nIEFNWA0K
Y29udGV4dCBzd2l0Y2ggYnVmZmVyIGF0IGluaXRpYWxpemF0aW9uIHRpbWUuICBIb3dldmVyLCBz
aW5jZSB3ZSBleHBlY3Qgb25seQ0KYSBzdWItc2V0IG9mIHRhc2tzIHRvIGFjdHVhbGx5IHVzZSBB
TVgsIHdlIGluc3RlYWQgZGVmZXIgYWxsb2NhdGlvbiB1bnRpbA0Kd2UgYWN0dWFsbHkgc2VlIGZp
cnN0IHVzZSBmb3IgdGhhdCB0YXNrLCByYXRoZXIgdGhhbiBhbGxvY2F0aW5nIGZvciBhbGwgdGFz
a3MuDQoNCldoaWxlIHdlIGN1cnJlbnRseSBkb24ndCBwcm9wb3NlIEFNWCB1c2UgaW5zaWRlIHRo
ZSBrZXJuZWwsIGl0IGlzIGNvbmNlaXZhYmxlDQp0aGF0IGNvdWxkIGJlIGRvbmUgaW4gdGhlIGZ1
dHVyZSwganVzdCBsaWtlIEFWWCBpcyB1c2VkIGJ5IHRoZSBSQUlEIGNvZGU7DQphbmQgaXQgd291
bGQgYmUgZG9uZSB0aGUgc2FtZSB3YXkgLS0ga2VybmVsX2ZwdV9iZWdpbigpL2tlcm5lbF9mcHVf
ZW5kKCkuDQpTdWNoIGZ1dHVyZSBLZXJuZWwgQU1YIHVzZSB3b3VsZCBfbm90XyBhcm0gWEZELCBh
bmQgd291bGQgX25vdF8gcHJvdm9rZSB0aGlzIGZhdWx0Lg0KKG5vdGUgdGhhdCB3ZSBjb250ZXh0
IHN3aXRjaCB0aGUgWEZELWFybWVkIHN0YXRlIHBlciB0YXNrKQ0KDQp2bWFsbG9jKCkgZG9lcyBu
b3QgZmFpbCwgYW5kIGRvZXMgbm90IHJldHVybiBhbiBlcnJvciwgYW5kIHNvIHRoZXJlIGlzIG5v
IGNvbmNlcHQNCm9mIHJldHVybmluZyBhIHNpZ25hbC4gIElmIHdlIGdvdCB0byB0aGUgcG9pbnQg
d2hlcmUgdm1hbGxvYygpIHNsZWVwcywgdGhlbiB0aGUgc3lzdGVtDQpoYXMgYmlnZ2VyIE9PTSBp
c3N1ZXMsIGFuZCB0aGUgT09NIGtpbGxlciB3b3VsZCBiZSBvbiB0aGUgcHJvd2wuDQoNCklmIHdl
IHdlcmUgY29uY2VybmVkIGFib3V0IHVzaW5nIHZtYWxsb2MgZm9yIGEgY291cGxlIG9mIHBhZ2Vz
IGluIHRoZSB0YXNrIHN0cnVjdHVyZSwNClRoZW4gd2UgY291bGQgaW1wbGVtZW50IGEgcm91dGlu
ZSB0byBoYXJ2ZXN0IHVudXNlZCBidWZmZXJzIGFuZCBmcmVlIHRoZW0gLS0NCmJ1dCB0aGF0IGRp
ZG4ndCBzZWVtIHdvcnRoIHRoZSBjb21wbGV4aXR5LiAgTm90ZSB0aGF0IHRoaXMgZmVhdHVyZSBp
cyA2NC1iaXQgb25seS4NCg0KVGhhbmtzLA0KLUxlbg0KDQoNCg==
