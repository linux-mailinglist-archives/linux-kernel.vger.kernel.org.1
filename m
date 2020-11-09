Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE02AC1E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgKIRMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:12:51 -0500
Received: from mail-eopbgr700083.outbound.protection.outlook.com ([40.107.70.83]:19873
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729432AbgKIRMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:12:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erYdZxzlPTPmpFvzPRiKI2X+3H+9twIgFG1JZ0bq/AQvj3vlROesp3NBFsyitKeC0zf17Dh/kz9MycaKvCuvPf2fAsJWE8Y8glLowwB7b+1dvOfbSjrnNbwGWWKtjPTZGCvS/+1AzE3UpCvkJ4R8RSl9eoLWygthGAwgBhg+PtE0SGSz8j9Gpy27I2yIsi0XmBjoU8k1YHpfl0c7DnQwLzA3nlSuyZTr9B2poBVuffag7vKC+8nR+TeogaEQ51ly1IY59bZ0hMBh3qXuRSJdC8PNkOcibTA1dRPYSoX/wSoE4yijDgrO5jcXeqzjrCxJNIAdgtpBWJbSpErsEpfS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNwZpM8CISsr0wS2m5qFFMda20+1jRyTEQkmJRPfOfI=;
 b=bwa9iyMdIsCAKG3x1WPbtMqXpT1oyn4w9yM0EEWg4JrAqkmYG9fPEuTjEirMPfVxlaJc94wGf5B3rh75OFDSZo49g4UBu0kiArsWxUGNfPc1kkKLGb2v9dgwbYER/BTQnRmOpxjhDYVAWzjNsyMjKY72E/XDKoKctyiyKpnoju41T33ZKuMsPCgxqUVVAUtZ20+K2laHwhgjEehJ00gkn+4coYLE/8XEAc7ZdlEMYlR2uTSbOd8CE3vM9YOpsRdogaZTBB9m3w3IElYpVuWl0k3Q0A3oezXFoYertrrdp4qICNq+hFv+nVwLpvqcYq9dmzgLRjJ0SPLqWBS83flIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNwZpM8CISsr0wS2m5qFFMda20+1jRyTEQkmJRPfOfI=;
 b=d4PsA/QoZzGAu9UJuOPzNQ3lkVWeefy56WIxcEh+ggkOo189gwUOO5uTn2yt85DQqdvDv6XRuhQSSkPlZz27E4TsDhRjxp6fqG8soEfuCMyvpjnfeFdfrOa5OQDQCriXMQTO+JOU+sMQmJJCOjjbh4G2HMMZmoI0YwvcwyUYGk8=
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 (2603:10b6:803:48::19) by SA0PR02MB7354.namprd02.prod.outlook.com
 (2603:10b6:806:eb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:12:47 +0000
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f]) by SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f%6]) with mapi id 15.20.3477.038; Mon, 9 Nov 2020
 17:12:47 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Harshal Chaudhari <harshalchau04@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Derek Kiernan <dkiernan@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: xilinx-sdfec: remove check for ioctl cmd and
 argument.
Thread-Topic: [PATCH] misc: xilinx-sdfec: remove check for ioctl cmd and
 argument.
