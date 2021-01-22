Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8706B3002B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbhAVMSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:18:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:33771 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727877AbhAVMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:10:23 -0500
X-UUID: 4c5d14c88c10403ba8c77319b58bafe8-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xdROprIdh/cM9sBOmGFqugjqZEh2e8FkV7LBr1Y63m8=;
        b=CL2VFXBp4o3mHoNSEE2H9pDkE5OPkS6B04zrWvcyedNw3DOwQJ+UWVlh++fZhT/I7VKG53PGghVKCc/JKeS6CYDRkaJ4y6ij9K/iiX8zMQCIUnZnmMCfOV5ZCEoMXFHT7IlxvvamLuxOcbpnJHK8ijPdNyU1eC8r8JXBxfej0uI=;
X-UUID: 4c5d14c88c10403ba8c77319b58bafe8-20210122
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1372066903; Fri, 22 Jan 2021 20:03:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:37 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:37 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next v2 02/17] dt-bindings: usb: mediatek: fix yamllint check warning
Date:   Fri, 22 Jan 2021 20:03:08 +0800
Message-ID: <20210122120323.4337-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B9106B7E9588D51D31A1A2591C4DC47A5E623353823F156C61F674A7140978572000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHdhcm5pbmc6ICJ0b28gbWFueSBzcGFjZXMgaW5zaWRlIGJyYWNrZXRzIg0KDQpTaWduZWQt
b2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYy
OiBubyBjaGFuZ2VzDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWss
bXRrLXhoY2kueWFtbCAgICAgICAgICB8IDIgKy0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbCAgICB8IDYgKysrLS0tDQogRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNiLnlhbWwgICAgfCA0ICsr
LS0NCiAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0
ZWssbXRrLXhoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
bWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KaW5kZXggMzhiMWZlMThhYTc5Li5hMzgxN2YzYWY1OWQg
MTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlh
dGVrLG10ay14aGNpLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KQEAgLTEzOSw3ICsxMzksNyBAQCBwYXR0ZXJu
UHJvcGVydGllczoNCiAgICAgZGVzY3JpcHRpb246IFRoZSBoYXJkIHdpcmVkIFVTQiBkZXZpY2Vz
Lg0KIA0KIGRlcGVuZGVuY2llczoNCi0gIHdha2V1cC1zb3VyY2U6IFsgJ21lZGlhdGVrLHN5c2Nv
bi13YWtldXAnIF0NCisgIHdha2V1cC1zb3VyY2U6IFsnbWVkaWF0ZWssc3lzY29uLXdha2V1cCdd
DQogDQogcmVxdWlyZWQ6DQogICAtIGNvbXBhdGlibGUNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQppbmRleCBm
NWMwNGI5ZDJkZTkuLjY2ZDc4ZjUzNDcyMiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KQEAgLTE3Miw5
ICsxNzIsOSBAQCBwYXR0ZXJuUHJvcGVydGllczoNCiAgICAgICBleGFtcGxlIGlmIHRoZSBob3N0
IG1vZGUgaXMgZW5hYmxlZC4NCiANCiBkZXBlbmRlbmNpZXM6DQotICBjb25uZWN0b3I6IFsgJ3Vz
Yi1yb2xlLXN3aXRjaCcgXQ0KLSAgcG9ydDogWyAndXNiLXJvbGUtc3dpdGNoJyBdDQotICB3YWtl
dXAtc291cmNlOiBbICdtZWRpYXRlayxzeXNjb24td2FrZXVwJyBdDQorICBjb25uZWN0b3I6IFsn
dXNiLXJvbGUtc3dpdGNoJ10NCisgIHBvcnQ6IFsndXNiLXJvbGUtc3dpdGNoJ10NCisgIHdha2V1
cC1zb3VyY2U6IFsnbWVkaWF0ZWssc3lzY29uLXdha2V1cCddDQogDQogcmVxdWlyZWQ6DQogICAt
IGNvbXBhdGlibGUNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21lZGlhdGVrLG11c2IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvbWVkaWF0ZWssbXVzYi55YW1sDQppbmRleCA3OTBlZmU4YjYyNzQuLmE1MTVjOWYz
MGI5NiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
bWVkaWF0ZWssbXVzYi55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21lZGlhdGVrLG11c2IueWFtbA0KQEAgLTY2LDggKzY2LDggQEAgcHJvcGVydGllczoN
CiAgICAgdHlwZTogb2JqZWN0DQogDQogZGVwZW5kZW5jaWVzOg0KLSAgdXNiLXJvbGUtc3dpdGNo
OiBbICdjb25uZWN0b3InIF0NCi0gIGNvbm5lY3RvcjogWyAndXNiLXJvbGUtc3dpdGNoJyBdDQor
ICB1c2Itcm9sZS1zd2l0Y2g6IFsnY29ubmVjdG9yJ10NCisgIGNvbm5lY3RvcjogWyd1c2Itcm9s
ZS1zd2l0Y2gnXQ0KIA0KIHJlcXVpcmVkOg0KICAgLSBjb21wYXRpYmxlDQotLSANCjIuMTguMA0K

