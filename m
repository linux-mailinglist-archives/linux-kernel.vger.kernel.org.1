Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50ABF2D38D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLICbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:31:15 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:30727
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgLICbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:31:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9ovcqAHYEI0+CN6MAZMrufj8kQeTkLIpmBL52dT9LBiDVs1R3+3W4TLvAi7hCydA0LJpyh9j1JOdb+KHHq6UI85uH1FbHihROG8GgRfRwoPITwWOyA+jBpyS5bdN+kNDKtDvmw49ik3Pt+tNA59PKSIqurptFy8fWymXPrWA/8qmOAv7lLea7CCkuJCHIYaq5WK6SyPO+reU2GUMlsjX+V2NLbi8ekKOOQ8KKwXkxLjapq1i6Bh7FjYZmASG+YpEabS/qdtNwazFaxLR9b96QJgkP4HUCzXteUhsPkHJPnIp8qg5yI+nX9Adl7F0Ile8SWazB+Ic7RMHnDN0Zb+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWbbEjfKskQu3A8AC1rB2wDCF6zvHZqaJfxAGiLuvbs=;
 b=cp32AkLI199+dcv2mIpqvwUyNEWUcGnDoMrbJLut66h7LByzRloBxiTOaE5piJONwr+sr2dJmLxJ90toUA41PZYpjGiQXSLXr1wId5xT+uiyvwcM0gtA4Rv+mcXY78qDX4dh/tSQP4orMM+gQrjNOloyqlB8SIcFqZIVJDlFOFCzzMIqFJ+kKXwn5I0Xgu5Db2LarlrwuoS3if/N9ZkgMRkIJRsm3yqI1zk/zQoS8BgmMVQDN0rkrsAQ8M40DUlJhUJ3naUmZB1c0R7lf1GieMBFFY0PjR1LN+Ptevav7eZaaLHHtP5tDHlRJgMw29fTQenb8gWBXysU3Cj0PUJwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWbbEjfKskQu3A8AC1rB2wDCF6zvHZqaJfxAGiLuvbs=;
 b=Rsr4CWsXKO9hzjB8cqQvTlVqdBLi0MSuZF3fIOSNu4ZTvwduOkE8Y2j90MQGq03nWU1ogkDjFZLl+lN+NwbTyRwaOcYvKslyQQUMdyIkFEwC/6t6FvZ9uqJhriO09wsaiLS8WgqVBkffE02ONgtp7TnwrWXg3Nyj8jJBkdBeFGw=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM5PR0402MB2756.eurprd04.prod.outlook.com (2603:10a6:203:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 02:30:23 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 02:30:22 +0000
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
Thread-Index: AQHWx5JthbwT/+cj4kS58mclaLP9FqnuF1QQ
Date:   Wed, 9 Dec 2020 02:30:22 +0000
Message-ID: <AM6PR04MB6053C8339E1894687C911E72E2CC0@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201124015949.29262-1-alice.guo@nxp.com>
 <20201130215721.GA3090303@robh.at.kernel.org>
 <AM6PR04MB60533A06C19AA37213C93F54E2F40@AM6PR04MB6053.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB60533A06C19AA37213C93F54E2F40@AM6PR04MB6053.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: f47eff7a-e568-4518-8db8-08d89bea6146
x-ms-traffictypediagnostic: AM5PR0402MB2756:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR0402MB275685F13576B74ED23306CEA3CC0@AM5PR0402MB2756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGWiHbgn/aNSuFWfKZ5aQMj7/+zJH2sczTct3uiNLLHv6rKm2wgt1WBw7LAk5xBC1vcqaIGUbT05qbcHJOIrSUeutlhgQ1Fh/YlJ2cHXYnb+FrBtoCTYuuNiF4AFCENwTCglJZW4hqcJkcA4jJlLYDQuGfjWiQJUwMwVCMYLiM4WcX4uGBD5i1KbGXfpPt4Rw7QwTvoJsr8BdX+zkJP9XeaSIC2u3gZfhrOSUmvXjtuJkrFQOff2V+RN2oXEas9gLcKcTWFpmgg7r3yvMKlhG/2hUKySqb64XAHl6PZirt7seXMHdHteUCeA4UHnFvsWivJTpK/q/JIN7mdRuxfPHx617NyCnkkvcBj5hg7Oq5hImMoMFa+/P8EgUYvgzl5yf0LUAE6v+S0RbjTjwnStJbzqQ9TUDPmL5J9cPNFg0bheoMQAEmTBE6PoFRZakjdcH3ZNCGFBWnq51b0ix7vG/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(66446008)(7696005)(9686003)(53546011)(186003)(64756008)(26005)(66556008)(66946007)(8936002)(66476007)(2906002)(86362001)(83380400001)(54906003)(966005)(52536014)(8676002)(4326008)(110136005)(508600001)(33656002)(71200400001)(55016002)(76116006)(5660300002)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?UFhOZ0lzYVBEdHNnSEgwNk84ZUNQL3dWZVhjaVNxT2RVYTFBdWZTNXgrL01R?=
 =?gb2312?B?VDB5K1lTZ1lROU9adFVWQjBrMUUxL0hacTg2QUMzdU5ZQXNIK3R1TFhCNkNo?=
 =?gb2312?B?d1h3Q0ozQVRuZStCeWM4dTM2U3NVVnlLR0NWRUxBZGYrSU4rSUhyY3djSXRS?=
 =?gb2312?B?eWtqcjQxbWdhaVhMUHhHNWVWR3RyMFJpT2d1OG5UK2YrdEdBUkxNQnpVb0h0?=
 =?gb2312?B?YmtCVHpoSTF6SC9uVTJOeGZxdTJXRGdSRlQ0cTlieUZHTG5JWlBBMXovODZG?=
 =?gb2312?B?UlNkOHVWazVGQ21pbUpYNUxvUm0xTk8rS1ZQdFNKK1pKQUhwM3djZDU4YVYr?=
 =?gb2312?B?UnMyVk1iWU0rNVhKakFHKzhqV0hPVTBQeHlUOUlvSHl0b1ZZM3hXQnJHcjlP?=
 =?gb2312?B?UytMcHFwOVZyK2ZnZUZSZU5acUlaR2hzd3E1S2RLQ0JPTXpscDRhL0xjOUx5?=
 =?gb2312?B?T3AxbkcxdDNZS3R5am9ZVEVoNGYvYUUyK1hFMlJpaTFtVEpvY2U2OG9RMEQy?=
 =?gb2312?B?OFN5SVZjWVd1VUgyYnY0TEh0cmwzTjhpWllzN1RzOU4xc3ZiejNhRDM3bmpr?=
 =?gb2312?B?VGMxcXlZcHQ5ako3aEk5Yy9XUXVIS0lTa3VEc0VDR2h4MXh6T2JYeXR2cmIx?=
 =?gb2312?B?aVg4TnUwcjJkTHVJSzNieEdvbXJaVFJXaHZtWnV3TVdBVlkzZTEyd0tRU0ll?=
 =?gb2312?B?SWpZZTFwLzNVcktOeEltWVBLd3lCc0RiM1RaZ0Nyay9KYUNxZ3dDY1ptU2Fj?=
 =?gb2312?B?eXpDMzlhUnp2ZG1OVmR3dlBRMWdYVzNKZ2NUT0VtVHZMLzk4eXpJMkw3MFpp?=
 =?gb2312?B?RVI1em1SdEQ5N3RhY1RuelJaa1VCUXZ1ZjFWNVdsNjFBclhLR3U0Ykw5c3RZ?=
 =?gb2312?B?OGMvVVJmN2lFSFh2aVNrc1dNS0NUUFgyUFlReWhYV1lUZUp2cUFTQVlpK2x2?=
 =?gb2312?B?SWF5TWl2dHVoTzk5RGxSOUtlaVVRMlNmN2dSMjRKaXlpSTlCMElxZFRrZDVk?=
 =?gb2312?B?N0JydnByVEVPWjliWFhLQlJmUzlRc1hCdHY0VUVxY3VPVEY1TkEwTEdqR0Vo?=
 =?gb2312?B?Zm9hd2ZoK0xQQVRmaC9rbFBPQTRXVkttdHg0NksvRWZKem1FTHV1U2JkWWFz?=
 =?gb2312?B?Q0lneGtERHk3Mkcwam5td2poczl4TGZJbUN4N1MwclBVTkczRVFJVHJpVWkr?=
 =?gb2312?B?SngxdEVDcWJiaThvQzBoMkxnYUFvT1ZidlI3bXZlRDR2ZXk5Ym1yUFlYMnJu?=
 =?gb2312?B?TGFRM2dMV2tseUlpQnlPTHY3ZkZzSVl0UXE5SDZwa0VmQVovZUorbmxJQVFC?=
 =?gb2312?Q?TNeBQ/UtuBIf4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47eff7a-e568-4518-8db8-08d89bea6146
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 02:30:22.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nos6uu1NsJs1uZ4pj4wW3+BtRqvmdmVOAKyVNKCeZshp8hvXVMnWnFODP25HpaBNbxXhk9gb7zNkwCyGzX0tKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2756
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLiAgYW5kIEtyenlzenRvZiBLb3psb3dza2ksIGRvIHlvdSBhZ3JlZT8NCg0K
QmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogbGludXgtYXJtLWtlcm5lbCA8bGludXgtYXJtLWtlcm5lbC1ib3VuY2VzQGxpc3Rz
LmluZnJhZGVhZC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBBbGljZSBHdW8gKE9TUykNCj4gU2VudDog
MjAyMMTqMTLUwjHI1SAxMTozMQ0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47DQo+IHNoYXduZ3VvQGtlcm5l
bC5vcmcNCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT47DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGtyemtAa2VybmVsLm9yZzsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIHY2IDEvNF0gZHQtYmluZGluZ3M6IHNvYzogaW14OG06IGFkZCBEVCBCaW5k
aW5nIGRvYyBmb3Igc29jDQo+IHVuaXF1ZSBJRA0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogbGludXgtYXJtLWtlcm5lbCA8bGludXgtYXJtLWtl
cm5lbC1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+ID4gT24gQmVoYWxmIE9mIFJvYiBI
ZXJyaW5nDQo+ID4gU2VudDogMjAyMMTqMTLUwjHI1SA1OjU3DQo+ID4gVG86IEFsaWNlIEd1byA8
YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47DQo+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga3J6a0BrZXJuZWwub3JnOw0KPiA+IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgMS80XSBkdC1iaW5kaW5nczogc29jOiBpbXg4bTogYWRkIERUIEJpbmRpbmcNCj4gPiBk
b2MgZm9yIHNvYyB1bmlxdWUgSUQNCj4gPg0KPiA+IE9uIFR1ZSwgTm92IDI0LCAyMDIwIGF0IDA5
OjU5OjQ2QU0gKzA4MDAsIEFsaWNlIEd1byB3cm90ZToNCj4gPiA+IEFkZCBEVCBCaW5kaW5nIGRv
YyBmb3IgdGhlIFVuaXF1ZSBJRCBvZiBpLk1YIDhNIHNlcmllcy4NCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4g
Pg0KPiA+ID4gdjI6IHJlbW92ZSB0aGUgc3ViamVjdCBwcmVmaXggIkxGLTI1NzEtMSINCj4gPiA+
IHYzOiBwdXQgaXQgaW50byBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zz
bC55YW1sDQo+ID4NCj4gPiBObywgSSBwcmVmZXIgdGhpcyBiZSBhIHNlcGFyYXRlIHNjaGVtYSBm
aWxlIGFuZCBub3QgY2x1dHRlciBib2FyZC9zb2MNCj4gPiBzY2hlbWFzIHdpdGggY2hpbGQgbm9k
ZXMuDQo+IA0KPiBIaSwNCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLiBJIHJlYWQNCj4g
IkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXJtLHJlYWx2aWV3LnlhbWwi
DQo+IGluIHdoaWNoIHRoZXJlIGlzIGEgInNvYyIuIFNvIEkgYWRkZWQgbXkgInNvYyIgdG8gdGhp
cyBjdXJyZW50IGZpbGUuIENhbiBJIGtlZXAgaXQgaW4NCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbD8NCj4gDQo+ID4gPiAgICAgbW9kaWZ5IHRoZSBkZXNj
cmlwdGlvbiBvZiBudm1lbS1jZWxscw0KPiA+ID4gICAgIHVzZSAibWFrZSBBUkNIPWFybTY0IGR0
YnNfY2hlY2siIHRvIHRlc3QgaXQgYW5kIGZpeCBlcnJvcnMNCj4gPiA+IHY0OiB1c2UgYWxsT2Yg
dG8gbGltaXQgbmV3IHZlcnNpb24gRFRTIGZpbGVzIGZvciBpLk1YOE0gdG8gaW5jbHVkZQ0KPiA+
ID4gICAgICJmc2wsaW14OG1tL24vcC9xLXNvYyIsIG52bWVtLWNlbGxzIGFuZCBudm1lbS1jZWxs
cy1uYW1lcw0KPiA+ID4gdjU6IGNvcnJlY3QgdGhlIGVycm9yIG9mIHVzaW5nIGFsbE9mDQo+ID4g
PiB2Njogbm9uZQ0KPiA+ID4NCj4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNs
LnlhbWwgICAgICAgICAgfCA0Nw0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+ID4gPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiA+IGluZGV4
IDY3OTgwZGNlZjY2ZC4uNzEzMmZmZDQxYWJiIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+ID4gQEAgLTkxOCw2
ICs5MTgsNTMgQEAgcHJvcGVydGllczoNCj4gPiA+ICAgICAgICAgICAgICAgIC0gZnNsLHMzMnYy
MzQtZXZiICAgICAgICAgICAjIFMzMlYyMzQtRVZCMiBDdXN0b21lcg0KPiA+IEV2YWx1YXRpb24g
Qm9hcmQNCj4gPiA+ICAgICAgICAgICAgLSBjb25zdDogZnNsLHMzMnYyMzQNCj4gPiA+DQo+ID4g
PiArICBzb2M6DQo+ID4gPiArICAgIHR5cGU6IG9iamVjdA0KPiA+ID4gKyAgICBwcm9wZXJ0aWVz
Og0KPiA+ID4gKyAgICAgIGNvbXBhdGlibGU6DQo+ID4gPiArICAgICAgICBvbmVPZjoNCj4gPiA+
ICsgICAgICAgICAgLSBkZXNjcmlwdGlvbjogbmV3IHZlcnNpb24gY29tcGF0aWJsZSBmb3IgaS5N
WDhNIFNvQ3MNCj4gPiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiA+ICsgICAgICAgICAgICAg
IC0gZW51bToNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tc29jDQo+ID4g
PiArICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1uLXNvYw0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgIC0gZnNsLGlteDhtcC1zb2MNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAtIGZzbCxp
bXg4bXEtc29jDQo+ID4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiBzaW1wbGUtYnVzDQo+ID4g
PiArDQo+ID4gPiArICAgICAgICAgIC0gZGVzY3JpcHRpb246IG9sZCB2ZXJzaW9uIGNvbXBhdGli
bGUgZm9yIGkuTVg4TSBTb0NzDQo+ID4gPiArICAgICAgICAgICAgaXRlbXM6DQo+ID4gPiArICAg
ICAgICAgICAgICAtIGNvbnN0OiBzaW1wbGUtYnVzDQo+ID4NCj4gPiBGaXggeW91ciBkdHMgZmls
ZXMgYW5kIGRyb3AgdGhpcy4NCj4gDQo+IE15IGNoYW5nZXMgYXJlIGJlbG93Lg0KPiANCj4gPg0K
PiA+ID4gKw0KPiA+ID4gK2FsbE9mOg0KPiA+ID4gKyAgLSBpZjoNCj4gPiA+ICsgICAgICBwcm9w
ZXJ0aWVzOg0KPiA+ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiA+ICsgICAgICAgICAgY29u
dGFpbnM6DQo+ID4gPiArICAgICAgICAgICAgZW51bToNCj4gPiA+ICsgICAgICAgICAgICAgIC0g
ZnNsLGlteDhtbQ0KPiA+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OG1uDQo+ID4gPiArICAg
ICAgICAgICAgICAtIGZzbCxpbXg4bXANCj4gPiA+ICsgICAgICAgICAgICAgIC0gZnNsLGlteDht
cQ0KPiA+ID4gKw0KPiA+ID4gKyAgICB0aGVuOg0KPiA+ID4gKyAgICAgIHBhdHRlcm5Qcm9wZXJ0
aWVzOg0KPiA+ID4gKyAgICAgICAgIl5zb2NAWzAtOWEtZl0rJCI6DQo+ID4NCj4gPiBBbmQgdGhp
cyBpcyBqdXN0IHdyb25nLiBGaXJzdCB5b3Ugc2F5IHRoZSBub2RlIGlzICdzb2MnIGFuZCB0aGVu
IGhlcmUNCj4gPiBpdCBoYXMgYSB1bml0IGFkZHJlc3MuDQo+IA0KPiBIZXJlIGFyZSBteSBjaGFu
Z2VzLiBJIGRlbGV0ZWQgdGhlIHNlY3Rpb24gZnJvbSAic29jOiIgdG8gIi0gY29uc3Q6IHNpbXBs
ZSBidXMiLg0KPiBQbGVhc2UgaGVscCBtZSB0byBzZWUgaWYgdGhleSBhcmUgY29ycmVjdCBhbmQg
d29ya2FibGUuIFRoYW5rIHlvdS4NCj4gYWxsT2Y6DQo+ICAgLSBpZjoNCj4gICAgICAgcHJvcGVy
dGllczoNCj4gICAgICAgICBjb21wYXRpYmxlOg0KPiAgICAgICAgICAgY29udGFpbnM6DQo+ICAg
ICAgICAgICAgIGVudW06DQo+ICAgICAgICAgICAgICAgLSBmc2wsaW14OG1tDQo+ICAgICAgICAg
ICAgICAgLSBmc2wsaW14OG1uDQo+ICAgICAgICAgICAgICAgLSBmc2wsaW14OG1wDQo+ICAgICAg
ICAgICAgICAgLSBmc2wsaW14OG1xDQo+IA0KPiAgICAgdGhlbjoNCj4gICAgICAgcGF0dGVyblBy
b3BlcnRpZXM6DQo+ICAgICAgICAgIl5zb2NAWzAtOWEtZl0rJCI6DQo+ICAgICAgICAgICBwcm9w
ZXJ0aWVzOg0KPiAgICAgICAgICAgICBjb21wYXRpYmxlOg0KPiAgICAgICAgICAgICAgIGl0ZW1z
Og0KPiAgICAgICAgICAgICAgICAgLSBlbnVtOg0KPiAgICAgICAgICAgICAgICAgICAgIC0gZnNs
LGlteDhtbS1zb2MNCj4gICAgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW4tc29jDQo+ICAg
ICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1wLXNvYw0KPiAgICAgICAgICAgICAgICAgICAg
IC0gZnNsLGlteDhtcS1zb2MNCj4gICAgICAgICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMN
Cj4gDQo+ICAgICAgICAgICByZXF1aXJlZDoNCj4gICAgICAgICAgICAgLSBjb21wYXRpYmxlDQo+
ICAgICAgICAgICAgIC0gbnZtZW0tY2VsbHMNCj4gICAgICAgICAgICAgLSBudm1lbS1jZWxsLW5h
bWVzDQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IEFsaWNlIEd1bw0KPiANCj4gDQo+ID4NCj4gPiA+
ICsgICAgICAgICAgcHJvcGVydGllczoNCj4gPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlOg0K
PiA+ID4gKyAgICAgICAgICAgICAgaXRlbXM6DQo+ID4gPiArICAgICAgICAgICAgICAgIC0gZW51
bToNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbS1zb2MNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbi1zb2MNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgIC0gZnNsLGlteDhtcC1zb2MNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIC0gZnNs
LGlteDhtcS1zb2MNCj4gPiA+ICsgICAgICAgICAgICAgICAgLSBjb25zdDogc2ltcGxlLWJ1cw0K
PiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICByZXF1aXJlZDoNCj4gPiA+ICsgICAgICAgICAgICAt
IGNvbXBhdGlibGUNCj4gPiA+ICsgICAgICAgICAgICAtIG52bWVtLWNlbGxzDQo+ID4gPiArICAg
ICAgICAgICAgLSBudm1lbS1jZWxsLW5hbWVzDQo+ID4gPiArDQo+ID4gPiAgYWRkaXRpb25hbFBy
b3BlcnRpZXM6IHRydWUNCj4gPiA+DQo+ID4gPiAgLi4uDQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4x
DQo+ID4gPg0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQo=
