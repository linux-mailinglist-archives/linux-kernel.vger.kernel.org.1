Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCCC271ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIUGRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:22 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6170 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbgIUGRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:11 -0400
X-UUID: 33aa4d5624de4657a8d0625bdefb4ac1-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=03QgLwsgOisVZbDGtPu7Lgll5Hbd3GQyWS3uWvzNTQ0=;
        b=ftScSwB5IevXsojNb5+KzWkvK0BxLBFxuN1gka1qezFAwetWLA4uK2/tdsNboz2HrMY2jXa4XY41FMp5rktbkvxzkApgXaEp19uPNPQz9fez4viXZ5yyechPmnHEtjKdgPlDQ2mudjethQATl+IIJuDX+QXHsEefeK5vQemPGXA=;
X-UUID: 33aa4d5624de4657a8d0625bdefb4ac1-20200921
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 625568464; Mon, 21 Sep 2020 14:17:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:06 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:17:04 +0800
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
Subject: [PATCH v4 07/11] usb: isp1760-hcd: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:31 +0800
Message-ID: <1600668815-12135-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7DBBB53265D7247BC7A4B0C82379CA3038943C4CC4771CF8CE69B2F2BB86AEE32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djQ6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2lzcDE3NjAvaXNwMTc2MC1oY2Qu
YyB8IDIwICsrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9pc3AxNzYw
L2lzcDE3NjAtaGNkLmMgYi9kcml2ZXJzL3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCmluZGV4
IGRkNzRhYjdhLi4zM2FlNjU2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaXNwMTc2MC9pc3Ax
NzYwLWhjZC5jDQorKysgYi9kcml2ZXJzL3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCkBAIC0y
Miw2ICsyMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvdWFjY2Vzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9p
b3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgvbW0uaD4NCiAjaW5jbHVkZSA8bGludXgvdGltZXIu
aD4NCiAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KQEAgLTM4MCwxOCArMzgxLDE1IEBAIHN0
YXRpYyBpbnQgaGFuZHNoYWtlKHN0cnVjdCB1c2JfaGNkICpoY2QsIHUzMiByZWcsDQogCQkgICAg
ICB1MzIgbWFzaywgdTMyIGRvbmUsIGludCB1c2VjKQ0KIHsNCiAJdTMyIHJlc3VsdDsNCisJaW50
IHJldDsNCisNCisJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhoY2QtPnJlZ3MgKyBy
ZWcsIHJlc3VsdCwNCisJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJl
c3VsdCA9PSBVMzJfTUFYKSwgMSwgdXNlYyk7DQorCWlmIChyZXN1bHQgPT0gVTMyX01BWCkNCisJ
CXJldHVybiAtRU5PREVWOw0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWdfcmVhZDMyKGhjZC0+
cmVncywgcmVnKTsNCi0JCWlmIChyZXN1bHQgPT0gfjApDQotCQkJcmV0dXJuIC1FTk9ERVY7DQot
CQlyZXN1bHQgJj0gbWFzazsNCi0JCWlmIChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsN
Ci0JCXVkZWxheSgxKTsNCi0JCXVzZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1
cm4gLUVUSU1FRE9VVDsNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyogcmVzZXQgYSBub24tcnVu
bmluZyAoU1RTX0hBTFQgPT0gMSkgY29udHJvbGxlciAqLw0KLS0gDQoxLjkuMQ0K

