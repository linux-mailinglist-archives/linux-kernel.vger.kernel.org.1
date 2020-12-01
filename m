Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545FF2CA182
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgLALgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:36:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4108 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730627AbgLALgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:36:00 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Clg4Z6pChzXhRG;
        Tue,  1 Dec 2020 19:34:54 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 1 Dec 2020 19:35:16 +0800
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Dec 2020 19:35:16 +0800
Received: from dggemi762-chm.china.huawei.com ([10.1.198.148]) by
 dggemi762-chm.china.huawei.com ([10.1.198.148]) with mapi id 15.01.1913.007;
 Tue, 1 Dec 2020 19:35:16 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jolly.shah@xilinx.com" <jolly.shah@xilinx.com>,
        "tejas.patel@xilinx.com" <tejas.patel@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSBmaXJtd2FyZTogeGlsaW54OiBNYXJrIHBt?=
 =?gb2312?B?X2FwaV9mZWF0dXJlc19tYXAgd2l0aCBzdGF0aWMga2V5d29yZA==?=
Thread-Topic: [PATCH -next] firmware: xilinx: Mark pm_api_features_map with
 static keyword
Thread-Index: AQHWx9G1aoWV6qkt5k+wHdW6BqpSo6niHAaA
Date:   Tue, 1 Dec 2020 11:35:16 +0000
Message-ID: <8684fa57bc064ed8a949e555e7e0ec94@huawei.com>
References: <1606821343-121199-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1606821343-121199-1-git-send-email-zou_wei@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.100]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLA0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLCB0aGVyZSBpcyBhIG1pc3Rha2UuDQpJ
IHdpbGwgc2VuZCB2MiBzb29uDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBab3V3ZWkg
KFNhbXVlbCkgDQq3osvNyrG85DogMjAyMMTqMTLUwjHI1SAxOToxNg0KytW8/sjLOiBtaWNoYWwu
c2ltZWtAeGlsaW54LmNvbTsgcmFqYW4udmFqYUB4aWxpbnguY29tOyBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgam9sbHkuc2hhaEB4aWxpbnguY29tOyB0ZWphcy5wYXRlbEB4aWxpbnguY29t
OyBtYW5pc2gubmFyYW5pQHhpbGlueC5jb20NCrOty806IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgWm91d2VpIChTYW11
ZWwpIDx6b3Vfd2VpQGh1YXdlaS5jb20+DQrW98ziOiBbUEFUQ0ggLW5leHRdIGZpcm13YXJlOiB4
aWxpbng6IE1hcmsgcG1fYXBpX2ZlYXR1cmVzX21hcCB3aXRoIHN0YXRpYyBrZXl3b3JkDQoNCkZp
eCB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJuaW5nOg0KDQpkcml2ZXJzL2Zpcm13YXJlL3hpbGlu
eC96eW5xbXAuYzozMjoxOiB3YXJuaW5nOiBzeW1ib2wgJ3BtX2FwaV9mZWF0dXJlc19tYXAnIHdh
cyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQoNClNpZ25lZC1vZmYtYnk6IFpv
dSBXZWkgPHpvdV93ZWlAaHVhd2VpLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZmlybXdhcmUveGlsaW54
L3p5bnFtcC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMg
Yi9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KaW5kZXggZDA4YWM4Mi4uOTQzYzJh
YzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KKysrIGIv
ZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMNCkBAIC0yOSw3ICsyOSw3IEBADQogI2Rl
ZmluZSBQTV9BUElfRkVBVFVSRV9DSEVDS19NQVhfT1JERVIgIDcNCiANCiBzdGF0aWMgYm9vbCBm
ZWF0dXJlX2NoZWNrX2VuYWJsZWQ7DQotREVGSU5FX0hBU0hUQUJMRShwbV9hcGlfZmVhdHVyZXNf
bWFwLCBQTV9BUElfRkVBVFVSRV9DSEVDS19NQVhfT1JERVIpOw0KK3N0YXRpYyBFRklORV9IQVNI
VEFCTEUocG1fYXBpX2ZlYXR1cmVzX21hcCwgUE1fQVBJX0ZFQVRVUkVfQ0hFQ0tfTUFYX09SREVS
KTsNCiANCiAvKioNCiAgKiBzdHJ1Y3QgcG1fYXBpX2ZlYXR1cmVfZGF0YSAtIFBNIEFQSSBGZWF0
dXJlIGRhdGENCi0tIA0KMi42LjINCg0K
