Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678DA2F4605
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbhAMILG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:11:06 -0500
Received: from mail-eopbgr1300133.outbound.protection.outlook.com ([40.107.130.133]:6160
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbhAMILE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:11:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGBgPFj93M7xLwjjmylsF4lNgZ2JxnMxkg+CBUsfF7PSdfzI5Otl/X6VR2PvdwYcM0DtnYYGTugqs2YB9RWw513XuOAx+eBM1s8OAWbWz5CiE3T3/pvDbZo2hb02Ff2iQ6S7vKefdLi2bjHmDKF9uFz9kD6LQ+ya0Yo1ZbfAefqiVBAEFMcQGSYw01QV6sb0YIcKQEJVd7SwI9oTgcOjxA8/MgU7TrbobQ7uVTrbOzWx4U7Ha1CxzpC7THmq7dEZABe6sfZCY+hsYPH7iToyu+WwRfyUBOm6Oso5Xs6CBvn4yWC/GK9cM5cXdd9BVqbQIIz0zDJE+KomdikXaTmM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99ZgweiB9ViK6XVyVH4WxbtBrvv2BVkbv+M6R0/VPq0=;
 b=IUaBDOKb+UK0UtiAQqggYlMuqp09oEChO08l2EkqqOLpYS1K9S6oBDLvuwncB2PJmw644Wcs6OE0D+yDWGOXrzNOHy7NZhnXjhiPKueMzM3rEiiOzIvHJqdoRtow3etl2PEoBHe0Yva2At+IFhPF4T8k63r88Ru7P3eTJh5bAQEo58wUTawAixrX/yOsAQD68yVOLq7WJ+xMtgNU8Rz/EQqsrELeRXanUAiSASKQ5K1e/pPARvVYPORg2dmBoRFcWLCERNyHUxO8QFmIg1UDvAv5xswyUJqtTHupYsKa6sJ0CS0QMkbBwPGzyWmYa3It1b7JXtSFoBxtmQ2fBRsHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.digi-group.com; dmarc=pass action=none
 header.from=cn.digi-group.com; dkim=pass header.d=cn.digi-group.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digiworld.onmicrosoft.com; s=selector2-digiworld-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99ZgweiB9ViK6XVyVH4WxbtBrvv2BVkbv+M6R0/VPq0=;
 b=nPZUd7G8h6ogRtCpqGzr9tXcHZvDFXJy+z/MZrjL7WyJshAoRUL7lG/rK58ewq4YBTk7i/t1RFsqnDRs6KaPaK7S+N4uWnezDCbpSMyHOUyRG9DCRoONrU6TkiTIOr0YTWosXwu1RqySe6k4RuP0huhUkEl9Sy/N+lnKccfo4OA=
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com (2603:1096:203:ad::15)
 by HK0PR06MB2132.apcprd06.prod.outlook.com (2603:1096:203:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 08:09:30 +0000
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501]) by HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 08:09:30 +0000
From:   Jin Chen Xin <cx.jin@cn.digi-group.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: [PATCH] drivers: add new VID/PID for supporting Teraoka
 AD2000
