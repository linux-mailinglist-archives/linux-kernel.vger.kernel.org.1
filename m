Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCFD28B21D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgJLKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:21:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34081 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgJLKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:21:15 -0400
X-UUID: 722f8c1187c74785bba0a5e09f268b67-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sV7v6zcBR17fd0+AW0xQOpWr/elRpG4GNvg37vzsCsg=;
        b=CoPRnWTpTkGDwcsJ3xupDsz2ATlpeXOHy5wk+g4WHCiCinJziwDtJgHGPEMCoU/LXJPXJe8JN1YVXMBbqev4IR2JL/LsRZTl1gUjcrIYR+nL0pxz/IFOp91YYEr9e7s+Ycp9pw+Tyze5Tff9O/Q8yGG3gf6uwbG7vovbFL3JhF4=;
X-UUID: 722f8c1187c74785bba0a5e09f268b67-20201012
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 104157862; Mon, 12 Oct 2020 18:21:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 18:20:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 18:20:58 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <marc.zyngier@arm.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        <wc.shih@mediatek.com>, <alix.wu@mediatek.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH] irqchip/irq-mst-intc: Declare mst_intc_of_init static
Date:   Mon, 12 Oct 2020 18:20:56 +0800
Message-ID: <20201012102056.4156-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bXN0X2ludGNfb2ZfaW5pdCBpcyBub3QgaW50ZW5kZWQgdG8gYmUgdXNlZCBvdXNpZGUgb2YgaXJx
LW1zdC1pbnRjLmMsDQpkZWNsYXJlIGl0IHN0YXRpYy4NCg0KUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogTWFyay1QSyBUc2FpIDxt
YXJrLXBrLnRzYWlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pcnFjaGlwL2lycS1tc3Qt
aW50Yy5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1tc3QtaW50Yy5jIGIvZHJp
dmVycy9pcnFjaGlwL2lycS1tc3QtaW50Yy5jDQppbmRleCA0YmUwNzc1OTE4OTguLmNmNmRlMDRh
NzNiNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtbXN0LWludGMuYw0KKysrIGIv
ZHJpdmVycy9pcnFjaGlwL2lycS1tc3QtaW50Yy5jDQpAQCAtMTU0LDcgKzE1NCw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgaXJxX2RvbWFpbl9vcHMgbXN0X2ludGNfZG9tYWluX29wcyA9IHsNCiAJ
LmZyZWUJCT0gaXJxX2RvbWFpbl9mcmVlX2lycXNfY29tbW9uLA0KIH07DQogDQotaW50IF9faW5p
dA0KK3N0YXRpYyBpbnQgX19pbml0DQogbXN0X2ludGNfb2ZfaW5pdChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKmRuLCBzdHJ1Y3QgZGV2aWNlX25vZGUgKnBhcmVudCkNCiB7DQogCXN0cnVjdCBpcnFfZG9t
YWluICpkb21haW4sICpkb21haW5fcGFyZW50Ow0KLS0gDQoyLjE4LjANCg==

