Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE426D214
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 06:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQELm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 00:11:42 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:59457
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgIQELm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yggt6CaMjqKKC+FeETp3ZGKilKX+BZPBQXX8uq9kkyh+gdsEL8fttTGKIRVTrwJWiaHtPa+/5lX4O9g4n//qkVi01YOJp0ZA9LFUp/eQ91Xx+5fQl752uhWO4kZeHfvOMXGFdwM8o2h51i7cqvT5yWFP09wjuo8H6gBBMbpVRQ7pPH8xs0B+dZnAWKeIH1EuNSXY+bjXZlh/tx4GRX9WsurMBawOpm2CuCWfD7l1RgT+Kkqb2XXk449Giic8wT1jkWi5NJxwFqrzRkMl7qj0iutD4otDSKBeeUEHzoejMwR021nW7RQFrz3DRYNsUNc6Q+1YErWKAs5yCvdyXmDrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKkwGANatxH/LMKEStwRUZwGgo2r3rEYhaPoDx43n34=;
 b=XCsIJ/ocVYeCAJY9Gf1RjCeSca2pgijUkPBzj1fAKmhshDf5vs+d63PruQLlITPAVXhlHsQEm6LOI002WEnQYMc2Gxu4wXSvKQWbzPLfZN6Ol1yBGg4Nt/tPWapVo2Bl/K6fmNQ6rDLct8yDtlHviGGol6mhLgVKc+3EVduWA5+Euea4cy7i8wj3tqSJD6IALKUfMuyAdtMhrH9kwInUaxXenW2f22lltkBL0VFRsqLriUXavIIpArg+JW/rYQriKt5EsGqgkduDGV8gRuDfqug45NUeBfY4NjJFZ69yC90k7Q7zDPg5VUaRaYd7ZA8M7y5aU5mhzxvt9GzcnyZykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKkwGANatxH/LMKEStwRUZwGgo2r3rEYhaPoDx43n34=;
 b=qqLHm2aozvYb50DYo9sAVRqWRa4+MHuxGI9uFjkaX+zMR0felhsneNVCOSGRNj7aveXC/MVDmSRaf7oGPf6RA89yjnOf0At2/N/99lEJo0amSlSic6KLDDw1y6VL6CnNLrYUW4aP36iHU0iEax3S8hEUttf5G0Vx7PUuN2DkeHE=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4677.eurprd04.prod.outlook.com (2603:10a6:20b:25::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 04:11:38 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 04:11:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 4/4] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed
 when HSRUN
Thread-Topic: [PATCH V2 4/4] ARM: imx: cpuidle-imx7ulp: Stop mode disallowed
 when HSRUN
Thread-Index: AQHWi9Tme5Dwi4JWREKrGxGH0KkkLKlsN6ZQ
Date:   Thu, 17 Sep 2020 04:11:37 +0000
Message-ID: <AM6PR04MB4966F2084EBFE51A460B0684803E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
 <1600224517-31465-5-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1600224517-31465-5-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f81d5e99-2907-411c-ce08-08d85abfc611
