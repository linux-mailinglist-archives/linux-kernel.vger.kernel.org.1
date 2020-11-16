Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B252B3D93
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKPHQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:16:55 -0500
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:19370
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbgKPHQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:16:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTIr0q6ahPJDY6XeK3xciF7Hl/t7jyqIAJqhf0JztUmBM2lJa/BKcASN9adErbZ/c0cZJPtDJ9jxBFg1CAncdkNyNYeK6nNLIUN3Yd/+a+rY2fF/GnfROpgqD9AvWzC55vpRfSBFpfzBNo/tjJhZVj0FgloNkZ4TvzSCjtSiXd97uj7EJDO7PMJJOII2xp386iGnDszCOoRd/N0QcoXckZ/hMlji+MmWna7eYmEEkpjAiYVb+kUwos8/fREaDfGR4i1Ux4DTJmP6bJEr8E6sZBHPH/VIv5qEXbX9kF9giV53YOSiF1vJ/P+rXZDjwmVsKXteT/86EPGcQx3B/783Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MSdNiIsj6gbP6of/BVghaFIyMGETaTbtN2YMWJTR9I=;
 b=jpsZRP0TQgF7eQJhmRIrYlfeq523UVwyYP51f4HpU4rV9AhlWnjym7ERACQKzDe7pDAGYB6KQBSqusm4jsjXpVna6Drg9H9iKlh2OBqXY3JkBnWkMnnTMjw8vpjqPgsDUr2kdVCT222RPqpEa7yZFtt6efeky8d0yq8EIrLynJOoWu+G5Vk1p7EEN+lcwHjRT2FaoHEmSfy2W8jITRdgDk/9x06trLm2JOdXkF1RyfpTmbeyQcAMl/UEEBYNlpcLkyA8lxY955UInF6fhcW0vvGhjGqQSYTEUhQBWy9vuQuUVVZPyt42rhfSLtetDW55zZWMiEpAA9E/g3B9RvPurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MSdNiIsj6gbP6of/BVghaFIyMGETaTbtN2YMWJTR9I=;
 b=Tg2YD2is3C0JU6v9+Kmrp9kHhKRFopAj6FsGfA6oDTiDR5wqQ6F8MQJ/sVRWxCMCrNh/3Q8ulJJDyOVVjObLupSVBpqdhqubltbKE3yXNV9AnyhWg6Nsp1pIyVcqmvYKW/Z5cIRv1j72g9DoToYZJJsMcR5wVEtsL93Vb9N3t/w=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 07:16:50 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.026; Mon, 16 Nov 2020
 07:16:50 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 3/4] arm64: dts: imx8m: add nvmem-cell
 related stuff
Thread-Topic: [EXT] Re: [PATCH v3 3/4] arm64: dts: imx8m: add nvmem-cell
 related stuff
