Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9ED28CA91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgJMIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:52:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55216 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404061AbgJMIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:52:19 -0400
X-UUID: 0c2c707e9ae0450d8da8f4053a9bbe67-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kPgVdXBZ16Sy3Bxw0HZy/Shb4t40QqjafhGAyV7TOcM=;
        b=WBkDfm0vDsC45QDWtjB4XbDsy5L0wYTmixVcVJfMQFGH0YerE+tzAZsy/p4QnNmCFM+PvuuFbJUUk4nSDsMHwdTF+Db3Y3ePhZWeuck17ZW4l60LFUTHFQ4x3DdcIcf2aERwbnQicke3/QP6N37NXwYpZZAvE1JwXsOhcmq9b50=;
X-UUID: 0c2c707e9ae0450d8da8f4053a9bbe67-20201013
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1239599055; Tue, 13 Oct 2020 16:52:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Oct 2020 16:52:12 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 16:52:12 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        CK Hu <ck.hu@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Min Guo <min.guo@mediatek.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v2 4/8] dt-bindings: phy: convert HDMI PHY binding to YAML schema
Date:   Tue, 13 Oct 2020 16:52:03 +0800
Message-ID: <20201013085207.17749-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29udmVydCBIRE1JIFBIWSBiaW5kaW5nIHRvIFlBTUwgc2NoZW1hIG1lZGlhdGVrLHVmcy1waHku
eWFtbA0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQotLS0NCnYyOiBmaXggYmluZGluZyBjaGVjayB3YXJuaW5nIG9mIHJlZyBpbiBleGFt
cGxlDQotLS0NCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxoZG1pLnR4dCAgICAgICAg
fCAxNyArLS0tDQogLi4uL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sICAgICAg
IHwgOTAgKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgOTEgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssaGRtaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxoZG1pLnR4dA0KaW5kZXggN2IxMjQyNDJiMGM1Li5lZGFj
MTg5NTFhNzUgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxoZG1pLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssaGRtaS50eHQNCkBA
IC01MCwyMiArNTAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIA0KIEhETUkgUEhZDQogPT09
PT09PT0NCi0NCi1UaGUgSERNSSBQSFkgc2VyaWFsaXplcyB0aGUgSERNSSBlbmNvZGVyJ3MgdGhy
ZWUgY2hhbm5lbCAxMC1iaXQgcGFyYWxsZWwNCi1vdXRwdXQgYW5kIGRyaXZlcyB0aGUgSERNSSBw
YWRzLg0KLQ0KLVJlcXVpcmVkIHByb3BlcnRpZXM6DQotLSBjb21wYXRpYmxlOiAibWVkaWF0ZWss
PGNoaXA+LWhkbWktcGh5Ig0KLS0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0
aCBvZiB0aGUgbW9kdWxlJ3MgcmVnaXN0ZXJzDQotLSBjbG9ja3M6IFBMTCByZWZlcmVuY2UgY2xv
Y2sNCi0tIGNsb2NrLW5hbWVzOiBtdXN0IGNvbnRhaW4gInBsbF9yZWYiDQotLSBjbG9jay1vdXRw
dXQtbmFtZXM6IG11c3QgYmUgImhkbWl0eF9kaWdfY3RzIiBvbiBtdDgxNzMNCi0tICNwaHktY2Vs
bHM6IG11c3QgYmUgPDA+DQotLSAjY2xvY2stY2VsbHM6IG11c3QgYmUgPDA+DQotDQotT3B0aW9u
YWwgcHJvcGVydGllczoNCi0tIG1lZGlhdGVrLGliaWFzOiBUWCBEUlYgYmlhcyBjdXJyZW50IGZv
ciA8MS42NUdicHMsIGRlZmF1bHRzIHRvIDB4YQ0KLS0gbWVkaWF0ZWssaWJpYXNfdXA6IFRYIERS
ViBiaWFzIGN1cnJlbnQgZm9yID4xLjY1R2JwcywgZGVmYXVsdHMgdG8gMHgxYw0KK1NlZSBwaHkv
bWVkaWF0ZWssaGRtaS1waHkueWFtbA0KIA0KIEV4YW1wbGU6DQogDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBo
eS55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi43N2RmNTAy
MDQ2MDYNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KQEAgLTAsMCArMSw5MCBAQA0KKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyMg
Q29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbCMNCisk
c2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisN
Cit0aXRsZTogTWVkaWFUZWsgSGlnaCBEZWZpbml0aW9uIE11bHRpbWVkaWEgSW50ZXJmYWNlIChI
RE1JKSBQSFkgYmluZGluZw0KKw0KK21haW50YWluZXJzOg0KKyAgLSBDSyBIdSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KKyAgLSBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQorDQorZGVzY3JpcHRpb246IHwNCisgIFRoZSBIRE1JIFBIWSBzZXJpYWxpemVzIHRoZSBIRE1J
IGVuY29kZXIncyB0aHJlZSBjaGFubmVsIDEwLWJpdCBwYXJhbGxlbA0KKyAgb3V0cHV0IGFuZCBk
cml2ZXMgdGhlIEhETUkgcGFkcy4NCisNCitwcm9wZXJ0aWVzOg0KKyAgJG5vZGVuYW1lOg0KKyAg
ICBwYXR0ZXJuOiAiXmhkbWktcGh5QFswLTlhLWZdKyQiDQorDQorICBjb21wYXRpYmxlOg0KKyAg
ICBlbnVtOg0KKyAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5DQorICAgICAgLSBtZWRp
YXRlayxtdDgxNzMtaGRtaS1waHkNCisNCisgIHJlZzoNCisgICAgbWF4SXRlbXM6IDENCisNCisg
IGNsb2NrczoNCisgICAgaXRlbXM6DQorICAgICAgLSBkZXNjcmlwdGlvbjogUExMIHJlZmVyZW5j
ZSBjbG9jaw0KKw0KKyAgY2xvY2stbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6
IHBsbF9yZWYNCisNCisgIGNsb2NrLW91dHB1dC1uYW1lczoNCisgICAgaXRlbXM6DQorICAgICAg
LSBjb25zdDogaGRtaXR4X2RpZ19jdHMNCisNCisgICIjcGh5LWNlbGxzIjoNCisgICAgY29uc3Q6
IDANCisNCisgICIjY2xvY2stY2VsbHMiOg0KKyAgICBjb25zdDogMA0KKw0KKyAgbWVkaWF0ZWss
aWJpYXM6DQorICAgIGRlc2NyaXB0aW9uOg0KKyAgICAgIFRYIERSViBiaWFzIGN1cnJlbnQgZm9y
IDwgMS42NUdicHMNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyDQorICAgIG1pbmltdW06IDANCisgICAgbWF4aW11bTogNjMNCisgICAgZGVmYXVsdDog
MHhhDQorDQorICBtZWRpYXRlayxpYmlhc191cDoNCisgICAgZGVzY3JpcHRpb246DQorICAgICAg
VFggRFJWIGJpYXMgY3VycmVudCBmb3IgPj0gMS42NUdicHMNCisgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQorICAgIG1pbmltdW06IDANCisgICAgbWF4
aW11bTogNjMNCisgICAgZGVmYXVsdDogMHgxYw0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRp
YmxlDQorICAtIHJlZw0KKyAgLSBjbG9ja3MNCisgIC0gY2xvY2stbmFtZXMNCisgIC0gY2xvY2st
b3V0cHV0LW5hbWVzDQorICAtICIjcGh5LWNlbGxzIg0KKyAgLSAiI2Nsb2NrLWNlbGxzIg0KKw0K
K2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxNzMtY2xrLmg+DQorICAgIGhkbWlfcGh5
OiBoZG1pLXBoeUAxMDIwOTEwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE3My1oZG1pLXBoeSI7DQorICAgICAgICByZWcgPSA8MHgxMDIwOTEwMCAweDI0PjsNCisgICAg
ICAgIGNsb2NrcyA9IDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9IRE1JX1JFRj47DQorICAgICAg
ICBjbG9jay1uYW1lcyA9ICJwbGxfcmVmIjsNCisgICAgICAgIGNsb2NrLW91dHB1dC1uYW1lcyA9
ICJoZG1pdHhfZGlnX2N0cyI7DQorICAgICAgICBtZWRpYXRlayxpYmlhcyA9IDwweGE+Ow0KKyAg
ICAgICAgbWVkaWF0ZWssaWJpYXNfdXAgPSA8MHgxYz47DQorICAgICAgICAjY2xvY2stY2VsbHMg
PSA8MD47DQorICAgICAgICAjcGh5LWNlbGxzID0gPDA+Ow0KKyAgICB9Ow0KKw0KKy4uLg0KLS0g
DQoyLjE4LjANCg==

