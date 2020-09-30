Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2F27E19B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgI3GqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:46:04 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:34679 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3GqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601448362; x=1632984362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0/JHvHJuaPqs8FMuYEeP5YPhFf4FCxNnA4ToL9C85rk=;
  b=GffO9Fe1ecNw1aC5L4JyHME7EnGhTBKITq8h1rmRqbCLaOEP2Gj2SzbM
   1CiT5AOq0UZk1aLqxqWSy4676IdEfA8gzyo4LKYLspX+EPn0+3ST6/9Ew
   mS7tzqvx9gxlKrO4t+t0Lz7OprOo63MxGc2AREkt6AwnjQVJ6m15ADABS
   /7qzbV0wHkLdwDmRt9HYqpqi4rU/P5zlJMfTJbxiH6ITzgNZYnojJeWqr
   17D5Ik3XxpMHtKf4Ll4TiyT+kEmhHZguYDsNt6YSG+x0C+SH3Lvv9c5NM
   StqZ8XY1AYmDbBhjUGO2Cos6bzxVBhEi2A1jMteTCHvFN0iedYXIuq9Lc
   Q==;
IronPort-SDR: R3OZxILgMHAzwvja38h3HhUsv/Ho1hgi6NWcrujHC1THVdd/N1koTwKxOaVdFDOGBHwtG5xD4b
 0guXoXoRbHxf3DihvG+fKj4ClopOO9Bsq/vw2R8E/Y14Swusp73uF1Mu/ZecmCJMI4BGAt2Y5r
 XOQKDB+keWYmQvTTyU/Uved1yje4xaFaxHoSf5jUqFfv2Q0/BwQEWZ4dj/ZYFXkIWXFNItPTq5
 W5WxlizcKqWRv6FpI32HhPU4YdgFRhJkHqhQmw5vln/7kRbcwZrNTsHs+MLbScKHhgm7+dYXsh
 qWQ=
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="28180940"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 23:46:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 23:46:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 29 Sep 2020 23:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HltuzEBnHp/8TuyuE+cY3GmhbQNUItNdnnuAwTBSTvzfKrSAbq0zFpRf6hBJpfHzeoWVpb+2T/pxR6ix4rDYBVX0a+xbH+0fyLNwN156p0IX4JQYqjfKHDm8sPCeTgxjqlYvaipg4pGA9mwd5XtNLaQiZXFYFhmBxFDWdwy5qCKZMFD+d65LhA50WN9ywBje4FafJPPaUifNJxDnu5T30qBu3aR7S2cp1U+9717qoIC0HAV9ZLCw9AXIMk2fRzyDvgU5ajcKVUV6ZuFcjjnpGDvhMRExikPNWmuL7KDuEEU6yK8AFPaA1RZmX3vN1ojvZCUxpMRLC8zn/bKXcjEMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/JHvHJuaPqs8FMuYEeP5YPhFf4FCxNnA4ToL9C85rk=;
 b=j/c40fasZk7d1ckrLgiCqSFROJE1igqqRZYYBPNg2v7aCUEfFJU8xalXPpH1b7S+IgVXYq1TTAmsME90Tl6569hEvpfiBoLV9Qr14Zdhm96hwJ0P4pJ1LOC55XZxrbPVU4awDJR9pL4drV9jbBnRjdTWUrNfgZ2/n3qjhWSTljTAtwUDRmxY8E26sO6LOF5Xtd/huCOcrcGOFBYi9JYc50+l6wz++D7ISEiWHNnO+KRzd5bS1SwQN/wLkyutvx66FsfIM8eADjW4UEYt/HJ8IZknYLVzwzT/RLFq/2bpTNxzGIRFO8zHOQ8G1mFweTMSf13R4z884mshn3rAR58yYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/JHvHJuaPqs8FMuYEeP5YPhFf4FCxNnA4ToL9C85rk=;
 b=ZJ5U8Gfnfse6L4+WhX5d161QkKhQ2k7dmhG4OfgNpU04N26H0NZkip8Eb25IbzrI1pBsmnkriAVsUossdjEKfpYPKX5gA3Xs+gZ3yo90q9kz5kUHglRH+rz2x6+X3qhvLN0aQADEsbEdmmgEXo4pmkwObo6cuUBQ9UBm+nDNb0I=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB2012.namprd11.prod.outlook.com (2603:10b6:3:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 06:46:00 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 06:46:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 07/15] mtd: spi-nor: core: use dummy cycle and address
 width info from SFDP
