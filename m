Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFC2C8435
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgK3MiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:38:13 -0500
Received: from mail-am6eur05on2116.outbound.protection.outlook.com ([40.107.22.116]:36961
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbgK3MiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:38:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZlO5W2gCEYwRiPoN+2zmEw6tOkirfZvPRFGsXeXZWWefPCSiPaowukTOHq2J3dGECGLy1NHkXhYa42RJeg4YHLg2iKFti7eBgstksFz5vD7A11WrOn48XnTvX/tvvVOsfVZFlyos+OH1vEFyy9XHQW99kfkFkPPpEf7T/qihjZ8WxWlR24I+wE6VZXQAdmraXYTf0TfSnsW9Z15G0I0lbvQ6BPRzDVdWc/dO6m2/IxzSboDvHLDxBnrFTWV46T/LMWKbj3+TUiBoFf5/AK6M6pXwsy2OLORYP4wutwBCvsr5lLLq/nIqUu717L38789BhBvIVoILzRhbxdcaOrRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENauT4lrIblSMvLdW8G2XjxqEilnFzIHE3gGagfSYxw=;
 b=QwSu0/hJ7NmpjgNkVDWMm3Th0xthhSONkD+/p5w/5DNGVv6hLAqJycewLDJIqNrrEqfT5peICpDV/B9IpvRxEvzlVGMoKU81b2ehaWmE5Ik5MD1bqqbjGF+h+9KDkqewd3TKzZNREuRP+cojkEGgpYBETuvApuRYrdd4nyEXYul5eRh0lcjaFIa5eLfiigl5fP1V9gxLbdkHG0fGrnrlVxIWHwZA5sH/kpn9aVOuz3sImdRRLqGQRobv3Rqoo+FgBqznABDJ+IfzbfiUstQ1cQ0q+qsOq3vSEc+2Zg2eCTIADmXt2ufNuImsQVaR+tdwHWuq+GAwYDCjxttFgnGlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENauT4lrIblSMvLdW8G2XjxqEilnFzIHE3gGagfSYxw=;
 b=I0IG1schPsk8CnUlvkyfsgKcp/GT14UmdvIBo6Z7XMAoRHxHYTyZJQ87hrVWUFjXNI25lTHKPrXUnD0EbsBNlcNDYTk7aV8QWfwIrxcQrxMAlyu2sW2JbYjHLvsAOkv/qJxlyfaGGloYNF90b0dyxGp0/gxTE+rbc7oxR2Jhqoo=
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com (2603:10a6:20b:37::25)
 by AM6PR0602MB3701.eurprd06.prod.outlook.com (2603:10a6:209:1d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 12:37:23 +0000
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::b073:9747:410c:12c6]) by AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::b073:9747:410c:12c6%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 12:37:23 +0000
From:   ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 2/2] ARM: multi_v7_defconfig: drop unused POWER_AVS option
Thread-Topic: [PATCH 2/2] ARM: multi_v7_defconfig: drop unused POWER_AVS
 option
Thread-Index: AQHWxwvRwTWzvnw3x0+tW66xX+DegqngmOuAgAADAzA=
Date:   Mon, 30 Nov 2020 12:37:23 +0000
Message-ID: <AM6PR06MB469188E766DAA99591B14280A6F50@AM6PR06MB4691.eurprd06.prod.outlook.com>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
 <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
 <20201130122245.GB22590@pi3>
