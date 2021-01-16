Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03342F8A37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 02:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbhAPBEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 20:04:52 -0500
Received: from mail-eopbgr1320091.outbound.protection.outlook.com ([40.107.132.91]:20755
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbhAPBEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 20:04:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbYMD9hU7DGMQdWQ6me8IiviHRygJBVahH7HeWefeSBThmFTysKM5cBbguQ36+9jFeqdDkFbDm4KdOxG7gVfOx693gEbWCR6JlyK8x4D/9h9ZeGIG/QyNOg3BWKBB4jj3c6bz0yplk8bIbibbwEANWtBnVGaKl619Tf2RF8y26fc1uVLKhOUICMZjKykBzLUUvr7ayLHVq41E5+WwJEwnlDnW7gOAiH9Ws+okzOMY1GkqrLM6jWNVYjWayHcAh+EMVo2FYRm14LypiA9hFGlY18yEbiMGUEvMB12dx8o865yOz+OzOBW7jRSvJ5CtcQGYfr8RncTC/kTZeLPyfX/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMMDMJZPNCkQxmOfwYzTTsCUABFlN0efzltGbxzh4+k=;
 b=f3D4MPsJmNhYeZfNyMpq5nYSRKU5evpnALKQ5KV/8AJQF7laRlnVVoMKeQwmp7ZbF2Mi+aWpmxHJTFuEik/jIUDTHIK9xhOnIGXo4+HI3yfnzEWt0F6kSWpAcZ70LPZJsuCVfHnFTspayEVbXOlnsL+oWouxHJWJ4kqTbJAI40thgADqLtmPvNaWmDhaN+XSfaBBY00f9UHilf52MLssS3BIBMmAnPDgU4a5NRcIqBa6ERpENOdjYdNMNiAr3ZArK2eeRKsIFMFloA0oYL3WqA3JERsaRPo+wHKKou8xMbrCK7cY3jyxMwTYKTfNzNH9ZPlo5t2tY+89BIvgFbXI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2241.apcprd06.prod.outlook.com (2603:1096:203:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Sat, 16 Jan
 2021 01:03:12 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9%6]) with mapi id 15.20.3763.011; Sat, 16 Jan 2021
 01:03:11 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     John Wang <wangzhiqiang.bj@bytedance.com>,
        "xuxiaohan@bytedance.com" <xuxiaohan@bytedance.com>,
        "yulei.sh@bytedance.com" <yulei.sh@bytedance.com>,
        Robert Lippert <rlippert@google.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Patrick Venture <venture@google.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        Joel Stanley <joel@linux.ibm.com>,
        Andrew Jeffery <andrewrj@au1.ibm.com>
Subject: RE: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
Thread-Topic: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
Thread-Index: AQHWzUMNmbahDDZWh0mpYVY7renfO6oaiJvQgA6d2ACAAITIoA==
Date:   Sat, 16 Jan 2021 01:03:11 +0000
Message-ID: <HK0PR06MB3380A1F79CDE49FACC1A3E71F2A60@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
 <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
