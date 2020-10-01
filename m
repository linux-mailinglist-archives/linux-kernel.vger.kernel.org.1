Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8100C27FA13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgJAHTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:19:18 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:45266 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601536757; x=1633072757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FTvQXOEm+3en4rfo4hjRt/QTRhkkLLW/SsfIK6VzuKw=;
  b=LzFXR4lxJjgtcs0JtWgIQyjFujXRAzorSLRBPlzr3UytNI4Hs6/oTWf+
   j6S7pT5wKF+ApZCdcJUnlPmGBFP0mQXKqwxVzqIqtwB6ekLEXUg6mds5k
   O9qUv5ChGpmLqvOBBMleslesF6JysAT0oBPKu354ctr17WOGZpHvJSz7D
   O+f2+oSzDvTZod45+h+/aCKogdr+OZrWOBF/yyJa/PbQaqCO4ynPL4QjW
   n4Dt3FggQ4UPYScexR9LULsxOj5VtFWAd4NioIyutR4ziurHsvLhsOlfX
   WtY/QRbLmNTvUSlik+59xQQ/Ei1EZ8/NmJtxskqGvXY46RZkeBzF7Vw/X
   g==;
IronPort-SDR: 4pRCL+p++3+x5YPbPOOvvk5LhOxZWGZgGJVY74WC5KEG7e4N77xuBRmskcSge7BEvQ/nkwbXk0
 LKCqm7qqW8ujQyMj5fA84K5g5gQ0deXeSJl5YgcCJAgnYsNmaTWHSiUS8aGFyBGkKaoRWeQCvh
 bFJB4zWyf/nnZCyZUjgAQF0nx7RCK/QqtnrjOJe45B4plAkNPv9dBzEVGCFibM9VUDRmVEKT42
 sp3oE2EPNHdE0vVYE573cEpY/10igVgK0oA+y0GlWXdeX1Buk8awo4t2vxxP/b9PSEFpeH7fmS
 kBQ=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="97872166"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 00:19:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 00:18:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 00:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4OP8Zs80uH1tXM0MJ0NFXIZFvISWcoG6GgAGMIR25F8Qb6KWk9blwzF0Nj/3iCJNeoBx8WNGNlWAwFGlxdtwv7EXPaFtkbOAg9sh5E7Ramng/KZKdagZZ90JdG7LLl1tsAWyXQlYarBkeylcsvo0iJN5+QDJPFn/sIOk3J5ORt9YmuV74bPZQPeLAk/CyK2j1ON71Bff15KbdPLJkxHuIxKsSwPISiCeKg2YbrSnz/+Gd4cdbXyvyjNnx8Lj5i4ulevKuBGZ6X8h8DuIYT7CmcKiGwS+AKVQ/nu64GjxtyO5BA9M/ROB2iv+Pq9dopgmCT9FFwlRuu/DJjW31iarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTvQXOEm+3en4rfo4hjRt/QTRhkkLLW/SsfIK6VzuKw=;
 b=CkX5A1mPHoQtscjnXMtxkh8Dx/qvfC2A7UEE3YeR40DzEITMoC/zj13GqWJjkSep+eHEp6NgVQwzdPYoouZOcv7Ov4Cp65ALBA4uBf+9NUtxx5J/YfW5z3/Y0lMHv7Vs3oJUPyG+25ufZ0htf28+Suu/Ff8FX94bYOkk3VymFlUCkpDPrJseVCyocdRuSQEz3a7tV7mT8alOt1NXN/cQxk9VQ/Pn9sL97KhqB2KmIovm2cNrsLQO2PHKQUka8i14GhhKDQEn1vVoT3gxoJbjqkgoIp50hoOOdgtK2CI6VtC4QRuaMi99GJnI0tBFUSA18L6CQ5n6yo7uHOrnohqB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTvQXOEm+3en4rfo4hjRt/QTRhkkLLW/SsfIK6VzuKw=;
 b=iywb+YE6ymDQ8Qw9OIKbyM+/8zzNHFSSoACoGSTRZ4W3PioWfx6BqCTljU/uvRELVkvDkOGMMPxTMXT8j4QHg+IvCQv/fFYHMtcgxFcokeueEgv+tvPk5bjbyod0LufvDlHmyD2AzU8qz6LE+FbaZhu4GpkwQ7isX02X2DAEQNk=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4442.namprd11.prod.outlook.com (2603:10b6:5:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Thu, 1 Oct
 2020 07:19:14 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 07:19:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Thread-Topic: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Thread-Index: AQHWl8Mq03c/QD6Sr0Oo7ADJT92UwQ==
Date:   Thu, 1 Oct 2020 07:19:14 +0000
Message-ID: <5340adf5-1bb2-1eff-3812-6976b3b76faf@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-2-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-2-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd5a05d1-85fc-4587-f578-08d865da4d5c
x-ms-traffictypediagnostic: DM6PR11MB4442:
x-microsoft-antispam-prvs: <DM6PR11MB4442ADEBA83E7FB02CD214F6F0300@DM6PR11MB4442.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J14ADsPLw4MG0awKNGyyyvQJ1/81sta+QBsW0dBp42y0VesSu57ZTlnKNWrsYxVPjvOEYIg7Vx/qX06K38OnLlTqo0rj4JQ9I7z9rZ8CYPNMBDNORVsUCFTU+p8vy4GRHHnlAJWxIqokRDO5ZqoI5Bl3JOs9Od0gWqMapFnKOImJ4BbyktrLN/1P2WzkJGYMBBOwcPZAE42t49gs2sJXJ4zuyNbj6MCTbL4hQVwm7O1lhoXRJpkmg7mEbgint5q/IRhwjPxLTJKfp0hCifuHJRDOz39ADFLM5sxxU7+s+04DR5n55kN+dbnHyD6ge9ELl51cyz7N5oOsm3rDyKWBSbq5XOZmf4bi5YihxBQ/RjeNGesJ2GZ5kXoUQ4W9+c3CcW2O1JTN48g4pFGGn3BN4ZCwmuEc7WEDC31mlQHpOX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(136003)(39860400002)(316002)(110136005)(6486002)(6512007)(5660300002)(4326008)(54906003)(66946007)(31696002)(64756008)(66476007)(36756003)(53546011)(2906002)(26005)(186003)(6506007)(66446008)(66556008)(83380400001)(71200400001)(8676002)(86362001)(2616005)(91956017)(76116006)(31686004)(478600001)(8936002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0HTquFx2ZlIReQucKU7aS/xTMsNVEe0rmkJpsNGj6L0Rqic3qBEz/kvFxETx81wGgcjP0ZmVUWb7E0FZP3H90/N8PESCCmZbCHxc81fdTJvP3D9xk/LNn8BZgZDuUbGRO/w+9ASETpdpZnsny2/+ARflv4gFCL7uQ+CpUfYtErW/yMrEAfll8pKTOQ0nwPv45dfoOsP0leHILmaZFtRU6pVZbWB+UcH0o79rulqiubBZVH5O93cJdnCQ9GCEgYHi46FFjZpu+KYYXBkQV03vCh2E2EoyDsJ+uGdvuWes4YzttEndMv1TvX9ewX5lIb8CYrUZdLwub1Z/v4pMxMqkZsuhV1+vd6u0C6FUbSFAxhHQNGDL7OPNyI/PjfC60ADA1cKx2OapDEDD5Bjzziig8nY4ANLglHzKdxtu+CvX2bhO031fat1n2GMFz5oA7WY9UivRomr/A1fY2b4PKJ+EPqechJ8IFGnqGwLzBTXguYGiy9aQP53HtPg4/KUsHfDl5O6ff1WfHiQfld9dpGmJ1XKj04a4/55ThFnTgOOO+DZjxNH7idxyyhHMBsWHodzH89nzYJMCxuJyveTMzYHm5i1zAYCeN628Cfxlv4jADeKARphPowQx2Sr7FeGpgLahy0pa6l8QRZpr4uw1Eeh84A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF0EE0281105BF429AA789F26EB482DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a05d1-85fc-4587-f578-08d865da4d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 07:19:14.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRpCb9O5K2uF2v4LJmabL2VAqUb0FYGEdDtJV/twh2BVHQVntu6wi6GH1zO8d0/TJ7FuMhl/9v485i6hUalHD16ZWq9dGzoEEiDP8FaX2yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4442
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJv
ciBjb2RlLiBVc2luZyBFT1BOT1RTVVBQIGlzIHByZWZlcnJlZA0KPiBpbiBpdHMgc3RlYWQuDQo+
IA0KPiBSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPg0KDQpUaGUgUi1iIHRhZyBzaG91bGQgYmUgYWZ0ZXIgeW91ciBTLW8tYi4gVGhpcyBhcHBs
aWVzIHRvIG90aGVyDQpwYXRjaGVzIGluIHRoZSBzZXJpZXMgdG9vLiBObyBuZWVkIHRvIHJlc3Vi
bWl0LCBpdCBjYW4gYmUgZml4ZWQgd2hlbg0KYXBwbHlpbmcuDQoNCj4gU2lnbmVkLW9mZi1ieTog
UHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jIHwgMTAgKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4IDAzNjlk
OThiMmQxMi4uNGQwZjhkMTY1NTQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMjI4MSw3
ICsyMjgxLDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2h3Y2Fwc19wcDJjbWQodTMyIGh3Y2FwcykN
Cj4gICAqQG5vcjogICAgICAgIHBvaW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InDQo+ICAgKkBv
cDogICAgICAgICBwb2ludGVyIHRvIG9wIHRlbXBsYXRlIHRvIGJlIGNoZWNrZWQNCj4gICAqDQo+
IC0gKiBSZXR1cm5zIDAgaWYgb3BlcmF0aW9uIGlzIHN1cHBvcnRlZCwgLUVOT1RTVVBQIG90aGVy
d2lzZS4NCj4gKyAqIFJldHVybnMgMCBpZiBvcGVyYXRpb24gaXMgc3VwcG9ydGVkLCAtRU9QTk9U
U1VQUCBvdGhlcndpc2UuDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgc3BpX25vcl9zcGltZW1fY2hl
Y2tfb3Aoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+IEBAIC0yMjk1LDEyICsyMjk1LDEyIEBA
IHN0YXRpYyBpbnQgc3BpX25vcl9zcGltZW1fY2hlY2tfb3Aoc3RydWN0IHNwaV9ub3IgKm5vciwN
Cj4gICAgICAgICBvcC0+YWRkci5uYnl0ZXMgPSA0Ow0KPiAgICAgICAgIGlmICghc3BpX21lbV9z
dXBwb3J0c19vcChub3ItPnNwaW1lbSwgb3ApKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAobm9y
LT5tdGQuc2l6ZSA+IFNaXzE2TSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9UU1VQUDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiANCj4gICAgICAgICAgICAgICAgIC8qIElmIGZsYXNoIHNpemUgPD0gMTZNQiwgMyBhZGRyZXNz
IGJ5dGVzIGFyZSBzdWZmaWNpZW50ICovDQo+ICAgICAgICAgICAgICAgICBvcC0+YWRkci5uYnl0
ZXMgPSAzOw0KPiAgICAgICAgICAgICAgICAgaWYgKCFzcGlfbWVtX3N1cHBvcnRzX29wKG5vci0+
c3BpbWVtLCBvcCkpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFNVUFA7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gICAgICAg
ICB9DQo+IA0KPiAgICAgICAgIHJldHVybiAwOw0KPiBAQCAtMjMxMiw3ICsyMzEyLDcgQEAgc3Rh
dGljIGludCBzcGlfbm9yX3NwaW1lbV9jaGVja19vcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAg
ICpAbm9yOiAgICAgICAgIHBvaW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InDQo+ICAgKkByZWFk
OiAgICAgICAgcG9pbnRlciB0byBvcCB0ZW1wbGF0ZSB0byBiZSBjaGVja2VkDQo+ICAgKg0KPiAt
ICogUmV0dXJucyAwIGlmIG9wZXJhdGlvbiBpcyBzdXBwb3J0ZWQsIC1FTk9UU1VQUCBvdGhlcndp
c2UuDQo+ICsgKiBSZXR1cm5zIDAgaWYgb3BlcmF0aW9uIGlzIHN1cHBvcnRlZCwgLUVPUE5PVFNV
UFAgb3RoZXJ3aXNlLg0KPiAgICovDQo+ICBzdGF0aWMgaW50IHNwaV9ub3Jfc3BpbWVtX2NoZWNr
X3JlYWRvcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9yZWFkX2NvbW1hbmQgKnJlYWQpDQo+
IEBAIC0yMzM4LDcgKzIzMzgsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3Jfc3BpbWVtX2NoZWNrX3Jl
YWRvcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgICpAbm9yOiAgICAgICAgIHBvaW50ZXIgdG8g
YSAnc3RydWN0IHNwaV9ub3InDQo+ICAgKkBwcDogICAgICAgICAgcG9pbnRlciB0byBvcCB0ZW1w
bGF0ZSB0byBiZSBjaGVja2VkDQo+ICAgKg0KPiAtICogUmV0dXJucyAwIGlmIG9wZXJhdGlvbiBp
cyBzdXBwb3J0ZWQsIC1FTk9UU1VQUCBvdGhlcndpc2UuDQo+ICsgKiBSZXR1cm5zIDAgaWYgb3Bl
cmF0aW9uIGlzIHN1cHBvcnRlZCwgLUVPUE5PVFNVUFAgb3RoZXJ3aXNlLg0KPiAgICovDQo+ICBz
dGF0aWMgaW50IHNwaV9ub3Jfc3BpbWVtX2NoZWNrX3BwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNwaV9ub3Jf
cHBfY29tbWFuZCAqcHApDQo+IC0tDQo+IDIuMjguMA0KPiANCg0K
