Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5B29F9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgJ3A1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:27:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:48882 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ3A1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:27:16 -0400
IronPort-SDR: Y5QThMb3cVocxpav+vYcxNnEZM8SZPZTOate9eq5ujzwLIdogN2eHeTW8MjF+1D5okzvxpVpqM
 PkKJI+ywQ4+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="253244822"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="253244822"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 17:27:14 -0700
IronPort-SDR: 4hvJpJIVP3xmROCTaIDvqsyxkXUtsFZewgjw9/+uwOn+EYh+09RPbSvs0wWesi4pZwgGz+s4Y0
 H4hx1XvEet6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="335275354"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 29 Oct 2020 17:27:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Oct 2020 17:27:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 29 Oct 2020 17:27:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 29 Oct 2020 17:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA6bbDt8W9hWmRA6m2v38ob+mXtwGQeZi2okLo9SDx6cH9Nv6lK+6kmZwC9/x9fo+Za0CvLRXbJiCYx2JgCNxB6zWbYyPNhfn9KEVBNWqyiWkKOb7Sz8lmQ+B2e50+6tlxJeVlK5/VadZjjZHt/rDdN3BL4Z8a/svgv6SWPRiB1HK2SKKMMz6EJz1EGhQ7Om1P2HcRsyV68QZLyZQKNBAj/MSKfqu0ud6OyFIoWPzTn7HakmdETTHMWX3weN0qKne1dYkbwvRtq7u03qh91SvtwrpNoqKIE6coCINlml9dgJJP8Hjf+xKfiGChmNUDN/C+72Vm4fHL2PnIYfPoBdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOAJBVNeiLV3b6ztjS55J/u+fR1nU3V6F0ESC1mzac0=;
 b=mPiZCUHyB37gb/WeHRHhbA4r9AF0GOzbmYBTkn8M95c5DC0ctBY+o3IaOnVV7GmjNGFXBrHqqMGRtwgfJEbbdWqJO1j8SCFH17ZZNW30tW0+PNdXKPe9mWSK4rlIeMTByjjeT9/MIbA3XsFQJqlSIF3mPwzVEuZIppI4t01EEvUvvOecAyCrUir7/7tJ2Wy0/wVS/S/s2+r9rtzr915QKq18l8eQK6WZ9MUz02/ThZ31Uq0Nm6CyKV8fdUcNvnd65VMMF8rxf2LGoxO1rFzVjteJzFPgJlX9GHT+C4jh2/S4EtHLAeKbi5RjL/dRQHNaAu7QJ+BR9sAOJTRvsqzijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOAJBVNeiLV3b6ztjS55J/u+fR1nU3V6F0ESC1mzac0=;
 b=HkEK5XzM4HlkP/+E5wIK2MOnn2Xcd4a7RGshujIVyKl24wbNn5ktR4obOMwVf7FRvi9n5600PR9ApZ365PO6sb5n9rGgwl71+IiaMgXRKKzPs7lEeCJAXZ1aigu7VVGt2XuiV4mdhrtEWQYtjKIOPOmi8+ryVVVLtHKuDwbiQkc=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BYAPR11MB2727.namprd11.prod.outlook.com (2603:10b6:a02:c7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 30 Oct
 2020 00:27:11 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::d7c:4111:fa54:a304]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::d7c:4111:fa54:a304%5]) with mapi id 15.20.3477.035; Fri, 30 Oct 2020
 00:27:11 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nios32: add support for TIF_NOTIFY_SIGNAL
