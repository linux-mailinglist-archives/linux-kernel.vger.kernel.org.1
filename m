Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFD278092
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgIYGXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:23:53 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:28659 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgIYGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:23:35 -0400
X-UUID: 42d6565761414e008c294ec8308da06c-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kYSGke9KlqBn4Imn3VxXZ1Ao1jgfddQziSV2EmrSBz4=;
        b=X66NiSswR2Q/D7nOuLdm49PL5P1zVc7XmqcysMei60HwYDdNt1SBgJXTiwvWa5zg8D5eULj2+dBurrX7tcLM4Yw3JqpRa9eIAcbMvyGPc2zo5z+SDXF1TOG+iP+cJt/wTwrvwTcOdXsWtJFh+Zu3mKJCm4pGWmZuS3ARSrAX4h0=;
X-UUID: 42d6565761414e008c294ec8308da06c-20200925
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 350916211; Fri, 25 Sep 2020 14:23:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:23:28 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:23:29 +0800
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
Subject: [PATCH V3 RESEND 10/11] usb: gadget: bdc: fix checkpatch.pl spacing error
Date:   Fri, 25 Sep 2020 14:20:31 +0800
Message-ID: <1601014832-29726-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 59C8D56F5436A71F21A67790EE0C55FB6701AEB7CD6F36843212C265EE2E39D22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IGNoZWNrcGF0Y2gucGwgZXJyb3I6DQpFUlJPUjpTUEFDSU5HOiBzcGFjZSBwcm9oaWJpdGVk
IGJlZm9yZSB0aGF0ICcsJw0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFp
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+
DQotLS0NCnYzOiBhZGQgYWNrZWQtYnkgRmxvcmlhbg0KDQp2MjogYWRkIENjIEZsb3JpYW4NCi0t
LQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYmRjL2JkY191ZGMuYw0KaW5kZXggMGMxYWI5NS4uNWFjMGVmOCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYw0KKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjX3VkYy5jDQpAQCAtNTMwLDcgKzUzMCw3IEBAIGludCBiZGNfdWRjX2lu
aXQoc3RydWN0IGJkYyAqYmRjKQ0KIA0KIAliZGMtPmdhZGdldC5uYW1lID0gQlJDTV9CRENfTkFN
RTsNCiAJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShiZGMtPmRldiwgYmRjLT5pcnEsIGJkY191ZGNf
aW50ZXJydXB0LA0KLQkJCQlJUlFGX1NIQVJFRCAsIEJSQ01fQkRDX05BTUUsIGJkYyk7DQorCQkJ
CUlSUUZfU0hBUkVELCBCUkNNX0JEQ19OQU1FLCBiZGMpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZf
ZXJyKGJkYy0+ZGV2LA0KIAkJCSJmYWlsZWQgdG8gcmVxdWVzdCBpcnEgIyVkICVkXG4iLA0KLS0g
DQoxLjkuMQ0K

