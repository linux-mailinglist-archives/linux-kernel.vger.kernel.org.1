Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07782A56FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgKCVc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:32:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:9885 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732145AbgKCVcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:32:53 -0500
IronPort-SDR: pprlvdFRUlIx5KDLBGD8oK0Dw/cpexEO5T8l5L7WmbbnyO+H6sRc/UmuK9/BQfBR4307MwTVLP
 /7/aqH8Ef+hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="148981201"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="148981201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 13:32:53 -0800
IronPort-SDR: ylaRUWlyQ4yzd+mRx7aj/MXNUq1UqNAjVAUTfCczHhZflUI501KHlyRalDFu5XLyzBPKsLqAfe
 e5/GcJ4TEHfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="325368005"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 03 Nov 2020 13:32:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 13:32:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Nov 2020 13:32:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Nov 2020 13:32:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 3 Nov 2020 13:32:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXezqNupd6w1MlIjfQqrZ0QY8Oe5i0WSCNJgPdLFtgJWr21E/Pq2O9zk/fURe7XPP/X7CSMhxCR/H5JUMnG8Z6EXvdWH+U2C2XgfPdC9STO97oy9T7eH3IEPOUIDXvWbvFbkuL+2uzUij844R4fIloNirz+DHUbmsgm8TinEVGFn3BuGpDIjI1RSK63hSjghkhu4uR20IYwJyiARm9iLLLK7//ixvPh9eCkwHgjvCiquc/z8IZx8r3DEds70CFR6rYaRflfYPk8/rbSVtlhE6pk5g6cjD1+4DTm7B9ZxoQmGZY/YAAuMpbJctZZcAwKaZMswgKjwmBceehEo8CWUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bteAOlvpUHwUgGWZYR7HYxCLl9IJsc1LrGIq/6KN+DQ=;
 b=AlVPXJqN6UryAW2gItNFvGTCrnlBauo6J4kkkTksFbqgaLBPHaTZNY9TFqD2hkt5xE+RFo9JssmQdkIgtvM1GCWL7fBky9qzA9/TFf3df6vh22mjcroj+YKUo7eC7Yj1ouGpFaTUK/Qb4L72qAPTB4T1tFxoVh/S1S8wBXiRAX6nnV4W4G1bdX6voKn7vN4md/VInjHVyoHlPsrQbpXn3hz8mOz9sN/0dIU1yymw59dwIHnP6GMaMmsbGb8jFH6fN0bZIURDOo39F8I6NY3cLTA6ILnrmnb8+qkUT916hnJmRX3AlmZLp0PaDCXrTyIFRk/G88uDhf2t5vpFtZXNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bteAOlvpUHwUgGWZYR7HYxCLl9IJsc1LrGIq/6KN+DQ=;
 b=RQgeOqK45GfiPDH9HJTFRf7+Os3RnhWRyM02w42D25Y/22GVy1cb0kOsFYvxALbVe65iqzt/3+HrR7F0anW8zng+9LerfWEGX68u+cyBtvOn4Lh+V+fsSJb0rQ7i89DpTwtWPiM/O6I27f1s2khjpQrtxSgBs7aSCE3eJ1rDPvQ=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (10.255.162.17) by
 BYAPR11MB2551.namprd11.prod.outlook.com (52.135.226.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.32; Tue, 3 Nov 2020 21:32:12 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58%7]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 21:32:12 +0000
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
Thread-Index: AQHWmDN58aiUgMgw60qFf3kCAh4uoKmDZ7KAgBLJBoCAAAOPgIAAKVWAgABRVYCAAKmzAIAABUyAgB/CTwA=
Date:   Tue, 3 Nov 2020 21:32:12 +0000
Message-ID: <d2b79aeddd2982b0a5e775b0fbf4fe828720bb94.camel@intel.com>
References: <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
         <78F221DB-CB61-40DB-9C6F-6C86D0F1BCDF@amacapital.net>
         <226772b9-7109-c632-2e9a-372df38b81a0@intel.com>
         <CALCETrW8u5rUsZvoo5t4YtC+4boBVcK__-srtA1+-YX06QYD1w@mail.gmail.com>
         <69721125-4e1c-ca9c-ff59-8e1331933e6c@intel.com>