Thread-Topic: [PATCH] nios32: add support for TIF_NOTIFY_SIGNAL
Thread-Index: AQHWrg8hZvorErXnLkKTKolNK1LoyKmvSiUg
Date:   Fri, 30 Oct 2020 00:27:11 +0000
Message-ID: <BY5PR11MB389300779C8CF5D2B5196E1BCC150@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <c6e927af-7ffd-d087-8716-729e87d80fb1@kernel.dk>
In-Reply-To: <c6e927af-7ffd-d087-8716-729e87d80fb1@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=intel.com;
x-originating-ip: [115.134.237.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 708b2149-1d08-4f01-90d3-08d87c6a8b4f
x-ms-traffictypediagnostic: BYAPR11MB2727:
x-microsoft-antispam-prvs: <BYAPR11MB272763FE233C061F3B7C336ACC150@BYAPR11MB2727.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+r2WsiORhmHe9V6f+C1DqPGuIZQH67oNn/cNdCTOF7Co6VwH5xIJKiVUl8cW0mp3suKacmgtZ1PA0A/G6HhNrEUTL1nARNknW97KFgB+T7lZFb6dpU0/7viACk+xBmEUoR3YjiVVT/FElgIOI25e8fUHwvTeGfIfhzD2J9MiQ9JvA0T40ygWbkVWd4Q+bCLvR3X+XKEW0hEH8oiNHOIy9u0TV1Ep97JmZAi42LOQOuj034REuyTbyMusJEBIPywZeqLth7WoyCvwrlyjDkoHN+7n6rrok3xqbH97+2JN77fpt9RB8o1FiYYVs8n+f9xp3x5visllBi0QEF+aQyf5r2smwuUXLPtZr4rjBSm1pK3P1Th3jZpJNrSNWzAJWuNivvrmxYhTZPkUhftJ2MXmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(478600001)(2906002)(966005)(7696005)(83380400001)(71200400001)(86362001)(53546011)(6506007)(33656002)(186003)(5660300002)(9686003)(8936002)(8676002)(26005)(66446008)(316002)(55016002)(110136005)(66556008)(66946007)(66476007)(76116006)(64756008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MHuRPVjE3J4WvVdYTNGsilo6Iy270lF7vOUmI/ALmY/LCvDvPFW6AZTEDZTifmbPQ9TipOZb5/GhgC9soWwvIzFR1U5MvIeYVEu+XH0jeIXrZcsbccM9/wKrjLJtEGCspGD7duKVjSbU2XvN1sgn/rhFVR2zr8yD8rQUxxF4bKXBuhVdcNR9EwcNqZxouS8S6htbqxMG8TiD7LcouzCfDECs7x/NMz/Lv2FBwcyC+xfmG1EEA8a+MvpgNMt+loN4vB/Bx3hZ0ZR/+MsPZ+Js9RKg0M/vOZk8jupHn1bqxliKuA9CgVqxwGrfReA59n/WKgTfq3SfzYvjiNIIkg8lG4v1EF/nuRqOHQenENxl7kL70nbd50W4dccEAGiSg4Buw6TxeXcxC+2IA9Ld5LzAmeCW3WI0afH3j5WSsjWVvAqT7Ency6N6PGMbJeo9n0KjBkvQxdvrO+yCzD3kk1FRIP09a2ymKr18N3+e6+JLSqYTjt3zLs2ugk3Q3u16njG8XUb0QinBoSEX5nNz0v8efHil95SxxZwLNNLo9bY9u30YV3Fx2jQ0X9E4FqfpWqsaX0Wg0Zekx3dRe3cJEJhJkOPpQU3LdhIAOggOZ90W2/ukz4nIWb+zXFuw0Ni+Lf8WwXXHG2UL6MjZ4uSZtWVk8Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708b2149-1d08-4f01-90d3-08d87c6a8b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 00:27:11.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIbuEJlvTec5Bsl8C88ttGmfAAZi+Wl2Md85t0fDhpMX2Pf2ibLCYdynzSz9RYgS1xdjqGb4oyPxd68VY5L7OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2727
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMzAsIDIwMjAgMTI6MTggQU0N
Cj4gVG86IFRhbiwgTGV5IEZvb24gPGxleS5mb29uLnRhbkBpbnRlbC5jb20+OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gbmlvczMyOiBhZGQgc3VwcG9y
dCBmb3IgVElGX05PVElGWV9TSUdOQUwNCj4gDQo+IFdpcmUgdXAgVElGX05PVElGWV9TSUdOQUwg
aGFuZGxpbmcgZm9yIG5pb3MzMi4NCj4gDQo+IENjOiBMZXkgRm9vbiBUYW4gPGxleS5mb29uLnRh
bkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4NCj4gLS0tDQo+IA0KPiA1LjExIGhhcyBzdXBwb3J0IHF1ZXVlZCB1cCBmb3IgVElGX05PVElG
WV9TSUdOQUwsIHNlZSB0aGlzIHBvc3RpbmcgZm9yDQo+IGRldGFpbHM6DQo+IA0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9pby11cmluZy8yMDIwMTAyNjIwMzIzMC4zODYzNDgtMS0NCj4gYXhi
b2VAa2VybmVsLmRrLw0KPiANCj4gQXMgcGFydCBvZiB0aGF0IHdvcmssIEknbSBhZGRpbmcgVElG
X05PVElGWV9TSUdOQUwgc3VwcG9ydCB0byBhbGwgYXJjaHMsIGFzDQo+IHRoYXQgd2lsbCBlbmFi
bGUgYSBzZXQgb2YgY2xlYW51cHMgb25jZSBhbGwgb2YgdGhlbSBzdXBwb3J0IGl0LiBJJ20gaGFw
cHkNCj4gY2FycnlpbmcgdGhpcyBwYXRjaCBpZiBuZWVkIGJlLCBvciBpdCBjYW4gYmUgZnVuZWxs
ZWQgdGhyb3VnaCB0aGUgYXJjaCB0cmVlLiBMZXQNCj4gbWUga25vdy4NCj4gDQo+ICBhcmNoL25p
b3MyL2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmggfCAyICsrDQo+ICBhcmNoL25pb3MyL2tlcm5l
bC9zaWduYWwuYyAgICAgICAgICAgfCAzICsrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL25pb3MyL2lu
Y2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgNCj4gYi9hcmNoL25pb3MyL2luY2x1ZGUvYXNtL3RocmVh
ZF9pbmZvLmgNCj4gaW5kZXggNzM0OWE0ZmE2MzViLi4yNzJkMmM3MmE3MjcgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvbmlvczIvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaA0KPiArKysgYi9hcmNoL25p
b3MyL2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgNCj4gQEAgLTg2LDYgKzg2LDcgQEAgc3RhdGlj
IGlubGluZSBzdHJ1Y3QgdGhyZWFkX2luZm8NCj4gKmN1cnJlbnRfdGhyZWFkX2luZm8odm9pZCkN
Cj4gICNkZWZpbmUgVElGX01FTURJRQkJNAkvKiBpcyB0ZXJtaW5hdGluZyBkdWUgdG8gT09NIGtp
bGxlciAqLw0KPiAgI2RlZmluZSBUSUZfU0VDQ09NUAkJNQkvKiBzZWN1cmUgY29tcHV0aW5nICov
DQo+ICAjZGVmaW5lIFRJRl9TWVNDQUxMX0FVRElUCTYJLyogc3lzY2FsbCBhdWRpdGluZyBhY3Rp
dmUgKi8NCj4gKyNkZWZpbmUgVElGX05PVElGWV9TSUdOQUwJNwkvKiBzaWduYWwgbm90aWZpY2F0
aW9ucyBleGlzdCAqLw0KPiAgI2RlZmluZSBUSUZfUkVTVE9SRV9TSUdNQVNLCTkJLyogcmVzdG9y
ZSBzaWduYWwgbWFzayBpbg0KPiBkb19zaWduYWwoKSAqLw0KPiANCj4gICNkZWZpbmUgVElGX1BP
TExJTkdfTlJGTEFHCTE2CS8qIHRydWUgaWYgcG9sbF9pZGxlKCkgaXMgcG9sbGluZw0KPiBAQCAt
OTcsNiArOTgsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCB0aHJlYWRfaW5mbw0KPiAqY3VycmVu
dF90aHJlYWRfaW5mbyh2b2lkKQ0KPiAgI2RlZmluZSBfVElGX05FRURfUkVTQ0hFRAkoMSA8PCBU
SUZfTkVFRF9SRVNDSEVEKQ0KPiAgI2RlZmluZSBfVElGX1NFQ0NPTVAJCSgxIDw8IFRJRl9TRUND
T01QKQ0KPiAgI2RlZmluZSBfVElGX1NZU0NBTExfQVVESVQJKDEgPDwgVElGX1NZU0NBTExfQVVE
SVQpDQo+ICsjZGVmaW5lIF9USUZfTk9USUZZX1NJR05BTAkoMSA8PCBUSUZfTk9USUZZX1NJR05B
TCkNCj4gICNkZWZpbmUgX1RJRl9SRVNUT1JFX1NJR01BU0sJKDEgPDwgVElGX1JFU1RPUkVfU0lH
TUFTSykNCj4gICNkZWZpbmUgX1RJRl9QT0xMSU5HX05SRkxBRwkoMSA8PCBUSUZfUE9MTElOR19O
UkZMQUcpDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9uaW9zMi9rZXJuZWwvc2lnbmFsLmMgYi9h
cmNoL25pb3MyL2tlcm5lbC9zaWduYWwuYyBpbmRleA0KPiBjZjJkY2EyYWM3YzMuLjIwMDlhZTJk
M2MzYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9uaW9zMi9rZXJuZWwvc2lnbmFsLmMNCj4gKysrIGIv
YXJjaC9uaW9zMi9rZXJuZWwvc2lnbmFsLmMNCj4gQEAgLTMwNiw3ICszMDYsOCBAQCBhc21saW5r
YWdlIGludCBkb19ub3RpZnlfcmVzdW1lKHN0cnVjdCBwdF9yZWdzDQo+ICpyZWdzKQ0KPiAgCWlm
ICghdXNlcl9tb2RlKHJlZ3MpKQ0KPiAgCQlyZXR1cm4gMDsNCj4gDQo+IC0JaWYgKHRlc3RfdGhy
ZWFkX2ZsYWcoVElGX1NJR1BFTkRJTkcpKSB7DQo+ICsJaWYgKHRlc3RfdGhyZWFkX2ZsYWcoVElG
X1NJR1BFTkRJTkcpIHx8DQo+ICsJICAgIHRlc3RfdGhyZWFkX2ZsYWcoVElGX05PVElGWV9TSUdO
QUwpKSB7DQo+ICAJCWludCByZXN0YXJ0ID0gZG9fc2lnbmFsKHJlZ3MpOw0KPiANCj4gIAkJaWYg
KHVubGlrZWx5KHJlc3RhcnQpKSB7DQo+IC0tDQoNClBsZWFzZSBoZWxwIGludGVncmF0ZSB0aGlz
IHBhdGNoIHRocnUgeW91ciBnaXQgdHJlZS4NCg0KQWNrZWQtYnk6IExleSBGb29uIFRhbiA8bGV5
LmZvb24udGFuQGludGVsLmNvbT4NCg0KUmVnYXJkcw0KTGV5IEZvb24NCg==
