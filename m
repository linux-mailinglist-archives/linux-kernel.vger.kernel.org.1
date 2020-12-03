Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EEE2CD989
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgLCOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:46:03 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:15851 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLCOqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607006761; x=1638542761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5y/KMrI+VfvdJWBH7hZNHOKUYiislY2Zxs3WvpyEsZ8=;
  b=uTN3P3OF53P7NGLFSFaO5g6Y02QFHvBG6WV5rMEVKBHkwxOOb3UrztGd
   Nhy83qM7tqdEx5OJ25n+veskOzONY5zauskfcUYFprXd1762jBlOmAa1i
   BYh7k05xR3k8WMjghTgAkt6FXqP4508fVKLo1JFQOFCwOTTV6krWP8oDd
   YGB7UftGno2+owZM4fhCba1ZyQcARe0I650UzfedN0fa9XVBisFHSW7/9
   3IL9Ge0d6vCfcoauP1KRTXIWvsHhwc+2uW/jA0aeWnUFpU5U/6SNuKcFb
   4EdbHZXd6HmTr1mGMfFmEBdi0dq00DAlr1HarFvM645Khv2L3wiZgyvT/
   A==;
IronPort-SDR: ncVMWUjUkOKUr+Y/L2lMtF7AX5s0onBKEnr5z2Cc5T61n2V2FgEsJmWeYiRMKwFM/S90MJIJAn
 XHfwiea5hALgzpeAlljTt6+C2YKIhFAMJJHb/OD9umD8w9kqgqxk61h6oagxMCNMzXgcgaIrfr
 Iv77WbrG052cToDmXYOeY4bONhwWiDxIPYziPX8qcoYAYxL4PrwZ/1AkTkGuAp+6YAPl2lI1gn
 j0Oum4EURq0Mpunf/iK0F9dbAvpBl1xCCZN47UM8We0dFR1SIZxbQPRDkPTGiSZHzclrHAoZfY
 6Qw=
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="100748696"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2020 07:44:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 07:44:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 3 Dec 2020 07:44:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx3Y56+GdfLxERyvM4v3+IY4a0DpYspwfYp+5WvE2DWlwxp7hfbkvPujFrHB1DzqnJRe1yfNTwV1bZ8dYCrkBBTSMecwIyLzzYByIaEK/btkfJVwSv/xC0eGw01VnSWqos376rW3N9zVOgoPOvQM/74mxN+3GowQrw9Iuxuh9rJx+sw3xUhqc6E2vHWRDDrQmyxrZZW6AEUsClqUAPM6NLAEix4r+RiOvVjlpd1dDq8t/N8ozFC/5cpjuSLCIfmnwp60AL5Y5JG51dcKykeIIiGxR7IHXKS+5bdPjHJs6Ud1uELJbzR5jMvWsfumkJG7P4kGr22qqf4DZvZ8Ij+FEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y/KMrI+VfvdJWBH7hZNHOKUYiislY2Zxs3WvpyEsZ8=;
 b=IRqnrsPkzp6OmOkIvcBheNj9g294VRI86KKPF6mqDb5eDUU5FCM8No8gTbA8pdMJSNzUv15cFbq43wjf/zHXFnf8SrXG0gFya1iJseROarkdkN10KLB49r/igAGRClzEB6Cev6yQO5PDJ9CgfQ5L3kJPSvJC1DQTltW8Uyyj4Mm8ILEnvQipcC3P1o9XCiZhuvO+67hDdb/At9SB00BpTsNb4vXH/Ob2e97jPkWxU4SWQlcrVMz/SOTfvtmxsmATxN0/IPJmKu2rMx3pWiedxvx0aV6YWcs35/qCP4NcR4/C7+CIYCUZPj9OmoU65DZgyWkUgAvKfSMSsOFZfCY+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y/KMrI+VfvdJWBH7hZNHOKUYiislY2Zxs3WvpyEsZ8=;
 b=iu4qutIlgsiNjy5kPJBkHWKC3kFNtYomLHQpKC0BJUiLrpdv3B5Vf0+9OfSbIRQChTZVOyjf6AK4znvRIhZyHkCjNdsWTolOKvo3ncns7B3p8GaLNPxi12VvaaA6NEZIqcJp5pfOct9hItMdlb/1ltcGc8fFNV3x+W8yJxGNFLc=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 14:44:54 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3632.020; Thu, 3 Dec 2020
 14:44:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 6/7] mtd: spi-nor: atmel: fix unlock_all() for
 AT25FS010/040
