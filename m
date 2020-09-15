Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889A9269E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgIOGez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:34:55 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:23792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgIOGev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:34:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7GQyzvsPNdx6LkvGaKVXt9QOCCneCCO6CGO2NXRuu6vNIU8bsHJEY308yZHMt/vGI+4vvab4xmwz9CbkMMgqG73YzdsSlEv2F4Ujzz2QH4bGZrcJClaKxoE7wRDm3Zb0dfnkOoLo1GRgZ7BmBzv+YbEw71E5R/VEQmGlADnazbGqtnveI6+wjrBI7W/6fRLQN5OpSBEwMLBgaEAJzPdWNMZQxyijKGEoaMPV8mIYLoHj02sUMJ/7cy0F9X/pxFazn9X1uBJqXfReBpum72RQjMUgJHBLrPb3qmZdnneSAv9ywcm8lAaxoX2XIowl7Flyd3ZhUE486FBUyFf+Iib0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtEmsleJgEIRNZzMnaCYVOW16njlB/IOMQpWuiMnEMk=;
 b=FOV0xAdTMtVqOLNYPzjzBbahOARuqnH8IAUiyZYcUyQy2dTisKZr9OqPOSGj2NLsuumNlvBMmFjXCRuAnxZ8x9m6E/cOife5H8hphs9vjx1iA9uwIDronlVo3xGvAS/5cAeK7lV17dSv6NT3zdQAajT6eGwn1xUQeCSuILkkdE96y38YKATw8qCn0rmjd0ajopeyFNpP8L3S4eZm3Bho9KaHGImJQj5IJOruDmpzeTrtQqwYHYp5+mQQYt5/DJ8Rxzff01CyCPz7R1pY2mhHuUv6OmvOYLLXL3ThBSGPXXlGJucSOrRXybqQRvUcXsMsgK7aP8Xg3L1hSLPce9pqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtEmsleJgEIRNZzMnaCYVOW16njlB/IOMQpWuiMnEMk=;
 b=fqzdWFrD7msgDu59mHpyv4VUnUFLMlqfoQweAHEPEUod3XYKHJ1M2L8o8Ev7fsYteLffj+AvNT/BAR/+v4z52jnMyBHe1ZnpNxwYQyNmQ9GT1+vC9UEDxvwAn/BPu93kjxCjiOvTTBVNDAwpuEFHyh69HfQSFlWzyYVjDYt5KGo=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2476.eurprd03.prod.outlook.com (2603:10a6:3:6e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Tue, 15 Sep 2020 06:34:46 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::88fd:1086:3253:3fcd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::88fd:1086:3253:3fcd%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 06:34:46 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robert.chiras@nxp.com" <robert.chiras@nxp.com>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH 06/13] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Thread-Topic: [PATCH 06/13] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Thread-Index: AQHWgss5NO4jUZlClkGJgvpiKmDktaloy4WAgACC0oA=
Date:   Tue, 15 Sep 2020 06:34:46 +0000
Message-ID: <6bfa15383657ca38a28edac38b5e8adf891865e7.camel@fi.rohmeurope.com>
References: <20200904145312.10960-1-krzk@kernel.org>
         <20200904145312.10960-7-krzk@kernel.org> <20200914224407.GA388924@bogus>
In-Reply-To: <20200914224407.GA388924@bogus>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acabe237-61b4-4f6a-557a-08d859417018
x-ms-traffictypediagnostic: HE1PR0301MB2476:
x-microsoft-antispam-prvs: <HE1PR0301MB247688FA7E134421BFB3F3ABAD200@HE1PR0301MB2476.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YAPxcSeWyCsy4wHECLjJ2pw37qaccjSCvOwuO8fhzu/Sd/mIRLSnoTU2RvuTyulQAwFte9LKkf5TqYZyoQ87JUDc47yKeDI2zNZsqkmbBnVY0MhZ3STjg1Ao4y/vi3HPAY9etSeGiv6fpFVK4s0klSHRXsD1Jx/xX7aIygLAJraVdOD/mFrH1oS8mPGyH+m227vosWA7Ne69kjr2VxTrs98GH9iVt2AfXkBMoLlRMZ+Kid8xgn6m09vZTsYpsg+VwRdhyQOHRWQPV8sBGnQwlOne7hDnCZsuJJpQ1FJ4LYf7OO8wGDVjKbN6+QHiS+zhXMmLpohs+6jwGl1M29rCc9gUgPZOI8+aZHEmMMJcvX419S6SS0YVORVoCG9+JIn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(7416002)(2906002)(8676002)(316002)(478600001)(4326008)(110136005)(3450700001)(8936002)(54906003)(5660300002)(6512007)(2616005)(71200400001)(66446008)(26005)(6486002)(66556008)(64756008)(66476007)(76116006)(86362001)(83380400001)(6506007)(186003)(66946007)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dTZoALMawbX/QMYRtZa6eXACzD8MfZdE/9QoLiFa9Zu7EWYtNmMs1oYWYKxl7KnY+X8Y402XPLhAegolNGaLmZWwPX+i8iHV3q7elwmkAz8W5HFT1mxuctsP2anrhcOFhYnxFp75oqI5lcXtl9dynAJ5h9c/5YrMCZOW+M2zx11Xs+PquuLz7ngvkfGHTqXcThnho5e9ut+iX1VOCXnyf71aoRLc6acyqqN2usFT05tHPq83wk+VCNpLtlda1cfF4UUmHCw1BT8B9ywRyI2NRB0DCD3XeD9/YWsn/39ncphqk7iyeZxet7O4nvRecAV4ZOTxiU+zyv11Dt2qlqMxbbwvKrC07ftE5az7ChYF9WcwLK1+4iIzYyoYeEdt1IbVXe4YOC40lXAxoseuajovytr7WBkG0BSU4Q9CRLYMhBKjQH1QR4k67PO5UYGLKb6BNR1vns4rj1pmIVJfLSewazKtC8m9eGsKVprCsgWPCcAstOSwTSHdKdkvuHvm3MY94SCIxvWjtizEOhDgZ9G4VlGZLERaq2TWePTz+a6rrM7GSGgp4HeH+VMXq4fSUgtZz/omj5A4r+NmZyJEzZSTT9aipIeKf7fbhR/CJCul+a9DH+okcR6I8ZUQ9VlawXarIi0SwOkLFXDz2PWbSIV5Yg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2757F9EFDD17A84A9DE0B10B51F84A28@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acabe237-61b4-4f6a-557a-08d859417018
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 06:34:46.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fuqz2DEnV+bJWtDVa8vhjX2ilB3awswg7e6RZ8yYoOOi9VLp47GtY4gQQrARallq6bPck80//SJcO2rUV31bXNSYJAohcnMnp2mkzncyph6BO+Vp5GzbkrQM+yHE0BTJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIZWxsbyBBbGwsDQoNCk9uIE1vbiwgMjAyMC0wOS0xNCBhdCAxNjo0NCAtMDYwMCwgUm9iIEhl
cnJpbmcgd3JvdGU6DQo+IE9uIEZyaSwgU2VwIDA0LCAyMDIwIGF0IDA0OjUzOjA1UE0gKzAyMDAs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gQWRkIGNvbW1vbiBwcm9wZXJ0aWVzIGFw
cGVhcmluZyBpbiBEVFNlcyAoY2xvY2stbmFtZXMsDQo+ID4gY2xvY2stb3V0cHV0LW5hbWVzKSB0
byBmaXggZHRic19jaGVjayB3YXJuaW5ncyBsaWtlOg0KPiA+IA0KPiA+ICAgYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWxpYnJlbTUtcjIuZHQueWFtbDoNCj4gPiAgICAgcG1p
Y0A0YjogJ2Nsb2NrLW5hbWVzJywgJ2Nsb2NrLW91dHB1dC1uYW1lcycsIGRvIG5vdCBtYXRjaCBh
bnkNCj4gPiBvZiB0aGUgcmVnZXhlczogJ3BpbmN0cmwtWzAtOV0rJw0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTgzNy1wbWljLnlhbWwg
ICAgICAgICAgfCA2DQo+ID4gKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21mZC9yb2htLGJkNzE4MzctDQo+ID4gcG1pYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4MzctDQo+ID4gcG1pYy55YW1sDQo+ID4g
aW5kZXggNjUwMThhMDE5ZTFkLi5lY2NlMGQ1ZTNhOTUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4MzctcG1pYy55YW1sDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4
MzctcG1pYy55YW1sDQo+ID4gQEAgLTMyLDkgKzMyLDE1IEBAIHByb3BlcnRpZXM6DQo+ID4gICAg
Y2xvY2tzOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiAgDQo+ID4gKyAgY2xvY2stbmFtZXM6
DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiANCj4gTmVlZHMgdG8gZGVmaW5lIHdoYXQgdGhlIG5h
bWUgaXMuDQoNClNvbWVvbmUgb25jZSB0b2xkIG1lIHRoYXQgIm5hbWluZyBpcyBoYXJkIi4NCkRv
IHdlIGhhdmUgc29tZSBnb29kIGNvbW1vbiBjb252ZW50aW9uIGZvciAzMksgb3NjaWxsYXRvciBp
bnB1dCBuYW1pbmc/DQpPciBzaG91bGQgaXQganVzdCBiZSBkcm9wcGVkPw0KDQo+IA0KPiA+ICsN
Cj4gPiAgICAiI2Nsb2NrLWNlbGxzIjoNCj4gPiAgICAgIGNvbnN0OiAwDQo+ID4gIA0KPiA+ICsg
IGNsb2NrLW91dHB1dC1uYW1lczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+IA0KPiBJZGVhbGx5
IHRoaXMgb25lIHRvbywgYnV0IHdlJ3ZlIGJlZW4gbW9yZSBmbGV4aWJsZSBvbiBpdC4NCg0KRGF0
YS1zaGVldCBmb3IgQkQ3MTgzNyB1c2VzIHBpbiBuYW1lICJDMzJrX09VVCIuIFNvIG1heWJlIHRo
aXMgd291bGQgYmUNCmdvb2Q/DQoNCkJENzE4MzggdXNlcyAiYmQ3MTgyOC0zMmstb3V0IiAuIHNv
IHdlIGNvdWxkIGFsc28gZ28gd2l0aCB0aGlzIHNhbWUNCmNvbnZlbnRpb24gYW5kIHVzZSAiYmQ3
MTgzNy0zMmstb3V0Ii4gT3IgLSB3ZSBjb3VsZCB0YWtlIGEgcmlzayBhbmQNCiphc3N1bWUqIHR5
cGljYWwgdXNlIGNhc2UgZm9yIHRoaXMgY2xrIChhcyB0aGlzIGlzIHR5cGljYWxseSB1c2VkIHdp
dGgNCmkuTVg4IEknZCBndWVzcyB0aGUgMzJrIGlzIHVzZWQgZm9yIFJUQykgYW5kIG5hbWUgaXQg
YWNjb3JkaW5nbHkuDQoNCkJyLA0KCU1hdHRpIFZhaXR0aW5lbg0KDQotLQ0KTWF0dGkgVmFpdHRp
bmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZA0K
U1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+fn4gIkkg
ZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJlbmUgRGVzY2FydGVzLiBKdXN0IHRoZW4gaGUgdmFuaXNo
ZWQgfn5+DQoNClNpbW9uIHNheXMgLSBpbiBMYXRpbiBwbGVhc2UuDQoibm9uIGNvZ2l0byBtZSIg
ZGl4aXQgUmVuZSBEZXNjYXJ0ZSwgZGVpbmRlIGV2YW5lc2Nhdml0DQoNCihUaGFua3MgZm9yIHRo
ZSB0cmFuc2xhdGlvbiBTaW1vbikNCg0K
