Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3A278031
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgIYGE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:04:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40125 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgIYGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:04:27 -0400
X-UUID: 645ed6c16f7049b8bff5dc79f51475a0-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Q0p4czr84XYZ0qBgAfFPrawGlMUYs3mqiKwpRcor5wM=;
        b=Wz3Yr2L6/oOCmNeuSjxpeDnSf1FHCCVJbRIYKtx44xs0RkXD8OilkGPSdEgfFcMuMySTco2FrKk6khz0+aXOkqG7KP32OCX5GJ59VhsvekBd7dhsH8O4KrDyaMxQiZYRto/oCVqh5PKIfqaPDUNwpjab7F3/uFQUsWBkmmTiwes=;
X-UUID: 645ed6c16f7049b8bff5dc79f51475a0-20200925
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1687986663; Fri, 25 Sep 2020 14:04:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:04:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:04:20 +0800
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
Subject: [PATCH RESEND v3 02/11] usb: gadget: bdc: remove bdc_ep_set_halt() declaration
Date:   Fri, 25 Sep 2020 14:01:33 +0800
Message-ID: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 97EEC91D1BE4E3316D061B25EC8B18CCBF6A5A6F1BFA1661291214CC41FB0B822000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8gZGVmaW5pdGlvbiBmb3IgYmRjX2VwX3NldF9oYWx0KCksIHNvIHJlbW92ZSBpdC4NCg0KQ2M6
IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IEZsb3Jp
YW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KLS0tDQp2MzogYWRkIGFja2VkLWJ5
IEZsb3JpYW4NCg0KdjI6IGFkZCBDYyBGbG9yaWFuDQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfY21kLmggfCAxIC0NCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oIGIvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oDQppbmRleCAzNzNlNjc0Li5hM2E2ZGJk
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oDQorKysg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCkBAIC0xNiw3ICsxNiw2IEBA
DQogaW50IGJkY19zdG9wX2VwKHN0cnVjdCBiZGMgKiwgaW50KTsNCiBpbnQgYmRjX2VwX3NldF9z
dGFsbChzdHJ1Y3QgYmRjICosIGludCk7DQogaW50IGJkY19lcF9jbGVhcl9zdGFsbChzdHJ1Y3Qg
YmRjICosIGludCk7DQotaW50IGJkY19lcF9zZXRfaGFsdChzdHJ1Y3QgYmRjX2VwICosIHUzMiAs
IGludCk7DQogaW50IGJkY19lcF9ibGEoc3RydWN0IGJkYyAqLCBzdHJ1Y3QgYmRjX2VwICosIGRt
YV9hZGRyX3QpOw0KIGludCBiZGNfZnVuY3Rpb25fd2FrZShzdHJ1Y3QgYmRjKiwgdTgpOw0KIGlu
dCBiZGNfZnVuY3Rpb25fd2FrZV9maChzdHJ1Y3QgYmRjKiwgdTgpOw0KLS0gDQoxLjkuMQ0K