Thread-Topic: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Thread-Index: AQHW6YNqQJblCgPun0eEg1fCBHRaaQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date:   Wed, 13 Jan 2021 08:09:29 +0000
Message-ID: <HK0PR06MB3825AE0A0AB2B4A300BA566A9FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cn.digi-group.com;
x-originating-ip: [116.228.41.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d07b6d4-ec00-49ba-16c4-08d8b79a8d8a
x-ms-traffictypediagnostic: HK0PR06MB2132:
x-microsoft-antispam-prvs: <HK0PR06MB21329FE10A7D1AA55CE218949FA90@HK0PR06MB2132.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eH+RXyvr4BPh9LPnCaO1qmQaK++/IxWHgJZTB+eYNExDxDQnreVJwD46WxX0yJ/tC1/MGQ7qJu9rAa0M6OuVF0N3eKA8RIP8qR+dIcaqF8GQv7vKw2Vxgg4qd6xdTDk/ZH1M7o8nCgitdw3HpkxOkgqlWfSq+70lRvQakmc6hcs8hKuRptjlbiJqmWJRcs2Ugj559dGkLcV0G8PW8nL0vNa9AyShjm7Hmy877gBDaXioyQp/ELti4GtQ76/19EZ9GCwxlXhHNXspgUJLo/maDBY0Wv0nnv+Wkk01Umw7HLo2vXZdgb1MARlldrkAvVGFmh+TOsbYRPN9PgNSgUgFFR+yDLLQkP46nj8Vc1Y/d3Ihsg28ErGuMzHJJoyYJNIW308zP+hZmJgHQB+O33T0pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3825.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(83380400001)(86362001)(6506007)(186003)(76116006)(8936002)(6916009)(55016002)(66946007)(9686003)(71200400001)(2906002)(66556008)(5660300002)(7696005)(316002)(66446008)(8676002)(54906003)(33656002)(4326008)(26005)(66476007)(478600001)(64756008)(52536014)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T0lUSkoxTWo4REo3bVZrK0ovckR3QXpmRTRKaWJaRTlSSmtGS1YyWFdkUm9u?=
 =?utf-8?B?L1YzWHZHYTM2aVY1SFAzVlpEZDRKUE9LaG9CVVBDU254SzhwemJDQ1lvTHBD?=
 =?utf-8?B?THpvcyt0SFJFa3RIdEppVXNlZXFWcXc2bnN4VDVYcE1ROVJsaHNKbmUyT2JW?=
 =?utf-8?B?MzlvQjl0SzhPb2htSnFWNGxIMDVvSVZqV3NQcklyakJaQVRleEp6YThpbENC?=
 =?utf-8?B?eHlNSW0zbEpLWHI2NFNGOWF2L2xxczVJcFFpenZzOUhwcjgvYmhvWmVMZVhS?=
 =?utf-8?B?WXd5NlYxRUpyRHRTMElsMHh5RURGL0VCcjJjb3NwVkd6V2drRGU4R2tRWlk4?=
 =?utf-8?B?bmhsZkxMODdNa1RWMTM4ODhGTjluVzl4OXROUWNUREJldGRobERLdG9yd1c2?=
 =?utf-8?B?T2RzZUdoQUJuUUx1WHl5NGtNK1B2Zk5PenVkdEdkdmJieFJ3R2tqc3VFZGFP?=
 =?utf-8?B?aHFEZUkvL1JzMm5PeVR6NUZkZ3U2VHYyS2hNNDZEM3hCdUl2R3NjN1diV2g1?=
 =?utf-8?B?bWtiYzJ6VHUxRERYSUZoSi85dmRwdm44N25lczVVaEl2cnNxRXg2YUZOMjFv?=
 =?utf-8?B?V0dSU29vTkZYU3VSdE1VZXJxRVA0RS9TbjltTmRlRnRZQ3gvRk1KYmVLS0xm?=
 =?utf-8?B?NnQzVnpOa0wvMjg0UkNOL2xkWGgxQUEwY2I0TzRtZVJiNmZYZjhDcXRpZnA5?=
 =?utf-8?B?aHFFamRXYXJIR3NhMEZNWjBFVXBSRm5SOUJDa1pIMXM3WkxVOXIyaUJnSWRC?=
 =?utf-8?B?L09WZW95UWw0WkEwRmFXVHhQUmhvazFUdllGS2YvN0xhN25rQ21OT2hWbzRN?=
 =?utf-8?B?MXgvczN3VmJlOHRrY0tObHBoWXIwS3A4Q3Z3NXpZT25QWHNtM0JBWWlWTWZk?=
 =?utf-8?B?YzZiQTFoWmVpb0V6VGx5ZEhEMjM3MHlFeU9ZNjBUOXRSMlRGZVRMNHhWWXNG?=
 =?utf-8?B?aW1kY1A5REJsUy80dEF6Ly9YczYxbDFJV3A3OXVkL0o4aUhwemlhS1hQY1k4?=
 =?utf-8?B?ZUR3VGpvK2FkN0pVaVFxam5JNGJCbmkwVFlRNHRVeGtMbldJeFJxdHR5dURR?=
 =?utf-8?B?Z2JhQld4aGdpOC9haklLa2tONTZEb1ZCcTMxTkVzRTRJdjIzbFFpRUN3Ynhq?=
 =?utf-8?B?R055M3pva3V1RWxIQy9aVFRncG1lQmFCRzdFc0d3YWZaUE9hUExmZmRoQ0V2?=
 =?utf-8?B?MGFQUE12ZElBcU1IRUZHbHFwb0Ntd0F5ZkI0d244SHVqWGVQNHVmaXJCdzdF?=
 =?utf-8?B?RGVBQURsYzVNSzFWQkk5M1pkblRqaDI3cEc4K3FLdlZDa3BLcE8xc3RJVzdM?=
 =?utf-8?Q?5B0jTeIIXUdLA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cn.digi-group.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3825.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d07b6d4-ec00-49ba-16c4-08d8b79a8d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 08:09:29.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05a6dd31-dbec-4a4f-a8cd-2eada561cecf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpcLVw6Ls01up6CtF0kVy9d54WG1VPx7ugiXyL8hi9S1XQm+vfAdjNBemTJ8LHOPOt1NxZmhD+8Kq/4G61yzELX/gqX/Yl0AfBuxm4m4QHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmluIENoZW4gWGluIHdvdWxkIGxpa2UgdG8gcmVjYWxsIHRoZSBtZXNzYWdlLCAiW1BBVENIXSBk
cml2ZXJzOiBhZGQgbmV3IFZJRC9QSUQgZm9yIHN1cHBvcnRpbmcgVGVyYW9rYSBBRDIwMDAiLg0K
KiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgbWVzc2FnZSBpcyBpbnRlbmRlZCBm
b3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbHMgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQgYW5k
IG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCBhbmQgY29uZmlkZW50
aWFsLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGJ5IG1pc3Rha2UsIHBsZWFzZSBk
aXNjYXJkIHRoaXMgZW1haWwgaW1tZWRpYXRlbHkuIERvIG5vdCBkaXNjbG9zZSwgZm9yd2FyZCBv
ciBjb3B5Lg0KKiDkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7Yo5YyF5ous5YW25Lu75L2V
6ZmE5Lu277yJ55qE5L+h5oGv77yM5LuF55So5LqO6YKu5Lu25YiX5Ye655qE5o6l5pS26ICF5L2/
55So77yM5bm25LiU5Y+v6IO95YyF5ZCr5pyJ54m56K645ZKM5py65a+G55qE5L+h5oGv44CC5aaC
5p6c5oKo6K+v5pS25Yiw6L+Z5bCB55S15a2Q6YKu5Lu277yM6K+36YCa55+l5Y+R5Lu25Lq677yM
5bm256uL5Y2z5Yig6Zmk5a6D77yM6K+35Yu/6YCP6Zyy44CB6L2s5Y+R5oiW5aSN5Yi244CCDQo=
