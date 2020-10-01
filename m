Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6227FB95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgJAIil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:38:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:2558 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601541520; x=1633077520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5eyBYPWYCYtjUkmT2hxl4sZYifrTZD5RLu8NUMrovLM=;
  b=kF/f4tPKFNTttbz4bvEIKeFozdX4lUdYXNmmn9fux/ykTjZk/O2zSbsf
   tgHUNPJVMLcF8UBgLttA9D4o2W/kYNeY6+B1rhK8MgFazbe3ucSntg56G
   rq7kkLiCKmiKdqBzZwcdqcApPFVvIt0EskvfTdXp+JpXGN1cYzKGDUavN
   nslexF0W/0yCsfEvgj0EHhlk5qvbS90JORFMTV7NqH9EiSXKqxl/uEf41
   ORFKbkZr7L4GiWn8cSIRwdrzgcbygDVKUixrvktbZmb4kC2K9+eX5mLfX
   BwMroUSDCK6+xLpqJA1vcaa0dv8/KgCgSxt6TTYHWHnhEd4r1QCTPr/p0
   A==;
IronPort-SDR: a7i5zr1xlS/RcbQMERMzDbJE0pM3KS383TxfHcnNtVi4vSLpcXIwYP4YE6vDZWWb+BobVYVz20
 PPFkKKspyxTQzBwzooaO+o0LC5pWuZFRqaFquSNKu97fi6L9nc7tSLzhBrwGV/AqSRD6y8io1W
 j6X7gF4rFcG6okoqDF+49NNuiu+ZRqSZocWupMVr+TYf2OS5XV76CNiOyCqwxnqffHi/yy6L/6
 +SEC5yzaK46tDzIKHwi/4Csp6J42ZKbk6jmaDHV7+mxrKmggvEnCAlBD2Up/6yr7UF0rtA7znS
 uCo=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="28348614"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:38:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:38:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 01:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBQiyZtPcbGBBr4gRJzruQXKW3zWZfTJ48SkGwNUIi2WRXX3guAKvbYuI6H4uZGhmXWdOVG+OKTUcZRun/+qZMSc3h6PZ8+/T0XW1vjwKuLKSBfFjjpQGx80n485MS1zy6N+Mov4M/45ystXgEmUnvERKMOP3GzRsa2+5gVxpQYyKJwRqpeuVddIRYwaBz0WGc9IHr8Vgpi32nGV7y9Smk3C033UCRJ9/tqj8eoxSWyipN0gFEYy0eR+RNqGD0ROT5jiNSAA6YqDR+4ojbiUeRAtTNEa7MjQZuko7iEITDcKw48L2V5J8A+2UYrl7LyrzeiBZLoa8x6FOiSvGQzuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eyBYPWYCYtjUkmT2hxl4sZYifrTZD5RLu8NUMrovLM=;
 b=BL2Y3rWigvlwjdUddfPd4G3wTkqZwRXAuzAQbu4Z73IqGbncSS3N6dt0J7PzOXfJfq7lsNgM/dVAr+pDhPlggXK7oDcdS77IUsOuPTVyxyP9mdFHZ2hhvcY7VP3muwRZ4G7+jooTlTca8r4NM32nWVzIYRZiuBmu/Y3HuXoF1iIxI9oUSMUdpttp6kwRElLTtJ/cxT2XDVfKrxoR4Q6JmrERiNkafOZWea4eb3tx5ehiKKbm6uMMtNgsq1n/14wiLTyM44XZTVsSkJs1R7afQ5GFpbgjONKoIQhz4gGF/Zpvlp33JBb8ygPvYfcbOJ8R5Cm7WtJEWfgyaTwzk01ZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eyBYPWYCYtjUkmT2hxl4sZYifrTZD5RLu8NUMrovLM=;
 b=YJGhXnDKqkO8JgHg6Yv4ec2YVHPBhJ7K5+c5AuY0qpvKEHOZkFwXAXv4DofQC8mLTo1t/lQtjMSXA2TXknDpz0hQqNATWwa3HvsbKHz2q2JftBjXP7y4mpvyU8cxMCMCJNn7GxMADpbfr91ZLvImycH6GKNTZk0YyeISQ7fel5g=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB3498.namprd11.prod.outlook.com (2603:10b6:5:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 08:38:38 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:38:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 15/15] mtd: spi-nor: micron-st: allow using
 MT35XU512ABA in Octal DTR mode
