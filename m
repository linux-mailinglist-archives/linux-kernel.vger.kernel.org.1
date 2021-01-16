Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947692F8C82
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbhAPJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:43 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45297 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726629AbhAPJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:54 -0500
X-UUID: 6ba9a2f2d54843cc8c63397ca2bfe64d-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7aYnpH3HNuIrIaHyA9QR6A7n68xEKo/2Nbjq9vRRJzw=;
        b=lHqeW6+cvti1hAbq+MiUlzwIUF5Qo/YGht2pIMnAmouC85B158GS827gk3TmiLNELc5bIyhfibMgWLUEMJjciLB9fVzJIpPqYsVzY1NjYiUMcBWvGc8fdrBp4tUym9CGHfGQaTPCEtn2ZpIPV7cr/1n/73UuMDdz0pgKhfQHdro=;
X-UUID: 6ba9a2f2d54843cc8c63397ca2bfe64d-20210116
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1148076225; Sat, 16 Jan 2021 17:07:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:07:01 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:07:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next 10/15] arm64: dts: mediatek: mt8516: harmonize node names and compatibles
Date:   Sat, 16 Jan 2021 17:06:51 +0800
Message-ID: <20210116090656.11752-10-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DF0CEA2BEE36AA4CFFF4BD2F092C09DDF5DBA51F83E182D786589611B8C5061B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmc6DQogIGhhcm1vbml6ZSBub2Rl
IG5hbWVzIGFuZCBjb21wYXRpYmxlczsNCiAgYWRkIHByb3BlcnR5ICJ1c2Itcm9sZS1zd2l0Y2gi
IGZvciBjb25uZWN0b3IgZGVwZW5kZW5jZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDg1MTYuZHRzaSAgICAgICAgIHwgOSArKysrKy0tLS0NCiBhcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL3B1bXBraW4tY29tbW9uLmR0c2kgfCAxICsNCiAyIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4NTE2LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODUxNi5kdHNpDQppbmRleCBlNmU0ZDlkNjAwOTQuLjcwYzljNzQyM2JkNCAx
MDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4NTE2LmR0c2kNCisr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4NTE2LmR0c2kNCkBAIC00NTAsNyAr
NDUwLDcgQEANCiAJCX07DQogDQogCQl1c2IwOiB1c2JAMTExMDAwMDAgew0KLQkJCWNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXRrLW11c2IiOw0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
NTE2LW11c2IiLCAibWVkaWF0ZWssbXRrLW11c2IiOw0KIAkJCXJlZyA9IDwwIDB4MTExMDAwMDAg
MCAweDEwMDA+Ow0KIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA3MiBJUlFfVFlQRV9MRVZFTF9M
T1c+Ow0KIAkJCWludGVycnVwdC1uYW1lcyA9ICJtYyI7DQpAQCAtNDYzLDcgKzQ2Myw3IEBADQog
CQl9Ow0KIA0KIAkJdXNiMTogdXNiQDExMTkwMDAwIHsNCi0JCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ay1tdXNiIjsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODUxNi1tdXNiIiwg
Im1lZGlhdGVrLG10ay1tdXNiIjsNCiAJCQlyZWcgPSA8MCAweDExMTkwMDAwIDAgMHgxMDAwPjsN
CiAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjEwIElSUV9UWVBFX0xFVkVMX0xPVz47DQogCQkJ
aW50ZXJydXB0LW5hbWVzID0gIm1jIjsNCkBAIC00NzYsOCArNDc2LDkgQEANCiAJCQlzdGF0dXMg
PSAiZGlzYWJsZWQiOw0KIAkJfTsNCiANCi0JCXVzYl9waHk6IHVzYkAxMTExMDAwMCB7DQotCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KKwkJdXNiX3BoeTogdC1w
aHlAMTExMTAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4NTE2LXRwaHkiLA0K
KwkJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KIAkJCXJlZyA9IDwwIDB4MTEx
MTAwMDAgMCAweDgwMD47DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQogCQkJI3NpemUtY2Vs
bHMgPSA8Mj47DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9wdW1w
a2luLWNvbW1vbi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9wdW1wa2luLWNv
bW1vbi5kdHNpDQppbmRleCA2M2ZkNzAwODZiYjguLjdkNzM4ZjAxY2Y4ZCAxMDA2NDQNCi0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvcHVtcGtpbi1jb21tb24uZHRzaQ0KKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9wdW1wa2luLWNvbW1vbi5kdHNpDQpAQCAtMTg4
LDYgKzE4OCw3IEBADQogJnVzYjAgew0KIAlzdGF0dXMgPSAib2theSI7DQogCWRyX21vZGUgPSAi
cGVyaXBoZXJhbCI7DQorCXVzYi1yb2xlLXN3aXRjaDsNCiANCiAJdXNiX2NvbjogY29ubmVjdG9y
IHsNCiAJCWNvbXBhdGlibGUgPSAidXNiLWMtY29ubmVjdG9yIjsNCi0tIA0KMi4xOC4wDQo=

