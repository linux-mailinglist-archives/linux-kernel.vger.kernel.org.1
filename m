Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2D2A012C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgJ3JWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:22:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48367 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725355AbgJ3JWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:22:17 -0400
X-UUID: a1c1de4dce73456794c4512a88187148-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=K5V31xXaT/tsnSWsgwrn41aFfqWokiL6hIHcHbvcD1M=;
        b=cBX0BWv/rKSIXBO/256zH2ssZc0MhalDgmejsftWSVZIZDI/WP73Lk1NuLmkW6NheGibFLtvJXQ6quZaBxvsR16zM72mx+WrVwv7fDx2FT4O1JEVU2+jRqyS4WwestC28OM9oY1K1FDJx6pSv2ygI2RF7pP+2BfRpYDu22qI1/U=;
X-UUID: a1c1de4dce73456794c4512a88187148-20201030
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 761791665; Fri, 30 Oct 2020 17:22:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 17:22:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 17:22:12 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v6 0/1] Add basic node support for Mediatek MT8192 SoC
Date:   Fri, 30 Oct 2020 17:22:06 +0800
Message-ID: <20201030092207.26488-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpNVDgxOTIgaXMgYSBTb0MgYmFzZWQgb24gNjRiaXQgQVJNdjggYXJjaGl0ZWN0dXJlLg0KSXQg
Y29udGFpbnMgNCBDQTU1IGFuZCA0IENBNzYgY29yZXMuDQpNVDgxOTIgc2hhcmUgbWFueSBIVyBJ
UCB3aXRoIE1UNjV4eCBzZXJpZXMuDQpUaGlzIHBhdGNoc2V0IHdhcyB0ZXN0ZWQgb24gTVQ4MTky
IGV2YWx1YXRpb24gYm9hcmQgdG8gc2hlbGwuDQoNCkJhc2VkIG9uIHY1LjEwLXJjMQ0KDQpDaGFu
Z2UgaW4gdjY6DQoxLiBSZW1vdmUgaW5jbHVkaW5nIG10ODE5Mi1jbGsuaA0KMi4gVXNlIGNsazI2
bSBmb3Igc3BpIGNsb2NrDQoNCkNoYW5nZSBpbiB2NToNCjEuIFJlbW92ZSB3YXRjaGRvZyBhbmQg
YWxsIHN5c2NvbiBub2Rlcw0KMi4gVXNlIGNsazI2bSBmb3IgdWFydCBjbG9jaw0KMy4gUmVtb3Zl
IHRoZSBkZXBlbmRlbmN5IGxpc3QNCg0KQ2hhbmdlIGluIHY0Og0KMS4gUmVtb3ZlIHNjcHN5cywg
c3BtaSBhbmQgYXB1IG5vZGVzDQoyLiBBZGQgaTJjIG5vZGVzDQozLiBVcGRhdGUgd2F0Y2hkb2cg
YmluZGluZw0KNC4gVXBkYXRlIGRlcGVuZGVuY3kgbGlzdA0KDQpDaGFuZ2UgaW4gdjM6DQpGaXgg
dHlwbyBpbiBiaW5kaW5nIGRvY3VtZW50IG9mIHRpbWVyDQoNCkNoYW5nZSBpbiB2MjoNCjEuIFJl
bW92ZSBtdDgxOTItcG93ZXIuaCBmcm9tIG10ODE5Mi5kdHNpIHdoaWNoIGlzIG5vdCB1c2VkIHll
dA0KMi4gQWRkIHRpbWVyIGJpbmRpbmcgZG9jdW1lbnQgYW5kIGRldmljZSB0cmVlIG5vZGUgaW4g
bXQ4MTkyLmR0c2kNCjMuIFJlbW92ZSB3YXRjaGRvZyBkcml2ZXIgbW9kaWZpY2F0aW9uDQoNClNl
aXlhIFdhbmcgKDEpOg0KICBhcm02NDogZHRzOiBBZGQgTWVkaWF0ZWsgU29DIE1UODE5MiBhbmQg
ZXZhbHVhdGlvbiBib2FyZCBkdHMgYW5kDQogICAgTWFrZWZpbGUNCg0KIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgfCAgIDEgKw0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTkyLWV2Yi5kdHMgfCAgMjkgKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODE5Mi5kdHNpICAgIHwgNTEyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCiAzIGZpbGVzIGNoYW5nZWQsIDU0MiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLWV2Yi5kdHMNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KDQot
LQ0KMi4xNC4xDQo=

