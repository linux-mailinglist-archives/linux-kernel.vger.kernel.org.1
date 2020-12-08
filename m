Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD622D274A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgLHJQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:16:59 -0500
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:21889
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728561AbgLHJQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:16:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdi0bzguffoHZgo8zmuJM3tIRhPCkmNV1m/6PWVCfkqdSUkw1ffWOLZcWGLYRA5QYBbH0vRD3z3yEQ8ohxyghBOY0SgbIQlTqCEQpPzjY8Cu3OYAQEjVVY1wx5JB2yAvagKLs/gdeJTy5F0XlLYHfEAr4QHWlfbbhzqkRPrWp7gqfxy+ykxiEH5noK6kqJjhVY21UndTsDR1dNTrDt4VNuBB0PoVe2xwGjLIftm1h9Q6bv3MSJzpAE6UkYDu2m6pmGCK3McnI58Y30/NQWN/KVeepct/A5w1g+jAJ+hy1XfJQjkYMxLyW2knDpu0Q10PqTE3OjCyJ0RtPfX0VA7VGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEz4c2PVfVonJPQiiiZbuGi/XPNtiNgN/UqcRnf2uFY=;
 b=Nsgu3O9pKhaidSS0HWk+9uqtFFaC2/bvHG/b0AOnyLFSaH8TGZ3IMzWkM2/0YIr830i8dkYAwM6eIsl9h6mHZqS47kdV4hQbmRFGDef//ZY7oOcPTWb2u4SzFJ9emniOrbkh1lKiJ1kR5UuF3+34Hyq5FKczP5moGOutq89sSQyJoT0eUSmaH3BWDsHB+m2YKfko7lqQ4kfW+O7BWYWUEriojW1ToMZxjDLrslL2vqXd1kBqJbUw8v9JfEyGNvE2Ow1W48Yc9fGVLflcNKL5fM1//y4Ma/R5unN7mXmwcTkZTFvRygr6FySp7XrmJkxxG263VilMktn4xeaJcXJOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEz4c2PVfVonJPQiiiZbuGi/XPNtiNgN/UqcRnf2uFY=;
 b=MnbfNERst88gSChKNFUdr/KtOnuToSDHLCVQvcLQII+EQcUh3wHELCSJZnK3L3T4tdWKg8lIXxWIjv2awfCeyJV3j49ySPyjkH9qwKxz+VvoOYH4Nqb+kGioGJV+13wNioWtcD3yudBpQ59VmyaP80Ap+jSWMWv9EO803d17DSY=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB5994.eurprd04.prod.outlook.com (2603:10a6:10:89::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 09:16:27 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 09:16:27 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pawel Laszczak <pawell@cadence.com>,
        "Quadros, Roger" <rogerq@ti.com>
Subject: RE: [RESEND PATCH] MAINTAINERS: Add myself as a reviewer for CADENCE
 USB3 DRD IP DRIVER
Thread-Topic: [RESEND PATCH] MAINTAINERS: Add myself as a reviewer for CADENCE
 USB3 DRD IP DRIVER
Thread-Index: AQHWzSB5UEXXVw1O80mIpR9L7fDTQansp0QAgABD9wA=
Date:   Tue, 8 Dec 2020 09:16:27 +0000
Message-ID: <DBBPR04MB79792ED4EC4CAB9B5FBF275A8BCD0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201208050806.15382-1-a-govindraju@ti.com>
 <80b6d061-2d35-c8e9-81ed-8fd67445410c@ti.com>
In-Reply-To: <80b6d061-2d35-c8e9-81ed-8fd67445410c@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1857437f-862d-460b-cf08-08d89b59f131
x-ms-traffictypediagnostic: DB7PR04MB5994:
x-microsoft-antispam-prvs: <DB7PR04MB59949A30CC73F86706E7CEC28BCD0@DB7PR04MB5994.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRV3TMsRQvUfyNxfS6kPYfD/7lm226bnuRc34bSKzc8yIy4gn8idHmXfM9e93kPd4eKLFXFGckl7nZBbcOiFGRj4e3bsWiHH9prbE9K9o+P28xY9p7bIB0l7Nto+ims6hGAYqEaLLdE6ZQ1X9gOvlvxOaJ49JQ14pecqhDKrdxcN7As+zEZB45FTtmedVKJxorV/J5hqiS5mpBnz5SX13lgEaVj8cYdmesdk3be4ikbdwvL+VYtynNpWYEDgEWu4uy6IazQoybJVoc32Vq1EPYk5G2yerCJFFBlCKDx7EpOSb1JP3Bav2kUKT73VkN0d0lcieUyfhXLSeI0AcVHxTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(508600001)(71200400001)(7696005)(86362001)(8936002)(44832011)(8676002)(26005)(66556008)(66946007)(66476007)(66446008)(76116006)(2906002)(5660300002)(52536014)(54906003)(110136005)(6506007)(9686003)(55016002)(64756008)(53546011)(186003)(33656002)(4744005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qk54TjVrVHU4TlRNWm5TSWs5TXVqMklobVZMZUZKQStlQWhZQUI4OExwWVRN?=
 =?utf-8?B?d3Vad2lvbUYvQnRxTkptdVE2b1Zqbm1EY2psMUZ3YnFpYmlPZnZtcjhlOUpv?=
 =?utf-8?B?RGdjME1MZUZHK0N1T2VwV1hWUk5WMzZkVVBndXp0NjgyckNuRERDWExyTmc1?=
 =?utf-8?B?L3AwVEdmM3ZBYWVTWGgya3hzdGxweEVKL0V2RDl6K2IydTdXVERCTlhEalhq?=
 =?utf-8?B?RG1hTDRVZ0JSYjZBdHVFcjhka093My9ibWs4L3ZSVnFyUThIYmt6aFFsY1lE?=
 =?utf-8?B?R1JPOXZoODVUVmxVb0NacFpaeVlrbTBxeFBLeHNIejNjZXBlSFdVYytMWURS?=
 =?utf-8?B?MFJremE2SnltVzhibm0wdngwOXNWeExIcFNtMTdMSHdBZWNIR1dYM2I0KzJk?=
 =?utf-8?B?UmxsQlpyNkcvOG1QTVFyWWFVMEVJTU1WZGYxdjVWdUhMZHlGQ3ppQ3lWN2s1?=
 =?utf-8?B?MlROV3NURGRHbWlZdTJmV3dscExoV2Q5b0N5OGUxQzhvNUViNm1Lc1RheUJF?=
 =?utf-8?B?L2RKOXQ3eTJWTTlGcDFnVUJyRy9Hc3RDSUN5Wmx6ZmpKU0tETXJWYlVRMENh?=
 =?utf-8?B?S1A4RDUvemhIZldYMEdZT2U3QmpNRVJyMTQyQi9SbmtoaENDb2lQYWNta0Vm?=
 =?utf-8?B?cWdXRGJ2ZU4yMEFBYUhQUEtpTkU1VlF6OGNVZ0hGRkJKSUdBVnV3L1JjQzlT?=
 =?utf-8?B?R2ZJT0VNaURHa2lBZmtPcEZvS1FDbWlNLzlGUGdUYU5xTUxCV1VBSmZ6U0k5?=
 =?utf-8?B?TzRMS3AvZHR4OW1nMHU5cjhqMzAxTndkOUFMRk02T2dHZ1BCMDJZSThlSDJO?=
 =?utf-8?B?ekpkRmZNMTkwOEc5WDJIQVQ1UGtYdFFuQ1BDNW95ODVTWjZHLzRHWmxkOGJI?=
 =?utf-8?B?U0MvZkVyZWNsRGR3Snl3RGJocEdKTHRVVUNrRjhmcUdYQ0RuNnBHOGRWWkxX?=
 =?utf-8?B?NHZTczJRZlk5UlBLOWxvN0w1WWpqQ1Y4d2tRVHBwM1QyUytLMFl6ZGhKT1R1?=
 =?utf-8?B?ZnlhTUNJOFFjaW9oc1VFRG5WaGc4Ym1VdFMwMUo3ZVpFSUdxSm45cHFnZGtG?=
 =?utf-8?B?c0x3SXVObHlmTnhYUFFpVG9QZTdzcUZUWlFndEVhcURmWnlLRDR2OG9ydzBn?=
 =?utf-8?B?RHRvUjJBdEdKM1B1cnVsZGFubHpsVUxWaFVtbDlrajJ5cFJTZStYdUhrSUgr?=
 =?utf-8?B?RktVSGZuem1MVG5MeGtKZkxtWGFqM0ZBc0R0TnQzSXJZbnVoWHc3R09rRjMz?=
 =?utf-8?B?WlIwR2xzVEp4eWdpQWl5OGRPTTJ0K2VscXZBd0kwRUJJNzVFR2Y4R0ZlWFVt?=
 =?utf-8?Q?0WASztaQPHZgI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1857437f-862d-460b-cf08-08d89b59f131
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 09:16:27.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6fwCDhh7Cfpe4hK5Sn/BcgXp0MWRBga/vZy1UwD6a6r9NM5oTPzJ3I4M+3yDKPn4esPhrwmgujSbD/06kadEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5994
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiArIFBldGVyLCBQYXdlbCBhbmQgUm9nZXIgZm9yIHRoZWlyIGFja3MuDQoNCkFwcGxpZWQs
IHRoYW5rcy4NCg0KUGV0ZXINCj4gDQo+IE9uIDA4LzEyLzIwIDEwOjM4IEFNLCBBc3dhdGggR292
aW5kcmFqdSB3cm90ZToNCj4gPiBJIHdvdWxkIGxpa2UgdG8gaGVscCBpbiByZXZpZXdpbmcgQ0FE
RU5DRSBVU0IzIERSRCBJUCBEUklWRVIgcGF0Y2hlcw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QXN3YXRoIEdvdmluZHJhanUgPGEtZ292aW5kcmFqdUB0aS5jb20+DQo+ID4gLS0tDQo+ID4NCj4g
PiBSZXNlbmRpbmcgdGhlIHBhdGNoIHRvIGFkZCBtb3JlIHZpZXdlcnMuDQo+ID4NCj4gPiAgTUFJ
TlRBSU5FUlMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleA0KPiA+IDZh
YWMwZjg0NWYzNC4uZmY5YmQ3ZDE4ZDk0IDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+
ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtMzg2MSw2ICszODYxLDcgQEAgQ0FERU5DRSBV
U0IzIERSRCBJUCBEUklWRVINCj4gPiAgTToJUGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29t
Pg0KPiA+ICBNOglQYXdlbCBMYXN6Y3phayA8cGF3ZWxsQGNhZGVuY2UuY29tPg0KPiA+ICBNOglS
b2dlciBRdWFkcm9zIDxyb2dlcnFAdGkuY29tPg0KPiA+ICtSOglBc3dhdGggR292aW5kcmFqdSA8
YS1nb3ZpbmRyYWp1QHRpLmNvbT4NCj4gPiAgTDoJbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0K
PiA+ICBTOglNYWludGFpbmVkDQo+ID4gIFQ6CWdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvcGV0ZXIuY2hlbi91c2IuZ2l0DQo+ID4gLS0NCj4gPiAyLjE3
LjENCj4gPg0KDQo=