In-Reply-To: <69721125-4e1c-ca9c-ff59-8e1331933e6c@intel.com>
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
x-ms-office365-filtering-correlation-id: 921cca2c-9481-4bcf-6010-08d8803fed76
x-ms-traffictypediagnostic: BYAPR11MB2551:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2551392B306AE3E1DBC49B5ED8110@BYAPR11MB2551.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IT//SlnytGKK5/Ux+AxMP85n9OGc1Fca7yoJia751oKOky2mLdPZ/cYQs8ikyOA6EXXSnS9g70FTP4RJZzW+krhnnTUePMhcbLsqg9hksgbtUDidk0lYj1PnI/uDEsdNhkWSIxtLk69wzSxKYvQJrFvUpjgO4GqR095T0dSK786jwKzZOIXGQKyE7EMyS5u4cj0Yv7/8ks8FxVvGR04A9Y0uE7HHORAJVg7i6FO9kMzOc5DbpWB+FsCSv81ec7XjGlErdeiYd9FSjOEF94yyLd/pwW52LZd3BgSComL3eyFEXo8jZlzabG62Xz5rAK8XQVsPXrhNc2FoGDvr7h+js6V8AOFQqgycBZu2Y9TAaQnDT3IzKoEfURIEmHcCTfF5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(66476007)(54906003)(4744005)(5660300002)(2906002)(110136005)(316002)(478600001)(66446008)(53546011)(4001150100001)(64756008)(36756003)(6506007)(83380400001)(66556008)(76116006)(3450700001)(26005)(66946007)(6512007)(86362001)(71200400001)(6486002)(186003)(107886003)(4326008)(6636002)(2616005)(8936002)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JSBxKoDSDdtjEBqTNPE6DbjNFQGrF8AEviTCv95cg8jgyz6zeqcsqnGJwGeXyUmsXZ9sFDEewK8haGksq76K50BnyLKtBMNxC8fWUob2kZ4dNhZghC4iudEd6Knu7DujTVKKJ7k/B7EB8m9NOCTpRgNNFObjPRy3XS9ioyK13s5B2BSP2txpRBLYhNgdag6lZziaOgRFAdCKYa4gp0zqVeS62RdQC15ejVC8bu6blTF61/LiYCOKBNDk6iFg5Ob75cTvWv/Atqk2XVHfanLhfcKf3rqKghG7qzLY0w5MV1k5sf5Y4is5b8Lo3Q8T93Hfn9/AMHdu3rDWLtQRyxMDRb5lK4sycq9ibLOUKmFIH7mqiBA1WRLkRqkeCdABb+GH5DVqS6pEudajY6Kgh0WluDTaApybZ2Stab10pWS6ydGYkPunsEH8w20s+lNi3K3kkIsvps77X4Iifa5X6stXs4ir2+flwvDlLbQ/Zwcv0tw5vdtrHClDxtfuyEdz4pukJRbRhyE0NJsTB+sIrrwcgr23UN1hf2kWpQUymDat1WhJFF/0WsTJJKS9asBRulSGa2iUzCTcl/XzFfvYjGZgP74llqCRre7fT1xGD2Li2aaKN9CRzyKxQVnU7OQSMQU8fiKnPgZC1v16gzQEE3O1Qg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D571889EEFD91439956106B7D63C595@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921cca2c-9481-4bcf-6010-08d8803fed76
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 21:32:12.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZyTA9JZB6NR3W0Hq2SAXPBs2PMHPwp8IvaFXtgTCu8J5RDGUZDUYxRMWoEaJZOAh5MGot36kM+vGTCNW2n1Qhz3PimHg62eCcekdCVRK8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2551
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTE0IGF0IDA5OjI5IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTAvMTQvMjAgOToxMCBBTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOg0KPiA+IA0KPiA+IEkg
d2FzIHN1Z2dlc3Rpbmcgc29tZXRoaW5nIGEgbGl0dGxlIGJpdCBkaWZmZXJlbnQuICBXZSdkIGtl
ZXAgWE1NLA0KPiA+IFlNTSwgWk1NLCBldGMgc3RhdGUgc3RvcmVkIGV4YWN0bHkgdGhlIHdheSB3
ZSBkbyBub3cgYW5kLCBmb3INCj4gPiBBTVgtdXNpbmcgdGFza3MsIHdlIHdvdWxkIHNhdmUgdGhl
IEFNWCBzdGF0ZSBpbiBhbiBlbnRpcmVseSBzZXBhcmF0ZQ0KPiA+IGJ1ZmZlci4gIFRoaXMgd2F5
IHRoZSBwYWluIG9mIGhhdmluZyBhIHZhcmlhYmxlIHhzdGF0ZSBsYXlvdXQgaXMNCj4gPiBjb25m
aW5lZCBqdXN0IHRvIEFNWCB0YXNrcy4NCj4gDQo+IE9LLCBnb3QgaXQuDQo+IA0KPiBTbywgd2Un
ZCBlaXRoZXIgbmVlZCBhIHNlY29uZCBzZXQgb2YgWFNBVkUvWFJTVE9Scywgb3IgIm1hbnVhbCIg
Y29weWluZw0KPiBvZiB0aGUgcmVnaXN0ZXJzIG91dCB0byBtZW1vcnkuICBXZSBjYW4gcHJlc2Vy
dmUgdGhlIG1vZGlmaWVkDQo+IG9wdGltaXphdGlvbiBpZiB3ZSdyZSBjYXJlZnVsIGFib3V0IG9y
ZGVyaW5nLCBidXQgb25seSBmb3IgKk9ORSogb2YgdGhlDQo+IFhTQVZFIGJ1ZmZlcnMgKGlmIHdl
IHVzZSB0d28pLg0KDQpGb3Igd2hhdCBpcyB3b3J0aCwNCg0KSWYgdXNpbmcgdHdvIGJ1ZmZlcnMs
IHRoZSBidWZmZXIgZm9yIHNhdmluZyB0aGUgdGlsZSBkYXRhIGFsc28gbmVlZHMgc3BhY2UNCmZv
ciB0aGUgbGVnYWN5IHN0YXRlcy4NCg0KVGhlIEFNWCBzdGF0ZSBpcyBzdG9yZWQgYXQgdGhlIGVu
ZCBvZiB0aGUgWFNBVkUgYnVmZmVyIChhdCBsZWFzdCBmb3Igbm93KS4NClNvLCB0aGUgbGF5b3V0
IChpbiB0ZXJtcyBvZiBvZmZzZXRzIG9mIG5vbi1BTVggc3RhdGVzKSB3b24ndCBiZSBjaGFuZ2Vk
IGF0DQpydW4tdGltZS4NCg0KVGhhbmtzLA0KQ2hhbmcNCg==
