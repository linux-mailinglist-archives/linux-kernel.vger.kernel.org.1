Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0DB2A013A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJ3JXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:23:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49457 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726110AbgJ3JXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:23:39 -0400
X-UUID: 7b9274f5c31a45df890ed48599eff29c-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZpW9Nn3WTF72bsEP3pngt8VigIg6cPhwRlY9GBZBlXw=;
        b=AIhW2Yc+ZpjSEsx+sO3xpFJxvt4v+rmpQ7J+QEkGU32WywXPCARvCiCQRRBH1/ah0s7QAcU3lMWW1Vh6pGa32JXhNnFfX5j4dJRZXO9pyI7kcJ8x3yd0fUR3Q/h+Y0NNbtfE+tPiHm6mGdvQT8Yj2+3XDgwZfCng/GAcZMGFQnM=;
X-UUID: 7b9274f5c31a45df890ed48599eff29c-20201030
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 35128789; Fri, 30 Oct 2020 17:13:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 17:13:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 17:13:12 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH v4 0/3] MT8192 SMI support
Date:   Fri, 30 Oct 2020 17:12:51 +0800
Message-ID: <20201030091254.26382-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3C519A5FD6F45B54AFFDD85386FD1928BE0CBF7344F9190F98C31982F514EB482000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBtYWlubHkgYWRkcyBTTUkgc3VwcG9ydCBmb3IgbXQ4MTkyLg0KDQpJdCBj
b21lcyBmcm9tIHRoZSBwYXRjaHNldFsxXS4gSSBzZXBlcmF0ZSB0aGUgc21pIHBhcnQgaW50byB0
aGlzIHBhdGNoc2V0Lg0KQW5kIHRoZSB0d28gcGFydChJT01NVS9TTUkpIHBhdGNoc2V0IGRvbid0
IGRlcGVuZCBvbiBlYWNoIG90aGVyLg0KDQpSZWJhc2Ugb24gdjUuMTAtcmMxLg0KDQpjaGFuZ2Vu
b3RlOg0KIHY0OiBhZGQgaWYtdGhlbiBzZWdtZW50IGluIHRoZSBiaW5kaW5nLg0KDQogdjM6IFsx
XS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjAwOTMwMDcw
NjQ3LjEwMTg4LTEteW9uZy53dUBtZWRpYXRlay5jb20vDQoNCllvbmcgV3UgKDMpOg0KICBkdC1i
aW5kaW5nczogbWVtb3J5OiBtZWRpYXRlazogQ29udmVydCBTTUkgdG8gRFQgc2NoZW1hDQogIGR0
LWJpbmRpbmdzOiBtZW1vcnk6IG1lZGlhdGVrOiBBZGQgbXQ4MTkyIHN1cHBvcnQNCiAgbWVtb3J5
OiBtdGstc21pOiBBZGQgbXQ4MTkyIHN1cHBvcnQNCg0KIC4uLi9tZWRpYXRlayxzbWktY29tbW9u
LnR4dCAgICAgICAgICAgICAgICAgICB8ICA1MCAtLS0tLS0NCiAuLi4vbWVkaWF0ZWssc21pLWNv
bW1vbi55YW1sICAgICAgICAgICAgICAgICAgfCAxNDIgKysrKysrKysrKysrKysrKysrDQogLi4u
L21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQgIHwgIDUwIC0tLS0tLQ0K
IC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbCB8IDEzMSArKysr
KysrKysrKysrKysrDQogZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jICAgICAgICAgICAgICAgICAg
ICAgIHwgIDE5ICsrKw0KIDUgZmlsZXMgY2hhbmdlZCwgMjkyIGluc2VydGlvbnMoKyksIDEwMCBk
ZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5
LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbA0KIGRlbGV0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21l
ZGlhdGVrLHNtaS1sYXJiLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlh
bWwNCg0KLS0gDQoyLjE4LjANCg0K

