Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC75284B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:44:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:6060 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFLo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601984665; x=1633520665;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=HyEHdxpzCqQPDE9KOl5WdvgooN1P3k6kHUj8sK3EUrA=;
  b=iUAp/hErmYCujrRetMdXltlsRF9AxdpNjm0l71nLCoByevUNz8CG4b6U
   wZe51QxaTtmXNpKc9qIr0KGLRwRCzvI6VrVong1NL/0Gu7oHamZJ6mle/
   rCjSErJK3ul0sKqT3vPZ75EwWyWIS1lTX0NRPbb89qkR2kSmGXnhQ0tBY
   1RtGD2fq2CPUnFZRg/iVDMlDtHZzkxpcClcSBfptg7jkhEl/D3WzjtOvx
   Y80aPpnYITyDYFiuwreafbJoNF558b9GEqHRXxVCTKS7XYlp4Jem6wH3U
   0slgZz8QqXFCPpPS46S29lPPAv53X6Neb0NLZcPE9MwnGkr9m/xqIKfST
   g==;
IronPort-SDR: 1Wk3BKJpWzvJp6Yad5pe5JAgrAZSTDAg/9en/RUYLa2dYDgKbxOWB6sVFqHa+gBTm+DKkUCKOg
 eCmgKXCIC1W79dEQd1bLYoPtLkmGt/Vx04gEtFGvYNrvIAHs16n1gpIk+Muth2uZTQkiY3TsE+
 LuvH1ZTScfnGFYYYDLpJMNLHFUvdma7e8afyZ+XcBUgPDA2p0xJY3HfKAAknx/XIWfIYdmOmbY
 9jHSXVqM2kghMVBVHEN69n8i7dyDcTy9CHJfu62Mu2nUyTXzp6/Wejn2RVEWRqIVl0Qsqxvl8j
 fUk=
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="94362825"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2020 04:44:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 04:44:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 6 Oct 2020 04:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK7OXhjJseNuajO2D0xIRlVASPPzrvpzvVSnrYdD7bjJulv8YuIB7nohHR4rvNBg5XMn7Bpkt64HkVzgWodzrPiVBbpBqFrgesxNWhxQMDbZz6OIXpj1dCV7Sf+mN9b1wEFIAsDTujmwaf6fB6Ci2ojaCIwy0BXLtpSEUZOeHdvPt1vcNAu+JOjTZTcffyH7BvSb1gG096rak+wASvCkWAuJS2A/MrVIVKyHYZmftmDDcfSnO7NB9fcLB9UWyeF/Fgb8cG4o5OpLLzDMbs7tWarDQhbNU7C2WlxquMlM2u3m/3OmIBe62wq9/e6scKNvpqIXhe1aFaSv1/7vIe2+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyEHdxpzCqQPDE9KOl5WdvgooN1P3k6kHUj8sK3EUrA=;
 b=ZfCVGP5PLShw5eigF3XBFgJziH/r9iFqeIcxcISMLBymZitDLGyo+pKfZpvksvPdB+tpp9oj99lQ02NcMROFFCO+fsGDxHNaz8CiYZppkCTWcr+sJRqssDRKFZL2nvKWkJysnF9HUdwvxdBhEwpUu19j0ps+rCUrVn/Vwbm/tm7B9G0Chqy/p8NphqCTzMDuCK/jXqBub0MpRir14bViIgnWZ8WmBY7tFksWK6NWcRqagnKGv0BH3s22VXPn9hEmrlt1fRuWE4QLofEh/8x+F86TYPVHctXus8vAW7ppScd0T2bkL+NXdggARxSRd4Obe/Q3XGXrBFB0GPWBN2Lmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyEHdxpzCqQPDE9KOl5WdvgooN1P3k6kHUj8sK3EUrA=;
 b=pzgjT2BVRR0ytpTV5bCr/vciDTGbkclJ4Ve2XMbOjhEhV+yJvEUGrZlkz/32z1u4Kn8qZjjpd+lEVuwf7DU6Yyp6GTnnqkSjpX03cOwvOJP2/TDzYcavgFXZw5vUIqoQqLKIOJpTrAUlvHJH/Guu3/4YcC40uJRODheuaoiumiQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3245.namprd11.prod.outlook.com (2603:10b6:805:be::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Tue, 6 Oct
 2020 11:44:23 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3455.021; Tue, 6 Oct 2020
 11:44:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bert@biot.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Fix address width on flash chips > 16MB
Thread-Topic: [PATCH v2] mtd: spi-nor: Fix address width on flash chips > 16MB
Thread-Index: AQHWm9YHYn9h83ZKS0S/mMEMTqJKHg==
Date:   Tue, 6 Oct 2020 11:44:23 +0000
Message-ID: <fa017eb8-2927-8560-7744-65592eb5a391@microchip.com>
References: <20201004213204.11584-1-bert@biot.com>
In-Reply-To: <20201004213204.11584-1-bert@biot.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: biot.com; dkim=none (message not signed)
 header.d=none;biot.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 537d9ca4-e645-48c6-8dcc-08d869ed2bd8
x-ms-traffictypediagnostic: SN6PR11MB3245:
x-microsoft-antispam-prvs: <SN6PR11MB3245A1576CDB9306A22E6806F00D0@SN6PR11MB3245.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6upj5UycWuQJU6wXTUR76zW0U+/gbQ5Mbb2i+pLFvEsohPZcSbM79Qnozrwt4pWbRqgV26co6f/SN5h37S7sqrhHV9/rGiI2v7HYRLZwV38K1QRiT01ignyxek3klzxVqkKhxxXKQrEA89W07Kp1DVXFGQrLhAHN0vavQGrTYNSKSVEGf+1kvIMvc0OoRk1fYMZhIN8Cu5/tnpeW8/z/nE15jVitz0+/mmjcwh9uSMV2FSM9LgJvy2zOA6DdMhjfjUJMF3yWrPSDqgMAZ4Vhdca8IdMGqDPpKUprrGLVLqWBECfUGwx4PA0M2aY7op5iSqFJSZ5O6kY0+Sq5fUFyO1vrs314iD0niF+++ZJev4wn8PROUN5cPkVtJycJJXj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(478600001)(31696002)(71200400001)(83380400001)(86362001)(66446008)(66476007)(8936002)(66946007)(64756008)(66556008)(6512007)(8676002)(76116006)(5660300002)(36756003)(53546011)(31686004)(2906002)(2616005)(6486002)(110136005)(316002)(6506007)(186003)(26005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0EnI3+ayg9m9sTZuBGAB/7W/euVnSFWYWj81StjXNgCmlj+vOfFa2E4Kfb0uqN1WXd1nh4YfQY+H9ohPjrGe4Ia/HZ5G6M+ozogcX1rJw3whifYGSdno6U+BBoTalDa53XfSu5IefiwCGR0qzdqKNqElsXluuHm937Z8i1L9mgYSpqFXyll2XnLYFUYLUZ4YZ5dxeq/n64CFIPcQPRcp1q79+NvHVeAHv8j9CLvn0WYHbwGmtFSCK/MAx2VnqtzopcLRL+CN/ukY+/MbTZhZiAoRe3AKXQohKYRox6SV4vtSs9iM0mPc3gobVL/bqGT4LGdCrlwqU6w2XKfey1Nv2nXOtqsbHrrAIUMq/PRYHZ3qrb9KKlROwC9AcQhl8sGjSCyN5o3umLGVmnODMA9oWylKmOO2UKMfq+Rsoc2xBhHVewsX6b2WfEx/piRMNvMOEX2TpFwZtDuPx+K2mGRp6Nv/MuHXFKSSMiw3slvZQXeyQMKGe6hg49g3zT7ocrJoefnKXvc07c1ByLRvEEW4Tzs9d7GHJ0NxI1ORFnaSid9RY99rLPW5Iw/68ayP7xw0Sqe0NLiBO7J2V1SHpysN6MIF59Xw8I8UOG5NsVkhKPWaOn6Qcm8SutybmMuSqGQxh22dpplVg/YFkFm09QwpMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B500135147064C42AC99E11FB6AA3D6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537d9ca4-e645-48c6-8dcc-08d869ed2bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 11:44:23.4791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qf7WAUL943iJOCYzZKifjH72COxCENlQGxYAIbJao7eGccA0/fmgDrSe+C9VowSiK31bLJdm5iQ13wK4QdmJka33J+W7+NmHf0kFNzpL0OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3245
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNS8yMCAxMjozMiBBTSwgQmVydCBWZXJtZXVsZW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSWYgYSBmbGFzaCBjaGlwIGhhcyBtb3JlIHRo
YW4gMTZNQiBjYXBhY2l0eSBidXQgaXRzIEJGUFQgcmVwb3J0cw0KPiBCRlBUX0RXT1JEMV9BRERS
RVNTX0JZVEVTXzNfT1JfNCwgdGhlIHNwaS1ub3IgZnJhbWV3b3JrIGRlZmF1bHRzIHRvIDMuDQo+
IA0KPiBUaGUgY2hlY2sgaW4gc3BpX25vcl9zZXRfYWRkcl93aWR0aCgpIGRvZXNuJ3QgY2F0Y2gg
aXQgYmVjYXVzZSBhZGRyX3dpZHRoDQo+IGRpZCBnZXQgc2V0LiBUaGlzIGZpeGVzIHRoYXQgY2hl
Y2suDQo+IA0KdGhlIHByb2JsZW0gd2FzIHVuY292ZXJlZCB3aXRoIGNvbW1pdCBmOWFjZDdmYTgw
YmUsIHNvIG1heWJlIGEgRml4ZXMgdGFnDQp3aWxsIGhlbHAuDQoNCkZpeGVzOiBmOWFjZDdmYTgw
YmUgKCJtdGQ6IHNwaS1ub3I6IHNmZHA6IGRlZmF1bHQgdG8gYWRkcl93aWR0aCBvZiAzIGZvciBj
b25maWd1cmFibGUgd2lkdGhzIikNCj4gU2lnbmVkLW9mZi1ieTogQmVydCBWZXJtZXVsZW4gPGJl
cnRAYmlvdC5jb20+DQoNCldlIGNhbiBoYXZlIHRoaXMgYXV0b21hdGljYWxseSBpbiB0aGUgc3Rh
YmxlIHRyZWUgYnkgYWRkaW5nIHRoZSB0YWc6DQoNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5j
b20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDggKysrKystLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPiBpbmRleCAwMzY5ZDk4YjJkMTIuLmEyYzM1YWQ5NjQ1YyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmMNCj4gQEAgLTMwMDksMTMgKzMwMDksMTUgQEAgc3RhdGljIGludCBzcGlf
bm9yX3NldF9hZGRyX3dpZHRoKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICAgICAgICAgICAgICAg
ICAvKiBhbHJlYWR5IGNvbmZpZ3VyZWQgZnJvbSBTRkRQICovDQo+ICAgICAgICAgfSBlbHNlIGlm
IChub3ItPmluZm8tPmFkZHJfd2lkdGgpIHsNCj4gICAgICAgICAgICAgICAgIG5vci0+YWRkcl93
aWR0aCA9IG5vci0+aW5mby0+YWRkcl93aWR0aDsNCj4gLSAgICAgICB9IGVsc2UgaWYgKG5vci0+
bXRkLnNpemUgPiAweDEwMDAwMDApIHsNCj4gLSAgICAgICAgICAgICAgIC8qIGVuYWJsZSA0LWJ5
dGUgYWRkcmVzc2luZyBpZiB0aGUgZGV2aWNlIGV4Y2VlZHMgMTZNaUIgKi8NCj4gLSAgICAgICAg
ICAgICAgIG5vci0+YWRkcl93aWR0aCA9IDQ7DQo+ICAgICAgICAgfSBlbHNlIHsNCj4gICAgICAg
ICAgICAgICAgIG5vci0+YWRkcl93aWR0aCA9IDM7DQo+ICAgICAgICAgfQ0KPiANCj4gKyAgICAg
ICBpZiAobm9yLT5hZGRyX3dpZHRoID09IDMgJiYgbm9yLT5tdGQuc2l6ZSA+IDB4MTAwMDAwMCkg
ew0KPiArICAgICAgICAgICAgICAgLyogZW5hYmxlIDQtYnl0ZSBhZGRyZXNzaW5nIGlmIHRoZSBk
ZXZpY2UgZXhjZWVkcyAxNk1pQiAqLw0KPiArICAgICAgICAgICAgICAgbm9yLT5hZGRyX3dpZHRo
ID0gNDsNCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAgICBpZiAobm9yLT5hZGRyX3dpZHRoID4g
U1BJX05PUl9NQVhfQUREUl9XSURUSCkgew0KPiAgICAgICAgICAgICAgICAgZGV2X2RiZyhub3It
PmRldiwgImFkZHJlc3Mgd2lkdGggaXMgdG9vIGxhcmdlOiAldVxuIiwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgbm9yLT5hZGRyX3dpZHRoKTsNCj4gLS0NCj4gMi4xNy4xDQo+IA0KDQo=
