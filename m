Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655BC294D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437419AbgJUNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:16:59 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:27877
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408965AbgJUNQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsLrENxOhOxdgBs4swpOUczxhmcZX53HV2HXq+7NdehyM2IyuiT/AbCyeA81R59gbyx9ZiDeBGc28Wes4rmlr60Zr01XRcINkAw/5F1qf8DWEiKzKelXlryvFqzyMwq5ZSeZhU1oOJnVGwgY06E0vHHa5yZ9PbNxx1n1pSh5/E3jt6AmuTG3Kl2yRmIXEgoLtithgWberA56E1DAcDCKPRZykc+Y6tLmfj2n13NhyFLsXlEl1KrasjSjZvZ1atBh9S5XyeuRnRwbXvIx1ivExZbWuNcy+yaI66Y3JP8cMrzwzwUFu1pgJLQPrV9PGdKd1Qjr4RVBNijkJBCowDPapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpxflisEqQMcqxtKTRFK+Ek7o12UFGQU2UrjBiRXWvE=;
 b=lQMU6JUx63UNtjrxzIG4PAbLrKhzcMM3pWu+Q+rw5Znpt5PWe7n4hvOt8rVQpHzKlUD1QQ+pLCUoAda83Qaihyc/mLUlnai5SYYaj9ELMOzDfEQvSTL2K4NtzZr62Epv+wiUZcScrtlRELd9nLn/C53M/gt+XxxpJkgmEu9IjYgwlCmQHcNV09mjSoyCIdHPlCkNAu2XAXxFSzxHV0Ri3I3Az4XxD8ml7rAzAxr7+HgoVbTYKhIp4bn0paDchgcClUk8NdGR/hCSyynPFAqHZwpuwonKI9NbbcWN+ELZtwZiRdh8i9WoflQeiMFoHnV80834s/FIk9qL+R89WYiHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpxflisEqQMcqxtKTRFK+Ek7o12UFGQU2UrjBiRXWvE=;
 b=bFlpW/EVQ/spwTHU5Nohdk6gJ2cj+bPKiwP/Zz5R7+mWVWoAq32jU2FywsdkWQgvDgxjAw6srs2BK9OcfJ18V0L1L1oigHCjiVkTJ7GxZRQciv4vwh+DWJsL7J+zWcDMvikTUXjkx5CtUOq3aor1dRe11je9uGt0Nz3Msqb970M=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.26; Wed, 21 Oct
 2020 13:16:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 13:16:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: defconfig: enable CONFIG_GPIO_MXC
Thread-Topic: [PATCH] arm64: defconfig: enable CONFIG_GPIO_MXC
Thread-Index: AQHWp3TUPFchaVuKy0e9Uvrmqtjbo6mh5usAgAAi3iA=
Date:   Wed, 21 Oct 2020 13:16:54 +0000
Message-ID: <DB6PR0402MB27608BD2A711D7A5748B826F881C0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1603262006-28217-1-git-send-email-peng.fan@nxp.com>
 <CAOMZO5DJ==aRqZAg8hmBZeBy3yeHKxTd08Vmym=meW31hqtWBg@mail.gmail.com>
