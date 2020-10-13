Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E828D659
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgJMWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 18:00:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:7336 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgJMWA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 18:00:29 -0400
IronPort-SDR: XdoRzCJLpv05fTpgIsPm1cW/aCyw5W0PprVZwLSzr1shFezIHtVnuLJsbM6HuvdTXwlEOef+lG
 KEay/7MlO2gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="250686272"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="250686272"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 15:00:27 -0700
IronPort-SDR: MxIwvzDdzrSq4y1zYjav5S4aRBCv387gEQkwRnWH0bZgEdYRFwFPOY2/6nEwOBNhe+h4x6SpB7
 iCNIc6iv6n8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="390454969"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 13 Oct 2020 15:00:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 15:00:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 13 Oct 2020 15:00:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 13 Oct 2020 15:00:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXhawVn0xXLD3g4DClLnemex0iYiymfg6JZC+jgjlVP3Y46vuQ1Gxo7OnkcZCMwWAFdtZsjKY2HIP0xCvungaNoA/9GuLuQqyw5/v8PXMYGREL925SYeC1p3KNy8MehU8iVoheYnODBg6OVKxgKX0YEzgo3i6J2gHeuInPYDAQWGpR25Waorf+RjI7yeXVb7tOsr/8+I8UESPZXFC5fe7nn5l4etv+BNFNgPs1Ip5VnFwiBn7l3U8UB4mCwIYTpiZDx0p1eNiWsy3C9YMgh7nC5Gr1CPeslRQavRD5vYid+vuBf4AbaBprSG1sfnr2qe/imd1pL15I54/slY7XKCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utlsb2puEfNib17J13H2h01ENPO0rap3yfKYOuxSjSQ=;
 b=Ndxkudn5ZrhPYjUVCFzVGT+YgMW8wg61I4i+uw+LLs+Lp19dNdrYbCRjRKUZ0oL87/y8CB2GcyjhMJmYrtjryu9TLoN9wJoTTItf6bIbot959uP9XtYp0D71bexUGzFWChBD44FcAbzeOj30AainjK79+2Zmoo4gSb8ANhv0arhznXiFXCpm8FDerlvhRatXh8c+M6o2s4cflnT8E026KFRQ+97PzmK7oazQuEg95579V6d59mufkdMKjpofElwp7hlc2yyiqppN5XUDZGLNQ3+rwrvxsx7EBOtVOwGaf/1qvaTQ92WDZ+/RN+Q7QIguurHsbDCb7bTsioMaKJOsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utlsb2puEfNib17J13H2h01ENPO0rap3yfKYOuxSjSQ=;
 b=LN2UAunfsPFLZozkOv7EA0NbenL7bWQSFf3hipm0oDjrqEKJrMWuomRyR4QgL+n0zy1nvYP5KlXD5jflE5BLk8S7/XYc1rlT87akWVyTWnzuqrp6P2iljUd0zAdCwKcWbQ/Ya6NQt8CzkrIVRaHseA3g83z5eFu19/uuNW6Ygfk=
