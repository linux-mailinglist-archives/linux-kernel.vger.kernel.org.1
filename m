Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F062C2248
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgKXJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:57:55 -0500
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:44645
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731643AbgKXJ5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIPty35dllHGSyB+XkJuyT/5jMHXA5dXt/t8ud/q5pJn0zlHkYCeiSGBu6p7k41l0lJCOr/rCBE8wfr6BEjgejQcL+OxVTxAY650lUM7pfQQHjG1vkfmUJBxt53ZwykkKgRj5ohqGvvOyoNThdpL9KqVRQkyIkarmWEHaH9wFV0U8G1pSq1HkC58mX14HXXLlt6Y1B7legd5eUiT7S6kRgh42tpTpDb3Lp3P8hyD/9pxK7ymtT6fJpxjBr7uJMtadZQkkUcu+AYmJMVo5YXhmiamrgcNljtAdGbXaU8geSXrplIO3Tbb38lkKc4++QY79Dobucc54hald3nO+mjS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sU/+v7/Zenoq1FenH2YSRonhENqUMgdJjjTEKReb1Y=;
 b=ecEY7QXfGP2e7JY99EHPGuEXIVGHeQUhusbV99ixDXTk1FDlx4NKWocj7Z762SZbVCRbtbh8IA3HfYwfwFC9a+NojigRi2c8l7tVAvVobIpG209dUnFdzPYMJYHgz/LOe+ss3mLEV42R6Gtz2i1A1J1GnBx2ZZn//LqvlOq+OM900PEbjJ0hGhjJ/gTLynnEGQIjQ+7A/YHdtpcdKxoA7g0MQ6PXIap4knPEUHy6kQ5waVLm6MyPVhp3sk+a04EfnMbvCTJhzigq+eNK2scjjRP54XsT3pRRscV408kmh4q4hpnCz8IYJfoeHzjp1nnY7vmL7qSqfO98jqxV0K9JgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sU/+v7/Zenoq1FenH2YSRonhENqUMgdJjjTEKReb1Y=;
 b=h0TcP+UyOpwtlqTR6KAn11vQQv0hgXKSiht9hqvS+WNA+fsfZaP1zFqDnZs5z+P6dg0iOM/rdK0feHldq/6B8OhaHhY16Xd3eL23WyFsmDXlqVjJkWqm8kgqUBFy6bZhM9CdSp5YxE43hzRWdRl0FSXioWsyXWQWccxbxFfDDkY=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB5241.eurprd04.prod.outlook.com (2603:10a6:10:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 24 Nov
 2020 09:57:45 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 09:57:45 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Topic: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Index: AQHWwY7qvaWheOMvwU2q0XXgyvVqyqnW1uYAgAAxWYCAAAPXgA==
Date:   Tue, 24 Nov 2020 09:57:45 +0000
Message-ID: <DBBPR04MB797982E6E190F0C0E0980F258BFB0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201123115051.30047-1-rogerq@ti.com>
 <20201124064242.GA32310@b29397-desktop>
 <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
In-Reply-To: <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0baf0cdd-6218-47d7-7ba6-08d8905f648d
x-ms-traffictypediagnostic: DB7PR04MB5241:
x-microsoft-antispam-prvs: <DB7PR04MB524153C64431B565015B00DD8BFB0@DB7PR04MB5241.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOuCYCD8FFeBLqILNTkYaPtxVZ92AzF4UVJaFo2iZZ3keM07Sl3SCj0nV4BDfJQ4Vluqzt0foJsxFJbnSO50EW9BUQmq2GKnAN+4cAWIRSrcko8ufP0PWndE9i3gF2kN2D+vUsHMpOvGnUkUUXi3N2v9U2GJCR7DSJqiQlDBTFyrtD2QM7kN8JgYX+l35NDhqYstEtHUFTmKs8cS1slHH+iZliHSazrM+dROt4JYSWkPZ7mpUtM3+TNAGYcni3IkF0I8gnqFrDe0ADEWe6truDi+RC4ivCDNGIXwkNEcaXI4rIDYe7FVYOsD2r8jXIPv8iCsuQ9qC5OKKOSmfoUSiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(5660300002)(44832011)(6506007)(9686003)(8676002)(186003)(6916009)(26005)(2906002)(55016002)(66556008)(76116006)(53546011)(316002)(71200400001)(66446008)(54906003)(66476007)(66946007)(33656002)(83380400001)(4326008)(8936002)(478600001)(86362001)(7696005)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wDX+40fwiXRxnCUwKNnmtsemH4HX/bS2K4MonYjdSEHMR4Lz6GqvjVFM/I3+Bgi+KxnPdOLOxoG18E7ZhWST3dqIRJlPW+o95dVcW+SiWLEf096fiDLJyZvSGZ9m9c5SZjCFXwbeZZQbw0Ru23U3UIe6v+KLJZj+izhar4w2lqB7GuoW0xQ67K4EBRpMN9xOoEWVIe6fPwp7OI0Vz/HgqBieL3RXa4zEb68mMoeSy2+PlcT58AaSkGZRzif9/arVNHr+EGO3LCmMDRdWIR/EzYteDqSoJFwzziGuH08d/385rwZFiLZatj0r58Fac7iTXwvJn4jHBajkOt+U6R1ff9t0T17DmtCmjmzSdy769s/Wvy9DYAATrbbAG/McNHZnTvgno7aPNmiftEjKxvA66t46d51NdQRKoK7F1w5HAUBsBSENR9khcJQnjQvV8jDHGV9FV3v/hQ4R6fyVs4mgHob77uNgefFN9jY5G+BH1J6B4wdpbZXjFm0b1uWHdi0szV2ZM/bjlJqNJ3Pkdgzo6k8T3sSbDo0B1txo4zF9HjYpj3G0k1cSz7puk5n6MjkLvttrbLmF9gVusDU/aqELeyKcQXyEEv5LpQQqVsHjav6tiePJNPbG2d74eRqX4gCCixxLkaiGYRqa//+7Tgji1pCS+0V9PYODZnN3GfLUZR9mtZCGoQU3YaqxGcgcY90miZaYiBtVdH8yit3UoNPRFRL8KRvrmGOVwHG0jh0KwUuS0LtCXWY+83d04qpF6/xR2U0xVUdaWS0pvHtj5JnLLGjP6RoMvAQflzP0MyXslrk9dvjcvlfZOWUnmIv6HAteLI9KPLzq3eBcfm84q4GL99mI3LQLNREzl/h2pVLQuzzoxIMRTJXpepb2c8dQi5fdAGonK3eWgC+Mq8JPsfiL0A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baf0cdd-6218-47d7-7ba6-08d8905f648d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:57:45.5594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trBs454ou3KqOHvfMTOhjKzLzBu+SC5B3aTo4W+gwj9Y2p4FhKIZSBUpIQbOUPSDS+tl6J/hrgEIbv47ckeYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KQmVzdCByZWdhcmRzLA0KUGV0ZXIgQ2hlbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUB0aS5jb20+DQo+IFNlbnQ6IDIw
MjDlubQxMeaciDI05pelIDE3OjM5DQo+IFRvOiBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5j
b20+DQo+IENjOiBwYXdlbGxAY2FkZW5jZS5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
OyBiYWxiaUBrZXJuZWwub3JnOw0KPiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJldmVydCAidXNi
OiBjZG5zMzogY29yZTogcXVpdCBpZiBpdCB1c2VzIHJvbGUgc3dpdGNoIGNsYXNzIg0KPiANCj4g
UGV0ZXIsDQo+IA0KPiBPbiAyNC8xMS8yMDIwIDA4OjQzLCBQZXRlciBDaGVuIHdyb3RlOg0KPiA+
IE9uIDIwLTExLTIzIDEzOjUwOjUxLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+PiBUaGlzIHJl
dmVydHMgY29tbWl0IDUwNjQyNzA5ZjY1OTBmZTQwYWZhNmQyMmMzMmYyM2Y1Yjg0MmFlZDUuDQo+
ID4+DQo+ID4+IFRoaXMgY29tbWl0IGJyZWFrcyBoYXJkd2FyZSBiYXNlZCByb2xlIHN3aXRjaGlu
ZyBvbiBUSSBwbGF0Zm9ybXMuDQo+ID4+IGNkbnMtPnJvbGVfc3cgaXMgYWx3YXlzIGdvaW5nIHRv
IGJlIG5vbi16ZXJvIGFzIGl0IGlzIGEgcG9pbnRlcg0KPiA+PiB0byB0aGUgdXNiX3JvbGVfc3dp
dGNoIGluc3RhbmNlLiBTb21lIG90aGVyIG1lYW5zIG5lZWRzIHRvIGJlIHVzZWQgaWYNCj4gPj4g
aGFyZHdhcmUgYmFzZWQgcm9sZSBzd2l0Y2hpbmcgaXMgbm90IHJlcXVpcmVkIGJ5IHRoZSBwbGF0
Zm9ybS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRp
LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy91c2IvY2RuczMvY29yZS5jIHwgNCAtLS0t
DQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9jZG5zMy9jb3Jl
LmMNCj4gPj4gaW5kZXggYTBmNzNkNDcxMWFlLi40YzE0NDVjZjJhZDAgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL3VzYi9jZG5z
My9jb3JlLmMNCj4gPj4gQEAgLTI4MCwxMCArMjgwLDYgQEAgaW50IGNkbnMzX2h3X3JvbGVfc3dp
dGNoKHN0cnVjdCBjZG5zMyAqY2RucykNCj4gPj4gICAJZW51bSB1c2Jfcm9sZSByZWFsX3JvbGUs
IGN1cnJlbnRfcm9sZTsNCj4gPj4gICAJaW50IHJldCA9IDA7DQo+ID4+DQo+ID4+IC0JLyogRGVw
ZW5kcyBvbiByb2xlIHN3aXRjaCBjbGFzcyAqLw0KPiA+PiAtCWlmIChjZG5zLT5yb2xlX3N3KQ0K
PiA+PiAtCQlyZXR1cm4gMDsNCj4gPj4gLQ0KPiA+PiAgIAlwbV9ydW50aW1lX2dldF9zeW5jKGNk
bnMtPmRldik7DQo+ID4+DQo+ID4+ICAgCWN1cnJlbnRfcm9sZSA9IGNkbnMtPnJvbGU7DQo+ID4+
IC0tDQo+ID4NCj4gPiBIaSBSb2dlciwNCj4gPg0KPiA+IEkgYW0gc29ycnkgYWJvdXQgdGhhdC4g
RG8geW91IHVzZSByb2xlIHN3aXRjaCAvc3lzIGVudHJ5LCBpZiB5b3UgaGF2ZQ0KPiA+IHVzZWQs
IEkgcHJlZmVyIHVzaW5nICJ1c2Itcm9sZS1zd2l0Y2giIHByb3BlcnR5IGF0IGR0cyB0byBqdWRn
ZSBpZiBTb0MNCj4gPiBPVEcgc2lnbmFscyBvciBleHRlcm5hbCBzaWduYWxzIGZvciByb2xlIHN3
aXRjaC4gSWYgeW91IGhhdmUgbm90IHVzZWQNCj4gPiBpdCwgSSBwcmVmZXIgb25seSBzZXR0aW5n
IGNkbnMtPnJvbGVfc3cgZm9yIHJvbGUgc3dpdGNoIHVzZSBjYXNlcy4NCj4gPg0KPiANCj4gV2Ug
dXNlIGJvdGggaGFyZHdhcmUgcm9sZSBzd2l0Y2ggYW5kIC9zeXMgZW50cmllcyBmb3IgbWFudWFs
bHkgZm9yY2luZyBhDQo+IGNlcnRhaW4gcm9sZS4NCj4gDQo+IFdlIGRvIG5vdCBzZXQgYW55ICJ1
c2Itcm9sZS1zd2l0Y2giIHByb3BlcnR5IGF0IERUUy4NCj4gDQo+IEN1cnJlbnRseSBjZG5zLT5y
b2xlX3N3IGlzIGJlaW5nIGFsd2F5cyBzZXQgYnkgZHJpdmVyIGlycmVzcGVjdGl2ZSBvZiBhbnkg
RFQNCj4gcHJvcGVydHksIHNvIHRoaXMgcGF0Y2ggaXMgY2xlYXJseSB3cm9uZyBhbmQgbmVlZHMg
dG8gYmUgcmV2ZXJ0ZWQuDQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQoNCkNvdWxkIHlv
dSBhY2NlcHQgYmVsb3cgZml4Pw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvY29y
ZS5jIGIvZHJpdmVycy91c2IvY2RuczMvY29yZS5jDQppbmRleCAyZTQ2OTEzOTc2OWYuLmZkZDUy
ZTg3YTdiMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KKysrIGIvZHJp
dmVycy91c2IvY2RuczMvY29yZS5jDQpAQCAtMjgwLDggKzI4MCw4IEBAIGludCBjZG5zM19od19y
b2xlX3N3aXRjaChzdHJ1Y3QgY2RuczMgKmNkbnMpDQogICAgICAgIGVudW0gdXNiX3JvbGUgcmVh
bF9yb2xlLCBjdXJyZW50X3JvbGU7DQogICAgICAgIGludCByZXQgPSAwOw0KDQotICAgICAgIC8q
IERlcGVuZHMgb24gcm9sZSBzd2l0Y2ggY2xhc3MgKi8NCi0gICAgICAgaWYgKGNkbnMtPnJvbGVf
c3cpDQorICAgICAgIC8qIHF1aXQgaWYgc3dpdGNoIHJvbGUgdGhyb3VnaCBleHRlcm5hbCBzaWdu
YWxzICovDQorICAgICAgIGlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGNkbnMtPmRldiwg
InVzYi1yb2xlLXN3aXRjaCIpKQ0KICAgICAgICAgICAgICAgIHJldHVybiAwOw0KDQogICAgICAg
IHBtX3J1bnRpbWVfZ2V0X3N5bmMoY2Rucy0+ZGV2KTsNCg0KUGV0ZXINCg==
