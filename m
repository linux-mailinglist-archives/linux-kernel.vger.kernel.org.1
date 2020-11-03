Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649192A3C12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 06:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKCFmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 00:42:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725953AbgKCFmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 00:42:23 -0500
X-UUID: 6b5ec04e2eab43fbbcdebd85e2586f00-20201103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WW0Lmah8IaQQ9ZgPn79i+P0KVknepuLmC9kWTei51Yc=;
        b=unRobiCxA4U4giVNtijjXCMLrUTDa3+b0GCFyEwfpDFKq2y6nQHdqbIsvB4jvilQXHdBbVAt9Jb/6/3Mqlmman5GIkh47fdm/bsOkHOs514Ddhtw1j12NfZ/eOS+GaihhfQ/BVYshDEV0z98xhI+bO6+uxG23GDNGDL+Re7dEUA=;
X-UUID: 6b5ec04e2eab43fbbcdebd85e2586f00-20201103
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1631611038; Tue, 03 Nov 2020 13:42:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Nov 2020 13:42:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Nov 2020 13:42:16 +0800
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
Subject: [PATCH v5 0/3] MT8192 SMI support
Date:   Tue, 3 Nov 2020 13:41:57 +0800
Message-ID: <20201103054200.21386-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EF9423204EAF833543A28E9D29A571C12114AD1C3BD3F5EA68511EA5BB10A7BA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBtYWlubHkgYWRkcyBTTUkgc3VwcG9ydCBmb3IgbXQ4MTkyLg0KDQpJdCBj
b21lcyBmcm9tIHRoZSBwYXRjaHNldFsxXS4gSSBzZXBlcmF0ZSB0aGUgc21pIHBhcnQgaW50byB0
aGlzIHBhdGNoc2V0Lg0KQW5kIHRoZSB0d28gcGFydChJT01NVS9TTUkpIHBhdGNoc2V0IGRvbid0
IGRlcGVuZCBvbiBlYWNoIG90aGVyLg0KDQpSZWJhc2Ugb24gdjUuMTAtcmMxLg0KDQpjaGFuZ2Vu
b3RlOg0KIHY1OiBGaXggY29tcGxhaW4gZnJvbSB5YW1sbGludC4NCg0KIHY0OiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1tZWRpYXRlay8yMDIwMTAzMDA5MTI1NC4yNjM4Mi0xLXlvbmcu
d3VAbWVkaWF0ZWsuY29tL1QvI21lYjAzYjNmNDAxODg5NGJmNDBjNDdmZWNlNTJmZTliMzg2NDA5
OTM0IA0KICAgIGFkZCBpZi10aGVuIHNlZ21lbnQgaW4gdGhlIGJpbmRpbmcuDQoNCiB2MzogWzFd
DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIwMDkzMDA3MDY0
Ny4xMDE4OC0xLXlvbmcud3VAbWVkaWF0ZWsuY29tLw0KDQoNCllvbmcgV3UgKDMpOg0KICBkdC1i
aW5kaW5nczogbWVtb3J5OiBtZWRpYXRlazogQ29udmVydCBTTUkgdG8gRFQgc2NoZW1hDQogIGR0
LWJpbmRpbmdzOiBtZW1vcnk6IG1lZGlhdGVrOiBBZGQgbXQ4MTkyIHN1cHBvcnQNCiAgbWVtb3J5
OiBtdGstc21pOiBBZGQgbXQ4MTkyIHN1cHBvcnQNCg0KIC4uLi9tZWRpYXRlayxzbWktY29tbW9u
LnR4dCAgICAgICAgICAgICAgICAgICB8ICA1MCAtLS0tLS0NCiAuLi4vbWVkaWF0ZWssc21pLWNv
bW1vbi55YW1sICAgICAgICAgICAgICAgICAgfCAxNDIgKysrKysrKysrKysrKysrKysrDQogLi4u
L21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQgIHwgIDUwIC0tLS0tLQ0K
IC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbCB8IDEzMiArKysr
KysrKysrKysrKysrDQogZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jICAgICAgICAgICAgICAgICAg
ICAgIHwgIDE5ICsrKw0KIDUgZmlsZXMgY2hhbmdlZCwgMjkzIGluc2VydGlvbnMoKyksIDEwMCBk
ZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5
LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbA0KIGRlbGV0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21l
ZGlhdGVrLHNtaS1sYXJiLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlh
bWwNCg0KLS0gDQoyLjE4LjANCg0K

