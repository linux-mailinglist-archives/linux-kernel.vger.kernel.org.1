Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64B28EB68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgJODRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 23:17:10 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:58241
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgJODRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj9xSrqQGxa1hgk+oSrvnqncUTCwF1189TKlCvsPMUbS9YqsB+Miy5m4OXn6G6hLv9y3Z6sePaKohRLhewJxXv2zxXIEl60HwWJEzKtd6rxMxce7LFn/IlJtwCi84lUfQux+AyDy54/djaRZeB8b/i3YJrGciK/Lyuk8FvYWeMQzV0KILJwF4/hmXoD9aMQSekC9OJLylVxag4omNeXv/8kDuDoURoOTmV5GYrLplARESWtU7rtRYOD7uEoEt5nu0NJwtmkAn5QjP8QFIa3aULJSw6hDBZvCRQFuaJgrOvETyp2VrSNxwvo7DyKqjqqdQHzZn+cMnyugbkfccVp4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdwITQBoGxWp3oBnP0CEvR5KOVLHCzeyAUJlWys10Y0=;
 b=cyis8B/97h12w4nCv2sv4kB4u/EaYV7IG2tEEl/nBMBxYC5T2lOiP81K8XRpiSN31BNm9YOT4pi2VENY12hepzXggfP7j+PuEP7hUnMU579UGTztFpcOa5Ku96/BEC2dkqvUpCuuwqKh2PkXEDGscSUE6u7ErZVsTvBsnSW8vIOdqdyESQbXAiXeL7yryWD2O3ixIPY3tgCw8oMBN42vbC/PudGwyE+xScaXs4/6TlXkSvKqLw2tteWK9sJEdoktsK3A3QayAoZn/0mnQzLsDoDyqUx1pi8ekN6gc6wlIjyMihI2CwDxz9OSWgWFG2nH+OYLF4I4rRrcaoSudbToJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdwITQBoGxWp3oBnP0CEvR5KOVLHCzeyAUJlWys10Y0=;
 b=jmavOOelB8POu1brXBjqNtHxOZ6blmp2Vlke6BsdCGakem55x8JQw0efjJpQV/TcmnjAVe1hCuvFIMHbB31Jr5C9vdR6J7Tm8weBzbS6lv5d+NXmntrl7z5DEfr4NiFjicHDOpJJbQiDKGEDa5jraDdca9UCZ1sBFexq2/AdXkc=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 15 Oct
 2020 03:17:06 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%9]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 03:17:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Ying Liu <victor.liu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] firmware: imx: always export scu symbols
Thread-Topic: [PATCH] firmware: imx: always export scu symbols
Thread-Index: AQHWogi4CkuQ02Y7uUCWsK78C0DdxamX4jYAgAAa92A=
Date:   Thu, 15 Oct 2020 03:17:05 +0000
Message-ID: <DB8PR04MB6795954B70F8C511E780E026E6020@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <1602665834-29902-1-git-send-email-qiangqing.zhang@nxp.com>
 <4172025486c3821ec063199041b0a92118e0cf4d.camel@nxp.com>
