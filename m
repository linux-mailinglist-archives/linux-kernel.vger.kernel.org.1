Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5927EA83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgI3OAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:00:15 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:57927 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgI3OAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601474414; x=1633010414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w8IUo3ZMtqczMcCy7KpgXL3ZdJqyyK6UKI6WtcFytjc=;
  b=VrZEfuTz5SKBvDeQ78tr977fRjJG+H+7sHLvF6wq23ag79kIrEHSFYgZ
   wm/TqZSl7hXouCIvgeKKAWFFfh55PjSU0QmpFPsntcKYIAUZQhhks56u9
   u6R3ySd7vXZomFXQ7U7n30a3jwtK8gFmcJl4w10hY2LS8uTtfNBADaBhL
   ZP1UZccaSDoMfVVRpQc43iD7e6qc42wnu5Ync8V9JLxAzf7bUHvOoFoYs
   PwlDuULz0uILSYrgD8Ty6p2G/DiLH52uIkrUxRqQOlfzZMPTIgrOj03mb
   DwbPdTobBiFYvKciH5vsHpEE6H44/dnF1MiUMrcvPUoFt9TfvQ/Ficq4f
   g==;
IronPort-SDR: PC/crVOLn4I9eauB9+HN/XMXgmbrzeXJgNjNzK8IxsE0OAZXXibTCGLYO83lzcQQI0rg1Ea+bV
 InjZZ5Kma4dCuIjN8J52Nh6ON39JCzmTHqmU8P/8ExNrXiteiAcY3Evq6UjJwDLagHrypdCqlI
 06dDBm6Anjh074wMYuUL9JIvv9sZ3JOTEA3wRXXtrsHWVn0HIbrhgzx8T1tf8f1ZgpxFXA8/GY
 G1Rt8XhLgkxURy08KQ3eR9kE4PPqvHXuPgLieng+O8pgUQNFIHIL2kdoIrq2GxER1HdEDax5M8
 XWQ=
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="90946062"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 07:00:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 07:00:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 30 Sep 2020 07:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noLRV6WBJaYAwLVQOyeLH+GGtYfqie/lio5EXeRuKa6noRR35fIp7WhcQeQu/AE0cK1tpBuHJW/qevzU1bZ4LVtzQOmno1ObtXcgxQVSW7qElbmZVRcoU+JoLYqlXs7Tpy78s2bTL6qf4avWL2OfH45v4NW13G3ioCiVddyu/AN/INAKlcGeTOm4SvI9Ona9m6vsRDk6l+9UWZuz0R3US50jTqH1x+17IYm6mO9+E4aztvZck+gtgRQFa4k8ICn15VVJ344ZIamMWZg572uvfLkf+VKhrTFPgVjQqF2vE+o9vVCXNIJhfbaAtpBDjDR+mUWWAcwg7uacQ745oZxPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8IUo3ZMtqczMcCy7KpgXL3ZdJqyyK6UKI6WtcFytjc=;
 b=lpg1K6DWMJuw+FpxuJWKXW+ocaCFKvuoIXQpujWpkF3vB16MaboMhJcg6PRfkwJgrd/1grYKYa+nRbw+mUv9ChyWaocEVMaRaYP65D51uKc3nN8iCZcsbwitTAmFCcrO5kYUnA2wR3lrb8ehnz/bvNFLUIHsjP9I9KGINanL3Za5SRIP1dD2n+E6+WDrsaiCJUX5bHklBzOUaRjmpKipXX5o2uQ4NBb8O4MJzc7u2VVr7cLtqMrM1rHeEELo8PWwLbl+//36+F1BYKL3tUQP7Qd9VkuC1/2Xo3lHAZidMY92JcRGmIRUpHuk1SOmhyfZDjPZ8w0uSIBshgKKv9JLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8IUo3ZMtqczMcCy7KpgXL3ZdJqyyK6UKI6WtcFytjc=;
 b=GE3i/W1iFC8dACGbaK0RAkNJhE84WLLIAq9iKlk46PqP1quKegd6Q7m6WzBWDa1zbOjdk9ZKFRBVpSWMt0XbdUPigjpyJJtQfM9/h5tp6njwjSNjPfFhxa53+ShapBVwm4DlphGemb70LU/SM4zFIPRnqgMjWoXmK6yYd/Oq1zA=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM5PR11MB1418.namprd11.prod.outlook.com (10.168.102.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Wed, 30 Sep 2020 14:00:11 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 14:00:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vigneshr@ti.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Topic: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Index: AQHWlzICH6PibhncD0qfQu8hdLJMbA==
Date:   Wed, 30 Sep 2020 14:00:11 +0000
Message-ID: <e56c5f60-2f59-f913-6eea-3bf8dd4c0774@microchip.com>
References: <20200327155939.13153-1-michael@walle.cc>
In-Reply-To: <20200327155939.13153-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f7587b-a26e-4d7b-0f98-08d8654925cc
x-ms-traffictypediagnostic: DM5PR11MB1418:
x-microsoft-antispam-prvs: <DM5PR11MB1418D14AB255BBF090CB081FF0330@DM5PR11MB1418.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 987S8sDTvT8tY+iONOq0OdZnU3LdQF7Fk61ZNp7RJeOUXsNMeKarcwBwUCLRDdQ+b3a0IMWnUTPwtOB9IdoP04pWqq6b8XlYwz2C+vXae+vn238FGJv+/7OaK15xZlrvqvi1CibKPboPNIoDBTDz+61SBM0l8I/zGdIeCs8V4wnNpslw9EZTysIYbDgh+CCE7hq8Cyu1JcBm+e1k4F51COMPqUKAOmc2prFizWhVXAo6g/6ggeGfp1xhxk3eda3tYh27ri7PAdv1CJLuOmWkfhvzAxnXx9UOWtIDqda0pKL8sUq7jl6FEYvbz9H4K7hZZ/qujgMRaqG5j3BrT+5lmN8/v4Sm/2U46hx/Z1hokc1Xv+zZS/kgTDVoI+gywiis
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(39860400002)(366004)(4326008)(53546011)(6506007)(6486002)(186003)(8936002)(26005)(36756003)(6512007)(8676002)(31696002)(86362001)(66946007)(91956017)(64756008)(66446008)(66556008)(66476007)(478600001)(76116006)(5660300002)(71200400001)(2616005)(54906003)(110136005)(316002)(2906002)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RRPN7b6SEFnH7h4FYoBIaBM1Drm9BAELaclxLCIwRFVjAYG7RcNJRiG9MKpW5IFJk474U7GgAYVnDW4A0uzWWQG22e58lVN+tS6ia+FvLt4auocKKponhi3iNqBD5IQ339AhI+6kVliGfjH/pfYi4cPHopMqGSFdlO9glFaEMmuKZMm7JTG0rrVQbZhdjbI1ibVWFApY/syUgvo+iKmr+1ClCBKZV+XvKn/paCHrJX7iB/jb9Ca7qrJXt6dA4aVGNhb0pmeQrKXRlq3xoTvKzmMRmhCwTgzsDwI3Dwl0Dxk1H0cP3CAyOcMrEKXmfotAI2DKHjhTlfwpDjBgFNpncdTGd7qIruQuq+Aoc0ACCvYkWGYPDT3uLUPIYn3gUeS8qR5UQHLqIyVfuH8pL0EAb694mWPw/amgQgoi98pQ4QqfvHLikk0Z+w74GOhmcXzAAoXcPSCWkXm6JjMmeEgoxt37QohlfrP/pUPvgj6GsXJlDcHhCrdeINHjR0t30tIC/7yUeUMvx+gKDwQtNP5CIYOOF0ppvz6EyhOoxRvW0riOdmMoK2HhC8YFBSb8MqSlJ87riQaib3YZkl6AMeC3sH6ym+Fw61JWj4y3WDqavZjEBynmc8AA08KCqCrooP7YpNNgqSs0ruH8JLw6QqQ9hQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3B4314CE1C2E64188B7E3BC84C35BF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f7587b-a26e-4d7b-0f98-08d8654925cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 14:00:11.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qMXv6Tlwo2w6eZS2IcScLBnpAhBEgah5ACLTyxb6xwENEXJQK6Yr+xc0z6K4XJ1GJuuZeN/jknxixFo6ESW+k2Obg5sZN92SQ6lA3yEfcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1418
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1pY2hhZWwsDQoNClBMZWFzZSBhY2NlcHQgbXkgYXBvbG9naWVzIGZvciB0aGUgbG9uZyBk
ZWxheS4NCg0KSSBkbyBhZ3JlZSB3aXRoIFZpZ25lc2gncyBjb21tZW50cy4gRmV3IG90aGVycyBi
ZWxvdy4NCg0KT24gMy8yNy8yMCA1OjU5IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KDQpbY3V0
XQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4IGNjNjhlYTg0MzE4ZS4uZmQxYzM2ZDcwYTEzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMjkxNiwyMCArMjkxNiwzOCBAQCBzdGF0aWMgaW50
IHNwaV9ub3JfcXVhZF9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gIH0NCj4gIA0KPiAg
LyoqDQo+IC0gKiBzcGlfbm9yX3VubG9ja19hbGwoKSAtIFVubG9ja3MgdGhlIGVudGlyZSBmbGFz
aCBtZW1vcnkgYXJyYXkuDQo+ICsgKiBzcGlfbm9yX2dsb2JhbF91bnByb3RlY3QoKSAtIFBlcmZv
cm0gYSBnbG9iYWwgdW5wcm90ZWN0IG9mIHRoZSBtZW1vcnkgYXJlYS4NCj4gICAqIEBub3I6CXBv
aW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InLg0KPiAgICoNCj4gICAqIFNvbWUgU1BJIE5PUiBm
bGFzaGVzIGFyZSB3cml0ZSBwcm90ZWN0ZWQgYnkgZGVmYXVsdCBhZnRlciBhIHBvd2VyLW9uIHJl
c2V0DQo+ICAgKiBjeWNsZSwgaW4gb3JkZXIgdG8gYXZvaWQgaW5hZHZlcnRlbnQgd3JpdGVzIGR1
cmluZyBwb3dlci11cC4gQmFja3dhcmQNCj4gICAqIGNvbXBhdGliaWxpdHkgaW1wb3NlcyB0byB1
bmxvY2sgdGhlIGVudGlyZSBmbGFzaCBtZW1vcnkgYXJyYXkgYXQgcG93ZXItdXANCj4gLSAqIGJ5
IGRlZmF1bHQuDQo+ICsgKiBieSBkZWZhdWx0LiBEbyBpdCBvbmx5IGZvciBmbGFzaGVzIHdoZXJl
IHRoZSBibG9jayBwcm90ZWN0aW9uIGJpdHMNCj4gKyAqIGFyZSB2b2xhdGlsZSwgdGhpcyBpcyBp
bmRpY2F0ZWQgYnkgU05PUl9GX05FRURfVU5QUk9URUNULg0KPiArICoNCj4gKyAqIFdlIGNhbm5v
dCB1c2Ugc3BpX25vcl91bmxvY2sobm9yLT5wYXJhbXMuc2l6ZSkgaGVyZSBiZWNhdXNlIHRoZXJl
IGFyZQ0KPiArICogbGVnYWN5IGRldmljZXMgKGVnLiBBVDI1REYwNDFBKSB3aGljaCBuZWVkIGEg
Imdsb2JhbCB1bnByb3RlY3QiIGNvbW1hbmQuDQo+ICsgKiBUaGlzIGlzIGRvbmUgYnkgd3JpdGlu
ZyAwYjB4MDAwMHh4IHRvIHRoZSBzdGF0dXMgcmVnaXN0ZXIuIFRoaXMgd2lsbCBhbHNvDQo+ICsg
KiB3b3JrIGZvciBhbGwgb3RoZXIgZmxhc2hlcyB3aGljaCBoYXZlIHRoZXNlIGJpdHMgbWFwcGVk
IHRvIEJQMCB0byBCUDMuDQo+ICsgKiBUaGUgdG9wIG1vc3QgYml0IGlzIHVzdXNhbGx5IHNvbWUg
a2luZCBvZiBsb2NrIGJpdCBmb3IgdGhlIGJsb2NrDQo+ICsgKiBwcm90ZWN0aW9uIGJpdHMuDQo+
ICAgKi8NCj4gLXN0YXRpYyBpbnQgc3BpX25vcl91bmxvY2tfYWxsKHN0cnVjdCBzcGlfbm9yICpu
b3IpDQo+ICtzdGF0aWMgaW50IHNwaV9ub3JfZ2xvYmFsX3VucHJvdGVjdChzdHJ1Y3Qgc3BpX25v
ciAqbm9yKQ0KPiAgew0KPiAtCWlmIChub3ItPmZsYWdzICYgU05PUl9GX0hBU19MT0NLKQ0KPiAt
CQlyZXR1cm4gc3BpX25vcl91bmxvY2soJm5vci0+bXRkLCAwLCBub3ItPnBhcmFtcy0+c2l6ZSk7
DQo+ICsJaW50IHJldDsNCj4gIA0KPiAtCXJldHVybiAwOw0KPiArCWRldl9kYmcobm9yLT5kZXYs
ICJ1bnByb3RlY3RpbmcgZW50aXJlIGZsYXNoXG4iKTsNCj4gKwlyZXQgPSBzcGlfbm9yX3JlYWRf
c3Iobm9yLCBub3ItPmJvdW5jZWJ1Zik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gKw0KPiArCW5vci0+Ym91bmNlYnVmWzBdICY9IH5TUl9HTE9CQUxfVU5QUk9URUNUX01BU0s7
DQo+ICsNCj4gKwkvKg0KPiArCSAqIERvbid0IHVzZSBzcGlfbm9yX3dyaXRlX3NyMV9hbmRfY2hl
Y2soKSBiZWNhdXNlIHdyaXRpbmcgdGhlIHN0YXR1cw0KPiArCSAqIHJlZ2lzdGVyIG1pZ2h0IGZh
aWwgaWYgdGhlIGZsYXNoIGlzIGhhcmR3YXJlIHdyaXRlIHByb3RlY3RlZC4NCj4gKwkgKi8NCj4g
KwlyZXR1cm4gc3BpX25vcl93cml0ZV9zcihub3IsIG5vci0+Ym91bmNlYnVmLCAxKTsNCj4gIH0N
Cg0KVGhpcyB3b24ndCB3b3JrIGZvciBhbGwgdGhlIGZsYXNoZXMuIFlvdSB1c2UgYSBHRU5NQVNL
KDUsIDIpIHRvIGNsZWFyDQp0aGUgU3RhdHVzIFJlZ2lzdGVyIGV2ZW4gZm9yIEJQMC0yIGZsYXNo
ZXMgYW5kIHlvdSBlbmQgdXAgY2xlYXJpbmcgQklUKDUpDQp3aGljaCBjYW4gbGVhZCB0byBzaWRl
IGVmZmVjdHMuDQoNCldlIHNob3VsZCBpbnN0ZWFkIGludHJvZHVjZSBhIG5vci0+cGFyYW1zLT5s
b2NraW5nX29wcy0+Z2xvYmFsX3VubG9jaygpIGhvb2sNCmZvciB0aGUgZmxhc2hlcyB0aGF0IGhh
dmUgc3BlY2lhbCBvcGNvZGVzIHRoYXQgdW5sb2NrIGFsbCB0aGUgZmxhc2ggYmxvY2tzLA0Kb3Ig
Zm9yIHRoZSBmbGFzaGVzIHRoYXQgZGV2aWF0ZSBmcm9tIHRoZSAiY2xlYXIganVzdCB5b3VyIEJQ
IGJpdHMiIHJ1bGUuDQoNCnlvdSBjYW4ga2VlcCB0aGUgY2FsbCB0byBzcGlfbm9yX3VubG9jaygm
bm9yLT5tdGQsIDAsIG5vci0+cGFyYW1zLT5zaXplKTsNCmFuZCBpbiBzcGlfbm9yX3VubG9jaygp
IGRvOg0KDQppZiAobGVuID09IG5vci0+cGFyYW1zLT5zaXplICYmIG5vci0+cGFyYW1zLT5sb2Nr
aW5nX29wcy0+Z2xvYmFsX3VubG9jaykNCglyZXQgPSBub3ItPnBhcmFtcy0+bG9ja2luZ19vcHMt
Pmdsb2JhbF91bmxvY2sobm9yKQ0KZWxzZQ0KCXJldCA9IG5vci0+cGFyYW1zLT5sb2NraW5nX29w
cy0+dW5sb2NrKG5vciwgb2ZzLCBsZW4pOw0KDQpDaGVlcnMsDQp0YQ0KCQ0K
