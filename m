Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4056C278023
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgIYGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:19824 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727201AbgIYGBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:34 -0400
X-UUID: 800ad663f5cb489fa60fb3bcc4709e6d-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CVty1io5XFRd6B908K6UaU6Yp52fbiwvzI57mN8EJhU=;
        b=hV9Ath1QaQhYFbedMI2826Tt4NBG3vDRcPrVdVdS5uTXwcJ4wmuZSpcdN2mLZw9n2LyMOBkOIPkA7S/SX0xQzBdN7D7cBSY2YS2Dgu8EEWsyeSUHE62FNj7qMnw+zut8qeluR3FhelMgrtyyDeSKuNX1vwUVMTQMtTOa0wkrRAU=;
X-UUID: 800ad663f5cb489fa60fb3bcc4709e6d-20200925
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1461611661; Fri, 25 Sep 2020 14:01:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:25 +0800
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
Subject: [PATCH 09/11] usb: gadget: bdc: fix checkpatch.pl tab warning
Date:   Fri, 25 Sep 2020 13:58:17 +0800
Message-ID: <1601013499-28920-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 517A33FA7F714865E568706B912D8304B50CE7276976D79D10E7BC57666AF1262000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V0FSTklORzpTVVNQRUNUX0NPREVfSU5ERU5UOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25k
aXRpb25hbCBzdGF0ZW1lbnRzDQpXQVJOSU5HOlRBQlNUT1A6IFN0YXRlbWVudHMgc2hvdWxkIHN0
YXJ0IG9uIGEgdGFic3RvcA0KDQpDaGFuZ2UtSWQ6IEllYzY2YzdlMjliYWJjMjgzNWUwMTM3ZDI5
ODA5M2IzOTZhYTI3NTlkDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQot
LS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmMgfCAyICstDQogZHJpdmVy
cy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgIHwgNCArKy0tDQogMiBmaWxlcyBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfY21kLmMNCmluZGV4IDQ0YzJhNWUuLjk5NWY3OWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYmRjL2JkY19jbWQuYw0KQEAgLTE2Myw3ICsxNjMsNyBAQCBpbnQgYmRjX2NvbmZpZ19lcChz
dHJ1Y3QgYmRjICpiZGMsIHN0cnVjdCBiZGNfZXAgKmVwKQ0KIAkJCQkJdXNiX2VuZHBvaW50X3hm
ZXJfaXNvYyhkZXNjKSkgew0KIAkJCXBhcmFtMiB8PSBzaTsNCiAJCQlpZiAodXNiX2VuZHBvaW50
X3hmZXJfaXNvYyhkZXNjKSAmJiBjb21wX2Rlc2MpDQotCQkJCQltdWwgPSBjb21wX2Rlc2MtPmJt
QXR0cmlidXRlczsNCisJCQkJbXVsID0gY29tcF9kZXNjLT5ibUF0dHJpYnV0ZXM7DQogDQogCQl9
DQogCQlwYXJhbTIgfD0gbXVsIDw8IEVQTV9TSElGVDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2Jk
Y19lcC5jDQppbmRleCAzZmIzNmM4Li5kMjI3ZDI2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRj
L2JkY19lcC5jDQpAQCAtMjc1LDcgKzI3NSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGZpbmRfZW5k
X2JkaShzdHJ1Y3QgYmRjX2VwICplcCwgaW50IG5leHRfaHdkX2JkaSkNCiAJZW5kX2JkaSA9IG5l
eHRfaHdkX2JkaSAtIDE7DQogCWlmIChlbmRfYmRpIDwgMCkNCiAJCWVuZF9iZGkgPSBlcC0+YmRf
bGlzdC5tYXhfYmRpIC0gMTsNCi0JIGVsc2UgaWYgKChlbmRfYmRpICUgKGVwLT5iZF9saXN0Lm51
bV9iZHNfdGFibGUtMSkpID09IDApDQorCWVsc2UgaWYgKChlbmRfYmRpICUgKGVwLT5iZF9saXN0
Lm51bV9iZHNfdGFibGUtMSkpID09IDApDQogCQllbmRfYmRpLS07DQogDQogCXJldHVybiBlbmRf
YmRpOw0KQEAgLTc5NSw3ICs3OTUsNyBAQCBzdGF0aWMgaW50IGVwX2RlcXVldWUoc3RydWN0IGJk
Y19lcCAqZXAsIHN0cnVjdCBiZGNfcmVxICpyZXEpDQogCQkJc3RhcnRfcGVuZGluZyA9IHRydWU7
DQogCQkJZW5kX3BlbmRpbmcgPSB0cnVlOw0KIAkJfSBlbHNlIGlmIChlbmRfYmRpID49IGN1cnJf
aHdfZHFwaSB8fCBlbmRfYmRpIDw9IGVxcF9iZGkpIHsNCi0JCQkJZW5kX3BlbmRpbmcgPSB0cnVl
Ow0KKwkJCWVuZF9wZW5kaW5nID0gdHJ1ZTsNCiAJCX0NCiAJfSBlbHNlIHsNCiAJCWlmIChzdGFy
dF9iZGkgPj0gY3Vycl9od19kcXBpKSB7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

