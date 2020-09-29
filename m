Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC55A27CAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgI2MVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:21:33 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:11518 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgI2LfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:35:25 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 07:35:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601379324; x=1632915324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FFTSLuhmFvpQuYs6UlCDy77D/Y6zKTqphrofGrE53CQ=;
  b=gp5axFftXnhzER2HH4cjZPGxA+slxVX9h8ZQjEVA6KuT+58zV57pgbPe
   SC1owcKPFyeQwf1OZ+SNRMyUGdrEbhSiPJwGsEcm980AimGR+poUBWOfV
   s4jOjtaNWsKNsaUhOrUWFe7owrD3aixfZLtlHw2MonmOg0cV0o3NkzoUv
   SID8+oBBy9uFgE1DOROmdQENAsgSe9/ds7j3ULj16ILrBq279vQyLswwq
   w5TuGt1ZCfOTY5OONFCTFWrfJZe7dKIdZFGRgwddYWVzvM/W4mKy0AqsT
   EBLAL+6s6mD7SRePyLh5CWiSKkuA8LROAGbSlxjC+zQmyaFy8GDgKeXbZ
   A==;
IronPort-SDR: TdPzTCeSGanF/gZzft2eIpss/k9uVzETofAIHPWWz2LCC1QY9urvPdQHZDE0euXriVymJOwVrD
 yq6O+Ylk3slSSMDEao8UhC/K82BVyr/UCiunK/ynFdHVQykCZjctDuJszXMerhEw4bLj5fDp2K
 4YTBt3w+R4CnVEpKlLfMNQmkVvMYrhzDj6oR73ublJF4DF7S2+JvGNYo7i+tHYwe71CVgZ9pmB
 jcXBFpPL8R+UqlUY7JG2idt9t8pxnMA6lYt/s2otTfo53NeYjYXaSP9/7aI50Mpfh43gjmQ3s/
 Hqk=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="90788854"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 04:26:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 04:26:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 29 Sep 2020 04:26:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIgSYfBTA+B1nIC+UMzZL6mMr5QPpEM2VPbuLBWSJYP7VffGQGPsv8FbPofVPmyFkCgu8CxcI4o33MH36xT8P8ga2Bh6pWsYyzH6BSkF8QikLhNXK3HNbiAQE70y1CRhYBreZFq35Hkc/EWxgjtHxKfTyAf4ZDblIsXQdUFu5nIfSPHaDuLYkshuU8WOFZ9Z0jeU1rOsWcJme5ZMcilUWGXt0B43laVXyWdUG3DGXnn/81ohZhUEnRTzdAp4GfF+i45vD5aPz0cKwH3VNWu7FMCrrajqT7UNs8SIW4odVC5rnkUzuED5i0re08FePFdDGa+c3lSfVlq0b1HDFPlgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFTSLuhmFvpQuYs6UlCDy77D/Y6zKTqphrofGrE53CQ=;
 b=ZcgVXji8d37GB3BG/M35/A667Ftrc3+k7Wsk/vLcwoDzL+lmEL08/o16fX3m23n7SNFinU27FX+R4x0gGWGFGups74fEMpkcigOk4B4p8pHdvXv/8IX/aLBEsCkC0WhO5S1IF8rcU81SvW4MKqEN8u2RoMz30obRjAwbIJwjSHN03eOlVLFSjqNYyPbgfqNKGLCyTOsPXNOgNL1OLvyU+NTwQ6KIB8huBb3RaegbIu0Xn1ijCVJVTS31kIo97wNy2sal8TDjr6YsdIosqBOuy3R/DtEXD6jG4Lw/M+9pFvokeNCeclpmeyXTIoU1/s8rHOxdm68QxZQSUmN2wKuwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFTSLuhmFvpQuYs6UlCDy77D/Y6zKTqphrofGrE53CQ=;
 b=teOOf3KoXA1BtkyNr47jAGEbbUJms7KYKf5QE2xeRbt24k8LC/Yc2HONjlzan2m0xm7Q2zcm0twj5DOEuYK4ZIhVq41VJmub2K3p9L+GeXfJsXFY9A7L8CAYLMsjtrpexlOaS3N1nLUjxpb9F5cwhW3tMtkPV2oVqFSrPbt4HYk=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1849.namprd11.prod.outlook.com (2603:10b6:3:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 11:26:25 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 11:26:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Topic: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Index: AQHWllNcSEOJ06dulUeHo292BYv/qQ==
Date:   Tue, 29 Sep 2020 11:26:25 +0000
Message-ID: <feb046fd-a9ea-9ea3-55f7-bf823ed1e61f@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-10-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-10-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bf59fcb-2ef5-4128-b14d-08d8646a8031
x-ms-traffictypediagnostic: DM5PR11MB1849:
x-microsoft-antispam-prvs: <DM5PR11MB1849BBBE7400B863F60030C8F0320@DM5PR11MB1849.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMjoB/MyftwttX9GZg4LPedqPKaaQZ0pEeE+Y9ugOaJjH4vtJWNBDnxpw4shGKUOAcJIVaSYfSHdEDLlulXCHppktg58pgfPbeDwESRmpOZjyI8w9bZvEdgqknY9er/lxwTtp3aGUZYVvSbLLsXqugP//0cC7uv4zRF9RM0a9TKzKTDQjkVgsW8Zl4Z1Dsy36aSnvHJiAR8oGiHTVpxgOJkBF4J2pFqIl8aEzAzz4YkYc2l6Z5fTVEAr4tKRDaIXb35LBd6XUULHjEgCST4M6gvIbQ1k6pusblGfau2XKm2ZfwObvfPHZz4tp+mKRk9hjLCyaivPVp3K0d7R3fJpm/fRXCcAzURPgIeseBwCZw4wkcMN3lTq5bgzK9lhLkXRzZG/yi2euH8JmqVVs3WDcwipKcaSC+aZHbFHOgtoaxyiOUS73JcMgrmV479LAEJa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(39860400002)(366004)(71200400001)(54906003)(5660300002)(86362001)(64756008)(66556008)(66476007)(66446008)(110136005)(76116006)(91956017)(36756003)(8936002)(2616005)(8676002)(66946007)(478600001)(26005)(2906002)(6512007)(53546011)(186003)(6506007)(31696002)(6486002)(31686004)(316002)(4326008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: l0Zm0EX3KBlJ34ZAaP5Pl86H6EpE2gs1xLw730arnaJdncfifnTELH/OYNvFmHhphCL98E07vxSMJw7Xk7p1NXiq5Lb+/85VjTntMTcOHndVKFEXvk6idDzflNFjgBKZ3NxkW1mGa4hxgTcQxlV/JYV9epMtLeHb0HYp1EeWVpFOrELXblYmNkjvVw71HRPaEAP26VPhT2Y40QFeqRLEwD9JBxyu+qhWLyiIn4DBFTvOBctMbWJVZfGtQ8+Wgz5D9OHNaj5Q/oag+Lwc+vb7jV1o2wogzCrqESoDKRjGCkovbl5mCrhtuBgirz3dPJLGl6R3AIReRlJ2CROB8d6GM3FT4lMxpbHYIWPk0v+xWgKgB49MJ0VLCTaHqZeZBdPhoIflSpkwpQnpzaqob8ZCrjJg3kF8pr7gHidgqW0wPzil3VIfQINjEikZPEP/rIz6uFsrbmUZTGKu1QiRDx6us5i/qaCG8tSR+6mg9WQchXUJV1LzlMB37Ysp+U5dHKSruLkagzVR74DkMzPspuW0V3hn0/gO7bGdbtNosNN8dvWoNME4uK+CiSt8S8PbkuMF9evUQeggu2Nnp6mAU6XXMTEYrn+Xz9PPIW+G8A2CA8SPWghg7ci5UZYao7Thh6pLeoCavurtL6BjDD9ol2EzOg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <96ECCF50E8F47043A6775C52E20CB543@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf59fcb-2ef5-4128-b14d-08d8646a8031
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 11:26:25.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rkntc0fvetsthqsoBlFnkIlswmpkKDs3rwexkqmZBybgD4OURvmYr6uwTh8LocWl9CCE68uCim1c3/bWgICx8722t2F+vXzk+agFYJEjsWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDkvMTYvMjAgMzo0NCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQWxsb3cgZmxhc2hlcyB0byBzcGVj
aWZ5IGEgaG9vayB0byBlbmFibGUgb2N0YWwgRFRSIG1vZGUuIFVzZSB0aGlzIGhvb2sNCj4gd2hl
bmV2ZXIgcG9zc2libGUgdG8gZ2V0IG9wdGltYWwgdHJhbnNmZXIgc3BlZWRzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIHwgIDIgKysNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gaW5kZXgg
ODdjNTY4ZGViZjE0Li42ZWU5MzU0NGQ3MmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IEBAIC0z
MDY5LDYgKzMwNjksMzUgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0cnVjdCBz
cGlfbm9yICpub3IpDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiArLyoqIHNwaV9u
b3Jfb2N0YWxfZHRyX2VuYWJsZSgpIC0gZW5hYmxlIE9jdGFsIERUUiBJL08gaWYgbmVlZGVkDQo+
ICsgKiBAbm9yOiAgICAgICAgICAgICAgICAgcG9pbnRlciB0byBhICdzdHJ1Y3Qgc3BpX25vcicN
Cj4gKyAqIEBlbmFibGU6ICAgICAgICAgICAgICB3aGV0aGVyIHRvIGVuYWJsZSBvciBkaXNhYmxl
IE9jdGFsIERUUg0KPiArICoNCj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAtZXJybm8gb3Ro
ZXJ3aXNlLg0KPiArICovDQo+ICtzdGF0aWMgaW50IHNwaV9ub3Jfb2N0YWxfZHRyX2VuYWJsZShz
dHJ1Y3Qgc3BpX25vciAqbm9yLCBib29sIGVuYWJsZSkNCj4gK3sNCj4gKyAgICAgICBpbnQgcmV0
Ow0KPiArDQo+ICsgICAgICAgaWYgKCFub3ItPnBhcmFtcy0+b2N0YWxfZHRyX2VuYWJsZSkNCj4g
KyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiArDQo+ICsgICAgICAgaWYgKCEobm9yLT5yZWFk
X3Byb3RvID09IFNOT1JfUFJPVE9fOF84XzhfRFRSICYmDQo+ICsgICAgICAgICAgICAgbm9yLT53
cml0ZV9wcm90byA9PSBTTk9SX1BST1RPXzhfOF84X0RUUikpDQo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4gKw0KPiArICAgICAgIHJldCA9IG5vci0+cGFyYW1zLT5vY3RhbF9kdHJfZW5h
YmxlKG5vciwgZW5hYmxlKTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gKw0KPiArICAgICAgIGlmIChlbmFibGUpDQo+ICsgICAgICAgICAgICAg
ICBub3ItPnJlZ19wcm90byA9IFNOT1JfUFJPVE9fOF84XzhfRFRSOw0KPiArICAgICAgIGVsc2UN
Cj4gKyAgICAgICAgICAgICAgIG5vci0+cmVnX3Byb3RvID0gU05PUl9QUk9UT18xXzFfMTsNCj4g
Kw0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAvKioNCj4gICAqIHNwaV9ub3Jf
cXVhZF9lbmFibGUoKSAtIGVuYWJsZS9kaXNhYmxlIFF1YWQgSS9PIGlmIG5lZWRlZC4NCj4gICAq
IEBub3I6ICAgICAgICAgICAgICAgIHBvaW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InDQo+IEBA
IC0zMTA5LDYgKzMxMzgsMTIgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXQoc3RydWN0IHNwaV9u
b3IgKm5vcikNCj4gIHsNCj4gICAgICAgICBpbnQgZXJyOw0KPiANCj4gKyAgICAgICBlcnIgPSBz
cGlfbm9yX29jdGFsX2R0cl9lbmFibGUobm9yLCB0cnVlKTsNCj4gKyAgICAgICBpZiAoZXJyKSB7
DQo+ICsgICAgICAgICAgICAgICBkZXZfZGJnKG5vci0+ZGV2LCAib2N0YWwgbW9kZSBub3Qgc3Vw
cG9ydGVkXG4iKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ICsgICAgICAgfQ0K
PiArDQo+ICAgICAgICAgZXJyID0gc3BpX25vcl9xdWFkX2VuYWJsZShub3IsIHRydWUpOw0KDQpJ
cyBpdCBwb3NzaWJsZSB0byBlbmFibGUgb2N0YWwgZHRyIGFuZCBxdWFkIGF0IHRoZSBzYW1lIHRp
bWU/DQpNYXliZSBhbiAnaWYvZWxzZSBpZicgaGVyZSBkZXBlbmRpbmcgb24gdGhlIHZhbHVlcyBv
ZiBub3ItPnJlYWRfcHJvdG8gYW5kDQpub3ItPndyaXRlX3Byb3RvDQoNCkNoZWVycywNCnRhDQo=
