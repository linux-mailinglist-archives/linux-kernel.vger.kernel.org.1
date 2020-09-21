Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4858C2721E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIULJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:09:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34773 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726347AbgIULJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:09:21 -0400
X-UUID: 0345ed92d44a4358aaa188b6c01a32e2-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ujPNIMbWH3zYMxKQiDHMi/v6JaPz8xZ2W6SlEARO0Ys=;
        b=J0Z3rzyplf+XQ29M3UR026mlAkyh/ayPdJNl3Qt59LqeoUvjrYiBY7Ui0IVaR4KKySGrDjojKOsvhrHdK19Luw3QuhSFjAkc//Xo5cHwJ+yPbZVElHAV12k6xaT4/r8TfARJIi5+GBsmPxATn8rSztcCRO2qAJ1cl3HZLXhj7Ek=;
X-UUID: 0345ed92d44a4358aaa188b6c01a32e2-20200921
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 898320028; Mon, 21 Sep 2020 19:04:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 19:04:12 +0800
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
Subject: [PATCH v3 3/4] dt-bindings: mediatek: add compatible for MT6873/8192 pwrap
Date:   Mon, 21 Sep 2020 19:03:54 +0800
Message-ID: <1600686235-27979-4-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIGR0LWJpbmRpbmcgZG9jdW1lbnRhdGlvbiBvZiBwd3JhcCBmb3IgTWVkaWF0ZWsg
TVQ2ODczLzgxOTINClNvQ3MgUGxhdGZvcm0uDQoNClNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5n
IFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvYy9tZWRpYXRlay9wd3JhcC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dA0KaW5kZXggZWNhYzJiYi4uODA1MWMxNyAxMDA2
NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsv
cHdyYXAudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21l
ZGlhdGVrL3B3cmFwLnR4dA0KQEAgLTIyLDYgKzIyLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllcyBp
biBwd3JhcCBkZXZpY2Ugbm9kZS4NCiAJIm1lZGlhdGVrLG10Njc2NS1wd3JhcCIgZm9yIE1UNjc2
NSBTb0NzDQogCSJtZWRpYXRlayxtdDY3NzktcHdyYXAiIGZvciBNVDY3NzkgU29Dcw0KIAkibWVk
aWF0ZWssbXQ2Nzk3LXB3cmFwIiBmb3IgTVQ2Nzk3IFNvQ3MNCisJIm1lZGlhdGVrLG10Njg3My1w
d3JhcCIgZm9yIE1UNjg3My84MTkyIFNvQ3MNCiAJIm1lZGlhdGVrLG10NzYyMi1wd3JhcCIgZm9y
IE1UNzYyMiBTb0NzDQogCSJtZWRpYXRlayxtdDgxMzUtcHdyYXAiIGZvciBNVDgxMzUgU29Dcw0K
IAkibWVkaWF0ZWssbXQ4MTczLXB3cmFwIiBmb3IgTVQ4MTczIFNvQ3MNCi0tIA0KMi42LjQNCg==

