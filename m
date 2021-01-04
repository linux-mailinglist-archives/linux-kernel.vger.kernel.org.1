Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC172E9242
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhADI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:59:49 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:51793 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbhADI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1609750788; x=1641286788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x0AERHHhwN9faRAvzNiJ452mrWq9xcth9YQI/p8sL8c=;
  b=BHy9OjJsNb0FFgLYMVG/u4y9AbHJnHWDPWlcThf8gYKsP4cPmLtnCRfS
   1Xwz8lwtvGxV3V7i/uOza2oRJxvOQLQzOT7AiOv/4uXdIF0VQzYD5Ig3O
   xnMPlyD/pgLyPueE1fffWTesXP4KHmBTGDYU/9LQ96K898OZOdoH6n5Le
   mtHiz/6+BshG5g+pXUMOo48UpyIOE3Yinoz+/q8DrOSD11siytn5/jmv9
   Q/hAc9LXPWsDbKbfEpzvK6XSsTtquczRphxJyJbZHs0bFx+0tph5a85ia
   clCHz3ZmGURZab/Sb8G57T8f8N5i4Bf1zvntE5eFLpoIWol2W2GRnILBF
   w==;
IronPort-SDR: FBipawBEFtWpb+mtMaCR/KSODq63DG/xmMeyUhf43sy/PYud1E1FDtupAuaZIbkpKakqFvn2Bb
 Jtd9IN00Uszhnisqd7p7el1paHspvFSczSE39LBGaH7GXnXKT5xCbfi+SMBoFheJCJJltcVBX1
 U6Ruw5umnp79wHcJfwd3JLqe3XwBc+2Uh6XgMv77Evuu79imUYqBITCbR9IEYuZ4vQcuGPpmuN
 lgIxklFk0XpEK/QYtLq0v6IVp4j2r7MMsOyhObgkEKr6KFJDX4sXYSXRMb/R0AWDwJT7iNTXJh
 uKQ=
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="104694961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jan 2021 01:58:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 4 Jan 2021 01:58:29 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 4 Jan 2021 01:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXZ1yvBcnDkUbiA7qz9IyUIL6E8Mszsv/KLSG9Pr4nxB6dl50g4W+v2mGYeFbkbg7x8tB/yI+vwwvp//VLHiaCo8IHtWqS8jOGG0VgT99TDcEFyNf6Czf/OswvL+Aq891GX1GHbcGR5HH5AnpevnB8zwzuSvKglIDHUm5V4str9Ju0yyVz9HVeisjFCITKJjKA2BZtBzD2H8X1qxhz6cxmewc5Vew4RHN5XJHyeIbuthr/wUYm/zwc8zEx6+fSc/oXc1NxLVgXJscRZbMyJX8vLf2jU+Dp93jGx8GWt1LAJaqVoTCdbOH2KKJAvUVin71NjKkGeiveDvDwjl2zy6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0AERHHhwN9faRAvzNiJ452mrWq9xcth9YQI/p8sL8c=;
 b=AgDjryYS2XVvxQAcx7nKwHhHhPB7Ruvkj72jGo4Cr9fzkAYJ8ZAHR39COeYEN7dwRD+oZ/fbkPapBroEj86+UMSFIatziVti5mDJljCX1Xe0imjfLImUAEUD1+UUk+loi52nKmj04MAJmnwKxt+L+EFetX+QMNBcOnCTQRe58v7oFEiWXp8wD054N8l7rtgANSyWuLhw14Gw5i6P/xpNOF2vh/rG9VqSCyOPcFheW0radxOiiUryk5VIUTdxZBm6gGRkWEMe1+JV9XTu5strp4wgAggDQazO8CX7wE07AW3XFt2QurCOEtjUZNX4t8CUM9JFp4u/P6Yfx0nSvpgjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0AERHHhwN9faRAvzNiJ452mrWq9xcth9YQI/p8sL8c=;
 b=JaQWmK/gjf6dR8buGbOKVwE1ELj5iXs4u/vDXD+mSnElalirobxQud2jdtJ9vS/BnG6Gu91Qkbg5CezIt/REBy8GmkqsMJV+7WkOrZYyA/g7E/ZbFJFUA050KEA4glrmE7O0BnQCC5MKlT8DuuvCwjgVs2m5nbnlxcZ+8iPKz/s=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2879.namprd11.prod.outlook.com (2603:10b6:805:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 08:58:27 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 08:58:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <shuhao.mai.1990@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: winbond: Add support for w25q512jv
Thread-Topic: [PATCH] mtd: spi-nor: winbond: Add support for w25q512jv
Thread-Index: AQHW4nfDfALMdqq+RU+TfKMGImMTYA==
Date:   Mon, 4 Jan 2021 08:58:26 +0000
Message-ID: <6e59d200-f4a6-459e-8cba-86782413ae8b@microchip.com>
References: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
In-Reply-To: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57345f22-cd96-4862-7d40-08d8b08ee672
x-ms-traffictypediagnostic: SN6PR11MB2879:
x-microsoft-antispam-prvs: <SN6PR11MB2879D967E7681E9109B5B74BF0D20@SN6PR11MB2879.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhjKX6JivlBSuGTrOlP7IlGmijReT+eQraA/oQNr49WzQSDSyhytBJ1QVbQkCdMcB/CGvN/D4zRPL5x/tf3rYIiPOnQjP+rC48Asmj5Muwi3qtj0LVnS/vXT+kH2S0IEC+i5Wue+SD4KVlLKuegV+3UWUhI8Cg2tgDPPq90jr9ofL8BNg2b4THeB2HlEIDseIb1VKyNci5VCsGVLuWtUJnALw7ZDpnVtJzyr0sxDcCmKP33F9dlbfTHK935O3I8VYxwRyoocapbTVuS6HXmO5KgLAjofpV/veH96c8GZIMg+5rZezRTGjFQ08KXHT7l+XRP0emA1pZqURAqCsD6q5W50zNlBuMrIVhrlDxyWJZCXbbiGa+Ty9nj+DeU/RRi5zsW8jrbvhIpyN/ujOrUOO+v8qgy2X0yWyERbEU7GeY/sMGDChWAEY6JJY0vLmxCkILJZErqGziehWOhaPiYw32AyJmTAmURB1qA0JssS1YsPeUo7a4L6Bq2Qs0MoxEMwuC+ktmsuQ7nzX3MIxAPnY9J82ch1RFZGfH9J0bMRL0FD5FI1IkuhyD4pEhmBTVG/zwjkM6m5YeXyafmWDMqoBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(346002)(136003)(8676002)(5660300002)(478600001)(26005)(66556008)(6512007)(186003)(36756003)(66946007)(4326008)(76116006)(91956017)(31696002)(110136005)(66476007)(54906003)(86362001)(64756008)(66446008)(8936002)(6506007)(83380400001)(966005)(53546011)(71200400001)(316002)(2616005)(6486002)(31686004)(2906002)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eXhmM2l5YUJvc01VYnMxTkxrdG9PM1dqMDdJY3Rwb2tGaHBsSUhSSm1xaHZ2?=
 =?utf-8?B?dHBvL3dWUlpQQjBRS1Yzdzl2dzM0K3lGUGpZRDNJK2RQS0RlQXVGa09KbGN6?=
 =?utf-8?B?VUUxNWJ1SHJFTlM4MGRLb1lNbC8rbllidzJtanBsY21DWEFDTERoNkdPUHJi?=
 =?utf-8?B?aGMwMXVMR2FZN1lEckQ2SkdHdEQ1RVBuZXBVZktpRVQ1eFFOTTBoMVJtaDZt?=
 =?utf-8?B?REppc3FEdFhET1lRUi93SWdZSm9GSkVFRWdveG84UmprS3RjZGRDamRHWUlU?=
 =?utf-8?B?WExOanRYeklIRUVuYVVPbWdoUkhIZkpVY1VvZnVuS2c3TXE0aUF3ZndzZDBN?=
 =?utf-8?B?NEJUd3dGUU1XYjIrVU5MRlVISklGcnFrdFREVHYvYmVjRDl5TFJPNXBHaERr?=
 =?utf-8?B?bmJuWk9BZmdiWWpoUW92V0xlVHYwKzVIeTdVeUpKTWg4VTdob0hjVldVa1ox?=
 =?utf-8?B?QlI1L1BYSExpVG80WHNCUmVLdUxvNjVmQVg5ZWd5amNmSjVBb0w2bVlHMUNQ?=
 =?utf-8?B?TUR3K3ZqbWx4bDBZQjFRSWR0U2t5Y3RNcEtXODh6UlJYSFhmSnB6UWV5N1F5?=
 =?utf-8?B?aFF1b3VWM0VCNWlMTnlGVm40V1ZpR1orVWZ4NmlVTnVJdXZabi80SWhld3Z6?=
 =?utf-8?B?VHd6dkdHc2llajNLUm4vaFZPTmtUNXJNNXg4Zzd5b0pMb0dHcEg5Q1VYalNp?=
 =?utf-8?B?NXVGL3BITU5GYXhFcW8vaXJSRXp3Z3hzN1ZzN3h6ZnBqa1E3VGYrc05UeDdO?=
 =?utf-8?B?ZXovOUsxOXYwbHR2c05FNG41MG8wQkgxVVBGbnN0aER6T05aaEtRSkJhTElo?=
 =?utf-8?B?VExQa0lxRTFXL1phRW9NTE55dHJwaFZocFZmaG0wUlZxNUtuaHhwUFJBWkhh?=
 =?utf-8?B?VE55WmZocFpyWndTQStnejRPdjJnN3JIY1FDanl3dEZDWnhDVXo2MWVjdTRI?=
 =?utf-8?B?bThaWUljTWtTMWk0QldRWlBneXVRdmU2aDZySXl5ZTgrRGRycEJvOUY5dHlt?=
 =?utf-8?B?T0VsRXdNVU82blRrc05oWHBxeEdFM1QwUWdEZFQ5YndJdE9Ea0VBNjJKZ0ZF?=
 =?utf-8?B?bkZPL3ovR0JlQkFhMW9WaUVydkVybW5IVU5zcWgyQ3ZyL3pVRzBqRUdYeXlM?=
 =?utf-8?B?MzlFOWJNbWtFZFUwbEhFdFZ5aHJKQUJFREJJVm9aczRjZTRDSGN2eDk5Z202?=
 =?utf-8?B?SGR2clhWY21rZHF0dWRFRjh2MmkxdnBWZDNZM3JhL3BQeWhtSy9tSEwxM0Nx?=
 =?utf-8?B?NGNHbHdDdUk0TFh3cy95K21WNXlxbC9pcmVlYmlkNzFSUW92NGlGWDVlYzJl?=
 =?utf-8?Q?y9ijVzLXkeTB8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <24ECFCC22852EB4289D61915E0260611@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57345f22-cd96-4862-7d40-08d8b08ee672
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 08:58:26.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Judq+RCM3hGYIThXjWErVcCgq0oKMlEhLGAzvU1DEY9Tn19V+rzNn3r5FvTJkC/CO5kHwXIUPGV1DIRU/HJRuFddgZuAei3dSBUa+tK4NdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2879
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWhhbywNCg0KT24gMTEvMTEvMjAgMzo0NSBBTSwgU2h1aGFvIE1haSB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dzI1cTUxMmp2LiBUaGlzIGlzIG9mIHRoZSBzYW1lIHNlcmllcyBjaGlwIHdpdGgNCj4gdzI1cTI1
Nmp2LCB3aGljaCBpcyBhbHJlYWR5IHN1cHBvcnRlZCwgYnV0IHdpdGggc2l6ZSBkb3VibGVkIGFu
ZA0KPiBkaWZmZXJlbnQgSkVERUMgSUQuDQoNCldoZXJlIGFuZCBob3cgd2FzIHRoaXMgdGVzdGVk
PyBQbGVhc2UgYWRkIHRoaXMgaW5mbyBpbiB0aGUgY29tbWl0DQptZXNzYWdlLg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBTaHVoYW8gTWFpIDxzaHVoYW8ubWFpLjE5OTBAZ21haWwuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jIHwgMiArKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivd2luYm9uZC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4gaW5kZXgg
ZTVkZmE3ODZmMTkwLi5iZWFhNjM4OWUyZGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivd2luYm9uZC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+
IEBAIC05Nyw2ICs5Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyB3aW5ib25k
X3BhcnRzW10gPSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQ
SV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ICAgICAgICAgeyAidzI1
bTUxMmp2IiwgSU5GTygweGVmNzExOSwgMCwgNjQgKiAxMDI0LCAxMDI0LA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfUVVBRF9SRUFEIHwgU1BJX05PUl9E
VUFMX1JFQUQpIH0sDQo+ICsgICAgICAgeyAidzI1cTUxMmp2IiwgSU5GTygweGVmNDAyMCwgMCwg
NjQgKiAxMDI0LCAxMDI0LA0KDQpXZSBzaG91bGQgbmFtZSBpdCAidzI1cTUxMmp2cSIgaW4gb3Jk
ZXIgdG8gZGlmZmVyZW50aWF0ZSBpdCB0byB0aGUNCiJNIiB2ZXJzaW9uOiBodHRwczovL3d3dy53
aW5ib25kLmNvbS9yZXNvdXJjZS1maWxlcy9XMjVRNTEySlYlMjBEVFIlMjBSZXZEJTIwMDYyOTIw
MjAlMjAxMzMucGRmDQoNClRoZSBmbGFzaCBzdXBwb3J0cyBCUCBsb2NraW5nIGFuZCB3ZSBjYW4g
ZW5hYmxlIGl0IGlmIHlvdSBjYW4gdGVzdCANCnRoZSBsb2NraW5nIHdpdGggbXRkLXV0aWxzLiBO
b3QgbWFuZGF0b3J5IHRob3VnaC4NCg0KQ2hlZXJzLA0KdGENCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX1FVQURfUkVBRCB8IFNQSV9OT1JfRFVBTF9SRUFE
KSB9LA0KPiAgfTsNCj4gDQo+ICAvKioNCj4gLS0NCj4gMi4yMC4xDQo+IA0KDQo=
