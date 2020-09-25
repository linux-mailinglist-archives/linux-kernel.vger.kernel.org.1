Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7CE27801F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgIYGBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:53850 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727180AbgIYGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:30 -0400
X-UUID: 6e6a34231f594a6492e345ae2e180cf9-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y7E4ycu+S5kKxDKmE75CRH74w4vzOtRNG2yWehc7u0k=;
        b=WRmOchD7XUs3TTugL2MCvEZR74kliCAOZS/bP/lCHAxQMF5fhjsbb3IRk5MgrAhDEVDvBn83n1IrsZh6UFGENHH9SI5YunY0znQyiJVubdAigWb78b2Me/aqF2Bou9RbV3di5QVevFN9zCSiwc8/+TFG3/vl/PZ2OYlLyrbzcZE=;
X-UUID: 6e6a34231f594a6492e345ae2e180cf9-20200925
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1810239495; Fri, 25 Sep 2020 14:01:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:20 +0800
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
Subject: [PATCH 05/11] usb: gadget: bdc: fix check warning of block comments alignment
Date:   Fri, 25 Sep 2020 13:58:13 +0800
Message-ID: <1601013499-28920-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5D605A96F2D82EB87F1C7A45BE7FF8F376883F53ACE87B63CE65DD0F19C0BB062000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KICBXQVJOSU5HOkJMT0NLX0NPTU1FTlRfU1RZTEU6DQogIEJsb2Nr
IGNvbW1lbnRzIHNob3VsZCBhbGlnbiB0aGUgKiBvbiBlYWNoIGxpbmUNCg0KQ2hhbmdlLUlkOiBJ
ZGM4OWM4MDU2NTA2NDFjMTRhZDU1NGY3NzMzMzk3ZDEyNTU2NzhiMg0KQ2M6IEZsb3JpYW4gRmFp
bmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IEZsb3JpYW4gRmFpbmVsbGkg
PGYuZmFpbmVsbGlAZ21haWwuY29tPg0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMv
YmRjLmggICAgIHwgMiArLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jICB8
IDIgKy0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRjLmMgfCA2ICsrKy0tLQ0K
IDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmggYi9kcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGMuaA0KaW5kZXggZmNiYTc3ZS4uYzBlZTczNSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oDQorKysgYi9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2JkYy9iZGMuaA0KQEAgLTM1LDcgKzM1LDcgQEANCiAvKg0KICAqIE1heGltdW0gc2l6
ZSBvZiBlcDAgcmVzcG9uc2UgYnVmZmVyIGZvciBjaDkgcmVxdWVzdHMsDQogICogdGhlIHNldF9z
ZWwgcmVxdWVzdCB1c2VzIDYgc28gZmFyLCB0aGUgbWF4Lg0KLSovDQorICovDQogI2RlZmluZSBF
UDBfUkVTUE9OU0VfQlVGRiAgNg0KIC8qIFN0YXJ0IHdpdGggU1MgYXMgZGVmYXVsdCAqLw0KICNk
ZWZpbmUgRVAwX01BWF9QS1RfU0laRSA1MTINCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2JkYy9iZGNfZXAuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5j
DQppbmRleCA0NGYzYTEyLi4zZmIzNmM4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2VwLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19l
cC5jDQpAQCAtNjgsNyArNjgsNyBAQCBzdGF0aWMgdm9pZCBlcF9iZF9saXN0X2ZyZWUoc3RydWN0
IGJkY19lcCAqZXAsIHUzMiBudW1fdGFicykNCiAJCSAqIGNoZWNrIGlmIHRoZSBiZF90YWJsZSBz
dHJ1Y3QgaXMgYWxsb2NhdGVkID8NCiAJCSAqIGlmIHllcywgdGhlbiBjaGVjayBpZiBiZCBtZW1v
cnkgaGFzIGJlZW4gYWxsb2NhdGVkLCB0aGVuDQogCQkgKiBmcmVlIHRoZSBkbWFfcG9vbCBhbmQg
YWxzbyB0aGUgYmRfdGFibGUgc3RydWN0IG1lbW9yeQ0KLQkJKi8NCisJCSAqLw0KIAkJYmRfdGFi
bGUgPSBiZF9saXN0LT5iZF90YWJsZV9hcnJheVtpbmRleF07DQogCQlkZXZfZGJnKGJkYy0+ZGV2
LCAiYmRfdGFibGU6JXAgaW5kZXg6JWRcbiIsIGJkX3RhYmxlLCBpbmRleCk7DQogCQlpZiAoIWJk
X3RhYmxlKSB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX3Vk
Yy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX3VkYy5jDQppbmRleCAyNDg0MjZh
Li4wYzFhYjk1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX3Vk
Yy5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfdWRjLmMNCkBAIC0xNjQs
NyArMTY0LDcgQEAgc3RhdGljIHZvaWQgYmRjX2Z1bmNfd2FrZV90aW1lcihzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspDQogCS8qDQogCSAqIENoZWNrIGlmIGhvc3QgaGFzIHN0YXJ0ZWQgdHJhbnNm
ZXJyaW5nIG9uIGVuZHBvaW50cw0KIAkgKiBGVU5DX1dBS0VfSVNTVUVEIGlzIGNsZWFyZWQgd2hl
biB0cmFuc2ZlciBoYXMgc3RhcnRlZCBhZnRlciByZXN1bWUNCi0JKi8NCisJICovDQogCWlmIChi
ZGMtPmRldnN0YXR1cyAmIEZVTkNfV0FLRV9JU1NVRUQpIHsNCiAJCWRldl9kYmcoYmRjLT5kZXYs
ICJGVU5DX1dBS0VfSVNTVUVEIEZMQUcgSVMgU1RJTEwgU0VUXG4iKTsNCiAJCS8qIGZsYWcgaXMg
c3RpbGwgc2V0LCBzbyBhZ2FpbiBzZW5kIGZ1bmMgd2FrZSAqLw0KQEAgLTIwNSw3ICsyMDUsNyBA
QCBzdGF0aWMgdm9pZCBoYW5kbGVfbGlua19zdGF0ZV9jaGFuZ2Uoc3RydWN0IGJkYyAqYmRjLCB1
MzIgdXNwYykNCiAJCQkJICogaWYgbm90IHRoZW4gc2VuZCBmdW5jdGlvbiB3YWtlIGFnYWluIGV2
ZXJ5DQogCQkJCSAqIFROb3RpZmljYXRpb24gc2VjcyB1bnRpbCBob3N0IGluaXRpYXRlcw0KIAkJ
CQkgKiB0cmFuc2ZlciB0byBCREMsIFVTQjMgc3BlYyBUYWJsZSA4LjEzDQotCQkJCSovDQorCQkJ
CSAqLw0KIAkJCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoDQogCQkJCQkJJmJkYy0+ZnVuY193YWtl
X25vdGlmeSwNCiAJCQkJCQltc2Vjc190b19qaWZmaWVzKEJEQ19UTk9USUZZKSk7DQpAQCAtMzc5
LDcgKzM3OSw3IEBAIHN0YXRpYyBpbnQgYmRjX3VkY19zdGFydChzdHJ1Y3QgdXNiX2dhZGdldCAq
Z2FkZ2V0LA0KIAkgKiBSdW4gdGhlIGNvbnRyb2xsZXIgZnJvbSBoZXJlIGFuZCB3aGVuIEJEQyBp
cyBjb25uZWN0ZWQgdG8NCiAJICogSG9zdCB0aGVuIGRyaXZlciB3aWxsIHJlY2VpdmUgYSBVU1BD
IFNSIHdpdGggVkJVUyBwcmVzZW50DQogCSAqIGFuZCB0aGVuIGRyaXZlciB3aWxsIGRvIGEgc29m
dGNvbm5lY3QuDQotCSovDQorCSAqLw0KIAlyZXQgPSBiZGNfcnVuKGJkYyk7DQogCWlmIChyZXQp
IHsNCiAJCWRldl9lcnIoYmRjLT5kZXYsICIlcyBiZGMgcnVuIGZhaWxcbiIsIF9fZnVuY19fKTsN
Ci0tIA0KMS44LjEuMS5kaXJ0eQ0K