Received: from BYAPR11MB3463.namprd11.prod.outlook.com (2603:10b6:a03:1e::16)
 by BY5PR11MB4085.namprd11.prod.outlook.com (2603:10b6:a03:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 22:00:16 +0000
Received: from BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6]) by BYAPR11MB3463.namprd11.prod.outlook.com
 ([fe80::94c2:2c26:494c:98e6%4]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 22:00:16 +0000
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
Subject: RE: [RFC PATCH 07/22] x86/fpu/xstate: Introduce helpers to manage an
 xstate area dynamically
Thread-Topic: [RFC PATCH 07/22] x86/fpu/xstate: Introduce helpers to manage an
 xstate area dynamically
Thread-Index: AQHWmDN2jRGFh6Yx80OtsKJINUAFuamDaHOAgBK+RfA=
Date:   Tue, 13 Oct 2020 22:00:16 +0000
Message-ID: <BYAPR11MB346378236EEB357339C0DD81E0040@BYAPR11MB3463.namprd11.prod.outlook.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
 <20201001203913.9125-8-chang.seok.bae@intel.com>
 <CALCETrWjOYd4wM0Mn7fY+t4ztU99GNP77A6skNwjTViJYUEZYQ@mail.gmail.com>
In-Reply-To: <CALCETrWjOYd4wM0Mn7fY+t4ztU99GNP77A6skNwjTViJYUEZYQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: bd7b3160-a69f-41e2-a11d-08d86fc35e95
x-ms-traffictypediagnostic: BY5PR11MB4085:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB408535C05AC4D47D382FF8FCE0040@BY5PR11MB4085.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQkMV7ymkVM8Wzy822FdVWZtUEdv3dDSSIOwD7KBlP4F0DZ6O8Wi2PJ/WKaFTXScZzEHL4ClTuDYNtahuVBOb0RsDC8rrQuWv+5VxOrX5e7pcOAQTK8YJXGIbjWWBOz2LETzm3GqI6bui8+4khjyuRKUFSp92nDbe0ZX3CHjgFbzHpY2PimtLiHiSSHJ87NebS17FjZQgSwrDBc9wreC8tPNBVDVZ9pOMk82Gsf4nOatlsdxNUc68iTgvSO2t9HdCZJ8WhWjWjealNqAd3a4RUUGhCmsv5vDU0t7apUpyuyRcs54+LkfA2PEwZFutRgma2z83HlSl1HK76m8cg3rCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(33656002)(478600001)(6636002)(2906002)(7696005)(6506007)(83380400001)(9686003)(8676002)(52536014)(4744005)(4326008)(66446008)(26005)(66556008)(66946007)(66476007)(64756008)(8936002)(186003)(55016002)(86362001)(110136005)(316002)(71200400001)(5660300002)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dwyanMaoLFNfjNU7ccM7mqCvq6RKREp78aGpjXycH67zWnuVsZ+LxE7VhQ8w1igV++m5pJ/wIWdXoRLrdzbzcYTltAUEjRfrhG1Gw2CGemcG8UiZdibHRsJgOJKVc1Jpp30UaBEVkPuZ0qj6vGFGndbKqwz4jlTRkx1MX1CcMgRPb90BbxTEDrlxb4VPhQO1+iM4lbyIOphsgNYfc7TwekkHwC3iZwCF0UDsdGgTo5jwQGZ5v5hJSoAn9Fv3bhfD1N+TqtEn/l/dqhKYhesmvzXrL3WRKq0z6ZVJ+mYmgbCOINfSo0H8NVpeijmTKCGfyot8cKw3BfBSlpfBcxCPdAUs6ykpIS8i3Y4BGlTL51DiUemnxu6GrPZ22AZedfUd3DudlXKOuJn7itzUMgZ7I+fYyO19yZFLT9VXxBLp3kkq2ql9NNKtZeYzteIDDFmvMces58ePOthn2r/rhPBZ0Q2oepXXb5A9Xzt/76KCZGm3dpyspazbVocS7vdBBG+XgIDZP1U/zBFTe9gXwtVs+CciuDpwycKCpP6ikfRPmUEe6IoDQUl5zZTXHJlE3nDu8Hh4QqGyJyunQQB66PginOApPIx5kfJo5gbc2LJ/DJ08LdMczsqdzj/oOplC13nMb3GH6SlxQEWGTq2WKhsb8w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7b3160-a69f-41e2-a11d-08d86fc35e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 22:00:16.6476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKXIcf9BbjuCISwRIGyhJKxxsx2mYq29JysHWqxAbdXoLwWLhOmicNs01JSBL/hD3XGm4Rixkk8LI77GN5IJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4085
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4NCj4gRnJvbTogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IA0KPg0KPiA+
ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIFRoZSBjYWxsZXIgbWF5IGJlIHVuZGVyIGludGVy
cnVwdCBkaXNhYmxlZCBjb25kaXRpb24uIEVuc3VyZSBpbnRlcnJ1cHQNCj4gPiArICAgICAgICAq
IGFsbG93YW5jZSBiZWZvcmUgdGhlIG1lbW9yeSBhbGxvY2F0aW9uLCB3aGljaCBtYXkgaW52b2x2
ZSB3aXRoIHBhZ2UgZmF1bHRzLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBsb2NhbF9p
cnFfZW5hYmxlKCk7DQoNCj4gLi4uIHlvdSBjYW4ndCBqdXN0IGVuYWJsZSBJUlFzIGhlcmUuICBJ
ZiBJUlFzIGFyZSBvZmYsIHRoZXkncmUgb2ZmIGZvciBhIHJlYXNvbi4gIFNlY29uZGx5LCBpZiB0
aGV5J3JlICpvbiosIHlvdSBqdXN0IGZvcmdvdCB0aGF0IGZhY3QuDQoNCkdvb2QgY2F0Y2guICBU
aGlzIGlzIGEgdHJhcCBoYW5kbGVyIGZyb20gdXNlci1zcGFjZSBhbmQgc2hvdWxkIG5ldmVyIGJl
IGNhbGxlZCB3aXRoIGlycXMgZGlzYWJsZWQsDQpTbyB0aGUgbG9jYWxfaXJxX2VuYWJsZSgpIHNo
b3VsZCBiZSBkZWFkIGNvZGUuICBDaGFuZyBzdWdnZXN0ZWQgdGhhdCBoZSBlcnJvbmVvdXNseSBs
ZWZ0IGl0IGluDQpmcm9tIGEgcHJldmlvdXMgaW1wbGVtZW50YXRpb24uDQoNCj4gPiArICAgICAg
IC8qIFdlIG5lZWQgNjRCIGFsaWduZWQgcG9pbnRlciwgYnV0IHZtYWxsb2MoKSByZXR1cm5zIGEg
cGFnZS1hbGlnbmVkIGFkZHJlc3MgKi8NCj4gPiArICAgICAgIHN0YXRlX3B0ciA9IHZtYWxsb2Mo
bmV3c3opOw0KDQo+IEFuZCBhbGxvY2F0aW5nIHRoaXMgc3RhdGUgZnJvbSB2bWFsbG9jKCkgc2Vl
bXMgcXVlc3Rpb25hYmxlLiAgV2h5IGFyZSB5b3UgZG9pbmcgdGhpcz8NCg0KV2hpbGUgdGhlIGJ1
ZmZlciBuZWVkcyB0byBiZSB2aXJ0dWFsbHkgY29udGlndW91cywgaXQgZG9lc24ndCBuZWVkIHRv
IGJlIHBoeXNpY2FsbHkgY29udGlndW91cywNCkFuZCBzbyB2bWFsbG9jKCkgaXMgbGVzcyBvdmVy
aGVhZCB0aGFuIGttYWxsb2MoKSBmb3IgdGhpcy4NCg0KVGhhbmtzLA0KLUxlbg0KDQo=
