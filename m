Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226F02C596A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403834AbgKZQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:43:00 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:64557 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKZQm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606408979; x=1637944979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NiidtesXtQDDsxRgTb5qXeKyy2saFIVNrtjJvjKE3fY=;
  b=YAEk5XrqsEvVoUlfYntTvR50UoIgVFktwh5xm3JHa0svDb0mZVp6Qwnn
   2Q2m/xTB/Xw7Cb5TGJ2fbk11O/LftMtjD5uZaHFfl1zl/gvjcDYKxP++6
   F09LfgeiHs8JCI+fZMaPY8DFFLsZxd4Xjc6l4OaQR0aNZ3icrCXFYSr8e
   U16mi7oTo+OupfwfLvjAA5fNBIJI6OneAMGFpS71e8dCsHShs/1Ia35Du
   M2S74gs/8DbcM7MEggBVIHxL5s20VqEMLkgHa+hpMa13uWzNji1vrlT3O
   Qcv+HvVTx2XtzDAHEdo6kXSbpJYnvaIK0ynwr0fasOjMm93OdRcKOKkmH
   g==;
IronPort-SDR: Cv05+1agXItdvKyR1Dd2DKv+nQ8l56H3fEEmk9prdjHJPI936uJryvB6maUKyxDk6KeQdi+ySx
 zAN5yVTD0C96tayvQgCkBFP57BAmagn4yaKImyICIBWczko7oWSryZR4jpSbYcDK0aSrDGNWLA
 sooZpHuBtAMI3OM5+KPJ8FyNKAHZe9AI2qZl8lbcWo4NjjkS+EqYa2gd2zIBltsBkYGzp70cBg
 tL/DN34m+wLYDwL96PpO2Yfa0W73TvwilX0m+s3HkvDa9dzfPIhKXyc1xkAbt1CmgizxUOKjGl
 OsE=
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="105153767"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2020 09:42:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 26 Nov 2020 09:42:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 09:42:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyJCnRWUM6yr0K5oRmbBEhKdMGXPKYhpYlW/UVqTduma5eqhCz+Vh4VQ7RMPYx5sGC1/vNEJ8tgHI0A5gIx5G48KcSpBuY8ctqJbQidynfFulV73TlleFw0ASpnR+QsIRMK/jNdgAiw7nP/nMUbA5OK43Oo1Ic8AqFHkta5+lw++xEFaSe/w1VaqzibwMfujMVK+fxlZyaFRh1HTgyaOuWC70IuJ1Jph8Tali4S9OPdtErrDIUweNOFFPPKyMMvzaVJZIJ9CFrWMSHbtLaizwxjg5P9krQk/AO5M5Q4a2AwtUyqNu6M9mbGq18/U+WqwJKxGLewrAJA6xtKi2Dhn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiidtesXtQDDsxRgTb5qXeKyy2saFIVNrtjJvjKE3fY=;
 b=E3YBvPkStWyF1QzhsXZygcmNLazgpuTNHS19hzbwntHtzZXxmqEW3poSPVhqjld309SzPwMzoz/3eQS5jjoesgEUkZkr1duwEvyAGr+KHToBz3QcznBujnutnCS5MH5GL13pQySIJWJ7HIkUPzVk55KQ3vL8Qg2W/GanLXR/e5t/7NDBkCo3rB66QLcVUmD7GtjyoAbB1V+0qKeWFJbheumoSvsHZWVC5KzQSsNsLPbo6nw1ERIipQkgdTp2iZ+HG1wUO1CspNVP1kS2uzseUOKlRa7b16gWg6wDi5ME2IIW5LOKiYcJd9+o1QUTL4+pv/4ef26DhKUCsh4AiA0EhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiidtesXtQDDsxRgTb5qXeKyy2saFIVNrtjJvjKE3fY=;
 b=Fc/NKvi5jXJg2OGzTnz4Lvcjevyy1aBLaJ4SPhhkhG1EgDHVajFjReFdyUOkMsyoZe9zetPt4ns1hRGKX26fXeTL16oCpq5vnWRAgj3YM+kpWOF5+rLUXGBbVxBhZkdszo/6pPIeD2iC7ck6plh9+TJVA7RwWZOyBEIzWUs2dgI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5164.namprd11.prod.outlook.com (2603:10b6:806:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 26 Nov
 2020 16:42:54 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3611.021; Thu, 26 Nov 2020
 16:42:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection flag
Thread-Topic: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection
 flag
Thread-Index: AQHWwpVIheOE53CDUkK+sIaiGLI1Ug==
Date:   Thu, 26 Nov 2020 16:42:54 +0000
Message-ID: <40cab307-1ef5-92e0-c922-9766f5ddf6d6@microchip.com>
References: <20201003153235.29762-1-michael@walle.cc>
 <20201003153235.29762-2-michael@walle.cc>
 <7b5159c1-5457-b43c-2bf2-1a17ed6df34a@microchip.com>
 <f9724ff71809557283beb7c8c4d4b356@walle.cc>
In-Reply-To: <f9724ff71809557283beb7c8c4d4b356@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78173a02-ed5f-41ce-ebc2-08d8922a52ac
x-ms-traffictypediagnostic: SA2PR11MB5164:
x-microsoft-antispam-prvs: <SA2PR11MB516486D0A0298E7B0C8FCB3CF0F90@SA2PR11MB5164.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXmeCNWmuMlEzX4uZXeKERQRThdsB6gwnWaWGBWFD7AWuEVknPsSCK+AP+mjjJC6/qAh17kXkkf2qU+2LdCCbKHt27Lebqe0ZdxA/SMsahIlysy2YpqiEbddS/cit5SoUe6m24rSZbf6/U60DhLRwq0+POAbcY3S2UIEG2tF+ErbdEFAc3sCL7T0aM4kBAOmQ5QxVr/Q8djYWfRMaR9ZOGaP6CMrpoU8Lb/42YElgPbZlr2tLQVYdGzSgiczLDNKwUoX06dxhyDhYi+aWfQvrKkgeiN2/pOFdITK0+1xB2fd+JQu4u1StkYQ3kWbTGVuKNCAwaH7TqRbzrj3aGZhFZRyUmhTDIv7duNOKrxRy6Bgxz+sEjkReebIh2mYugn9QASq64YQ/ArpRBuAmfqu7H/ENCqaBDVPk64tGWAQWcRHy55zR0J8PTIdbXeAh6fs7TgRkW0bzXVnYy2y8lFQ3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(4001150100001)(71200400001)(6916009)(64756008)(31696002)(5660300002)(66476007)(76116006)(66446008)(66946007)(4326008)(36756003)(86362001)(66556008)(83380400001)(6486002)(6512007)(54906003)(2906002)(478600001)(316002)(2616005)(186003)(8676002)(8936002)(966005)(53546011)(31686004)(26005)(6506007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a20vVmYybkFaRXlmYlB1ZUQvb1ZxWjJidHozdzJRbzBmbFV5Q3RWcEJKWHJI?=
 =?utf-8?B?d0dpWDRVTWZkbjJSMkp4elNMZFdZcXhib1B0MG1QdjhMRDFEUTNnNGdRUVNh?=
 =?utf-8?B?VnhTTzIybkN6M1FTZHJLb0djUXQ3WlRZS0pZRGUxYjN6OTYremJZdzVucVVp?=
 =?utf-8?B?VFdSeC8xb3VKOThFQ05jWE1EMnVueXgzVEZNTHUvRFdERjVYRmNRSHhrQ1V2?=
 =?utf-8?B?aEE4U2RwVk5zOTNXNEVZUVRpQjNqS3N3R3lad3AwaXhFM2VKdXk5WGVJOE1n?=
 =?utf-8?B?RlA3WWtsSStTSVBUNGpOYjVoS2tON3FiMUtoaHlQRktqakwvS2NmeGNwa25K?=
 =?utf-8?B?bWMzY0VoWit1Zk5TZ3ZyVmZxRE9XMFRPaytuWk5GeHNiSFBod3N0alZ2YkhR?=
 =?utf-8?B?TzJiNGhtZDBKdHd2Rm5oQmd1bFlPZWcvL0plQ0FWMlNlYUR5NENQVG81ZzRt?=
 =?utf-8?B?UXd0Mkt5K0JNVzI3aG04TGRFK1JxTTEzYmZGVnZ3VEJRRjZrRG9XSHhoMjlH?=
 =?utf-8?B?a0pwN1htblpiZzZlZnlFNHMydC9lYWFiMkVHT3B1d25wMW5CUHlXUVJQU1Nx?=
 =?utf-8?B?Y1FkNVpIUjJrL1JmRmdyNzRkbU5ka1ZjNGliQWRVenE1WFY3d0s0dDZNNVZi?=
 =?utf-8?B?Vzg4dFJSbkJwWUlJbCs3Yk04aERDYU1WNlQ3ZFU1SmJXcjgwcTlXNG9VR3I0?=
 =?utf-8?B?MTAySUg2ZVZTSDdseE9zQzdabmk4Vm1pbXBFdGo4YjB5OWpvWmhDSHdXcUwv?=
 =?utf-8?B?MHE4eDlpRm5aTHpEOWZ1TXdtYUZEejc3cXpzV1ZIWmN1REl5WlNOeUVqcm9v?=
 =?utf-8?B?WFpLblFNeDhXMGU5emJGNk1sOGRGVHFTRElYOC85alRnQnFscG5ZZElRb2RM?=
 =?utf-8?B?L3hidkdjcVc1cXp5dW1GN0g1eEJrZGgvMTY4SDdid2lQaStqUnZ3amFHckJ4?=
 =?utf-8?B?NVFtK3I4L0JuQkIzRlJZVjA5OFBjSkVuRkRWSWxiMFhpRUdJWGpuUWpkRGd1?=
 =?utf-8?B?RkNVdDFBd2doeEc5RC8walRETnQ3M2h1VngrdE1oUVdUMUYxOUwyRGl4UTJ1?=
 =?utf-8?B?UVIxa3VoVTBYZXpxNGJCQzhXMGNzeVczSC94WGZDcS95eEhLV3JLUzVLNldt?=
 =?utf-8?B?L3loOW9ZbmdrRXhRQXJ5b3lmcVNCMDByaUNQTy96Qzc3NTgvb29HSjlPb3Ru?=
 =?utf-8?B?ZU05YkJwRVRxQVZtMFp4MG01aTVaNXphTmZmc1JvNXRaL08vKzFYaXpkMXV1?=
 =?utf-8?B?RVJGZlBIaXpncGJiMVVGc2IrYnByOVF0bmpuSHZRZlVTNEFsSkRYTFB2eXZv?=
 =?utf-8?Q?RedqCG56+DV4U=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <60235A6F44BE3F4BA6BE0D56DD9A2637@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78173a02-ed5f-41ce-ebc2-08d8922a52ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 16:42:54.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvjizsrS2GV7YCAsUjsaaK2NKoby4rxy24/Yu3s5SvZqUZ3NOB8A4iZomhGpiX77lxI+S4X3N4uxKzVSj05KUWfogXCJGB1eBOu014vFJx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjUvMjAgODoxNyBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIwLTExLTI0IDIwOjA5LCBzY2hyaWVi
IFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDEwLzMvMjAgNjozMiBQTSwgTWlj
aGFlbCBXYWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPj4+DQo+Pj4gVGhpcyBpcyBjb25zaWRlcmVkIGJhZCBmb3IgdGhlIGZvbGxvd2luZyBy
ZWFzb25zOg0KPj4+IMKgKDEpIFdlIG9ubHkgc3VwcG9ydCB0aGUgYmxvY2sgcHJvdGVjdGlvbiB3
aXRoIEJQbiBiaXRzIGZvciB3cml0ZQ0KPj4+IMKgwqDCoMKgIHByb3RlY3Rpb24uIE5vdCBhbGwg
QXRtZWwgcGFydHMgc3VwcG9ydCB0aGlzLg0KPj4+IMKgKDIpIE5ld2x5IGFkZGVkIGZsYXNoIGNo
aXAgd2lsbCBhdXRvbWF0aWNhbGx5IGluaGVyaXQgdGhlICJoYXMNCj4+PiDCoMKgwqDCoCBsb2Nr
aW5nIiBzdXBwb3J0IGFuZCB0aHVzIG5lZWRzIHRvIGV4cGxpY2l0bHkgdGVzdGVkLiBCZXR0ZXIN
Cj4+PiDCoMKgwqDCoCBiZSBvcHQtaW4gaW5zdGVhZCBvZiBvcHQtb3V0Lg0KPj4+IMKgKDMpIFRo
ZXJlIGFyZSBhbHJlYWR5IHN1cHBvcnRlZCBmbGFzaGVzIHdoaWNoIGRvZXNuJ3Qgc3VwcG9ydA0K
Pj4+IMKgwqDCoMKgIHRoZSBsb2NraW5nIHNjaGVtZS4gU28gSSBhc3N1bWUgdGhpcyB3YXNuJ3Qg
cHJvcGVybHkgdGVzdGVkDQo+Pj4gwqDCoMKgwqAgYmVmb3JlIGFkZGluZyB0aGF0IGNoaXA7IHdo
aWNoIGVuZm9yY2VzIG15IHByZXZpb3VzIGFyZ3VtZW50DQo+Pj4gwqDCoMKgwqAgdGhhdCBsb2Nr
aW5nIHN1cHBvcnQgc2hvdWxkIGJlIGFuIG9wdC1pbi4NCj4+Pg0KPj4+IFJlbW92ZSB0aGUgZ2xv
YmFsIGZsYWcgYW5kIGFkZCBpbmRpdmlkdWFsIGZsYWdzIHRvIGFsbCBmbGFzaGVzIHdoaWNoDQo+
Pj4gc3VwcG9ydHMgQlAgbG9ja2luZy4gSW4gcGFydGljdWxhciB0aGUgZm9sbG93aW5nIGZsYXNo
ZXMgZG9uJ3Qgc3VwcG9ydA0KPj4+IHRoZSBCUCBzY2hlbWU6DQo+Pj4gwqAtIEFUMjZGMDA0DQo+
Pj4gwqAtIEFUMjVTTDMyMQ0KPj4+IMKgLSBBVDQ1REIwODFEDQo+Pj4NCj4+PiBQbGVhc2Ugbm90
ZSwgdGhhdCBzb21lIGZsYXNoZXMgd2hpY2ggYXJlIG1hcmtlZCBhcyBTUElfTk9SX0hBU19MT0NL
DQo+Pj4ganVzdA0KPj4+IHN1cHBvcnQgR2xvYmFsIFByb3RlY3Rpb24sIGkuZS4gbm90IG91ciBz
dXBwb3J0ZWQgYmxvY2sgcHJvdGVjdGlvbg0KPj4+IGxvY2tpbmcgc2NoZW1lLiBUaGlzIGlzIHRv
IGtlZXAgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkgd2l0aCB0aGUNCj4+PiBjdXJyZW50ICJ1bmxv
Y2sgYWxsIGF0IGJvb3QiIG1lY2hhbmlzbS4gSW4gcGFydGljdWxhciB0aGUgZm9sbG93aW5nDQo+
Pj4gZmxhc2hlcyBkb2Vzbid0IGhhdmUgQlAgYml0czoNCj4+PiDCoC0gQVQyNURGMDQxQQ0KPj4+
IMKgLSBBVDI1REYzMjENCj4+PiDCoC0gQVQyNURGMzIxQQ0KPj4+IMKgLSBBVDI1REY2NDENCj4+
PiDCoC0gQVQyNkRGMDgxQQ0KPj4+IMKgLSBBVDI2REYxNjFBDQo+Pj4gwqAtIEFUMjZERjMyMQ0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4N
Cj4+DQo+PiBSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2No
aXAuY29tPg0KPj4NCj4+PiAtLS0NCj4+PiBjaGFuZ2VzIHNpbmNlIHY0Og0KPj4+IMKgLSBub25l
DQo+Pj4NCj4+PiBjaGFuZ2VzIHNpbmNlIHYzL3YyL3YxOg0KPj4+IMKgLSB0aGVyZSB3YXMgbm8g
c3VjaCB2ZXJzaW9uIGJlY2F1c2UgdGhpcyBwYXRjaCB3YXMgYnVuZGxlZCB3aXRoDQo+Pj4gYW5v
dGhlcg0KPj4+IMKgwqAgcGF0Y2gNCj4+Pg0KPj4+IGNoYW5nZXMgc2luY2UgUkZDOg0KPj4+IMKg
LSBtZW50aW9uIHRoZSBmbGFzaGVzIHdoaWNoIGp1c3Qgc3VwcG9ydCB0aGUgIkdsb2JhbCBVbnBy
b3RlY3QiIGluDQo+Pj4gdGhlDQo+Pj4gwqDCoCBjb21taXQgbWVzc2FnZQ0KPj4+DQo+Pj4gwqBk
cml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgfCAyOCArKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tDQo+Pj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgYi9k
cml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+PiBpbmRleCAzZjVmMjFhNDczYTYuLjQ5ZDM5
MmM2YzhiYyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+
PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+PiBAQCAtMTAsMzcgKzEwLDI3
IEBADQo+Pj4NCj4+PiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBhdG1lbF9wYXJ0
c1tdID0gew0KPj4+IMKgwqDCoMKgwqDCoMKgIC8qIEF0bWVsIC0tIHNvbWUgYXJlIChjb25mdXNp
bmdseSkgbWFya2V0ZWQgYXMgIkRhdGFGbGFzaCIgKi8NCj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0
MjVmczAxMCIswqAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LMKgwqAgNCwgU0VDVF80Sykg
fSwNCj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVmczA0MCIswqAgSU5GTygweDFmNjYwNCwgMCwg
NjQgKiAxMDI0LMKgwqAgOCwgU0VDVF80SykgfSwNCj4+PiArwqDCoMKgwqDCoMKgIHsgImF0MjVm
czAxMCIswqAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LMKgwqAgNCwgU0VDVF80SyB8DQo+
Pj4gU1BJX05PUl9IQVNfTE9DSykgfSwNCj4+DQo+PiBodHRwczovL2RhdGFzaGVldHNwZGYuY29t
L3BkZi1maWxlLzU4NzE2NC9BVE1FTENvcnBvcmF0aW9uL0FUMjVGUzAxMC8xDQo+PiBCUCBiaXRz
IGFyZSBhdCBiaXQgMiwgMywgNSBhbmQgNi4NCj4+IEJQMCwgQlAxLCBCUDMsIEJQNCBhbmQgV1BF
TiwgYXJlIG5vbnZvbGF0aWxlIGNlbGxzDQo+Pg0KPj4+ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWZz
MDQwIizCoCBJTkZPKDB4MWY2NjA0LCAwLCA2NCAqIDEwMjQswqDCoCA4LCBTRUNUXzRLIHwNCj4+
PiBTUElfTk9SX0hBU19MT0NLKSB9LA0KPj4NCj4+IGh0dHBzOi8vZGF0YXNoZWV0c3BkZi5jb20v
cGRmLWZpbGUvNTg3MTY1L0FUTUVMQ29ycG9yYXRpb24vQVQyNUZTMDQwLzENCj4+IEJQIGJpdHMg
YXJlIGF0IGJpdCAyLCAzLCA0LCA1LCBhbmQgNi4NCj4+IEJQMCwgQlAxLCBCUDIsIEJQMywgQlA0
IGFyZSBub252b2xhdGlsZSBjZWxscw0KPj4NCj4+Pg0KPj4+IC3CoMKgwqDCoMKgwqAgeyAiYXQy
NWRmMDQxYSIsIElORk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCzCoMKgIDgsIFNFQ1RfNEspIH0s
DQo+Pj4gLcKgwqDCoMKgwqDCoCB7ICJhdDI1ZGYzMjEiLMKgIElORk8oMHgxZjQ3MDAsIDAsIDY0
ICogMTAyNCzCoCA2NCwgU0VDVF80SykgfSwNCj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjMy
MWEiLCBJTkZPKDB4MWY0NzAxLCAwLCA2NCAqIDEwMjQswqAgNjQsIFNFQ1RfNEspIH0sDQo+Pj4g
LcKgwqDCoMKgwqDCoCB7ICJhdDI1ZGY2NDEiLMKgIElORk8oMHgxZjQ4MDAsIDAsIDY0ICogMTAy
NCwgMTI4LCBTRUNUXzRLKSB9LA0KPj4+ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWRmMDQxYSIsIElO
Rk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCzCoMKgIDgsIFNFQ1RfNEsgfA0KPj4+IFNQSV9OT1Jf
SEFTX0xPQ0spIH0sDQo+Pg0KPj4gaHR0cHM6Ly9kYXRhc2hlZXRzcGRmLmNvbS9wZGYtZmlsZS85
NzUzMzEvQWRlc3RvL0FUMjVERjA0MUEvMQ0KPj4gR2xvYmFsIFByb3RlY3QvVW5wcm90ZWN0IHVz
aW5nIFdyaXRlIFNSIGNvbW1hbmQ6DQo+PiBHbG9iYWwgVW5sb2NrOiB3cml0ZSAweDAwIHRvIFNS
DQo+PiBHbG9iYWwgTG9jazogUmVhZCBTUi4gSWYgU1IuU1BSTCBpcyAxIHdyaXRlIDB4ZmYgdG8g
U1IsIGVsc2Ugd3JpdGUNCj4+IDB4N2YuDQo+IA0KPiBUaGF0IGlzIG5vdCBteSB1bmRlcnN0YW5k
aW5nLiBRdW90ZToNCj4gwqAgVG8gcGVyZm9ybSBhIEdsb2JhbCBQcm90ZWN0LCB0aGUgYXBwcm9w
cmlhdGUgV1AgcGluIGFuZCBTUFJMDQo+IMKgIGNvbmRpdGlvbnMgbXVzdCBiZSBtZXQsIGFuZCB0
aGUgc3lzdGVtIG11c3Qgd3JpdGUgYSBsb2dpY2FsIOKAnDHigJ0NCj4gwqAgdG8gYml0cyA1LCA0
LCAzLCBhbmQgMiBvZiB0aGUgU3RhdHVzIFJlZ2lzdGVyLg0KPiANCj4gQW5kDQo+IMKgIENvbnZl
cnNlbHksIHRvIHBlci1mb3JtIGEgR2xvYmFsIFVucHJvdGVjdCwgdGhlIHNhbWUgV1AgYW5kIFNQ
UkwNCj4gwqAgY29uZGl0aW9ucyBtdXN0IGJlIG1ldCBidXQgdGhlIHN5c3RlbSBtdXN0IHdyaXRl
IGEgbG9naWNhbCDigJww4oCdIHRvDQo+IMKgIGJpdHMgNSwgNCwgMywgYW5kIDIgb2YgdGhlIFN0
YXR1cyBSZWdpc3Rlcg0KPiANCj4gS2VlcCBpbiBtaW5kIHRoYXQgYml0IDUsIDQsIDMgYW5kIDIg
aXMgZXhhY3RseSB0aGUNCj4gQVRNRUxfU1JfR0xPQkFMX1BST1RFQ1RfTUFTSy4gVGhlIFNQUkwg
Yml0IGlzIGhhbmRsZWQgaW4gdGhlIHVubG9jaygpDQo+IGZ1bmN0aW9uLiBBY2NvcmluZyB0byB0
YWJsZSA5LjIgeW91IGFsc28gaGF2ZSB0byBmaXJzdCBkaXNhYmxlIHRoZSBTUFJMDQo+IGJpdCBh
bmQgdGhlbiB3cml0ZSB0aGUgQlAgYml0cyB0byB6ZXJvLg0KPiANCg0KV2UgdG9vayB0aGlzIG9u
IGlyYywgSSB0cnkgdG8gc3VtbWFyaXplIHRoZSBjb25jbHVzaW9uczoNCjEvIGZvciBnbG9iYWwg
dW5sb2NrIHByb3RlY3Qgd2UgaGF2ZSB0byBmaXJzdCBzZXQgU1BSTCB0byB6ZXJvLCBpZiBub3Qg
YWxyZWFkeQ0Kc2V0LCB0aGVuIHRvIHNldCB0aGUgQlAgYml0cyB0byB6ZXJvDQoyLyBmb3IgZ2xv
YmFsIGxvY2sgcHJvdGVjdCwgU1BSTCBhbmQgQlAgYml0cyBzaG91bGQgYmUgd3JpdHRlbiBpbiBv
bmUgc2hvdA0KMy8gY29uc2lkZXIgV1AjOiBzZXQgU1BSTCB0byAxIHdoZW4gc29tZXRoaW5nIGlz
IGxvY2tlZCwgc2V0IGl0IHRvIHplcm8NCmlmIG5vdGhpbmcgaXMgbG9ja2VkLg0KNC8gYXQyNWZz
MDEwIGFuZCBhdDI1ZnMwNDAgaGF2ZSBhIEJQbiBtZWNoYW5pc20gdGhhdCB1c2VzIEJQNCwgc2lt
aWxhciB0bw0Kd2hhdCB3ZSBoYXZlIGluIHNwaV9ub3Jfc3JfbG9ja2luZ19vcHMoKS4gV2UgZGVj
aWRlZCB0aGF0IGl0IGRvZXNuJ3Qgd29ydGgNCnRvIHBvbGx1dGUgdGhlIGNvcmUgZnVuY3Rpb24g
anVzdCBmb3IgdGhlc2UgZmxhc2hlcywgdGhleSB3aWxsIGhhdmUgdGhlaXINCm93biBmaXh1cCBo
b29rLiBXZSBjYW4ndCB1c2UgdGhlIGhvb2sgaW50cm9kdWNlZCBpbiAzLzMgYmVjYXVzZSB0aG9z
ZQ0KZmxhc2hlcyBhcmUgdXNpbmcgImluZGl2aWR1YWwgc2VjdG9yIHByb3RlY3Rpb24iLCBhbmQg
ZXZlbiBpZiB0aGUNCiJnbG9iYWwgcHJvdGVjdC91bnByb3RlY3QgZmVhdHVyZSIgaXMgY2xvc2Ug
dG8gd3JpdGluZyBhIDB4MCB0byBTUiwNCmV2ZW50dWFsbHkgdGhlICJpbmRpdmlkdWFsIHNlY3Rv
ciBwcm90ZWN0aW9uIiBsb2NraW5nIG1lY2hhbmlzbSBzaG91bGQgYmUNCmV4dGVuZGVkIHRvIGFs
c28gc3VwcG9ydCBpbmRpdmlkdWFsIHNlY3RvciBsb2NraW5nLg0KDQpJIGhvcGUgdGhhdCBJIGRp
ZG4ndCBtaXNzIGFueXRoaW5nLg0KdGENCg==
