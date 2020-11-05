Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D242A7E23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgKEMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:05:40 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2425 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKEMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:05:39 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CRhzt591Vz52Dh;
        Thu,  5 Nov 2020 20:05:30 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 5 Nov 2020 20:05:34 +0800
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 5 Nov 2020 20:05:34 +0800
Received: from dggemi762-chm.china.huawei.com ([10.1.198.148]) by
 dggemi762-chm.china.huawei.com ([10.1.198.148]) with mapi id 15.01.1913.007;
 Thu, 5 Nov 2020 20:05:33 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSBBU29DOiBtZWRpYXRlazogbXQ4MTkyOiBN?=
 =?gb2312?Q?ake_some_symbols_static?=
Thread-Topic: [PATCH -next] ASoC: mediatek: mt8192: Make some symbols static
Thread-Index: AQHWs2nWluaJsVCcpEKkmgl3F4+tXam5cHAg
Date:   Thu, 5 Nov 2020 12:05:33 +0000
Message-ID: <5f10d3f7d9b24bdc82b7ce9f6bf50023@huawei.com>
References: <1604577724-24687-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1604577724-24687-1-git-send-email-zou_wei@huawei.com>
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

SGkgYWxsLA0KDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIEknbGwgc2VuZCBhbm90aGVyIHBh
dGNoIHdpdGggb3RoZXIgZml4ZXMuDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBab3V3
ZWkgKFNhbXVlbCkgDQq3osvNyrG85DogMjAyMMTqMTHUwjXI1SAyMDowMg0KytW8/sjLOiBsZ2ly
ZHdvb2RAZ21haWwuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7IHBlcmV4QHBlcmV4LmN6OyB0aXdh
aUBzdXNlLmNvbTsgbWF0dGhpYXMuYmdnQGdtYWlsLmNvbQ0Ks63LzTogYWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IFpvdXdlaSAoU2FtdWVsKSA8em91X3dlaUBodWF3ZWkuY29tPg0K1vfM4jogW1BBVENIIC1u
ZXh0XSBBU29DOiBtZWRpYXRlazogbXQ4MTkyOiBNYWtlIHNvbWUgc3ltYm9scyBzdGF0aWMNCg0K
Rml4IHRoZSBmb2xsb3dpbmcgc3BhcnNlIHdhcm5pbmdzOg0KDQouL210ODE5Mi1kYWktaTJzLmM6
MjA0MDo1OiB3YXJuaW5nOiBzeW1ib2wgJ210ODE5Ml9kYWlfaTJzX2dldF9zaGFyZScgd2FzIG5v
dCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCi4vbXQ4MTkyLWRhaS1pMnMuYzoyMDYw
OjU6IHdhcm5pbmc6IHN5bWJvbCAnbXQ4MTkyX2RhaV9pMnNfc2V0X3ByaXYnIHdhcyBub3QgZGVj
bGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQoNClJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxo
dWxrY2lAaHVhd2VpLmNvbT4NClNpZ25lZC1vZmYtYnk6IFpvdSBXZWkgPHpvdV93ZWlAaHVhd2Vp
LmNvbT4NCi0tLQ0KIHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWRhaS1pMnMuYyB8
IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTkyL210ODE5Mi1kYWktaTJz
LmMgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTkyL210ODE5Mi1kYWktaTJzLmMNCmluZGV4IDUz
YzU2MGUuLjViMjkzNDAgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTkyL210
ODE5Mi1kYWktaTJzLmMNCisrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTIvbXQ4MTkyLWRh
aS1pMnMuYw0KQEAgLTIwMzcsNyArMjAzNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Fm
ZV9pMnNfcHJpdiBtdDgxOTJfaTJzX3ByaXZbREFJX0kyU19OVU1dID0gew0KIAl9LA0KIH07DQog
DQotaW50IG10ODE5Ml9kYWlfaTJzX2dldF9zaGFyZShzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUp
DQorc3RhdGljIGludCBtdDgxOTJfZGFpX2kyc19nZXRfc2hhcmUoc3RydWN0IG10a19iYXNlX2Fm
ZSAqYWZlKQ0KIHsNCiAJc3RydWN0IG10ODE5Ml9hZmVfcHJpdmF0ZSAqYWZlX3ByaXYgPSBhZmUt
PnBsYXRmb3JtX3ByaXY7DQogCWNvbnN0IHN0cnVjdCBkZXZpY2Vfbm9kZSAqb2Zfbm9kZSA9IGFm
ZS0+ZGV2LT5vZl9ub2RlOyBAQCAtMjA1Nyw3ICsyMDU3LDcgQEAgaW50IG10ODE5Ml9kYWlfaTJz
X2dldF9zaGFyZShzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUpDQogCXJldHVybiAwOw0KIH0NCiAN
Ci1pbnQgbXQ4MTkyX2RhaV9pMnNfc2V0X3ByaXYoc3RydWN0IG10a19iYXNlX2FmZSAqYWZlKQ0K
K3N0YXRpYyBpbnQgbXQ4MTkyX2RhaV9pMnNfc2V0X3ByaXYoc3RydWN0IG10a19iYXNlX2FmZSAq
YWZlKQ0KIHsNCiAJaW50IGk7DQogCWludCByZXQ7DQotLQ0KMi42LjINCg0K
