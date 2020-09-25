Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6576A278017
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgIYGB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52869 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgIYGB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:26 -0400
X-UUID: 3dffde2c96cc46efb8af3660c358bd1e-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tnTXrW+viUcET7ilMySC0jNd0vhu5XBB0MZp5smjZUo=;
        b=u/IHtzilf8Woc4tmjsedC7idEaWm/mJwddQKsVC0oyJ30BoR4enEw+TU5NcZeeyvKSQezkyzr4UqtL9BraOSEQaHD/lhQeByaAp52ory+zxYcnX9Rf94IO2NnJ4Ao8CwZ8gMGTofWME0nf20KzaZCnm05+Del6Sek3/9gIMublw=;
X-UUID: 3dffde2c96cc46efb8af3660c358bd1e-20200925
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1958158567; Fri, 25 Sep 2020 14:01:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:17 +0800
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
Subject: [PATCH 03/11] usb: gadget: bdc: prefer pointer dereference to pointer type
Date:   Fri, 25 Sep 2020 13:58:11 +0800
Message-ID: <1601013499-28920-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6A5CBFBC10784D0BF179ABE74E3B3DCC5998AE9FCFEF7BBE740656628695DA722000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHJlZmVyIGt6YWxsb2Moc2l6ZW9mKCpiZF90YWJsZSkuLi4pIG92ZXINCmt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCBiZF90YWJsZSkNCg0KQ2hhbmdlLUlkOiBJZjc4Y2M5MjkyODdmYTQ1YTNmOWRlMzhm
MmU3MDU3MzA3Y2QyOTVkZA0KQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwu
Y29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsu
Y29tPg0KQWNrZWQtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0K
LS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgfCAyICstDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYmRjL2JkY19lcC5jDQppbmRleCBmYWZkYzlmLi43NjQ2M2RlIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19lcC5jDQpAQCAtMTQ3LDcgKzE0Nyw3IEBAIHN0YXRpYyBpbnQgZXBfYmRf
bGlzdF9hbGxvYyhzdHJ1Y3QgYmRjX2VwICplcCkNCiAJLyogQWxsb2NhdGUgbWVtb3J5IGZvciBl
YWNoIHRhYmxlICovDQogCWZvciAoaW5kZXggPSAwOyBpbmRleCA8IG51bV90YWJzOyBpbmRleCsr
KSB7DQogCQkvKiBBbGxvY2F0ZSBtZW1vcnkgZm9yIGJkX3RhYmxlIHN0cnVjdHVyZSAqLw0KLQkJ
YmRfdGFibGUgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgYmRfdGFibGUpLCBHRlBfQVRPTUlDKTsN
CisJCWJkX3RhYmxlID0ga3phbGxvYyhzaXplb2YoKmJkX3RhYmxlKSwgR0ZQX0FUT01JQyk7DQog
CQlpZiAoIWJkX3RhYmxlKQ0KIAkJCWdvdG8gZmFpbDsNCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

