Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEF295C29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896073AbgJVJoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:44:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38689 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2895918AbgJVJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:44:44 -0400
X-UUID: 646a30c67f8045b6831346530bdd4d8d-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4h6hAq7l0V4rS9t709EExfcDsTlXaMuAC530Tl9I3lE=;
        b=aHofETMCPK01JrxMeZoldwr40Y5X+PCDLPMw/laQrLcXcZ6OlVKBFs/gi/y7vZtRxhEuIY+8c8Vjhp5cxY/Jo4ncD9Jzxc4Rhmr3nx2hmD0xVAH5xF6gyy64QR1/i1s3G5iyJKL+3/iI5oEhUbxCXFcZs8BDVP8Og+rqmCzRabE=;
X-UUID: 646a30c67f8045b6831346530bdd4d8d-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1232868719; Thu, 22 Oct 2020 17:44:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 17:44:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 17:44:20 +0800
From:   Houlong Wei <houlong.wei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <yongqiang.niu@mediatek.com>
Subject: [PATCH] soc: mediatek: cmdq: fixup possible timeout issue
Date:   Thu, 22 Oct 2020 17:41:53 +0800
Message-ID: <20201022094152.17662-1-houlong.wei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4ZXM6IDU3NmYxYjRiYzgwMiAoInNvYzogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBDTURRIGhl
bHBlciIpDQoNClRoZXJlIG1heSBiZSBwb3NzaWJsZSB0aW1lb3V0IGlzc3VlIHdoZW4gbG90cyBv
ZiBjbWRxIHBhY2tldHMgYXJlDQpmbHVzaGVkIHRvIHRoZSBzYW1lIGNtZHEgY2xpZW50LiBUaGUg
bmVjZXNzYXJ5IG1vZGlmaWNhdGlvbnMgYXJlIGFzDQpiZWxvdy4NCjEuQWRqdXN0IHRoZSB0aW1l
ciB0aW1lb3V0IHBlcmlvZCBhcyBjbGllbnQtPnRpbWVvdXRfbXMgKiBjbGllbnQtPnBrdF9jbnQu
DQoyLk9wdGltaXplIHRoZSB0aW1lIHRvIHN0YXJ0IHRoZSB0aW1lci4NCg0KU2lnbmVkLW9mZi1i
eTogSG91bG9uZyBXZWkgPGhvdWxvbmcud2VpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMjIgKysrKysrKysrKysrKysrKysrLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggZGM2NDRjZmI2NDE5Li4z
MTE0MmMxOTM1MjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBA
IC0zNTAsNyArMzUwLDggQEAgc3RhdGljIHZvaWQgY21kcV9wa3RfZmx1c2hfYXN5bmNfY2Ioc3Ry
dWN0IGNtZHFfY2JfZGF0YSBkYXRhKQ0KIAkJCWRlbF90aW1lcigmY2xpZW50LT50aW1lcik7DQog
CQllbHNlDQogCQkJbW9kX3RpbWVyKCZjbGllbnQtPnRpbWVyLCBqaWZmaWVzICsNCi0JCQkJICBt
c2Vjc190b19qaWZmaWVzKGNsaWVudC0+dGltZW91dF9tcykpOw0KKwkJCQkgIG1zZWNzX3RvX2pp
ZmZpZXMoY2xpZW50LT50aW1lb3V0X21zICoNCisJCQkJCQkgICBjbGllbnQtPnBrdF9jbnQpKTsN
CiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNsaWVudC0+bG9jaywgZmxhZ3MpOw0KIAl9DQog
DQpAQCAtMzc5LDkgKzM4MCw3IEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCiANCiAJaWYgKGNsaWVudC0+dGlt
ZW91dF9tcyAhPSBDTURRX05PX1RJTUVPVVQpIHsNCiAJCXNwaW5fbG9ja19pcnFzYXZlKCZjbGll
bnQtPmxvY2ssIGZsYWdzKTsNCi0JCWlmIChjbGllbnQtPnBrdF9jbnQrKyA9PSAwKQ0KLQkJCW1v
ZF90aW1lcigmY2xpZW50LT50aW1lciwgamlmZmllcyArDQotCQkJCSAgbXNlY3NfdG9famlmZmll
cyhjbGllbnQtPnRpbWVvdXRfbXMpKTsNCisJCWNsaWVudC0+cGt0X2NudCsrOw0KIAkJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmY2xpZW50LT5sb2NrLCBmbGFncyk7DQogCX0NCiANCkBAIC0zOTEs
NiArMzkwLDIxIEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCiAJLyogV2UgY2FuIHNlbmQgbmV4dCBwYWNrZXQg
aW1tZWRpYXRlbHksIHNvIGp1c3QgY2FsbCB0eGRvbmUuICovDQogCW1ib3hfY2xpZW50X3R4ZG9u
ZShjbGllbnQtPmNoYW4sIDApOw0KIA0KKwlpZiAoY2xpZW50LT50aW1lb3V0X21zICE9IENNRFFf
Tk9fVElNRU9VVCkgew0KKwkJc3Bpbl9sb2NrX2lycXNhdmUoJmNsaWVudC0+bG9jaywgZmxhZ3Mp
Ow0KKwkJLyoNCisJCSAqIEdDRSBIVyBtYXliZSBleGVjdXRlIHRvbyBxdWlja2x5IGFuZCB0aGUg
Y2FsbGJhY2sgZnVuY3Rpb24NCisJCSAqIG1heSBiZSBpbnZva2VkIGVhcmxpZXIuIElmIHRoaXMg
aGFwcGVucywgcGt0X2NudCBpcyByZWR1Y2VkDQorCQkgKiBieSAxIGluIGNtZHFfcGt0X2ZsdXNo
X2FzeW5jX2NiKCkuIFRoZSB0aW1lciBpcyBzZXQgb25seSBpZg0KKwkJICogcGt0X2NudCBpcyBn
cmVhdGVyIHRoYW4gMC4NCisJCSAqLw0KKwkJaWYgKGNsaWVudC0+cGt0X2NudCA+IDApDQorCQkJ
bW9kX3RpbWVyKCZjbGllbnQtPnRpbWVyLCBqaWZmaWVzICsNCisJCQkJICBtc2Vjc190b19qaWZm
aWVzKGNsaWVudC0+dGltZW91dF9tcyAqDQorCQkJCQkJICAgY2xpZW50LT5wa3RfY250KSk7DQor
CQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjbGllbnQtPmxvY2ssIGZsYWdzKTsNCisJfQ0KKw0K
IAlyZXR1cm4gMDsNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9mbHVzaF9hc3luYyk7DQot
LSANCjIuMTguMA0K

