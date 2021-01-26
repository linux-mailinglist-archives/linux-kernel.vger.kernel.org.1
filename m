Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F4303B43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404992AbhAZLO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:14:59 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:54817 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728488AbhAZIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:06:49 -0500
IronPort-SDR: 8aDFyMddk+//Yxe92vzfQph6xAqJiCAyhX6JcFmjSy7RrHOtMe8EfB20HcHgkVqUrwDudXB4Nj
 IhJZEzM5/qI8am936iu61wdl+RiVTFSmebiaHJBH/CTkYG9pXhZhknZUuo4i7ciYqSL5lunXTQ
 fup3C9PzlHQfQcOJMEYuGLN/3BJl/x+SZyrqg7UAK/xfIQcl/bEXY9TH7050CWCoEer6+zQRvx
 0Hi2YkQKm8CEYtCMR6QC2Y4y4hHkOOlSUze/bH1TjNaA+/4s9cYOS8erdgqqVt9I2DphFcErJy
 vus=
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="25071521"
X-IronPort-AV: E=Sophos;i="5.79,375,1602514800"; 
   d="scan'208";a="25071521"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 17:03:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n++Srhbh+tXtGILrLALW3nx+nh11JoSsKqswVMGZhMNDiaAtwdSV0WG1DgyoxIwwkfjSnJnjLpJtR9Yc36GXeLRJk7Isu1xX95jHpnIaCcypum8hq8l8SDIsMdEFLbdt7u930a77vWHRFcaq788N0RyBNvRPpQ9Wu8UNyczz5jYMvtxxexFNjNIv/+PLe+gjNMSnS9K9LHSIwUNW5YQRgXKevDq2k2loGIwLLVS8KzBpmJkRMxwLIvlHfoCLhAK/wDYaOexiiiYuRuEqUEC5By+Dad4LUX3eMMXDNCY1hqUMGPZjiqtxIL5b8nlT7gb1Bigvz6/0qbAEFnhEhDOa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UWBoujJrDINirzdyl4LdFdpJyBNsRHpgsF6QLhXWQ4=;
 b=J1r4QFcoIZUHpTLKeG55JemUMA+kMewKvf5mBZzQbKryxgxE4UvFuDAUtPl0+xRr6uG/PPFJ6WJ8c34veAOZ7hEh1SJ8BHCRpXm0qq+5ZhIXrcnCXxRITD0r43XmZvj4LpTXuRakHvz7pkJQhJaPfmAcV42ne4pT9rw2W7Pc2qULBHpZzp8NcxFNzGncM8s497xW67NHr7zLcEvw7boSrol7I4E0JSqmHqstKXoEYsiQHynV2rU6w8brcww1YKgBoGi5NVv/4TH4zEFhv7wOXjl1fWaIM4WzElz9698sCUsZWxPwRoiN0S5k6GEHCoFC77dtrqGYUr0poiG/TVs0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UWBoujJrDINirzdyl4LdFdpJyBNsRHpgsF6QLhXWQ4=;
 b=BsoTPj26/qjQgPPlM+Cmj8ACgUdqi33pRPIJCExH/Kz7mVGIZVMuOdXcfJ/FeMB3VUNORdGmeeLznauguZkY/qlzy6hLkcpW9zqJt/OMLfOL1H+CLEI65TWk9b19DfXgJqS7uT94oeq1YWy5cvKmjLDh1nS7qSGtFic5yDJTYDk=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB3095.jpnprd01.prod.outlook.com (2603:1096:604:1d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Tue, 26 Jan
 2021 08:03:29 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 08:03:29 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Topic: [PATCH v2 3/3] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
Thread-Index: AQHW7+ShaO8SfWqmV0W2c0KaDfSTBaoyWX8AgADbuSCABRsRAIABQycw
Date:   Tue, 26 Jan 2021 08:03:29 +0000
Message-ID: <OSBPR01MB4600437C6564700CCA65654CF7BC0@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
 <20210121105425.2695843-4-nakamura.shun@jp.fujitsu.com>
 <a0f7c814-5c56-4e17-1198-a611d19f57d5@huawei.com>
 <OSBPR01MB4600A7B761F965C443D92DCFF7A00@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <59c31515-8275-5dfe-0276-ed9353bceb6c@huawei.com>
In-Reply-To: <59c31515-8275-5dfe-0276-ed9353bceb6c@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: d2b094aaac05471da359b656f1e25076
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 583dc3b3-b3e6-42aa-1f5e-08d8c1d0de05
x-ms-traffictypediagnostic: OSBPR01MB3095:
x-microsoft-antispam-prvs: <OSBPR01MB3095C60C59FF9CCC3D600F5DF7BC0@OSBPR01MB3095.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roXQefkTaAT6HAQUmjqEjEucl3djBTGJwsWw8Yp81ErSWB0TZy7IIGosoiA2r/KBEl8edh/Kfw88xy+yZ6DZ/7BRN2r+UMVrxJv9hTs3Yr1bKqmAuUkObakLSRcCAF976rQBz8diHEMmjkg7CQxuj3Gnh+soOeI2zxDCwPXvQZxmI6T6+7WXG0gLy6eQe3kckQ8zY9yLydOh7k7Y1ltjnk5MvU7sP6a2m8fNwRolgrw/772/16a6EaybWpv06WTKK2jIU6P/L2F7RC+LgLAU4L5nIvkwQ9IVBV02iAUvU6zyh0ELWGdMBsRoogcxeW8do4uIp4LMgsAJ0nH9N7MOVrjyQbsYzZTyxi3S1Vkcq3pENNnMwEyqcnoZhKiYAeqsb6XaUt4H0gPS1wZVR+caXJ/My54lHc2gIL7BJWsvKIcHhNO4/TejrLRln+dFPJF7IPTGc6emJDdy2JcAJ43ac59QgoyISWl8ghiG0P0QAN2iLx5VXLP8QzDiaDcORTzbRsIGNnkVQjPCVb9Pvjs75yVNca5L+Qj3p5a8B6zwKw01OQMz2my5Zk4c5HE9n/VorgNFQR7PsT8x0AIKJofEhJYHKpQXA446BlGg8lxD1SzURCOGCEttLAsZZMQc9Z/jCpahjlelkA6s+8Gx53kbQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(6506007)(53546011)(66946007)(64756008)(33656002)(52536014)(85182001)(66556008)(186003)(8936002)(76116006)(66446008)(8676002)(66476007)(26005)(7696005)(83380400001)(2906002)(5660300002)(55016002)(9686003)(71200400001)(316002)(54906003)(966005)(478600001)(86362001)(6916009)(4326008)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SkV4d1pTWkQvNHY4a3BNRitORWk0RVF2cnEzMk9HMy9OaWl0Q3pnTXNiZmow?=
 =?utf-8?B?djlQMEIyUFd1akY1dnVMVGVVaTZ0VGRnYnRlTC9mdkkwMVcvVWc4ME5YaURU?=
 =?utf-8?B?Yy9taHhiTU80bE9yQmppcVdlcG9sTUtsTjRyRnlzZEFsNG4yeDFucUIwY1Bv?=
 =?utf-8?B?RzUvQ2UvRGpPc2xoTGFxTHFRcWVBL3JPOWIxZlhHd05GS0lMcWJ3NlMwalZH?=
 =?utf-8?B?cHJDWjJCTzRkNHBkK1hTSmpzbE5uRHlMOUFydUJqMXkxejJrRHNXN3FmbWZm?=
 =?utf-8?B?T29MeGNnMjJXL1RRRnNsTm9oNmNDSnBkZGVjdC9IbE9tcGFiRkVqZ3VEMklX?=
 =?utf-8?B?dkRTY0tmVjBqeWk4djg2Wm9VQUVjUVNVRkpCcTU0ZTR1MDNIUC9KdnIzQmFF?=
 =?utf-8?B?RENiM2t4bnBzOXd3OHVEK29HalZUV1d6bU9TdnozTklVbitCRWIwSHFwbmlz?=
 =?utf-8?B?TjBqM0tXY0RiRG1BTy9WZEtYN0xXak5DbTFPQzZkcThNTE1lRDRJR1Ivd2ls?=
 =?utf-8?B?R0dZKzJnNUc1SFhOUzZRbGdEamR0VXBsUVkwZFM0NXpaQkEySktDdjBtMXRw?=
 =?utf-8?B?Y01mWlhsNG1ZRm4xSzVtOHI4cUJZenRBalFrYUFaSEZpQkhscFZGN3AvVFpJ?=
 =?utf-8?B?VURzTW5XaVRLZW9ZMU9GUytMNXA0VG1hclR3UXNTaTZxMVJBZyt5Qko1bE55?=
 =?utf-8?B?SFROUDlMd1BtNUlHRSttK3Erc09YMzlYOUdsM05sdE81VDFHZ1hRQXZBV3E4?=
 =?utf-8?B?OHpaK2xuRzZSNWtKVnMvS2tFSGN2Y01vc1BYNWhRTEUrMVhtaXk2VXk1ZjNW?=
 =?utf-8?B?R0Rwbzdna1NSTmRadHYxays3dW9SQ3NXMVZPaTMrOVgrL3FNcmI5VXFkRWcv?=
 =?utf-8?B?SDZ2bmphWkZpOFBGZmNtL1RWdHF5Y1pDTXc0Zm83Q1d4TnVMb1ZVMFk0ZTc0?=
 =?utf-8?B?SlVzRWtuMG9wMTZqVDA3QWZ5bis4anQwMlZTSmVxRHZGamRPbXBpTDBvVmJT?=
 =?utf-8?B?QUUyK1Z4R1B3cUQySDZzY2xIcXlQYTJSMlFLenhyb2s1TGFaampMckNndlhL?=
 =?utf-8?B?V0E0bDBOMmRGVU9tcG92SXBTZHB2TC9EWFVScnlHYmo2bXpzRWtHVVFxd3lY?=
 =?utf-8?B?MFBBUDhpa2pYbGZja2xBeHN3bXZYaDI3YjRxZHdPdW40d2ZqZkVJaTQ5QzJ6?=
 =?utf-8?B?eWpyb3kxUFAzUDcvdlc2UUFVOTZkS2JQdlExanl6NWpucVBzamZQRmJlUHZm?=
 =?utf-8?B?Mm5DZUpicmViV2Q2MXhaazFDWmRhcDdDSUN4eGluNm0rTTdkQ0g3RDc0OC9a?=
 =?utf-8?B?R2hiSjZvVnhWemRjSXRYUFRWNzh1dktpdFBEQUNzbW9ZMGJjbTBkVUViWVZm?=
 =?utf-8?B?Q3A3dGtCSHhjWTJmSVFya2JKVU5IeGNIRlJJYVY0N2M2L21xa29ROWduRGVk?=
 =?utf-8?Q?B2c/oD/H?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583dc3b3-b3e6-42aa-1f5e-08d8c1d0de05
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 08:03:29.4561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhDriN+3ElO+4xAtsvuBe7FIXDVsLpyoKwq/O2Kfzqm/sdLJiO9vYJVEddMBEaKPsaWUuBAh6XrIWzSUx8p/FCWDdEOzaWTA8F3J7EZbrbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvaG4NCg0KVGhhbmtzIGZvciB0aGUgaW5mby4NCg0KQmVzdCBSZWdhcmRzDQpTaHVuc3Vr
ZQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEdhcnJ5IDxqb2hu
LmdhcnJ5QGh1YXdlaS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyNSwgMjAyMSA5OjQ2
IFBNDQo+IFRvOiBOYWthbXVyYSwgU2h1bnN1a2Uv5Lit5p2RIOS/iuS7iyA8bmFrYW11cmEuc2h1
bkBmdWppdHN1LmNvbT4NCj4gQ2M6IHdpbGxAa2VybmVsLm9yZzsgbWF0aGlldS5wb2lyaWVyQGxp
bmFyby5vcmc7IGxlby55YW5AbGluYXJvLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjIgMy8zXSBwZXJmIHZlbmRvciBldmVudHM6IEFkZCBGdWppdHN1IEE2NEZYIFYx
LjIgcG11DQo+IGV2ZW50DQo+IA0KPiBPbiAyMi8wMS8yMDIxIDA4OjM3LCBuYWthbXVyYS5zaHVu
QGZ1aml0c3UuY29tIHdyb3RlOg0KPiA+PiBJIHRoaW5rIHRoYXQgd2UgbmVlZCB0byB0aGUgc2Ft
ZSBoZXJlIGFzIHRoZSBJTVBERUYgcmVjb21tZW5kZWQNCj4gPj4gZXZlbnRzIC0gYWRkIGEgY29t
bW9uIEpTT04gdG8gcmVkdWNlIHRoZSBkdXBsaWNhdGlvbi4NCj4gPj4NCj4gPj4gSSBoYWQgZG9u
ZSB3b3JrIG9uIHRoaXMgZm9yIGN1cnJlbnQgQ1BVcywgYnV0IG5ldmVyIGdvdCBpdCBmaW5pc2hl
ZC4NCj4gPj4gTGV0IG1lIGNoZWNrIHRoZSBzdGF0dXMuDQo+ID4gSWYgeW91IGxldCBtZSBrbm93
IHRoZSByZXN1bHQsIEkgd2lsbCByZXNlbmQgdGhlIHBhdGNoIGFjY29yZGluZyB0byB0aGUgcG9s
aWN5Lg0KPiANCj4gSSBqdXN0IHNlbnQgdGhpczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8xNjExNTc1NjAwLTI0NDAtMS1naXQtc2VuZC1lbWFpbC1qb2huLmdhcnJ5QGh1DQo+IGF3
ZWkuY29tL1QvI3UNCj4gDQo+IEFuZCBub3cgSSBoYXZlIG5vdGljZWQgdGhhdCBJIGRpZCBub3Qg
Y2MgYXJtNjQgcmV2aWV3ZXJzIDooDQo+IA0KPiBBbnl3YXksIGl0IHNob3VsZCBiZSBvayB0byBi
YXNlIG9uIHRoYXQgc2VyaWVzLg0KPiANCj4gQW5kIHBsZWFzZSBhZGQgZ3V5cyB1bmRlciAiUEVS
Rk9STUFOQ0UgRVZFTlRTIFNVQlNZU1RFTSIgZm9yIHNlbmRpbmcNCj4gcGF0Y2hlcyBmb3IgcGVy
ZiwgYW5kIG5vdCBqdXN0IHRoZSBhcm02NCBndXlzLg0KPiANCj4gVGhhbmtzLA0KPiBKb2huDQo=
