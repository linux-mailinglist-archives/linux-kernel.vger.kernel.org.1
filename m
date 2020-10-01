Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0427FB6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgJAIXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:23:52 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51677 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601540631; x=1633076631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B8J5rK2/XYJDmR7RVtKKn3wpj2o1HPPduV6zGiusOeU=;
  b=tsU652MtUZEW1Xs/A337Z681Zjy47plKKmCFczgoDoVAJzZRNRuqHL2X
   Br/Ie3StrT4XrWFmf89GFq12GhoI3ik3UhXVK9vWpch+n28e4flv+8l6n
   k/1MslLMAupfO01Fe8jDVPqailG0Uj2jaoWakV+ABhPfmzxmEoGD8PCHd
   euDzxMMwMS2EcugOetAmNlkeYKzzxDjT2mAORlhU5jkUl2CyDv+uTBwIc
   mwfvS24Jgtcxa4YkFeFbC6Dfz1vT1xGkXyHTsJkUaZXZuaevVCY1z8x4f
   JtmSuAJZzb8hGmleSe8ykt+mmN6oKb9IFqQvEKJAR862CMNBDM7NtXxi/
   A==;
IronPort-SDR: 3HqHglg9mfdNvMl44YogJQikBNw2pATPoDzVc9CvjAB31bzyqjlD6oAB8+y3GAwwt8Jn/OYmqZ
 uecOcgSzBTn+/2mExaS+n/dqj0H+I7liBtkVHiV9yQOSzZjKJWXCBRGUbxHyPvbfdBoM+CZ8vf
 4GE/mrgC9DkAtZ6Nm+eLr9vCxgP0HmZ3Obu4kdgRhnpOeckOHsuthgzHYamGcxm+xJaktrLR2l
 Qk/Eg9S1RvJeLN7B57tj3+WqgSHovH0TGrsbo1lwPZpKXzlQAPqIgizLO9ssLZKdsnJejVUP1W
 es0=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="97880777"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:23:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:23:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 01:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQEVVUAeDf0oUQO/gkvYPJidcl8xCiUjlIv+ECBx47x+Zap2BFdknNAdmgdCMsEIxDhobHZ+aCvLwfY6GNoe87P+xrb24yKxDk0K96/LaRHsfFyEoymFf+du6psO1wDd7cGV99FJ946cJvi4uUXJteD38v3BjfvojyvkqAe3iUZ65gKS3HhxNLNmBUqylUGzaIhjqSmDyyvht4azsSxduKLH9ss8E/wf5FiH4V0sfMP0CufnbvoJckAH2ELFWplMB9bw0y06rEUCEXjIwACO5foUSiqYun5f17Lh8o5gHJFaJhp7XtbIh60DWoFqyw+y0y1eM6xAFasOkSruJCwKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8J5rK2/XYJDmR7RVtKKn3wpj2o1HPPduV6zGiusOeU=;
 b=BkuOtfhrqykfdAbeEXTwQIcvQcBxfJ7ffJ5q93Ig57ztKcSY862vAsyY3hFYXGSLXULm4O1hMAxMhg8PiFPEvGD9jxIOJtWrB0vKLA6/cY1/1A7erNn+ojZwydDaEavyG0HsfBKBfqjha+JNHfASWdwi4D+0U1bGaX6cZVnHsKLf217uCSbC3HP0Gtm+HssOz79OGlIU1MkLoIjady/GyHHSajUZxy8FZh1w+BDmUwiGyAnOXjC6I6u1x1vJdQJhHedcRmXvdsJg89pZ65Y+Ynpfq+jRpMCE1tPBPBWfRJ9FTBKsF5jRnnqJw2LulLGwIEuziErT4trn57PA3APgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8J5rK2/XYJDmR7RVtKKn3wpj2o1HPPduV6zGiusOeU=;
 b=m+9oM/CHgeQKm4v6FiyOw3CsNUf5cr4qdt5t19Bi7ZA2QfkqtmbOXuNtjupqQM1+Hqg0bjru1CCdbW3t6mvX0NNNoHq/UU4FhdXHgexYO19QO/fc03fPPfxTXkqfq+YES3+/TJb2qL/AL4inD5mB/nk+QqtpAM3EaEUvZ09swds=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1947.namprd11.prod.outlook.com (2603:10b6:3:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 08:23:49 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:23:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 12/15] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Thread-Topic: [PATCH v14 12/15] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Thread-Index: AQHWl8wvt1pUh+Hm6UeGalF6SyDG5Q==
