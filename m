Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B936E2A58A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgKCVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:53:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:11303 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbgKCVxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:53:33 -0500
IronPort-SDR: crsQAZVDi7qACqiH0rXednRs9NpNdwnEu5mYEGdp14hexpI78gg64yUXUrQfFvMDIdVzNWJDRc
 6SeASZloOXsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="148983401"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="148983401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 13:53:31 -0800
IronPort-SDR: ypb6TBEHoWuWgs5OGsICOfce28AetEI2sPBDDQsHQlLl1MEW1Y57dkv2DeUD4SmT265YakQ5Xc
 8ttclV3rW+DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="363178988"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Nov 2020 13:53:31 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 13:53:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 13:53:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Nov 2020 13:53:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 3 Nov 2020 13:53:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9vO125IQRPiIuIPaqoX9mhX83+tjGEGDRa0ikbLO1MOSpqKOPNE3zwBBpnky10ij08SEiD9tTGAdvEKYLsoBxXXAklkpq6wz8kRNe/TKFGMzfDzCsa/ATIfgwvFZJUa+JD7sUSTo+ISCKQoZFyO2nW8uRE2kyFPwHMmKPAs06V4kQmQ4+fTzSDmMoZ02obAVThkNtWeWMtbsPAyKwV5C83KHTXdexvQGgcdOW+Fn/fo/GJWjCaRNfzlV8Dkz4WRCfcqubPwRqY0EWHnByG03Vd7jRZm0mURVQry4Lh1A5LvhPXa8WLaha5bxHYwe5Wfqm2GtIGsIp6Rdh1FjhVKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwf43/iVllctWyNAdqBE+upbRXxTmlJz5VqocIGD2D0=;
 b=M1oVA/qXx/0MvQUzCe+h3W/OpK5xvDVMBq8ABftymOBJtVpYEDhG+tOyDIzizsvlyNpoiIVKZUCHkQl8Z2vzKQbQuTHpIvoQD08ff0EyfI+k66BBFoUHj5vWKBD1nmKJEss0IfwIaGL7Equo19joTVqRIqJEKKPCF/oIWwBAHR66fEktG0ESylq9+gYFW2V84x0N1DRC+LbTbaUVJ68OBANfS4oc6GGIZeO1MK+ERwZyyLv1dnD1GCtPT0mZFms86B8rqzCuHoypvTBSoOpP5iiZkebitjAPFcNhRHSOj7DDc+gU64Qrp2dzGFFGDHZqRR9e0+SOt4RNvWlRX+CBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwf43/iVllctWyNAdqBE+upbRXxTmlJz5VqocIGD2D0=;
 b=dFIAPSGSAxMp9//PzS7RzAZ+lViGYU3uPPA5yKTXpKMAS07uQD8x6VrIYEZDMlQU6xLkDVdVhyqXhS1qvABSvxnWijpSqUh3rMXhU7OvwsgwpMV0SoiHARE1p1RDrsC2IDPuHd+mj/ylvVVkRLPMTtTzg07ZoJE04BucpOp4cgA=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BYAPR11MB2614.namprd11.prod.outlook.com (2603:10b6:a02:cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 21:53:22 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58%7]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 21:53:22 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Lutomirski, Andy" <luto@amacapital.net>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
Thread-Topic: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area
 on first use
Thread-Index: AQHWmDN58aiUgMgw60qFf3kCAh4uoKmDZ7KAgBLJBoCAAAOPgIAAKVWAgABRVYCAAKmzAIAABUyAgB/CTwCAAAOHgIAAAmKA
Date:   Tue, 3 Nov 2020 21:53:22 +0000
Message-ID: <978ba3b768214048b26619e0003db50c9d9c0792.camel@intel.com>
References: <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
         <78F221DB-CB61-40DB-9C6F-6C86D0F1BCDF@amacapital.net>
         <226772b9-7109-c632-2e9a-372df38b81a0@intel.com>
         <CALCETrW8u5rUsZvoo5t4YtC+4boBVcK__-srtA1+-YX06QYD1w@mail.gmail.com>
         <69721125-4e1c-ca9c-ff59-8e1331933e6c@intel.com>
         <d2b79aeddd2982b0a5e775b0fbf4fe828720bb94.camel@intel.com>
         <be49f086-4135-7859-d88a-8c0444d20087@intel.com>