Thread-Topic: [PATCH v13 07/15] mtd: spi-nor: core: use dummy cycle and
 address width info from SFDP
Thread-Index: AQHWlvVbrA++65RfX0GVoJcjVm7DyQ==
Date:   Wed, 30 Sep 2020 06:46:00 +0000
Message-ID: <e8e829b2-5d06-6213-c240-17f2fdb72482@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-8-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-8-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 75e89fc0-3616-4b09-1e5d-08d8650c7e2e
x-ms-traffictypediagnostic: DM5PR11MB2012:
x-microsoft-antispam-prvs: <DM5PR11MB2012A650A698EA0B74366F91F0330@DM5PR11MB2012.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QonTCDV5/adEQi0NcYHMhi3qGqcqq3MclEQw8ucda456W9AWG6O6VQgfb+uShLKD4F3TFnHLBOi4L+Z8BITCSTbV1Qkm1kagT4Or+4oN3k6YOzxIJUfYsxEuFuVcqTRNDWUOoLOyOgBeBh4Ym+C64CNwHMx2kHybx23jr6Uuylqdun9URTyYjZEPe/9nGIZ5BAJy/lgpojkE51EUsxaFyl14uDhVgAWyXZJ6Te+/VTfOMoO9nkFgTMKoIbTzdVayrk7M6LczVi2+gxvzFFA6QWM1V2fqBCNBFJic9Oq34/7hkAobW48vuUG8KecOCkUU2u5K/78Wu8hAfDHjnaNdrZ8FM5CatKmoFIcgOmC7XeL0H1gkSdCNi5NnLA8dmNdU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(86362001)(6506007)(53546011)(2616005)(36756003)(71200400001)(26005)(6486002)(5660300002)(31686004)(478600001)(186003)(316002)(31696002)(66946007)(76116006)(8676002)(66446008)(91956017)(6512007)(66556008)(66476007)(64756008)(8936002)(4326008)(110136005)(2906002)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +geH1O5Ctti+UMMgkSFXo6u8/AztUf+08oKws6OXFr8b7xt+R/pCDVU0Koye9ZXHvLdUyp/nLTvTWEj5+mSIsZJFehajB4KFN51l+wZF8Mo8vncCOwlSdW4apO2XdfNWdben4o7j94xvfUw4zAcXaYV6HwSP2wj6dwCmfoLYgL72NiV1YcIumNC/6B2QHiGq4zcwv2lug7TygO8nQ4pvTeJ3T+4ZfyGUX4SSN4485x+/YOfTYcjy6hLwjZG6LHmSZTdQAqHiFAZv2l+HGPMv2kv0pEPBWQvYrnVHQdxOsSczb0RdrG8e9aLFwc1ZGsBVH6x3gCA5Ttvwofglz1R68voRuDJ5ZJf2NW7waq7iqYd1zp5ev7zuRg9+p7ijwwbShEBqBLVczSGGb/YOHHhakK+G5vEwMseyv5Ur8RjaCqz4kMy39O2ZNXj9afrlcSvk9lGAQnYt6Vq6u+ta9ksP4rt4vs52Ep/CRjx3ry9Gn0EMQ1+j1v8tSvFA9xfPT14Ga3AuZ6TlyeR2BjpOqSMI5PIUeakv5SZPtiuBM+VDTMfEHVKCF9aXDi28WjTLXWyAU9IJaboyk+ZzsTgBWPNtsj7Ii2TNmlsObBEKOfBFuLcci145Lju2sSpFS2u3OaEzaG/U0M5jAf3WaAZmKzG9qw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C3757141C9579438C3F092F57B6E65D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e89fc0-3616-4b09-1e5d-08d8650c7e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 06:46:00.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxs8p0XXduBLvnTI8w1peNJ1En+YeZ1OCoyBHGYmZQ9XPwTuwQmnQPcgwvwKSKjSNSFYjKh5ytF8EJuzpkOQKjvnU5gEFa8tSR7bygfMI7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgeFNQSSBQcm9maWxlIDEuMCB0YWJsZSBz
cGVjaWZpZXMgaG93IG1hbnkgZHVtbXkgY3ljbGVzIGFuZCBhZGRyZXNzDQo+IGJ5dGVzIGFyZSBu
ZWVkZWQgZm9yIHRoZSBSZWFkIFN0YXR1cyBSZWdpc3RlciBjb21tYW5kIGluIG9jdGFsIERUUiBt
b2RlLg0KPiBVc2UgdGhhdCBpbmZvcm1hdGlvbiB0byBzZW5kIHRoZSBjb3JyZWN0IFJlYWQgU1Ig
Y29tbWFuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRp
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDEwICsrKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUu
Yw0KPiBpbmRleCBjYmIxYWFiMjdkMDMuLjg4YzllMTgwNjdmNCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3Jl
LmMNCj4gQEAgLTM4Myw2ICszODMsMTEgQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWRfc3Ioc3Ry
dWN0IHNwaV9ub3IgKm5vciwgdTggKnNyKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNQSV9NRU1fT1BfTk9fRFVNTVksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU1BJX01FTV9PUF9EQVRBX0lOKDEsIHNyLCAxKSk7DQo+IA0KPiArICAgICAgICAg
ICAgICAgaWYgKHNwaV9ub3JfcHJvdG9jb2xfaXNfZHRyKG5vci0+cmVnX3Byb3RvKSkgew0KDQp0
aGlzIHNob3VsZCBiZSBkb25lIGp1c3QgZm9yIG9jdGFsIGR0cg0KDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIG9wLmFkZHIubmJ5dGVzID0gbm9yLT5wYXJhbXMtPnJkc3JfYWRkcl9uYnl0ZXM7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG9wLmR1bW15Lm5ieXRlcyA9IG5vci0+cGFyYW1z
LT5yZHNyX2R1bW15Ow0KPiArICAgICAgICAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgICAgICAg
ICBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcChub3IsICZvcCwgbm9yLT5yZWdfcHJvdG8pOw0KPiAN
Cj4gICAgICAgICAgICAgICAgIHJldCA9IHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9w
KTsNCj4gQEAgLTQxNSw2ICs0MjAsMTEgQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWRfZnNyKHN0
cnVjdCBzcGlfbm9yICpub3IsIHU4ICpmc3IpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfSU4oMSwgZnNyLCAxKSk7DQo+IA0KPiArICAgICAg
ICAgICAgICAgaWYgKHNwaV9ub3JfcHJvdG9jb2xfaXNfZHRyKG5vci0+cmVnX3Byb3RvKSkgew0K
DQpzYW1lIGhlcmUNCg0KPiArICAgICAgICAgICAgICAgICAgICAgICBvcC5hZGRyLm5ieXRlcyA9
IG5vci0+cGFyYW1zLT5yZHNyX2FkZHJfbmJ5dGVzOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBvcC5kdW1teS5uYnl0ZXMgPSBub3ItPnBhcmFtcy0+cmRzcl9kdW1teTsNCj4gKyAgICAgICAg
ICAgICAgIH0NCj4gKw0KPiAgICAgICAgICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Ao
bm9yLCAmb3AsIG5vci0+cmVnX3Byb3RvKTsNCj4gDQo+ICAgICAgICAgICAgICAgICByZXQgPSBz
cGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZvcCk7DQo+IC0tDQo+IDIuMjguMA0KPiANCg0K
