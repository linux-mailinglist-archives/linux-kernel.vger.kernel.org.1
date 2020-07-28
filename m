Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F323077B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgG1KQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 06:16:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19703 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728623AbgG1KQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:16:23 -0400
X-UUID: 5365a2184f45496fa0f507ed69ced540-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+b+gg37ADEMMgnGEo469POvk0qcXvqRgsDtfenL9vqg=;
        b=MU8T8AEVLGWGGFNQVgsgDIMZ22GW7lBJ9Gw0E3bObXqBUVKoHyQbH1lroaqhRcTm4MdzOQJOEDcXVoiLD+sXuAfmDB5DziYqWT1je2txDMCrB8hMXykXlZOelT1tIdwEp8pfaH+vpTJuy0j5lLyvtUhpBgml3dX+LU5OD8ZgRJA=;
X-UUID: 5365a2184f45496fa0f507ed69ced540-20200728
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 568498662; Tue, 28 Jul 2020 18:16:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 18:16:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 18:16:19 +0800
From:   Freddy Hsin <freddy.hsin@mediatek.com>
To:     <linux-mediatek@lists.infradead.or>,
        <linux-arm-kernel@lists.infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Saravana Kannan <saravanak@google.com>,
        <linux-kernel@vger.kernel.org>, <chang-an.chen@mediatek.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        <wsd_upstream@mediatek.com>, <kuohong.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, Freddy Hsin <freddy.hsin@mediatek.com>
Subject: [PATCH v1 1/2] kernel: time: export sched_clock_register function
Date:   Tue, 28 Jul 2020 18:16:16 +0800
Message-ID: <1595931377-21627-2-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com>
References: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZXhwb3J0IHNjaGVkX2Nsb2NrX3JlZ2lzdGVyIGZ1bmN0aW9uLCBiZWNhdXNlIHRoZSBNZWRpYXRl
ayB0aW1lcg0KbG9hZGFibGUgbW9kdWxlIGRlcGVuZHMgb24gdGhpcyBmdW5jdGlvbg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBGcmVkZHkgSHNpbiA8ZnJlZGR5LmhzaW5AbWVkaWF0ZWsuY29tPg0KLS0tDQog
a2VybmVsL3RpbWUvc2NoZWRfY2xvY2suYyB8ICAgIDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL3RpbWUvc2NoZWRfY2xvY2suYyBiL2tl
cm5lbC90aW1lL3NjaGVkX2Nsb2NrLmMNCmluZGV4IGZhM2Y4MDAuLmUxZDVhZmUgMTAwNjQ0DQot
LS0gYS9rZXJuZWwvdGltZS9zY2hlZF9jbG9jay5jDQorKysgYi9rZXJuZWwvdGltZS9zY2hlZF9j
bG9jay5jDQpAQCAtMjM5LDYgKzIzOSw3IEBAIHN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFydCBz
Y2hlZF9jbG9ja19wb2xsKHN0cnVjdCBocnRpbWVyICpocnQpDQogDQogCXByX2RlYnVnKCJSZWdp
c3RlcmVkICVwUyBhcyBzY2hlZF9jbG9jayBzb3VyY2VcbiIsIHJlYWQpOw0KIH0NCitFWFBPUlRf
U1lNQk9MKHNjaGVkX2Nsb2NrX3JlZ2lzdGVyKTsNCiANCiB2b2lkIF9faW5pdCBnZW5lcmljX3Nj
aGVkX2Nsb2NrX2luaXQodm9pZCkNCiB7DQotLSANCjEuNy45LjUNCg==

