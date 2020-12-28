Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51C02E339B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgL1C1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:27:23 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:21536
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbgL1C1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:27:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa5rkMMofV+jBdEY1avxOu8yQs1BLJeoRYoVrpPPAbo/XYCh3pPEISoIkUhQhurZvLBXZ0P/AYboxZDYHNCJmB4jy/s4T66unXEtEfig0FjjOFx4BQsPIOX9Xus3kGAMqVoxcfnM0tw2VkQqcppe6I4wDEkrsXVRsWblyPAKUECKPaYyLRhG/ED9yzC5H/fI4NacQ62n3wB79bc42kOCwYypfps/tahLu8m7j1C7YWGvz5W4vh5V/ypFrNeJIY6TbU9iQ9oKvWjwJ0/ZDsj65OTH+2IaJNfasg5YW3adKoINutf2pK26B+3nK5sOPY46aB6JeFUJd9oS8REV+e92Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmTw8oRXUbAxtF9pb6Wd+PZPTItr25m1I3ov3ITtD4o=;
 b=lox8W2DzAgHB9MB3x0JPQWmBYsu5CWAKM3QjtXzkN1a7QVjag91fX+lMxSD8oBN+jNPxSkRJywaBvA8lSWw12QNSQLteRzjoHJxwj/tybCoHH01fT5V9QkTbvmjk/notZT6dKtU0fmL+Ho7g6BOk/70GlunYmMZb9PG7MJSRIEyzum5H7Pf0OBTDVLu7xQPU/XycDpSb/ryibkXI/kHO0afT77qZLLN+9YOjwSdLXf3/U2Iywaa8VKSVCIdJ8STo+bWufNtC1FqTYxThDdY1ZGZLSNRgHp3KFl128KcX/gc+n70St50Mxr+8MB6YxJA1hF00NS3mTITK1xPTbz7GwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmTw8oRXUbAxtF9pb6Wd+PZPTItr25m1I3ov3ITtD4o=;
 b=Ndoj/HvIUE71ha+JzHi6anEzk38i1AuembX/pg685sfvypbS5JC+TTculaffaS4mXWCQAG1dcwLrVMTQ99y0Mk/bfgcokeSbjN7aGK6GuyuoX1CRiF9d4NFank0xFD1mSHqGPeyxwW2gma7KXEUcHLMSxmoHBQS+obBJhn9JrxE=
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Mon, 28 Dec
 2020 02:26:33 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%5]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 02:26:33 +0000
From:   "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: regmap: debugfs: fix a memory leak when calling regmap_attach_dev
Thread-Topic: regmap: debugfs: fix a memory leak when calling
 regmap_attach_dev
Thread-Index: AQHW3FXcaMlV7254xkKXhXYYZYHhsqoLuDnQ
Date:   Mon, 28 Dec 2020 02:26:33 +0000
Message-ID: <PH0PR11MB50770B63B8BFB8B7DAD615C195D90@PH0PR11MB5077.namprd11.prod.outlook.com>
References: <20201225122613.3810458-1-xiaolei.wang@windriver.com>
 <737e8b89-5748-2ef5-5294-8e65421931b9@web.de>
 <PH0PR11MB507734E4DF73DF015AD601EB95DA0@PH0PR11MB5077.namprd11.prod.outlook.com>
 <46e289a6-49ab-a627-dab1-56a8b0587c08@web.de>
