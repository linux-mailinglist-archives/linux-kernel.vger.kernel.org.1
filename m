Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B22DDF69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgLRIME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:12:04 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2402 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgLRIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:12:04 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Cy1kt6nLHz52k2;
        Fri, 18 Dec 2020 16:10:30 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 18 Dec 2020 16:11:20 +0800
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 18 Dec 2020 16:11:20 +0800
Received: from dggemi762-chm.china.huawei.com ([10.1.198.148]) by
 dggemi762-chm.china.huawei.com ([10.1.198.148]) with mapi id 15.01.2106.002;
 Fri, 18 Dec 2020 16:11:20 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSB2ZHBhOiBNYXJrIG1hY2FkZHJfYnVmIHdp?=
 =?gb2312?Q?th_static_keyword?=
Thread-Topic: [PATCH -next] vdpa: Mark macaddr_buf with static keyword
Thread-Index: AQHW1N67OsyATgPgb0SfqgASIfYi/Kn79t+AgACJOFA=
Date:   Fri, 18 Dec 2020 08:11:20 +0000
Message-ID: <14fa1fb211784992a0e64e9810bdedef@huawei.com>
References: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
 <20201218075659.zjts2fiwp2jkh2ei@steredhat>
In-Reply-To: <20201218075659.zjts2fiwp2jkh2ei@steredhat>
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

SGksDQpJIHJ1biB0aGlzIGNvbW1hbmQ6DQptYWtlIGFsbG1vZGNvbmZpZyBBUkNIPXg4Nl82NCBD
Uk9TU19DT01QSUxFPXg4Nl82NC1saW51eC1nbnUtDQptYWtlIEM9MiBkcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW1fbmV0Lm8gQVJDSD14ODZfNjQgQ1JPU1NfQ09NUElMRT14ODZfNjQtbGlu
dXgtZ251LQ0KDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBTdGVmYW5vIEdhcnphcmVs
bGEgW21haWx0bzpzZ2FyemFyZUByZWRoYXQuY29tXSANCreiy83KsbzkOiAyMDIwxOoxMtTCMTjI
1SAxNTo1Nw0KytW8/sjLOiBab3V3ZWkgKFNhbXVlbCkgPHpvdV93ZWlAaHVhd2VpLmNvbT4NCrOt
y806IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBtZ3VydG92b3lAbnZpZGlh
LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBbUEFUQ0ggLW5leHRdIHZkcGE6IE1hcmsg
bWFjYWRkcl9idWYgd2l0aCBzdGF0aWMga2V5d29yZA0KDQpPbiBGcmksIERlYyAxOCwgMjAyMCBh
dCAwOTo1MTozNUFNICswODAwLCBab3UgV2VpIHdyb3RlOg0KPkZpeCB0aGUgZm9sbG93aW5nIHNw
YXJzZSB3YXJuaW5nOg0KPg0KPmRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYzoz
Njo0OiB3YXJuaW5nOiBzeW1ib2wgJ21hY2FkZHJfYnVmJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91
bGQgaXQgYmUgc3RhdGljPw0KPg0KPlJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVh
d2VpLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBab3UgV2VpIDx6b3Vfd2VpQGh1YXdlaS5jb20+DQo+
LS0tDQo+IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDIgKy0NCj4gMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNClJldmlld2VkLWJ5
OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+DQoNCkkgYnVpbHQgd2l0
aCBXPTEgYnV0IEkgZGlkbid0IGhhdmUgdGhpcyB3YXJuaW5nLg0KDQpUaGFua3MgZm9yIGZpeGlu
ZywNClN0ZWZhbm8NCg0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW1fbmV0LmMgDQo+Yi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMNCj5p
bmRleCBjMTBiNjk4Li5mMDQ4MjQyIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbV9uZXQuYw0KPisrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9u
ZXQuYw0KPkBAIC0zMyw3ICszMyw3IEBAIHN0YXRpYyBjaGFyICptYWNhZGRyOyAgbW9kdWxlX3Bh
cmFtKG1hY2FkZHIsIGNoYXJwLCANCj4wKTsgIE1PRFVMRV9QQVJNX0RFU0MobWFjYWRkciwgIkV0
aGVybmV0IE1BQyBhZGRyZXNzIik7DQo+DQo+LXU4IG1hY2FkZHJfYnVmW0VUSF9BTEVOXTsNCj4r
c3RhdGljIHU4IG1hY2FkZHJfYnVmW0VUSF9BTEVOXTsNCj4NCj4gc3RhdGljIHN0cnVjdCB2ZHBh
c2ltICp2ZHBhc2ltX25ldF9kZXY7DQo+DQo+LS0NCj4yLjYuMg0KPg0KDQo=
