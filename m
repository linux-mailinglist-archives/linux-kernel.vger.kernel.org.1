Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520DC278082
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgIYGX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:23:29 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:36473 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726983AbgIYGX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:23:26 -0400
X-UUID: de0d5c4cef974d8aa19bd1bd1e9c014b-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q0p4czr84XYZ0qBgAfFPrawGlMUYs3mqiKwpRcor5wM=;
        b=bBZxEoQ5ypnPKLP20v21wY0l5mwbQUn9E8+0oefYhnPxeQr3p2Sn6m09vIfEXu72fIJfG1Ik+wxM48Ysq2A+x8es7qriCWBVkb0e0ch5f683P/PHm7NM0p2i5QdiLQLFfAzZfpHgFJFMUUQ//SAq1JJE3GbO4d739QMDt0G5dc8=;
X-UUID: de0d5c4cef974d8aa19bd1bd1e9c014b-20200925
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1790189985; Fri, 25 Sep 2020 14:23:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:23:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:23:18 +0800
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
Subject: [PATCH V3 RESEND 02/11] usb: gadget: bdc: remove bdc_ep_set_halt() declaration
Date:   Fri, 25 Sep 2020 14:20:23 +0800
Message-ID: <1601014832-29726-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C846D79B859D62840C4B78692E850076B64CB80AD808ECE0C848FE0EFDF578552000:8
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