x-ms-traffictypediagnostic: AM6PR04MB4677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB467715B87CFEEC1DFD2E2B4C803E0@AM6PR04MB4677.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLVUwaPx1ccf+gqN4VB42aeVZNXp5y9MzqcU/mZpjwI7WuEMK3V59uOVvYZWSCmUD5yFfZ6XVw7bc4UPiBDzBRQKf+k31mm5J3dBmByuYONmegjXE87+awOhTcdX/Wd+g/ZsDUkz7i6HbV5EzDx31BhfvSU1f+lvu8fF2VldJMUdbsgnKNV8PYogpzGTl5blGPyFjjIRdz2CiHyMVIUDnQbUfWLx4y5jWa1AYrusTiZGPLLBULMDXQT+bgzkyvY/uMpY8KrtZkXs53VklN5TNo92JG+gFVzEBmhaWDDoUy0xLS9GVfj8eQR5kukftucUGgx+q3AyYnmGyLXfeBCx8Y6wGSMytg73IQsGDTTGO9B0LPcATMD3hhyq+xeLxxOp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(54906003)(5660300002)(110136005)(316002)(52536014)(4326008)(44832011)(478600001)(2906002)(76116006)(33656002)(86362001)(66556008)(55016002)(8936002)(7696005)(66476007)(66446008)(64756008)(8676002)(66946007)(9686003)(6506007)(71200400001)(83380400001)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Fwk9Rl1jltsb5AyhqvFRCf+54o2O3MuCUBqoQt0S9GUZHvcXEU4VDZRNWn4fUgeIGM2+0Slbd1KS6IHG7RvNwKZ/0ABTn8jW+ajQ+ATj3Fwvhc3mxmGNwVsD1cpcI6bM4xb5o/I59GbKCC7EsETMeCzBhE0224GjbAQx42YhVlfpmX5ejl1/YEGIO0eDFYJnvgzh2dmQyAwzvK2ZbL4tjqbJD7FXi4yih7W9it3ZeMvIKLSbSHLNmpk8OYGBnVs2YWrEo6KZXwNrOBdXNwHLOXR8SL41kmXoOgf80YS3+uEsvdyPyGg0NptXNzq+XsPEj7n6rNoYH92zPjaUoRAbnGb0nRr9tUVLvMNzZV/RY6M51KlGSaVkJcJZUvJoZPaeOLApYoE9Ep8I4xGHf6uy0bMpmh3OnDzKpBUBiwU/RBTXU9qYWIv6o1S7t/W1PjzcLac9P4lNi8sGLgE+OXDSLpBCMMZ6oXEDxUP/IrqZmOQ7vew+ADtiJ3pU3ABp3ehioNBvkhW3y7vQJbWLTBPbLC33uoOSOHbJSwSMuRkguWGYWDtS5m1osKHHs6co/KGiqRo1otUuBsgZbR/IRjdYaJgi/8yDJ0pUl3DdVXMidYfP7Qfr33Evsvz1eOzZBE00XdMfh+vNUhA5s4XRlhP9Rw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81d5e99-2907-411c-ce08-08d85abfc611
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 04:11:38.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5jVkJS1W22Lb6CBVFg44b3FP2+XdyEyduKSr/oiqQn+DrlXBNsJ8k2AZvMRrENCFW8BUpyWAgoHz+v5gbgpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4677
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTYsIDIwMjAgMTA6NDkgQU0NCj4gDQo+IFdoZW4gY3B1IHJ1bnMgaW4gSFNSVU4g
bW9kZSwgY3B1aWRsZSBpcyBub3QgYWxsb3dlZCB0byBydW4gaW50byBTdG9wIG1vZGUuDQo+IFNv
IGFkZCBpbXg3dWxwX2dldF9tb2RlIHRvIGdldCB0aHIgY3B1IHJ1biBtb2RlLCBhbmQgdXNlIFdB
SVQgbW9kZQ0KPiBpbnN0ZWFkLCB3aGVuIGNwdSBpbiBIU1JVTiBtb2RlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0v
bWFjaC1pbXgvY29tbW9uLmggICAgICAgICAgfCAgMSArDQo+ICBhcmNoL2FybS9tYWNoLWlteC9j
cHVpZGxlLWlteDd1bHAuYyB8IDE0ICsrKysrKysrKysrLS0tDQo+ICBhcmNoL2FybS9tYWNoLWlt
eC9wbS1pbXg3dWxwLmMgICAgICB8IDEwICsrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwg
MjIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9tYWNoLWlteC9jb21tb24uaCBiL2FyY2gvYXJtL21hY2gtaW14L2NvbW1vbi5oDQo+IGlu
ZGV4IDcyYzNmY2MzMjkxMC4uNzA3YWM2NTBmMWMyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9t
YWNoLWlteC9jb21tb24uaA0KPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9jb21tb24uaA0KPiBA
QCAtMTAzLDYgKzEwMyw3IEBAIHZvaWQgaW14Nl9zZXRfaW50X21lbV9jbGtfbHBtKGJvb2wgZW5h
YmxlKTsgIHZvaWQNCj4gaW14NnNsX3NldF93YWl0X2Nsayhib29sIGVudGVyKTsgIGludCBpbXhf
bW1kY19nZXRfZGRyX3R5cGUodm9pZCk7ICBpbnQNCj4gaW14N3VscF9zZXRfbHBtKGVudW0gdWxw
X2NwdV9wd3JfbW9kZSBtb2RlKTsNCj4gK3UzMiBpbXg3dWxwX2dldF9tb2RlKHZvaWQpOw0KPiAN
Cj4gIHZvaWQgaW14X2NwdV9kaWUodW5zaWduZWQgaW50IGNwdSk7DQo+ICBpbnQgaW14X2NwdV9r
aWxsKHVuc2lnbmVkIGludCBjcHUpOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgv
Y3B1aWRsZS1pbXg3dWxwLmMNCj4gYi9hcmNoL2FybS9tYWNoLWlteC9jcHVpZGxlLWlteDd1bHAu
Yw0KPiBpbmRleCBjYTg2Yzk2N2QxOWUuLmU3MDA5ZDEwYjMzMSAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm0vbWFjaC1pbXgvY3B1aWRsZS1pbXg3dWxwLmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1p
bXgvY3B1aWRsZS1pbXg3dWxwLmMNCj4gQEAgLTE1LDEwICsxNSwxOCBAQA0KPiAgc3RhdGljIGlu
dCBpbXg3dWxwX2VudGVyX3dhaXQoc3RydWN0IGNwdWlkbGVfZGV2aWNlICpkZXYsDQo+ICAJCQkg
ICAgc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYsIGludCBpbmRleCkgIHsNCj4gLQlpZiAoaW5k
ZXggPT0gMSkNCj4gKwl1MzIgbW9kZTsNCj4gKw0KPiArCWlmIChpbmRleCA9PSAxKSB7DQo+ICAJ
CWlteDd1bHBfc2V0X2xwbShVTFBfUE1fV0FJVCk7DQo+IC0JZWxzZQ0KPiAtCQlpbXg3dWxwX3Nl
dF9scG0oVUxQX1BNX1NUT1ApOw0KPiArCX0gZWxzZSB7DQo+ICsJCW1vZGUgPSBpbXg3dWxwX2dl
dF9tb2RlKCk7DQo+ICsNCj4gKwkJaWYgKG1vZGUgPT0gMykNCg0KQ2FuIHdlIGFsc28gcHV0IGEg
Y29tbWVudCBhYm92ZSB0byBlYXNlIHRoZSBjb2RlIHJlYWRpbmc/DQpPdGhlcndpc2U6DQpSZXZp
ZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0K
QWlzaGVuZw0KDQo+ICsJCQlpbXg3dWxwX3NldF9scG0oVUxQX1BNX1dBSVQpOw0KPiArCQllbHNl
DQo+ICsJCQlpbXg3dWxwX3NldF9scG0oVUxQX1BNX1NUT1ApOw0KPiArCX0NCj4gDQo+ICAJY3B1
X2RvX2lkbGUoKTsNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWlteC9wbS1pbXg3
dWxwLmMNCj4gYi9hcmNoL2FybS9tYWNoLWlteC9wbS1pbXg3dWxwLmMgaW5kZXggMzkzZmFmMWU4
MzgyLi4xNDEwY2NmYzcxYmQNCj4gMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14L3Bt
LWlteDd1bHAuYw0KPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9wbS1pbXg3dWxwLmMNCj4gQEAg
LTYzLDYgKzYzLDE2IEBAIGludCBpbXg3dWxwX3NldF9scG0oZW51bSB1bHBfY3B1X3B3cl9tb2Rl
IG1vZGUpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiArdTMyIGlteDd1bHBfZ2V0X21vZGUo
dm9pZCkNCj4gK3sNCj4gKwl1MzIgbW9kZTsNCj4gKw0KPiArCW1vZGUgPSByZWFkbF9yZWxheGVk
KHNtYzFfYmFzZSArIFNNQ19QTUNUUkwpICYgQk1fUE1DVFJMX1JVTk07DQo+ICsJbW9kZSA+Pj0g
QlBfUE1DVFJMX1JVTk07DQo+ICsNCj4gKwlyZXR1cm4gbW9kZTsNCj4gK30NCj4gKw0KPiAgdm9p
ZCBfX2luaXQgaW14N3VscF9wbV9pbml0KHZvaWQpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZV9u
b2RlICpucDsNCj4gLS0NCj4gMi4yOC4wDQoNCg==
