Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC92C71B1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbgK1VvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:06 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:52165 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgK1S3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606588194; x=1638124194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ouP5a/uKnJmStFA7LiZNPy4eyH92/FCjeybl10hw7UY=;
  b=qQgonmuuX+b70/mllsRYUc4zCJzImHIS0iL4XW2W4xWzz1ud0OPkEDKR
   39VJnBB1TnI5Yen/AqIbhQ0+b7EmHtp7YLt2ulZY10OXMzUloxNPjjgwZ
   CMzII68laY+26s23sX20/XFkY3xgr/w/amM66AZhF5KTMK1LNpmO8N2Pv
   9LTDgNP1o0d+eK+JoL5Ry4UN8nvwK8+gMGCQH4bX76f4LOkSJxC5xwY12
   KPvxMs7B+1zbkHtjnjVT/NzsFVxl+Ha0pwRLHKzoqdo76eSJDNGDwKeTz
   1gHVYRSOjcdYLPBYK6FpJdbn08l8IJ4jMvLQ+QRjIAVkdFVetUHBdE9i2
   g==;
IronPort-SDR: 2PF6SrU0jnZc7EpGiV8OytWGIzzE8c25EbzKlJpyh0wDrWbNrtWz9tua5HoupOFcIJb1FfsHTz
 1iNsHBNarpCkkGC6MGKIlue/gpTB7+y14zHeNhkMLLcSD2nB0kkEORVM2dmMv7euDSVUID9/bz
 nSlDtu2sSn0CiiyL/+ERRs5cYgsulic7k9m81752Dz/AOvzd2arQF2SyOkUC+H9cLCc3galDbo
 +SbgJpzuIa0Vlwqcm1trG9z7Yhem9qJnKivSpLgglWB4b6H0KC7oYyxF/TkqxIzyj/OgUhp5Is
 l+s=
X-IronPort-AV: E=Sophos;i="5.78,377,1599548400"; 
   d="scan'208";a="97847516"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2020 01:25:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 28 Nov 2020 01:25:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Sat, 28 Nov 2020 01:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyTWWnNJGfdwfyECKZaN1W94uor2JO4qwHskHfKm8y/LxmSJ5A2FjUemEbCGYTreVvSXZghimr8ICfdTVep0nUKovjXwUAWqMknLH8tQd+FioFid0vVUWAM2m0swKVZI166gLYt7Rk93UjDz+XMSiN16Dk8zunpEfRw6HQbIHn7KPC9EwZfwp2Q6GvKA2t/RIb89LH08UWPKMz3EWGugWfdKNwUkcTwMGVnF8YxCAaZ4N1UQii/PP+nVaYYbpPX2jxXZr3mgnHwUZsZLk/wQahF829iNKo8DSekDQwkDjS7oT92KK4xl+aaG/DzZtsX0/ZWCFXSYdpW0W7Wq7vqfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouP5a/uKnJmStFA7LiZNPy4eyH92/FCjeybl10hw7UY=;
 b=efOZ5mjSbx+Ce07DmDu7YX+5zKReUGoy17ghiukoHzyG1702aidjvG0LFZ01/yBUrW+zPSTyXxpyYxR5TxrUtgaJnBwcKdvzUBleWbUjq2V25R7z0FTxNOZFLfh1MZ/A4wTOb8TPQ/WaTYjDZu2gIIEDHYpeXURRr5+sNcgrhWlwMo1fg3ir3KF49dhUt8f6Z8Yhb8w89uJpuqKuXc41g7oMlHbJ+PnvXr8cPIc9d/KPMzrMMHU8RXO7pqqro4IVdgZUQWXZmAj+GxFYYo4wVpYkL+kDDxuhrw95D5osmpg7R0xBmvtskr+dtoqRWnhjQ5vM7+aajxVSyOts/Ay+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouP5a/uKnJmStFA7LiZNPy4eyH92/FCjeybl10hw7UY=;
 b=ZYtaHiKrD6i4WMVqyFEOzVWW5MTVOg4k3Rc0qB5O96i6nVfI8PIfAA1WkYVuzaBKc6dPQkO02QxE3uTazVTogxCnIuBhY1SZKqSf2RJkz19DfVZ3J9qxhBeS2ksfhfFcx8Szl8lHGHw3s+mJJfFG6ikLAiX68uccfMUrlhrngT4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Sat, 28 Nov
 2020 08:25:09 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3611.021; Sat, 28 Nov 2020
 08:25:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v6 4/5] mtd: spi-nor: atmel: Fix unlock_all() for
 AT25FS010/040
