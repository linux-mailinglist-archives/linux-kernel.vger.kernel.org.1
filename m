Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A127CBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbgI2M3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:29:47 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24182 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgI2Lai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601379038; x=1632915038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pPIqFUcy8fTZSkir27poZeGbsiGXBIs8Uptq5si8F8w=;
  b=Xj7qq+4jx8qwcdbP4VSx0bnpxOJgHzWPnC8xcg7BEhwxGcfDICgMo7P5
   2OhzN3ilXKZOY3klThIBUpp4Yv/IJM/xGxnmoYLTNa/iMQ1WfOA3GPPjm
   5NegMtQkoXZ++1x9154S4XDBSyXXsDjhEePljYOxbyml9UYZVYz5riPzI
   G0iv7VOHU6MUFQK61lnEYjOe+iS51Jpdl3GREA8njm4ClzQd9Q8ZVJGG5
   ZGXqVwlLA45pj5CooIp4g1RRW5Wa4Oho37xTMDW6+pkA5o1SvnozpS+N/
   sBCnwx3oeRHw0UeWFgXaP/XUm4usXSrI2TlBNgjnVynp3eFn5Pse6ifMz
   Q==;
IronPort-SDR: /GeLjTiP0+S4p7tcJK1b26auoB5uQKKFlCqU2F4n+xaFfTmgyvFYswDuKDq2sAiLNIkCe+agcZ
 bwL9QuA8s+8O7si4eoFHmwRuzSuWieQzWiDQqLLz2n3T1vyIlr8nxrhDVc3xY0FsRoxVFLvU6i
 BA4NrF6JKM39IEhk0LYXzOO15l3zCHulEIj8waj0vNWP13m2J72TMZd6hujgbZzNJXr+a/W5rX
 +B5Scy1UAcRaq9w6HxxDmTLMOqdX+d0q6RyEOc9R8YAf1oqCQiS0sXozPgStldFPQS7HvyDsY1
 1xo=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="92767508"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 04:30:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 04:30:37 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 29 Sep 2020 04:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODovr30h2uu0sNLPwav5BjWsJP4K+SSso3SjCx4v9ZRp6kuU8A9zEkTvB6/lxPGe//z/pHGqS2wtMwOQ8TOXusffQhqnJ1KC6fW01XNxugMaX3G/qlXeEW2DUQxWmOOfbIKbEFOoc6QoF8+XPNxPyjxNVzT15ejltuwjaVrYv/3vYdr1LSK93ILlj/BZYfgcTFq3+9CxfLGUEdwT/oX5fyqYXi2RkElLLeC6/XTloXxGx018tXpKzxkf8YQlZtEGdwr61j7f40kFAi5+mpDublXMCNSvsRFWIrgISDT3lu3M+7g3z2VLukSSGc9NV8vLAE+fqQ3MuNyAoCXA/PefPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPIqFUcy8fTZSkir27poZeGbsiGXBIs8Uptq5si8F8w=;
 b=ZR8aIQfHRXeeZyfvguKlS8xQVGgOlDX8BXMcUIOtE5piin7rQMKILIR++82VSbT25o+u9nplLke4iJ+tYhI6s6E/IfyRpIhkmAQdh7Nv+Ix6q6SnKJ5fCtaGaDJlgX4FQpWCN5RLsXyPshwJhgcvVkyyD2z515jwFdrkkT9DF3rMPGOJXzDoq0/5s+KPz6gRxD5LMxW9I/vJcT+XYfiApLpzVRhVMAeJvnGg8HCMT6BxKe0LStJy8cq7cPigd+YI9WynnCx1JuZkcaIk7VOHnVaR8w/MiSaMp9mh5g7PTwtYOk+b8EGHhGBtFj89bjqb+0F1JSI7lxMQqCJpOZvs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPIqFUcy8fTZSkir27poZeGbsiGXBIs8Uptq5si8F8w=;
 b=T1FaZM3b+WXghaNJMSp+yk432Kb6/B0y+EVrJmg98G31HIuswO+HGfmQgF5rHGuq2qG1Gfgp+pDXUOMf/h5tSp/kJW3yVHwlxt51A5XJp7H6lpOkeS3Ox+x7Sq9aO9b5O7kRTL3wbLlh/IKuvT6rKaX0S1eJuVnf6XGbHlNONnk=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1849.namprd11.prod.outlook.com (2603:10b6:3:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 11:30:35 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 11:30:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Thread-Topic: [PATCH v13 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Thread-Index: AQHWllPyG1aFgNJlm02+rIjiIwVdlQ==
Date:   Tue, 29 Sep 2020 11:30:35 +0000
Message-ID: <9eabfa53-40a7-3e29-b59f-bf762b2d0af4@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-2-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-2-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: c5ec4908-2297-4a81-2d79-08d8646b1564
x-ms-traffictypediagnostic: DM5PR11MB1849:
x-microsoft-antispam-prvs: <DM5PR11MB18492CC1B808FFAD9D7DB68DF0320@DM5PR11MB1849.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pzjf5z86ZdCnvabBguxfPYJzATAinTb8qYcK7ALqfKVunPeRYAVsu+k8MWiJO9mZp7hHxXhnpaRXTpSH+cHgnL4QZ1JFC5U1ikw+Q9ztPzgkXDaUG6IFwH3ghPjHs2IQ/cUVfeNVjAVPAnwV5wveBM+mTHZRYxbkBr3oDZGgTQ/07xMUuJKz2n3lwIPjzkzFqqxPvNknP0fZlY/Q2aLY0Tot0V0XnGdFj+Hf1WEE0zjYTweaOosnQKNCZNXZVjJtmE/XYWYAPAAK1DbFX7RxgUJNLD9i+AGJGy1XX58q7Rdg8lQbvOn14DVLB+vfcKKNbGW7ftKlT/wgZYjkhYtFggKxFjL9R7+7TVTcVC4E3i84nOMyC7SIGfU87D20AQeRxT+EV/7hGOU0N+JaKE2nGfozebUfhv3SQPbQ1WE3f98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(53546011)(186003)(6506007)(83380400001)(2906002)(4326008)(31686004)(6486002)(31696002)(64756008)(66556008)(66476007)(86362001)(66446008)(54906003)(71200400001)(5660300002)(26005)(498600001)(91956017)(36756003)(8936002)(2616005)(110136005)(76116006)(8676002)(66946007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BetH8l0AsHvla+g2PUpigxBU4MTiunmEnwRWIZsP9yXrcqU1b9pVPBRj+F6nsqMS9jDRRZNbfli4jXMEwPXaOJX7OXdEUjh4TBYMBEKmxhwyQXjVo5+O5N2Rb8WvBMy7FW/IxEMgl8fZB2y2c/RyhsPnk9pArEDM1ccrkrXKxZ2Mr5+hulrzf/8cXTdUkgPDasSDG1xG6Ceq+FFMZakln1n82G95jrWCQUsr9ooNRb5eWyALjR1HJ2yF+cWCs2XQ+8uB3tj1yIhrmOxHDytBCo77+fwSUJlOnXx51nTsRTWlJcoL2Odoz4XeQlZdBqKnjj5TaS7ZzYmqhs3QXqf7iOXYiveFzYqXKp8WhNgpJogZiXk+q21jBBUwHDbNdOSCQAnGjFJ8pZzkz4PMN/yd+hKb5Ww8vF97Uq5n+zCptEg1Zfup7/hY0UG4+lP3BftHj4UFi9wUfCCh2Z/TAsgGTJ7T0d0aTSxvME0YPQTdr79r3sKy/FJl2HWNPmAo7AY2OdUszeznEHMwnSowjL+MM+fwy/rCi3p2313DgqU/8a+ZvNT6V5mDu84BwziOAFsaIuMfI/Sb77Io447rlTcyoD+2QgGXnNyzDcKDmENwPOzevY/0OFXXKgGEq3ceUzbc33XhUIjz5f9zGGLrrHZSTw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <60C214559661754D9FE0ACE43D2DBE7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec4908-2297-4a81-2d79-08d8646b1564
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 11:30:35.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2rG7GjiEhtqkVzLrQUJtTRGbypXN6wClNgn8lt23OjguJQ5xjpGmMeDr5gMyIV/SG50ReKvyidA21bxAfLwrZe/cQPDxYvFcOoBSzqjl9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJv
ciBjb2RlLiBVc2luZyBFT1BOT1RTVVBQIGlzIHByZWZlcnJlZA0KPiBpbiBpdHMgc3RlYWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQoNClJl
dmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoN
Cj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDEwICsrKysrLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYw0KPiBpbmRleCA2NWVmZjRjZTZhYjEuLjYyMzM4NGVmOWE1ZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmMNCj4gQEAgLTIyOTcsNyArMjI5Nyw3IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9o
d2NhcHNfcHAyY21kKHUzMiBod2NhcHMpDQo+ICAgKkBub3I6ICAgICAgICBwb2ludGVyIHRvIGEg
J3N0cnVjdCBzcGlfbm9yJw0KPiAgICpAb3A6ICAgICAgICAgcG9pbnRlciB0byBvcCB0ZW1wbGF0
ZSB0byBiZSBjaGVja2VkDQo+ICAgKg0KPiAtICogUmV0dXJucyAwIGlmIG9wZXJhdGlvbiBpcyBz
dXBwb3J0ZWQsIC1FTk9UU1VQUCBvdGhlcndpc2UuDQo+ICsgKiBSZXR1cm5zIDAgaWYgb3BlcmF0
aW9uIGlzIHN1cHBvcnRlZCwgLUVPUE5PVFNVUFAgb3RoZXJ3aXNlLg0KPiAgICovDQo+ICBzdGF0
aWMgaW50IHNwaV9ub3Jfc3BpbWVtX2NoZWNrX29wKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0K
PiBAQCAtMjMxMSwxMiArMjMxMSwxMiBAQCBzdGF0aWMgaW50IHNwaV9ub3Jfc3BpbWVtX2NoZWNr
X29wKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAgICAgICAgb3AtPmFkZHIubmJ5dGVzID0gNDsN
Cj4gICAgICAgICBpZiAoIXNwaV9tZW1fc3VwcG9ydHNfb3Aobm9yLT5zcGltZW0sIG9wKSkgew0K
PiAgICAgICAgICAgICAgICAgaWYgKG5vci0+bXRkLnNpemUgPiBTWl8xNk0pDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFNVUFA7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gDQo+ICAgICAgICAgICAgICAgICAvKiBJZiBmbGFz
aCBzaXplIDw9IDE2TUIsIDMgYWRkcmVzcyBieXRlcyBhcmUgc3VmZmljaWVudCAqLw0KPiAgICAg
ICAgICAgICAgICAgb3AtPmFkZHIubmJ5dGVzID0gMzsNCj4gICAgICAgICAgICAgICAgIGlmICgh
c3BpX21lbV9zdXBwb3J0c19vcChub3ItPnNwaW1lbSwgb3ApKQ0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVOT1RTVVBQOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVPUE5PVFNVUFA7DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICByZXR1cm4gMDsNCj4g
QEAgLTIzMjgsNyArMjMyOCw3IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9zcGltZW1fY2hlY2tfb3Ao
c3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAqQG5vcjogICAgICAgICBwb2ludGVyIHRvIGEgJ3N0
cnVjdCBzcGlfbm9yJw0KPiAgICpAcmVhZDogICAgICAgIHBvaW50ZXIgdG8gb3AgdGVtcGxhdGUg
dG8gYmUgY2hlY2tlZA0KPiAgICoNCj4gLSAqIFJldHVybnMgMCBpZiBvcGVyYXRpb24gaXMgc3Vw
cG9ydGVkLCAtRU5PVFNVUFAgb3RoZXJ3aXNlLg0KPiArICogUmV0dXJucyAwIGlmIG9wZXJhdGlv
biBpcyBzdXBwb3J0ZWQsIC1FT1BOT1RTVVBQIG90aGVyd2lzZS4NCj4gICAqLw0KPiAgc3RhdGlj
IGludCBzcGlfbm9yX3NwaW1lbV9jaGVja19yZWFkb3Aoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNwaV9u
b3JfcmVhZF9jb21tYW5kICpyZWFkKQ0KPiBAQCAtMjM1NCw3ICsyMzU0LDcgQEAgc3RhdGljIGlu
dCBzcGlfbm9yX3NwaW1lbV9jaGVja19yZWFkb3Aoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAq
QG5vcjogICAgICAgICBwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJw0KPiAgICpAcHA6ICAg
ICAgICAgIHBvaW50ZXIgdG8gb3AgdGVtcGxhdGUgdG8gYmUgY2hlY2tlZA0KPiAgICoNCj4gLSAq
IFJldHVybnMgMCBpZiBvcGVyYXRpb24gaXMgc3VwcG9ydGVkLCAtRU5PVFNVUFAgb3RoZXJ3aXNl
Lg0KPiArICogUmV0dXJucyAwIGlmIG9wZXJhdGlvbiBpcyBzdXBwb3J0ZWQsIC1FT1BOT1RTVVBQ
IG90aGVyd2lzZS4NCj4gICAqLw0KPiAgc3RhdGljIGludCBzcGlfbm9yX3NwaW1lbV9jaGVja19w
cChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IHN0cnVjdCBzcGlfbm9yX3BwX2NvbW1hbmQgKnBwKQ0KPiAtLQ0KPiAyLjI4LjAN
Cj4gDQoNCg==
