Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D563A278018
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgIYGB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:9247 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbgIYGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:27 -0400
X-UUID: 2f3fc8d007ca4b8a84f51726b5cc0ac0-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/kONCJJ8aVnXmYA03TO5LSP2R7Z9rLaJR2FAZttJ864=;
        b=GqiZ4UBquNs5ybjshWHwF5BxBwDUsNGWAR4nb1UrBVLKeWvNovjGwH9zQTliTaoQl2Z52dW3vlkFxZZgWqUx+Ou/nChUDRcB9cFzol/QdHUMtwfY4X96ubp35u+AB9qIjSKxp5Oc7Hf0FcLtuUtjRVQUwt3/tstXTrJrWP048iU=;
X-UUID: 2f3fc8d007ca4b8a84f51726b5cc0ac0-20200925
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 917380502; Fri, 25 Sep 2020 14:01:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:16 +0800
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
Subject: [PATCH 02/11] usb: gadget: bdc: remove bdc_ep_set_halt() declaration
Date:   Fri, 25 Sep 2020 13:58:10 +0800
Message-ID: <1601013499-28920-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2FE7C5F0EF1F1CCE5A76AF90EE3C8403C9DD61C62CCE5E3420B3A5B0B0E7225F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8gZGVmaW5pdGlvbiBmb3IgYmRjX2VwX3NldF9oYWx0KCksIHNvIHJlbW92ZSBpdC4NCg0KQ2hh
bmdlLUlkOiBJYWFhODM3YTI3Njg4Y2E0NGI3YjM2MWIwZTEyMjZkMmQ0YWU0MDU3ZA0KQ2M6IEZs
b3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1
bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IEZsb3JpYW4g
RmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2NtZC5oIHwgMSAtDQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaCBiL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaA0KaW5kZXggMzczZTY3NC4uYTNhNmRi
ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaA0KKysr
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oDQpAQCAtMTYsNyArMTYsNiBA
QA0KIGludCBiZGNfc3RvcF9lcChzdHJ1Y3QgYmRjICosIGludCk7DQogaW50IGJkY19lcF9zZXRf
c3RhbGwoc3RydWN0IGJkYyAqLCBpbnQpOw0KIGludCBiZGNfZXBfY2xlYXJfc3RhbGwoc3RydWN0
IGJkYyAqLCBpbnQpOw0KLWludCBiZGNfZXBfc2V0X2hhbHQoc3RydWN0IGJkY19lcCAqLCB1MzIg
LCBpbnQpOw0KIGludCBiZGNfZXBfYmxhKHN0cnVjdCBiZGMgKiwgc3RydWN0IGJkY19lcCAqLCBk
bWFfYWRkcl90KTsNCiBpbnQgYmRjX2Z1bmN0aW9uX3dha2Uoc3RydWN0IGJkYyosIHU4KTsNCiBp
bnQgYmRjX2Z1bmN0aW9uX3dha2VfZmgoc3RydWN0IGJkYyosIHU4KTsNCi0tIA0KMS44LjEuMS5k
aXJ0eQ0K

