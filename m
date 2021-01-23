Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E75301710
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 18:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbhAWRDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 12:03:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16942 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 12:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611421425; x=1642957425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c10A4sHfyyLjeouHZh8+E8X77jDKemtMIF4Aoe5zwi0=;
  b=wROrDyInhWOO6op9vvKUiup0K/CX96uI+/Cu792vSNwoLlkGvpfYcIcC
   x2bnzuXJBpthfcRHIRaRMXDuxdCAa4CLPhpo6HvWo/trWZUQJLQYQ1j31
   upjajN49lJ0fSOPF0FDJ8CwH4BX9vAYyYlLQhAJBndHq+4VKjAbXvXCMg
   QyUshMWzC4TfVywtwtjXWMoQlAtL90Hqx5nUwAh4kkFAxnhNjlX+Yo6xS
   SYZ1cvkh7YHru0mXMzfi/xnObSdUQBSCOpZnAgV1Sbspv+imPhCo1kvhY
   4Cr4zE6xXJSrnMJDFSgmCqeu52fI4mQVxLZJryN/cMl6psPFWBLLtTucZ
   w==;
IronPort-SDR: V61o9ynxm4MJa0LQ3FLV9nzO12DvmQ1Ghy/+vgYlg9hOmQUsoK8rH/LclC7N1hK/P4RgqXyuYD
 q0EGfdCVWjaBBhDXLCaHTr/KyKaZb3I7LbXydvB85Wq59eEqnP7s/ww1pL9OaSLL4aR6F+Gf/U
 jlyykUQVm1f+Lu0LEKtWM7dMfgVUTc3ZdJQsY7eeGr3B2LrHZTcOL8PeCb+HlEAu/hWzDKI5j5
 WOjtRbJ1zchu9jaZGkPo9+Kk8+6nJXvwXEqCPtUxMZ5asuQhEjeFaVbDKOMMcXIAyMCQrxFz1B
 3WI=
