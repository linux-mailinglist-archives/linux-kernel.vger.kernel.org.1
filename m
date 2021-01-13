Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441242F45AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbhAMIEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:04:09 -0500
Received: from mail-eopbgr1300123.outbound.protection.outlook.com ([40.107.130.123]:12224
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbhAMIEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:04:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faKykLyugSrVYyfvkFoMEBKJqBqwdukgogylswKo3seOkCTKg51aUy6TbLwQU28uM6sWr1VSB+o+h9YONVcGjh/iAJEogrSqZyO51saLP7h3YjsR+l8WOwqRS1nBVj7LpnX36f6J6JHWbvST0trlPxHoO7E77pbiJDX5+tkRP4paWBaHe8UrxYO3ellliIhnaiGINydtZ3ju2tws4PtDf8jW3yUzMUT95c0AMF+qX9SCHpiPg3F3VYpImtZd3gXF/Mlg2ZgRhgdE/A2QGOVgd/xrP0hYu9+j9AYM3wD7epzvvm2IAhG/5ZDoQ3ugsuvmet+nH2PXIIAp2AEF5CfsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2WMQWNlF/k2B/J04wupGBnqC/el4rpzB8bakyVji7c=;
 b=CER58A9xdFFM31IcwRe9b3MROCSQUsZHKYclmPcZ/3jAck2ZPtZYc3Yrq18pQdaH0zjdsZZHeyD+b4CpFb8c9u51faVmC8VwMS2p+w4QjtUnPIMIhV9y1BNRcXJyXTzXWtp27CjAvogBlheEFzivywnaspVsTHrguS8omCaj1NhTe7x3eARJIFn5H0ymBl1OtUspFv9yoq4i3lm/59Q/MdhnB2dZgn2C9Xkj6MCVsDMe6oBZFbvInmh00MiMiHEvGMLMwVzL4FjbM52Eml1o6OjhURXSYjMPu42TzpNdKuIxZzd7pDNUw383H1V/IT5UXzF/FO9A/JWK2bE3qJ/PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.digi-group.com; dmarc=pass action=none
 header.from=cn.digi-group.com; dkim=pass header.d=cn.digi-group.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digiworld.onmicrosoft.com; s=selector2-digiworld-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2WMQWNlF/k2B/J04wupGBnqC/el4rpzB8bakyVji7c=;
 b=eNMBvUlZ9KXvPNdQtB7FsVsQB2JxOuTqBtHzh6c8NH8aVm0Tj+FbgDNvzKckwQj7R5gS++3IkpOVF1RGk03F9qlOZBrlm0WL/Z/i/94GNUbxReNUio+oqsz0JGYkk8AsLb7sZS/Ee3lVC8lHe+0thcmIUqL+vQT/4HdHc0XWPzg=
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com (2603:1096:203:ad::15)
 by HK2PR0601MB1889.apcprd06.prod.outlook.com (2603:1096:202:5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 08:02:33 +0000
Received: from HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501]) by HK0PR06MB3825.apcprd06.prod.outlook.com
 ([fe80::f5c6:1f35:5fd5:9501%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 08:02:33 +0000
From:   Jin Chen Xin <cx.jin@cn.digi-group.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Thread-Topic: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Thread-Index: AdbpggAh9jV/9Z95QKa5T5h81ghvlQ==
Date:   Wed, 13 Jan 2021 08:02:33 +0000
Message-ID: <HK0PR06MB38255C7062AD2A1F578AE7459FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cn.digi-group.com;
x-originating-ip: [116.228.41.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ae2979d-8711-4c9b-afe3-08d8b7999524
x-ms-traffictypediagnostic: HK2PR0601MB1889:
x-microsoft-antispam-prvs: <HK2PR0601MB18892290884FBFD87EBBF70F9FA90@HK2PR0601MB1889.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUqgU2me3zbAL711aDxlzevXc89iewbbodJopVvIZ8V7Q/MVIu5unO+mOKpJiMK+DY5gpGDoJOHg/8p9yogtiFI8mAKmaD1IRp/0w4CX5q9ugxYKfNYxVUUW9VGPPFRz9CiQcW+GjyEtKKYOCx4OkQoKg8s2w7Ds9YwVIBLCsbN22dDU36B9TUS49d7VpLPBWCNkkl7KPB7C73M7s0UC77UKXKvpQqaamw+2YfVvDGr9qVISPZYvIkyfHwSLt3F+kDU/kgOg23bH0W7anQl3AOsmlEWNFmXI3LjmOj14uxZvGak4UJlBKtbkfsCY7k/4VAUWpJ75Q3yYkva54AVePyX8cFVxagbK1YTHRhUBgcybuEmyRDul7LZt24gdCVxe0pQk1HK1XEzgf/2Ab+MP6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3825.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(52536014)(4326008)(7696005)(66556008)(8676002)(33656002)(186003)(8936002)(83380400001)(64756008)(66476007)(5660300002)(478600001)(86362001)(26005)(54906003)(66446008)(9686003)(71200400001)(53546011)(2906002)(55016002)(76116006)(66946007)(316002)(6506007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZFF0TUkycjBtWHROY3dYM3YwUG9GS3Z6SVJTMUp0bjhrVzY1QytFS0t3ODBW?=
 =?utf-8?B?QlM5U01aSWRadUxUbW10QjBsazFnY242czhJdm9NR295QklET3BqRVJzQzBW?=
 =?utf-8?B?NmdUR3JacmwzUStvWitBdlRLMkFDb25VRC9wcTBObFpLL0xkR0hFeUFpZzZi?=
 =?utf-8?B?OWtFZGFiL3c3RGdGd21WeUl0NmViNnp0VEF4VDhqck92RXRNZVd6VXFGNVhr?=
 =?utf-8?B?aUVaQ21LOXFiR0pBTHpQQWdRcUlacTF2REMvS0IvZXd2b25pQWhzUjZEMTVz?=
 =?utf-8?B?a2dYaE5Hb2orREFpdEFrZ3NEMVA4QlNvdG4rZGdtSkFEZkMvVVRUWEs5eWNv?=
 =?utf-8?B?MWQ5N2Y5OWFZNThNYzdRQmIrcjVubVVUWHVIM0EwMnZlZE50WmE2UnZZajdX?=
 =?utf-8?B?Tm0vQldCTCtMVm9hUVY4MllTTTZtUzVCbDVDQUtDMDF3c3gySHFJSnhGZXVN?=
 =?utf-8?B?OGE0d05ockZTL0pCZUJaaFdHZ2Z4Z0QyUDBwbnJnQ3RzWTQvQU5nNFVzN3E4?=
 =?utf-8?B?TUdvbE9BMlpoUDBRU29qb2ZjelNOR0tZK2tGallienRaajlRemN3K2s4NkNi?=
 =?utf-8?B?WEtBaURpWTY0UkV4VmEwRVQ3TnRzU2ttZEM5S3kwRXB2bXZhdEFvMlBmRC9l?=
 =?utf-8?B?SC82U05XaG5wSkhpaU5OTDhLNVdQNnBDVWhUQlV2R0hTTjJlbUVJZXBzN0o3?=
 =?utf-8?B?NHVrV2pYR1NLQklER0pQRTlwVm1rQTZvbVRtOWhWVXIyelJTWUZyWUFtTk01?=
 =?utf-8?B?L3BZdlc4UkhuVmV3c0FZb0J5YUxWZGtPZzFIVzkxOWRZVWxEV0lueWswWlBY?=
 =?utf-8?B?Q2JFaEE3UkE0OXI5aUxqVFlodlIxdDZwbFZJbC9KYnhQUWFDM1BIMXMyb3Vq?=
 =?utf-8?B?eGZOUVN6MitTbEtnaTI4eGVvbVFMY2hSTldReFRXRHZMRU8rUTZPVzZNYW5n?=
 =?utf-8?B?MHVQNmdSZGs5aktsaWhUdDc4MzFhQ2ZUMEw3Ri9TNDJVelJNZjVqRENKNThh?=
 =?utf-8?B?UlRmL0p0VEdSSnYxVzJEQk9CSVROY0FjZTVlaGlicUFDU01GMVliL1hDbWhs?=
 =?utf-8?B?UW5mN3p5UEU4V3NnL3kyRGpaaUVqVVBhdDYwR0QxYUxkUTltczlEZk9yOFA1?=
 =?utf-8?B?cVk4NXRtNGJYWFNaRyt4STRSZWQyc3RNZUV0ZHMxVzRidFV6ckNMNE45RXM1?=
 =?utf-8?B?L3VpeFB0N0d5RHdSWWJydEljTFYraUU2Z1JNZ0VtTVU4dWtnZzV3RUwyejdN?=
 =?utf-8?B?TU51b05JZC9XSVRITi80aU5WT1V5KzdCdktiRmZkWmp3Z1VuKzZkaHNZZkhZ?=
 =?utf-8?Q?+VQgkr+1cU8dU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cn.digi-group.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3825.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae2979d-8711-4c9b-afe3-08d8b7999524
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 08:02:33.2074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05a6dd31-dbec-4a4f-a8cd-2eada561cecf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZodRtaQIrr9Pr+uVrT5kFzSDXQGsFXbozbfm4TPlANxBwtpku8bhuEwj+Jskpw+EJHlxvprl9umeovqIawtErcsDp057KDDVY+mPlaVajVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1889
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpGcm9tIDFkZjExOWNmYTEwNTM4M2EwZTA0N2E2ODYwMmIzYTlkYzRmODFjM2MgTW9uIFNlcCAx
NyAwMDowMDowMCAyMDAxDQpGcm9tOiBKaW4gQ2hlbi1YaW4gPGN4LmppbkBjbi5kaWdpLWdyb3Vw
LmNvbT4NCkRhdGU6IFdlZCwgMTMgSmFuIDIwMjEgMTQ6MDk6MDcgKzA4MDANClN1YmplY3Q6IFtQ
QVRDSF0gZHJpdmVyczogYWRkIG5ldyBWSUQvUElEIGZvciBzdXBwb3J0aW5nIFRlcmFva2EgQUQy
MDAwDQoNClRlcmFva2EgQUQyMDAwIHVzZXMgdGhlIENQMjEweCBkcml2ZXIsIGJ1dCB0aGUgY2hp
cCBWSUQvUElEIGlzDQpjdXN0b21pemVkIHdpdGggMDk4OC8wNTc4LiBXZSBuZWVkIHRoZSBkcml2
ZXIgdG8gc3VwcG9ydCB0aGUgbmV3IFZJRC9QSUQuDQoNClNpZ25lZC1vZmYtYnk6IEppbiBDaGVu
LVhpbiA8Y3guamluQGNuLmRpZ2ktZ3JvdXAuY29tPg0KLS0tDQogZHJpdmVycy91c2Ivc2VyaWFs
L2NwMjEweC5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9zZXJpYWwvY3AyMTB4LmMgYi9kcml2ZXJzL3VzYi9zZXJpYWwv
Y3AyMTB4LmMNCmluZGV4IGZiYjEwZGYuLmMyNzRjYzMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Vz
Yi9zZXJpYWwvY3AyMTB4LmMNCisrKyBiL2RyaXZlcnMvdXNiL3NlcmlhbC9jcDIxMHguYw0KQEAg
LTIzNCw2ICsyMzQsNyBAQCBzdGF0aWMgaW50IGNwMjEweF90aW9jbXNldF9wb3J0KHN0cnVjdCB1
c2Jfc2VyaWFsX3BvcnQgKnBvcnQsDQogeyBVU0JfREVWSUNFKDB4MzE5NSwgMHhGMjgxKSB9LCAv
KiBMaW5rIEluc3RydW1lbnRzIE1TTy0yOCAqLw0KIHsgVVNCX0RFVklDRSgweDM5MjMsIDB4N0Ew
QikgfSwgLyogTmF0aW9uYWwgSW5zdHJ1bWVudHMgVVNCIFNlcmlhbCBDb25zb2xlICovDQogeyBV
U0JfREVWSUNFKDB4NDEzQywgMHg5NTAwKSB9LCAvKiBEVzcwMCBHUFMgVVNCIGludGVyZmFjZSAq
Lw0KK3sgVVNCX0RFVklDRSgweDA5ODgsIDB4MDU3OCkgfSwgLyogVGVyYW9rYSBBRDIwMDAgKi8N
CiB7IH0gLyogVGVybWluYXRpbmcgRW50cnkgKi8NCiB9Ow0KDQotLQ0KMS44LjMuMQ0KDQoNCg0K
DQpCZXN0IFJlZ2FyZHMsDQoNCkppbiBDaGVuLVhpbg0KU29mdHdhcmUgRGV2ZWxvcG1lbnQgRGVw
dC4NClNoYW5naGFpIFRlcmFva2EgRWxlY3Ryb25pYyBDby4sIEx0ZC4NCg0KKiBUaGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGluIHRoaXMgbWVzc2FnZSBpcyBpbnRlbmRlZCBmb3IgdGhlIHVzZSBv
ZiB0aGUgaW5kaXZpZHVhbHMgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWlu
IGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCBhbmQgY29uZmlkZW50aWFsLiBJZiB5b3Ug
aGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGJ5IG1pc3Rha2UsIHBsZWFzZSBkaXNjYXJkIHRoaXMg
ZW1haWwgaW1tZWRpYXRlbHkuIERvIG5vdCBkaXNjbG9zZSwgZm9yd2FyZCBvciBjb3B5Lg0KKiDk
v6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7Yo5YyF5ous5YW25Lu75L2V6ZmE5Lu277yJ55qE
5L+h5oGv77yM5LuF55So5LqO6YKu5Lu25YiX5Ye655qE5o6l5pS26ICF5L2/55So77yM5bm25LiU
5Y+v6IO95YyF5ZCr5pyJ54m56K645ZKM5py65a+G55qE5L+h5oGv44CC5aaC5p6c5oKo6K+v5pS2
5Yiw6L+Z5bCB55S15a2Q6YKu5Lu277yM6K+36YCa55+l5Y+R5Lu25Lq677yM5bm256uL5Y2z5Yig
6Zmk5a6D77yM6K+35Yu/6YCP6Zyy44CB6L2s5Y+R5oiW5aSN5Yi244CCDQo=
