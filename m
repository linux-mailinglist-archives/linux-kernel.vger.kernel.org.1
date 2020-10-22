Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03DC295EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507166AbgJVMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:47:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46612 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506490AbgJVMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:47:45 -0400
X-UUID: 709a1e10d77b437c84ed650ea57a3fa1-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XvPErSZpWjrvcm1+QkD4UGQ0oryX23O2RK+dpXdrlKA=;
        b=dSkHOccfF8J0pe2NYHJtWBImxvCBlABSLuK1Zi4+eb9BRdmVH2Xdng2P5vvE8+0keDx3RIn+ENliq4qyvsh17P5YEJTedLaITAUU7e8ImMv79oj19GMmxhLD+OWXF+wUIHnvuwwGW/m1+fLDM3ACwiOZFD+2FroQqSbuMHE3ggQ=;
X-UUID: 709a1e10d77b437c84ed650ea57a3fa1-20201022
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1362695770; Thu, 22 Oct 2020 20:47:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:47:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:47:39 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 0/4] Mediatek MT8192 scpsys support 
Date:   Thu, 22 Oct 2020 20:47:33 +0800
Message-ID: <1603370857-30646-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuOS1yYzEsIE1UODE5MiBjbG9jayB2NFsxXSBhbmQN
CnNvYzogbWVkaWF0ZWs6IHBtLWRvbWFpbnM6IEFkZCBuZXcgZHJpdmVyIGZvciBTQ1BTWVMgcG93
ZXIgZG9tYWlucyBjb250cm9sbGVyWzJdDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTM2ODc5OQ0KWzJdIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJp
ZXM9MzU4NDI5DQoNCmNoYW5nZSBzaW5jZSB2MToNCi0gYWRkIHBhdGNoIG9mIGRlZmF1bHQgcG93
ZXIgb2ZmIGZsYWcNCg0KV2VpeWkgTHUgKDQpOg0KICBkdC1iaW5kaW5nczogcG93ZXI6IEFkZCBN
VDgxOTIgcG93ZXIgZG9tYWlucw0KICBzb2M6IG1lZGlhdGVrOiBwbS1kb21haW5zOiBBZGQgZGVm
YXVsdCBwb3dlciBvZmYgZmxhZw0KICBzb2M6IG1lZGlhdGVrOiBwbS1kb21haW5zOiBBZGQgc3Vw
cG9ydCBmb3IgbXQ4MTkyDQogIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBBZGQgbXQ4MTkyIHBvd2Vy
IGRvbWFpbnMgY29udHJvbGxlcg0KDQogLi4uL3Bvd2VyL21lZGlhdGVrLHBvd2VyLWNvbnRyb2xs
ZXIueWFtbCAgICAgIHwgICAxICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5
Mi5kdHNpICAgICAgfCAyMDEgKysrKysrKysrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
cG0tZG9tYWlucy5jICAgICAgICAgfCAzMTMgKysrKysrKysrKysrKysrKystDQogaW5jbHVkZS9k
dC1iaW5kaW5ncy9wb3dlci9tdDgxOTItcG93ZXIuaCAgICAgIHwgIDMyICsrDQogaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCAgICAgICAgIHwgIDU2ICsrKysNCiA1IGZpbGVz
IGNoYW5nZWQsIDU5NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1wb3dlci5oDQo=

