Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC427E2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgI3HdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:33:01 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:1607 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3HdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601451180; x=1632987180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kW+mA5tDuHwJrs37XUczN24DFwh4b5o6HcrlfxzocZc=;
  b=POiMl+N7+InoQiYOdGv10mKC+uAQu/Gj946QJBgEWy1R5VrZ0hlB7HTL
   WbKcTFLo39ik/MDeYHxGFMQSWDNahBqKFrZBfDcfBPzPfV8rt5S9uvBWs
   pIipNke6/RVhYSY6ZB5VTV5BlYNXQ3OuG2Zvbr07vlGtQQ2uqLM4Pf/Hf
   CsDnkPYOlWpbkFdTG1fKrpeIdmdPm8wxZqs8lo9hyvZjKF2HUjUv3pJd9
   /OGtQaTGIKQKlAwndgQKpIfbRm/YIe/6kcxKAUN0oDOr1MwqE2R0sHT3B
   hb5KKaof0rz7G2t+2uYwzNxYw4iouTiEDEu81eOBBNIAoIKAJXklhVApZ
   w==;
IronPort-SDR: H2JaYZWc1L/8iTv4iKVOuXlPiQV699ElqEa8uNxyjzYFhJpCtUzGCQLYLWTtVnLbwAA0DO98qX
 b7gzbWFJLKTcbrej6orAiy+Oi+71FoOnKwxpCrpRHwxSQ+frZRAAC6P8i1VKmL+DoCp9X6xcWZ
 b1ijlvJBf0MosJ3y1ECbUZ0BjPHy9yqOHr/IB789quEPmgfLNP7sekCrG2S5vLsG8OGemJ85tW
 Jv0ojOGSTdwxZUf7tErMo9P6DwQQkHbgsNDpogTenm+QBsOjLohHH6f6TUVKW1Iwy3UzwAF6Oe
 FwM=
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="93698148"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 00:33:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 00:32:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 30 Sep 2020 00:32:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNmz6z85lcK8xHmZg6yzLi0iwou+KlPNMxQVa7pFo7Hqg34LJNglpzovKudkC++tgGil/TmQNnQlP7FNro/ZRyFFKSDBYudDTEUF/QJMEcs3qsSMaGL7YXvQe3xKfN9g63btEpoZ7qHK3SreZdwbq6atRQrTlDVYjR9gv6ueCy4v7puqLprvZyl+lakzgRemQ/G0VKR+zB01uInrQkR3Gr3dsw3aKekKZKLTMUDSuSxclJgEDFv0OwHJ1zXApbubtKQYmKHa9QRo9tf05FQ5Mosq7b1Tj4rHEkkFWaKJRLd5a1NIDK8znScwQZe0YOdyY44kfkwQnOqj7AdWHR1dAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW+mA5tDuHwJrs37XUczN24DFwh4b5o6HcrlfxzocZc=;
 b=LaP04VdPj8CbcBw9N+ug3DWOkz1GLtj/nH+1e1n0QElQYexNILAqiQQR/vwXs/u901c75OMvbObm0jS2DIRkwEH01ONV2Xr9La7pzTw9/WFe8kEAPLVms/qfMDMBfu46B4an0nylgCigb0xn4qQReKr3GFDzpb5WjvXnyyb9fQ0Bq1iovuPq+cI5XuPjbavrmKS2waB7dvk2zaLFWbdiiFuyzOBX424UpLjWPs+WFAoMkZ4ziPvv1wqTBUrpOG7BMfrORQL5qQ2niaM2u8tY+LF2QZMucpfRsRtoHW/A9UA6mnNcMi8gSI0znZGT0PKdvuE2G6nXx0Q7axWYVsOKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW+mA5tDuHwJrs37XUczN24DFwh4b5o6HcrlfxzocZc=;
 b=vYFoj2auch7AgcDV5TobHZn52TOV90GFumVRnYK+2X02CBhqoWhXLgAkISg06VHBIdq0RqzQbC3LvrBe54JDhXBpI1cr9uEiYlGFrhQVDv6bMk4jSeqp9KSa4RO0lSr+cO5Ss9Fvm7+BtRkpHzAgHTwTNI1FUBndQ21LVkfO5pQ=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Wed, 30 Sep
 2020 07:32:58 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 07:32:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 11/15] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Thread-Topic: [PATCH v13 11/15] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Thread-Index: AQHWlvvqDbIicWrKq0y8e3oO7kFq9w==
