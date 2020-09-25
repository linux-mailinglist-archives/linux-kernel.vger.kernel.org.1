Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45927801C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgIYGBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:35 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:59384 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727184AbgIYGBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:32 -0400
X-UUID: 0c263731fde049f78e710caa55cf0bc5-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ioBc3o5u8lTTE+lzbNK4VQGtM2z5ZV87TWFA/gqKwdY=;
        b=JSOG9K5qtpezvCFRfq+VoMaPEYvvUAtTU8B5Vl6ebDtnetXNalh8afK7nQLV/H9FkzQqYMzMq5ddMNSXBWNOR3LNACZBFLEs5EAXYUgneMuTcfqoMfrINM5GPbe6g9ZwbkEDhRnAkiGeGjrwzqZzw1nALmFwcbEiaWFbZtCoNeg=;
X-UUID: 0c263731fde049f78e710caa55cf0bc5-20200925
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 302478163; Fri, 25 Sep 2020 14:01:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:23 +0800
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
Subject: [PATCH 07/11] usb: gadget: bdc: avoid precedence issues
Date:   Fri, 25 Sep 2020 13:58:15 +0800
Message-ID: <1601013499-28920-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 368363B06B99BFA69F05A14122C60D8989D5940629090D5A678AFDA6B744E46A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICgpIGFyb3VuZCBtYWNybyBhcmd1bWVudCB0byBhdm9pZCBwcmVjZWRlbmNlIGlzc3Vlcw0K
DQpDaGFuZ2UtSWQ6IEkwMzZhMjhlYjk0Zjk3ZDk1NTAxNWQ1ZjU4YTE2OGJmNjZiZGVjZjQzDQpD
YzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogRmxv
cmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGMuaCB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaCBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRj
L2JkYy5oDQppbmRleCA2NThhYmVmLi5mOGQ1OTU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2Jk
Yy5oDQpAQCAtODYsMjAgKzg2LDIwIEBADQogI2RlZmluZSBCRENfRVBTVFM1CTB4NzQNCiAjZGVm
aW5lIEJEQ19FUFNUUzYJMHg3OA0KICNkZWZpbmUgQkRDX0VQU1RTNwkweDdjDQotI2RlZmluZSBC
RENfU1JSQkFMKG4pCSgweDIwMCArIChuICogMHgxMCkpDQotI2RlZmluZSBCRENfU1JSQkFIKG4p
CSgweDIwNCArIChuICogMHgxMCkpDQotI2RlZmluZSBCRENfU1JSSU5UKG4pCSgweDIwOCArIChu
ICogMHgxMCkpDQotI2RlZmluZSBCRENfSU5UQ1RMUyhuKQkoMHgyMGMgKyAobiAqIDB4MTApKQ0K
KyNkZWZpbmUgQkRDX1NSUkJBTChuKQkoMHgyMDAgKyAoKG4pICogMHgxMCkpDQorI2RlZmluZSBC
RENfU1JSQkFIKG4pCSgweDIwNCArICgobikgKiAweDEwKSkNCisjZGVmaW5lIEJEQ19TUlJJTlQo
bikJKDB4MjA4ICsgKChuKSAqIDB4MTApKQ0KKyNkZWZpbmUgQkRDX0lOVENUTFMobikJKDB4MjBj
ICsgKChuKSAqIDB4MTApKQ0KIA0KIC8qIEV4dGVuZGVkIGNhcGFiaWxpdHkgcmVncyAqLw0KICNk
ZWZpbmUgQkRDX0ZTQ05PQwkweGNkNA0KICNkZWZpbmUgQkRDX0ZTQ05JQwkweGNlNA0KLSNkZWZp
bmUgTlVNX05DUyhwKQkocCA+PiAyOCkNCisjZGVmaW5lIE5VTV9OQ1MocCkJKChwKSA+PiAyOCkN
CiANCiAvKiBSZWdpc3RlciBiaXQgZmllbGRzIGFuZCBNYXNrcyAqLw0KIC8qIEJEQyBDb25maWd1
cmF0aW9uIDAgKi8NCiAjZGVmaW5lIEJEQ19QR1MocCkJKCgocCkgJiAoMHg3IDw8IDgpKSA+PiA4
KQ0KLSNkZWZpbmUgQkRDX1NQQihwKQkocCAmIDB4NykNCisjZGVmaW5lIEJEQ19TUEIocCkJKChw
KSAmIDB4NykNCiANCiAvKiBCREMgQ2FwYWJpbGl0eTEgKi8NCiAjZGVmaW5lIEJEQ19QNjQJCSgx
IDw8IDApDQpAQCAtMTEzLDcgKzExMyw3IEBADQogI2RlZmluZSBCRENfQ01EX0RWQwkweDENCiAj
ZGVmaW5lIEJEQ19DTURfQ1dTCQkoMHgxIDw8IDUpDQogI2RlZmluZSBCRENfQ01EX0NTVChwKQkJ
KCgocCkgJiAoMHhmIDw8IDYpKT4+NikNCi0jZGVmaW5lIEJEQ19DTURfRVBOKHApCQkoKHAgJiAw
eDFmKSA8PCAxMCkNCisjZGVmaW5lIEJEQ19DTURfRVBOKHApCQkoKChwKSAmIDB4MWYpIDw8IDEw
KQ0KICNkZWZpbmUgQkRDX1NVQl9DTURfQURECQkoMHgxIDw8IDE3KQ0KICNkZWZpbmUgQkRDX1NV
Ql9DTURfRldLCQkoMHg0IDw8IDE3KQ0KIC8qIFJlc2V0IHNlcXVlbmNlIG51bWJlciAqLw0KQEAg
LTE2Myw3ICsxNjMsNyBAQA0KICNkZWZpbmUgQkRDX1NQRUVEX0hTCTB4Mw0KICNkZWZpbmUgQkRD
X1NQRUVEX1NTCTB4NA0KIA0KLSNkZWZpbmUgQkRDX1BTVChwKQkocCAmIDB4ZikNCisjZGVmaW5l
IEJEQ19QU1QocCkJKChwKSAmIDB4ZikNCiAjZGVmaW5lIEJEQ19QU1RfTUFTSwkweGYNCiANCiAv
KiBVU1BQTVMgKi8NCkBAIC0yMjgsNyArMjI4LDcgQEANCiAvKiBzdGF0dXMgcmVwb3J0IGRlZmlu
ZXMgKi8NCiAjZGVmaW5lIFNSX1hTRgkJMA0KICNkZWZpbmUgU1JfVVNQQwkJNA0KLSNkZWZpbmUg
U1JfQkRfTEVOKHApICAgIChwICYgMHhmZmZmZmYpDQorI2RlZmluZSBTUl9CRF9MRU4ocCkgICAg
KChwKSAmIDB4ZmZmZmZmKQ0KIA0KICNkZWZpbmUgWFNGX1NVQ0MJMHgxDQogI2RlZmluZSBYU0Zf
U0hPUlQJMHgzDQotLSANCjEuOC4xLjEuZGlydHkNCg==

