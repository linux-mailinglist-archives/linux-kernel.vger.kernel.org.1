Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781522CBF24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbgLBOKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:10:14 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:14755 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389011AbgLBOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606918212; x=1638454212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C30ENq3xnNGNTpXTE04W76mr0TERGoYqyVlpPlDvCfo=;
  b=NLoICA/ZWFzDq/TTC6SCxY+sNRHaxQ3vOSRwOS0MvCSsy1kSCmVun40l
   x9YKccQRihfa1tsiaJzTVNLEReJBElc6gm2X+udQqSO9wAklIY8uOHZzX
   9S0eXwWku9xCVMXzhotbc4KLpFhixYwFFsrB7xb4LcYsLWydWY+1v7Am8
   Y9vVBl3E8U6ocf7icSYjEaU/z9Y4BQuQUyajpZAj7D/PUoZCKPr5GyrsV
   caBCll7zMg8tS6Kjt1ZEE0NSEr9aMPohEgPVpDXZedWBJXT/eN5nC+ssg
   GvLypofGg3JR0OdUq2YWgMV6vvRsNVjQxacw03r2woUE0UTFX4jRuE43e
   Q==;
IronPort-SDR: O+mgS+0U3adoP/lt3DH2Vao5UUnuTo+INhC5Ou0FLZwnUGBVfOIePb8ccq7h9cao/qKmDn62Gc
 tmDQ366W1bJrsdC399TXWRm+JbHjUCr3wxh6FBWON919aNzsKRb8EnglPMOo2yBFW+/dwjaIcz
 L+PjroR3CBoUKCtgBhBF1MBSgsrP7Jp609Ci1fOx6Dg3O8l581rEg3B/E+UA6mjba8hcIauU+/
 kGbA1jZA35lFO8kXztF8RRJHl83mCE7NThsKyZ0Uvjr0BPe1ILX6/fN0erNFnrSI5pHZtl8aGw
 A08=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="105845985"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 07:09:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 07:09:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 2 Dec 2020 07:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VovlEv7ZlMyZBlgaoc3jcVGXC0Kf8N2LSraAhL+wM3uHKln7zYuURIeIaMz2G7dAN3sYavaRisOuMcsB2MqLkh2D33VUT1sa5h3sh8hENNCxjpjebWsZM94p8wWAqpI6zvxARag+QNE6ESLczAPGc8U//l25wCrxGrvw6GDqaE7e2rPZZaQT9zIkNw5nZS6Y1gl/Ui9N4lsLR0wCNg5mAz4fappTICj3oQNj1187CR4mHWYq9EJYj5v9Y/Qlf1edgg5h499+v4C+d82WqeQNeXqpPsVe/twtZcgXMJ/1lnXANTqyPR+GQmaTxw+clqhIqOj8JqSjRK8GWZ2Q65ijvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C30ENq3xnNGNTpXTE04W76mr0TERGoYqyVlpPlDvCfo=;
 b=TaYLJOMZZfIyP5nxXsDmOxoEjvPnLHq6zqCoomPSVzO2OiM7H/ydI+CP3ep167edzlrnKvaduoJNFzHtbvqs3PjkXtAtqmMljCvSQ51rkbNXretwsqYk+hy/pE+uob8RCmTFssLRCqTf5xuLuDfOrvrWHMQwEoj44QvBERDAUP4MAQrRIXiJS1a5HaDIXgdnMF40sMJnkObEEPWwAuZYzzljDKVENsD9ck7styp5SEFkSksUrQveYxZxHi/AlJr1fikQwgNYg2CK98W8ew411Vsia86NYb9kK6z8j4GgXykDBqERFsJrQEj75nvDBC0hVfQvFQf8/BFZYnJh+OvSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C30ENq3xnNGNTpXTE04W76mr0TERGoYqyVlpPlDvCfo=;
 b=JCupKYa4Q+e/1UNRNB9n4J4fPaC3ld4nq3KlFxEvifp+54qNSYeU/eNmXIA8xJgVwKE9JA5+ksOKvHHERImOmOemm7i2H2KWakFBBUXixxxseuZwIvmId+0djdlLuq+7rQhUYkTTSdRPvfJSH4VfcPil/b+NnSKwEaDjgcdvdNk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3021.namprd11.prod.outlook.com (2603:10b6:805:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Wed, 2 Dec
 2020 14:09:03 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3632.017; Wed, 2 Dec 2020
 14:09:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v6 5/5] mtd: spi-nor: keep lock bits if they are
 non-volatile
Thread-Topic: [PATCH v6 5/5] mtd: spi-nor: keep lock bits if they are
 non-volatile