In-Reply-To: <be49f086-4135-7859-d88a-8c0444d20087@intel.com>
Reply-To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: amacapital.net; dkim=none (message not signed)
 header.d=none;amacapital.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d236fbd7-43f6-4976-bd68-08d88042e252
x-ms-traffictypediagnostic: BYAPR11MB2614:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26149527DF4A81B37302C9BAD8110@BYAPR11MB2614.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxc+uPkrCCXoQINX8MsTcxkI3qrlVLooRu4Hp6OwlWpXoSbkyFEgjFJQ8qm6E82SlGlrBlXxkfXOAs7V4BcGr5hlETMc24uE5FlgGjda3hphqdls6fzFWp+B4CZjfzdRog/joU1FeTuBdUgtjF3aSVbuGexXyCMAqT9aQ2e/YwfGtwrlj+TpNSvr31kAUZfS7BOJL5gm0P1dEweqHi1fngubU4Cy0Iw3xRvbzKgaRMUOq7uCMNfPDE8G8ByOpMYn5oEvH/SbQ1bnXfO8ZRxxaIkT8ha9oJxwn5D25qIOxt2sHRXI/gVgs+o7XmsaVbA+SFh77ux89zrHxrGRSmA3dA7QJNnS15r/ctfBwQXRJJMe/b8L/4DmHMz1P1HN6o3i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(478600001)(5660300002)(107886003)(53546011)(36756003)(86362001)(186003)(6636002)(83380400001)(26005)(6512007)(8676002)(2906002)(316002)(76116006)(66446008)(4001150100001)(64756008)(66476007)(66556008)(2616005)(4326008)(3450700001)(54906003)(6506007)(8936002)(6486002)(66946007)(110136005)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EjkH2+Pc+XRAmWgPgEtMUbzTDEjxc4qaHzTC9uCOiBmZa4eVH8tGTIWRXCJ3GCvQ5U0ItAXmxpUTB7HWts9sZVUNp8iS42BGpoW+S5+kTpOL/RUmwdS1WDth4jTQpLdVrlSHdvkzqgouPMyQSXSsFDX3nn4p9q8XG39kBHdrKqjUyKE7irveQ/wQmPuZ8ZS6ZEU7Vb8aZpGP1EKzAVaKVm+JOoBrJJ6saUS/hOxV6H2RdvxI8o8jj83eglzDfyRCoGpZD7oF2tYSnGOWf7lSIOa7VzZPayupJdUanbq/mFGIGE/2aKPx+xChmxUVMbrPKSHFgfogccgSNDC0cqbNWA0iQ0aq5Mkd6xoLUTIEUBHGo308TFsCzROGn+9edefms9MjVlIHdYBj2xF2JzVTS+m67ZW9duvPJ4guBmQxMF8xwQotX4HOJO50Cem+ZYrQM9o6d9n8f7wn/05KYR5ng5+En6PWAPtzDT/kqkoYw9QRA6Pq5JjLtNAAiMeSwWtWRKFzN9j3ITdpZwsrIj1rfwJ0TiebprDy/w5+V26N+Fb4CHaKSIYSuDIJdhKQoS9BSg5ywiJMC9EmsDCgwAmO7McN0NwDD//BI467A0SVQW8vPEYpTLmwjjrRQBNjGf5g4BSpEAp2hDuKPchJUNZ6ag==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CB64660514251439DC9EA5650790A85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d236fbd7-43f6-4976-bd68-08d88042e252
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 21:53:22.5135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g22uwiA6O8+q7PObBILe5dQNIjA+5RGB1qkmwm+v0rkaNywb0agEftGLBx01fCs3ffwPaSgIPiv289zM/GmcC+BW5o5tHE0CvWfMDh+2Edk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2614
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTAzIGF0IDEzOjQxIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTEvMy8yMCAxOjMyIFBNLCBCYWUsIENoYW5nIFNlb2sgd3JvdGU6DQo+ID4gT24gV2VkLCAy
MDIwLTEwLTE0IGF0IDA5OjI5IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4gPiA+IE9uIDEw
LzE0LzIwIDk6MTAgQU0sIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4gPiA+ID4gSSB3YXMgc3Vn
Z2VzdGluZyBzb21ldGhpbmcgYSBsaXR0bGUgYml0IGRpZmZlcmVudC4gIFdlJ2Qga2VlcCBYTU0s
DQo+ID4gPiA+IFlNTSwgWk1NLCBldGMgc3RhdGUgc3RvcmVkIGV4YWN0bHkgdGhlIHdheSB3ZSBk
byBub3cgYW5kLCBmb3INCj4gPiA+ID4gQU1YLXVzaW5nIHRhc2tzLCB3ZSB3b3VsZCBzYXZlIHRo
ZSBBTVggc3RhdGUgaW4gYW4gZW50aXJlbHkNCj4gPiA+ID4gc2VwYXJhdGUNCj4gPiA+ID4gYnVm
ZmVyLiAgVGhpcyB3YXkgdGhlIHBhaW4gb2YgaGF2aW5nIGEgdmFyaWFibGUgeHN0YXRlIGxheW91
dCBpcw0KPiA+ID4gPiBjb25maW5lZCBqdXN0IHRvIEFNWCB0YXNrcy4NCj4gPiA+IA0KPiA+ID4g
T0ssIGdvdCBpdC4NCj4gPiA+IA0KPiA+ID4gU28sIHdlJ2QgZWl0aGVyIG5lZWQgYSBzZWNvbmQg
c2V0IG9mIFhTQVZFL1hSU1RPUnMsIG9yICJtYW51YWwiDQo+ID4gPiBjb3B5aW5nDQo+ID4gPiBv
ZiB0aGUgcmVnaXN0ZXJzIG91dCB0byBtZW1vcnkuICBXZSBjYW4gcHJlc2VydmUgdGhlIG1vZGlm
aWVkDQo+ID4gPiBvcHRpbWl6YXRpb24gaWYgd2UncmUgY2FyZWZ1bCBhYm91dCBvcmRlcmluZywg
YnV0IG9ubHkgZm9yICpPTkUqIG9mDQo+ID4gPiB0aGUNCj4gPiA+IFhTQVZFIGJ1ZmZlcnMgKGlm
IHdlIHVzZSB0d28pLg0KPiA+IA0KPiA+IEZvciB3aGF0IGlzIHdvcnRoLA0KPiA+IA0KPiA+IElm
IHVzaW5nIHR3byBidWZmZXJzLCB0aGUgYnVmZmVyIGZvciBzYXZpbmcgdGhlIHRpbGUgZGF0YSBh
bHNvIG5lZWRzDQo+ID4gc3BhY2UNCj4gPiBmb3IgdGhlIGxlZ2FjeSBzdGF0ZXMuDQo+IA0KPiBK
dXN0IHRvIGJlIGNsZWFyLCB5b3UncmUgdGFsa2luZyBhYm91dCB0aGUgNTEyLWJ5dGUgJ3N0cnVj
dA0KPiBmeHJlZ3Nfc3RhdGUnIHdoaWNoIGlzIHRoZSBmaXJzdCBtZW1iZXIgb2YgJ3N0cnVjdCB4
cmVnc19zdGF0ZScsIHJpZ2h0Pw0KDQpZZXMuDQoNCj4gDQo+ID4gVGhlIEFNWCBzdGF0ZSBpcyBz
dG9yZWQgYXQgdGhlIGVuZCBvZiB0aGUgWFNBVkUgYnVmZmVyIChhdCBsZWFzdCBmb3INCj4gPiBu
b3cpLg0KPiA+IFNvLCB0aGUgbGF5b3V0IChpbiB0ZXJtcyBvZiBvZmZzZXRzIG9mIG5vbi1BTVgg
c3RhdGVzKSB3b24ndCBiZSBjaGFuZ2VkDQo+ID4gYXQNCj4gPiBydW4tdGltZS4NCj4gDQo+IEkg
ZG9uJ3Qga25vdyB3aGF0IHBvaW50IHlvdSBhcmUgdHJ5aW5nIHRvIG1ha2UgaGVyZS4NCg0KSSB3
YXMgdHJ5aW5nIHRvIGNsYXJpZnkgdGhlIGNvbmNlcm4gdGhhdCBBbmR5IGhhZDoNCg0KCSJ0aGUg
cGFpbiBvZiBoYXZpbmcgYSB2YXJpYWJsZSB4c3RhdGUgbGF5b3V0Ig0KDQpUaGFua3MsDQpDaGFu
Zw0K