In-Reply-To: <4172025486c3821ec063199041b0a92118e0cf4d.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e7ce48e-891a-49e2-ee3e-08d870b8cb4c
x-ms-traffictypediagnostic: DBAPR04MB7240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB72401B3A336D1C7181B1AF79E6020@DBAPR04MB7240.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 305Svw5IYSAgr431zWps9+sqGazXkN4Szv0Nl6yPFXFCNFXeoqheJ0FEQm7HJ3Caq5rXokyQOP8XzcMwPr4rZ8BqAVnh7dwZayFMCqWiH6WPhzBg8dJIdIaivQ4WHQgBUQ9GAy9xFb3GOkQeokb9wJv4PjkCLPJVhpjl+uREt3/zFotqVsgM3pnHZyr2QGx2gLYR0RUEkcJfcQmBMFzp3XUudi6n4tbmHCQ1vMeB8kiWq/6XJUmkBS4lNWKhoklCJr077xh2eT1zXS+3E9qc6K1xsxLc0zcKSO2Sw6EAAGh/Ovw7Aolcv9mMEdaHVsa2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(86362001)(4001150100001)(8676002)(83380400001)(66476007)(66556008)(66946007)(53546011)(66446008)(4326008)(478600001)(7696005)(6506007)(76116006)(64756008)(8936002)(55016002)(5660300002)(71200400001)(52536014)(2906002)(9686003)(54906003)(110136005)(316002)(33656002)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: I9Su7Cw1Wnqb5hPsD8f3tbCAzUMYURS0yyBq7xOvyt3tNMmWX7sEceBAomjU9e9MaZqlS1ie9o1ABSG0jIxRaHsQ/Uzr3Jk0Vmo2q1ucgRx9szwyNEbTDPysrIsIiOtKNcKQHZmSrEy6PUi7ilaSv15nmz+LXeMlzV7N4u2nrE8eCB8pqUncxN1wIZ4TuxJa35teQbj7YblCRkie5emTZ+5lhDIc44eei+kCpeXyozeqCF0duGiA0fYQcqFQyomfiLfYBlIbn0RENpAwbHqBaD+8MeYKzJsQXZR8BidCkIt2I39elOP8vRcW9t3xzFlXd//OqYMiFLgArtDJFuQ6mE6kjBbW2qxurj0DdFATGPzDtf9yzafJtwWUrCmpBVkovpQ7hwJSJIyPA5mNp5OoEoYS0w8p9ZY8HMmoGYjSTxqjp2MOilb1kbrbfm6ECJhgWiHWMrxvB+vbWScVN9Rb27L45oUrbV2CPTFF0rUxrAJUSefLrBFK1iae/Fam3HfKKmBjd6Utmm2s86WBeboaIq/Yu44BfFjVXI2xH1s1jdwQ6g4LybEMS2DCiGS/RGkmuAYyQ8df0UcLQgJbqKzHFNqrj64NVipk9IebEZOZBO3I7YjfTtDWYCakJaukjEuNIQxyq8vV027leHrEg5oRdg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7ce48e-891a-49e2-ee3e-08d870b8cb4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 03:17:05.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ4D6TJwcsoQEe/GG4lZE42lstqfAInOvCC0mIJxWs5YUQNoBZp7VWD6fbp3IRGqtu95OsYZVi+9bdsNDADePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBZaW5nLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlpbmcg
TGl1IDx2aWN0b3IubGl1QG54cC5jb20+DQo+IFNlbnQ6IDIwMjDlubQxMOaciDE15pelIDk6MzMN
Cj4gVG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBzaGF3bmd1b0Br
ZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlDQo+IENjOiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhA
bnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGZpcm13YXJlOiBpbXg6IGFsd2F5cyBleHBvcnQgc2N1IHN5bWJv
bHMNCj4gDQo+IEhpIEpvYWtpbSwNCj4gDQo+IE9uIFdlZCwgMjAyMC0xMC0xNCBhdCAxNjo1NyAr
MDgwMCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IEZyb206IExpdSBZaW5nIDx2aWN0b3IubGl1
QG54cC5jb20+DQo+ID4NCj4gPiBBbHdheXMgZXhwb3J0IHNjdSBzeW1ib2xzIGZvciBib3RoIFND
VSBTb0NzIGFuZCBub24tU0NVIFNvQ3MgdG8gYXZvaWQNCj4gPiBidWlsZCBlcnJvci4NCj4gDQo+
IHMvc2N1L1NDVS8NCg0KT0suDQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpdSBZaW5nIDx2
aWN0b3IubGl1QG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFpoYW5nIDxxaWFuZ3Fpbmcuemhh
bmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvaXBj
LmggICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJl
L2lteC9zdmMvbWlzYy5oIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUv
aW14L2lwYy5oDQo+ID4gaW5kZXggODkxMDU3NDM0ODU4Li4zMDBmYTI1M2ZjMzAgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmgNCj4gPiArKysgYi9pbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL2lteC9pcGMuaA0KPiA+IEBAIC0zNCw2ICszNCw3IEBAIHN0cnVj
dCBpbXhfc2NfcnBjX21zZyB7DQo+ID4gIAl1aW50OF90IGZ1bmM7DQo+ID4gIH07DQo+ID4NCj4g
PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0lNWF9TQ1UpDQo+ID4gIC8qDQo+ID4gICAqIFRoaXMg
aXMgYW4gZnVuY3Rpb24gdG8gc2VuZCBhbiBSUEMgbWVzc2FnZSBvdmVyIGFuIElQQyBjaGFubmVs
Lg0KPiA+ICAgKiBJdCBpcyBjYWxsZWQgYnkgY2xpZW50LXNpZGUgU0NGVyBBUEkgZnVuY3Rpb24g
c2hpbXMuDQo+ID4gQEAgLTU1LDQgKzU2LDE4IEBAIGludCBpbXhfc2N1X2NhbGxfcnBjKHN0cnVj
dCBpbXhfc2NfaXBjICppcGMsIHZvaWQNCj4gPiAqbXNnLCBib29sIGhhdmVfcmVzcCk7DQo+ID4g
ICAqIEByZXR1cm4gUmV0dXJucyBhbiBlcnJvciBjb2RlICgwID0gc3VjY2VzcywgZmFpbGVkIGlm
IDwgMCkNCj4gPiAgICovDQo+ID4gIGludCBpbXhfc2N1X2dldF9oYW5kbGUoc3RydWN0IGlteF9z
Y19pcGMgKippcGMpOw0KPiA+ICsNCj4gPiArI2Vsc2UNCj4gPiArc3RhdGljIGlubGluZSBpbnQN
Cj4gPiAraW14X3NjdV9jYWxsX3JwYyhzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB2b2lkICptc2cs
IGJvb2wgaGF2ZV9yZXNwKSB7DQo+ID4gKwlyZXR1cm4gLUVJTzsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGlubGluZSBpbnQgaW14X3NjdV9nZXRfaGFuZGxlKHN0cnVjdCBpbXhfc2NfaXBj
ICoqaXBjKSB7DQo+ID4gKwlyZXR1cm4gLUVJTzsNCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiAr
DQo+ID4gICNlbmRpZiAvKiBfU0NfSVBDX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS9pbXgvc3ZjL21pc2MuaA0KPiA+IGluZGV4IDAzMWRkNGQzYzc2Ni4uZDI1NTA0OGYxN2RlIDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9taXNjLmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oDQo+ID4gQEAgLTQ2
LDYgKzQ2LDcgQEAgZW51bSBpbXhfbWlzY19mdW5jIHsNCj4gPiAgICogQ29udHJvbCBGdW5jdGlv
bnMNCj4gPiAgICovDQo+ID4NCj4gPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0lNWF9TQ1UpDQo+
ID4gIGludCBpbXhfc2NfbWlzY19zZXRfY29udHJvbChzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1
MzIgcmVzb3VyY2UsDQo+ID4gIAkJCSAgICB1OCBjdHJsLCB1MzIgdmFsKTsNCj4gPg0KPiA+IEBA
IC01NSw0ICs1NiwyNiBAQCBpbnQgaW14X3NjX21pc2NfZ2V0X2NvbnRyb2woc3RydWN0IGlteF9z
Y19pcGMgKmlwYywNCj4gPiB1MzIgcmVzb3VyY2UsICBpbnQgaW14X3NjX3BtX2NwdV9zdGFydChz
dHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1MzINCj4gPiByZXNvdXJjZSwNCj4gPiAgCQkJYm9vbCBl
bmFibGUsIHU2NCBwaHlzX2FkZHIpOw0KPiA+DQo+ID4gKyNlbHNlDQo+ID4gK3N0YXRpYyBpbmxp
bmUgaW50DQo+ID4gK2lteF9zY19taXNjX3NldF9jb250cm9sKHN0cnVjdCBpbXhfc2NfaXBjICpp
cGMsIHUzMiByZXNvdXJjZSwNCj4gPiArCQkJdTggY3RybCwgdTMyIHZhbCkNCj4gPiArew0KPiA+
ICsJcmV0dXJuIC1FSU87DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50DQo+
ID4gK2lteF9zY19taXNjX2dldF9jb250cm9sKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUzMiBy
ZXNvdXJjZSwNCj4gPiArCQkJdTggY3RybCwgdTMyICp2YWwpDQo+ID4gK3sNCj4gPiArCXJldHVy
biAtRUlPOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBpbXhfc2NfcG1f
Y3B1X3N0YXJ0KHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUzMg0KPiA+IHJlc291cmNlLA0KPiA+
ICsJCQkJICAgICAgYm9vbCBlbmFibGUsIHU2NCBwaHlzX2FkZHIpIHsNCj4gPiArCXJldHVybiAt
RUlPOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9TQ19NSVND
X0FQSV9IICovDQo+IA0KPiBUaGlzIGlzIGRvbmUgaW4gb3VyIGRvd25zdHJlYW0gdHJlZS4gSSBk
aWQgdGhpcyBiZWNhdXNlIGEgZG93bnN0cmVhbSBkaXNwbGF5DQo+IGRyaXZlciBjb3ZlcnMgU29D
cyB3L3dvIFNDVS4gRm9yIHVwc3RyZWFtLCBJIGZpbmQgdGhlIGRyaXZlcnMgY2FuIGJlIHNwbGl0
ZWQgc28NCj4gdGhhdCB0aGlzIGlzIG5vdCBuZWVkZWQuDQo+IA0KPiBEbyB5b3Ugc2VlIGFueSBl
eGlzdGluZyB1cHN0cmVhbSBkcml2ZXIgY292ZXJzIFNvQ3Mgdy93byBTQ1U/DQpZZXMsIEZsZXhD
QU4gZHJpdmVyIGNvdmVycyBTb0NzIHcvd28gU0NVLCBzbyBJIG5lZWQgdGhpcyBwYXRjaCB0byBh
dm9pZCBhZGRpbmcgSVNfRU5BQkxFRChDT05GSUdfSU1YX1NDVSkgaW4gRmxleENBTiBkcml2ZXIu
DQoNCj4gSSB0aGluayB0aGlzIGNhbiBiZSBpbnRyb2R1Y2VkIHRvZ2V0aGVyIHdpdGggdGhlIGZp
cnN0IHRoYXQga2luayBvZiBkcml2ZXIuDQpPaywgaXQgc2VlbXMgYmV0dGVyLCB0aGFua3MuDQoN
CkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KPiAtLQ0KPiAgTGl1IFlpbmcNCg0K
