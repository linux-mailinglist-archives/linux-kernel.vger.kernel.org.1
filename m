Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8903C278041
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgIYGEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:04:54 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727332AbgIYGEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:04:45 -0400
X-UUID: 655bfa4379a846d5b1eb4633339d5f61-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L++qiABiAzjVbnpi2fjLv+qiJlqqsDdE0Ctsz0YdEqI=;
        b=c2YasB+0GmZgucsPWx2/0wNJFNidqupedkw0PLMt4vt6xtRHpCTtN0C0UIBH371jA58dYApmzJSHptBewhT+NpbLm8oFYGNiimDIImv0qAxXSJ2GL8luPsLaUWT5wxVFt2yPxbhlGAY2maSad4GctnPTzp+dkJteoFrgjNYYIhA=;
X-UUID: 655bfa4379a846d5b1eb4633339d5f61-20200925
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 72437295; Fri, 25 Sep 2020 14:04:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:04:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:04:24 +0800
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
Subject: [PATCH RESEND v3 05/11] usb: gadget: bdc: fix check warning of block comments alignment
Date:   Fri, 25 Sep 2020 14:01:36 +0800
Message-ID: <1601013702-29079-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 22F8232CE4142182678B2909282BA24D05F5A7153DE7838C063D4EAC699C5A4F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KICBXQVJOSU5HOkJMT0NLX0NPTU1FTlRfU1RZTEU6DQogIEJsb2Nr
IGNvbW1lbnRzIHNob3VsZCBhbGlnbiB0aGUgKiBvbiBlYWNoIGxpbmUNCg0KQ2M6IEZsb3JpYW4g
RmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IEZsb3JpYW4gRmFpbmVs
bGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KLS0tDQp2MzogYWRkIGFja2VkLWJ5IEZsb3JpYW4N
Cg0KdjI6IGFkZCBDYyBGbG9yaWFuDQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9i
ZGMuaCAgICAgfCAyICstDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgIHwg
MiArLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYyB8IDYgKysrLS0tDQog
MyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaCBiL2RyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkYy5oDQppbmRleCBmY2JhNzdlLi5jMGVlNzM1IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkYy5oDQpAQCAtMzUsNyArMzUsNyBAQA0KIC8qDQogICogTWF4aW11bSBzaXpl
IG9mIGVwMCByZXNwb25zZSBidWZmZXIgZm9yIGNoOSByZXF1ZXN0cywNCiAgKiB0aGUgc2V0X3Nl
bCByZXF1ZXN0IHVzZXMgNiBzbyBmYXIsIHRoZSBtYXguDQotKi8NCisgKi8NCiAjZGVmaW5lIEVQ
MF9SRVNQT05TRV9CVUZGICA2DQogLyogU3RhcnQgd2l0aCBTUyBhcyBkZWZhdWx0ICovDQogI2Rl
ZmluZSBFUDBfTUFYX1BLVF9TSVpFIDUxMg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19lcC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMN
CmluZGV4IDQ0ZjNhMTIuLjNmYjM2YzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfZXAuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2Vw
LmMNCkBAIC02OCw3ICs2OCw3IEBAIHN0YXRpYyB2b2lkIGVwX2JkX2xpc3RfZnJlZShzdHJ1Y3Qg
YmRjX2VwICplcCwgdTMyIG51bV90YWJzKQ0KIAkJICogY2hlY2sgaWYgdGhlIGJkX3RhYmxlIHN0
cnVjdCBpcyBhbGxvY2F0ZWQgPw0KIAkJICogaWYgeWVzLCB0aGVuIGNoZWNrIGlmIGJkIG1lbW9y
eSBoYXMgYmVlbiBhbGxvY2F0ZWQsIHRoZW4NCiAJCSAqIGZyZWUgdGhlIGRtYV9wb29sIGFuZCBh
bHNvIHRoZSBiZF90YWJsZSBzdHJ1Y3QgbWVtb3J5DQotCQkqLw0KKwkJICovDQogCQliZF90YWJs
ZSA9IGJkX2xpc3QtPmJkX3RhYmxlX2FycmF5W2luZGV4XTsNCiAJCWRldl9kYmcoYmRjLT5kZXYs
ICJiZF90YWJsZTolcCBpbmRleDolZFxuIiwgYmRfdGFibGUsIGluZGV4KTsNCiAJCWlmICghYmRf
dGFibGUpIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRj
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRjLmMNCmluZGV4IDI0ODQyNmEu
LjBjMWFiOTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRj
LmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYw0KQEAgLTE2NCw3
ICsxNjQsNyBAQCBzdGF0aWMgdm9pZCBiZGNfZnVuY193YWtlX3RpbWVyKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykNCiAJLyoNCiAJICogQ2hlY2sgaWYgaG9zdCBoYXMgc3RhcnRlZCB0cmFuc2Zl
cnJpbmcgb24gZW5kcG9pbnRzDQogCSAqIEZVTkNfV0FLRV9JU1NVRUQgaXMgY2xlYXJlZCB3aGVu
IHRyYW5zZmVyIGhhcyBzdGFydGVkIGFmdGVyIHJlc3VtZQ0KLQkqLw0KKwkgKi8NCiAJaWYgKGJk
Yy0+ZGV2c3RhdHVzICYgRlVOQ19XQUtFX0lTU1VFRCkgew0KIAkJZGV2X2RiZyhiZGMtPmRldiwg
IkZVTkNfV0FLRV9JU1NVRUQgRkxBRyBJUyBTVElMTCBTRVRcbiIpOw0KIAkJLyogZmxhZyBpcyBz
dGlsbCBzZXQsIHNvIGFnYWluIHNlbmQgZnVuYyB3YWtlICovDQpAQCAtMjA1LDcgKzIwNSw3IEBA
IHN0YXRpYyB2b2lkIGhhbmRsZV9saW5rX3N0YXRlX2NoYW5nZShzdHJ1Y3QgYmRjICpiZGMsIHUz
MiB1c3BjKQ0KIAkJCQkgKiBpZiBub3QgdGhlbiBzZW5kIGZ1bmN0aW9uIHdha2UgYWdhaW4gZXZl
cnkNCiAJCQkJICogVE5vdGlmaWNhdGlvbiBzZWNzIHVudGlsIGhvc3QgaW5pdGlhdGVzDQogCQkJ
CSAqIHRyYW5zZmVyIHRvIEJEQywgVVNCMyBzcGVjIFRhYmxlIDguMTMNCi0JCQkJKi8NCisJCQkJ
ICovDQogCQkJCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygNCiAJCQkJCQkmYmRjLT5mdW5jX3dha2Vf
bm90aWZ5LA0KIAkJCQkJCW1zZWNzX3RvX2ppZmZpZXMoQkRDX1ROT1RJRlkpKTsNCkBAIC0zNzks
NyArMzc5LDcgQEAgc3RhdGljIGludCBiZGNfdWRjX3N0YXJ0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpn
YWRnZXQsDQogCSAqIFJ1biB0aGUgY29udHJvbGxlciBmcm9tIGhlcmUgYW5kIHdoZW4gQkRDIGlz
IGNvbm5lY3RlZCB0bw0KIAkgKiBIb3N0IHRoZW4gZHJpdmVyIHdpbGwgcmVjZWl2ZSBhIFVTUEMg
U1Igd2l0aCBWQlVTIHByZXNlbnQNCiAJICogYW5kIHRoZW4gZHJpdmVyIHdpbGwgZG8gYSBzb2Z0
Y29ubmVjdC4NCi0JKi8NCisJICovDQogCXJldCA9IGJkY19ydW4oYmRjKTsNCiAJaWYgKHJldCkg
ew0KIAkJZGV2X2VycihiZGMtPmRldiwgIiVzIGJkYyBydW4gZmFpbFxuIiwgX19mdW5jX18pOw0K
LS0gDQoxLjkuMQ0K

