Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DD027E24C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgI3HLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:11:22 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:25021 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgI3HLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601449880; x=1632985880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=te5Fq8lU1NgnJLTpRCidjkrgB1vZRxYx1twgyQtF8jQ=;
  b=dyRrYKxkN0J//2/+AUHSkbVVqBlUCJQcLvVC90KIE0ssVDMK162aTu+z
   3mNu7VFpJUTSageYJ8EORT2m6bi4+gCdSHrmE5XRqh38mAySM9cJlxuKa
   G77wiqz1cT7XS2wvXSqSFuC65xF7175cFoof+h02m7VmdWW1OpZTpbB4C
   2i/BnnGk6nb+yy9lZwuVDzI48tYOP/KsFooRiUI6lgcmR97vg1CghSlz4
   QqhfNQ653y+N7IkI28VDHFuFqv+wyhVzS72AxqXtP80+PAINf4wN4yJqe
   2qUIVb+LTtQEPPKh1uLvgrGsRFy0uuYuDRyXjwweRpw7JFLMXuIiNO9TZ
   A==;
IronPort-SDR: hx1hx9303ujWudmhME8ocjZV37tnz/CnL2v85ymatifM6Tl0jBfRy8aSn0+l6ZwAhNeQ3ge1/J
 4HPYGG20hE16DT4Q8yB9sHL1LTIf+z3vsDxy9Q7SMCZa0T7a80SPCpn0wi/xryO8NCm35qIDlt
 CNpwRfYujPHROqJGlqaE+TAvBCwgO6MQI9Vd5KyEWbdEQGV8Z/7eTdYfpjuLx3S3waMxPlCZ8I
 0x2SqEJ4GM9+D+HhSxfS8K+kiPoKXOCYK3TR2fjhJaopC3XOS/VsCWbJpkBgBylbicOwklCZQ8
 YWY=
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="88632018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 00:11:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 00:11:03 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Sep 2020 00:11:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afWce9WKVwUThiJXSXO53nkmYB6/7rkZb1Utwa2eXDyUmZbWaBMt7acceEG+akxgWQVYGJ+pQ2nEWdf7QSN3vaauO4bK/Ke20ZQSYRXmCvSwRwyNnlYJPRWDDbUGNWgWdXXvJh39YS0F6BUsPiGwE/HABR5aRAN8N6J92p5+VlSfmn6heigenfwWztkxSYjTIHzvZ8AbxUjfPQMQBhCwM3Ycsh1l0ittIBch6xfmsrgoaIuCZbIqUrCgMTzUqLA/8oTEf71g0jhug3Vy/VjTUhc6yBYj+lnIg9nkr3WQGQxf0qWjdYFY7SPyJuXkfp0Z4oI0t6r6nu4Yu3Rd+aw5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te5Fq8lU1NgnJLTpRCidjkrgB1vZRxYx1twgyQtF8jQ=;
 b=Fb2YToZ6FOT4YAVsCrpZaht0wmOYgtv+Q+JMDzXSQkrG9YyQZr3JD6HD5VCZ6ePbNU8CntnzUUWy3BVZTPJD80WDc0YjE8NxoqCTeCm5fqEKBGuj9nEWkyiZd1yHAOOeubebr1og6ZcLsFbdQV//T+cEGHM9kJZuC7V+tdWZoKlWA+ADyhKgT07eAWvN5SEt9YB4o25kHxOJjJiVQWPCxP5EHfGW47uC+EY4f/En9F11onITEKSLU3NZ32rk6GoSMQ65CCKxYhnSTMhtKPOqV6GL+8NX79Led2D5QeOsPX7WBwtknwjNIaKWvQ0ILN7ssHju0EnVbT7KmDg4xf/kTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te5Fq8lU1NgnJLTpRCidjkrgB1vZRxYx1twgyQtF8jQ=;
 b=tN+g3AEYDYJkzQV/ft+Gv1325/qMsIxASSQhiYNYseChkhh9erWqx73iD3BbLtKozjtqVnWRESQkKYY8silGniflSy81T83whlfCWUOWNbSAtcSm1Svpw1xwJfGmtP5Tx/NSvwdV5YVDIoStPznRhkeZfBD8dyyobhzIUARdUz0=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM5PR11MB1612.namprd11.prod.outlook.com (10.172.37.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.24; Wed, 30 Sep 2020 07:11:16 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 07:11:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Topic: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Index: AQHWlvjhSEOJ06dulUeHo292BYv/qQ==
Date:   Wed, 30 Sep 2020 07:11:16 +0000
Message-ID: <47419443-fe8c-1046-ae04-d188560156c5@microchip.com>
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
x-originating-ip: [5.13.1.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc99a13-f2dd-4255-7ee3-08d8651005bf
x-ms-traffictypediagnostic: DM5PR11MB1612:
x-microsoft-antispam-prvs: <DM5PR11MB1612F480D4E1FBF3A18BEB19F0330@DM5PR11MB1612.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Mziihyp3BIYXVVjUykLteJdCU7rIorXzlemoE/Qd2I6ZDq9SAeyT8tqQgzNBHgt3Lc+fqNVAGM2iwnUuCEHrmq16+RXk9tUphyX85iYP06QVzi6PcYZwFdQus24mw+yRAZhF5ZeCKmpAdrkf5C9+xBkZ9cDe8rzdiub3GsDKIa6w5lkZHbS4rtP+dx1T1SG2ZA67hZaNf35OiZUeR2r9AnyFKV0Fyp5KQpdUgn6mXlvZHwNJGU1K7UqZTMiRwALpHK4Hu/XylYi8BZg/GHZ3o5KRbt+oMxMkXASsEuK2BFg0TPbeYlIvjwRRSN2yeeK9nbOIGGlJ5+BIdSy6cDEbrx5JcphTW1cZaVqvEPTv5EUGU0OK2BNsMJNYbIxx4k+piiQXVWdYzNziebLa4OCKNeLbB8iNxvAQy7fPYn9UAtOxM8umwM3OfEkAf+wEG44
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(366004)(346002)(86362001)(71200400001)(31696002)(66556008)(64756008)(66446008)(66476007)(66946007)(478600001)(76116006)(31686004)(4326008)(8676002)(110136005)(186003)(54906003)(36756003)(83380400001)(91956017)(8936002)(6512007)(2616005)(2906002)(6486002)(5660300002)(316002)(53546011)(6506007)(26005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1tL6YqnZbURu6/5ZOm8FHGMrzDcxUzlr1ayqYNabLwWnU48h77iDx+iA7x9to2Co+o24T+/V/wLfNeZMLMcaR95qfIhE1guxqpAT+ZkR/u3jrc6mfhYGPiK7ACmRYHpqKOsOm+YB1mt5NmdjWaW8HDQzFhAooWVTxzJyHlS/7rYfrpAlgyI1TY/FurpWSEzwRrEnsAkL3RycHX0MYXnXgsWd5y7pNnvYGiXKteACxj3ZCFRPOaR5vQ/7cUDip3Ypij1FZCR1uvrNCaFoRt+Xb315mNdDwEOHFgrVhRM9hxo+99FsAKC3VLXLjZjPPsjYswiJhDPnMK/TP+jr/0mas6D5RRTNF8RwD3andchqDV5Cug3cBxGfRO7shTTf13r8slS2CLfcRklc0jv0Q9KvSGapl86snFo6haIKT/R1paAEm4WvgyoVCG9ERtXSiN0BOfAB7wLcd43672nc79+krrOkoyazplSCiqZ+k79K5wnlWcC6VndS4ACmGG9loO35w46whCsrHoXfU0V5KTfu7fvPc3JdamVykb4ddF56tow6dLuSWI43LSGIYHbT66iGRpv/j1Qjk7aOGfMmTqBweypcSQ8VIzNArR3jeONxqOtvZ1sgoihJlU9cYz/dllWcx0W3ghHLgQm5b67JlESo7A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <258C63BA3A245947B7BB956365F72089@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc99a13-f2dd-4255-7ee3-08d8651005bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:11:16.1793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJV7vZJUqAP+f6Z6lxUgsdUkHry77IWjJ/AdTPMlOs9yFv2WA0/CVBWG49f5/pmhpG+qWJTeVgIyuEyWn+b9VRCoXYA3wnc0u+wjv6SKjIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1612
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbGxvdyBmbGFzaGVzIHRvIHNwZWNpZnkgYSBo
b29rIHRvIGVuYWJsZSBvY3RhbCBEVFIgbW9kZS4gVXNlIHRoaXMgaG9vaw0KPiB3aGVuZXZlciBw
b3NzaWJsZSB0byBnZXQgb3B0aW1hbCB0cmFuc2ZlciBzcGVlZHMuDQoNCldlIG5lZWQgdG8gcmVz
dHJpY3QgdGhlIGFjY2VzcyB0byBvY3RhbCBkdHIgZW5hYmxlIGZvciBmbGFzaGVzIHRoYXQgZW50
ZXIgaW4NCjgtOC04IGR0ciBtb2RlIHZpYSBub24tdm9sYXRpbGUgYml0cy4gSXQncyB3aGF0IEkg
dHJpZWQgaW4gUkZDIDEvMy4NCg0KTG9va3MgZ29vZCA7KQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAzNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCA4N2M1NjhkZWJm
MTQuLjZlZTkzNTQ0ZDcyZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3Jl
LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTMwNjksNiArMzA2
OSwzNSBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5v
cikNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICsvKiogc3BpX25vcl9vY3RhbF9k
dHJfZW5hYmxlKCkgLSBlbmFibGUgT2N0YWwgRFRSIEkvTyBpZiBuZWVkZWQNCj4gKyAqIEBub3I6
ICAgICAgICAgICAgICAgICBwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJw0KPiArICogQGVu
YWJsZTogICAgICAgICAgICAgIHdoZXRoZXIgdG8gZW5hYmxlIG9yIGRpc2FibGUgT2N0YWwgRFRS
DQo+ICsgKg0KPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UuDQo+
ICsgKi8NCj4gK3N0YXRpYyBpbnQgc3BpX25vcl9vY3RhbF9kdHJfZW5hYmxlKHN0cnVjdCBzcGlf
bm9yICpub3IsIGJvb2wgZW5hYmxlKQ0KPiArew0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4g
KyAgICAgICBpZiAoIW5vci0+cGFyYW1zLT5vY3RhbF9kdHJfZW5hYmxlKQ0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAgICAgICBpZiAoIShub3ItPnJlYWRfcHJvdG8gPT0g
U05PUl9QUk9UT184XzhfOF9EVFIgJiYNCj4gKyAgICAgICAgICAgICBub3ItPndyaXRlX3Byb3Rv
ID09IFNOT1JfUFJPVE9fOF84XzhfRFRSKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0K
PiArDQo+ICsgICAgICAgcmV0ID0gbm9yLT5wYXJhbXMtPm9jdGFsX2R0cl9lbmFibGUobm9yLCBl
bmFibGUpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiArDQo+ICsgICAgICAgaWYgKGVuYWJsZSkNCj4gKyAgICAgICAgICAgICAgIG5vci0+cmVn
X3Byb3RvID0gU05PUl9QUk9UT184XzhfOF9EVFI7DQo+ICsgICAgICAgZWxzZQ0KPiArICAgICAg
ICAgICAgICAgbm9yLT5yZWdfcHJvdG8gPSBTTk9SX1BST1RPXzFfMV8xOw0KPiArDQo+ICsgICAg
ICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogc3BpX25vcl9xdWFkX2VuYWJs
ZSgpIC0gZW5hYmxlL2Rpc2FibGUgUXVhZCBJL08gaWYgbmVlZGVkLg0KPiAgICogQG5vcjogICAg
ICAgICAgICAgICAgcG9pbnRlciB0byBhICdzdHJ1Y3Qgc3BpX25vcicNCj4gQEAgLTMxMDksNiAr
MzEzOCwxMiBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0K
PiAgew0KPiAgICAgICAgIGludCBlcnI7DQo+IA0KPiArICAgICAgIGVyciA9IHNwaV9ub3Jfb2N0
YWxfZHRyX2VuYWJsZShub3IsIHRydWUpOw0KPiArICAgICAgIGlmIChlcnIpIHsNCj4gKyAgICAg
ICAgICAgICAgIGRldl9kYmcobm9yLT5kZXYsICJvY3RhbCBtb2RlIG5vdCBzdXBwb3J0ZWRcbiIp
Ow0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gKyAgICAgICB9DQo+ICsNCj4gICAg
ICAgICBlcnIgPSBzcGlfbm9yX3F1YWRfZW5hYmxlKG5vciwgdHJ1ZSk7DQo+ICAgICAgICAgaWYg
KGVycikgew0KPiAgICAgICAgICAgICAgICAgZGV2X2RiZyhub3ItPmRldiwgInF1YWQgbW9kZSBu
b3Qgc3VwcG9ydGVkXG4iKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gaW5kZXggNDJlYzc2OTJkOGU3Li5m
Y2I1ZjA3MWViZWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+
ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IEBAIC0yMDMsNiArMjAzLDcgQEAg
c3RydWN0IHNwaV9ub3JfbG9ja2luZ19vcHMgew0KPiAgICogICAgICAgICAgICAgICAgICAgICAg
aGlnaGVyIGluZGV4IGluIHRoZSBhcnJheSwgdGhlIGhpZ2hlciBwcmlvcml0eS4NCj4gICAqIEBl
cmFzZV9tYXA6ICAgICAgICAgdGhlIGVyYXNlIG1hcCBwYXJzZWQgZnJvbSB0aGUgU0ZEUCBTZWN0
b3IgTWFwIFBhcmFtZXRlcg0KPiAgICogICAgICAgICAgICAgICAgICAgICAgVGFibGUuDQo+ICsg
KiBAb2N0YWxfZHRyX2VuYWJsZTogIGVuYWJsZXMgU1BJIE5PUiBvY3RhbCBEVFIgbW9kZS4NCj4g
ICAqIEBxdWFkX2VuYWJsZTogICAgICAgZW5hYmxlcy9kaXNhYmxlcyBTUEkgTk9SIFF1YWQgbW9k
ZS4NCj4gICAqIEBzZXRfNGJ5dGVfYWRkcl9tb2RlOiBwdXRzIHRoZSBTUEkgTk9SIGluIDQgYnl0
ZSBhZGRyZXNzaW5nIG1vZGUuDQo+ICAgKiBAY29udmVydF9hZGRyOiAgICAgIGNvbnZlcnRzIGFu
IGFic29sdXRlIGFkZHJlc3MgaW50byBzb21ldGhpbmcgdGhlIGZsYXNoDQo+IEBAIC0yMjYsNiAr
MjI3LDcgQEAgc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyIHsNCj4gDQo+ICAgICAgICAg
c3RydWN0IHNwaV9ub3JfZXJhc2VfbWFwICAgICAgICBlcmFzZV9tYXA7DQo+IA0KPiArICAgICAg
IGludCAoKm9jdGFsX2R0cl9lbmFibGUpKHN0cnVjdCBzcGlfbm9yICpub3IsIGJvb2wgZW5hYmxl
KTsNCj4gICAgICAgICBpbnQgKCpxdWFkX2VuYWJsZSkoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9v
bCBlbmFibGUpOw0KPiAgICAgICAgIGludCAoKnNldF80Ynl0ZV9hZGRyX21vZGUpKHN0cnVjdCBz
cGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKTsNCj4gICAgICAgICB1MzIgKCpjb252ZXJ0X2FkZHIp
KHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBhZGRyKTsNCj4gLS0NCj4gMi4yOC4wDQo+IA0KDQo=
