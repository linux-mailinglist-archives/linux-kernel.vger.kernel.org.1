Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9044F273CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIVIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:00:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58891 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbgIVIAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:00:16 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 04:00:15 EDT
X-UUID: 7158b61a1e5448668abfe74e009a824d-20200922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kzHH5APnEkOj/iTmhtuS6d+iRdyxeZzVST6CIJYTUHw=;
        b=qTznJrcRIO9Wdi5AD/vUcmfRsiM5TuE0+pyF6SpqUHlyXdTOC/OHwzOgPO8/XCotoxo9R5A0F8M9b+Gq3hcePbNYH3Qsrc/BFJFkPCjIisJcuV/hnE2BF/WICJP0Uuh8IqXEi/8xSDwo/YikTZSCjvOZxk+ktwIRCGFFDFS0FMg=;
X-UUID: 7158b61a1e5448668abfe74e009a824d-20200922
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1974907599; Tue, 22 Sep 2020 15:55:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Sep 2020 15:55:08 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Sep 2020 15:55:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanley Chu <stanley.chu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/4] dt-bindings: phy: convert HDMI PHY binding to YAML schema
Date:   Tue, 22 Sep 2020 15:55:08 +0800
Message-ID: <4817a10e1c3b2beeb79b0cf5e182df747ce268e7.1600760719.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <5af7c097d1c71a180d8ed1f1a44055859b42f1a0.1600760719.git.chunfeng.yun@mediatek.com>
References: <5af7c097d1c71a180d8ed1f1a44055859b42f1a0.1600760719.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29udmVydCBIRE1JIFBIWSBiaW5kaW5nIHRvIFlBTUwgc2NoZW1hIG1lZGlhdGVrLHVmcy1waHku
eWFtbA0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQotLS0NCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxoZG1pLnR4dCAgICAg
ICAgfCAxNyArLS0tDQogLi4uL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sICAg
ICAgIHwgOTAgKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgOTEgaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssaGRtaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxoZG1pLnR4dA0KaW5kZXggN2IxMjQyNDJiMGM1Li5l
ZGFjMTg5NTFhNzUgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxoZG1pLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssaGRtaS50eHQN
CkBAIC01MCwyMiArNTAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIA0KIEhETUkgUEhZDQog
PT09PT09PT0NCi0NCi1UaGUgSERNSSBQSFkgc2VyaWFsaXplcyB0aGUgSERNSSBlbmNvZGVyJ3Mg
dGhyZWUgY2hhbm5lbCAxMC1iaXQgcGFyYWxsZWwNCi1vdXRwdXQgYW5kIGRyaXZlcyB0aGUgSERN
SSBwYWRzLg0KLQ0KLVJlcXVpcmVkIHByb3BlcnRpZXM6DQotLSBjb21wYXRpYmxlOiAibWVkaWF0
ZWssPGNoaXA+LWhkbWktcGh5Ig0KLS0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxl
bmd0aCBvZiB0aGUgbW9kdWxlJ3MgcmVnaXN0ZXJzDQotLSBjbG9ja3M6IFBMTCByZWZlcmVuY2Ug
Y2xvY2sNCi0tIGNsb2NrLW5hbWVzOiBtdXN0IGNvbnRhaW4gInBsbF9yZWYiDQotLSBjbG9jay1v
dXRwdXQtbmFtZXM6IG11c3QgYmUgImhkbWl0eF9kaWdfY3RzIiBvbiBtdDgxNzMNCi0tICNwaHkt
Y2VsbHM6IG11c3QgYmUgPDA+DQotLSAjY2xvY2stY2VsbHM6IG11c3QgYmUgPDA+DQotDQotT3B0
aW9uYWwgcHJvcGVydGllczoNCi0tIG1lZGlhdGVrLGliaWFzOiBUWCBEUlYgYmlhcyBjdXJyZW50
IGZvciA8MS42NUdicHMsIGRlZmF1bHRzIHRvIDB4YQ0KLS0gbWVkaWF0ZWssaWJpYXNfdXA6IFRY
IERSViBiaWFzIGN1cnJlbnQgZm9yID4xLjY1R2JwcywgZGVmYXVsdHMgdG8gMHgxYw0KK1NlZSBw
aHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KIA0KIEV4YW1wbGU6DQogDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1p
LXBoeS55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi42Nzli
NDAwNWVlNjINCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KQEAgLTAsMCArMSw5MCBAQA0KKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0K
KyMgQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbCMN
Ciskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
CisNCit0aXRsZTogTWVkaWFUZWsgSGlnaCBEZWZpbml0aW9uIE11bHRpbWVkaWEgSW50ZXJmYWNl
IChIRE1JKSBQSFkgYmluZGluZw0KKw0KK21haW50YWluZXJzOg0KKyAgLSBDSyBIdSA8Y2suaHVA
bWVkaWF0ZWsuY29tPg0KKyAgLSBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQorDQorZGVzY3JpcHRpb246IHwNCisgIFRoZSBIRE1JIFBIWSBzZXJpYWxpemVzIHRoZSBI
RE1JIGVuY29kZXIncyB0aHJlZSBjaGFubmVsIDEwLWJpdCBwYXJhbGxlbA0KKyAgb3V0cHV0IGFu
ZCBkcml2ZXMgdGhlIEhETUkgcGFkcy4NCisNCitwcm9wZXJ0aWVzOg0KKyAgJG5vZGVuYW1lOg0K
KyAgICBwYXR0ZXJuOiAiXmhkbWktcGh5QFswLTlhLWZdKyQiDQorDQorICBjb21wYXRpYmxlOg0K
KyAgICBlbnVtOg0KKyAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5DQorICAgICAgLSBt
ZWRpYXRlayxtdDgxNzMtaGRtaS1waHkNCisNCisgIHJlZzoNCisgICAgbWF4SXRlbXM6IDENCisN
CisgIGNsb2NrczoNCisgICAgaXRlbXM6DQorICAgICAgLSBkZXNjcmlwdGlvbjogUExMIHJlZmVy
ZW5jZSBjbG9jaw0KKw0KKyAgY2xvY2stbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29u
c3Q6IHBsbF9yZWYNCisNCisgIGNsb2NrLW91dHB1dC1uYW1lczoNCisgICAgaXRlbXM6DQorICAg
ICAgLSBjb25zdDogaGRtaXR4X2RpZ19jdHMNCisNCisgICIjcGh5LWNlbGxzIjoNCisgICAgY29u
c3Q6IDANCisNCisgICIjY2xvY2stY2VsbHMiOg0KKyAgICBjb25zdDogMA0KKw0KKyAgbWVkaWF0
ZWssaWJpYXM6DQorICAgIGRlc2NyaXB0aW9uOg0KKyAgICAgIFRYIERSViBiaWFzIGN1cnJlbnQg
Zm9yIDwgMS42NUdicHMNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvdWludDMyDQorICAgIG1pbmltdW06IDANCisgICAgbWF4aW11bTogNjMNCisgICAgZGVmYXVs
dDogMHhhDQorDQorICBtZWRpYXRlayxpYmlhc191cDoNCisgICAgZGVzY3JpcHRpb246DQorICAg
ICAgVFggRFJWIGJpYXMgY3VycmVudCBmb3IgPj0gMS42NUdicHMNCisgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQorICAgIG1pbmltdW06IDANCisgICAg
bWF4aW11bTogNjMNCisgICAgZGVmYXVsdDogMHgxYw0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21w
YXRpYmxlDQorICAtIHJlZw0KKyAgLSBjbG9ja3MNCisgIC0gY2xvY2stbmFtZXMNCisgIC0gY2xv
Y2stb3V0cHV0LW5hbWVzDQorICAtICIjcGh5LWNlbGxzIg0KKyAgLSAiI2Nsb2NrLWNlbGxzIg0K
Kw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQor
ICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxNzMtY2xrLmg+DQorICAgIGhkbWlf
cGh5OiBoZG1pLXBoeUAxMDIwOTEwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE3My1oZG1pLXBoeSI7DQorICAgICAgICByZWcgPSA8MCAweDEwMjA5MTAwIDAgMHgyND47
DQorICAgICAgICBjbG9ja3MgPSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfSERNSV9SRUY+Ow0K
KyAgICAgICAgY2xvY2stbmFtZXMgPSAicGxsX3JlZiI7DQorICAgICAgICBjbG9jay1vdXRwdXQt
bmFtZXMgPSAiaGRtaXR4X2RpZ19jdHMiOw0KKyAgICAgICAgbWVkaWF0ZWssaWJpYXMgPSA8MHhh
PjsNCisgICAgICAgIG1lZGlhdGVrLGliaWFzX3VwID0gPDB4MWM+Ow0KKyAgICAgICAgI2Nsb2Nr
LWNlbGxzID0gPDA+Ow0KKyAgICAgICAgI3BoeS1jZWxscyA9IDwwPjsNCisgICAgfTsNCisNCisu
Li4NCi0tIA0KMi4xOC4wDQo=

