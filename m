Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C410271AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIUGRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:37 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:37159 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbgIUGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:22 -0400
X-UUID: 847c506cef2040d1ac54569fed59b031-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6qZ3MFCp67LQIehQWoxsg/JhWq3n6ohpU0YiOM2IRh4=;
        b=EEQXTdPab/7sy/TBuVvayjO/SjldcuWGvOAXt1oxM8Dn2WfqdG4PHT6vemaX2A+svzCkDhoZhrrPjBQzLYbxPSK7Welhl8fNtwlO1HLqYsvhNziPihxNTji+Q6O3z3z+vY49bmfmt7AaQpQYAlw46eEP47+9tnA/TZ/w4jWrb1s=;
X-UUID: 847c506cef2040d1ac54569fed59b031-20200921
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 937722441; Mon, 21 Sep 2020 14:17:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:14 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:17:12 +0800
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 11/11] iopoll: update kerneldoc of read_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:35 +0800
Message-ID: <1600668815-12135-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 12B795415FC0ED3118BA475BA2E81ADE4E49B603F95922E5AACB3B2F03B46E0A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXJndW1lbnRzIGRlc2NyaXB0aW9uIG9mIHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIGlzIG91
dCBvZiBkYXRlLA0KdXBkYXRlIGl0Lg0KDQpDYzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5o
YXJ2YXJkLmVkdT4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KdjQ6IG5vIGNoYW5nZXMNCg0KdjM6IGZpeCB0eXBvIGluIGNvbW1p
dCBtZXNzYWdlIHN1Z2dlc3RlZCBieSBTZXJnZWkNCg0KdjI6IG5ldyBwYXRjaCwgc3VnZ2VzdGVk
IGJ5IEFsYW4NCi0tLQ0KIGluY2x1ZGUvbGludXgvaW9wb2xsLmggfCA0ICsrLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9pb3BvbGwuaCBiL2luY2x1ZGUvbGludXgvaW9wb2xsLmgNCmluZGV4IGJj
ODlhYzYuLjJjODg2MGUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2lvcG9sbC5oDQorKysg
Yi9pbmNsdWRlL2xpbnV4L2lvcG9sbC5oDQpAQCAtNjAsOCArNjAsNyBAQA0KIC8qKg0KICAqIHJl
YWRfcG9sbF90aW1lb3V0X2F0b21pYyAtIFBlcmlvZGljYWxseSBwb2xsIGFuIGFkZHJlc3MgdW50
aWwgYSBjb25kaXRpb24gaXMNCiAgKiAJCQkJbWV0IG9yIGEgdGltZW91dCBvY2N1cnMNCi0gKiBA
b3A6IGFjY2Vzc29yIGZ1bmN0aW9uICh0YWtlcyBAYWRkciBhcyBpdHMgb25seSBhcmd1bWVudCkN
Ci0gKiBAYWRkcjogQWRkcmVzcyB0byBwb2xsDQorICogQG9wOiBhY2Nlc3NvciBmdW5jdGlvbiAo
dGFrZXMgQGFyZ3MgYXMgaXRzIGFyZ3VtZW50cykNCiAgKiBAdmFsOiBWYXJpYWJsZSB0byByZWFk
IHRoZSB2YWx1ZSBpbnRvDQogICogQGNvbmQ6IEJyZWFrIGNvbmRpdGlvbiAodXN1YWxseSBpbnZv
bHZpbmcgQHZhbCkNCiAgKiBAZGVsYXlfdXM6IFRpbWUgdG8gdWRlbGF5IGJldHdlZW4gcmVhZHMg
aW4gdXMgKDAgdGlnaHQtbG9vcHMpLiAgU2hvdWxkDQpAQCAtNjksNiArNjgsNyBAQA0KICAqICAg
ICAgICAgICAgRG9jdW1lbnRhdGlvbi90aW1lcnMvdGltZXJzLWhvd3RvLnJzdCkuDQogICogQHRp
bWVvdXRfdXM6IFRpbWVvdXQgaW4gdXMsIDAgbWVhbnMgbmV2ZXIgdGltZW91dA0KICAqIEBkZWxh
eV9iZWZvcmVfcmVhZDogaWYgaXQgaXMgdHJ1ZSwgZGVsYXkgQGRlbGF5X3VzIGJlZm9yZSByZWFk
Lg0KKyAqIEBhcmdzOiBhcmd1bWVudHMgZm9yIEBvcCBwb2xsDQogICoNCiAgKiBSZXR1cm5zIDAg
b24gc3VjY2VzcyBhbmQgLUVUSU1FRE9VVCB1cG9uIGEgdGltZW91dC4gSW4gZWl0aGVyDQogICog
Y2FzZSwgdGhlIGxhc3QgcmVhZCB2YWx1ZSBhdCBAYXJncyBpcyBzdG9yZWQgaW4gQHZhbC4NCi0t
IA0KMS45LjENCg==