Thread-Topic: [PATCH v7 6/7] mtd: spi-nor: atmel: fix unlock_all() for
 AT25FS010/040
Thread-Index: AQHWyYLcJsKk2P42uE+7Sa9dD7Nz7g==
Date:   Thu, 3 Dec 2020 14:44:54 +0000
Message-ID: <9338f65d-ff5e-ade8-8beb-986445996da0@microchip.com>
References: <20201202230040.14009-1-michael@walle.cc>
 <20201202230040.14009-7-michael@walle.cc>
In-Reply-To: <20201202230040.14009-7-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b7be81-9816-405e-8bff-08d89799ff91
x-ms-traffictypediagnostic: SA0PR11MB4687:
x-microsoft-antispam-prvs: <SA0PR11MB4687CA761C246B001F6FFCEAF0F20@SA0PR11MB4687.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dR+c4oBTcpBvTDXS/kQiPjt08yWzd/kw4HgNaCC8UzRzvKzcc/ZTlNdDG90Kq6CL3B2SDQrzZQQG4OURLXB6JhDRup8bLN76wPK8GQTTuc+mlrBVak7UV6TCBTe3+kmVD2I9BxavgZVEIqewLFnBQIjLpOJS9EpV0gLzRxWcodHup8KEhNOHV5GztklpJEYmt3EdqE+dU0y8jdPOotts2N/FaxCYVXEINIkqEjhJS8ZEj880Jzos1vjnTRMZV8tgQ0HiIoTfrZIBVze8qkNNlYjnOeKnDXYSrXXlerY8t3bW2VYWjcDUdNNETZ8cFylZV2VFnlWqnVJaxNumpxsqyzs34YIqntOlO9BP7Rsew4AsFcOYQy7hF2U4BdUKFwZnpCZWyly+Mt9YFVVcz5FbTBRxT9Ap0VeqUsq1GN1+lvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(6512007)(26005)(31686004)(186003)(6506007)(5660300002)(478600001)(53546011)(83380400001)(71200400001)(86362001)(64756008)(8676002)(91956017)(36756003)(54906003)(6486002)(110136005)(76116006)(66556008)(66446008)(31696002)(2616005)(8936002)(4326008)(66946007)(2906002)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZXZBaGtmTHMwTzlzVnZvVU10ZTErM2c0UTlPTk1jL2lRSGc4ZFpqeVBKZ1hD?=
 =?utf-8?B?Rzg4dU5lQ0pxVjQ2UG41dER3TjA1TU9xY3hWeDRaTmxrWW9ESTdXMFN3ZWdy?=
 =?utf-8?B?bGxQOVhXSmJwOU9aanRzTjNUTnZQYUtxSjBCK0NNUlRlQy9tWE1OLzYxNmlv?=
 =?utf-8?B?NFRYNWNpZUk0dW1jbGpjcUcyVjk1UXpuMWxlRFNqQ3lkYUJPTHBlc1ZueGpv?=
 =?utf-8?B?bkZZME5xajVDZmRkQzRWMHNodmRMSDhaYklUUStSa1JmSml5WmRXVFNaZWFa?=
 =?utf-8?B?WnlmMjI2Zm1OQTVDRE5VMkdLbEQ1NVd2N0pIV1MyM2ZWMkNGZHpIMlY2UXBj?=
 =?utf-8?B?QnhnaUpVd01pY240anBOdGVENGdyc1E4Zjd2dzVDRVJ5VHlUQ0YyUm5IdmlW?=
 =?utf-8?B?QUVkMHQzU0dpWUVGVDZuUy9qREQyaVlPbkl6WmtML0NCeFFiRlVWdzBZTjha?=
 =?utf-8?B?RHJCc2hYanJhb1EvckFZYzBMMUVFemV4emJTMWd4cWhPM244eTJNQ2U3NGRs?=
 =?utf-8?B?RkRSdkwwU2syZFNHWmp6ZmRyT1I3SWMrMzZlRklNTG95azFlT0lESGpaRW85?=
 =?utf-8?B?VkJYYzByYkF3YlAzbGpaRWdYS2JSN0xaWUhucEh3ZGZaQlNDTWRHdlNlaUJW?=
 =?utf-8?B?czdHbEN2K1hwZXlKMlZvLzBUaWswd2F0TWFPcnpaZUlYbHVScGtzK1ozRjV4?=
 =?utf-8?B?VkV5UU52LzE2Q3RrSkJXcFdKOUJZV0pCMHNPNW9HK1VRbklwQ3hwRlpvVzVw?=
 =?utf-8?B?RytKUXo4Skhwcy9hZnpDdC9rcHhBSVBEdHJmMjlQVlJJVC92bC81VHdZZ3Ri?=
 =?utf-8?B?eWphRWdFZ3VScU15L2tma0VoaW5SR1o5dGRnRFRxMG8wNUlpOG5vZ1VhSElr?=
 =?utf-8?B?Wjh2dmwwU0x2VmFCMUlEVEpSNjF1WkRFUnRTSHJLeTFNVjFUY2RHNnVtMWtL?=
 =?utf-8?B?TktWeVI2RGd0MFBhajRFRG9Vd1FQZTRiZTJwRmNRNi9GRDd2RFlvRGVxY0h0?=
 =?utf-8?B?aVliZGVlUTB5SFYrNnlJalRtTloyY3hRcjRZZGpJR0Njb3B4ZXFQQkFzNEJT?=
 =?utf-8?B?Rmp5V1QrcElPRko2alZQMkpmVXdQU3BuQmREMDlPS3QrWml1aFR6QWtHSDhY?=
 =?utf-8?B?ZTNXYUlhR0pVNHZmdVhwQW9BaWN5QmxkTjdOeHd4ZjhsWFoxc0RSYXhmT2M2?=
 =?utf-8?B?bkFIWTZaWFN0SlpjSGI5N21xaWJTZ0NHRjhaR1dRcHoxNE53WU5qSnF1SzJh?=
 =?utf-8?B?WG5xOGd3VjBrQ1VVTnB6aDM4VFYyUHgxdzhXRHI4MHBGSktjSWl4K25hVHBq?=
 =?utf-8?Q?4XvpH24m0yvqQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7B741E404F82641AAC0DE3732DD8EEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b7be81-9816-405e-8bff-08d89799ff91
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 14:44:54.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTF2X+b8ccdU+/xUZvzTHT/mz3xR4iUIxqsPgN55WY2I9cW6bKIF4KG7Crdeq+vin1haiFYHJKUMkkQJKqP6+xqqVsBu+9ldyxvX9l3SRt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMy8yMCAxOjAwIEFNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZXNlIGZsYXNoZXMgaGF2ZSBzb21lIHdlaXJk
IEJQIGJpdHMgbWFwcGluZyB3aGljaCBhcmVuJ3Qgc3VwcG9ydGVkIGluDQo+IHRoZSBjdXJyZW50
IGxvY2tpbmcgY29kZS4gSnVzdCBhZGQgYSBzaW1wbGUgdW5sb2NrIG9wIHRvIHVucHJvdGVjdCB0
aGUNCj4gZW50aXJlIGZsYXNoIGFycmF5IHdoaWNoIGlzIG5lZWRlZCBmb3IgbGVnYWN5IGJlaGF2
aW9yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5j
Yz4NCg0KV2l0aCBmaXhlcyB0YWcgYWRkZWQsIG9uZSBjYW4gYWRkOg0KUmV2aWV3ZWQtYnk6IFR1
ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gY2hh
bmdlcyBzaW5jZSB2NjoNCj4gIC0gdXNlIHNwaV9ub3Jfd3JpdGVfc3JfYW5kX2NoZWNrKCkgYW5k
IGxvZyBhIGRlYnVnIG1lc3NhZ2UgaWYgd3JpdGluZw0KPiAgICBmYWlscw0KPiANCj4gY2hhbmdl
cyBzaW5jZSB2NToNCj4gIC0gbmV3IHBhdGNoDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9h
dG1lbC5jIHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMgIHwgIDIgKy0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5oICB8ICAxICsNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVs
LmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4gaW5kZXggNDlkMzkyYzZjOGJjLi5l
ZTM4MmE0NGJkMGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvYXRtZWwuYw0K
PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4gQEAgLTgsMTAgKzgsNTkgQEAN
Cj4gDQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiANCj4gKy8qDQo+ICsgKiBUaGUgQXRtZWwgQVQy
NUZTMDEwL0FUMjVGUzA0MCBwYXJ0cyBoYXZlIHNvbWUgd2VpcmQgY29uZmlndXJhdGlvbiBmb3Ig
dGhlDQo+ICsgKiBibG9jayBwcm90ZWN0aW9uIGJpdHMuIFdlIGRvbid0IHN1cHBvcnQgdGhlbS4g
QnV0IGxlZ2FjeSBiZWhhdmlvciBpbiBsaW51eA0KPiArICogaXMgdG8gdW5sb2NrIHRoZSB3aG9s
ZSBmbGFzaCBhcnJheSBvbiBzdGFydHVwLiBUaGVyZWZvcmUsIHdlIGhhdmUgdG8gc3VwcG9ydA0K
PiArICogZXhhY3RseSB0aGlzIG9wZXJhdGlvbi4NCj4gKyAqLw0KPiArc3RhdGljIGludCBhdG1l
bF9hdDI1ZnNfbG9jayhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qgb2ZzLCB1aW50NjRfdCBs
ZW4pDQo+ICt7DQo+ICsgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgaW50IGF0bWVsX2F0MjVmc191bmxvY2soc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90
IG9mcywgdWludDY0X3QgbGVuKQ0KPiArew0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAg
ICAgICAvKiBXZSBvbmx5IHN1cHBvcnQgdW5sb2NraW5nIHRoZSB3aG9sZSBmbGFzaCBhcnJheSAq
Lw0KPiArICAgICAgIGlmIChvZnMgfHwgbGVuICE9IG5vci0+cGFyYW1zLT5zaXplKQ0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKyAgICAgICAvKiBXcml0ZSAweDAw
IHRvIHRoZSBzdGF0dXMgcmVnaXN0ZXIgdG8gZGlzYWJsZSB3cml0ZSBwcm90ZWN0aW9uICovDQo+
ICsgICAgICAgcmV0ID0gc3BpX25vcl93cml0ZV9zcl9hbmRfY2hlY2sobm9yLCAwKTsNCj4gKyAg
ICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgZGV2X2RiZyhub3ItPmRldiwgInVuYWJs
ZSB0byBjbGVhciBCUCBiaXRzLCBXUCMgYXNzZXJ0ZWQ/XG4iKTsNCj4gKw0KPiArICAgICAgIHJl
dHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgYXRtZWxfYXQyNWZzX2lzX2xvY2tl
ZChzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qgb2ZzLCB1aW50NjRfdCBsZW4pDQo+ICt7DQo+
ICsgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHNwaV9ub3JfbG9ja2luZ19vcHMgYXRtZWxfYXQyNWZzX2xvY2tpbmdfb3BzID0gew0K
PiArICAgICAgIC5sb2NrID0gYXRtZWxfYXQyNWZzX2xvY2ssDQo+ICsgICAgICAgLnVubG9jayA9
IGF0bWVsX2F0MjVmc191bmxvY2ssDQo+ICsgICAgICAgLmlzX2xvY2tlZCA9IGF0bWVsX2F0MjVm
c19pc19sb2NrZWQsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgdm9pZCBhdG1lbF9hdDI1ZnNfZGVm
YXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICt7DQo+ICsgICAgICAgbm9yLT5wYXJh
bXMtPmxvY2tpbmdfb3BzID0gJmF0bWVsX2F0MjVmc19sb2NraW5nX29wczsNCj4gK30NCj4gKw0K
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfbm9yX2ZpeHVwcyBhdG1lbF9hdDI1ZnNfZml4dXBz
ID0gew0KPiArICAgICAgIC5kZWZhdWx0X2luaXQgPSBhdG1lbF9hdDI1ZnNfZGVmYXVsdF9pbml0
LA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIGF0bWVsX3Bh
cnRzW10gPSB7DQo+ICAgICAgICAgLyogQXRtZWwgLS0gc29tZSBhcmUgKGNvbmZ1c2luZ2x5KSBt
YXJrZXRlZCBhcyAiRGF0YUZsYXNoIiAqLw0KPiAtICAgICAgIHsgImF0MjVmczAxMCIsICBJTkZP
KDB4MWY2NjAxLCAwLCAzMiAqIDEwMjQsICAgNCwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0sp
IH0sDQo+IC0gICAgICAgeyAiYXQyNWZzMDQwIiwgIElORk8oMHgxZjY2MDQsIDAsIDY0ICogMTAy
NCwgICA4LCBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSykgfSwNCj4gKyAgICAgICB7ICJhdDI1
ZnMwMTAiLCAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LCAgIDQsIFNFQ1RfNEsgfCBTUElf
Tk9SX0hBU19MT0NLKQ0KPiArICAgICAgICAgICAgICAgLmZpeHVwcyA9ICZhdG1lbF9hdDI1ZnNf
Zml4dXBzIH0sDQo+ICsgICAgICAgeyAiYXQyNWZzMDQwIiwgIElORk8oMHgxZjY2MDQsIDAsIDY0
ICogMTAyNCwgICA4LCBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSykNCj4gKyAgICAgICAgICAg
ICAgIC5maXh1cHMgPSAmYXRtZWxfYXQyNWZzX2ZpeHVwcyB9LA0KPiANCj4gICAgICAgICB7ICJh
dDI1ZGYwNDFhIiwgSU5GTygweDFmNDQwMSwgMCwgNjQgKiAxMDI0LCAgIDgsIFNFQ1RfNEsgfCBT
UElfTk9SX0hBU19MT0NLKSB9LA0KPiAgICAgICAgIHsgImF0MjVkZjMyMSIsICBJTkZPKDB4MWY0
NzAwLCAwLCA2NCAqIDEwMjQsICA2NCwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jDQo+IGluZGV4IDAxMzE5OGFiZTkyOS4uNmFmY2I5OWU5NzQxIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPiBAQCAtMTA0OSw3ICsxMDQ5LDcgQEAgc3RhdGljIGludCBzcGlfbm9y
X3dyaXRlXzE2Yml0X2NyX2FuZF9jaGVjayhzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCBjcikNCj4g
ICAqDQo+ICAgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZS4NCj4gICAq
Lw0KPiAtc3RhdGljIGludCBzcGlfbm9yX3dyaXRlX3NyX2FuZF9jaGVjayhzdHJ1Y3Qgc3BpX25v
ciAqbm9yLCB1OCBzcjEpDQo+ICtpbnQgc3BpX25vcl93cml0ZV9zcl9hbmRfY2hlY2soc3RydWN0
IHNwaV9ub3IgKm5vciwgdTggc3IxKQ0KPiAgew0KPiAgICAgICAgIGlmIChub3ItPmZsYWdzICYg
U05PUl9GX0hBU18xNkJJVF9TUikNCj4gICAgICAgICAgICAgICAgIHJldHVybiBzcGlfbm9yX3dy
aXRlXzE2Yml0X3NyX2FuZF9jaGVjayhub3IsIHNyMSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IGluZGV4
IDBhNzc1YTdiNTYwNi4uNzc4MDE2OWQ0ODViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiBAQCAt
NDMwLDYgKzQzMCw3IEBAIHZvaWQgc3BpX25vcl91bmxvY2tfYW5kX3VucHJlcChzdHJ1Y3Qgc3Bp
X25vciAqbm9yKTsNCj4gIGludCBzcGlfbm9yX3NyMV9iaXQ2X3F1YWRfZW5hYmxlKHN0cnVjdCBz
cGlfbm9yICpub3IpOw0KPiAgaW50IHNwaV9ub3Jfc3IyX2JpdDFfcXVhZF9lbmFibGUoc3RydWN0
IHNwaV9ub3IgKm5vcik7DQo+ICBpbnQgc3BpX25vcl9zcjJfYml0N19xdWFkX2VuYWJsZShzdHJ1
Y3Qgc3BpX25vciAqbm9yKTsNCj4gK2ludCBzcGlfbm9yX3dyaXRlX3NyX2FuZF9jaGVjayhzdHJ1
Y3Qgc3BpX25vciAqbm9yLCB1OCBzcjEpOw0KPiANCj4gIGludCBzcGlfbm9yX3hyZWFkX3NyKHN0
cnVjdCBzcGlfbm9yICpub3IsIHU4ICpzcik7DQo+ICBzc2l6ZV90IHNwaV9ub3JfcmVhZF9kYXRh
KHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCBmcm9tLCBzaXplX3QgbGVuLA0KPiAtLQ0KPiAy
LjIwLjENCj4gDQoNCg==
