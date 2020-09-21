Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1D2721DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIULJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:09:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34773 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726572AbgIULJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:09:22 -0400
X-UUID: 4812fccac1c04c5081e69975825891df-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=08rofXZloIV3LjQNVkR9D0dDfByH8KC8gG9Jp+c7MV4=;
        b=KToGJuQ7Z0awhQ11DY/mH/rrIn7LXzd+Eg34uUdpnhJgXgV4Z62id0tv4HPhd9soVxwrS4cI+hkMQZfHb/U3LaC1cEwiWZexaRzewKcK35KZg37QJksL9nHhwNKlWTutlH3Ti5mAwhzs1t9NL0mm0B85D4HmiFUfJNvjOEXeh44=;
X-UUID: 4812fccac1c04c5081e69975825891df-20200921
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1338918562; Mon, 21 Sep 2020 19:04:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 19:04:10 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 19:04:12 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>, <drinkcat@chromium.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH v3 0/4] Add PMIC wrapper support for Mediatek MT6873/8192 SoC IC
Date:   Mon, 21 Sep 2020 19:03:51 +0800
Message-ID: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBuZXcgU29DIE1UNjg3My84MTkyIHRvIHRoZSBw
bWljLXdyYXAgZHJpdmVyLg0KDQpjaGFuZ2VzIHNpbmNlIHYyOg0KLSByZWZpbmUgc29tZSBjb2Rp
bmcgc3R5bGUgYWJvdXQgUFdSQVBfQ0FQX0FSQiBjYXBhY2l0eSBmb3IgYmV0dGVyIGNvZGUgcXVh
bGl0eQ0KDQpIc2luLUhzaXVuZyBXYW5nICg0KToNCiAgc29jOiBtZWRpYXRlazogcHdyYXA6IHVz
ZSBCSVQoKSBtYWNybw0KICBzb2M6IG1lZGlhdGVrOiBwd3JhcDogYWRkIGFyYml0ZXIgY2FwYWJp
bGl0eQ0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IGFkZCBjb21wYXRpYmxlIGZvciBNVDY4NzMv
ODE5MiBwd3JhcA0KICBzb2M6IG1lZGlhdGVrOiBwd3JhcDogYWRkIHB3cmFwIGRyaXZlciBmb3Ig
TVQ2ODczLzgxOTIgU29Dcw0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVr
L3B3cmFwLnR4dCAgICAgfCAgMSArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3Jh
cC5jICAgICAgICAgICAgICAgfCA5MCArKysrKysrKysrKysrKysrKysrLS0tDQogMiBmaWxlcyBj
aGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjYuNA0K

