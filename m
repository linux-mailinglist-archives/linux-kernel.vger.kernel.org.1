Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6422EA489
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 05:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAEEvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 23:51:36 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:12897
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbhAEEvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 23:51:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibkdcVcx8rGtdWWRkV5ykRUmue5uk5wMdOVSYKckZXDsRpHD0awpkq+QWX/hBOQbWTg0NO8NMD1pxZE1NhGtxf2f9tRPcPw9JSp9d72FLanQnMZ7v2kn+XQT9x5nEMRLdQIO8tMs11NkVQrEFt3kwrbJEh6VPrW5DLH6nW0Zywq7F+oWYCK01yXzo6hKw2xUoEvv/QwpmbIi9/wr6ojbSS5Bj5ZZE7PkFpVuXJ1McSJ7yFYh5yWSq3ziCPDEqL4Zg8CgKd/kPiLULChBkugWJeX6HYeavMp+ECRi8D7SFmXZdLey/1MIXBY2FbVRVnYTUWmqBcrZMVOBvRfiAGbjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzi0bMvur0/+hs4McuB5HZYOutwneLn9AAmGT75CMgU=;
 b=K0ZbLKliL3bH2YAi3ruZmr/hGgNSrhUE8M5gsIicKXn5iKA1s8xnXJbGwgQ6ibwcZgxZtab8B9LnvTuc2R3SehKXmMc7PI8GFWrefIMBFpo53mDEdCqa0cUHkxPbsCWjuk+JPGWcjs1BrP09WVzABh7L8Paqi/YYFYVpL6IyWbnKWRA1ZMPxu/5fuUWCF8lYTwgbLB/Q2e9Y/MBEwmGRF9YVsWhHBzUNYwDiU6dXJ9lSYxgRryW5URF05oBfWjekue/MGCLTkGIBtx0YXCFa+Myu+MCsWww8Kvl1IKuI36aM8VbsEkBW16qRAjic+7xxzF6vUBcZonZjKnWgW1cFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzi0bMvur0/+hs4McuB5HZYOutwneLn9AAmGT75CMgU=;
 b=ReP3izxQdJu2LkyJhWdAvxko7oM/u+dhbtzETnZc2+mUO+sUdWbwio/Ce0wm+cCp8CAHI1mTkCpJzw2e0OIQ/EkZXnMk/S2Uqig2JgDTnM6OivmQgsNAyXjmHYfNzOgysVM3wdFYrryqzV+UckVJfz+XAe4E+ey+fXLBX1fcZpk=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3719.namprd11.prod.outlook.com (2603:10b6:a03:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 04:50:45 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3700.031; Tue, 5 Jan 2021
 04:50:45 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "ingrassia@epigenesys.com" <ingrassia@epigenesys.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: =?gb2312?B?u9i4tDogS0FTQU46IHVzZS1hZnRlci1mcmVlIFJlYWQgaW4gc2VydmljZV9v?=
 =?gb2312?Q?utstanding=5Finterrupt?=
Thread-Topic: KASAN: use-after-free Read in service_outstanding_interrupt
Thread-Index: AQHW1O05bsNShK3ed0y2i+cMjepvWqoXw2CAgADMJXo=
Date:   Tue, 5 Jan 2021 04:50:45 +0000
Message-ID: <BYAPR11MB2632EDC88523D674D9C63E73FFD10@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <000000000000994d2a05b6b49959@google.com>,<6a56df508f597d38746878e80e1f159a556d3152.camel@suse.com>
In-Reply-To: <6a56df508f597d38746878e80e1f159a556d3152.camel@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [106.39.151.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09175cfa-bc7e-40c7-8470-08d8b135767b
x-ms-traffictypediagnostic: BYAPR11MB3719:
x-microsoft-antispam-prvs: <BYAPR11MB3719F26A23A9A63A07A11708FFD10@BYAPR11MB3719.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIarIZuQHsWMm9eUDle7uX5f/edtCXCz3ZUo0ZH3TuNfkq8EcH1xfUxRMWchdgYxSzTKlPvrQZCI398NcFXRFVDPnok5x5SBTX+/Tp0vpG74VNJd6zqeq4NqC8Z+r+FaSGMELX4B4oBzykxkcnD34raiw5j1Wzvk6lhJ+tpz7J5sBHB6A7CjGv+xwMTKsojnnTFfbm8xYogodRZUl1C7tLhHi9P5dDrzzYsb6eVk13j5OzMUDMtRT3Xe6XUKwqpATLp8Y63h7ogcaaNs70jYb3RY7fmpfcUzjDl4hv38k8vUQswTCUFRqy7fCPeyM3ECcKc54HW6uUBUNFjBYzWEwo0vvpn7eoLj293VsdcSEReGJFgXa6BeIPQJtXsczC7F1VqvIofpcSE1whvckamwjU9S0GCdKIBf9M5ja9gjttRJ8Cd4rYH3t+uR+sp16gVYIckMCBmFov8b2A7ARQiVODUkA58QkOHK1is+B0wXvZl5EiKjZxejPi8Elvv7KJsyKKINo12TzAPffvE6Dpjek7YsNlOojmi/LxYsTAs/sRqnFVtv9D9XCjG1qI1RBI9H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39850400004)(346002)(376002)(66556008)(83380400001)(64756008)(8936002)(966005)(76116006)(5660300002)(478600001)(71200400001)(66446008)(66946007)(7416002)(86362001)(91956017)(66476007)(316002)(33656002)(186003)(6506007)(26005)(110136005)(2906002)(224303003)(55016002)(9686003)(52536014)(7696005)(921005)(87944003)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?bExqRmo1NGc3eGxPT0paeCt6VkdqQmt0NENIOTdzNXRyWGF0OFRMbDk4dE0z?=
 =?gb2312?B?SmhDNVNhaWxOVkVEcnBlS0FUd1M2d3VScGVDYmJENjZOcFJMMmwwK3dSUDZO?=
 =?gb2312?B?KytBMm5uV2VwcVB1ejdSWDV5eU04dG5TTCtOR2E1SmZNdkxLVHZLTXYvdDNV?=
 =?gb2312?B?NDhSZjdpcUhCZ2ZxUGtwZnV1dVRjU01pemtDdmxoQWFXclJ2T3BEb3pkVXN3?=
 =?gb2312?B?VkwzWEx5ZnFxTDUzWTVMa0RrVU9vNXhsQmkrUm5QdTlGTzdQSmRYSFRxb0tv?=
 =?gb2312?B?UGMxWFZvTSsvOFFnWU53NEpYYzVoQktyOGZhd1VNREhXT1M2SkdQclF2SUdW?=
 =?gb2312?B?aXFGUmJmanFGOElXaG5Ya2RGTEpPTFFJa3o4K09KU3Zud3pvT0dpWVJ6WWl3?=
 =?gb2312?B?c2hvNW40cWpoSTd4aDY4ellSd1c3NjZuOVpsZWRlNWtpdlRwdnlIZTlLVERy?=
 =?gb2312?B?d0dVbDEvOHRYRUNwekV1amZzVkx1ZktkeFIwYmRZQlRTaVRUTGRSQXErWWty?=
 =?gb2312?B?aTZremdsRjFoWVQ3ZVIyK2dUR3BNNktuVE5PeTI1WVZDTDN2OU5sNXF1clJI?=
 =?gb2312?B?N0tpQTZKR1ZkOUVCSFRKSXZVQmk2R210dFRyVUtEMi9TNXE4dnBPRVkwOXVN?=
 =?gb2312?B?c0lCZ1l6M3RMUjIveGJ3Rld1bFhLRlk4UmQxTWJCd2VWNVZBY29CVUlsTld6?=
 =?gb2312?B?NzhsNDBoSHJXTHBPUnB3ZTZwbzZhQlRBZGVZU2RYNFBua2hUT2hnTE91cjhB?=
 =?gb2312?B?cnBobGZUOStISzFXRy9HYVpqU0tVTnM4UWlhbi80NFJIQjV1bFArZGo5T0FV?=
 =?gb2312?B?OU8wOXVORlh2QklIU3JFbjVHMjlWN2dGb2hRQzNscEVvNzlQaUZQdjNvWWg1?=
 =?gb2312?B?T24vVDlEOExOVnBnd2ZNVkJ2VGREU3BDNUV3QzNHWFdQRjFHVllVUWJna1FK?=
 =?gb2312?B?MFFQdEIwbXR2VDJvekJ3Z2F5NXppNFBrRFRpTlJXNmZjOGc4VEcwR2ROWDlL?=
 =?gb2312?B?Y0UxdDkwSEJtY3RtK1ZGWW1YWGRCOUZIY0dYM0tqb0tyQ0d6OGgvWEpBa2w2?=
 =?gb2312?B?VlliMC9YdzRCYlI3ay9uN285cWVoMGIzRDArQjN1M1RBb1BKSE5sVXpiZzlM?=
 =?gb2312?B?OStKdkVXN2hMdnFveGcvcW13ekg1MitldzBrT3YrQlhkanZjK0xXMElwcU93?=
 =?gb2312?B?VDg5RkFRcDg4RzM4dzdSaGxSbE9aZ0MvK0kwZnFod0VXZ2pVNjN1eWJ6Qit0?=
 =?gb2312?B?djFIb09ldzNxc01STWNZRG1FdHNpMnZDa0JxV1AvOWsreWtJYTgyeStoRDhJ?=
 =?gb2312?Q?taoHyc+9qHhO4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09175cfa-bc7e-40c7-8470-08d8b135767b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 04:50:45.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjHYOU7o8UJVAbBy4NTcUu+kRtTHATcqfqKIOtwAkylBD45LPjyLHZ1bxYr7LzvFRLV3HDC7fNqZeispm+pPDa8xIlxgbU0PNJuydkE+ApM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3719
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogT2xpdmVy
IE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jHUwjXI1SAwOjI4CsrV
vP7Iyzogc3l6Ym90OyBhbmRyZXlrbnZsQGdvb2dsZS5jb207IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOyBndXN0YXZvYXJzQGtlcm5lbC5vcmc7IGluZ3Jhc3NpYUBlcGlnZW5lc3lzLmNvbTsg
bGVlLmpvbmVzQGxpbmFyby5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IHBlbmd1aW4ta2VybmVsQEktbG92ZS5TQUtVUkEubmUuanA7
IHN5emthbGxlci1idWdzQGdvb2dsZWdyb3Vwcy5jb20K1vfM4jogUmU6IEtBU0FOOiB1c2UtYWZ0
ZXItZnJlZSBSZWFkIGluIHNlcnZpY2Vfb3V0c3RhbmRpbmdfaW50ZXJydXB0CgpBbSBEb25uZXJz
dGFnLCBkZW4gMTcuMTIuMjAyMCwgMTk6MjEgLTA4MDAgc2NocmllYiBzeXpib3Q6Cj4gc3l6Ym90
IGhhcyBmb3VuZCBhIHJlcHJvZHVjZXIgZm9yIHRoZSBmb2xsb3dpbmcgaXNzdWUgb246Cj4KPiBI
RUFEIGNvbW1pdDogICAgNWU2MDM2NmQgTWVyZ2UgdGFnICdmYWxsdGhyb3VnaC1maXhlcy1jbGFu
Zy01LjExLXJjMScgb2YgZy4uCj4gZ2l0IHRyZWU6ICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdraC91c2IuZ2l0IHVzYi10ZXN0aW5nCj4g
Y29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94
PTEyYzViNjIzNTAwMDAwCj4ga2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNw
b3QuY29tL3gvLmNvbmZpZz94PTVjZWE3NTA2YjcxMzk3MjcKPiBkYXNoYm9hcmQgbGluazogaHR0
cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTllMDRlMmRmNGEzMmZiNjYxZGFm
Cj4gY29tcGlsZXI6ICAgICAgIGdjYyAoR0NDKSAxMC4xLjAtc3l6IDIwMjAwNTA3Cj4gc3l6IHJl
cHJvOiAgICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTc1
YWRmMDc1MDAwMDAKPiBDIHJlcHJvZHVjZXI6ICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20veC9yZXByby5jP3g9MTY3MjY4MGY1MDAwMDAKPgo+IElNUE9SVEFOVDogaWYgeW91IGZpeCB0
aGUgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoKPiBS
ZXBvcnRlZC1ieTogPnN5emJvdCs5ZTA0ZTJkZjRhMzJmYjY2MWRhZkBzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tCj4KPiNzeXogdGVzdDogaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS9rYXNhbi5n
aXQgIDVlNjAzNjZkCj4KCiBIZWxsbyBPbGl2ZXIgCiAKIHRoaXMgdXNlLWFmdGVyLWZyZWUgc3Rp
bGwgZXhpc3Rzo6xJdCBjYW4gYmUgc2VlbiBmcm9tIGNhbGx0cmFjZSB0aGF0IGl0IGlzIAogdXNi
X2RldmljZSdzIG9iamVjdCAgaGFzIGJlZW4gcmVsZWFzZWQgd2hlbiBkaXNjb25uZWN0LAogY2Fu
IGFkZCBhIHJlZmVyZW5jZSBjb3VudCB0byB1c2JfZGV2aWNlJ3Mgb2JqZWN0IHRvIGF2b2lkIHRo
aXMgcHJvYmxlbSAKIAogZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NsYXNzL2NkYy13ZG0uYyBi
L2RyaXZlcnMvdXNiL2NsYXNzL2NkYy13ZG0uYwppbmRleCA1MDhiMWMzZjhiNzMuLjAwMWNiOTNk
YTZiZiAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvY2xhc3MvY2RjLXdkbS5jCisrKyBiL2RyaXZl
cnMvdXNiL2NsYXNzL2NkYy13ZG0uYwpAQCAtMTA2LDYgKzEwNiw3IEBAIHN0cnVjdCB3ZG1fZGV2
aWNlIHsKIAogICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgICAgICAgIGRldmljZV9saXN0OwogICAg
ICAgIGludCAgICAgICAgICAgICAgICAgICAgICgqbWFuYWdlX3Bvd2VyKShzdHJ1Y3QgdXNiX2lu
dGVyZmFjZSAqLCBpbnQpOworICAgICAgIHN0cnVjdCB1c2JfZGV2aWNlICAgICAgICp1c2JfZGV2
OwogfTsKIAogc3RhdGljIHN0cnVjdCB1c2JfZHJpdmVyIHdkbV9kcml2ZXI7CkBAIC0zMzgsNiAr
MzM5LDcgQEAgc3RhdGljIHZvaWQgZnJlZV91cmJzKHN0cnVjdCB3ZG1fZGV2aWNlICpkZXNjKQog
CiBzdGF0aWMgdm9pZCBjbGVhbnVwKHN0cnVjdCB3ZG1fZGV2aWNlICpkZXNjKQogeworICAgICAg
IHVzYl9wdXRfZGV2KGRlc2MtPnVzYl9kZXYpOwogICAgICAgIGtmcmVlKGRlc2MtPnNidWYpOwog
ICAgICAgIGtmcmVlKGRlc2MtPmluYnVmKTsKICAgICAgICBrZnJlZShkZXNjLT5vcnEpOwpAQCAt
ODU1LDYgKzg1Nyw3IEBAIHN0YXRpYyBpbnQgd2RtX2NyZWF0ZShzdHJ1Y3QgdXNiX2ludGVyZmFj
ZSAqaW50Ziwgc3RydWN0IHVzYl9lbmRwb2ludF9kZXNjcmlwdG8KcgogICAgICAgIGRlc2MtPmlu
dGYgPSBpbnRmOwogICAgICAgIElOSVRfV09SSygmZGVzYy0+cnh3b3JrLCB3ZG1fcnh3b3JrKTsK
ICAgICAgICBJTklUX1dPUksoJmRlc2MtPnNlcnZpY2Vfb3V0c19pbnRyLCBzZXJ2aWNlX2ludGVy
cnVwdF93b3JrKTsKKyAgICAgICBkZXNjLT51c2JfZGV2ID0gdXNiX2dldF9kZXYoaW50ZXJmYWNl
X3RvX3VzYmRldihpbnRmKSk7CiAKICAgICAgICBydiA9IC1FSU5WQUw7CiAgICAgICAgaWYgKCF1
c2JfZW5kcG9pbnRfaXNfaW50X2luKGVwKSkKCgoKCj5Gcm9tIGY1MWUzYzVhMjAyZjNhYmM4MDVl
ZGQ2NGIyMWE2OGQyOWRkOWQ2MGUgTW9uIFNlcCAxNyA+MDA6MDA6MDAgMjAwMQo+RnJvbTogT2xp
dmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4KPkRhdGU6IE1vbiwgNCBKYW4gMjAyMSAxNzoy
NjozMyArMDEwMAo+U3ViamVjdDogW1BBVENIXSBjZGMtd2RtOiBwb2lzb24gVVJCcyB1cG9uIGRp
c2Nvbm5lY3QKPgo+V2UgaGF2ZSBhIGNoaWNrZW4gYW5kIGVnZyBpc3N1ZSBiZXR3ZWVuIGludGVy
cnVwdCBhbmQgd29yay4KPlRoaXMgc2hvdWxkIGJyZWFrIHRoZSBjeWNsZS4KPgo+U2lnbmVkLW9m
Zi1ieTogT2xpdmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4KPi0tLQo+ZHJpdmVycy91c2Iv
Y2xhc3MvY2RjLXdkbS5jIHwgNiArKystLS0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2xhc3MvY2Rj
LXdkbS5jIGIvZHJpdmVycy91c2IvY2xhc3MvY2RjLT53ZG0uYwo+aW5kZXggMDJkMGNmZDIzYmIy
Li4xNGVkZGRhMzUyODAgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL3VzYi9jbGFzcy9jZGMtd2RtLmMK
PisrKyBiL2RyaXZlcnMvdXNiL2NsYXNzL2NkYy13ZG0uYwo+QEAgLTMyNCw5ICszMjQsOSBAQCBz
dGF0aWMgdm9pZCB3ZG1faW50X2NhbGxiYWNrKHN0cnVjdCB1cmIgKnVyYikKPnN0YXRpYyB2b2lk
IGtpbGxfdXJicyhzdHJ1Y3Qgd2RtX2RldmljZSAqZGVzYykKPiB7Cj4gICAgICAgLyogdGhlIG9y
ZGVyIGhlcmUgaXMgZXNzZW50aWFsICovCj4tICAgICAgIHVzYl9raWxsX3VyYihkZXNjLT5jb21t
YW5kKTsKPi0gICAgICAgdXNiX2tpbGxfdXJiKGRlc2MtPnZhbGlkaXR5KTsKPi0gICAgICAgdXNi
X2tpbGxfdXJiKGRlc2MtPnJlc3BvbnNlKTsKPisgICAgICAgdXNiX3BvaXNvbl91cmIoZGVzYy0+
Y29tbWFuZCk7Cj4rICAgICAgIHVzYl9wb2lzb25fdXJiKGRlc2MtPnZhbGlkaXR5KTsKPisgICAg
ICAgdXNiX3BvaXNvbl91cmIoZGVzYy0+cmVzcG9uc2UpOwo+IH0KPgo+IHN0YXRpYyB2b2lkIGZy
ZWVfdXJicyhzdHJ1Y3Qgd2RtX2RldmljZSAqZGVzYykKPi0tCj4yLjI2LjIKCgo=
