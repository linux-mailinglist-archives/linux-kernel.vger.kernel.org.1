Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC35224E63F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHVIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 04:09:35 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:36496 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727008AbgHVIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:27 -0400
X-UUID: 97798217ae4b435ab16de9eda914188a-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1f1GqktsmoCBBHY58Mnms9zF6E9zoWUyHkZ1qxBjj5A=;
        b=bTS+Qnr4b3tPMI41AdLVavYNePWv0WlNLuMWx31i5DZtW3XiQ9GPonkNfsG/s95mgvtnjGaP8lJc4OGI0amImT/WmbAQRilppyQRtpeJVHKdETZUMr4ETxqCUyjNrULgfsCYmk+SKnLA6Ek/r/1mVys5cpcqVK3+sh+H3ZO/PV0=;
X-UUID: 97798217ae4b435ab16de9eda914188a-20200822
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 78470259; Sat, 22 Aug 2020 16:09:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 11/11] iopoll: update kerneldoc of read_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:53 +0800
Message-ID: <1598083553-31896-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 08DE332221603EEB4127FB0BA2C940C91FF642440EAC2E2737773133EF96AEEA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXJndW1lbnRzIGRlc2NyaXB0aW9uIG9mIHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIGlzIG91
dCBvZiBkYXRlLA0KdXBkYXRlIGl0Lg0KDQpDYzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5o
YXJ2YXJkLmVkdT4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KdjM6IGZpeCB0eXBvIGluIGNvbW1pdCBtZXNzYWdlIHN1Z2dlc3Rl
ZCBieSBTZXJnZWkNCg0KdjI6IG5ldyBwYXRjaCwgc3VnZ2VzdGVkIGJ5IEFsYW4NCi0tLQ0KIGlu
Y2x1ZGUvbGludXgvaW9wb2xsLmggfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb3Bv
bGwuaCBiL2luY2x1ZGUvbGludXgvaW9wb2xsLmgNCmluZGV4IGJjODlhYzYuLjJjODg2MGUgMTAw
NjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2lvcG9sbC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L2lv
cG9sbC5oDQpAQCAtNjAsOCArNjAsNyBAQA0KIC8qKg0KICAqIHJlYWRfcG9sbF90aW1lb3V0X2F0
b21pYyAtIFBlcmlvZGljYWxseSBwb2xsIGFuIGFkZHJlc3MgdW50aWwgYSBjb25kaXRpb24gaXMN
CiAgKiAJCQkJbWV0IG9yIGEgdGltZW91dCBvY2N1cnMNCi0gKiBAb3A6IGFjY2Vzc29yIGZ1bmN0
aW9uICh0YWtlcyBAYWRkciBhcyBpdHMgb25seSBhcmd1bWVudCkNCi0gKiBAYWRkcjogQWRkcmVz
cyB0byBwb2xsDQorICogQG9wOiBhY2Nlc3NvciBmdW5jdGlvbiAodGFrZXMgQGFyZ3MgYXMgaXRz
IGFyZ3VtZW50cykNCiAgKiBAdmFsOiBWYXJpYWJsZSB0byByZWFkIHRoZSB2YWx1ZSBpbnRvDQog
ICogQGNvbmQ6IEJyZWFrIGNvbmRpdGlvbiAodXN1YWxseSBpbnZvbHZpbmcgQHZhbCkNCiAgKiBA
ZGVsYXlfdXM6IFRpbWUgdG8gdWRlbGF5IGJldHdlZW4gcmVhZHMgaW4gdXMgKDAgdGlnaHQtbG9v
cHMpLiAgU2hvdWxkDQpAQCAtNjksNiArNjgsNyBAQA0KICAqICAgICAgICAgICAgRG9jdW1lbnRh
dGlvbi90aW1lcnMvdGltZXJzLWhvd3RvLnJzdCkuDQogICogQHRpbWVvdXRfdXM6IFRpbWVvdXQg
aW4gdXMsIDAgbWVhbnMgbmV2ZXIgdGltZW91dA0KICAqIEBkZWxheV9iZWZvcmVfcmVhZDogaWYg
aXQgaXMgdHJ1ZSwgZGVsYXkgQGRlbGF5X3VzIGJlZm9yZSByZWFkLg0KKyAqIEBhcmdzOiBhcmd1
bWVudHMgZm9yIEBvcCBwb2xsDQogICoNCiAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBhbmQgLUVU
SU1FRE9VVCB1cG9uIGEgdGltZW91dC4gSW4gZWl0aGVyDQogICogY2FzZSwgdGhlIGxhc3QgcmVh
ZCB2YWx1ZSBhdCBAYXJncyBpcyBzdG9yZWQgaW4gQHZhbC4NCi0tIA0KMS45LjENCg==

