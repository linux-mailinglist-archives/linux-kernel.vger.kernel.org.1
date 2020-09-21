Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB27271ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIUGRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:24 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:42163 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgIUGRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:11 -0400
X-UUID: 7d6a59728f09409a9bd29d77974c7ab0-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eXo3ZNdSOv7o75Rg1veepw4qxn8TsYpXE6uoKVo5ls8=;
        b=gotV4TnDTm2El8gyBVp2VKdGqYhNmg/KAAIK7J0HG87g61RmpIaxUxGvHbuJcd9HCyVzbxTYjftHmlzaBES1dbTpRUvqzx62wG7ckhxZNOto0iTHo1F+UeGCTbHFdM3TLJGWOJHyVVUGVsN6Bddfxwa6nTuBJVg424bgEzTf46w=;
X-UUID: 7d6a59728f09409a9bd29d77974c7ab0-20200921
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2029283798; Mon, 21 Sep 2020 14:17:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:05 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:17:03 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Jann Horn <jannh@google.com>,
        Jason Yan <yanaijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v4 06/11] usb: fotg210-hcd: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:30 +0800
Message-ID: <1600668815-12135-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CE95345C94FC4573D10D501B0ECEFF2EE20D259A0C306BD28181E09C342AD6FE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djQ6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvZm90ZzIxMC1oY2QuYyB8
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

