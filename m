Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EEF2444D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 08:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHNGFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 02:05:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:29563 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgHNGFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:05:33 -0400
X-UUID: 2d99217e74c84f8ba20a5b274f5aa6fd-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qLDakBeiLbmANdjXt3bA+JvN+jwjGyd1xiqJb9UZTck=;
        b=IThPlJJ9LO0zjrFTZu+Sn3J9t+ddJxMcvj13LvIw+ZfS/ys8AIg2xg5m7WxsOrU52eDM7njvUXkXI35ORlDpsqWH0Jrm0hVYBiXiXvFauqwizWHdfpKHmXLG5Y1G4Lz/ji3Pn1W+phuGyIwMFLWGPVqXHUKiQ0Jf9SycrFpRrgM=;
X-UUID: 2d99217e74c84f8ba20a5b274f5aa6fd-20200814
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 734366943; Fri, 14 Aug 2020 14:05:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 14:05:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 14:05:27 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH v4 3/3] dt-bindings: timer: Add compatible for Mediatek MT8192
Date:   Fri, 14 Aug 2020 14:04:54 +0800
Message-ID: <20200814060454.32200-4-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200814060454.32200-1-seiya.wang@mediatek.com>
References: <20200814060454.32200-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBkdC1iaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgdGltZXIgZm9yIE1l
ZGlhdGVrIE1UODE5MiBTb0MNClBsYXRmb3JtLg0KDQpBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IFNlaXlhIFdhbmcgPHNlaXlhLndhbmdAbWVk
aWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVy
L21lZGlhdGVrLG10ay10aW1lci50eHQgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90
aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RpbWVyL21lZGlhdGVrLG10ay10aW1lci50eHQNCmluZGV4IDBkMjU2NDg2Zjg4Ni4u
NjkwYTljMDk2NmFjIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3RpbWVyL21lZGlhdGVrLG10ay10aW1lci50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy90aW1lci9tZWRpYXRlayxtdGstdGltZXIudHh0DQpAQCAtMjIsNiAr
MjIsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIA0KIAlGb3IgdGhvc2UgU29DcyB0aGF0IHVz
ZSBTWVNUDQogCSogIm1lZGlhdGVrLG10ODE4My10aW1lciIgZm9yIE1UODE4MyBjb21wYXRpYmxl
IHRpbWVycyAoU1lTVCkNCisJKiAibWVkaWF0ZWssbXQ4MTkyLXRpbWVyIiBmb3IgTVQ4MTkyIGNv
bXBhdGlibGUgdGltZXJzIChTWVNUKQ0KIAkqICJtZWRpYXRlayxtdDc2MjktdGltZXIiIGZvciBN
VDc2MjkgY29tcGF0aWJsZSB0aW1lcnMgKFNZU1QpDQogCSogIm1lZGlhdGVrLG10Njc2NS10aW1l
ciIgZm9yIE1UNjc2NSBhbmQgYWxsIGFib3ZlIGNvbXBhdGlibGUgdGltZXJzIChTWVNUKQ0KIA0K
LS0gDQoyLjE0LjENCg==

