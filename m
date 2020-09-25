Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C75278098
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgIYGYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:24:03 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:51562 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbgIYGX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:23:28 -0400
X-UUID: 48b1fb3542d24cfdaa5120034f5f9fec-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZN6jhTTTTGUHf+kFM+VsC/tCe2Iq5MXwW/i4+iWR9EU=;
        b=mV/MiruKD5doTC1tsVhWw9XpkyroCTp8ydQVr1Blu6p1BpfAYyfv9HiUKMU0hSTsLmkhaZp2J4bz06TbTgkM/fI1ROkJuSANByoN2ZAK/wPp0mMHSxsaDLGBHyzK9bPBsGQx1s/Y8Bks1dctQhvGwYeeIxgP5TB7E8LVIBuzpd8=;
X-UUID: 48b1fb3542d24cfdaa5120034f5f9fec-20200925
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 809288285; Fri, 25 Sep 2020 14:23:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:23:20 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:23:20 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH V3 RESEND 04/11] usb: gadget: bdc: fix warning of embedded function name
Date:   Fri, 25 Sep 2020 14:20:25 +0800
Message-ID: <1601014832-29726-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9391E6810A3D7A6149B86E7A41D8CF3C17861FC7E9F4AE4F9F3CE150A7B573832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlICciJXMuLi4iLCBfX2Z1bmNfXycgdG8gcmVwbGFjZSBlbWJlZGRlZCBmdW5jdGlvbiBuYW1l
DQoNCkNjOiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCkFja2VkLWJ5
OiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NCi0tLQ0KdjM6IGFkZCBh
Y2tlZC1ieSBGbG9yaWFuDQoNCnYyOiBhZGQgQ2MgRmxvcmlhbg0KLS0tDQogZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5jIHwgMiArLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMv
YmRjL2JkY19lcC5jICB8IDYgKysrLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZGJnLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmMNCmlu
ZGV4IDdiYTc0NDguLjljMDNlMTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZGJnLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcu
Yw0KQEAgLTY4LDcgKzY4LDcgQEAgdm9pZCBiZGNfZGJnX3NycihzdHJ1Y3QgYmRjICpiZGMsIHUz
MiBzcnJfbnVtKQ0KIA0KIAlzciA9IGJkYy0+c3JyLnNyX2JkczsNCiAJYWRkciA9IGJkYy0+c3Jy
LmRtYV9hZGRyOw0KLQlkZXZfdmRiZyhiZGMtPmRldiwgImJkY19kYmdfc3JyIHNyOiVwIGRxcF9p
bmRleDolZFxuIiwNCisJZGV2X3ZkYmcoYmRjLT5kZXYsICIlcyBzcjolcCBkcXBfaW5kZXg6JWRc
biIsIF9fZnVuY19fLA0KIAkJCQkJCXNyLCBiZGMtPnNyci5kcXBfaW5kZXgpOw0KIAlmb3IgKGkg
PSAwOyBpIDwgTlVNX1NSX0VOVFJJRVM7IGkrKykgew0KIAkJc3IgPSAmYmRjLT5zcnIuc3JfYmRz
W2ldOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIGIv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCmluZGV4IDc2NDYzZGUuLjQ0ZjNh
MTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KKysr
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCkBAIC03NTYsNyArNzU2LDcg
QEAgc3RhdGljIGludCBlcF9kZXF1ZXVlKHN0cnVjdCBiZGNfZXAgKmVwLCBzdHJ1Y3QgYmRjX3Jl
cSAqcmVxKQ0KIA0KIAlkZXZfZGJnKGJkYy0+ZGV2LCAiJXMgZXA6JXMgc3RhcnQ6JWQgZW5kOiVk
XG4iLA0KIAkJCQkJX19mdW5jX18sIGVwLT5uYW1lLCBzdGFydF9iZGksIGVuZF9iZGkpOw0KLQlk
ZXZfZGJnKGJkYy0+ZGV2LCAiZXBfZGVxdWV1ZSBlcD0lcCBlcC0+ZGVzYz0lcFxuIiwNCisJZGV2
X2RiZyhiZGMtPmRldiwgIiVzIGVwPSVwIGVwLT5kZXNjPSVwXG4iLCBfX2Z1bmNfXywNCiAJCQkJ
CQllcCwgKHZvaWQgKillcC0+dXNiX2VwLmRlc2MpOw0KIAkvKiBpZiBzdGlsbCBjb25uZWN0ZWQs
IHN0b3AgdGhlIGVwIHRvIHNlZSB3aGVyZSB0aGUgSFcgaXMgPyAqLw0KIAlpZiAoIShiZGNfcmVh
ZGwoYmRjLT5yZWdzLCBCRENfVVNQQykgJiBCRENfUFNUX01BU0spKSB7DQpAQCAtMTg1OCwxMiAr
MTg1OCwxMiBAQCBzdGF0aWMgaW50IGJkY19nYWRnZXRfZXBfZW5hYmxlKHN0cnVjdCB1c2JfZXAg
Kl9lcCwNCiAJaW50IHJldDsNCiANCiAJaWYgKCFfZXAgfHwgIWRlc2MgfHwgZGVzYy0+YkRlc2Ny
aXB0b3JUeXBlICE9IFVTQl9EVF9FTkRQT0lOVCkgew0KLQkJcHJfZGVidWcoImJkY19nYWRnZXRf
ZXBfZW5hYmxlIGludmFsaWQgcGFyYW1ldGVyc1xuIik7DQorCQlwcl9kZWJ1ZygiJXMgaW52YWxp
ZCBwYXJhbWV0ZXJzXG4iLCBfX2Z1bmNfXyk7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KIA0K
IAlpZiAoIWRlc2MtPndNYXhQYWNrZXRTaXplKSB7DQotCQlwcl9kZWJ1ZygiYmRjX2dhZGdldF9l
cF9lbmFibGUgbWlzc2luZyB3TWF4UGFja2V0U2l6ZVxuIik7DQorCQlwcl9kZWJ1ZygiJXMgbWlz
c2luZyB3TWF4UGFja2V0U2l6ZVxuIiwgX19mdW5jX18pOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQog
CX0NCiANCi0tIA0KMS45LjENCg==