Date:   Thu, 1 Oct 2020 08:23:48 +0000
Message-ID: <c1f8eadb-640c-1299-c075-946a3aeb98a5@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-13-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-13-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 32a73576-2a60-4a8d-4bcc-08d865e3528c
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB1947FE72D3521236E7D7CEBFF0300@DM5PR11MB1947.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCOWuUXYwuyImxlfT1dD2xfuaQ+EDcAJN36Bdqp6KlV0RBE3NoTzXH/yY5/9Nqf0ZFvdK7YZ+9s0fRNYDABsDmDQHQppf5VV6w5i7IylcA+6/qF5hO8xdbXN6K3HjNkEBFI4CrHsUBw5KX+3vOtQCxI4fAPN/utkaW/VOIcY5zslGvmJYRk1bokWHoc2BpjJ9EufM6neYtlvdlh5mZbBPB1mdJ2+SSaXK0afBwsd0yiUPGSARPPjF+1WoE3Lr5a1753btjMQtkKpFPmPokuJ0aS5YboIBzQa2bgMhY1GAA/AndR+dhD9TgmvfO0Sq9Xz6u6DXMQxhn05W2Q5YFkj9tukxm+JiutBs7D6HlWZqkGo19qxHTKucERvitg+Hgt6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(4326008)(66946007)(478600001)(64756008)(66556008)(316002)(66476007)(71200400001)(91956017)(186003)(110136005)(2906002)(76116006)(86362001)(66446008)(36756003)(26005)(2616005)(6506007)(5660300002)(53546011)(31696002)(8936002)(31686004)(83380400001)(6512007)(6486002)(8676002)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hApl2afoJ+0WTSHQ/eNemvOrt+MPBlizVPlx5FF5QNUpdzdz9/Lq9/GrBNOxNoFckXD5lwoozhphVyAhGEJDwHaPi3U5wnSNtq+Nf0m/NOj4hjezxixslKIRa/5ReG34UgATta/KQSzdXGJzusP4ar1wuuTOHSQjwwTlFBa6D/Hekek+IC7kGFgUhh6qyGuF08Yok5Gf76oJ+pygef3yqstYlZ4XiFTLwdf5gVvrArYaHY3/TXDGEqI6m2oQ3zB1jjoKj4WfY1T1+OsuraP7ifIBmKvKXV8ptP6Ey8PjuMsOe3jSA2SNLjAFKxVNKMVfKFTAqX0hL4Fy1lkOYrODZwYiTEb1LPJ7mmuTsGBdHb1aiUTkbAQWrHaes04e9kNSUFep3VRCiuaT1saWJFa2ElPuWLX0kObbJ6i7n3V81sJYEtdtfj/KeStAiHSAFykw4XHHuIBPtA5j3EXoLdwKFRoW8hVFqSglGRlTIipuB9yRN+K3HTr6SlUMn7XNOrdxohHaHSvAJrAwzLl69LJ3neHTpFPQZMJ46mQZYU/nNRl4zd2eipz0tpHg92Cj8lDTC8QBKxe/NLldE5BLqoq00HezcrCuLabS9DwOXSXDlcK2/y1k9EB0H4q8+50qLvktwMCJ3oMxzgctKzWqTMkVjw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3045947DFE80F3488065B1899F7573C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a73576-2a60-4a8d-4bcc-08d865e3528c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:23:48.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZhuf3bKdAbmPrybdj/YmaYjRX7MK3WUNGYw5KDBQ9bJURfRl5AQPqRuHH0sCmhWDASq/89+NIznyW9gk3HVGHr8XWHkEeBiNGYD4thKS3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBQZXJmb3JtIGEgU29mdCBSZXNldCBvbiBzaHV0
ZG93biBvbiBmbGFzaGVzIHRoYXQgc3VwcG9ydCBpdCBzbyB0aGF0IHRoZQ0KPiBmbGFzaCBjYW4g
YmUgcmVzZXQgdG8gaXRzIGluaXRpYWwgc3RhdGUgYW5kIGFueSBjb25maWd1cmF0aW9ucyBtYWRl
IGJ5DQo+IHNwaS1ub3IgKGdpdmVuIHRoYXQgdGhleSdyZSBvbmx5IGRvbmUgaW4gdm9sYXRpbGUg
cmVnaXN0ZXJzKSB3aWxsIGJlDQo+IHJlc2V0LiBUaGlzIHdpbGwgaGFuZCBiYWNrIHRoZSBmbGFz
aCBpbiBwcmlzdGluZSBzdGF0ZSBmb3IgYW55IGZ1cnRoZXINCj4gb3BlcmF0aW9ucyBvbiBpdC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4N
Cg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jICB8IDQ1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3Iu
aCB8ICAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1u
b3IvY29yZS5jDQo+IGluZGV4IGI0MmQ1OWFiMjcyNC4uOWRlODExYjMzMTI1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYw0KPiBAQCAtNDAsNiArNDAsOSBAQA0KPiANCj4gICNkZWZpbmUgU1BJX05PUl9N
QVhfQUREUl9XSURUSCA0DQo+IA0KPiArI2RlZmluZSBTUElfTk9SX1NSU1RfU0xFRVBfTUlOIDIw
MA0KPiArI2RlZmluZSBTUElfTk9SX1NSU1RfU0xFRVBfTUFYIDQwMA0KPiArDQo+ICAvKioNCj4g
ICAqIHNwaV9ub3JfZ2V0X2NtZF9leHQoKSAtIEdldCB0aGUgY29tbWFuZCBvcGNvZGUgZXh0ZW5z
aW9uIGJhc2VkIG9uIHRoZQ0KPiAgICogICAgICAgICAgICAgICAgICAgICAgICBleHRlbnNpb24g
dHlwZS4NCj4gQEAgLTMxNzUsNiArMzE3OCw0NSBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdChz
dHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiANCj4gK3N0
YXRpYyB2b2lkIHNwaV9ub3Jfc29mdF9yZXNldChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiArew0K
PiArICAgICAgIHN0cnVjdCBzcGlfbWVtX29wIG9wOw0KPiArICAgICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICAgICBvcCA9IChzdHJ1Y3Qgc3BpX21lbV9vcClTUElfTUVNX09QKFNQSV9NRU1fT1Bf
Q01EKFNQSU5PUl9PUF9TUlNURU4sIDApLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBTUElf
TUVNX09QX05PX0RVTU1ZLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05P
X0FERFIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fREFUQSk7DQo+
ICsNCj4gKyAgICAgICBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcChub3IsICZvcCwgbm9yLT5yZWdf
cHJvdG8pOw0KPiArDQo+ICsgICAgICAgcmV0ID0gc3BpX21lbV9leGVjX29wKG5vci0+c3BpbWVt
LCAmb3ApOw0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIGRldl93YXJu
KG5vci0+ZGV2LCAiU29mdHdhcmUgcmVzZXQgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBvcCA9IChzdHJ1
Y3Qgc3BpX21lbV9vcClTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9TUlNULCAw
KSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19BRERSLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBTUElfTUVNX09QX05PX0RBVEEpOw0KPiArDQo+ICsgICAgICAgc3BpX25vcl9z
cGltZW1fc2V0dXBfb3Aobm9yLCAmb3AsIG5vci0+cmVnX3Byb3RvKTsNCj4gKw0KPiArICAgICAg
IHJldCA9IHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4gKyAgICAgICBpZiAo
cmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfd2Fybihub3ItPmRldiwgIlNvZnR3YXJlIHJl
c2V0IGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ICsg
ICAgICAgfQ0KPiArDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBTb2Z0d2FyZSBSZXNldCBp
cyBub3QgaW5zdGFudCwgYW5kIHRoZSBkZWxheSB2YXJpZXMgZnJvbSBmbGFzaCB0bw0KPiArICAg
ICAgICAqIGZsYXNoLiBMb29raW5nIGF0IGEgZmV3IGZsYXNoZXMsIG1vc3QgcmFuZ2Ugc29tZXdo
ZXJlIGJlbG93IDEwMA0KPiArICAgICAgICAqIG1pY3Jvc2Vjb25kcy4gU28sIHNsZWVwIGZvciBh
IHJhbmdlIG9mIDIwMC00MDAgdXMuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgdXNsZWVwX3Jh
bmdlKFNQSV9OT1JfU1JTVF9TTEVFUF9NSU4sIFNQSV9OT1JfU1JTVF9TTEVFUF9NQVgpOw0KPiAr
fQ0KPiArDQo+ICAvKiBtdGQgcmVzdW1lIGhhbmRsZXIgKi8NCj4gIHN0YXRpYyB2b2lkIHNwaV9u
b3JfcmVzdW1lKHN0cnVjdCBtdGRfaW5mbyAqbXRkKQ0KPiAgew0KPiBAQCAtMzE5NCw2ICszMjM2
LDkgQEAgdm9pZCBzcGlfbm9yX3Jlc3RvcmUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gICAgICAg
ICBpZiAobm9yLT5hZGRyX3dpZHRoID09IDQgJiYgIShub3ItPmZsYWdzICYgU05PUl9GXzRCX09Q
Q09ERVMpICYmDQo+ICAgICAgICAgICAgIG5vci0+ZmxhZ3MgJiBTTk9SX0ZfQlJPS0VOX1JFU0VU
KQ0KPiAgICAgICAgICAgICAgICAgbm9yLT5wYXJhbXMtPnNldF80Ynl0ZV9hZGRyX21vZGUobm9y
LCBmYWxzZSk7DQo+ICsNCj4gKyAgICAgICBpZiAobm9yLT5mbGFncyAmIFNOT1JfRl9TT0ZUX1JF
U0VUKQ0KPiArICAgICAgICAgICAgICAgc3BpX25vcl9zb2Z0X3Jlc2V0KG5vcik7DQo+ICB9DQo+
ICBFWFBPUlRfU1lNQk9MX0dQTChzcGlfbm9yX3Jlc3RvcmUpOw0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCBiL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3Iu
aA0KPiBpbmRleCBjZDU0OTA0MmM1M2QuLjI5OTY4NWQxNWRjMiAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbXRkL3NwaS1u
b3IuaA0KPiBAQCAtNTEsNiArNTEsOCBAQA0KPiAgI2RlZmluZSBTUElOT1JfT1BfQ0xGU1IgICAg
ICAgICAgICAgICAgMHg1MCAgICAvKiBDbGVhciBmbGFnIHN0YXR1cyByZWdpc3RlciAqLw0KPiAg
I2RlZmluZSBTUElOT1JfT1BfUkRFQVIgICAgICAgICAgICAgICAgMHhjOCAgICAvKiBSZWFkIEV4
dGVuZGVkIEFkZHJlc3MgUmVnaXN0ZXIgKi8NCj4gICNkZWZpbmUgU1BJTk9SX09QX1dSRUFSICAg
ICAgICAgICAgICAgIDB4YzUgICAgLyogV3JpdGUgRXh0ZW5kZWQgQWRkcmVzcyBSZWdpc3RlciAq
Lw0KPiArI2RlZmluZSBTUElOT1JfT1BfU1JTVEVOICAgICAgIDB4NjYgICAgLyogU29mdHdhcmUg
UmVzZXQgRW5hYmxlICovDQo+ICsjZGVmaW5lIFNQSU5PUl9PUF9TUlNUICAgICAgICAgMHg5OSAg
ICAvKiBTb2Z0d2FyZSBSZXNldCAqLw0KPiANCj4gIC8qIDQtYnl0ZSBhZGRyZXNzIG9wY29kZXMg
LSB1c2VkIG9uIFNwYW5zaW9uIGFuZCBzb21lIE1hY3Jvbml4IGZsYXNoZXMuICovDQo+ICAjZGVm
aW5lIFNQSU5PUl9PUF9SRUFEXzRCICAgICAgMHgxMyAgICAvKiBSZWFkIGRhdGEgYnl0ZXMgKGxv
dyBmcmVxdWVuY3kpICovDQo+IC0tDQo+IDIuMjguMA0KPiANCg0K
