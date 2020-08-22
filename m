Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191C624E64B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 10:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHVIKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 04:10:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5953 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726817AbgHVIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:22 -0400
X-UUID: 22721569c0e849278fd3493521bcc8b7-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mVw3k7m+HfgDDtgies2lv1Zs9zfJ0QocsJ5+s8RXmlU=;
        b=VXn4nZ4tEqj/7EiscAukcNLqZnzkOK/WqdzwxY6fXPVJvW31b+4XJ80L0EYEdf5ywNgH+IyOuGfJKk6T6JObtnckmRr2dz1eGtRt6MzdqUpqQ3ABEDXM65p57Z/m2E8Kh2/6CPFOoXH2x1XGTEp+qt1YQoY+kIflH7RftZyWn1I=;
X-UUID: 22721569c0e849278fd3493521bcc8b7-20200822
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 73142746; Sat, 22 Aug 2020 16:09:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:11 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3 06/11] usb: fotg210-hcd: convert to readl_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:48 +0800
Message-ID: <1598083553-31896-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FFAB3A675C0FCD41B35C30EDB2E3EF20789DC91B551497B01A4FF75CD3CBAF322000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djM6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYyB8
IDIwICsrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcy
MTAtaGNkLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCmluZGV4IDE5NGRmODIu
LjFkOTRmY2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2ZvdGcyMTAtaGNkLmMNCisr
KyBiL2RyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYw0KQEAgLTMyLDYgKzMyLDcgQEANCiAj
aW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+
DQogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KIA0KICNpbmNsdWRlIDxhc20vYnl0ZW9yZGVyLmg+
DQpAQCAtODgzLDE4ICs4ODQsMTUgQEAgc3RhdGljIGludCBoYW5kc2hha2Uoc3RydWN0IGZvdGcy
MTBfaGNkICpmb3RnMjEwLCB2b2lkIF9faW9tZW0gKnB0ciwNCiAJCXUzMiBtYXNrLCB1MzIgZG9u
ZSwgaW50IHVzZWMpDQogew0KIAl1MzIgcmVzdWx0Ow0KKwlpbnQgcmV0Ow0KIA0KLQlkbyB7DQot
CQlyZXN1bHQgPSBmb3RnMjEwX3JlYWRsKGZvdGcyMTAsIHB0cik7DQotCQlpZiAocmVzdWx0ID09
IH4odTMyKTApCQkvKiBjYXJkIHJlbW92ZWQgKi8NCi0JCQlyZXR1cm4gLUVOT0RFVjsNCi0JCXJl
c3VsdCAmPSBtYXNrOw0KLQkJaWYgKHJlc3VsdCA9PSBkb25lKQ0KLQkJCXJldHVybiAwOw0KLQkJ
dWRlbGF5KDEpOw0KLQkJdXNlYy0tOw0KLQl9IHdoaWxlICh1c2VjID4gMCk7DQotCXJldHVybiAt
RVRJTUVET1VUOw0KKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHB0ciwgcmVzdWx0
LA0KKwkJCQkJKChyZXN1bHQgJiBtYXNrKSA9PSBkb25lIHx8DQorCQkJCQkgcmVzdWx0ID09IFUz
Ml9NQVgpLCAxLCB1c2VjKTsNCisJaWYgKHJlc3VsdCA9PSBVMzJfTUFYKQkJLyogY2FyZCByZW1v
dmVkICovDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyog
Rm9yY2UgSEMgdG8gaGFsdCBzdGF0ZSBmcm9tIHVua25vd24gKEVIQ0kgc3BlYyBzZWN0aW9uIDIu
MykuDQotLSANCjEuOS4xDQo=

