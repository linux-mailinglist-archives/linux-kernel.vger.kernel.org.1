Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0729AC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbgJ0Mi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:38:58 -0400
Received: from mail-eopbgr770047.outbound.protection.outlook.com ([40.107.77.47]:17248
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2900064AbgJ0Mi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvShI/LQTivEom0p/OsULUAxq9SPOrFRkUHTEyuK+ARxE1f/wSEg/L7KkFCbzQfVvjXRKBFU/RY+ambxmTqTGlepk8l4foLJe4CdnRAL9vUURgeOONk0cJJNNtzPtQDwqIgmtpo9rpT1o+C6r5lC8PNk0jnXuCPP9PGHMhQiXVm546QjxZpZ2VCo3BJBZn0zjBPCFfts5D8A9ZE546FpKWptZmUReVD4pCh0Nl8MFDqrY4mJsqi54MiY5NsjNlXv4Pwhll2iKDKY721nj+BHmWWNexrmLI0We0t2AKa+YRBUs9urplpEsugsV3XhQN93U6zOodVWsqYYNVg+u3xMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRyZR222gvh0YnZ81+kzDMo2DZWUgUUEyRRx5Re9fmo=;
 b=caoIMqTBgez5QtCm7TTiF2b4ia0HoNzgk5ghjjIzuXPlBqTUCpGXxweuE2NVh0cNiX4ZjiWMuKt6qQkXP5J+YDd1jKw+wDuq3KWgu0E2T60eSm1wo+Oi7Ss/FrxRJ7sT2yrpJBXv7oirsU8nNjLs2VAEOcXj162BucDu/OBGNrVP5Pg/JrD1RCa0G+bWfnN56dHRU8N/wg3UyDbG6uazVYvRFRXqXq67p2c4mAgO8m0BpfSZzB6NaQ1v6D1bCbGE4RYj2pLtKqXZEnydnY7n7ln4pV6DuptIKmDF/QiD1ap3aKn2khbGuFx/wlJF0teFZ3XS5C45x+xu/NsZjG1muQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRyZR222gvh0YnZ81+kzDMo2DZWUgUUEyRRx5Re9fmo=;
 b=tVjIx+4Rn+NGW3ZUUaQlmrBFwJFTWjlCumfLiuRw/2iN1oo9LvFcoMX25kGfFFIZP9e17CXVMQIMT7WjRAjwRWRsjLI0r11TLIbRrnwMh45F5U3fuAM/Viwf6qxOL0BGUoLWYlQL124dn2Il6B43KbZU48mr5pmeftUellNihqE=
Received: from BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18)
 by BY5PR02MB7074.namprd02.prod.outlook.com (2603:10b6:a03:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 12:38:53 +0000
Received: from BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f923:e06c:f837:bd7e]) by BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f923:e06c:f837:bd7e%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 12:38:53 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, Arnd Bergmann <arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH] firmware: xilinx: fix out-of-bounds access
Thread-Topic: [PATCH] firmware: xilinx: fix out-of-bounds access
Thread-Index: AQHWq7BcZtWlKQFhOUiN9ze4b/47+6mrNpSAgAApuaCAAAFTgIAAAgDA
Date:   Tue, 27 Oct 2020 12:38:52 +0000
Message-ID: <BYAPR02MB394157181C05FC902D56C51CB7160@BYAPR02MB3941.namprd02.prod.outlook.com>
References: <20201026155449.3703142-1-arnd@kernel.org>
 <459e03f1-2a9e-5bc4-4bf6-9a0ddf5c4a70@xilinx.com>
 <BYAPR02MB39417FEC6A86636833EF25ECB7160@BYAPR02MB3941.namprd02.prod.outlook.com>
 <8a632786-eb40-ea00-2b98-2d494fabb06f@xilinx.com>
