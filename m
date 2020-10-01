Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2EB27F9EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgJAHHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:07:53 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:46525 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601536072; x=1633072072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hEAPTQu+LfvwmqpvhM0jIfklszhQrT985XMXnC9S/Xg=;
  b=wCRp5v6fOu4Boitx3Y+kFGRq+O2pWNF4YrpoXGYBl5PRRY3dtuNCNqNC
   tZdWTVy5epDRN88d4HTMkNNUS/TfSmIyBEIjIh/Sf1NWCEUHLd8Dxwrkl
   Offm+ehKlNS6ym6FDD3EWP4AncVP46Y/RgMqL1nOvC+g7GppiBxv9NB0Z
   /iB1kihQHGFfbanZP1jDsT5zbRqxLPYbcTsTa2oM0Vvo4ffUluStt25w+
   Osm3S+kAhg/Hv/qcc39YG8zHgMqnH+7bkfrZmXZj20ej5yplhUPnlJUMW
   4XrRuQqzPbpRuA2dF4ODB2Hq4yy9UBeHtin1DoSYROg5KCofYyddObLxZ
   Q==;
IronPort-SDR: syiTvmmw5D9Yl8Rn4IEM/1ZkFHRVZNzu1R2ktsw4o8SDbNYFHb5qjkun63eZG+nxCoR2TXGQmy
 8DEdRfi06r2OQ2tM0uQn2VWR4KWKdU7JGz7XYH9BHJn1kQcTlINkNRVCb1gsdlfkihcoaT8E36
 ecucFRDzTPcaDvbcIhVG3sUutykqbktXYedtw7nT2gKGQeJsUTvBBGA0LfwC3o5zchXKP3CZQ/
 sPUNkqKB9kt8PdXy/qzTTtexqmIxq7yR10Ll77OHEX7Mte+0Kp2lqtZZE9UMdZwr6zZP/Q/Lgb
 hGY=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="91044486"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 00:07:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 00:07:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 00:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2mz4bfU9HoHgoWHaeAs5Tqpmka+MEt0+w/uxoReah5TLFyq1a84UyMNgph3ZYdyLtpUOQlwI6/dPV+y27GEHYHCpQirttVsW1RUbTzi5+826UH+gtU/ir58wPJjICgWa5opxrKQj/EI+MtshU6cxv/xjh6tV5Q8ie5FrGpiVCUtDqjc3XdXc0rOmDmQdPDlin4H8DrFmgmrFYpg59aypfQQ0dqwpKVaO2w5niIr0vzrck3qnpu40W03mhSM8gI4MgkZsk0/sbBbNO84lROw1dI9CP0tLtiwDcI9s8nJZ6U3DrtZjAtERWhsQBibI1PL2L1dbwGFZUHGBcfWdRkWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEAPTQu+LfvwmqpvhM0jIfklszhQrT985XMXnC9S/Xg=;
 b=l7OqbWv/ZnGzn//5P83eTIwedXOV8i0/N/vvQ7m/xpTyXGQkX3rmFyHH45T8+V+rcTMbMH7fPLBPEEGBxwEzOKLIF3mhye2iiGrBzGlKdmbtCxYRO2+L79Tc2vDWxbD2lozF6LDJyB/hYP1zo3/tXopUUT0Hed7OF0CYDcJlWSvAzUAWrYfqR1PkP01XQtuDJOiuAN7oQ8WBEVCTJR3NVf9VmVm81TNtvxZZ5WGRcX+M962XEDImmBTNpV0Gz8SwYmII+0vyHYpsWoTROaha++Kqp+Zl3bYYSLPI27x6TsDYIeL9v1BhILR9EcYbvHDQDYrLCIAXVzga5DuPOBTKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEAPTQu+LfvwmqpvhM0jIfklszhQrT985XMXnC9S/Xg=;
 b=lF3mav0zA2xpZc3J+ceS2Znm9dAeAJLbWrlyR3H5RFProDkoh10KaRaYIf92/VbNA4l/qyFhUQpEm3DpfcRIl+lBJt9k/jVicin0P0iXqqQPrgKaXcdP4T7VJROXE5GVdcGTduy3OcWDSnJBaCbBbarMGbGY43/BhvSc1KPOTvg=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR1101MB2314.namprd11.prod.outlook.com (2603:10b6:4:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Thu, 1 Oct
 2020 07:07:42 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 07:07:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Topic: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Index: AQHWlzICH6PibhncD0qfQu8hdLJMbA==
Date:   Thu, 1 Oct 2020 07:07:42 +0000
Message-ID: <bec5b899-fbd2-1c29-611c-654f17e63dbf@microchip.com>
References: <20200327155939.13153-1-michael@walle.cc>
 <e56c5f60-2f59-f913-6eea-3bf8dd4c0774@microchip.com>
 <a82d1ce203383af149ed77c5fd6c8985@walle.cc>
In-Reply-To: <a82d1ce203383af149ed77c5fd6c8985@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a96c0d30-5545-45da-2f7c-08d865d8b086
x-ms-traffictypediagnostic: DM5PR1101MB2314:
x-microsoft-antispam-prvs: <DM5PR1101MB2314C88DF345533817039509F0300@DM5PR1101MB2314.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNGtyEWE25Mi+jJ8dS1l3h3NPvB2UoJNkBuf75QCYWs3J49VTadd2N/RMOTshnMwGqmRm7xBuUz6uAmisHph2Yws8FiZzip1qAEuFVxrTpVu1CRT5J4lZN93OTT5xGp8QuyrbDTQg0tjlIWKFW/LHSTE4mOtoPOMY/PV/bVoobaIGOl8TkY7jVXE/gcxr36O1GSjo5tUXLgbm/eWmBZxetfbmY9QCYLFdvLHFKUHhAYVs9N6cF8cB7bYuRv991ZUW6h+s9tCeYuhSoOI9z8c68PFzB28eci6QszU0HLrfMrioTmWQe63ax+9BJKCIskHQqKej/k29qW84DW/Bl0X2PWbJttMdWRNJ4/rIe/LSzjxjDFrlSrY95Aq7GO3yjPLF3Kk4LyZB6HqSm+WFYBgqWvJP/YjuedeZO9P85Tt3sgozD0qHPibM5fV5hZYC8XSWZADxOKjnF7vDXRfLyGjNMrgCf1ftdpo8yWe0rYi700qITZtn+NrUOO5uVG9Ym5u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(39860400002)(136003)(6486002)(8676002)(71200400001)(6916009)(8936002)(31686004)(83080400001)(31696002)(4326008)(2906002)(478600001)(86362001)(91956017)(76116006)(66946007)(2616005)(316002)(54906003)(66556008)(966005)(26005)(53546011)(5660300002)(6506007)(83380400001)(186003)(64756008)(66476007)(6512007)(66446008)(36756003)(15398625002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Q97UCB7E52dvdQ1dwOMRKOMpTBbpzK/qAjGjlGWfgp5WIyQhupMKVL/hXMEn25djBkfffvrn6SILY6EYTNf3L77xoy0z26J8Iiuh+v44lu16aPgOjwg6udliKijUKFZ3/woPbyld3XxS7+lpDmuaK0AMC3RXW7+A9vuo1MJScyXB0hw1zo0+K2/wLHvCK+zH3JfCnmkztjLKle1Euj2KZ0B0l8AzgpT9WlnXnkuHmJ51LBOkeBMD3SSRqI5BBNwM9kv4nkP8C4VmbG6EsoFmYgHf1S4W8/eelUXrvCHRJtl3X5wIqToy9gDAyLvl3ZVktJ23AXzL/yYhkJg34UArw8sW2gwzXN0jPWAvOp+RRwuKz+HRAgJHFg0q0J/xC2apdBcnPHITozLt1Vexpi2jS50D5aHmK/3O615gQ7bX9B34dl3t6SXxLHnBWEhJOZqmJe2fbS1aCHY9b2EfyowEaXDAR2hQnYqglHUa2Qq7izRycdMkzc1x3jJtM7MOIVcZuuoAB8u6GvJTUfzG799ye8A63Th6XGokRpedB4ZGDz+gIxSzKbBZgagUPefcbe+bH9uzPfaU1iLpT/+4RqXn3a0XZkARRRfgnJkeAPNQu4f862XXnAKuJ5VLWFW3MRT39AnwB9lcjBRxJJGM9MnljQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0E60C254D56C24ABD1277DD9EA1DADC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96c0d30-5545-45da-2f7c-08d865d8b086
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 07:07:42.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIcq5KRn5fzqqlPMX919jQvyQN63efKxxaJP6JnRmnKvMbL2ZfPcSzFaef+QqzEur+hm5s2siD0Z2EHQcspgapGM+Z3nXih2MwfbNxpPr+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2314
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCAxOjM4IEFNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFR1ZG9yLA0KDQpIaSwgTWljaGFlbCwNCg0K
PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYw0KPj4+IGluZGV4IGNjNjhlYTg0MzE4ZS4uZmQxYzM2ZDcwYTEz
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+PiBAQCAtMjkxNiwyMCArMjkxNiwzOCBAQCBz
dGF0aWMgaW50IHNwaV9ub3JfcXVhZF9lbmFibGUoc3RydWN0IHNwaV9ub3INCj4+PiAqbm9yKQ0K
Pj4+IMKgfQ0KPj4+DQo+Pj4gwqAvKioNCj4+PiAtICogc3BpX25vcl91bmxvY2tfYWxsKCkgLSBV
bmxvY2tzIHRoZSBlbnRpcmUgZmxhc2ggbWVtb3J5IGFycmF5Lg0KPj4+ICsgKiBzcGlfbm9yX2ds
b2JhbF91bnByb3RlY3QoKSAtIFBlcmZvcm0gYSBnbG9iYWwgdW5wcm90ZWN0IG9mIHRoZQ0KPj4+
IG1lbW9yeSBhcmVhLg0KPj4+IMKgICogQG5vcjrCoMKgwqAgcG9pbnRlciB0byBhICdzdHJ1Y3Qg
c3BpX25vcicuDQo+Pj4gwqAgKg0KPj4+IMKgICogU29tZSBTUEkgTk9SIGZsYXNoZXMgYXJlIHdy
aXRlIHByb3RlY3RlZCBieSBkZWZhdWx0IGFmdGVyIGENCj4+PiBwb3dlci1vbiByZXNldA0KPj4+
IMKgICogY3ljbGUsIGluIG9yZGVyIHRvIGF2b2lkIGluYWR2ZXJ0ZW50IHdyaXRlcyBkdXJpbmcg
cG93ZXItdXAuDQo+Pj4gQmFja3dhcmQNCj4+PiDCoCAqIGNvbXBhdGliaWxpdHkgaW1wb3NlcyB0
byB1bmxvY2sgdGhlIGVudGlyZSBmbGFzaCBtZW1vcnkgYXJyYXkgYXQNCj4+PiBwb3dlci11cA0K
Pj4+IC0gKiBieSBkZWZhdWx0Lg0KPj4+ICsgKiBieSBkZWZhdWx0LiBEbyBpdCBvbmx5IGZvciBm
bGFzaGVzIHdoZXJlIHRoZSBibG9jayBwcm90ZWN0aW9uIGJpdHMNCj4+PiArICogYXJlIHZvbGF0
aWxlLCB0aGlzIGlzIGluZGljYXRlZCBieSBTTk9SX0ZfTkVFRF9VTlBST1RFQ1QuDQo+Pj4gKyAq
DQo+Pj4gKyAqIFdlIGNhbm5vdCB1c2Ugc3BpX25vcl91bmxvY2sobm9yLT5wYXJhbXMuc2l6ZSkg
aGVyZSBiZWNhdXNlIHRoZXJlDQo+Pj4gYXJlDQo+Pj4gKyAqIGxlZ2FjeSBkZXZpY2VzIChlZy4g
QVQyNURGMDQxQSkgd2hpY2ggbmVlZCBhICJnbG9iYWwgdW5wcm90ZWN0Ig0KPj4+IGNvbW1hbmQu
DQo+Pj4gKyAqIFRoaXMgaXMgZG9uZSBieSB3cml0aW5nIDBiMHgwMDAweHggdG8gdGhlIHN0YXR1
cyByZWdpc3Rlci4gVGhpcw0KPj4+IHdpbGwgYWxzbw0KPj4+ICsgKiB3b3JrIGZvciBhbGwgb3Ro
ZXIgZmxhc2hlcyB3aGljaCBoYXZlIHRoZXNlIGJpdHMgbWFwcGVkIHRvIEJQMCB0bw0KPj4+IEJQ
My4NCj4+PiArICogVGhlIHRvcCBtb3N0IGJpdCBpcyB1c3VzYWxseSBzb21lIGtpbmQgb2YgbG9j
ayBiaXQgZm9yIHRoZSBibG9jaw0KPj4+ICsgKiBwcm90ZWN0aW9uIGJpdHMuDQo+Pj4gwqAgKi8N
Cj4+PiAtc3RhdGljIGludCBzcGlfbm9yX3VubG9ja19hbGwoc3RydWN0IHNwaV9ub3IgKm5vcikN
Cj4+PiArc3RhdGljIGludCBzcGlfbm9yX2dsb2JhbF91bnByb3RlY3Qoc3RydWN0IHNwaV9ub3Ig
Km5vcikNCj4+PiDCoHsNCj4+PiAtwqDCoMKgIGlmIChub3ItPmZsYWdzICYgU05PUl9GX0hBU19M
T0NLKQ0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzcGlfbm9yX3VubG9jaygm
bm9yLT5tdGQsIDAsIG5vci0+cGFyYW1zLT5zaXplKTsNCj4+PiArwqDCoMKgIGludCByZXQ7DQo+
Pj4NCj4+PiAtwqDCoMKgIHJldHVybiAwOw0KPj4+ICvCoMKgwqAgZGV2X2RiZyhub3ItPmRldiwg
InVucHJvdGVjdGluZyBlbnRpcmUgZmxhc2hcbiIpOw0KPj4+ICvCoMKgwqAgcmV0ID0gc3BpX25v
cl9yZWFkX3NyKG5vciwgbm9yLT5ib3VuY2VidWYpOw0KPj4+ICvCoMKgwqAgaWYgKHJldCkNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4+ICsNCj4+PiArwqDCoMKg
IG5vci0+Ym91bmNlYnVmWzBdICY9IH5TUl9HTE9CQUxfVU5QUk9URUNUX01BU0s7DQo+Pj4gKw0K
Pj4+ICvCoMKgwqAgLyoNCj4+PiArwqDCoMKgwqAgKiBEb24ndCB1c2Ugc3BpX25vcl93cml0ZV9z
cjFfYW5kX2NoZWNrKCkgYmVjYXVzZSB3cml0aW5nIHRoZQ0KPj4+IHN0YXR1cw0KPj4+ICvCoMKg
wqDCoCAqIHJlZ2lzdGVyIG1pZ2h0IGZhaWwgaWYgdGhlIGZsYXNoIGlzIGhhcmR3YXJlIHdyaXRl
IHByb3RlY3RlZC4NCj4+PiArwqDCoMKgwqAgKi8NCj4+PiArwqDCoMKgIHJldHVybiBzcGlfbm9y
X3dyaXRlX3NyKG5vciwgbm9yLT5ib3VuY2VidWYsIDEpOw0KPj4+IMKgfQ0KPj4NCj4+IFRoaXMg
d29uJ3Qgd29yayBmb3IgYWxsIHRoZSBmbGFzaGVzLiBZb3UgdXNlIGEgR0VOTUFTSyg1LCAyKSB0
byBjbGVhcg0KPj4gdGhlIFN0YXR1cyBSZWdpc3RlciBldmVuIGZvciBCUDAtMiBmbGFzaGVzIGFu
ZCB5b3UgZW5kIHVwIGNsZWFyaW5nDQo+PiBCSVQoNSkNCj4+IHdoaWNoIGNhbiBsZWFkIHRvIHNp
ZGUgZWZmZWN0cy4NCj4+DQo+PiBXZSBzaG91bGQgaW5zdGVhZCBpbnRyb2R1Y2UgYSBub3ItPnBh
cmFtcy0+bG9ja2luZ19vcHMtPmdsb2JhbF91bmxvY2soKQ0KPj4gaG9vaw0KPj4gZm9yIHRoZSBm
bGFzaGVzIHRoYXQgaGF2ZSBzcGVjaWFsIG9wY29kZXMgdGhhdCB1bmxvY2sgYWxsIHRoZSBmbGFz
aA0KPj4gYmxvY2tzLA0KPj4gb3IgZm9yIHRoZSBmbGFzaGVzIHRoYXQgZGV2aWF0ZSBmcm9tIHRo
ZSAiY2xlYXIganVzdCB5b3VyIEJQIGJpdHMiDQo+PiBydWxlLg0KPiANCj4gV291bGRuJ3QgaXQg
bWFrZSBtb3JlIHNlbnNlIHRvIGp1c3Qgc2V0IHBhcmFtcy0+bG9ja2luZ19vcHMgZm9yIHRoZXNl
DQo+IGZsYXNoZXMNCj4gdG8gZGlmZmVyZW50IGZ1bmN0aW9ucz8gb3IgZXZlbiBwcm92aWRlIGEg
c3BpX25vcl9nbG9iYWxfdW5wcm90ZWN0X29wcw0KPiBpbg0KPiBjb3JlLmMgYW5kIHRoZXNlIGZs
YXNoZXMgd2lsbCBqdXN0IHNldCB0aGVtLiB0aGVyZSBpcyBubyBpbmRpdmlkdWFsDQo+IHNlY3Rv
cg0KPiByYW5nZSBsb2NrIGZvciB0aGVzZSBjaGlwcy4ganVzdCBhIGxvY2sgYWxsIG9yIG5vdGhp
bmcuDQoNCkkgbGlrZSB0aGUgaWRlYSBvZiBoYXZpbmcgYWxsIGxvY2tpbmcgcmVsYXRlZCBmdW5j
dGlvbnMgcGxhY2VkIGluIGEgc2luZ2xlDQpwbGFjZSwgdGh1cyB0aGUgZ2xvYmFsX3VubG9jaygp
IHNob3VsZCBiZSBpbnNpZGUgbG9ja2luZ19vcHMgc3RydWN0Lg0KWW91IGNhbiB1cGRhdGUgcGFy
YW1zLT5sb2NraW5nX29wcy4gSWYgd2UgaGF2ZSB2ZW5kb3Igc3BlY2lmaWMgbG9ja2luZ19vcHMN
CndlIGNhbiBzZXQgdGhlbSB2aWE6DQoJbm9yLT5tYW51ZmFjdHVyZXItPmZpeHVwcy0+ZGVmYXVs
dF9pbml0KG5vcik7DQpvciBpZiB0aGV5IGFyZSBmbGFzaCBzcGVjaWZpYywgd2l0aCBhIHNtYWxs
ZXIgZ3JhbnVsYXJpdHksIHZpYToNCglub3ItPmluZm8tPmZpeHVwcy0+ZGVmYXVsdF9pbml0KG5v
cik7IA0KDQo+IA0KPiBJZiBpdCBpcyBtb3JlIGNvbW1vbiBhbmQgbm90IGp1c3Qgb25lIHZlbmRv
ciBpdCBtaWdodCBhbHNvIG1ha2Ugc2Vuc2UgdG8NCj4gYWRkDQo+IGEgc2VwZXJhdGUgZmxhZyB3
aGljaCB3aWxsIHRoZW4gc2V0IHRoZSBsb2NraW5nIG9wcyB0bw0KPiBzcGlfbm9yX2dsb2JhbF91
bnByb3RlY3Rfb3BzLCBhbHNvIGl0IHNlZW1zIHRoYXQgdGhlcmUgaGF2ZSB0byBiZSB0d28NCg0K
SSBkb24ndCBsaWtlIHRoYXQgd2UgaGF2ZSBzbyBtYW55IGZsYWdzLCBzbyBJIHRyeSB0byBhdm9p
ZCBpbnRyb2R1Y2luZyBuZXcNCm9uZXMgYXMgYmVzdCBhcyBJIGNhbi4gQ2hlY2tpbmcgZm9yIG51
bGwgcG9pbnRlciBzaG91bGQgc3VmZmljZS4NCg0KPiB3cml0ZXMNCj4gdG8gdGhlIHN0YXR1cyBy
ZWdpc3Rlciwgb25lIHRvIGNsZWFyIFNQUkwgYW5kIHRoZW4gb25lIHRvIGNsZWFyIHRoZSBCUA0K
PiBiaXRzLg0KDQpTUFIgaXMgcHJldHR5IGNvbW1vbiwgYWxzbyBhdmFpbGFibGUgaW4gV2luYm9u
ZCBhbmQgTWljcm9uLiBJIHNlZSB0aGF0DQppdCBpcyBhIG5vbi12b2xhdGlsZSBiaXQgZm9yIHRo
ZXNlIHZlbmRvcnMuIE5WIGJpdHMgYXJlIG9mIGNvbmNlcm4gDQpiZWNhdXNlIHlvdSBjYW4gd2Vh
ciB0aGVtIGRvd24gd2l0aCBtdWx0aXBsZSBzZXQvY2xlYXIgb3BzLiBXZSBoYXZlIHRvDQp0aGlu
ayBob3cgd2UnbGwgZGVhbCB3aXRoIE5WIGJpdHMgaW4gZ2VuZXJhbCBpbiBTUEkgTk9SLg0KDQo+
IFNlZSBmb3IgZXhhbXBsZSBbMV0gVGFibGUgOS0yLiBJJ2xsIGhhdmUgdG8gZ28gdGhyb3VnaCB0
aGUgZGF0YXNoZWV0cw0KPiBhZ2Fpbg0KPiB0byBzZWUgd2hhdCBmbGFzaGVzIGp1c3QgaGF2ZSBh
IGdsb2JhbCAodW4pcHJvdGVjdC4NCg0KWWVzLCBzb3JyeSBmb3IgdGhhdCwgbXkgYmFkLiBJIGNh
biBoZWxwIGlmIHlvdSB3YW50LCBJIGNhbiBnbyB0aHJvdWdoDQpkYXRhc2hlZXRzIHRvLg0KDQpM
ZXQncyBub3QgaW50cm9kdWNlIHRoZSBnbG9iYWwgdW5sb2NrIG9wcyBjb21tYW5kcyB5ZXQsIGxl
dCdzIGp1c3QNCnNvbHZlIHRoZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGlzc3VlcyB3aXRoIHRo
ZSBleGlzdGluZyBjb2RlLiBXZSBjYW4NCmFkZCBuZXcgb3Bjb2RlcyBsYXRlciBvbi4NCg0KQWxz
bywgSSBjYW4gc2NyYXRjaCBhIHBhdGNoIHdpdGggdGhlIGdsb2JhbF91bmxvY2soKSBob29rIGlm
IHlvdSBwcmVmZXIsDQpzbyB0aGF0IHdlIGNhbiB0YWxrIG9uIGNvZGUuDQoNCkNoZWVycywNCnRh
DQoNCj4gDQo+IFsxXSBodHRwczovL3d3dy5hZGVzdG90ZWNoLmNvbS93cC1jb250ZW50L3VwbG9h
ZHMvZG9jMzY2OC5wZGYNCj4gDQo+IC1taWNoYWVsDQoNCg==