Thread-Topic: [PATCH v6 4/5] mtd: spi-nor: atmel: Fix unlock_all() for
 AT25FS010/040
Thread-Index: AQHWxV/7Y2BwcnWnOEKyWKfbGcieMg==
Date:   Sat, 28 Nov 2020 08:25:09 +0000
Message-ID: <ba9850c1-a684-6376-7331-2e09567dcb73@microchip.com>
References: <20201126202614.5710-1-michael@walle.cc>
 <20201126202614.5710-5-michael@walle.cc>
In-Reply-To: <20201126202614.5710-5-michael@walle.cc>
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
x-ms-office365-filtering-correlation-id: b33661d6-92a2-45ac-6879-08d893771ea0
x-ms-traffictypediagnostic: SA2PR11MB5116:
x-microsoft-antispam-prvs: <SA2PR11MB51163801FD6E12D7B814B9F9F0F70@SA2PR11MB5116.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XBixhVs7Ie54+uBGGxMahrPDoazwOUKaQjYSizwZSnGE9Rw7tVA6lWlN134AlHxDBH1O3Nemasv77M12BNm2wRE1TtSzKQ8RXgSE1gFWNgL/HM1PWNKa4M9++/E5PnHjPsg7iHLLB6SG+ElzML5m+TKFLNcAsJ/zumVuFuO8ZaEEMdePMAPuAJrptkkQJMQvHKHYJSPjyE0JCga/i5dTn59t4YSzVb4lYY0fBzxHmWpVpUfIPdRAvz7IOZbM6VjyJkFKsflhH8uou5bxiTfvY1iPbMW6i3dZhNYfmM/r4pziykG4nAm51RPxNZEDleMb1k4RSLRKXGxMJQF9cNVPhM1WbcF1l9hhycrRr45Ad9un3XedjQ38dsikMb0ZSlrf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(26005)(86362001)(316002)(66946007)(53546011)(6486002)(8676002)(83380400001)(6506007)(36756003)(71200400001)(31686004)(76116006)(8936002)(5660300002)(54906003)(2906002)(110136005)(478600001)(31696002)(2616005)(6512007)(66556008)(66476007)(64756008)(186003)(4326008)(66446008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OVdqdVM5OVNKSEhsR3VrOWRwU3RZQ2hxRHFhZFppWUxGNXY4Q1FTOTFTUG1V?=
 =?utf-8?B?bkJoeU9OZ0NBME52aC9PK1lJa1BYNVhLV1dnQWJlMzVVSEhNVzlINVRpbDlS?=
 =?utf-8?B?K2lwVVAvR0ZkZFplYUdyTzZnbEtRUUNHMWhPN04wR1RXV3dJaXpXRzdDMVVX?=
 =?utf-8?B?YmxRZmN4WjVHcHRWNzNMZ1hiQ29adE42RDFXNkpoaFMyNmhjVHlwWFE5dE1m?=
 =?utf-8?B?MEs5dWtnT3Urb2RFbEdrd2pxVG5EQzhISTdEU1JtcmlQUHFtTWxjYVZzcHA1?=
 =?utf-8?B?cFUvRlVmM3VQZWIzdmxxaTd5eDBHeGM3OTExMnBqcVYxOVE0Mm1LejN4ZDV1?=
 =?utf-8?B?QXI4SFJNb1pWK3MxSnRvZDVTbXpsbi9oQXpjSWZLbXlOQTJ5RFI2WmJCS0lV?=
 =?utf-8?B?TzgyYnJpbmlHTGptT1U4SUZLbFY0NEIvemtzVWpzQlBjNjhoV3VoMG9nZ3ps?=
 =?utf-8?B?QkNtUFQ3eHpDS1M4V2ZLWE0vYjMxRVRLMUZqejM1OE5IZHlMVFhGVXRpcVEv?=
 =?utf-8?B?T3dQZFltT0RTRld6S1E2Q1NreDBVSTUxQkN4bzVuRFZzY0g3eDJnRWNxWFdt?=
 =?utf-8?B?Ly9QSklXYU9tcTZ2NndBUzYybWNYL3hEdFY2bnRwOVQ5UEs5MDJVTzR1WC9n?=
 =?utf-8?B?QUE5ZC9qUjB0Y0swSXNxZ2JLWnlzeGpLV2hrUzVmM01KMFp0ckxwNHhjOTFz?=
 =?utf-8?B?T2xQbU9SYUovSElHeWZSQ3pCdVc4amhvZVc0TUFDZDMvL1ZIQ0FmSkVqNDAr?=
 =?utf-8?B?T2gxakYxa0t5dlM0Z0hpS2JxQk5wM2lSQWlPb3pRQzYwYlFCNGxLZWJRMEMy?=
 =?utf-8?B?U1UvVWdQd25RQWZWTWoyZXJuWW5zM3dkQS9iTTBvZ3BIUi9pVUtQT1Iwd2Nw?=
 =?utf-8?B?ZHZUajU2c1ZiSzgwR3hhelVMeC9vNm1mdEl0L0xVRmk1SEZteUdEUzkrTEhC?=
 =?utf-8?B?VGcrdDc3cjNqT09oSW5pWEVOZzVPZUFGNUxKeVJHYlk4V0p5a3RxYTV3RXVu?=
 =?utf-8?B?c3hvcEJSYXZ0SFVHTXdFUStZaVl3MFpJQUx5NFRKR3Z6aUhjNDUvTE8wRDJs?=
 =?utf-8?B?VGYrbHExVlVnSEJsWnk3dzRpcW9QSU1uNm9kdE5GSXpFVkNhdWpZYjYxMEd1?=
 =?utf-8?B?Wk9YUTlaUlVuMGczZURvVnlPZXI2UVYxeFAxSW5PZjdVU2UxU2NUZFdaUlhU?=
 =?utf-8?B?NjIwZG5ucDRyM3YvSWFIUWNTOG9DT2REZk9udDNTZ0drd1pnaXVZVjJ3WFdm?=
 =?utf-8?B?LzlzT0d4bnNybU1tWUtXV0ZiVVJiL1ZZN0U0clhscytxMTlOb0ZKMDlzalJE?=
 =?utf-8?Q?HeTmXHS/ohPak=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E882EB300FF8DE498957431E33005E4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33661d6-92a2-45ac-6879-08d893771ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2020 08:25:09.6339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gtm/DD0yfGzeBSCpz6TE/4g24ls7it3Q7iSAJQde2x33cVqmr5i51bz0sNGlhbKEbK78tDjdmBDQ2EhNptCm/8XWWXTuBGG+Mm7a0wsGR34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjYvMjAgMTA6MjYgUE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlc2UgZmxhc2hlcyBoYXZlIHNvbWUgd2Vp
cmQgQlAgYml0cyBtYXBwaW5nIHdoaWNoIGFyZW4ndCBzdXBwb3J0ZWQgaW4NCj4gdGhlIGN1cnJl
bnQgbG9ja2luZyBjb2RlLiBKdXN0IGFkZCBhIHNpbXBsZSB1bmxvY2sgb3AgdG8gdW5wcm90ZWN0
IHRoZQ0KPiBlbnRpcmUgZmxhc2ggYXJyYXkgd2hpY2ggaXMgbmVlZGVkIGZvciBsZWdhY3kgYmVo
YXZpb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxl
LmNjPg0KPiAtLS0NCj4gY2hhbmdlcyBzaW5jZSB2NQ0KPiAgLSBuZXcgcGF0Y2gNCj4gDQo+ICBk
cml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAgfCAgMiArLQ0KPiAg
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggIHwgIDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvYXRtZWwuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvYXRtZWwuYw0KPiBp
bmRleCA0OWQzOTJjNmM4YmMuLmZlNmE0NjUzODIzZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
dGQvc3BpLW5vci9hdG1lbC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvYXRtZWwuYw0K
PiBAQCAtOCwxMCArOCw1OSBAQA0KPiANCj4gICNpbmNsdWRlICJjb3JlLmgiDQo+IA0KPiArLyoN
Cj4gKyAqIFRoZSBBdG1lbCBBVDI1RlMwMTAvQVQyNUZTMDQwIHBhcnRzIGhhdmUgc29tZSB3ZWly
ZCBjb25maWd1cmF0aW9uIGZvciB0aGUNCj4gKyAqIGJsb2NrIHByb3RlY3Rpb24gYml0cy4gV2Ug
ZG9uJ3Qgc3VwcG9ydCB0aGVtLiBCdXQgbGVnYWN5IGJlaGF2aW91ciBpbiBsaW51eA0KPiArICog
aXMgdG8gdW5sb2NrIHRoZSB3aG9sZSBmbGFzaCBhcnJheSBvbiBzdGFydHVwLiBUaGVyZWZvcmUs
IHdlIGhhdmUgdG8gc3VwcG9ydA0KPiArICogZXhhY3RseSB0aGlzIG9wZXJhdGlvbi4NCj4gKyAq
Lw0KPiArc3RhdGljIGludCBhdG1lbF9hdDI1ZnNfbG9jayhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBs
b2ZmX3Qgb2ZzLCB1aW50NjRfdCBsZW4pDQo+ICt7DQo+ICsgICAgICAgcmV0dXJuIC1FT1BOT1RT
VVBQOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGF0bWVsX2F0MjVmc191bmxvY2soc3RydWN0
IHNwaV9ub3IgKm5vciwgbG9mZl90IG9mcywgdWludDY0X3QgbGVuKQ0KPiArew0KPiArICAgICAg
IC8qIFdlIG9ubHkgc3VwcG9ydCB1bmxvY2tpbmcgdGhlIHdob2xlIGZsYXNoIGFycmF5ICovDQo+
ICsgICAgICAgaWYgKG9mcyB8fCBsZW4gIT0gbm9yLT5wYXJhbXMtPnNpemUpDQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICog
V3JpdGUgMHgwMCB0byB0aGUgc3RhdHVzIHJlZ2lzdGVyIHRvIHRyeSB0byBkaXNhYmxlIHRoZSB3
cml0ZQ0KPiArICAgICAgICAqIHByb3RlY3Rpb24uIFRoaXMgd2lsbCBmYWlsIGlmIFNSV0QgKHRo
ZSBkYXRhc2hlZXQgY2FsbHMgaXQgV1BFTikgaXMNCj4gKyAgICAgICAgKiBzZXQuIEJ1dCB0aGVy
ZSBpcyBub3RoaW5nIHdlIGNhbiBkby4NCj4gKyAgICAgICAgKi8NCg0KY2FuJ3Qgd2UgZG8gdGhl
IHNhbWUgYXMgeW91IGRpZCBpbiA1LzU/DQorICAgICAgIHJldCA9IHNwaV9ub3JfcmVhZF9zcihu
b3IsIG5vci0+Ym91bmNlYnVmKTsNCisgICAgICAgaWYgKHJldCkNCisgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Ow0KKw0KKyAgICAgICBzciA9IG5vci0+Ym91bmNlYnVmWzBdOw0KKw0KKyAgICAg
ICBpZiAoc3IgJiBTUl9TUldEKSB7DQorICAgICAgICAgICAgICAgc3IgJj0gflNSX1NSV0Q7DQor
ICAgICAgICAgICAgICAgcmV0ID0gc3BpX25vcl93cml0ZV9zcl9hbmRfY2hlY2sobm9yLCBzcik7
DQorICAgICAgICAgICAgICAgaWYgKHJldCkNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQorICAgICAgIH0NCg0KSWYgU1JXRCBpcyBzZXQgdG8gMSwgd2UgZmlyc3QgdHJ5IHRv
IHNldCBpdCB0byAwLiBJZiBXUCMgaXMgYXNzZXJ0ZWQsIHdlDQp3aWxsIGNhdGNoIHRoaXMgaW4g
c3BpX25vcl93cml0ZV9zcl9hbmRfY2hlY2soKQ0KDQo+ICsgICAgICAgbm9yLT5ib3VuY2VidWZb
MF0gPSAwOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHNwaV9ub3Jfd3JpdGVfc3Iobm9yLCBub3It
PmJvdW5jZWJ1ZiwgMSk7DQoNCmFuZCB0aGVuIHlvdSBjYW4gdXNlIHNwaV9ub3Jfd3JpdGVfc3Jf
YW5kX2NoZWNrIGhlcmUNCg0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGF0bWVsX2F0MjVmc19p
c19sb2NrZWQoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IG9mcywgdWludDY0X3QgbGVuKQ0K
PiArew0KPiArICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBzcGlfbm9yX2xvY2tpbmdfb3BzIGF0bWVsX2F0MjVmc19sb2NraW5nX29w
cyA9IHsNCj4gKyAgICAgICAubG9jayA9IGF0bWVsX2F0MjVmc19sb2NrLA0KPiArICAgICAgIC51
bmxvY2sgPSBhdG1lbF9hdDI1ZnNfdW5sb2NrLA0KPiArICAgICAgIC5pc19sb2NrZWQgPSBhdG1l
bF9hdDI1ZnNfaXNfbG9ja2VkLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIHZvaWQgYXRtZWxfYXQy
NWZzX2RlZmF1bHRfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiArew0KPiArICAgICAgIG5v
ci0+cGFyYW1zLT5sb2NraW5nX29wcyA9ICZhdG1lbF9hdDI1ZnNfbG9ja2luZ19vcHM7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgYXRtZWxfYXQyNWZz
X2ZpeHVwcyA9IHsNCj4gKyAgICAgICAuZGVmYXVsdF9pbml0ID0gYXRtZWxfYXQyNWZzX2RlZmF1
bHRfaW5pdCwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBh
dG1lbF9wYXJ0c1tdID0gew0KPiAgICAgICAgIC8qIEF0bWVsIC0tIHNvbWUgYXJlIChjb25mdXNp
bmdseSkgbWFya2V0ZWQgYXMgIkRhdGFGbGFzaCIgKi8NCj4gLSAgICAgICB7ICJhdDI1ZnMwMTAi
LCAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LCAgIDQsIFNFQ1RfNEsgfCBTUElfTk9SX0hB
U19MT0NLKSB9LA0KPiAtICAgICAgIHsgImF0MjVmczA0MCIsICBJTkZPKDB4MWY2NjA0LCAwLCA2
NCAqIDEwMjQsICAgOCwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+ICsgICAgICAg
eyAiYXQyNWZzMDEwIiwgIElORk8oMHgxZjY2MDEsIDAsIDMyICogMTAyNCwgICA0LCBTRUNUXzRL
IHwgU1BJX05PUl9IQVNfTE9DSykNCj4gKyAgICAgICAgICAgICAgIC5maXh1cHMgPSAmYXRtZWxf
YXQyNWZzX2ZpeHVwcyB9LA0KPiArICAgICAgIHsgImF0MjVmczA0MCIsICBJTkZPKDB4MWY2NjA0
LCAwLCA2NCAqIDEwMjQsICAgOCwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spDQo+ICsgICAg
ICAgICAgICAgICAuZml4dXBzID0gJmF0bWVsX2F0MjVmc19maXh1cHMgfSwNCj4gDQo+ICAgICAg
ICAgeyAiYXQyNWRmMDQxYSIsIElORk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCwgICA4LCBTRUNU
XzRLIHwgU1BJX05PUl9IQVNfTE9DSykgfSwNCj4gICAgICAgICB7ICJhdDI1ZGYzMjEiLCAgSU5G
TygweDFmNDcwMCwgMCwgNjQgKiAxMDI0LCAgNjQsIFNFQ1RfNEsgfCBTUElfTk9SX0hBU19MT0NL
KSB9LA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCA1YmVlN2M4ZGE0ZGMuLjhjMDZhMjhhOTBkZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTg2MSw3ICs4NjEsNyBAQCBpbnQgc3BpX25vcl93
YWl0X3RpbGxfcmVhZHkoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gICAqDQo+ICAgKiBSZXR1cm46
IDAgb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZS4NCj4gICAqLw0KPiAtc3RhdGljIGludCBz
cGlfbm9yX3dyaXRlX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0IHU4ICpzciwgc2l6ZV90
IGxlbikNCj4gK2ludCBzcGlfbm9yX3dyaXRlX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0
IHU4ICpzciwgc2l6ZV90IGxlbikNCj4gIHsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmgNCj4gaW5kZXggMGE3NzVhN2I1NjA2Li4xNmIzNTBlMWQ4NjUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1u
b3IvY29yZS5oDQo+IEBAIC00MzAsNiArNDMwLDcgQEAgdm9pZCBzcGlfbm9yX3VubG9ja19hbmRf
dW5wcmVwKHN0cnVjdCBzcGlfbm9yICpub3IpOw0KPiAgaW50IHNwaV9ub3Jfc3IxX2JpdDZfcXVh
ZF9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcik7DQo+ICBpbnQgc3BpX25vcl9zcjJfYml0MV9x
dWFkX2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKTsNCj4gIGludCBzcGlfbm9yX3NyMl9iaXQ3
X3F1YWRfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpub3IpOw0KPiAraW50IHNwaV9ub3Jfd3JpdGVf
c3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgY29uc3QgdTggKnNyLCBzaXplX3QgbGVuKTsNCj4gDQo+
ICBpbnQgc3BpX25vcl94cmVhZF9zcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCAqc3IpOw0KPiAg
c3NpemVfdCBzcGlfbm9yX3JlYWRfZGF0YShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgZnJv
bSwgc2l6ZV90IGxlbiwNCj4gLS0NCj4gMi4yMC4xDQo+IA0KDQo=