Thread-Index: AQHWsHHjE+Lsy30TskK+ImsVE/BzvKnAFhxw
Date:   Mon, 9 Nov 2020 17:12:47 +0000
Message-ID: <SN4PR0201MB3472341FB4C4F3C0EA4265A9CBEA0@SN4PR0201MB3472.namprd02.prod.outlook.com>
References: <20201101170949.18616-1-harshalchau04@gmail.com>
In-Reply-To: <20201101170949.18616-1-harshalchau04@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c9267f5-4a0e-410b-48f3-08d884d2ae1d
x-ms-traffictypediagnostic: SA0PR02MB7354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR02MB7354B818699F74D815DE642DCBEA0@SA0PR02MB7354.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yD5zHqbrkxOmyhXWJCjyXS5VpX6LdG1E5z5D8GgbrWJyP255lMtvMrnmzKcXq9dMr27fXosOoI/dm4ejUzjPtcAAvtQdFqwmyHPSGnX20Dw6CxCGrp0UCvBr52dn4CtxE8ouOxEL4N0vDP6hs8Z0QEuNVxuqQxsLL0FVklR66r4MJkYwUBuOwaDivmvZRw4SsUdQoOyhsLQXOLqcxgjTjMXKk1o4IaTTRhQkGfB3CoQIdLoRglXcc9kQz0YGPJTUQtOs53Ht2+dlQZZS2YydNZvQwM7goFlneZbZS2MQ9lnFgiTkbEi68U2J/U2C7kwMAfEj5Wpz+wQccVC4mlcP3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB3472.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(83380400001)(86362001)(54906003)(110136005)(8936002)(186003)(7696005)(26005)(33656002)(6506007)(4326008)(64756008)(66556008)(66476007)(66446008)(9686003)(2906002)(76116006)(66946007)(71200400001)(5660300002)(8676002)(53546011)(52536014)(478600001)(316002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YuDrpPlKlKfalwlkqK5FGLjUZyAVot82+Ot95u/Xgj7wKGkVoQSXQFgVcL1PHM9d8R67dxX+bI4N77edtE0wfhjnkGlfqyf5h3GfKljXPzPfLubVztVEGxd3oJWYRZapo/vpdD2mDUtuHB91cZnuUPLzK/F4IEvaI2NIkmB6RI8L0kj4z33bDXiF+ffIhojC/Im0L9S6O+7GOnhmUk5qglOoeOWiqMkuXyltjv1LbZkpPnM8URCjDnte2n2OKaPcpK9PKh+IJoPrJf3qZPFRVsjtOaEeRC7zX5od0248J8bwyMtmSPnDC5YQmtkdJa6uhk0rH3I+qDEAB7kHcH5bC+HJGxKmuQhTeDBB/GyYeMwjuh5F89kYXzyfdTH2jA6McwzeWYYYKJ15eMi15HK37QxDIWpbU10WwtbcQvOlaKD+Xl+WMERiNetGzwUzCEqWe5YmaCTrwAFzj50ZOSIrkjJ9hJApeC4Vx+DS9ZWfGrOEY0+R3f3TeNdpXd1u3/V+Pdecm1WPCqqDRZqZlXnR8rkPfFVut+TqCxLNyoyspBZLbrxHfYszI6lCbMME+NTAvHQTG4qbl8bWCiJq56nWMHdqOb3ikgNCnxR7AMjVnV6LuhUk7IA+cHI2Ex2FeVGq8Nlh7ht1BYJGW7U4kq4dIg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB3472.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9267f5-4a0e-410b-48f3-08d884d2ae1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 17:12:47.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEqDj+cMbitWTX0FTuKl2EGeMH90fwb64f3ULBBhw2W+sYQ42cm5k50LiqL4mk1GzjKypAAWBJXs5t+mzJrMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7354
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhhcnNoYWwgQ2hhdWRoYXJp
IDxoYXJzaGFsY2hhdTA0QGdtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5IDEgTm92ZW1iZXIgMjAy
MCAxNzoxMA0KPiBUbzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IERyYWdhbiBDdmV0aWMg
PGRyYWdhbmNAeGlsaW54LmNvbT4NCj4gQ2M6IERlcmVrIEtpZXJuYW4gPGRraWVybmFuQHhpbGlu
eC5jb20+OyBhcm5kQGFybmRiLmRlOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47
IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBtaXNjOiB4aWxpbngtc2RmZWM6IHJl
bW92ZSBjaGVjayBmb3IgaW9jdGwgY21kIGFuZCBhcmd1bWVudC4NCj4gDQo+IGlmIChfSU9DX1RZ
UEUoY21kKSAhPSBQUF9JT0NUTCkNCj4gICAgICAgICByZXR1cm4gLUVOT1RUWTsNCj4gDQo+IElu
dmFsaWQgaW9jdGwgY29tbWFuZCBjaGVjayBub3JtYWxseSBwZXJmb3JtcyBieSDigJxkZWZhdWx0
4oCdIGNhc2UuDQo+IA0KPiBpZiAoX0lPQ19ESVIoY21kKSAhPSBfSU9DX05PTkUpIHsNCj4gICAg
ICAgIGFyZ3AgPSAodm9pZCBfX3VzZXIgKilhcmc7DQo+ICAgICAgICBpZiAoIWFyZ3ApDQo+ICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsgfQ0KPiANCj4gQW5kIGZvciBjaGVja2luZyBpb2N0
bCBhcmd1bWVudHMsIGNvcHlfZnJvbV91c2VyKCkvY29weV90b191c2VyKCkNCj4gY2hlY2tzIGFy
ZSBlbm91Z2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIYXJzaGFsIENoYXVkaGFyaSA8aGFyc2hh
bGNoYXUwNEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9taXNjL3hpbGlueF9zZGZlYy5j
IHwgMTYgKysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3hpbGlu
eF9zZGZlYy5jIGIvZHJpdmVycy9taXNjL3hpbGlueF9zZGZlYy5jDQo+IGluZGV4IDkyMjkxMjky
NzU2YS4uZmYxMDRjODk0YjNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MveGlsaW54X3Nk
ZmVjLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL3hpbGlueF9zZGZlYy5jDQo+IEBAIC05NDQsOCAr
OTQ0LDggQEAgc3RhdGljIGxvbmcgeHNkZmVjX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZnB0ciwg
dW5zaWduZWQgaW50IGNtZCwNCj4gIAkJCSAgICAgdW5zaWduZWQgbG9uZyBkYXRhKQ0KPiAgew0K
PiAgCXN0cnVjdCB4c2RmZWNfZGV2ICp4c2RmZWM7DQo+IC0Jdm9pZCBfX3VzZXIgKmFyZyA9IE5V
TEw7DQo+IC0JaW50IHJ2YWwgPSAtRUlOVkFMOw0KPiArCXZvaWQgX191c2VyICphcmcgPSAodm9p
ZCBfX3VzZXIgKilkYXRhOw0KPiArCWludCBydmFsOw0KPiANCj4gIAl4c2RmZWMgPSBjb250YWlu
ZXJfb2YoZnB0ci0+cHJpdmF0ZV9kYXRhLCBzdHJ1Y3QgeHNkZmVjX2RldiwgbWlzY2Rldik7DQo+
IA0KPiBAQCAtOTU2LDE2ICs5NTYsNiBAQCBzdGF0aWMgbG9uZyB4c2RmZWNfZGV2X2lvY3RsKHN0
cnVjdCBmaWxlICpmcHRyLCB1bnNpZ25lZCBpbnQgY21kLA0KPiAgCQlyZXR1cm4gLUVQRVJNOw0K
PiAgCX0NCj4gDQo+IC0JaWYgKF9JT0NfVFlQRShjbWQpICE9IFhTREZFQ19NQUdJQykNCj4gLQkJ
cmV0dXJuIC1FTk9UVFk7DQo+IC0NCj4gLQkvKiBjaGVjayBpZiBpb2N0bCBhcmd1bWVudCBpcyBw
cmVzZW50IGFuZCB2YWxpZCAqLw0KPiAtCWlmIChfSU9DX0RJUihjbWQpICE9IF9JT0NfTk9ORSkg
ew0KPiAtCQlhcmcgPSAodm9pZCBfX3VzZXIgKilkYXRhOw0KPiAtCQlpZiAoIWFyZykNCj4gLQkJ
CXJldHVybiBydmFsOw0KPiAtCX0NCj4gLQ0KPiAgCXN3aXRjaCAoY21kKSB7DQo+ICAJY2FzZSBY
U0RGRUNfU1RBUlRfREVWOg0KPiAgCQlydmFsID0geHNkZmVjX3N0YXJ0KHhzZGZlYyk7DQo+IEBA
IC0xMDEwLDcgKzEwMDAsNyBAQCBzdGF0aWMgbG9uZyB4c2RmZWNfZGV2X2lvY3RsKHN0cnVjdCBm
aWxlICpmcHRyLCB1bnNpZ25lZCBpbnQgY21kLA0KPiAgCQlydmFsID0geHNkZmVjX2lzX2FjdGl2
ZSh4c2RmZWMsIChib29sIF9fdXNlciAqKWFyZyk7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6
DQo+IC0JCS8qIFNob3VsZCBub3QgZ2V0IGhlcmUgKi8NCj4gKwkJcnZhbCA9IC1FTk9UVFk7DQo+
ICAJCWJyZWFrOw0KPiAgCX0NCj4gIAlyZXR1cm4gcnZhbDsNCj4gLS0NCj4gMi4xNy4xDQoNCkFj
a2VkLWJ5OiBEcmFnYW4gQ3ZldGljIDxkcmFnYW4uY3ZldGljQHhpbGlueC5jb20+DQoNCg==
