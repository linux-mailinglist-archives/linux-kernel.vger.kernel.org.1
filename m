Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08D026D205
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 06:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIQEEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 00:04:36 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:33700
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbgIQEEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcjzZ9BHDRT8vp7m9x1VUENkVS/mlPHldeHejUztI+jRkcFSiPs8mzDQ3QhOE2Avo9NWSEcmq+GOOo7HNuL3Ub6Ap+b2yKJXK2/3TSYwcLF6qFPzA3bDe1m7E/Bxr8eajDtCn+/TmRdV+r4ZEQ//VSClrX4pxiudtiZejhqCR/81Jl4m7DMZQ6GCAYSQOzDIqL+KKuQ5dNz0QUCmE8D1Hr0UrP7c2rrOaWdzz7VLUx/WepR2i4ynIYyE3oK3lan9WOKTytGgOJylEepv0GEMxBm3/aJAdd+zjLxnQoKajSw2seQ18OYQpY8Tk/v1KnzoAs81zQQTV00594scNcKBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=688owMFuwGBr4mNFdLceJC3vH/H4ADj7SE8NtzmMtio=;
 b=K07d5ne5tfREDU1BhJbt5Rp06XFzsSMK6r1aEl90PdJw7Kkoj1GoJ7wj1xLXgOzGq8SnCBqrA/AnXt6YsYE9Zs0MAcdSsDzMMX/b+5hE2CVe4O4QzoWgV2UcPFvNDn6iDZlNrKG8+5P3tLnQoMnqmu012rQuYaFEqx3zNM4ANSXhLx7y6xZeo43rY5HfDQLYd9O2sMWoUlfv3fUg5plKtp9a9NurdIcspMZ/LXuuFHD6sKU/r4e/DXOyxDymqgqIxGRg81VUPt7awTq0PwYSfwfq4Bqz16B+JpyIk8YkgNDOhpGKGZPS4yJB66Z81jtR2AvuopcW9QEPKYdQyDQLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=688owMFuwGBr4mNFdLceJC3vH/H4ADj7SE8NtzmMtio=;
 b=QFZ9Vn6z6ODVv6LLFJdQM0sfBas9y2/SSWjdBe2W2UJ5YJUYprq9vf9LtnpGwgcMhm03qKmOB3d3PecSqoJ3x/boOcIHtBixeuxACuBmmIo1xetnogLEE/XzN5CA3brp6fJ+ITgjKr5tItZlbtbJyDP57lK8lEaj8uC3RpI3MhA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4677.eurprd04.prod.outlook.com (2603:10a6:20b:25::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 04:04:29 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 04:04:29 +0000
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
Subject: RE: [PATCH V2 3/4] ARM: imx: imx7ulp: support HSRUN mode
Thread-Topic: [PATCH V2 3/4] ARM: imx: imx7ulp: support HSRUN mode
Thread-Index: AQHWi9TkjioikKSvtkmxImgy+nFKG6lsN0MQ
Date:   Thu, 17 Sep 2020 04:04:29 +0000
Message-ID: <AM6PR04MB496611DC4C616CD034A970B9803E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
 <1600224517-31465-4-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1600224517-31465-4-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3453ac77-c1c4-4924-44b3-08d85abec6c9
x-ms-traffictypediagnostic: AM6PR04MB4677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB467718B22172E9D3C1A4CC98803E0@AM6PR04MB4677.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: maL6t9Z0EUyz1zfnxDawVJllK64hbvdlgs3DnSNNJ1cz9QWelEi6Kap2tuXcs30eIQXLros8EYjewl9W3IcgftV+uLkeWYTAjcatTe6WrURwx44kjffnA+wM0ZV/VvGVDLFlaes187szI2/hbLzxRw9ygefjh6ThCUosr6YMyGNoloqV6TFbNBKp9nl6hABoj2y/jHOiyDuc3a1dUoILgVX/SoFKrl0BLGQVhL2Ne1MuwYMwavVkMkCs7OC+9gcMOrqhHOlUc9O7auWs8bPICsGULt+aypwDfq6MbHaJtw0cExaJ/2GVa8+DPWhLCOtrCEPFjzdNbJV9YpbRVK5NVhiSlkydb+BHGF32/WKSnJmGNAIcQRT1OWKH/KeLKF3R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(7696005)(66476007)(66946007)(9686003)(66446008)(64756008)(8676002)(66556008)(8936002)(55016002)(26005)(186003)(6506007)(71200400001)(5660300002)(110136005)(44832011)(4326008)(316002)(52536014)(54906003)(33656002)(86362001)(478600001)(76116006)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nzXGpyyxvcMxJUCpa4zmuR6gA9yD7//MloqBpnhtqVlwvFi3r6L/5FEeTM6naKvIO8R/gmz2/1A7rAQrQ4bldngsPtwS5Jlc8xKgISYRtgCvwG+yPmcF75A8TOR4pfYybK39pcUWgRBa1PDM/xaATwbDsItZKLas8/hH/O74GpwF3R/nUVt5WHivDWi20bM+3x6nEFyeFoE8zSX4so/hMGirYEr5l3ijrFTzJmynFTMZ/GXLdSMOGpHiIqqXGKP5oeam/vCFovoWN1uPWpwZDjny9qhOxX97zfwcs8YiQyBJEktOYXhVwdUlBS5QTbwpo3BTrzYqkHlHTCVLptnJQcXOjRYm2Rwszj/Qkme26u2Nh2eaSu8mx9voQUKitb23W4yrI0wVdh/a5MvW7RpY+BSgC0xRAUmRwcOaTtxPNQZeCGG6+7Y5mB07ycn5XKK1JADg93W4tLmYL5ZBzerem1LfSTvOHXS93G760cbbELDpVimBqDRiP8toBe65t2Sw6JdUbhJI4OCrhp+SaT+Jfqu49EBqOW6EEPrNlyuMGOTMKAWnrlxrQCHSUvTbIxDVnTNLqpHASlvUDo1G8DtlquZ8H+uyYZb2aYdKAFSUk0JneWp4K9gzn+hXM4lx2sUIcH2AHTKh3L2xa7FUj5QkSw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3453ac77-c1c4-4924-44b3-08d85abec6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 04:04:29.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjNgv68a3XaLZ0S7k0WTgeChxmx0LR8XHOUj8Ls6KndJ3Gmx3QufCc9BYAvNsyjcbfdwBStfAY/xfWiaKKkwhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4677
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTYsIDIwMjAgMTA6NDkgQU0NCj4gDQo+IENvbmZpZ3VyZSBQTVBST1QgdG8gbGV0
IEFSTSBjb3JlIGNvdWxkIHJ1biBpbnRvIEhTUlVOIG1vZGUuDQo+IEluIExETy1lbmFibGVkIG1v
ZGUsIEhTUlVOIG1vZGUgaXMgbm90IGFsbG93ZWQsIHNvIGFkZCBhIGNoZWNrIGJlZm9yZQ0KPiBj
b25maWd1cmUgUE1QUk9ULg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvcG0taW14N3VscC5jIHwgMTUg
KysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtaW14L3BtLWlteDd1bHAuYw0KPiBiL2FyY2gv
YXJtL21hY2gtaW14L3BtLWlteDd1bHAuYyBpbmRleCAyZTc1NmQ4MTkxZmEuLjM5M2ZhZjFlODM4
Mg0KPiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1pbXgvcG0taW14N3VscC5jDQo+ICsr
KyBiL2FyY2gvYXJtL21hY2gtaW14L3BtLWlteDd1bHAuYw0KPiBAQCAtMTEsNiArMTEsMTAgQEAN
Cj4gDQo+ICAjaW5jbHVkZSAiY29tbW9uLmgiDQo+IA0KPiArI2RlZmluZSBQTUMwX0NUUkwJCTB4
MjgNCj4gKyNkZWZpbmUgQk1fQ1RSTF9MRE9FTgkJQklUKDMxKQ0KPiArDQo+ICsjZGVmaW5lIFNN
Q19QTVBST1QJCTB4OA0KPiAgI2RlZmluZSBTTUNfUE1DVFJMCQkweDEwDQo+ICAjZGVmaW5lIEJQ
X1BNQ1RSTF9QU1RPUE8gICAgICAgIDE2DQo+ICAjZGVmaW5lIFBTVE9QT19QU1RPUDMJCTB4Mw0K
PiBAQCAtMjUsNyArMjksMTAgQEANCj4gICNkZWZpbmUgQk1fUE1DVFJMX1JVTk0JCSgzIDw8IEJQ
X1BNQ1RSTF9SVU5NKQ0KPiAgI2RlZmluZSBCTV9QTUNUUkxfU1RPUE0JCSg3IDw8IEJQX1BNQ1RS
TF9TVE9QTSkNCj4gDQo+ICsjZGVmaW5lIEJNX1BNUFJPVF9BSFNSVU4JQklUKDcpDQo+ICsNCj4g
IHN0YXRpYyB2b2lkIF9faW9tZW0gKnNtYzFfYmFzZTsNCj4gK3N0YXRpYyB2b2lkIF9faW9tZW0g
KnBtYzBfYmFzZTsNCj4gDQo+ICBpbnQgaW14N3VscF9zZXRfbHBtKGVudW0gdWxwX2NwdV9wd3Jf
bW9kZSBtb2RlKSAgeyBAQCAtNjUsNSArNzIsMTMNCj4gQEAgdm9pZCBfX2luaXQgaW14N3VscF9w
bV9pbml0KHZvaWQpDQo+ICAJb2Zfbm9kZV9wdXQobnApOw0KPiAgCVdBUk5fT04oIXNtYzFfYmFz
ZSk7DQo+IA0KPiArCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgImZz
bCxpbXg3dWxwLXBtYzAiKTsNCj4gKwlwbWMwX2Jhc2UgPSBvZl9pb21hcChucCwgMCk7DQo+ICsJ
V0FSTl9PTighcG1jMF9iYXNlKTsNCj4gKwlvZl9ub2RlX3B1dChucCk7DQo+ICsNCj4gKwlpZiAo
IShyZWFkbF9yZWxheGVkKHBtYzBfYmFzZSArIFBNQzBfQ1RSTCkgJiBCTV9DVFJMX0xET0VOKSkN
Cj4gKwkJd3JpdGVsX3JlbGF4ZWQoQk1fUE1QUk9UX0FIU1JVTiwgc21jMV9iYXNlICsgU01DX1BN
UFJPVCk7DQoNCldoZW4gd2lsbCBIU1JVTiBtb2RlIGJlIGVuYWJsZWQ/IEUuZy4gUlVOTT1IU1JV
Tg0KSXQgc2VlbXMgUlVOTSB3aWxsIGJlIGNsZWFyZWQgaW4gdGhlIGZvbGxvd2luZyBpbXg3dWxw
X3NldF9scG0oKS4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+ICsNCj4gIAlpbXg3dWxwX3NldF9s
cG0oVUxQX1BNX1JVTik7DQo+ICB9DQo+IC0tDQo+IDIuMjguMA0KDQo=