In-Reply-To: <8a632786-eb40-ea00-2b98-2d494fabb06f@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81a0031c-aff0-4286-5869-08d87a754348
x-ms-traffictypediagnostic: BY5PR02MB7074:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB7074B6720A38F4FD77EB0A4DB7160@BY5PR02MB7074.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQKoe7zztFnLdF8zHEsosw8t0OxWRbMpYW0R8xfvgL00q2yo5B7MFUgA+AiXagNIF3scK4gjdkke/EcZ/+aONI/PeyM4JLNgPI86zFiiMC/Frab06+S1igi20hQK7VDSFXwhHDjiS7lqVQPAqDrAnVwDJocnWzzVYN5ZyATdCEb+sLlyYzWFuKDjS1uk4zGfJdEBtg3RYtdhfEcBiu21lpQdQTFCmRU29hIFLWMT8jo6+jsZewKcIZ9mAg5b7i2av7K9CzbxfyOSWMDLQahCeHHc28MjZDfuTnsSvJyx879JOf57jdIDdR6jRwVqGmWY4enlfF15UQ4IRlebZbCP8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3941.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(9686003)(478600001)(86362001)(5660300002)(316002)(52536014)(54906003)(110136005)(55016002)(2906002)(4326008)(186003)(8676002)(8936002)(107886003)(66446008)(66476007)(76116006)(83380400001)(7696005)(6506007)(71200400001)(66946007)(53546011)(64756008)(33656002)(26005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: znRFO5YWznsNmtDBdv6SS1aGAeq4Vy1kudVh0GdAObmn8mcdSQtxyIjMk4IUn2LAXfJ7IFWLUYg0LiXhjAYY/C+AeimzjCRx/EBDO5MSBXGzPzdI9nqw0zKxUacpty2wFs1LSyW43q0f2qPJem74QlGwBbMjcW8KIsXvFrjjSX/x8eNO+4S1kKwqtTyqeyFozn9xofhWYmg7StjKi4RI9FyYkVD+DtToPhPzyDuUosKTDjB1ecj2s3cTQKTmg0NW+1I70aiapdT/ySGRVT4zKIMTRrQOYkMl2imJ0zM4Z0kdZYXwlzrg0GWdytEf7bSZvuY8B3WdamEdE1LqfUDCfpmERdxR8dJA2LJQSBP1ZEzqyf2Ek/VyusHQh5AYLVSL8h4++3wabvWW6vtrWqSj3aKMYUHwQmSQGzCqGUpgiPp152dJgvw3HDoQGBEiGkRhsU7qCnfS0Q7Ofdex1od6MaeivnCrq6mTm/G0Ov2YreuxFRSKcZ9diWxBiKoYpkZWmsHVmtuHL6HP98fnOnYoh4b9mIeD6UOT9M3rEC6gxaK1qIQ2YhNGBH9gO71v6ExSCPvHSk1/BArH0O2ugMsJY/oqNTGgUvFALTI0gJKfXMVCtLf+d2IxWHU3vDvrm7D6fLpqYelw15nWHIXtOkCiXQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a0031c-aff0-4286-5869-08d87a754348
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:38:52.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hj1pZnR+07ScfFuG75KoO8I/ip4/x1yvL1+PRVW/nzGwdtGhdpbrwtXh45UxsaOQoHRrJUh7OMDdG1rZ90JCKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlj
aGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gU2VudDogMjcgT2N0b2JlciAy
MDIwIDA1OjI3DQo+IFRvOiBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47IEFybmQgQmVy
Z21hbm4gPGFybmRAa2VybmVsLm9yZz4NCj4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsg
VGVqYXMgUGF0ZWwgPFRFSkFTUEB4aWxpbnguY29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0IDxnaXRA
eGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZmlybXdhcmU6IHhpbGlueDogZml4
IG91dC1vZi1ib3VuZHMgYWNjZXNzDQo+IA0KPiANCj4gDQo+IE9uIDI3LiAxMC4gMjAgMTM6MjMs
IFJhamFuIFZhamEgd3JvdGU6DQo+ID4gSGkgTWljaGFsLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhp
bGlueC5jb20+DQo+ID4+IFNlbnQ6IDI3IE9jdG9iZXIgMjAyMCAwMjo1Mw0KPiA+PiBUbzogQXJu
ZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPjsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlu
eC5jb20+Ow0KPiA+PiBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT4NCj4gPj4gQ2M6IEFy
bmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNv
bT47DQo+IEdyZWcNCj4gPj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+OyBUZWphcyBQYXRlbA0KPiA+PiA8VEVKQVNQQHhpbGlueC5jb20+OyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBnaXQgPGdpdEB4aWxpbnguY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBmaXJt
d2FyZTogeGlsaW54OiBmaXggb3V0LW9mLWJvdW5kcyBhY2Nlc3MNCj4gPj4NCj4gPj4NCj4gPj4N
Cj4gPj4gT24gMjYuIDEwLiAyMCAxNjo1NCwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPj4+IEZy
b206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+ID4+Pg0KPiA+Pj4gVGhlIHp5bnFt
cF9wbV9zZXRfc3VzcGVuZF9tb2RlKCkgYW5kDQo+ID4+IHp5bnFtcF9wbV9nZXRfdHJ1c3R6b25l
X3ZlcnNpb24oKQ0KPiA+Pj4gZnVuY3Rpb25zIHBhc3MgdmFsdWVzIGFzIGFwaV9pZCBpbnRvIHp5
bnFtcF9wbV9pbnZva2VfZm4NCj4gPj4+IHRoYXQgYXJlIGJleW9uZCBQTV9BUElfTUFYLCByZXN1
bHRpbmcgaW4gYW4gb3V0LW9mLWJvdW5kcyBhY2Nlc3M6DQo+ID4+Pg0KPiA+Pj4gZHJpdmVycy9m
aXJtd2FyZS94aWxpbngvenlucW1wLmM6IEluIGZ1bmN0aW9uDQo+ID4+ICd6eW5xbXBfcG1fc2V0
X3N1c3BlbmRfbW9kZSc6DQo+ID4+PiBkcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYzox
NTA6MjQ6IHdhcm5pbmc6IGFycmF5IHN1YnNjcmlwdCAyNTYyIGlzDQo+IGFib3ZlDQo+ID4+IGFy
cmF5IGJvdW5kcyBvZiAndTMyWzY0XScge2FrYSAndW5zaWduZWQgaW50WzY0XSd9IFstV2FycmF5
LWJvdW5kc10NCj4gPj4+ICAgMTUwIHwgIGlmICh6eW5xbXBfcG1fZmVhdHVyZXNbYXBpX2lkXSAh
PSBQTV9GRUFUVVJFX1VOQ0hFQ0tFRCkNCj4gPj4+ICAgICAgIHwgICAgICB+fn5+fn5+fn5+fn5+
fn5+fn5efn5+fn5+fg0KPiA+Pj4gZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmM6Mjg6
MTI6IG5vdGU6IHdoaWxlIHJlZmVyZW5jaW5nDQo+ID4+ICd6eW5xbXBfcG1fZmVhdHVyZXMnDQo+
ID4+PiAgICAyOCB8IHN0YXRpYyB1MzIgenlucW1wX3BtX2ZlYXR1cmVzW1BNX0FQSV9NQVhdOw0K
PiA+Pj4gICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+Pg0KPiA+PiBX
aGljaCBDT05GSUcgb3B0aW9uL3Rvb2wgaXMgcmVwb3J0aW5nIHRoaXMgaXNzdWU/DQo+ID4+DQo+
ID4+Pg0KPiA+Pj4gUmVwbGFjZSB0aGUgcmVzdWx0aW5nIHVuZGVmaW5lZCBiZWhhdmlvciB3aXRo
IGFuIGVycm9yIHJldHVybi4NCj4gPj4+IFRoaXMgbWF5IGJyZWFrIHNvbWUgdGhpbmdzIHRoYXQg
aGFwcGVuIHRvIHdvcmsgYXQgdGhlIG1vbWVudA0KPiA+Pj4gYnV0IHNlZW1zIGJldHRlciB0aGFu
IHJhbmRvbWx5IG92ZXJ3cml0aW5nIGtlcm5lbCBkYXRhLg0KPiA+Pj4NCj4gPj4+IEkgYXNzdW1l
IHdlIG5lZWQgYWRkaXRpb25hbCBmaXhlcyBmb3IgdGhlIHR3byBmdW5jdGlvbnMgdGhhdCBub3cN
Cj4gPj4+IHJldHVybiBhbiBlcnJvci4NCj4gPj4+DQo+ID4+PiBGaXhlczogNzY1ODI2NzFlYjVk
ICgiZmlybXdhcmU6IHhpbGlueDogQWRkIFp5bnFtcCBmaXJtd2FyZSBkcml2ZXIiKQ0KPiA+Pj4g
Rml4ZXM6IGUxNzhkZjMxY2Y0MSAoImZpcm13YXJlOiB4aWxpbng6IEltcGxlbWVudCBaeW5xTVAg
cG93ZXINCj4gbWFuYWdlbWVudA0KPiA+PiBBUElzIikNCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEFy
bmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL2Zp
cm13YXJlL3hpbGlueC96eW5xbXAuYyB8IDMgKysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJl
L3hpbGlueC96eW5xbXAuYw0KPiA+PiBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5j
DQo+ID4+PiBpbmRleCA4ZDFmZjI0NTRlMmUuLmVmYjhhNjZlZmM2OCAxMDA2NDQNCj4gPj4+IC0t
LSBhL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4+PiArKysgYi9kcml2ZXJz
L2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+Pj4gQEAgLTE0Nyw2ICsxNDcsOSBAQCBzdGF0
aWMgaW50IHp5bnFtcF9wbV9mZWF0dXJlKHUzMiBhcGlfaWQpDQo+ID4+PiAgCQlyZXR1cm4gMDsN
Cj4gPj4+DQo+ID4+PiAgCS8qIFJldHVybiB2YWx1ZSBpZiBmZWF0dXJlIGlzIGFscmVhZHkgY2hl
Y2tlZCAqLw0KPiA+Pj4gKwlpZiAoYXBpX2lkID4gQVJSQVlfU0laRSh6eW5xbXBfcG1fZmVhdHVy
ZXMpKQ0KPiA+Pj4gKwkJcmV0dXJuIFBNX0ZFQVRVUkVfSU5WQUxJRDsNCj4gPj4+ICsNCj4gPj4+
ICAJaWYgKHp5bnFtcF9wbV9mZWF0dXJlc1thcGlfaWRdICE9IFBNX0ZFQVRVUkVfVU5DSEVDS0VE
KQ0KPiA+Pj4gIAkJcmV0dXJuIHp5bnFtcF9wbV9mZWF0dXJlc1thcGlfaWRdOw0KPiA+Pj4NCj4g
Pj4+DQo+ID4+DQo+ID4+IERlZmluaXRlbHkgZ29vZCBjYXRjaCBidXQgbm90IHF1aXRlIHN1cmUg
d2hhdCBzaG91bGQgYmUgY29ycmVjdCByZWFjdGlvbi4NCj4gPj4gUmFqYW46IENhbiB5b3UgcGxl
YXNlIHRha2UgYSBsb29rIGF0IGl0IHdpdGggcHJpb3JpdHk/DQo+ID4gW1JhamFuXSBDaGFuZ2Ug
bG9va3MgZmluZSB0byBtZS4NCj4gDQo+IGFzIGlzIG1lbnRpb25lZCBhYm92ZSB0aGF0IHR3byBm
dW5jdGlvbnMgbm93IHJldHVybnMgYW5kIGVycm9yDQo+IFBNX0ZFQVRVUkVfSU5WQUxJRC4gV2hp
Y2ggbWVhbnMgdGhhdCB6eW5xbXBfcG1fc2V0X3N1c3BlbmRfbW9kZSgpDQo+IGFuZA0KPiB6eW5x
bXBfcG1fZ2V0X3RydXN0em9uZV92ZXJzaW9uKCkgZmFpbCBhbGwgdGhlIHRpbWUgd2hpY2ggZG9l
c24ndCBsb29rDQo+IGNvcnJlY3QuDQpbUmFqYW5dIFJpZ2h0IE1pY2hhbCwgSSBjb21wbGV0ZWx5
IG1pc3NlZCBBUEkgd2hpY2ggYXJlIG5vdCBpbiBwbXVmdyAsICBBUEkgSURzIGZyb20gQVRGIGFy
ZSBkaWZmZXJlbnQgYW5kIGl0IGRvZXNuJ3QgZml0IGluIFBNX0FQSV9NQVggcmFuZ2UsIHNvIEkg
dGhpbmsgaW5zdGVhZCBvZiBqdXN0IHNpbmdsZSBhcnJheSB3aXRoIFBNX0FQSV9NQVggc2l6ZSwg
aW1wbGVtZW50YXRpb24gY2FuIGJlIHVwZGF0ZWQgaGF2aW5nLCBoYXNoIHRhYmxlIGtpbmQgb2Yg
aW1wbGVtZW50YXRpb24gYW5kIG5vdCBkaXJlY3RseSBpbiBhcnJheSBpbmRleCB3aGljaCBpcyBz
YW1lIGFzIEFQSSBJRC4NCg0KVGhhbmtzLA0KUmFqYW4gDQo+IA0KPiBNDQo=
