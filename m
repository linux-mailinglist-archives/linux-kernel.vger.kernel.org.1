Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692A128806F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgJIClx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:41:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29604 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729517AbgJIClx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:41:53 -0400
X-UUID: 1e9425752dcd4f278ed88c21beac7b6e-20201009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TkH5V8eKQiruL8/pn1MjIKfrBNvjzUM+osNIwqVGMGw=;
        b=ZVlW3RTUONuu2bpktdUbH4PZIZqDzyruWo/BLzQK12Yld+Uh9HGTspwXM30z24LmGjXestdj+AT6GEZZyB+14ckDc84BVsAloLEpRMM2SEhR2dzvk9q3vvnbtb3vLh67v3sLmlArBTMK5itgJP9jj8zocmUFsXYmwC3nsMhmXvI=;
X-UUID: 1e9425752dcd4f278ed88c21beac7b6e-20201009
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <lina.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2058584294; Fri, 09 Oct 2020 10:41:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Oct 2020 10:41:36 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Oct 2020 10:41:35 +0800
From:   mtk81216 <lina.wang@mediatek.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <kernel-team@android.com>,
        Lina Wang <lina.wang@mediatek.com>
Subject: [PATCH] xfrm:ignore big packets when tunnel mode
Date:   Fri, 9 Oct 2020 10:35:32 +0800
Message-ID: <20201009023532.6474-1-lina.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 008FD9764427441DC770CAB2E01159E36266243A2F20FBE2BA8406546E8153EF2000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGluYSBXYW5nIDxsaW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpJbiB0dW5uZWwgbW9k
ZSwgd2hlbiBpbm5lciBpbnRlcmZhY2UgaXMgaXB2NCxvdXRlciBpbnRlcmZhY2UgaXMgaXB2Niwg
ZmxhZ3MNCm9mIHR1bm5lbCBtb2RlJ3MgeGZybSBzdGF0ZSBpcyBhZi11bnNwZWMsIGlmIGEgbGFy
Z2VyIHBhY2tldCB3aG8gaXMgYmlnZ2VyDQp0aGFuIG10dSBnb2VzIHRocm91Z2ggdHVubmVsIGlu
dGVyZmFjZSwgaXQgZW50ZXJzIGlwNl9mcmFnbWVudCwgZ29lcyB0bw0KZmFpbF90b29iaWcsIGFu
ZCBJQ01QVjYoSUNNUFY2X1BLVF9UT09CSUcpIHdpbGwgYmUgc2VudC4gSXQgaXMgdW5uZWNlc3Nh
cnkNCnRvIGRvIHNvLiBJcDZfZnJhZ21lbnQgd2lsbCBmcmFnbWVudCBzdWNoIHBhY2tldCB3aXRo
IG91dGVyIGludGVyZmFjZSdzIG10dQ0KbWludXMgdHVubmVsbGVkIGVzcCBoZWFkZXIsaXQgd29u
b3QgYmUgdG9vIGJpZy4NCg0KVGhlIHNhbWUgdGhpbmdzIGhhcHBlbiwgd2hlbiBhIGxhcmdlciBm
cmFnbWVudGVkIHBhY2tldCB3aG9zZSBmcmFnX21heF9zaXplDQppcyBsYXJnZXIgdGhhbiBtdHUu
DQoNCldoZW4gYSBsYXJnZXIgZnJhZ21lbnRlZCBwYWNrZXQgaXMgZm9yd2FyZGVkLCBpdCBhbHNv
IG1lZXRzIHRoZSBzYW1lIA0Kc2NlbmFyeS4NCg0KVGhpcyBwYXRjaCBoYXMgaGFuZGxlZCB0aHJl
ZSBhYm92ZSBzY2VuYXJpZXMsIGlmIGl0IGlzIHR1bm5lbCBtb2RlLGp1c3QgDQppZ25vcmUgc2ti
X2xlbiBvciBmcmFnX21heF9zaXplLCBrZWVwIGdvaW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBMaW5h
IFdhbmcgPGxpbmEud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBuZXQvaXB2Ni9pcDZfb3V0cHV0
LmMgfCAyMyArKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L2lwdjYvaXA2X291
dHB1dC5jIGIvbmV0L2lwdjYvaXA2X291dHB1dC5jDQppbmRleCBjNzhlNjdkNzc0N2YuLjBlMWU2
ZmNkN2E1ZCAxMDA2NDQNCi0tLSBhL25ldC9pcHY2L2lwNl9vdXRwdXQuYw0KKysrIGIvbmV0L2lw
djYvaXA2X291dHB1dC5jDQpAQCAtNDAyLDEyICs0MDIsMTQgQEAgc3RhdGljIGlubGluZSBpbnQg
aXA2X2ZvcndhcmRfZmluaXNoKHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IHNvY2sgKnNrLA0KIA0K
IHN0YXRpYyBib29sIGlwNl9wa3RfdG9vX2JpZyhjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1
bnNpZ25lZCBpbnQgbXR1KQ0KIHsNCisJc3RydWN0IHJ0Nl9pbmZvICpydCA9IChzdHJ1Y3QgcnQ2
X2luZm8gKilza2JfZHN0KHNrYik7DQogCWlmIChza2ItPmxlbiA8PSBtdHUpDQogCQlyZXR1cm4g
ZmFsc2U7DQogDQogCS8qIGlwdjYgY29ubnRyYWNrIGRlZnJhZyBzZXRzIG1heF9mcmFnX3NpemUg
KyBpZ25vcmVfZGYgKi8NCiAJaWYgKElQNkNCKHNrYiktPmZyYWdfbWF4X3NpemUgJiYgSVA2Q0Io
c2tiKS0+ZnJhZ19tYXhfc2l6ZSA+IG10dSkNCi0JCXJldHVybiB0cnVlOw0KKwkJaWYgKHJ0ICYm
ICEocnQtPmRzdC5mbGFncyAmIERTVF9YRlJNX1RVTk5FTCkpDQorCQkJcmV0dXJuIHRydWU7DQog
DQogCWlmIChza2ItPmlnbm9yZV9kZikNCiAJCXJldHVybiBmYWxzZTsNCkBAIC03ODcsMTYgKzc4
OSwxOSBAQCBpbnQgaXA2X2ZyYWdtZW50KHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IHNvY2sgKnNr
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KIAkgKiBvciBpZiB0aGUgc2tiIGl0IG5vdCBnZW5lcmF0
ZWQgYnkgYSBsb2NhbCBzb2NrZXQuDQogCSAqLw0KIAlpZiAodW5saWtlbHkoIXNrYi0+aWdub3Jl
X2RmICYmIHNrYi0+bGVuID4gbXR1KSkNCi0JCWdvdG8gZmFpbF90b29iaWc7DQotDQotCWlmIChJ
UDZDQihza2IpLT5mcmFnX21heF9zaXplKSB7DQotCQlpZiAoSVA2Q0Ioc2tiKS0+ZnJhZ19tYXhf
c2l6ZSA+IG10dSkNCisJCWlmIChydCAmJiAocnQtPmRzdC5mbGFncyAmIERTVF9YRlJNX1RVTk5F
TCkpDQogCQkJZ290byBmYWlsX3Rvb2JpZzsNCiANCi0JCS8qIGRvbid0IHNlbmQgZnJhZ21lbnRz
IGxhcmdlciB0aGFuIHdoYXQgd2UgcmVjZWl2ZWQgKi8NCi0JCW10dSA9IElQNkNCKHNrYiktPmZy
YWdfbWF4X3NpemU7DQotCQlpZiAobXR1IDwgSVBWNl9NSU5fTVRVKQ0KLQkJCW10dSA9IElQVjZf
TUlOX01UVTsNCisJaWYgKElQNkNCKHNrYiktPmZyYWdfbWF4X3NpemUpIHsNCisJCWlmIChJUDZD
Qihza2IpLT5mcmFnX21heF9zaXplID4gbXR1KSB7DQorCQkJaWYgKHJ0ICYmICEocnQtPmRzdC5m
bGFncyAmIERTVF9YRlJNX1RVTk5FTCkpDQorCQkJCWdvdG8gZmFpbF90b29iaWc7DQorCQl9IGVs
c2Ugew0KKwkJCS8qIGRvbid0IHNlbmQgZnJhZ21lbnRzIGxhcmdlciB0aGFuIHdoYXQgd2UgcmVj
ZWl2ZWQgKi8NCisJCQltdHUgPSBJUDZDQihza2IpLT5mcmFnX21heF9zaXplOw0KKwkJCWlmICht
dHUgPCBJUFY2X01JTl9NVFUpDQorCQkJCW10dSA9IElQVjZfTUlOX01UVTsNCisJCX0NCiAJfQ0K
IA0KIAlpZiAobnAgJiYgbnAtPmZyYWdfc2l6ZSA8IG10dSkgew0KLS0gDQoyLjE4LjANCg==