In-Reply-To: <46e289a6-49ab-a627-dab1-56a8b0587c08@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [192.103.52.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e310323-793f-4f90-b2c4-08d8aad7fe7e
x-ms-traffictypediagnostic: PH0PR11MB4997:
x-microsoft-antispam-prvs: <PH0PR11MB49975EAEFAD31A7FF7B6A39195D90@PH0PR11MB4997.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jgb0NTL3jG1T7KmDtNdOqZgPiVMKQnrRkr7AbElDuVjxSsqc/XiM2x+g0dVhpqqEoHUWTn+Za53jZpjLSDmE6IW9xQnqx8Fyy6BOoFEtmDSvI74bCyBqzBFkB4VaxwGbSQkZ7IVuUacPS/WzRDaCU+NyXsf0jn2Uncf6TJk9fywPwjCJQ0Jc/a8VQ3eHvL9ucMbHgct0f2FsYyCcCKO34V4oViSMk7QrtloVGPxRKrYgkbB7HIxOs+Tn5boqNOdpe2hTM5DnOOD0CiWbLKPXV5L0beG6sqL95qPiyrC7sbIsub6lLc3e4njdCf49LUA/3ZcK+xI5ibumzGwPzXjaJTCDlyQHfenXt4NOLo8pAwNbbVkXiA7hgAxVhtNUG595qeftPfdNILEprE2Mwxw66MHwwLqekBKfLfAYiqZIyZtu3hvA3JHXq7nTOCoiUrvAB3Cs6wCyiPFgiUx13dqFYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39840400004)(366004)(346002)(9686003)(478600001)(2906002)(66556008)(71200400001)(53546011)(66946007)(6506007)(76116006)(66476007)(8676002)(66446008)(26005)(86362001)(64756008)(55016002)(54906003)(8936002)(4326008)(5660300002)(7696005)(186003)(33656002)(83380400001)(110136005)(52536014)(966005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V1NIUHptQ3M2cTZGVkZBVS9nUmVXSjJFQllzSkFFT2lwNSsxbXVwRjJYYVFE?=
 =?utf-8?B?Y3RSTm43dG12Zk1ocVRCOEF5RnROQUtHT2ZBRWh3Sll0TWpDb0cvM1R1Nm4y?=
 =?utf-8?B?UHZzcUR5OHZGMGlvM3ZYSUNxYXRYVkZEZEtCd0NEYTFvVjVaTGpuYkdFYjdi?=
 =?utf-8?B?d3RZbCtxbUwxanpXanE4eFNZREhhdGJSM2EvTWtWWUR4OE9HVDlrQVVMQ0lW?=
 =?utf-8?B?YmxGU2lrMzZlc1pPcmcxSyttUDNXQnZkcHA3VUJaTXE2LzI2RytYWXJOY3ho?=
 =?utf-8?B?Z3kvS01ta1BnZXdZNm55alRiRVJXVElnT2FkM1dwaHBaNG9wSjdLQTg4eUhT?=
 =?utf-8?B?OS83UXJZOGtsYXViVjZsc2tkekpNOUVhUTRETTUyV0NzdUl5Ymt5T05WaGRn?=
 =?utf-8?B?NmxMVGlNUmJ6UDFBN2lnOHVUZUx6RGd6aFQ0OUdPM0tpNEl2NGJ3VGR1NGpz?=
 =?utf-8?B?dkJEcUlSeUNyTEtjaTBhWGFZZW1YSWt6T3BXWkZnWmU1eTlZeDJ2aUtqUkpt?=
 =?utf-8?B?Znp2L3phMnMxeVV4OTV1M1lTZzVRNzJEamlNdGI3b1VBZkFadktOeG9OeHpE?=
 =?utf-8?B?ZGNhc1ZJSjlKcktkQXYwbC9YSDN5amNReDQ2UkxUcWgvdmhncUxBZ1hLNWU4?=
 =?utf-8?B?Qk51MUpNZ2FSeG9rcHFyMTJvMEdaMWxOUnphdlQyVVJnZE5jVEI2ZUdYb0NE?=
 =?utf-8?B?UW5LOXdjYnJmSjRTL3EyLzdHMENsZ0IyZWtSNDNjZlVrL05rUDU3ajBDM2Jm?=
 =?utf-8?B?N0xTZGhsR0REcERmV014VFFSeWNZK2F5RlUrNzNQQ3BiOU5oTWtqaVJ4MGNp?=
 =?utf-8?B?b25UNExsMGFUWktDaFFFYXJaWXN2SGxRZUo4clZyaCtnWXJGT1hNeHBGaU1E?=
 =?utf-8?B?N01iNm9PRERKVHZDb2s4UnRmZnVGYjNVRGljZmp3QTk1Snc4Tkp2M0xrekJm?=
 =?utf-8?B?ZjhwTERUaG5NNFhMSGhyZUNDVGloaTB6Z2tmR0lyV21STXN5aXNpZDM1alFw?=
 =?utf-8?B?dW45K0NhOXBqY2k3bGZheVUyaGFwVTBRbTJWd1ZBejlMQmM0UVBwQ0NtVlJ2?=
 =?utf-8?B?ejVYN29iVGU2ejJtaGFTNXFiN2RjakxDbzhyYjVhNENEbzJ3TGFHdXNRYjhq?=
 =?utf-8?B?Q0Vibm1sRmdGVjBIaTJDdnl0aElDbnQ3OWJRNVFZaGlhbUpYZ3NPVmxqd1Uy?=
 =?utf-8?B?cnBkZ1cvakhhQUw0RnFQTEhOelpVdVMyTmxaRTM5cGZwRVplS1BkRlRUVzY5?=
 =?utf-8?B?bXUxQy9naUFoZjhMaWFaYzR6WE0zS09GV0t6eFEvOWlSeXlHemFnZTVjNmlO?=
 =?utf-8?Q?3LSMozf43fSUA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e310323-793f-4f90-b2c4-08d8aad7fe7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 02:26:33.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7C4XWPJ2YbrYnDbUWE8WHIeX1eOmxvqxqznVqgz887i8i3sp8rW6V4Gh41i40bSgsKJSI+6hk5F9lmitHnGsJ1t9kiCN0pyBlzllTI4l6j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEbyB5b3UgbWVhbiBzbz8NCj4NCj4gY29tbWl0Og0KPiAgICAgICAgICA5Yjk0N2ExM2U3ZjYg
KCJyZWdtYXA6IHVzZSBkZWJ1Z2ZzIGV2ZW4gd2hlbiBubyBkZXZpY2UiKQ0KDQo+IFBsZWFzZSB0
YWtlIGFub3RoZXIgbG9vayBhdCBrbm93biBpbmZvcm1hdGlvbiBzb3VyY2VzLg0KDQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2lk
PWY4MzhmOGQyYjY5NGNmOWQ1MjRkYzQ0MjNlOWRkMmRiMTM4OTJmM2Yjbjg5DQo+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2lkPWY4
MzhmOGQyYjY5NGNmOWQ1MjRkYzQ0MjNlOWRkMmRiMTM4OTJmM2YjbjEyMQ0KDQoNCg0KPiBXaGlj
aCBvbmUgZG8geW91IG1lYW4gYnkgImFub3RoZXIgbnVsbCBwb2ludCI/DQoNCkhvdyBkbyB5b3Ug
dGhpbmsgYWJvdXQgdG8gY2hlY2sgaWYgY2FsbHMgb2YgdGhlIGZ1bmN0aW9uIOKAnGthc3ByaW50
ZuKAnSBzdWNjZWVkZWQgaGVyZT8NCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1
LjEwLjMvc291cmNlL2xpYi9rYXNwcmludGYuYyNMNTMNCg0KV2lsbCBhbnkgbW9yZSBleGNlcHRp
b24gaGFuZGxpbmcgYmVjb21lIHJlbGV2YW50IGFsc28gZm9yIHRoZSBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGUgZnVuY3Rpb24g4oCccmVnbWFwX2RlYnVnZnNfaW5pdOKAnT8NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdl
Yi5kZT4gDQpTZW50OiBTdW5kYXksIERlY2VtYmVyIDI3LCAyMDIwIDk6NDAgUE0NClRvOiBXYW5n
LCBYaWFvbGVpIDxYaWFvbGVpLldhbmdAd2luZHJpdmVyLmNvbT47IGtlcm5lbC1qYW5pdG9yc0B2
Z2VyLmtlcm5lbC5vcmcNCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHcmVnIEty
b2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgTWFyayBCcm93biA8YnJv
b25pZUBrZXJuZWwub3JnPjsgUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0K
U3ViamVjdDogUmU6IHJlZ21hcDogZGVidWdmczogZml4IGEgbWVtb3J5IGxlYWsgd2hlbiBjYWxs
aW5nIHJlZ21hcF9hdHRhY2hfZGV2DQoNCj4gRG8geW91IG1lYW4gc28/DQo+DQo+IGNvbW1pdDoN
Cj4gICAgICAgICAgOWI5NDdhMTNlN2Y2ICgicmVnbWFwOiB1c2UgZGVidWdmcyBldmVuIHdoZW4g
bm8gZGV2aWNlIikNCg0KPiBQbGVhc2UgdGFrZSBhbm90aGVyIGxvb2sgYXQga25vd24gaW5mb3Jt
YXRpb24gc291cmNlcy4NCg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
c3VibWl0dGluZy1wYXRjaGVzLnJzdD9pZD1mODM4ZjhkMmI2OTRjZjlkNTI0ZGM0NDIzZTlkZDJk
YjEzODkyZjNmI244OQ0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3Vi
bWl0dGluZy1wYXRjaGVzLnJzdD9pZD1mODM4ZjhkMmI2OTRjZjlkNTI0ZGM0NDIzZTlkZDJkYjEz
ODkyZjNmI24xMjENCg0KPiBXaGljaCBvbmUgZG8geW91IG1lYW4gYnkgImFub3RoZXIgbnVsbCBw
b2ludCI/DQoNCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBjaGVjayBpZiBjYWxscyBvZiB0
aGUgZnVuY3Rpb24g4oCca2FzcHJpbnRm4oCdIHN1Y2NlZWRlZCBoZXJlPw0KPiBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92NS4xMC4zL3NvdXJjZS9saWIva2FzcHJpbnRmLmMjTDUz
DQoNCj4gV2lsbCBhbnkgbW9yZSBleGNlcHRpb24gaGFuZGxpbmcgYmVjb21lIHJlbGV2YW50IGFs
c28gZm9yIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZnVuY3Rpb24g4oCccmVnbWFwX2RlYnVn
ZnNfaW5pdOKAnT8NCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24sIEkgd2lsbCBtb2RpZnkg
dGhlIGNvbW1pdCBsb2cgYW5kIGFkZCBhbm90aGVyIG51bGwgcG9pbnQgY2hlY2sgdG9nZXRoZXIg
d2l0aCBjb3JyZXNwb25kaW5nIGV4Y2VwdGlvbiBoYW5kbGluZw0KDQoNClJlZ2FyZHMsDQpYaWFv
bGVpIA0K
