Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC41C2F8C62
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAPJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:07:53 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:62098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbhAPJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:07:48 -0500
X-UUID: e4595f3d832c47edb2ce69307b07627a-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jcPT0Ouro3sFfGACLVKC62buUbGfh+WkruUymncuilQ=;
        b=pM0+Q+KrcysYMM92t99TDWsDjCAS0Cgnww6LQvb0FhonpynkePvBB2C/OY4bJD4de+NnlUbh+Xma5JzASnILj7EkPA6e7jWB8Zp4H0qVA65i/T8IpjxPFheyXr34T/SuuUvInpNCytahYM8twR9qpHdwhn8ixmI96tTgsH95VJc=;
X-UUID: e4595f3d832c47edb2ce69307b07627a-20210116
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 245384260; Sat, 16 Jan 2021 17:07:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:06:58 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:06:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next 02/15] dt-bindings: usb: mediatek: fix yamllint check warning
Date:   Sat, 16 Jan 2021 17:06:43 +0800
Message-ID: <20210116090656.11752-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 950C4F545F68DBC63BF8CFA97B963ECC14D56E0EA4CF1E0805DB59BDFF6F46BE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHdhcm5pbmc6ICJ0b28gbWFueSBzcGFjZXMgaW5zaWRlIGJyYWNrZXRzIg0KDQpTaWduZWQt
b2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCAgICAgICAg
ICB8IDIgKy0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVr
LG10dTMueWFtbCAgICB8IDYgKysrLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9tZWRpYXRlayxtdXNiLnlhbWwgICAgfCA0ICsrLS0NCiAzIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFt
bA0KaW5kZXggMzhiMWZlMThhYTc5Li5hMzgxN2YzYWY1OWQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXho
Y2kueWFtbA0KQEAgLTEzOSw3ICsxMzksNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCiAgICAgZGVz
Y3JpcHRpb246IFRoZSBoYXJkIHdpcmVkIFVTQiBkZXZpY2VzLg0KIA0KIGRlcGVuZGVuY2llczoN
Ci0gIHdha2V1cC1zb3VyY2U6IFsgJ21lZGlhdGVrLHN5c2Nvbi13YWtldXAnIF0NCisgIHdha2V1
cC1zb3VyY2U6IFsnbWVkaWF0ZWssc3lzY29uLXdha2V1cCddDQogDQogcmVxdWlyZWQ6DQogICAt
IGNvbXBhdGlibGUNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21lZGlhdGVrLG10dTMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQppbmRleCBmNWMwNGI5ZDJkZTkuLjY2ZDc4ZjUz
NDcyMiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
bWVkaWF0ZWssbXR1My55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KQEAgLTE3Miw5ICsxNzIsOSBAQCBwYXR0ZXJuUHJv
cGVydGllczoNCiAgICAgICBleGFtcGxlIGlmIHRoZSBob3N0IG1vZGUgaXMgZW5hYmxlZC4NCiAN
CiBkZXBlbmRlbmNpZXM6DQotICBjb25uZWN0b3I6IFsgJ3VzYi1yb2xlLXN3aXRjaCcgXQ0KLSAg
cG9ydDogWyAndXNiLXJvbGUtc3dpdGNoJyBdDQotICB3YWtldXAtc291cmNlOiBbICdtZWRpYXRl
ayxzeXNjb24td2FrZXVwJyBdDQorICBjb25uZWN0b3I6IFsndXNiLXJvbGUtc3dpdGNoJ10NCisg
IHBvcnQ6IFsndXNiLXJvbGUtc3dpdGNoJ10NCisgIHdha2V1cC1zb3VyY2U6IFsnbWVkaWF0ZWss
c3lzY29uLXdha2V1cCddDQogDQogcmVxdWlyZWQ6DQogICAtIGNvbXBhdGlibGUNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG11c2Iu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXVz
Yi55YW1sDQppbmRleCA3OTBlZmU4YjYyNzQuLmE1MTVjOWYzMGI5NiAxMDA2NDQNCi0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXVzYi55YW1sDQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG11c2Iu
eWFtbA0KQEAgLTY2LDggKzY2LDggQEAgcHJvcGVydGllczoNCiAgICAgdHlwZTogb2JqZWN0DQog
DQogZGVwZW5kZW5jaWVzOg0KLSAgdXNiLXJvbGUtc3dpdGNoOiBbICdjb25uZWN0b3InIF0NCi0g
IGNvbm5lY3RvcjogWyAndXNiLXJvbGUtc3dpdGNoJyBdDQorICB1c2Itcm9sZS1zd2l0Y2g6IFsn
Y29ubmVjdG9yJ10NCisgIGNvbm5lY3RvcjogWyd1c2Itcm9sZS1zd2l0Y2gnXQ0KIA0KIHJlcXVp
cmVkOg0KICAgLSBjb21wYXRpYmxlDQotLSANCjIuMTguMA0K

