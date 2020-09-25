Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCED278034
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgIYGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:04:31 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43819 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgIYGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:04:30 -0400
X-UUID: 7a8f9329c8094777aab4d009c43c2bf8-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5egQoq8hPPAkOfF/INbEfBKiZv1N/+035QYwraMLsRk=;
        b=V1DT5LBbrUCDCnOsYxS5EknJA9LVLWtj0wcrFWlabkfWfip1dJTdYiaC9BqWmsUDAHKU9Vr0Rtx0qUHjWBrL/tESqol7PCrfuUm2rzbVccsglIgqENNKbzqOKUGLyRdybWuTisQq0fTuG+s1daNhccz2GxOp/zHwzURJv104CWI=;
X-UUID: 7a8f9329c8094777aab4d009c43c2bf8-20200925
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1936715688; Fri, 25 Sep 2020 14:04:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:04:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:04:22 +0800
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
Subject: [PATCH RESEND v3 03/11] usb: gadget: bdc: prefer pointer dereference to pointer type
Date:   Fri, 25 Sep 2020 14:01:34 +0800
Message-ID: <1601013702-29079-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B1B665AE6624B315DF54812A6B714A1C6DAD5B6E45F48398DB1BE1EBD0D5A25B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHJlZmVyIGt6YWxsb2Moc2l6ZW9mKCpiZF90YWJsZSkuLi4pIG92ZXINCmt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCBiZF90YWJsZSkNCg0KQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21h
aWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KQWNrZWQtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29t
Pg0KLS0tDQp2MzogYWRkIGFja2VkLWJ5IEZsb3JpYW4NCg0KdjI6IGFkZCBDYyBGbG9yaWFuDQot
LS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2VwLmMNCmluZGV4IGZhZmRjOWYuLjc2NDYzZGUgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2VwLmMNCkBAIC0xNDcsNyArMTQ3LDcgQEAgc3RhdGljIGludCBlcF9iZF9s
aXN0X2FsbG9jKHN0cnVjdCBiZGNfZXAgKmVwKQ0KIAkvKiBBbGxvY2F0ZSBtZW1vcnkgZm9yIGVh
Y2ggdGFibGUgKi8NCiAJZm9yIChpbmRleCA9IDA7IGluZGV4IDwgbnVtX3RhYnM7IGluZGV4Kysp
IHsNCiAJCS8qIEFsbG9jYXRlIG1lbW9yeSBmb3IgYmRfdGFibGUgc3RydWN0dXJlICovDQotCQli
ZF90YWJsZSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBiZF90YWJsZSksIEdGUF9BVE9NSUMpOw0K
KwkJYmRfdGFibGUgPSBremFsbG9jKHNpemVvZigqYmRfdGFibGUpLCBHRlBfQVRPTUlDKTsNCiAJ
CWlmICghYmRfdGFibGUpDQogCQkJZ290byBmYWlsOw0KIA0KLS0gDQoxLjkuMQ0K