In-Reply-To: <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [180.217.39.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 055c136e-88b9-41df-7a56-08d8b9ba7ec8
x-ms-traffictypediagnostic: HK0PR06MB2241:
x-microsoft-antispam-prvs: <HK0PR06MB2241E392791B004655870708F2A60@HK0PR06MB2241.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKAVqz3BEHcwaDhBJ2ZWBwP3ez3ksxWWZYYws3VPBtXnP3AfxhB0VZd9gZjk8bpTbfJrlLAeang2gYs374ERgHL9tbhwdCPCPp28sd6ClXZAPCF8QqLDUNkZjBNFnFh7i62ZR8ePPqDLVmCylOPir/dSVqIy/SdHOzsNNafOepcII/vBvTcxThOhuaXK0kA3asXj7OUYLFJOREdMZvFtVpwMSL/I1SYNM5jkp+u3XLHRXUXJzavJ+ovugreFznCf4IO5adDnkji1Neuce6D/b9kyeRtMjd1oRnUVBl03GgYiPT8sT/eWS7obKB5sVeObg/3USQYg7+kv//W1fqJKRVwxq+Y0z5SxHdB6VM0l6pGyY2kfRkumhKVa5BdCs6IWgPe+np1iGXrgZhb14n+bE4xz7W6JcKJXkdNMCV8zZnZPSi4xSqGlqVAoT49DtdnsefY9eZqhB2Cc02xSXbxihd5QvnUJuX6BJKJ2BaioA4qoR/NH3ynANAZ9uN38lQC5WCiTGYvuHZf1YLBY6kqQB9wYzDZTQeF2+p6tpefIGP9vupxLl2MJ5U3Kx4U8laC8kFIyBlDlEWLHkC7PpbZi7efVBZvYFFmuaVYuOvr+A1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(366004)(346002)(396003)(376002)(86362001)(52536014)(64756008)(54906003)(66446008)(66556008)(5660300002)(2906002)(966005)(66476007)(478600001)(8676002)(66946007)(7696005)(76116006)(9686003)(55016002)(8936002)(33656002)(316002)(6916009)(186003)(4326008)(26005)(71200400001)(6506007)(53546011)(7416002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eWl5ZEx1S2EwVmMxYTF4aHV0MUR3MUtrZFMwSUdaMDhpR0s1b2hsVWtzNEN0?=
 =?utf-8?B?UFdZNnRzTEw4NC9wMUw1L2FhK1paYTZ4R0RWZ2tSZGRuLzhsY083VFg4czZW?=
 =?utf-8?B?SFd5N004bExNeUJKWHlEdkdDRjd3WkFhZ3gwVHFMUW10VEZxOXYwYnhWS1BU?=
 =?utf-8?B?RDBUNDdGTlNZSGZsT3JOeVpHYWREclArekpkOFIxRzR4cnV4U3JRNmhjbWYy?=
 =?utf-8?B?WVFOZm9wMjNFVEVhdHlWWVRwR1pWRkNXemJUb1dxZ3pqekdVc0Uya2Z0VEpT?=
 =?utf-8?B?Q09XTlV1OHhINTFIcXRJRmJ2SU5EUEowZ0N4Ti9WMDJoelJuT1JtVlNZNGs1?=
 =?utf-8?B?dWdnb1JFOUh5bWFCOHJOVVVMMlZrKzR4N2pLZDdYQXl5QkZzS0o5WStHS3RV?=
 =?utf-8?B?OEdMRHlkVjBhT0JSV1FBRTlKdlZ2eG1XQlA0cGt2bDBEemRsbzFCcE1qWXlw?=
 =?utf-8?B?TUFnK1U2VXBnZXhzMG82d2NuS0lGMitzdG8vcWZqU2NyWlRyY1BPcFJxUExp?=
 =?utf-8?B?NFpHYi81UUM0V2dFeDh4L094MjA2a0RKNlk4bXNzaCs2OVFBYkRVVlF1RGpF?=
 =?utf-8?B?c1Z4NmpNZTdiYitmMTlzNndMN1RXbDQyMVA5eU9BUlpyQUVwSUJCOHlTcVZI?=
 =?utf-8?B?cmR1bndva0hyNmtyRWVteFJkRzBmaTNhUmt2N3JrY2F2Y2JiN2FsZ3d0M1pW?=
 =?utf-8?B?RDNHK0VIRGkxZER5RVBqbDhKaUJJdkxNWlZKY3FYamNEeTc1anpYYnhWWFdu?=
 =?utf-8?B?ekhISm1oWWRmMmwxNXIwanBveGdiMWlqKzRHWUFHT3pVUjF1VzgwRUJLZzVX?=
 =?utf-8?B?cWxSWThidHUrdmp3eW9HVE8ydEpLbmhtTzduZFUxS05xbW4xR2ordjRicXJy?=
 =?utf-8?B?QlVzRTdNY3J1eUNzQlRKcVpTN2tMbVpBTEtuVDVmdFVZNnRlTEsveDkwYnFF?=
 =?utf-8?B?UGZGN05SOUNkM09YeWlERlNuMWV6c1pyTTlDNks5bE12OUNaMEJjYmprRjJZ?=
 =?utf-8?B?cElEbHRGNDJzSmliVjNxSWxiRUk5NlhmSnpoRHd2U1YxWXgwQVlnNVpPVDQv?=
 =?utf-8?B?dWhaMVRRWTFFbFBHZHNLOWlRUFNCWkUwQ3U3WmI0UmNyTkNxK3J1SFloQjRG?=
 =?utf-8?B?bGYvaEdubXNVVHlHc05SYnlUdGlsWm1YNnR5eWRhM3BvWmNydEYyS0dqcFNV?=
 =?utf-8?B?L0hUejBXcGErVzNlMEVQNzFaZVdVWDdvMjh5dWh1SnBuUDNNOGgwc3l6aVIx?=
 =?utf-8?B?NnhTNjRqRU9zVE9HQ1AxemVDN1lEREluU2cySFJUYlFQMk16SUxtZVMxNmFC?=
 =?utf-8?Q?6a4Ik3Z8h+P7s=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055c136e-88b9-41df-7a56-08d8b9ba7ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2021 01:03:11.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qyGvj0adyrqaJonOMtezeeuAFyHD/AfeJmiT8xkBK767oI0pLEFfdqeQq4KjIJhSlbLo7S/knaID+PAchZVWIRdQshwPuW+BlFy6EZq9YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDE2LCAyMDIxIDE6MDUgQU0N
Cj4gVG86IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiBDYzogSm9obiBX
YW5nIDx3YW5nemhpcWlhbmcuYmpAYnl0ZWRhbmNlLmNvbT47DQo+IHh1eGlhb2hhbkBieXRlZGFu
Y2UuY29tOyB5dWxlaS5zaEBieXRlZGFuY2UuY29tOyBSb2JlcnQgTGlwcGVydA0KPiA8cmxpcHBl
cnRAZ29vZ2xlLmNvbT47IG1vZGVyYXRlZCBsaXN0OkFSTS9BU1BFRUQgTUFDSElORSBTVVBQT1JU
DQo+IDxsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbg0K
PiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBWZXJub24gTWF1ZXJ5DQo+IDx2ZXJub24u
bWF1ZXJ5QGxpbnV4LmludGVsLmNvbT47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz47DQo+IEphZSBIeXVuIFlvbyA8amFlLmh5dW4ueW9vQGludGVsLmNvbT47IFBhdHJp
Y2sgVmVudHVyZQ0KPiA8dmVudHVyZUBnb29nbGUuY29tPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL0FT
UEVFRCBNQUNISU5FIFNVUFBPUlQNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIG1pc2M6IEFkZCBjbG9jayBjb250
cm9sIGxvZ2ljIGludG8gQXNwZWVkIExQQw0KPiBTTk9PUCBkcml2ZXINCj4gDQo+IE9uIFdlZCwg
SmFuIDYsIDIwMjEgYXQgMTA6NTcgQU0gUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGVsbG8gSm9obiwgSm9lbCwgSmFlLA0KPiA+ICAgICAg
ICAgRm9yIHRoaXMgc2hvdWxkIGJlIHNldCBMQ0xLIHRvIGJlIENSSVRJQ0FMIGl0IHdpbGwgZml4
IExQQyByZWxhdGVkDQo+IGRyaXZlci4gKEtDUy9CVC9TTk9PUCkNCj4gPiAgICAgICAgIEkgaGF2
ZSBzZW5kIHRoZSBwYXRjaCBiZWZvcmUuDQo+ID4NCj4gPiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbGludXgtYXNwZWVkL3BhdGNoLzIwMjAwOTI4MDcwMTA4DQo+ID4gLjE0
MDQwLTItcnlhbl9jaGVuQGFzcGVlZHRlY2guY29tLw0KPiA+DQo+ID4gSGVsbG8gSm9lbCwNCj4g
PiAgICAgICAgIFdpbGwgeW91IGNvbnNpZGVyIHRoaXMgcGF0Y2g/DQo+ID4gICAgICAgICBCZXNp
ZGUgS0NTL0JUL1NOT09QLCBVQVJUMS9VQVJUMiB3aWxsIGJlIG1vc3QgcmVsYXRlZCBpc3N1ZQ0K
PiBmb3IgaG9zdCBzaWRlLg0KPiANCj4gU29ycnkgaXQgZGlkIG5vdCBtYWtlIGl0IGludG8gdGhl
IG1lcmdlIHdpbmRvdy4gVGhlIHBhdGNoIGlzIHN0aWxsIGluIHBhdGNod29yay4NCj4gSSBjb3Vs
ZCBqdXN0IHBpY2sgaXQgdXAgZGlyZWN0bHkgZm9yIHY1LjEyLCBvciB3YWl0IGZvciBhIGNvbWJp
bmVkIHB1bGwgcmVxdWVzdA0KPiB3aXRoIG90aGVyIHdvcmsuIA0KDQpIZWxsbyBBcm5kLA0KVGhh
bmtzIHlvdXIgdXBkYXRlLg0KDQo+Sm9lbCwgcGxlYXNlIGxldCBtZSBrbm93IHdoYXQgeW91IHBy
ZWZlci4NCj4gDQpIZWxsbyBKb2VsLA0KQ291bGQgeW91IGhlbHAgY2hlY2sgb24gdGhpcyBwYXRj
aD8gDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtYXNwZWVkL3Bh
dGNoLzIwMjAwOTI4MDcwMTA4LjE0MDQwLTItcnlhbl9jaGVuQGFzcGVlZHRlY2guY29tLw0K
