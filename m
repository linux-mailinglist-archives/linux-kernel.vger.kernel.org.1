Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC52C95CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgLADcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:32:07 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:22433
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727626AbgLADcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:32:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2P6PMm2TDzcUkPz7DhsaRti5/PLSZq75xJozossrG3nko0AjOXF8tq8Cf0fMdw08vTOCiz0YiDmY1Ac97D2g+/GjnXtqGiFNtLdVD3tvWG7rPOdQHvZz3YaaZ6ZfiUc1U8Z6WfVtoGsl720texbGCcEor58ayszzZuhBtwnbtv9FOxSrV+jYFn6GJvc5XFUZfQ6uWqMH25+ItdiYscxNsmwuATgDwYcK9DJ9fwyr7y6mWy32wX2HPDRmuFvA0CtVtAC6SWtCEJcNdiJQ2DWAbs5CfdVqVTdQn+hABOzeinpD6KmH+HuIul/5UP5Bd3b+DDgbpPvPVC2y3Os8pTDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwate6YYKWxzoGQC6P3SDt4SSCMQbMkp4PL2glfsyeY=;
 b=AYtLfGIa1YGFeTRBG9hOsIzMxw+DVkJppSOZXE+VLGtdWx1xH0BR7UYr2gCPdEKnJ90YyTj5hJdK10PkdEaPZxCEXtztak2Yz9aCMElDx6Lt/RqvUciXaAsJFvTPUgSDyDzqe5JqdjXyX+jZWEW4tJgScB4yyqYDAtRXMFe6rtQCXWBe2OYZ8P5CRj8ILi1Ux0tpb+hwG18AL5jTBx35YZsRXq28v31AVXhpZL2DTdTReeA7O/hBvNfTy9YcVxWVtCJ24Jun5U0Aimf7ebNys22Q/k6iDVqJqC1t8WEPHQdKHgVkByIbGk6FNJp5+SOQ1pcbWMp+Wlc2rX8LHEkS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwate6YYKWxzoGQC6P3SDt4SSCMQbMkp4PL2glfsyeY=;
 b=lAp8piISGuyXAceBI65n+6GeLMThxBO86mTmZITnSjJpCFkmBS1EScbQsZU0WJlw+HpOKmA/kEoilJ/DA9cBAf8SSfVgDu0rXOTzpKHeASn1ORT5i7MaMCXsv6lTVzweirrbrb9qGEI1hf5HUFwcKfEnSl73S8XvAXYlmpeGkIA=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR0402MB3752.eurprd04.prod.outlook.com (2603:10a6:209:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Tue, 1 Dec
 2020 03:31:16 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 03:31:16 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Topic: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Index: AQHWx5JthbwT/+cj4kS58mclaLP9Fg==
Date:   Tue, 1 Dec 2020 03:31:16 +0000
Message-ID: <AM6PR04MB60533A06C19AA37213C93F54E2F40@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201124015949.29262-1-alice.guo@nxp.com>
 <20201130215721.GA3090303@robh.at.kernel.org>
In-Reply-To: <20201130215721.GA3090303@robh.at.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83b78235-6b43-4ea6-ad2f-08d895a98fe1
x-ms-traffictypediagnostic: AM6PR0402MB3752:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB37528C4D78695EC3E0FCEE34A3F40@AM6PR0402MB3752.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCvzom6mFKQ7rLLRZSZ7pF7xf7YYvcSoIGnxk/Aebx3JRR+5M2t8KNg7DkhJrFH9DC2fzEqFS/dJUCSPbw52dvj/t8Y7+zmqDV0AnTvUMIy7PNZS0fVXnbaRFEsTnOE4YNvJH+wxkGwEYcxaKBWgbo/s4kT8K5NQFlw1FuwuMDTJ7Mo2esnkP1AwrJdffPWr8Xfm+G2ir5pT7rI6Q81fCY/nnhmJBwiTEZif/La6fM3HxRpLdF34HPJ0VrsmKw2Ox9LnOoFO1BVRv16eJ4SY1672WPerk/8AGSNYwjZf1la3B1sTlb9LOXHZz2ie/7kKkzE0KYaqOUyOSEJZbJOGtHT09zIoIExIdOEukPUX9hdQzVGQOrKA47dfsNJH4Nx1JZ7YddSoDJqciS+zPtyTNvtjiWGVV7NRrxbKlav1upsOIIiKxVfeiP/ocBF0nvYJ+vGUyQSE9jGwt/UcDRc56g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(396003)(376002)(346002)(2906002)(478600001)(7696005)(4326008)(9686003)(55016002)(71200400001)(966005)(54906003)(8676002)(86362001)(8936002)(6506007)(316002)(33656002)(110136005)(5660300002)(52536014)(66946007)(26005)(53546011)(186003)(64756008)(66556008)(66476007)(66446008)(76116006)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?cnBDMEpWSGhrN0F2VGYzaUtOZDhjSHlnbTVOc0xoK1ZNUDFoNS9nQmdRZlVB?=
 =?gb2312?B?M2tueW1iOE5zMFI0amp4YUVocG4wMkdvN0c3ZXZqSGY4N0NWK254ejdacC8r?=
 =?gb2312?B?N2lSSXNiWUlIak0vSUQwdTVyR2ZEUFZkZjdDV2Mzd3dxTkgyYmdLbkNMcm9L?=
 =?gb2312?B?MGNURTBzb2xPMzZZYkx1ZmJVZWFtOHQ1T2Yrd2cwNjNxSzdpWTM3Ykd3QTE0?=
 =?gb2312?B?VjFXQ1U4RnVpdnNvZFdkbEZiYU9MNEdVaWpHYmZJRHg2MFJXa3U4NmZsODll?=
 =?gb2312?B?blVpcjZXQ25LUVMwb3FLc2pHU0hiK2VnRHN4aXIzTWNrYmVkeDdKSUpHYWt3?=
 =?gb2312?B?RXdFY1p5T3lEa05ITlFCc3ZicEZ0bUpqZVNUcUlTa3JJcEhXSzljOGkxK3Rv?=
 =?gb2312?B?cHl0aC9yMDRSZDIxNnI0MzdLZDBraFhVemVMWlN3anFNMndNWEhma1o0OTJD?=
 =?gb2312?B?WEIvQUxZTHVBZnljV2xmTnJXWGh6dEtWV0JWWEhYMFp0RUNwZkdzS3BLaGo1?=
 =?gb2312?B?MWhVVTZUVDV2QTNGSHVXeitRYTZyRlVoeFlJQXpYekl5TWR4bGY3SHFUc3NP?=
 =?gb2312?B?VWxBY0x2VmJ4TW9Mb0lpcHRCOVgrQnNwRUlNeng3ck5PREZCMmxjczNtcVBl?=
 =?gb2312?B?cjhtb0lGMzduOWwwZzNOaXFORk1WU0pibUNqQW5xeVlSSmhnQUFGVHJWWDVX?=
 =?gb2312?B?aDFOM1BMd3NKcjBqM21WWm1QSGdyb0Q5RWJOd2Npdys0TjJOQUxlQTZCUE1O?=
 =?gb2312?B?RENhaXgvMmtzSmFKb1VjZmZ4KzJPMmpQSFIwWFI0cEZiTzZZYWFwMHE5Q01C?=
 =?gb2312?B?V0c4WElvcjJOUWZERVY3b2o1eUkzQUpZWG9ZVHdSUDNuRUl4QXBqZkk3N2pZ?=
 =?gb2312?B?T2FpbmUyZ0ZDZkFZTUV4T21SNUFXY3FDQWpvVUVWY3J5aTNyWGN1QVJ1K1lW?=
 =?gb2312?B?NEtQbGw3KzdaNmVFZnRORjNtTVQ0VzR1MkE0ZVFBbUpIOFRMaFBEMEExTmsv?=
 =?gb2312?B?VjM2TWMzSXBQb1Z3ZzdDVVVLSzZ6RTIvY1ZXZEprTkJSdEt0LzJHVUFQMDJC?=
 =?gb2312?B?ZlRURitySFhLNHNmNm1SdFNmOWV3R1JUMXBtYlBTclJ3c1F1ZTlKYVJxdEwy?=
 =?gb2312?B?MzRiZlI5eGpVRm0wRmdJOXhhNGpHY1cyNFpvRGgwZEo3RGNObkw5VkM5OVFW?=
 =?gb2312?B?YTJOTzhYajE3QWlpZmVwcGJLWldwN2k3clVjb2tkeWFlUjZ2OGUxai9MaU45?=
 =?gb2312?B?OE5Vd25qbmJ3WTNhNEZVQ0Z3ZUxETlJxYlgzdlR4ZHNKbm94VFg2N2hnVnJt?=
 =?gb2312?Q?bX7RaU8w59Vrk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b78235-6b43-4ea6-ad2f-08d895a98fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:31:16.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edrtqRhx6wX/l6HUa/0jgtwz1Ltjm0UZDHkXQFIT6ZBzVqozYpspByeCC78XTva/4Dbw4nvt+On0yIS5Y0psyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYXJtLWtlcm5l
bCA8bGludXgtYXJtLWtlcm5lbC1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uDQo+IEJl
aGFsZiBPZiBSb2IgSGVycmluZw0KPiBTZW50OiAyMDIwxOoxMtTCMcjVIDU6NTcNCj4gVG86IEFs
aWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrcnprQGtlcm5lbC5vcmc7DQo+IGRs
LWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NiAxLzRdIGR0LWJpbmRpbmdzOiBzb2M6IGlteDhtOiBhZGQgRFQgQmluZGluZyBkb2MgZm9y
IHNvYw0KPiB1bmlxdWUgSUQNCj4gDQo+IE9uIFR1ZSwgTm92IDI0LCAyMDIwIGF0IDA5OjU5OjQ2
QU0gKzA4MDAsIEFsaWNlIEd1byB3cm90ZToNCj4gPiBBZGQgRFQgQmluZGluZyBkb2MgZm9yIHRo
ZSBVbmlxdWUgSUQgb2YgaS5NWCA4TSBzZXJpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gdjI6IHJlbW92
ZSB0aGUgc3ViamVjdCBwcmVmaXggIkxGLTI1NzEtMSINCj4gPiB2MzogcHV0IGl0IGludG8gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiANCj4gTm8sIEkg
cHJlZmVyIHRoaXMgYmUgYSBzZXBhcmF0ZSBzY2hlbWEgZmlsZSBhbmQgbm90IGNsdXR0ZXIgYm9h
cmQvc29jIHNjaGVtYXMNCj4gd2l0aCBjaGlsZCBub2Rlcy4NCg0KSGksDQpUaGFuayB5b3UgZm9y
IHlvdXIgY29tbWVudHMuIEkgcmVhZCAiRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9hcm0scmVhbHZpZXcueWFtbCINCmluIHdoaWNoIHRoZXJlIGlzIGEgInNvYyIuIFNvIEkg
YWRkZWQgbXkgInNvYyIgdG8gdGhpcyBjdXJyZW50IGZpbGUuIENhbiBJIGtlZXAgaXQgaW4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbD8NCg0KPiA+ICAgICBt
b2RpZnkgdGhlIGRlc2NyaXB0aW9uIG9mIG52bWVtLWNlbGxzDQo+ID4gICAgIHVzZSAibWFrZSBB
UkNIPWFybTY0IGR0YnNfY2hlY2siIHRvIHRlc3QgaXQgYW5kIGZpeCBlcnJvcnMNCj4gPiB2NDog
dXNlIGFsbE9mIHRvIGxpbWl0IG5ldyB2ZXJzaW9uIERUUyBmaWxlcyBmb3IgaS5NWDhNIHRvIGlu
Y2x1ZGUNCj4gPiAgICAgImZzbCxpbXg4bW0vbi9wL3Etc29jIiwgbnZtZW0tY2VsbHMgYW5kIG52
bWVtLWNlbGxzLW5hbWVzDQo+ID4gdjU6IGNvcnJlY3QgdGhlIGVycm9yIG9mIHVzaW5nIGFsbE9m
DQo+ID4gdjY6IG5vbmUNCj4gPg0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNs
LnlhbWwgICAgICAgICAgfCA0Nw0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+IGluZGV4IDY3OTgwZGNlZjY2
ZC4uNzEzMmZmZDQxYWJiIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+ID4gQEAgLTkxOCw2ICs5MTgsNTMgQEAgcHJvcGVy
dGllczoNCj4gPiAgICAgICAgICAgICAgICAtIGZzbCxzMzJ2MjM0LWV2YiAgICAgICAgICAgIyBT
MzJWMjM0LUVWQjIgQ3VzdG9tZXINCj4gRXZhbHVhdGlvbiBCb2FyZA0KPiA+ICAgICAgICAgICAg
LSBjb25zdDogZnNsLHMzMnYyMzQNCj4gPg0KPiA+ICsgIHNvYzoNCj4gPiArICAgIHR5cGU6IG9i
amVjdA0KPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgY29tcGF0aWJsZToNCj4gPiAr
ICAgICAgICBvbmVPZjoNCj4gPiArICAgICAgICAgIC0gZGVzY3JpcHRpb246IG5ldyB2ZXJzaW9u
IGNvbXBhdGlibGUgZm9yIGkuTVg4TSBTb0NzDQo+ID4gKyAgICAgICAgICAgIGl0ZW1zOg0KPiA+
ICsgICAgICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAgICAgLSBmc2wsaW14
OG1tLXNvYw0KPiA+ICsgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW4tc29jDQo+ID4gKyAg
ICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtcC1zb2MNCj4gPiArICAgICAgICAgICAgICAgICAg
LSBmc2wsaW14OG1xLXNvYw0KPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMN
Cj4gPiArDQo+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBvbGQgdmVyc2lvbiBjb21wYXRp
YmxlIGZvciBpLk1YOE0gU29Dcw0KPiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAg
ICAgICAgICAtIGNvbnN0OiBzaW1wbGUtYnVzDQo+IA0KPiBGaXggeW91ciBkdHMgZmlsZXMgYW5k
IGRyb3AgdGhpcy4NCg0KTXkgY2hhbmdlcyBhcmUgYmVsb3cuDQoNCj4gDQo+ID4gKw0KPiA+ICth
bGxPZjoNCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAg
IGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAg
ZW51bToNCj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0NCj4gPiArICAgICAgICAgICAg
ICAtIGZzbCxpbXg4bW4NCj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg4bXANCj4gPiArICAg
ICAgICAgICAgICAtIGZzbCxpbXg4bXENCj4gPiArDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAg
ICBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiArICAgICAgICAiXnNvY0BbMC05YS1mXSskIjoNCj4g
DQo+IEFuZCB0aGlzIGlzIGp1c3Qgd3JvbmcuIEZpcnN0IHlvdSBzYXkgdGhlIG5vZGUgaXMgJ3Nv
YycgYW5kIHRoZW4gaGVyZSBpdCBoYXMgYSB1bml0DQo+IGFkZHJlc3MuDQoNCkhlcmUgYXJlIG15
IGNoYW5nZXMuIEkgZGVsZXRlZCB0aGUgc2VjdGlvbiBmcm9tICJzb2M6IiB0byAiLSBjb25zdDog
c2ltcGxlIGJ1cyIuIFBsZWFzZSBoZWxwIG1lIHRvIHNlZSBpZiB0aGV5IGFyZSBjb3JyZWN0IGFu
ZCB3b3JrYWJsZS4gVGhhbmsgeW91Lg0KYWxsT2Y6DQogIC0gaWY6DQogICAgICBwcm9wZXJ0aWVz
Og0KICAgICAgICBjb21wYXRpYmxlOg0KICAgICAgICAgIGNvbnRhaW5zOg0KICAgICAgICAgICAg
ZW51bToNCiAgICAgICAgICAgICAgLSBmc2wsaW14OG1tDQogICAgICAgICAgICAgIC0gZnNsLGlt
eDhtbg0KICAgICAgICAgICAgICAtIGZzbCxpbXg4bXANCiAgICAgICAgICAgICAgLSBmc2wsaW14
OG1xDQoNCiAgICB0aGVuOg0KICAgICAgcGF0dGVyblByb3BlcnRpZXM6DQogICAgICAgICJec29j
QFswLTlhLWZdKyQiOg0KICAgICAgICAgIHByb3BlcnRpZXM6DQogICAgICAgICAgICBjb21wYXRp
YmxlOg0KICAgICAgICAgICAgICBpdGVtczoNCiAgICAgICAgICAgICAgICAtIGVudW06DQogICAg
ICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbS1zb2MNCiAgICAgICAgICAgICAgICAgICAgLSBm
c2wsaW14OG1uLXNvYw0KICAgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bXAtc29jDQogICAg
ICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtcS1zb2MNCiAgICAgICAgICAgICAgICAtIGNvbnN0
OiBzaW1wbGUtYnVzDQoNCiAgICAgICAgICByZXF1aXJlZDoNCiAgICAgICAgICAgIC0gY29tcGF0
aWJsZQ0KICAgICAgICAgICAgLSBudm1lbS1jZWxscw0KICAgICAgICAgICAgLSBudm1lbS1jZWxs
LW5hbWVzDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0KDQoNCj4gDQo+ID4gKyAgICAgICAg
ICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAg
ICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgIC0gZnNsLGlteDhtbS1zb2MNCj4gPiArICAgICAgICAgICAgICAgICAgICAt
IGZzbCxpbXg4bW4tc29jDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1wLXNv
Yw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtcS1zb2MNCj4gPiArICAgICAg
ICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCj4gPiArDQo+ID4gKyAgICAgICAgICByZXF1
aXJlZDoNCj4gPiArICAgICAgICAgICAgLSBjb21wYXRpYmxlDQo+ID4gKyAgICAgICAgICAgIC0g
bnZtZW0tY2VsbHMNCj4gPiArICAgICAgICAgICAgLSBudm1lbS1jZWxsLW5hbWVzDQo+ID4gKw0K
PiA+ICBhZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0KPiA+DQo+ID4gIC4uLg0KPiA+IC0tDQo+
ID4gMi4xNy4xDQo+ID4NCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg==