X-IronPort-AV: E=Sophos;i="5.79,369,1602572400"; 
   d="scan'208";a="112223088"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2021 10:02:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 23 Jan 2021 10:02:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Sat, 23 Jan 2021 10:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj1M+IcY0mDWTV3d7xgkMQ5EH+NVU8SHqZMCBY7xJMqv7YLVlGXjDYXPDsKtT5EKyoqMR5f9aYNGdxtdlHHk5ebeud7CGDI4GKNImNK3csY2uBSssR4uCWNm91BZohRhHkodkkp/SKsdrLWPuCB9piXpSmxR5PB5zKFZSSWgv43DRDbWHfclqrbMCosa+DIjs5PgW7RdUuORssOBOx+6XSmKYcpDs2QjjxK5YudXIHaLk43iCafho/jmX6Lx6r4SKM47H8Vzs4HufYsGjRfe+Eyu2qOFUy5Oym6rqdBQMyfqCRcsKz2hki+cUnR7sNpt14iTEYKoo3aVH+bunmOfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c10A4sHfyyLjeouHZh8+E8X77jDKemtMIF4Aoe5zwi0=;
 b=ZXCy0fzw61xkKjYE2DlR+Dir0AiNzuqKAs8qHyoUfyemKjYUswqUT3/DDISFtDUfgnZF3wlW1/M7HxZY4RiqnrJbO7NgUZpHyshk+pKXHR2TYkW89bS0iEXMSG383fUFfWRu5133c+uxJATsUvpTLGMTy/hsVbYhZHAz3FBkFHo0z4+W7GiRMBm2nVtO5+//K149MbNVAL7RytHTus0drNm7rlEqlaSWws/C0N9vnR9OzFYeS/7NDWDyC5CosOWm+VswInZxFD+xX9tMQrUuM4bvx2JvHTewVkwa6IpOhMRsenbZR/O/FbupmF/vQue6rw9s20yBVTP4DTbUTkgg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c10A4sHfyyLjeouHZh8+E8X77jDKemtMIF4Aoe5zwi0=;
 b=Us0dwuyOukxEH1IkyGaxwiywmPo+OWaJSjxFqr0SVUCxFjxjaxdo5yz4G035J/+4f5AhzrnNM7FI0EEQd4MfPDecE3wixpkhAo8QWat973nuxQ9FkAPFDyjpnM6SOs9NXulcBz5olI9P6/+dHG396mtMTXYinDeKfV2tZriFV8A=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3102.namprd11.prod.outlook.com (2603:10b6:805:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Sat, 23 Jan
 2021 17:02:28 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.017; Sat, 23 Jan 2021
 17:02:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <andreas@rammhold.de>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <microcaicai@gmail.com>, <daniel@makrotopia.org>
Subject: Re: [PATCH] spi-nor: Add support for xt25f128b
Thread-Topic: [PATCH] spi-nor: Add support for xt25f128b
Thread-Index: AQHW8amGXnetse7GDkStiA6zZMefFg==
Date:   Sat, 23 Jan 2021 17:02:28 +0000
Message-ID: <40568568-b314-7a23-8164-84cbc98debdb@microchip.com>
References: <20201220224314.2659-1-andreas@rammhold.de>
In-Reply-To: <20201220224314.2659-1-andreas@rammhold.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: rammhold.de; dkim=none (message not signed)
 header.d=none;rammhold.de; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfd352b4-7f37-4d9c-da9b-08d8bfc0aa31
x-ms-traffictypediagnostic: SN6PR11MB3102:
x-microsoft-antispam-prvs: <SN6PR11MB31028795015874CEFCF3FB84F0BF9@SN6PR11MB3102.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V5P4Vp7APyo1vbk9Mg9A+6Ysuwn3e4mGP8UvCTXRKupSDoqzlxw4RtA9uQWCZ8DAGj/+U15i+jTuM1l7+iHtwqdzdVuiHwyQBdLIUWwLbKWII5lhFfDMfeUJgMtNxkMe8r4u9Z6aK6DUG8garhWyDfhR349FfFGCoocYQRf3LX0AHX6lJ/hFoizzwpXW2dFX3z+OhD2RNdEXoTiXYf0cZqc5CJnRvCHeNR3VXP7SedPYcFEv8NHQ3Etmvuhx0Raqmgs9uWMgK4LcdQ5DQdzoZMunOhMDzlc6W0DtZGJyuoUC3d9myjV+Xu+ms+SfmA8D5wd+6jHgSK9QlvkM13427g6jzejRZeRk2wRAt9ByCxeLBJj3pS9+WKsAV+Fj3NQmUERtD42VtTEmjwWfFhrJvlQHJGMRsoAsiwBRz5dxl2l1Cff18C+nSceCO1Mhf5WE+nFcePdhRt4VlRtQ1bDuF8BOeKgTPikFIaoQQZ+zIZoJakmZdW8D9i3cTnLByhq6oyP4f5jTv7sW/sdY8FCu4+ww08I0FiuqdvPx2ur/JPO3ZG+SuiR4nUTgXl+YrjCjIXSxREK2H6WfV0GhqJyk+v3Sqvui2rRUYKQAx4+5E1unuEqfn9bdaytOI4Hvu63tJlETU1xaGMCxskI3q9E93X9gg4lN8OXpsqDO5+ULtK3CxHCnH62ojmLYuWojn6kcC3tGdMI+dPJSHUzd0iqEZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39850400004)(5660300002)(4326008)(71200400001)(66556008)(66476007)(36756003)(316002)(54906003)(66446008)(66946007)(91956017)(110136005)(76116006)(8936002)(6506007)(2906002)(6512007)(83380400001)(53546011)(6486002)(31686004)(64756008)(186003)(26005)(2616005)(478600001)(86362001)(31696002)(966005)(8676002)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Yjdacy9TWGZGczhyV1BnTlNvYmlZSU51WjVEc09pYlhnQ1hxdS95aGxZQWpT?=
 =?utf-8?B?aENWMXY4M3hpQTdXSTBaSFJYUUczRzRuMDRxR3E1L3dsUmtFUlhzR3BrblpG?=
 =?utf-8?B?S0N3ajluaUZMUy92QkVBQ2c1Y1lkYTRMQUF1UXFkYjl1REJCV3NCUU9Vd05N?=
 =?utf-8?B?bFgwb2lCK2hWK0JZVGx6RnlqV3RtRVN1WE8xVytwelMyVnovSW5SMVU3azh6?=
 =?utf-8?B?NURISDRsT3hzenpKamxhUUpMNjVTUVNjM2taS1duWTZqRTNpdEpQbDBtRFl2?=
 =?utf-8?B?SWpYT2N5eG9rbkNTSU9QQzN2QTRRS3VWOUtvYmtaL0pXU3ZVRThaQ1luR1k4?=
 =?utf-8?B?M1JBSjdUcXd1V3Z5Sm0zSFU1SjMvU0U2ZGF5cTBNWFZDdVBjWEtsakI1bHVr?=
 =?utf-8?B?L215VlJYVHkxRUd1UDdzZ0tBczM3blVkYTFQbGNBRGFYLzd0R1RuYi95VlVS?=
 =?utf-8?B?VDNUZGhJbXR0WHpQMGt5VU9VZU5Ba2lLWWdkd2k4dTAzSnMyNDZOaFlWTnh2?=
 =?utf-8?B?Q29KS0dwZUl3b25QTjd2Y2pBUEh6bUFuOHlXbGdIaXpsQUMzYmtCcFdtZHRD?=
 =?utf-8?B?dWpWU1MvZTZSdlJHajRjTG1JRnd5R2pEYmFhUU9vZDdEU01TaDQ5QTZjZ29W?=
 =?utf-8?B?Sm9QYnVRZlZ6YTQyeUFUZnBCUmlqdGVPRmlDUVd6bjlUdEF2UXlNNDM2WVhY?=
 =?utf-8?B?c1BESTBmcWRGeXM2a3E5OHQ5ckZieXZrcExMQ0VEVENEeHgvT0pHUk8wcEZt?=
 =?utf-8?B?RDNBNmpxdnRidWNUaExoWW1KN2tCalF2L3l6TzJFeHpxdVI3cytmQ1N0RnVU?=
 =?utf-8?B?eE1td0MyVnJseHlyWnJnOXMyczJVbVQ1c1pwZXVhLzRBYmplRGFGYWlCR2FT?=
 =?utf-8?B?Wi8vZDhhNG42dSt0NTViVUpvNFZ1VjlLUGcreVhic29YdzBsa29ZWGd4czQv?=
 =?utf-8?B?S2JFUEVEVTNVUG9qRzFvdkFZWWRLREJpV1VXSjg3Mk95cTNmME10N2lhZjVY?=
 =?utf-8?B?UVBGdTZUeXVtZmFaTm91K2JjVGllRXV2RjRQeHBQd3dwSGZmakRjYVRUQ3lO?=
 =?utf-8?B?dFpGbUl1TndiTkNaRFdFVk9xbXUxR1N5U3FUeXJwRE9TZXZrWDNoa3VJVVpy?=
 =?utf-8?B?K2VVZjROcXpTZEhxcEhybWtYbHdpenFPMzdkVyt6L2V4VjJzUTRNeUhMNVBy?=
 =?utf-8?B?ai9ONkVIM3c4dGhIQlE4ZGgzRDMxc3FvbEdPb3FKa242Z0dVWXdNa09GTW1Q?=
 =?utf-8?B?dXZhNk9kU0hIZHZnVHYyUVVNZkFwQ3oyRDh1dDdkRno1UXQycnp5RHFyRXVw?=
 =?utf-8?B?bUF6MDBET1pNaFVzUjR1eUZOYkJVNzVxZzNIcUxMdStOMFJQRHRhb1RBSXNB?=
 =?utf-8?Q?Oocpk1hsiVlpSth3wD3Xnh7W0m1CPRzA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <87E0CFA6333FDA46B08B9ADA20E41DCB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd352b4-7f37-4d9c-da9b-08d8bfc0aa31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 17:02:28.1222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWY8DtecQtzmdFXFyTy5zm12t0UK0astkwe/7mj5dUgWIH/44CN3F48n1FIBzPkew+NRegMoaayXAFJQdbBr+GI2QubPKMfZD8RDrQ4TzJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZHJlYXMsDQoNCk9uIDEyLzIxLzIwIDEyOjQzIEFNLCBBbmRyZWFzIFJhbW1ob2xkIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoaXMgYWRk
