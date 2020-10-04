Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B028291C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 07:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgJDFui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 01:50:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39660 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725819AbgJDFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 01:50:38 -0400
X-UUID: 30dced02d66d411b88bb2734d2ad1759-20201004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=R1eNNkVeR51W23UaO/9D2srShKgkSQlKxuAx45eQzEE=;
        b=JN5Kf1it8RML7AQiqpfdrEha/XerUBDXU10DLO5QLjnuIFI1dgNXYK0mdJ6A0HxuKyYYlJ8iEBLZiu533OLJs0x1xpPbXdgqtwEQ5cz3ogNQg1nzjJeHXWEp+3VdkYPUjHK3NenIFk2coA5NgODLgIDbqz4e6HhqoD3B8ybpt8w=;
X-UUID: 30dced02d66d411b88bb2734d2ad1759-20201004
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1485577375; Sun, 04 Oct 2020 13:50:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 4 Oct 2020 13:50:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 4 Oct 2020 13:50:26 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Phil Chang <phil.chang@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>, Joe Liu <joe.liu@mediatek.com>
Subject: [PATCH] [PATCH] of_reserved_mem: Increase the number of reserved regions
Date:   Sun, 4 Oct 2020 13:50:24 +0800
Message-ID: <20201004055024.23542-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2VydGFpbiBTb0NzIG5lZWQgdG8gc3VwcG9ydCBsYXJnZSBhbW91bnQgb2YgcmVzZXJ2ZWQgbWVt
b3J5DQpyZWdpb25zLCBlc3BlY2lhbGx5IHRvIGZvbGxvdyB0aGUgR0tJIHJ1bGVzIGZyb20gR29v
Z2xlLg0KSW4gTVRLIG5ldyBTb0MgcmVxdWlyZXMgbW9yZSB0aGFuIDY4IHJlZ2lvbnMgb2YgcmVz
ZXJ2ZWQgbWVtb3J5DQpmb3IgZWFjaCBJUCdzIHVzYWdlLCBzdWNoIGFzIGxvYWQgZmlybXdhcmUg
dG8gc3BlY2lmaWMgc2FwY2UsDQpzbyB0aGF0IG5lZWQgdG8gcmVzZXJ2ZSBtb3JlIHJlZ2lzaW9u
cyANCg0KU2lnbmVkLW9mZi1ieTogSm9lIExpdSA8am9lLmxpdUBtZWRpYXRlay5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBZSiBDaGlhbmcgPHlqLmNoaWFuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBBbGl4IFd1IDxhbGl4Lnd1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFBoaWwg
Q2hhbmcgPHBoaWwuY2hhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9vZi9vZl9yZXNl
cnZlZF9tZW0uYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvb2Yvb2ZfcmVzZXJ2ZWRfbWVtLmMgYi9k
cml2ZXJzL29mL29mX3Jlc2VydmVkX21lbS5jDQppbmRleCA0NmI5MzcxYzhhMzMuLjU5NWYwNzQx
ZGNlZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvb2Yvb2ZfcmVzZXJ2ZWRfbWVtLmMNCisrKyBiL2Ry
aXZlcnMvb2Yvb2ZfcmVzZXJ2ZWRfbWVtLmMNCkBAIC0yMiw3ICsyMiw3IEBADQogI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvbWVtYmxvY2suaD4NCiANCi0jZGVmaW5l
IE1BWF9SRVNFUlZFRF9SRUdJT05TCTY0DQorI2RlZmluZSBNQVhfUkVTRVJWRURfUkVHSU9OUwkx
MjgNCiBzdGF0aWMgc3RydWN0IHJlc2VydmVkX21lbSByZXNlcnZlZF9tZW1bTUFYX1JFU0VSVkVE
X1JFR0lPTlNdOw0KIHN0YXRpYyBpbnQgcmVzZXJ2ZWRfbWVtX2NvdW50Ow0KIA0KLS0gDQoyLjE4
LjANCg==