Thread-Topic: [PATCH v14 15/15] mtd: spi-nor: micron-st: allow using
 MT35XU512ABA in Octal DTR mode
Thread-Index: AQHWl85BnKqqiFKj/k2EkaA2SrTTAA==
Date:   Thu, 1 Oct 2020 08:38:38 +0000
Message-ID: <dd899747-f1eb-2253-9677-8d82c9f73ea6@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-16-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-16-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 168a6a54-7902-453d-3d46-08d865e564b5
x-ms-traffictypediagnostic: DM6PR11MB3498:
x-microsoft-antispam-prvs: <DM6PR11MB3498B2C7EA0E08229D300F77F0300@DM6PR11MB3498.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWghxHQW+XRY+7T0WAVygu4z74sgBNX7vTR40+XAIYN6i7msQzceE8UAveXXHvV2Cyog9QMis4xBW8wyKLqYducMzd3/Q5geCSoKTg8Gq+WmbFKAzSqjK6t0YsY1+K3LMcj+17qGccuGxOf/m5kPcfkZhVSMUPVfZXg/F0VxccUoi5OCtSUL4t2hlthgfmNT8r3nT8K/EJeQDJqx9/kYLD/nHZL4KfccYrKsHiIKWyDeQEG0Zeb33SX6Qkw+dSn/zX/MSYcJ+0RILiLiSGOZ/SvZ7dHjjdAcI8qKLHNyWM+2gTgoFtc2Y+iDNvaih+ZZUqK1HGqLIBaYmbQb26/XB/KDtifApZptz/QJhrdcPGoLxuHQLGd0DVsykzaTvSN5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(6506007)(186003)(76116006)(36756003)(54906003)(110136005)(66946007)(316002)(66476007)(64756008)(66556008)(26005)(2906002)(6512007)(5660300002)(8676002)(71200400001)(31686004)(53546011)(91956017)(6486002)(2616005)(83380400001)(478600001)(8936002)(4326008)(66446008)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zhyq2dJMSY+J5xekKIH/sgzKY5cBhbY2J6ynrRwC/aLYXc+himGUZfRiBmPLgA+BmR9mcIdGHZCZMFg5bi9nozUDty38v0H6zecIHHVNitzrn5i4iz1/7Jx+CQjUv+pcr5+GVf/4po8uVfbB6L1qP+1vKjmJGdjwkHyMvDFGuE88eU5PyD/QWv3n6if+dw0juyc191aZYiMriRKUmlmh9zMDgKFSiSUXLazmSRtMSjenHWwfCXBRKg10vHtGlIVimz6juAHjPrwHFp6VB1P6a9wO7uHEMnW/Wq0FRb5jcYi6+OIMLawT4jadW/QKlgOw1zn1S1T8ib/ZfeYIVx4KaNqs7OWw7xP2fxdnsmg9qVJaT9Wp49wNxic79627/Sc40QDQC0iTw9dhP0FxdoVwIIZJSDm2+hJH2t677TGAdYjMdWwYnJ2l0x1gdM+/T5umltXJun9W0FXWol7LNwfqqYkt5i/ZXfRpL1eZoEqzDYUty4w+MB1ZCjUur0UCvQsWkbvjqjY6rqHQrRaEhcnKT6A9XBI6GWHRJDxkDXEXjKTunZL+gTg258Bsd6eT+Zq3j8U/zkjz1rtQsZ9mOPofQ3LpInSS4QL7iGrWUf76SxeunYQ8Uy5BifnwPG2UFC2VdCJRFhb7Zrt+RISCxrwnqQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5FF6A9D2F35174FBAE831E513CFE84B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168a6a54-7902-453d-3d46-08d865e564b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:38:38.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVKiQo/vAMZoVyE3Ac+n9+xLv73jeS3B6zNH9qeQ0vJ7zFvHJJLNrzoReEKCTC6sQ/hpJGico6eazRIbBN7jYywgOWrALv2hwd5/21X1VVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3498
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTaW5jZSB0aGlzIGZsYXNoIGRvZXNuJ3QgaGF2
ZSBhIFByb2ZpbGUgMS4wIHRhYmxlLCB0aGUgT2N0YWwgRFRSDQo+IGNhcGFiaWxpdGllcyBhcmUg
ZW5hYmxlZCBpbiB0aGUgcG9zdCBTRkRQIGZpeHVwLCBhbG9uZyB3aXRoIHRoZSA4RC04RC04RA0K
PiBmYXN0IHJlYWQgc2V0dGluZ3MuDQo+IA0KPiBFbmFibGUgT2N0YWwgRFRSIG1vZGUgd2l0aCAy
MCBkdW1teSBjeWNsZXMgdG8gYWxsb3cgcnVubmluZyBhdCB0aGUNCj4gbWF4aW11bSBzdXBwb3J0
ZWQgZnJlcXVlbmN5IG9mIDIwME1oei4NCj4gDQo+IFRoZSBmbGFzaCBzdXBwb3J0cyB0aGUgc29m
dCByZXNldCBzZXF1ZW5jZS4gU28sIGFkZCB0aGUgZmxhZyBpbiB0aGUNCj4gZmxhc2gncyBpbmZv
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMgfCAxMDAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5OSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5v
ci9taWNyb24tc3QuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4gaW5kZXgg
ZWYzNjk1MDgwNzEwLi5iMDAwMmMyOWZkMzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvbWljcm9uLXN0LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3Qu
Yw0KPiBAQCAtOCwxMCArOCwxMDggQEANCj4gDQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiANCj4g
KyNkZWZpbmUgU1BJTk9SX09QX01UX0RUUl9SRCAgICAweGZkICAgIC8qIEZhc3QgUmVhZCBvcGNv
ZGUgaW4gRFRSIG1vZGUgKi8NCj4gKyNkZWZpbmUgU1BJTk9SX09QX01UX1JEX0FOWV9SRUcgICAg
ICAgIDB4ODUgICAgLyogUmVhZCB2b2xhdGlsZSByZWdpc3RlciAqLw0KPiArI2RlZmluZSBTUElO
T1JfT1BfTVRfV1JfQU5ZX1JFRyAgICAgICAgMHg4MSAgICAvKiBXcml0ZSB2b2xhdGlsZSByZWdp
c3RlciAqLw0KPiArI2RlZmluZSBTUElOT1JfUkVHX01UX0NGUjBWICAgIDB4MDAgICAgLyogRm9y
IHNldHRpbmcgb2N0YWwgRFRSIG1vZGUgKi8NCj4gKyNkZWZpbmUgU1BJTk9SX1JFR19NVF9DRlIx
ViAgICAweDAxICAgIC8qIEZvciBzZXR0aW5nIGR1bW15IGN5Y2xlcyAqLw0KPiArI2RlZmluZSBT
UElOT1JfTVRfT0NUX0RUUiAgICAgIDB4ZTcgICAgLyogRW5hYmxlIE9jdGFsIERUUi4gKi8NCj4g
KyNkZWZpbmUgU1BJTk9SX01UX0VYU1BJICAgICAgICAgICAgICAgIDB4ZmYgICAgLyogRW5hYmxl
IEV4dGVuZGVkIFNQSSAoZGVmYXVsdCkgKi8NCj4gKw0KPiArc3RhdGljIGludCBzcGlfbm9yX21p
Y3Jvbl9vY3RhbF9kdHJfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKQ0K
PiArew0KPiArICAgICAgIHN0cnVjdCBzcGlfbWVtX29wIG9wOw0KPiArICAgICAgIHU4ICpidWYg
PSBub3ItPmJvdW5jZWJ1ZjsNCj4gKyAgICAgICBpbnQgcmV0Ow0KPiArDQo+ICsgICAgICAgaWYg
KGVuYWJsZSkgew0KPiArICAgICAgICAgICAgICAgLyogVXNlIDIwIGR1bW15IGN5Y2xlcyBmb3Ig
bWVtb3J5IGFycmF5IHJlYWRzLiAqLw0KPiArICAgICAgICAgICAgICAgcmV0ID0gc3BpX25vcl93
cml0ZV9lbmFibGUobm9yKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICpidWYg
PSAyMDsNCj4gKyAgICAgICAgICAgICAgIG9wID0gKHN0cnVjdCBzcGlfbWVtX29wKQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9N
VF9XUl9BTllfUkVHLCAxKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBT
UElfTUVNX09QX0FERFIoMywgU1BJTk9SX1JFR19NVF9DRlIxViwgMSksDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfT1VUKDEsIGJ1ZiwgMSkp
Ow0KPiArDQo+ICsgICAgICAgICAgICAgICByZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGlt
ZW0sICZvcCk7DQo+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICsgICAgICAgICAgICAgICByZXQgPSBzcGlfbm9y
X3dhaXRfdGlsbF9yZWFkeShub3IpOw0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAg
ICAgICByZXQgPSBzcGlfbm9yX3dyaXRlX2VuYWJsZShub3IpOw0KPiArICAgICAgIGlmIChyZXQp
DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICsgICAgICAgaWYgKGVuYWJs
ZSkNCj4gKyAgICAgICAgICAgICAgICpidWYgPSBTUElOT1JfTVRfT0NUX0RUUjsNCj4gKyAgICAg
ICBlbHNlDQo+ICsgICAgICAgICAgICAgICAqYnVmID0gU1BJTk9SX01UX0VYU1BJOw0KPiArDQo+
ICsgICAgICAgb3AgPSAoc3RydWN0IHNwaV9tZW1fb3ApDQo+ICsgICAgICAgICAgICAgICBTUElf
TUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9NVF9XUl9BTllfUkVHLCAxKSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9BRERSKGVuYWJsZSA/IDMgOiA0LA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJTk9SX1JFR19N
VF9DRlIwViwgMSksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9f
RFVNTVksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfREFUQV9PVVQo
MSwgYnVmLCAxKSk7DQo+ICsNCj4gKyAgICAgICBpZiAoIWVuYWJsZSkNCj4gKyAgICAgICAgICAg
ICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgJm9wLCBTTk9SX1BST1RPXzhfOF84X0RU
Uik7DQo+ICsNCj4gKyAgICAgICByZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZv
cCk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ICsNCj4gKyAgICAgICAvKiBHaXZlIHNvbWUgdGltZSBmb3IgdGhlIG1vZGUgY2hhbmdlIHRvIHRh
a2UgcGxhY2UuICovDQo+ICsgICAgICAgdXNsZWVwX3JhbmdlKDQwMCwgNjAwKTsNCg0KRG9uJ3Qg
d2UgbmVlZCB0byBzdGlsbCByZWFkIHRoZSBTdGF0dXMgUmVnaXN0ZXIgaGVyZT8gVGhlIHNhbWUg
cXVlc3Rpb24NCmFwcGxpZXMgZm9yIHRoZSBwcmV2aW91cyBwYXRjaC4NCg0KPiArDQo+ICsgICAg
ICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10MzV4dTUxMmFiYV9kZWZh
dWx0X2luaXQoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gK3sNCj4gKyAgICAgICBub3ItPnBhcmFt
cy0+b2N0YWxfZHRyX2VuYWJsZSA9IHNwaV9ub3JfbWljcm9uX29jdGFsX2R0cl9lbmFibGU7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10MzV4dTUxMmFiYV9wb3N0X3NmZHBfZml4dXAoc3Ry
dWN0IHNwaV9ub3IgKm5vcikNCj4gK3sNCj4gKyAgICAgICAvKiBTZXQgdGhlIEZhc3QgUmVhZCBz
ZXR0aW5ncy4gKi8NCj4gKyAgICAgICBub3ItPnBhcmFtcy0+aHdjYXBzLm1hc2sgfD0gU05PUl9I
V0NBUFNfUkVBRF84XzhfOF9EVFI7DQo+ICsgICAgICAgc3BpX25vcl9zZXRfcmVhZF9zZXR0aW5n
cygmbm9yLT5wYXJhbXMtPnJlYWRzW1NOT1JfQ01EX1JFQURfOF84XzhfRFRSXSwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIDIwLCBTUElOT1JfT1BfTVRfRFRSX1JELA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU05PUl9QUk9UT184XzhfOF9EVFIp
Ow0KPiArDQo+ICsgICAgICAgbm9yLT5jbWRfZXh0X3R5cGUgPSBTUElfTk9SX0VYVF9SRVBFQVQ7
DQo+ICsgICAgICAgbm9yLT5wYXJhbXMtPnJkc3JfZHVtbXkgPSA4Ow0KPiArICAgICAgIG5vci0+
cGFyYW1zLT5yZHNyX2FkZHJfbmJ5dGVzID0gMDsNCj4gKw0KPiArICAgICAgIC8qDQo+ICsgICAg
ICAgICogVGhlIEJGUFQgcXVhZCBlbmFibGUgZmllbGQgaXMgc2V0IHRvIGEgcmVzZXJ2ZWQgdmFs
dWUgc28gdGhlIHF1YWQNCj4gKyAgICAgICAgKiBlbmFibGUgZnVuY3Rpb24gaXMgaWdub3JlZCBi
eSBzcGlfbm9yX3BhcnNlX2JmcHQoKS4gTWFrZSBzdXJlIHdlDQo+ICsgICAgICAgICogZGlzYWJs
ZSBpdC4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBub3ItPnBhcmFtcy0+cXVhZF9lbmFibGUg
PSBOVUxMOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHNwaV9ub3JfZml4dXBzIG10MzV4
dTUxMmFiYV9maXh1cHMgPSB7DQo+ICsgICAgICAgLmRlZmF1bHRfaW5pdCA9IG10MzV4dTUxMmFi
YV9kZWZhdWx0X2luaXQsDQo+ICsgICAgICAgLnBvc3Rfc2ZkcCA9IG10MzV4dTUxMmFiYV9wb3N0
X3NmZHBfZml4dXAsDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2lu
Zm8gbWljcm9uX3BhcnRzW10gPSB7DQo+ICAgICAgICAgeyAibXQzNXh1NTEyYWJhIiwgSU5GTygw
eDJjNWIxYSwgMCwgMTI4ICogMTAyNCwgNTEyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgU0VDVF80SyB8IFVTRV9GU1IgfCBTUElfTk9SX09DVEFMX1JFQUQgfA0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU1BJX05PUl80Ql9PUENPREVTKSB9LA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU1BJX05PUl80Ql9PUENPREVTIHwgU1BJX05PUl9PQ1RB
TF9EVFJfUkVBRCB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX09D
VEFMX0RUUl9QUCB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0lP
X01PREVfRU5fVk9MQVRJTEUpDQo+ICsgICAgICAgICAuZml4dXBzID0gJm10MzV4dTUxMmFiYV9m
aXh1cHN9LA0KPiAgICAgICAgIHsgIm10MzV4dTAyZyIsIElORk8oMHgyYzViMWMsIDAsIDEyOCAq
IDEwMjQsIDIwNDgsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTRUNUXzRLIHwgVVNF
X0ZTUiB8IFNQSV9OT1JfT0NUQUxfUkVBRCB8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBTUElfTk9SXzRCX09QQ09ERVMpIH0sDQo+IC0tDQo+IDIuMjguMA0KPiANCg0K