Thread-Index: AQHWuay/7VlOaPORo02HR6TiH8sucKnHy00AgAKR3SA=
Date:   Mon, 16 Nov 2020 07:16:49 +0000
Message-ID: <AM6PR04MB6053CEDF5DA36C02EF71D4D1E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-3-alice.guo@nxp.com> <20201114160052.GC14989@kozik-lap>
In-Reply-To: <20201114160052.GC14989@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 968bb133-82c9-48e7-c2d3-08d889ff9614
x-ms-traffictypediagnostic: AS8PR04MB8006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8006A5E7447F66D638203416E2E30@AS8PR04MB8006.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VFevx036iyxLoNXblMmyaR+mTIaBiPA8fg6l98u+gvGgIK8X927y+bTwKX9vAFQPKRt+bY/E+B6UuuIgi4MlYWLwqLcfyFeR+8BZ43hyCa0ehkCQaoSSlY7wdEMNDEvb97eSHLX6TZRchjExpngXc/F9vIYayKZZHqZgIK0Weo2NbCgfLPLF9CYMTr5gvZka8HYXdHkh3HUBjnzMGmnxhibiOwSI1M+LW+JrFMvJTaJage0wbSS8OqkWujgI3Hy4JH680a3hQ1jbdZeEVFnAYYODwhHPkZFwWdxmm7h7P0rIwqcCBn6lweRoUPF5VFV8rjhFrEJkIJaQ4YuSO60FuuA0VdD+Uqgc9tJAArKXasLEGEVRAeLk0Kwe02KzNlY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(26005)(76116006)(66946007)(6506007)(53546011)(186003)(55016002)(86362001)(66446008)(66476007)(66556008)(64756008)(7696005)(316002)(54906003)(44832011)(9686003)(33656002)(478600001)(52536014)(5660300002)(83380400001)(6916009)(71200400001)(4326008)(2906002)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dnDpjPNaRQqaRjs/930/zgTMd8z56fmEvYxooRU1+WQSNpmOaPyKQBe8Oo6D8c1T+N+UU6leSQ0/MxnRnKGOU7BULj2792epXqjZ9a8GcAxGwJk6qvDhd4avLGPl1NEJr5YSztsRBDwDi/8MIWqwS4lBTEZd9I9Z2huasbSRvE3H0JkBIQydNBD57dPgRe2KGBkpuKpweaLc0AN2dQwzA/fKseRK9fTPPmXbJU6GJ1Hya7GHoVlpTcjMYBuoXyGTdl9SIkaWp4cLJ5g9SRJzES8l/IRDiYzIat9pek8fKAghTysJJBFgMaausNYiT9nkgDn5ryxG858Lmk8PDdnWu44xJpA3QoV2BBNbqs/jeJbYOHyTtpwXGBwi47mujFFkpkc7euQ/kiTC8+PdIHhtQly3n2vWu9rJ+6QQkC/yDTUVtMudCI6LuPysRDqxKwH0gK/idm44362l6JaQ1dE5jVDivX2G2fjmXzRD0XrqaaxY7R0GYiHWwiyufkNHCVo6z4HF3sqMnyAecHocn4rT941+naHJpz88oqzAqGJIC31G9hAKkPt5jFuNW32Hkww/QUj95kcdVz61sAvnBf+qP/V8fml3iV3wFeFnS35Ax2SpmcIxipSylN+LMsFVk6EqLsQrTi2iPGKp5Grfe+mdLtWmC2mL2P1VBZV3jmflFdyP4cnEsoxoWa9c/3CfCfQ585OyxAAciiW7OS2b3FLO6GT9yb0k2waAAFhQLCkbyebg6yyHCeTOAc/+kPKagmMPyuTVaaPqpDX/cn0Cg5fyVWwyUD49ycQhF+dD+kiCd1cIlZ7lAYiHzYb6r/ZNoMG6QWhGOlJ3Gk+vF1ptva9e9F2YBqwwM2qAWlCKmjnhbHAM9at4JKCclBAaLguDz3en9U1EJxthiUbB3T91/4Z5Eg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968bb133-82c9-48e7-c2d3-08d889ff9614
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 07:16:49.9164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQczN/TDjb3J5/06DljirdAoajqUcxgwCFq8PckPulMtoqOjn/gCf5uj3LEkg+mfxnVElHjlVOqDsoCpM/X9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTHmnIgxNeaXpSAwOjAxDQo+
IFRvOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwu
b3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6
IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMy80XSBhcm02NDogZHRzOiBpbXg4bTogYWRkIG52bWVtLWNl
bGwgcmVsYXRlZA0KPiBzdHVmZg0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBG
cmksIE5vdiAxMywgMjAyMCBhdCAwNzowNDowOFBNICswODAwLCBBbGljZSBHdW8gd3JvdGU6DQo+
ID4gQWRkIG52bWVtLWNlbGwgcmVsYXRlZCBzdHVmZiBmb3IgdGhlIHNvYyB1bmlxdWUgSUQuDQo+
IA0KPiBEbyBub3Qgc2lsZW50bHkgaWdub3JlIGNvbW1lbnRzIGR1cmluZyByZXZpZXcuIExldCBt
ZSByZXBlYXQgbXkgY29tbWVudA0KPiBmcm9tIHYxOg0KPiANCj4gU3ViamVjdCBhbmQgY29tbWl0
IG1zZzogcGxlYXNlIGRvIG5vdCBhZGQgInN0dWZmIiBidXQgZGVzY3JpYmUgd2hhdCBhcmUgeW91
DQo+IGFkZGluZyBhbmQgd2h5ICh3aGF0IGlzIHRoZSBwdXJwb3NlLCBmZWF0dXJlLCBiZW5lZml0
KS4NCj4gIlN0dWZmIiBpcyB0b28gZ2VuZXJpYy4NCj4gDQo+IEkgY2FuIHJlcGhyYXNlIGl0LCBz
aW5jZSBtYXliZSBJIHdhcyBub3QgdW5kZXJzdG9vZC4gRG8gbm90IHVzZSB3b3JkcyBsaWtlDQo+
ICJzdHVmZiIgb3IgInRoaW5nIi4gSW5zdGVhZCBkZXNjcmliZSBleGFjdGx5IHdoYXQgeW91IGFy
ZSBhZGRpbmcgYW5kIGFuc3dlciB0bw0KPiB0aGUgbW9zdCBpbXBvcnRhbnQgcXVlc3Rpb246IHdo
eSBhcmUgeW91IGFkZGluZyBpdC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+
IA0KW0FsaWNlIEd1b10gSGksDQpJIHdpbGwgbW9kaWZ5IGFjY29yZGluZyB0byB5b3VyIGNvbW1l
bnQuDQpCZXN0IFJlZ2FyZHMsDQpBbGljZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCA2ICsrKysrKw0KPiA+IGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpIHwgNiArKysrKysNCj4gPiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaSB8IDYgKysrKysrDQo+ID4gYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgfCA2ICsrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKykNCg==