In-Reply-To: <CAOMZO5DJ==aRqZAg8hmBZeBy3yeHKxTd08Vmym=meW31hqtWBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [114.217.181.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 527d83f0-f109-43b7-ceff-08d875c394f2
x-ms-traffictypediagnostic: DB7PR04MB5995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB59952BCA1A5E868BFC1B2A90881C0@DB7PR04MB5995.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KkoR/SXpmQAQsfjHPvAf7cBS1pLQzUV9Y26mQld5ml1k6Rigs/sT11m9NEYqj4IttLQNBksaaY49pPGcaNAKC9x3TY+HzI5R9+rsERS0IfhpYEoQH1LGpVqeX5jaVWNWRZnKKjJD3yexYpCF6H1DnUwezrdZiPhbX/1WF2UV0IAdkSGLfvKMSip/mNTGdmxZA0rdMVNIfIDtXdE2HvI5YSRCGmsrXsUusCrMrc06b3ahp5ZVMWwrDd/MPvdPm1366gja7l2Z79jisHKIr5dTrvd7P4O+xzuwL2JAsSeS+jcgb47Gh4/PhMLjiuP6nGcFnku69OvbrHjkpzAe2/L8QCxiRC0ACnjs26N62Vv4THfoMRI/Vgc5f/drwkQOoECyYIlVwq6Cd8MKX2mekq453w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(33656002)(5660300002)(66946007)(52536014)(6916009)(4326008)(478600001)(45080400002)(316002)(8676002)(66556008)(64756008)(66446008)(66476007)(86362001)(966005)(4744005)(6506007)(76116006)(2906002)(53546011)(44832011)(9686003)(55016002)(186003)(7696005)(26005)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bmSAtjmyepKg5/oOhUPKjznHg7ntyvWln7TpWUEKGnGjTOdOSUHvSHCaY7MGQ5edt7fY0ebeZVQ0AzVK/5eL1YKqklM6ge+l5hyGOsjacR3euLD2qiQkYQSQ2+OwHP2ItCEZLi0nTl8DoEZ8q+8tm2t3MMt2p7bW+vBChxOBYo4liAp0LlPxRGBUK7h5UwiLKz8s86menkafY1lPu0ONgtZlACOfn8+DFSrLfRSDfvoPyD/WIbiXMFZWclmyywAxlR68lW2NXc6+vpFbCM9NdKajYsxOApXEH/OgBWL565z3u8YnxOoxR33GC5AECQ0Wtf/NRnwGXTvs3R0OD9Sp/Akj21ReLBZNOhXL7EscOzqZyqsF/a1dGZUNiu5kN30AdidshS/8amX/PaIO3fuiEaTPgfY1kfE4KK0sYix6vvga+4XFk4HSMkURxdm2quGnSt8Zb594oEZjBOv0aSQ9GxG4H+ec/kRok1vhzOw1yTDAE4RleORzVOsnl7eA/+Q6M2UEsfHqdsR3Ell80CX75WIvXK/iCutqzo36oGKyKbaHzjrEQbB8vnopPma5WUg47rvxN5TY1foe4F6MPULkBQWsAMX6zWgIhiR3iAeiae8vSfmTlGWWueVc4LQV1cL4dnh/VSCc7CscdP0c3dUcKg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527d83f0-f109-43b7-ceff-08d875c394f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 13:16:54.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmrPmQxdTB3Ql9K4DQNjDiQOmOlcM1XUYogNKOshiESklr4UCJ9Q49Df+uKrnARUfibVA5BQpQN64fgIBp+8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBhcm02NDogZGVmY29uZmlnOiBlbmFibGUgQ09ORklHX0dQ
SU9fTVhDDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gV2VkLCBPY3QgMjEsIDIwMjAgYXQgMzoz
OCBBTSA8cGVuZy5mYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRvIGkuTVg4TVAsIGFsd2F5cyBtZXQgIldhaXRp
bmcgZm9yIHJvb3QgZGV2aWNlIC9kZXYvbW1jYmxrMXAyLi4uIiwgaXQNCj4gPiBpcyBiZWNhdXNl
IHRoZSBncGlvIGRyaXZlciBub3QgZW5hYmxlZC4gU28gZW5hYmxlIENPTkZJR19HUElPX01YQyB0
bw0KPiA+IG1ha2Ugc3VyZSBpdCBjb3VsZCBib290IHdlbGwuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IEFuc29uIGhhcyBhbHJlYWR5
IHN1Ym1pdHRlZCB0aGlzIGNoYW5nZToNCg0KVGhhbmtzIGZvciB0aGUgaW5mby4gTm90IHNhdyB0
aGUgcGF0Y2ggaW4gbmV4dCB0cmVlLiBTbyBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guDQoNClRo
YW5rcywNClBlbmcuDQoNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Y2gNCj4gd29yay5vemxhYnMub3JnJTJGcHJv
amVjdCUyRmxpbnV4LWdwaW8lMkZwYXRjaCUyRjE2MDAzMjA4MjktMTQ1My0yLWdpDQo+IHQtc2Vu
ZC1lbWFpbC1BbnNvbi5IdWFuZyU0MG54cC5jb20lMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q3Blbmcu
ZmENCj4gbiU0MG54cC5jb20lN0MyNzRhZDk5ZTNhN2Y0ZGQwOGVhZjA4ZDg3NWIyMTNmZSU3QzY4
NmVhMWQzYmMyYjQNCj4gYzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3Mzg4NzU0OTg4
Mjc1ODg4JTdDVW5rbm93biUNCj4gN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhVw0KPiB3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZh
bXA7c2RhdGE9RmZrSUx2N3lDU0Jta3o5bTFUN1hGTDR0N2NHYkkNCj4gVks2QkRXallzdFBaVUEl
M0QmYW1wO3Jlc2VydmVkPTANCg==