Thread-Index: AQHWxW+nmejBYVo+OESi/M9WLE7bHw==
Date:   Wed, 2 Dec 2020 14:09:03 +0000
Message-ID: <b490ed3a-c3ac-7fa6-cab1-161a74b15fe4@microchip.com>
References: <20201126202614.5710-1-michael@walle.cc>
 <20201126202614.5710-6-michael@walle.cc>
 <432b31a7-2560-3b83-44d2-aa82c2e322ae@microchip.com>
 <46c99138eb6ce251bc741d358388c219@walle.cc>
 <8e0a6a20-2779-9397-eedf-02518b4a0e5a@microchip.com>
 <fe04f234584c2f459e865955b0d09303@walle.cc>
In-Reply-To: <fe04f234584c2f459e865955b0d09303@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d45eae0-3a46-44b3-c4aa-08d896cbd2cf
x-ms-traffictypediagnostic: SN6PR11MB3021:
x-microsoft-antispam-prvs: <SN6PR11MB3021020D494309A3DE1C9276F0F30@SN6PR11MB3021.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUXyRg5vsGG9Bg3XvJnHGXDECkmM+GwwHx1/v60PnssOx9hzjFhnQw0YET9srVkNINS8OKa2Gov6jm9Hs8Bmml6nKs+Wdn/+LDQsFXcSLJMPqPrHxxMiJBWIceVMKEO7KXX4gKFYX3GcfHvPykERwQvW62IQ3Wp1FCU/i84DUlk8iPFV1UK9PzXy4dC2UXoH+5hBs2opNMawziPGOENV3GN8SHjt7dRSTA57LNqiIBSg/Im6Va+c6MtWvgwIZrPzYzMMw0nbzC9TxCgn08nnWfzzq8SRK7CSJA7pk8LlXAz/Yr/2Zgm3oC2afpQPjNdsesB0n7i+wA/fhEJFVXM/3Gxl1mf2NhI27YJjX2Z8Ebb2yUSSP7oU34SRlGBf0az53vQxiQ3f1GqAXtmeHhzDrtajNZIHGeIk7CeV5F+iX3w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(186003)(6506007)(6916009)(53546011)(2906002)(4326008)(6512007)(86362001)(83380400001)(36756003)(31686004)(316002)(5660300002)(2616005)(54906003)(26005)(8936002)(66446008)(76116006)(66946007)(64756008)(66556008)(478600001)(66476007)(71200400001)(8676002)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NjFvNmtZMU5EdWw2dG56SEFQNDNFWnovaVdacDJZUy9aNDFteWxJbk5ROU0w?=
 =?utf-8?B?SEdRbkJ4c2FMdGNOWEplb0VuS2YwT1o2aE9tRFZ4dC9hcXpwU21oKzJZaWVE?=
 =?utf-8?B?Y0d3VTNkaDIxY0JHTEJlcXpJSGlNeTNoSlJtdmhjU2paVERBSld5alc3cVoy?=
 =?utf-8?B?Q0dBL1RMZHR5eU9UTWJoUGJrckJ1QXJISjRld3Jqc25KZVVWMUZHNGFrVTU3?=
 =?utf-8?B?dTBIaUoxQ2Z6eUM3K0VaeUEzWmJyK2VoWEpGREpLRElkVGpLTzhDV01wVVJZ?=
 =?utf-8?B?OXk2czNiNzJHYVd3WmdRNWtma01IS3FIQnZrb0JNMnVJYmkrUE1NaXErZml6?=
 =?utf-8?B?Z1dDempDclptR250dG5GV2ZueEVWWjgrc3dsTnVnV2ZiWW1pZjQ5WUVjVUQ5?=
 =?utf-8?B?RlJVVFhDeTV1MkRVN3BTaUM1TDhoV2szRGJ3U3ZyN29jSFNjZEh2ZGtTU1Rn?=
 =?utf-8?B?VFNpSGdGZTZtWmlQRGZ3ZHlkMG1hQ2JQcXViSG1Kb1NjdGNHYjc5YzFmYlBy?=
 =?utf-8?B?RUVaZU1PeFV0MjlITTkzeTQ4aXVVTGJpYXVWbTFQbTR3d2xBblk5NEVaOFFr?=
 =?utf-8?B?cHZHQmZjUG9ISkNsSzBER1U4UE5sbEJzVXM1ck01UjNkWTZRMFpVM2JLUWpv?=
 =?utf-8?B?cU12Nzh4UWp1MEVXbHVxOVB3dEpwbW9Qa3lVTFhjQkFORjQzRTROaTUrYmUw?=
 =?utf-8?B?RStNaXY3TGVkV2lhTHRHR2FncEJRaDFpMkJMOG9NaEdIVE1tTlQrMkx5c3I3?=
 =?utf-8?B?bFRvUkZZcVZpNWZ5blIzTjVjeHJ5SWYweS84bnl3L1VGZEcwWHFGaWtyYWhM?=
 =?utf-8?B?RHU1QTdZb21hbkFObnJqRzR3bngrcEU3UWNZVnYwdEgrZy9ZSXBTZ1lwTkZ4?=
 =?utf-8?B?YkhLNHZjcFVrNlZPYUV4Vk0yNG1jVmlhNllDZnE5dllIdndRVGp6bG1kNExv?=
 =?utf-8?B?dURmYlNMOUxoQzVOZXhBRHltbGU2ejRNbTFKbGNCU0lvQ3JIVWJOODJ3N3BL?=
 =?utf-8?B?cjRJSFBjcTR5cElNejZITFVXWm10cVArMkRKR09LcDlZWGV3c3oxck11d24z?=
 =?utf-8?B?Y2ZLQkc2bk9zemVNenBYZUJGaXNDc2RPWjlmc1BrUlplWnNuTjV5WkRLS0Mx?=
 =?utf-8?B?WXgwQ1NmekVONTd0THlraFNXNVZhUys0UDR6bEdTZ3hYSDdDbGhlZHlMSXFV?=
 =?utf-8?B?WURPNGVBQ01ST040YTdmOUkvTUhIb2hmTXg5L0pSOGRsbFg2UjVWdFl2WmdF?=
 =?utf-8?B?TlJjWkVjeXAwWGhDeHdacWpTTmd3TlZLWGcwdDV0bmVjWEIxY01ldjdPS1Jl?=
 =?utf-8?Q?507i+LUhb1a6I=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C5E56C4D1E18419DC6E4BE3F95A827@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d45eae0-3a46-44b3-c4aa-08d896cbd2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 14:09:03.1637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c58T4ZYqFgu+q//vvKdlvI8H2U/rop9c5AHvwbrVk/tPlBzhMvc0PAxmvj75S/6fDeoswPuHNWnTSjMTf2gVzwSMZSxBMngm9u2PjjQWjhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMi8yMCAxOjI1IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFtIDIwMjAtMTItMDIgMTI6MTAsIHNjaHJpZWIg
VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4gT24gMTEvMzAvMjAgNDozOCBQTSwgTWlj
aGFlbCBXYWxsZSB3cm90ZToNCj4gWy4uXQ0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgICogaW5kaWNh
dGVkIGJ5IFNOT1JfRl9XUF9JU19WT0xBVElMRS4NCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAqLw0K
Pj4+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfTVREX1NQSV9OT1JfV1Bf
RElTQUJMRSkgfHwNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAoSVNfRU5BQkxFRChDT05G
SUdfTVREX1NQSV9OT1JfV1BfRElTQUJMRV9PTl9WT0xBVElMRSkNCj4+Pj4+ICYmDQo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub3ItPmZsYWdzICYgU05PUl9GX1dQX0lTX1ZPTEFUSUxF
KSkgew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gc3BpX25vcl91
bmxvY2tfYWxsKG5vcik7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
ZXJyKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2Vycihub3ItPmRldiwgIkZhaWxlZCB0byB1bmxvY2sgdGhlDQo+Pj4+PiBlbnRpcmUN
Cj4+Pj4+IGZsYXNoIG1lbW9yeSBhcnJheVxuIik7DQo+Pj4+DQo+Pj4+IGRldl9kYmcgZm9yIGxv
dyBsZXZlbCBpbmZvDQo+Pj4NCj4+PiBJcyB0aGlzIGxvdyBsZXZlbCBpbmZvIG9yIGFuIGFjdHVh
bCBlcnJvcj8gV2hpY2ggcmFpc2VzIHRoZSBxdWVzdGlvbjoNCj4+PiBzaG91bGQgc3BpX25vcl91
bmxvY2tfYWxsKCkgaW4gY2FzZSBTV1JEIGNvdWxkbid0IGJlIGNsZWFyZWQgYW5kIHRodXMNCj4+
PiBzaG91bGQgYWxsIHRoZSBzcGlfbm9yX2luaXQgZmFpbCBvZiB0aGlzPyBPciBzaG91bGQgaXQg
cmF0aGVyIGJlIGENCj4+DQo+PiB5ZXMsIGl0IHNob3VsZCwgYmVjYXVzZSB0aGUgZmxhc2ggd2ls
bCBub3Qgd29yayBhcyBleHBlY3RlZC9yZXF1ZXN0ZWQuDQo+IA0KPiBPbmUgY291bnRlcmFyZ3Vt
ZW50OiB0YWtlIG91ciBzbDI4IGJvYXJkLCBpdCBoYXMgYSBoYXJkd2FyZQ0KPiB3cml0ZS1wcm90
ZWN0ZWQNCj4gU1BJIGZsYXNoLiBJdCBhY3R1YWxseSB3b3JrcyByaWdodCBub3cgYmVjYXVzZSB0
aGUgd3JpdGVfc3JfYW5kX2NoZWNrKCkNCj4gZG9lc24ndCB3b3JrIGFzIGludGVuZGVkIGFuZCBk
b2Vzbid0IGNoZWNrIHdoYXQgaXMgd3JpdHRlbi4gU28gaWYgeW91J2QNCj4gZml4IHRoYXQgKGFu
ZCB0aGVzZSBjaGFuZ2VzIHdvdWxkIGJlIGJhY2twb3J0ZWQgdG8gdGhlIHN0YWJsZSB0cmVlcyks
DQo+IHlvdSdkDQo+IGJhc2ljYWxseSBicmVhayBzcGktbm9yIG9uIHRoZXNlIGJvYXJkcy4gQW5k
IHRoaXMgX211c3RfIGJlIHRoZSBjYXNlIGZvcg0KPiBhbGwgYm9hcmRzIHdoaWNoIGFyZSBhY3R1
YWxseSB1c2luZyAoaGFyZC0gb3Igc29md2FyZSkgd3JpdGUtcHJvdGVjdGlvbi4NCj4gVGhhdCBp
cyB0aGUgb25seSB3YXkgd3JpdGUtcHJvdGVjdGlvbiBtYWtlcyBzZW5zZSBwcmlvciB0byB0aGlz
IHBhdGNoDQo+IHNlcmllcy4gQmVjYXVzZSBsaW51eCB3aWxsIGhhcHBpbHkgdW5sb2NrIGV2ZXJ5
IGZsYXNoIG9uIHN0YXJ0dXAuDQo+IFRoZXJlZm9yZSwNCj4gdGhlIGhhcmR3YXJlIHdyaXRlIHBy
b3RlY3Rpb24gaXMgdGhlIG9ubHkgbWVhc3VyZSBhZ2FpbnN0IHRoaXMuDQo+IA0KDQpJIHNlZS4g
SWYgV1AjIGlzIGFzc2VydGVkLCBzcGlfbm9yX3VubG9ja19hbGwoKSB3b3VsZCBmYWlsIGFuZCB3
b3VsZCBzdG9wDQp0aGUgZXhlY3V0aW9uLiBPbmUgY2FuIGF2b2lkIHRoZSBmYWlsIGJ5IGNob29z
aW5nIE1URF9TUElfTk9SX1NXUF9LRUVQLA0KYnV0IHRoYXQgd291bGQgbm90IGJlIGJhY2t3YXJk
IGNvbXBhdGlibGUuIEhhdmluZyBpbiBtaW5kIHRoYXQgaW4gdGhlDQpwYXN0IHRoZSB1bmxvY2sg
YWxsIHdhcyBqdXN0IGEgemVybyB3cml0dGVuIHRvIFNSLCB3aXRob3V0IGNoZWNraW5nIGlmDQp0
aGUgd3JpdGUgd2FzIHN1Y2Nlc3NmdWwsIEkgd291bGQgbm93IHNheSB0aGF0IHlvdXIgcHJvcG9z
YWwgd2l0aCB0aGUNCnNvZnQgZXJyb3IgaWYgZmFpci4gRXZlbiBpZiB3cml0ZXMgYW5kIGVyYXNl
cyB3aWxsIG5vdCB3b3JrIGluIGNhc2UgV1AjDQppcyBhc3NlcnRlZCwgd2Ugd291bGQgYXQgbGVh
c3QgbGV0IHVzZXJzIGRvIHJlYWRzLiBUaGUgd3JpdGVzIGFuZCBlcmFzZXMNCnByb2JsZW1zIHdv
dWxkIGJlIGNhdWdodCB3aGVuIGVuYWJsaW5nIHRoZSBkZWJ1ZyB0cmFjZXMuIFNvIHBsZWFzZSBn
bw0KYWhlYWQgYW5kIHByaW50IGp1c3QgYSBkZXZfZGJnIHdoZW4gc3BpX25vcl91bmxvY2tfYWxs
KCkgZmFpbHMsIHdpdGhvdXQNCnN0b3BwaW5nIHRoZSBleGVjdXRpb24uDQoNCkNoZWVycywNCnRh
DQo=