Date:   Wed, 30 Sep 2020 07:32:58 +0000
Message-ID: <a32450dc-8db3-597c-34b0-68632ac27184@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-12-p.yadav@ti.com>
 <20200929130838.4hfa2y3qoxissdus@ti.com>
In-Reply-To: <20200929130838.4hfa2y3qoxissdus@ti.com>
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
x-ms-office365-filtering-correlation-id: 952ec13c-121b-43d0-5f8d-08d865130db9
x-ms-traffictypediagnostic: DM6PR11MB4236:
x-microsoft-antispam-prvs: <DM6PR11MB423657E658BD0974F57AE153F0330@DM6PR11MB4236.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpB4Zt4ze0MLQZZF9pqM5vDnDnwdiStZSOLI19J1i3VjTPkIMcCAAn1XZd6C1Dm2h9cybbWnvaG4F7gQUNwzzS8QiH2hjWaXjLTw3LfK0T7uvyCaGJuJ442LQDeChIxJX6TxNsFfGhv8bxm5MWc8UuDCu42ZOtVSQhyILAvLuKa6/TEbeONVzukTdPk35NAYmnMSR500XgEFtj0RoM5yTM9p5lZgY6OnRfIArV9PJ0h6uGUYxzdzquXaQM05xQQtSbtwlrfHb9h61RJKkItSvgLxCZvPzFAony4O07hiBTypBvtosQYeQQ6vSCGpuoB+N0UT+Gr3DWrsDfPGib5g4ypkU954Tkzhjokq9/lZnm7jZMemzX8TbZV0PpIptYUlmkgPyTy5hbZtdHQYA5taL6/rHa3Y/BnfSs1N8iUp2hCMNVfzMLMnh0I5TJHEZJ8i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(8676002)(54906003)(66556008)(4326008)(66446008)(64756008)(66476007)(31696002)(53546011)(6506007)(8936002)(66946007)(71200400001)(36756003)(26005)(76116006)(478600001)(86362001)(186003)(5660300002)(6486002)(83380400001)(6512007)(91956017)(110136005)(2906002)(31686004)(2616005)(316002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cs7Xp3NIZRq+DObVDCbHJxfgsGo3dOneC7IvA3DzOuW+ntXAJJgXxXa8zYK5JASWZGw/b3Tk0/KIytX0QIzwGQXGxS/lUQcESKm0I6zQ10+z1mf6CRm8CWISL/HGzApii7g+6/PoOWRTgsNctAdu6YxQ7ylFRoyaSoBWfNFaoPrkYPS4NTlLHdMZnPXBQK3PY0iYfAD5J1z8U3192+upH76/3GWuOcN/krQX7hG+DaXJE/jcfx5QJsOqiXdejuyQZCmuzX0TBrR03OZTejdbz6WdRKXVmU9VlZDfNU3g2cVsIpyEM2bm4OSTCNAn5vVbc7DLrPQOaqTERL49TxXNRWsiykKLNrXYmkltO/GOJkagnz5awj2/FhEH08qd50Kc60GrdaGDaZm/zYo5zCUggt6stJMQn6NT5IBDusqF5OK/AEVSyHRyo/2P005Jgm6lLumGIxy3S7bFrXxEiyfPJymce8TS0344Fc6OLV2eOIXChXajue4e/Lrb+m0QJWDCoqSfwnVnyaRKDxEHNF11X0HGADivbHIPAsPHfhgjNOu/ZJKNNOWP+2sVJ47xUQ21w/QqRkXQolhwJ8UIdCjGcSnIwmq1pN5cYcCWkq+5/LbYYOl7dFNgapYNtLwSPPIpbECW1aZm74WAvyhiqli/jA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB8B893A61DF5A47A026EA948B66750D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952ec13c-121b-43d0-5f8d-08d865130db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:32:58.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mp5Hf5TOFT0JBE/kb3XT81tNX6rbo3zg4EXtoHs7Eh2DBn7f+WzptpOscXtkUDUI/+gp9MhIHAi+DZDjgjeCCB38UeVit4fx97cqN6HmQpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4236
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yOS8yMCA0OjA4IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxNi8wOS8yMCAwNjoxNFBNLCBQcmF0eXVz
aCBZYWRhdiB3cm90ZToNCj4+IFBlcmZvcm0gYSBTb2Z0IFJlc2V0IG9uIHNodXRkb3duIG9uIGZs
YXNoZXMgdGhhdCBzdXBwb3J0IGl0IHNvIHRoYXQgdGhlDQo+PiBmbGFzaCBjYW4gYmUgcmVzZXQg
dG8gaXRzIGluaXRpYWwgc3RhdGUgYW5kIGFueSBjb25maWd1cmF0aW9ucyBtYWRlIGJ5DQo+PiBz
cGktbm9yIChnaXZlbiB0aGF0IHRoZXkncmUgb25seSBkb25lIGluIHZvbGF0aWxlIHJlZ2lzdGVy
cykgd2lsbCBiZQ0KPj4gcmVzZXQuIFRoaXMgd2lsbCBoYW5kIGJhY2sgdGhlIGZsYXNoIGluIHBy
aXN0aW5lIHN0YXRlIGZvciBhbnkgZnVydGhlcg0KPj4gb3BlcmF0aW9ucyBvbiBpdC4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+PiAtLS0N
Cj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAgfCA0MSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+PiAgaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oIHwgIDIg
KysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuYw0KPj4gaW5kZXggNmVlOTM1NDRkNzJmLi44NTNkZmEwMmYwZGUgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmMNCj4+IEBAIC00MCw2ICs0MCw5IEBADQo+Pg0KPj4gICNkZWZpbmUgU1BJX05PUl9N
QVhfQUREUl9XSURUSCAgICAgICA0DQo+Pg0KPj4gKyNkZWZpbmUgU1BJX05PUl9TUlNUX1NMRUVQ
X01JTiAyMDANCj4+ICsjZGVmaW5lIFNQSV9OT1JfU1JTVF9TTEVFUF9NQVggNDAwDQo+PiArDQo+
PiAgLyoqDQo+PiAgICogc3BpX25vcl9nZXRfY21kX2V4dCgpIC0gR2V0IHRoZSBjb21tYW5kIG9w
Y29kZSBleHRlbnNpb24gYmFzZWQgb24gdGhlDQo+PiAgICogICAgICAgICAgICAgICAgICAgICAg
ZXh0ZW5zaW9uIHR5cGUuDQo+PiBAQCAtMzE3NCw2ICszMTc3LDQxIEBAIHN0YXRpYyBpbnQgc3Bp
X25vcl9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgICAgICByZXR1cm4gMDsNCj4+ICB9
DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIHNwaV9ub3Jfc29mdF9yZXNldChzdHJ1Y3Qgc3BpX25vciAq
bm9yKQ0KPj4gK3sNCj4+ICsgICAgIHN0cnVjdCBzcGlfbWVtX29wIG9wOw0KPj4gKyAgICAgaW50
IHJldDsNCj4+ICsNCj4+ICsgICAgIG9wID0gKHN0cnVjdCBzcGlfbWVtX29wKVNQSV9NRU1fT1Ao
U1BJX01FTV9PUF9DTUQoU1BJTk9SX09QX1NSU1RFTiwgOCksDQoNCmNhbiB3ZSBhdm9pZCB0aGUg
Y2FzdD8NCg0KPiANCj4gVGhlIGJ1c3dpZHRoIHVzZWQgaGVyZSBzaG91bGQgYmUgMSBpbnN0ZWFk
IG9mIDguIEl0IG1ha2VzIG5vIGRpZmZlcmVuY2UNCj4gaW4gcHJhY3RpY2UgYmVjYXVzZSB0aGUg
Y2FsbCB0byBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcCgpIGltbWVkaWF0ZWx5DQo+IGFmdGVyIHdp
bGwgb3Zlci13cml0ZSBpdCB0byB0aGUgY29ycmVjdCB2YWx1ZSBhbnl3YXksIGJ1dCBsZXQncyBm
b2xsb3cNCj4gdGhlIHN0eWxlIGZvbGxvd2VkIHRocm91Z2hvdXQgdGhlIHJlc3Qgb2YgdGhlIGNv
ZGViYXNlLiBXaWxsIGZpeCBpbiB0aGUNCj4gbmV4dCB2ZXJzaW9uLg0KDQpvciB5b3UgY2FuIGp1
c3Qgc2V0IHRoZSBidXN3aWR0aCB0byAwIHNvIHRoYXQgdGhlIHJlYWRlciByaXNlcyBoaXMgZXll
YnJvdw0KYW5kIHNlYXJjaCBmb3Igd2hlcmUgaXQgaXMgdXBkYXRlZC4gSWYgeW91IGxpa2UgaXQg
YmV0dGVyIHlvdSdsbCBoYXZlIHRvIGNoYW5nZQ0KdGhyb3VnaG91dCB0aGUgZW50aXJlIGNvZGUg
YmFzZSwgbWF5YmUgaW4gNC8xNSB3aGVyZSBzZXR1cF9vcCBpcyBpbnRyb2R1Y2VkLg0KDQo+IA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fRFVNTVksDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19BRERSLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIFNQSV9NRU1fT1BfTk9fREFUQSk7DQo+PiArICAgICBzcGlfbm9yX3NwaW1lbV9zZXR1cF9v
cChub3IsICZvcCwgbm9yLT5yZWdfcHJvdG8pOw0KDQpTdGlsbCBub3QgYSBiaWcgZmFuIG9mIHRo
aXMsIGJ1dCB3ZSBjYW4gdXBkYXRlIHRoZSBvcCBpbml0IGxhdGVyIG9uLiBIb3cNCmFib3V0IHNv
bWUgbmV3IGxpbmVzIGFyb3VuZCBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcCgpPyBGaXJzdCB0aW1l
IEkgcmVhZA0KdGhlIGNvZGUgSSBoYXZlbid0IHNlZW4gaXQuDQoNCj4+ICsgICAgIHJldCA9IHNw
aV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4+ICsgICAgIGlmIChyZXQpIHsNCj4+
ICsgICAgICAgICAgICAgZGV2X3dhcm4obm9yLT5kZXYsICJTb2Z0d2FyZSByZXNldCBmYWlsZWQ6
ICVkXG4iLCByZXQpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm47DQo+PiArICAgICB9DQo+PiAr
DQo+PiArICAgICBvcCA9IChzdHJ1Y3Qgc3BpX21lbV9vcClTUElfTUVNX09QKFNQSV9NRU1fT1Bf
Q01EKFNQSU5PUl9PUF9TUlNULCA4KSwNCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICBTUElfTUVNX09QX05PX0FERFIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgU1BJX01F
TV9PUF9OT19EQVRBKTsNCj4+ICsgICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgJm9w
LCBub3ItPnJlZ19wcm90byk7DQo+PiArICAgICByZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5z
cGltZW0sICZvcCk7DQo+PiArICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgIGRldl93
YXJuKG5vci0+ZGV2LCAiU29mdHdhcmUgcmVzZXQgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4+ICsg
ICAgICAgICAgICAgcmV0dXJuOw0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgLyoNCj4+ICsg
ICAgICAqIFNvZnR3YXJlIFJlc2V0IGlzIG5vdCBpbnN0YW50LCBhbmQgdGhlIGRlbGF5IHZhcmll
cyBmcm9tIGZsYXNoIHRvDQo+PiArICAgICAgKiBmbGFzaC4gTG9va2luZyBhdCBhIGZldyBmbGFz
aGVzLCBtb3N0IHJhbmdlIHNvbWV3aGVyZSBiZWxvdyAxMDANCj4+ICsgICAgICAqIG1pY3Jvc2Vj
b25kcy4gU28sIHNsZWVwIGZvciBhIHJhbmdlIG9mIDIwMC00MDAgdXMuDQo+PiArICAgICAgKi8N
Cj4+ICsgICAgIHVzbGVlcF9yYW5nZShTUElfTk9SX1NSU1RfU0xFRVBfTUlOLCBTUElfTk9SX1NS
U1RfU0xFRVBfTUFYKTsNCj4+ICt9DQo+PiArDQo+PiAgLyogbXRkIHJlc3VtZSBoYW5kbGVyICov
DQo+PiAgc3RhdGljIHZvaWQgc3BpX25vcl9yZXN1bWUoc3RydWN0IG10ZF9pbmZvICptdGQpDQo+
PiAgew0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gUHJhdHl1c2ggWWFkYXYNCj4gVGV4YXMgSW5z
dHJ1bWVudHMgSW5kaWENCj4gDQoNCg==
