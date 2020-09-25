Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB027808E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgIYGXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:23:45 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:49207 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727200AbgIYGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:23:41 -0400
X-UUID: 9fd2140d1a0e4c5786e24fbcde55c2a1-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7kJllcDXjClhWfBJ3mveoC+PnCLMneF842iGb2qp2Wo=;
        b=RkSiMGBX2JftCI8gLBDlAlTFkmbaemGiBmqEMgV84SuWRZV3PdMznBcaMcFaIbDjbmZyfLUiG+YiDu/S7cLgHFXm482Lv60BNoAL9ktyOOz+8I0hD+ziFGMYoI+KoFugGOnhHXqwRaN+rGSOU+opkX7YgnDmITsWN4809t7aFCM=;
X-UUID: 9fd2140d1a0e4c5786e24fbcde55c2a1-20200925
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 427782146; Fri, 25 Sep 2020 14:23:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:23:30 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:23:30 +0800
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
Subject: [PATCH V3 RESEND 11/11] usb: gadget: bdc: fix checkpatch.pl repeated word warning
Date:   Fri, 25 Sep 2020 14:20:32 +0800
Message-ID: <1601014832-29726-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601014832-29726-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BE62818FB4E605FD9C3A8676AF50F1D181E46D70F0AC87F4CC131114666E62EA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KV0FSTklORzpSRVBFQVRFRF9XT1JEOiBQb3NzaWJsZSByZXBlYXRl
ZCB3b3JkOiAnYW5kJw0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQot
LS0NCnYzOiBhZGQgYWNrZWQtYnkgRmxvcmlhbg0KDQp2MjogYWRkIENjIEZsb3JpYW4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfZXAuYw0KaW5kZXggZDIyN2QyNi4uOGUyZjIwYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZXAuYw0KQEAgLTE0MDUsNyArMTQwNSw3IEBAIHN0YXRpYyBpbnQgZXAwX3NldF9z
ZWwoc3RydWN0IGJkYyAqYmRjLA0KIH0NCiANCiAvKg0KLSAqIFF1ZXVlIGEgMCBieXRlIGJkIG9u
bHkgaWYgd0xlbmd0aCBpcyBtb3JlIHRoYW4gdGhlIGxlbmd0aCBhbmQgYW5kIGxlbmd0aCBpcw0K
KyAqIFF1ZXVlIGEgMCBieXRlIGJkIG9ubHkgaWYgd0xlbmd0aCBpcyBtb3JlIHRoYW4gdGhlIGxl
bmd0aCBhbmQgbGVuZ3RoIGlzDQogICogYSBtdWx0aXBsZSBvZiBNYXhQYWNrZXQgdGhlbiBxdWV1
ZSAwIGJ5dGUgQkQNCiAgKi8NCiBzdGF0aWMgaW50IGVwMF9xdWV1ZV96bHAoc3RydWN0IGJkYyAq
YmRjKQ0KLS0gDQoxLjkuMQ0K

