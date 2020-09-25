Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295BA278038
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgIYGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:04:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:37486 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727217AbgIYGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:04:36 -0400
X-UUID: e0b3404abd8f45f294c3f03524b9edc1-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M9B+st9EHiLWNz6oa11lg4+mh5nozfsj2SPClhQffMk=;
        b=oICynPrcjgESkqCoOIvdOqvVfq9TDngK2oaYeXy+SlIa4tmhsD7ecJDIreZu6JelL2BjqHUeBCu59GG2k3G1Nb8qmW2sHuzNHxjSGTAo9b9EzF2A1wxT+Q7ipKUMF2hEh4RLqLOsJ8zVB2OrVH8+3Y3iGUAx4gJoOJbNa++0KGU=;
X-UUID: e0b3404abd8f45f294c3f03524b9edc1-20200925
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1829611717; Fri, 25 Sep 2020 14:04:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:04:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:04:27 +0800
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
Subject: [PATCH RESEND v3 07/11] usb: gadget: bdc: avoid precedence issues
Date:   Fri, 25 Sep 2020 14:01:38 +0800
Message-ID: <1601013702-29079-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0389EB4D72E59CF5B32446441A9D0A2251206227AC968397D5D446D17E51BCDB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICgpIGFyb3VuZCBtYWNybyBhcmd1bWVudCB0byBhdm9pZCBwcmVjZWRlbmNlIGlzc3Vlcw0K
DQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTog
RmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQotLS0NCnYzOiBhZGQgYWNr
ZWQtYnkgRmxvcmlhbg0KDQp2MjogYWRkIENjIEZsb3JpYW4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkYy5oIHwgMTggKysrKysrKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMv
YmRjLmgNCmluZGV4IDY1OGFiZWYuLmY4ZDU5NTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGMuaA0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRj
LmgNCkBAIC04NiwyMCArODYsMjAgQEANCiAjZGVmaW5lIEJEQ19FUFNUUzUJMHg3NA0KICNkZWZp
bmUgQkRDX0VQU1RTNgkweDc4DQogI2RlZmluZSBCRENfRVBTVFM3CTB4N2MNCi0jZGVmaW5lIEJE
Q19TUlJCQUwobikJKDB4MjAwICsgKG4gKiAweDEwKSkNCi0jZGVmaW5lIEJEQ19TUlJCQUgobikJ
KDB4MjA0ICsgKG4gKiAweDEwKSkNCi0jZGVmaW5lIEJEQ19TUlJJTlQobikJKDB4MjA4ICsgKG4g
KiAweDEwKSkNCi0jZGVmaW5lIEJEQ19JTlRDVExTKG4pCSgweDIwYyArIChuICogMHgxMCkpDQor
I2RlZmluZSBCRENfU1JSQkFMKG4pCSgweDIwMCArICgobikgKiAweDEwKSkNCisjZGVmaW5lIEJE
Q19TUlJCQUgobikJKDB4MjA0ICsgKChuKSAqIDB4MTApKQ0KKyNkZWZpbmUgQkRDX1NSUklOVChu
KQkoMHgyMDggKyAoKG4pICogMHgxMCkpDQorI2RlZmluZSBCRENfSU5UQ1RMUyhuKQkoMHgyMGMg
KyAoKG4pICogMHgxMCkpDQogDQogLyogRXh0ZW5kZWQgY2FwYWJpbGl0eSByZWdzICovDQogI2Rl
ZmluZSBCRENfRlNDTk9DCTB4Y2Q0DQogI2RlZmluZSBCRENfRlNDTklDCTB4Y2U0DQotI2RlZmlu
ZSBOVU1fTkNTKHApCShwID4+IDI4KQ0KKyNkZWZpbmUgTlVNX05DUyhwKQkoKHApID4+IDI4KQ0K
IA0KIC8qIFJlZ2lzdGVyIGJpdCBmaWVsZHMgYW5kIE1hc2tzICovDQogLyogQkRDIENvbmZpZ3Vy
YXRpb24gMCAqLw0KICNkZWZpbmUgQkRDX1BHUyhwKQkoKChwKSAmICgweDcgPDwgOCkpID4+IDgp
DQotI2RlZmluZSBCRENfU1BCKHApCShwICYgMHg3KQ0KKyNkZWZpbmUgQkRDX1NQQihwKQkoKHAp
ICYgMHg3KQ0KIA0KIC8qIEJEQyBDYXBhYmlsaXR5MSAqLw0KICNkZWZpbmUgQkRDX1A2NAkJKDEg
PDwgMCkNCkBAIC0xMTMsNyArMTEzLDcgQEANCiAjZGVmaW5lIEJEQ19DTURfRFZDCTB4MQ0KICNk
ZWZpbmUgQkRDX0NNRF9DV1MJCSgweDEgPDwgNSkNCiAjZGVmaW5lIEJEQ19DTURfQ1NUKHApCQko
KChwKSAmICgweGYgPDwgNikpPj42KQ0KLSNkZWZpbmUgQkRDX0NNRF9FUE4ocCkJCSgocCAmIDB4
MWYpIDw8IDEwKQ0KKyNkZWZpbmUgQkRDX0NNRF9FUE4ocCkJCSgoKHApICYgMHgxZikgPDwgMTAp
DQogI2RlZmluZSBCRENfU1VCX0NNRF9BREQJCSgweDEgPDwgMTcpDQogI2RlZmluZSBCRENfU1VC
X0NNRF9GV0sJCSgweDQgPDwgMTcpDQogLyogUmVzZXQgc2VxdWVuY2UgbnVtYmVyICovDQpAQCAt
MTYzLDcgKzE2Myw3IEBADQogI2RlZmluZSBCRENfU1BFRURfSFMJMHgzDQogI2RlZmluZSBCRENf
U1BFRURfU1MJMHg0DQogDQotI2RlZmluZSBCRENfUFNUKHApCShwICYgMHhmKQ0KKyNkZWZpbmUg
QkRDX1BTVChwKQkoKHApICYgMHhmKQ0KICNkZWZpbmUgQkRDX1BTVF9NQVNLCTB4Zg0KIA0KIC8q
IFVTUFBNUyAqLw0KQEAgLTIyOCw3ICsyMjgsNyBAQA0KIC8qIHN0YXR1cyByZXBvcnQgZGVmaW5l
cyAqLw0KICNkZWZpbmUgU1JfWFNGCQkwDQogI2RlZmluZSBTUl9VU1BDCQk0DQotI2RlZmluZSBT
Ul9CRF9MRU4ocCkgICAgKHAgJiAweGZmZmZmZikNCisjZGVmaW5lIFNSX0JEX0xFTihwKSAgICAo
KHApICYgMHhmZmZmZmYpDQogDQogI2RlZmluZSBYU0ZfU1VDQwkweDENCiAjZGVmaW5lIFhTRl9T
SE9SVAkweDMNCi0tIA0KMS45LjENCg==