cyBzdXBwb3J0IGZvciB0aGUgeHQyNWYxMjhiIGFzIGZvdW5kIG9uIHRoZSByb2NrcGk0YiBTQkMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIFJhbW1ob2xkIDxhbmRyZWFzQHJhbW1ob2xk
LmRlPg0KPiAtLS0NCj4gDQo+IFRoaXMgY29udGludWVzIHRoZSBlZmZvcnRzIGRvbmUgaW4gWzFd
ICYgWzJdIHRoYXQgd2VudCBzdGFsZS4gSSd2ZQ0KPiB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiBteSBS
b2NrUGk0YiB3aGljaCBvbmx5IGhhcyB0aGUgeHQyNWYxMjhiIChhbmQgbm90DQo+IHRoZSB4dDI1
ZjMyYiBhcyBhbHNvIHByb3BzZWQgaW4gWzJdKS4gSSBoYXZlIHRyaWVkIHRvIG9idGFpbiBhIGNv
cHkgb2YNCj4gdGhlIGRhdGFzaGVldHMgYnV0IHdhcyB1bmFibGUgdG8gZmluZCB0aGVtLiBOb3Qg
c3VyZSB3aHJlIHlvdSB3b3VsZCBnZXQNCj4gdGhlbS4NCj4gDQo+IFdoaWxlIFsxXSB3YXMgYWxy
ZWFkeSBmb3IgdGhlIG5ldyBzcGktbm9yIGxheW91dCBpdCB3YXMgbWlzc2luZyB0aGUgYml0cw0K
PiBpbiB0aGUgY29yZS57YyxofSBmaWxlcy4NCj4gDQo+IA0KPiBbMV06IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQvcGF0Y2gvQ0FNZ3FPMnk5TVlEajZhbnRP
YVdMQlJLVTh2R0V3cUNCLVkxVGtYVFNXc21zZWQrVzZBQG1haWwuZ21haWwuY29tLw0KPiBbMl06
IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQvcGF0Y2gvMjAy
MDAyMDYxNzE5NDEuR0EyMzk4QG1ha3JvdG9waWEub3JnLw0KPiANCj4gIGRyaXZlcnMvbXRkL3Nw
aS1ub3IvTWFrZWZpbGUgfCAgMSArDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAgIHwg
IDEgKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggICB8ICAxICsNCj4gIGRyaXZlcnMv
bXRkL3NwaS1ub3IveHR4LmMgICAgfCAxNiArKysrKysrKysrKysrKysrDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210
ZC9zcGktbm9yL3h0eC5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9N
YWtlZmlsZSBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvTWFrZWZpbGUNCj4gaW5kZXggNjUzOTIzODk2
MjA1Li4zZjdhNTJkN2ZhMGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvTWFr
ZWZpbGUNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmlsZQ0KPiBAQCAtMTcsNiAr
MTcsNyBAQCBzcGktbm9yLW9ianMgICAgICAgICAgICAgICAgICArPSBzc3Qubw0KPiAgc3BpLW5v
ci1vYmpzICAgICAgICAgICAgICAgICAgICs9IHdpbmJvbmQubw0KPiAgc3BpLW5vci1vYmpzICAg
ICAgICAgICAgICAgICAgICs9IHhpbGlueC5vDQo+ICBzcGktbm9yLW9ianMgICAgICAgICAgICAg
ICAgICAgKz0geG1jLm8NCj4gK3NwaS1ub3Itb2JqcyAgICAgICAgICAgICAgICAgICArPSB4dHgu
bw0KPiAgb2JqLSQoQ09ORklHX01URF9TUElfTk9SKSAgICAgICs9IHNwaS1ub3Iubw0KPiANCj4g
IG9iai0kKENPTkZJR19NVERfU1BJX05PUikgICAgICArPSBjb250cm9sbGVycy8NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4gaW5kZXggZjBhZTdhMDE3MDNhLi5jYTE5ODg1NTQ5NDUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+IEBAIC0yMDI0LDYgKzIwMjQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9u
b3JfbWFudWZhY3R1cmVyICptYW51ZmFjdHVyZXJzW10gPSB7DQo+ICAgICAgICAgJnNwaV9ub3Jf
d2luYm9uZCwNCj4gICAgICAgICAmc3BpX25vcl94aWxpbngsDQo+ICAgICAgICAgJnNwaV9ub3Jf
eG1jLA0KPiArICAgICAgICZzcGlfbm9yX3h0eCwNCj4gIH07DQo+IA0KPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBmbGFzaF9pbmZvICoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gaW5kZXggNmYyZjZiMjcxNzNm
Li5jZWE4YzBjMjVjOWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5o
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IEBAIC0zOTgsNiArMzk4LDcg
QEAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciBzcGlfbm9yX3NzdDsN
Cj4gIGV4dGVybiBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9tYW51ZmFjdHVyZXIgc3BpX25vcl93aW5i
b25kOw0KPiAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciBzcGlfbm9y
X3hpbGlueDsNCj4gIGV4dGVybiBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9tYW51ZmFjdHVyZXIgc3Bp
X25vcl94bWM7DQo+ICtleHRlcm4gY29uc3Qgc3RydWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyIHNw
aV9ub3JfeHR4Ow0KPiANCj4gIGludCBzcGlfbm9yX3dyaXRlX2VuYWJsZShzdHJ1Y3Qgc3BpX25v
ciAqbm9yKTsNCj4gIGludCBzcGlfbm9yX3dyaXRlX2Rpc2FibGUoc3RydWN0IHNwaV9ub3IgKm5v
cik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3h0eC5jIGIvZHJpdmVycy9t
dGQvc3BpLW5vci94dHguYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmExMDEwMmQ4YjNlMg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IveHR4LmMNCj4gQEAgLTAsMCArMSwxNiBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L210ZC9zcGktbm9yLmg+
DQo+ICsNCj4gKyNpbmNsdWRlICJjb3JlLmgiDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
Zmxhc2hfaW5mbyB4dHhfcGFydHNbXSA9IHsNCj4gKyAvKiBYVFggKFNoZW56aGVuIFhpbiBUaWFu
IFhpYSBUZWNoKSAqLw0KPiArIHsgInh0MjVmMTI4YiIsIElORk8oMHgwYjQwMTgsIDAsIDY0ICog
MTAyNCwgMjU2LCBTRUNUXzRLKSB9LA0KDQpBY2NvcmRpbmcgdG8gSkVQMTA2QkEsIHRoZSBYVFgn
cyBpZGVudGlmaWNhdGlvbiBjb2RlIGlzIGluIGJhbmsgMTANCmFuZCBpcyBjb21wcmlzZWQgb2Yg
OSBDb250aW51YXRpb24gQ29kZXMgKDB4N2YpIGFuZCB0aGVuIGJ5IDBCLg0KWFRYJ3MgbWFudWZh
Y3R1cmVyIElEIHNob3VsZCBiZToNCjB4N2YsIDB4N2YsIDB4N2YsIDB4N2YsIDB4N2YsIDB4N2Ys
IDB4N2YsIDB4N2YsIDB4N2YsIDB4MGIuDQoNCkNhbiB5b3UgaGFjayB0aGUgU1BJX05PUl9NQVhf
SURfTEVOIGZpZWxkLCBpbiBvcmRlciB0byByZWFkIDEyDQpvciBtb3JlIGJ5dGVzPyBJIGFzc3Vt
ZSBYVFggZ290IGl0IHdyb25nLCBhbmQgcHV0IHRoZQ0KY29udGludWF0aW9uIGNvZGVzIGFmdGVy
IHRoZSBmbGFzaCBJRC4NCg0KQ2hlZXJzLA0KdGENCg0KPiArfTsNCj4gKw0KPiArY29uc3Qgc3Ry
dWN0IHNwaV9ub3JfbWFudWZhY3R1cmVyIHNwaV9ub3JfeHR4ID0gew0KPiArIC5uYW1lID0gInh0
eCIsDQo+ICsgLnBhcnRzID0geHR4X3BhcnRzLA0KPiArIC5ucGFydHMgPSBBUlJBWV9TSVpFKHh0
eF9wYXJ0cyksDQo+ICt9Ow0KPiAtLQ0KPiAyLjI5LjINCj4gDQoNCg==