In-Reply-To: <20201130122245.GB22590@pi3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=leica-geosystems.com;
x-originating-ip: [193.8.40.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 776ad4df-c689-40a0-fc1f-08d8952caffd
x-ms-traffictypediagnostic: AM6PR0602MB3701:
x-microsoft-antispam-prvs: <AM6PR0602MB370158556D54E0D568490FCBA6F50@AM6PR0602MB3701.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p1LlVmv9EFJOp4+b/rE8/Gg+s96uAjsbw7Mrtu1HCTTVBIbRwkeYmg5HLj5TjhxufScuUzDhzIFXazVdJmufaGvfObBOtNZNuJVmNx8vBczqgZsqnj/tVhc0+QpuVu+8YRIC1BqPsoA3ggT1iA6gp1xLBaATqMnldhm7bGh3nVvOqGzdaJyp4bc/KAeRxaddl/BxUuKM68JkFmNtQYEp1X0t+HDIwbHmUYvKRbPNVyO0qnfSuBXmAZNBZUbW/ZFyAas4v/0+f6CYp8R9p1zACA8XK961bpXw6/CBOJ+m3e79rc/DeSYxzCPHm/TwJjSS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4691.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(76116006)(66446008)(316002)(66476007)(2906002)(33656002)(66556008)(64756008)(66946007)(5660300002)(6506007)(71200400001)(26005)(54906003)(53546011)(7416002)(52536014)(55016002)(478600001)(86362001)(45080400002)(6916009)(7696005)(9686003)(8936002)(4326008)(83380400001)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M1VHWk1mdmovVnFrekdrM21ZYTJ2Wkp2OEdONlJzNmt6aWdtbjBwTmh5dXFa?=
 =?utf-8?B?UDV1ekxoRktlOFdPSnFpTDd3UC9TUHBlQk9TSlZEcWNzM1c4d0hnZFMveDFD?=
 =?utf-8?B?S2F6a0tCUHlGbHBEdkFxTDU0Y1Rvd0wweTQvbEVRTHphMisrN3YwS1QvLy90?=
 =?utf-8?B?ZGVjMkpGTlkrZzRxaHB4NW9qcmp3ek94RmY3WVFsc0NRLzRSbk10WXBlUFVs?=
 =?utf-8?B?dUx3aTNMUXBwVUdTbnRueFpYTUlldDF1T3dpTWFtaW5TOWhvc2h4bE0vL2VW?=
 =?utf-8?B?SFJ6aUJpMndEVVg5MXZteVFyZ2xUNjlNQlY2VmxQdVA0SkZLOFloUXdxVDRv?=
 =?utf-8?B?eFl6dWhZdEpNOG80R09nMjJiNXU2M2hqRENjbFIxM0QyMHpmQTEyS1hmc2Zu?=
 =?utf-8?B?MGhoVkRNWjZLUGp3SCsrQkpXdFcxT1FHdm5aSU9BbWUwWTNSanRyZmtIZWNK?=
 =?utf-8?B?a3lQSEtHcjFyQVhTL2tDWVREQkFLYURCbzhpa2NNa3gwR2xJWmdiN1JpMnlm?=
 =?utf-8?B?Szk1UW1xN3JIays2Mmt2S0NWTGE5MHUxR1hhTTJYZk9tVHlScG10UXMzNlJJ?=
 =?utf-8?B?S0Z0dU1zK1VUeDZyWEJ6aHphcFI5T0IwQlA3ZzB0L1EyckVlWmxGaUZlMGV3?=
 =?utf-8?B?eHVldTBUM0hZcG1hK0RqeTVSZ1lkbEd4bnAvanJ0STIvaDlsRjY4OHRvTDkz?=
 =?utf-8?B?a2ZZUzMwdWtoeTBEVE1XRDZra1V1cW5Ed01ZM1hJNUtNbnk0MTd0VVhYRU9z?=
 =?utf-8?B?SzBqbng3Z3VKZ0RvRWFXVk53NjY1QWo4Y0pUcUtDVHhhNjNkUmFNMGtZMWZy?=
 =?utf-8?B?MWNwNjZ1NGFNQm10YVA0blNPa3lDWmJpbnRDZmdnOFVZZFdab2dNc3Q2YU5D?=
 =?utf-8?B?SG9vYTk5WVR2ak1KeHgvQjJaL25RV0x4cU5OQzV2Z2dKZE5QVW9YOVhKRmg5?=
 =?utf-8?B?SGhkQXpmM1JtdEhqdDFPeUtoL0dZTFFkTDMwRWhyY2N1dnk5MXNQdE1BT25C?=
 =?utf-8?B?MlpxOXhvd1RaNWZHRG1xcHBFaEM4RXR1c1JMNzJRNDJWeHNwSWpxd1RDUkwz?=
 =?utf-8?B?ZktrUk9wQnhyVTJMb1pzOGNIRkUza0R4cGxuR3cySGM4dE55UkZYNW1BMFBl?=
 =?utf-8?B?c3EvYTVtblVEdk5BL21CMkpFc3NVQmV2dUcwZW9DYmZXWUx1Sng2Rk9CbTRQ?=
 =?utf-8?B?ek5OYXpZa1hodGVLaGx3bFg0ZjY2N0pkNW8wVVlVYko3eVJEekc2ekJ2aU44?=
 =?utf-8?B?OE1zRjhjd3U3QlZTTWpzTFhZU2RqQnhsekVlU1FhT3pDOVdWQ2FKRHE2NVZB?=
 =?utf-8?Q?74Um3T9CKKwYc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4691.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776ad4df-c689-40a0-fc1f-08d8952caffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 12:37:23.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 042EHSIgoEjd8Dlu8tjCI0Ecrvms+lTIG3Z0RTKtAig/lz61WK+RLEwA7dcbNJ2uyBjK4mlQ9eCUqtnWvoNNXoVSyOJGEAyDHMV3SgEfelfV6tMO5UFYqmeVEuth06Zq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3701
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBO
b3ZlbWJlciAzMCwgMjAyMCAxOjIzIFBNDQo+IFRvOiBaSElaSElLSU4gQW5kcmV5IDxhbmRyZXku
emhpemhpa2luQGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPiBDYzogY2F0YWxpbi5tYXJpbmFzQGFy
bS5jb207IHdpbGxAa2VybmVsLm9yZzsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7DQo+IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IGxlb3lhbmcubGlAbnhwLmNvbTsgdmtvdWxAa2VybmVsLm9yZzsN
Cj4gZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU7IEFuc29uLkh1YW5nQG54cC5jb207IG1pY2hhZWxA
d2FsbGUuY2M7DQo+IG9sb2ZAbGl4b20ubmV0OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBOaXNoYW50aCBNZW5v
biA8bm1AdGkuY29tPjsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBBUk06IG11bHRpX3Y3X2RlZmNvbmZpZzogZHJvcCB1
bnVzZWQNCj4gUE9XRVJfQVZTIG9wdGlvbg0KPiANCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBI
ZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZQ0K
PiBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhp
cyBlbWFpbC4NCj4gDQo+IA0KPiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAxMToyNzozMUFNICsw
MDAwLCBBbmRyZXkgWmhpemhpa2luIHdyb3RlOg0KPiA+IENvbW1pdCA3ODViNWJiNDFiMGEgKCJQ
TTogQVZTOiBEcm9wIHRoZSBhdnMgZGlyZWN0b3J5IGFuZCB0aGUNCj4gPiBjb3JyZXNwb25kaW5n
IEtjb25maWciKSBtb3ZlZCBBVlMgY29kZSB0byBTT0Mtc3BlY2lmaWMgZm9sZGVycywgYW5kDQo+
ID4gcmVtb3ZlZCBjb3JyZXNwb25kaW5nIEtjb25maWcgZnJvbSBkcml2ZXJzL3Bvd2VyLCBsZWF2
aW5nIG9yaWdpbmFsDQo+ID4gUE9XRVJfQVZTIGNvbmZpZyBvcHRpb24gZW5hYmxlZCBpbiBtdWx0
aV92N19kZWZjb25maWcgZmlsZS4NCj4gPg0KPiA+IFJlbW92ZSB0aGUgb3B0aW9uLCB3aGljaCBo
YXMgbm8gcmVmZXJlbmNlcyBpbiB0aGUgdHJlZSBhbnltb3JlLg0KPiA+DQo+ID4gRml4ZXM6IDc4
NWI1YmI0MWIwYSAoIlBNOiBBVlM6IERyb3AgdGhlIGF2cyBkaXJlY3RvcnkgYW5kIHRoZQ0KPiA+
IGNvcnJlc3BvbmRpbmcgS2NvbmZpZyIpDQo+ID4gQ2M6IE5pc2hhbnRoIE1lbm9uIDxubUB0aS5j
b20+DQo+ID4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFuZHJleSBaaGl6aGlraW4NCj4gPiA8YW5kcmV5LnpoaXpoaWtpbkBsZWlj
YS1nZW9zeXN0ZW1zLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLiBZb3Ugc2hvdWxk
IGFsc28gcmVtb3ZlIGl0IGZyb20gdGhlIG9tYXAycGx1cyBjb25maWcuDQoNClRydWUsIGp1c3Qg
cmVhbGl6ZWQgdGhpcyBjb25maWcgb3B0aW9uIGlzIHByZXNlbnQgaW4gYXJjaC9hcm0vY29uZmln
cy9vbWFwMnBsdXNfZGVmY29uZmlnLiBUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LCB3b3Vs
ZCBzdWJtaXQgYSBzZXBhcmF0ZSBwYXRjaCB0byB0YWtlIGNhcmUgb2YgaXQgbm93Lg0KDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpSZWdhcmRzLA0KQW5kcmV5DQo=
