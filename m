Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC393273CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIVHzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:55:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35105 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbgIVHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:55:15 -0400
X-UUID: 03c42a6be468462f8e894b535cd8f7d8-20200922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tAy9SIgzJcPBsk985GJ+X6+hIqQmLFQwVgOe/UUyf+c=;
        b=InvGFg9F+YFHjWyC3zKkmG8RZthX5p/q5EfP9ygTeGbfQ8nMVu5aZYL0lDDinjD5iwZPuF5Zqg6PXOzYO8ljY/WRmBPCogSQH8OSd0+LNwrnxYSs9cToPOnMfeZ/eQtOr1QLhDMiIjOemWKEQ+Iz6D6H18AO18WiHxXKrJgFLvg=;
X-UUID: 03c42a6be468462f8e894b535cd8f7d8-20200922
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 492823032; Tue, 22 Sep 2020 15:55:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 3/4] dt-bindings: phy: convert phy-mtk-ufs.txt to YAML schema
Date:   Tue, 22 Sep 2020 15:55:07 +0800
Message-ID: <006ecd5b88fd7d23a355f2522c37e745f72ac45a.1600760719.git.chunfeng.yun@mediatek.com>
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

Q29udmVydCBwaHktbXRrLXVmcy50eHQgdG8gWUFNTCBzY2hlbWEgbWVkaWF0ZWssdWZzLXBoeS55
YW1sDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55YW1sICAgICAg
ICB8IDY0ICsrKysrKysrKysrKysrKysrKysNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
cGh5LW10ay11ZnMudHh0ICAgfCAzOCAtLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNjQg
aW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55YW1sDQog
ZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
cGh5LW10ay11ZnMudHh0DQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGh5L21lZGlhdGVrLHVmcy1waHkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55YW1sDQpuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi42Mjk4MTlkN2YxYzgNCi0tLSAvZGV2L251bGwNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBo
eS55YW1sDQpAQCAtMCwwICsxLDY0IEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQ
TC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQorIyBDb3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFU
ZWsNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L3BoeS9tZWRpYXRlayx1ZnMtcGh5LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlhVGVrIFVuaXZlcnNh
bCBGbGFzaCBTdG9yYWdlIChVRlMpIE0tUEhZIGJpbmRpbmcNCisNCittYWludGFpbmVyczoNCisg
IC0gU3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlhdGVrLmNvbT4NCisgIC0gQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBV
RlMgTS1QSFkgbm9kZXMgYXJlIGRlZmluZWQgdG8gZGVzY3JpYmUgb24tY2hpcCBVRlMgTS1QSFkg
aGFyZHdhcmUgbWFjcm8uDQorICBFYWNoIFVGUyBNLVBIWSBub2RlIHNob3VsZCBoYXZlIGl0cyBv
d24gbm9kZS4NCisgIFRvIGJpbmQgVUZTIE0tUEhZIHdpdGggVUZTIGhvc3QgY29udHJvbGxlciwg
dGhlIGNvbnRyb2xsZXIgbm9kZSBzaG91bGQNCisgIGNvbnRhaW4gYSBwaGFuZGxlIHJlZmVyZW5j
ZSB0byBVRlMgTS1QSFkgbm9kZS4NCisNCitwcm9wZXJ0aWVzOg0KKyAgJG5vZGVuYW1lOg0KKyAg
ICBwYXR0ZXJuOiAiXnVmcy1waHlAWzAtOWEtZl0rJCINCisNCisgIGNvbXBhdGlibGU6DQorICAg
IGNvbnN0OiBtZWRpYXRlayxtdDgxODMtdWZzcGh5DQorDQorICByZWc6DQorICAgIG1heEl0ZW1z
OiAxDQorDQorICBjbG9ja3M6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gZGVzY3JpcHRpb246IFVu
aXBybyBjb3JlIGNvbnRyb2wgY2xvY2suDQorICAgICAgLSBkZXNjcmlwdGlvbjogTS1QSFkgY29y
ZSBjb250cm9sIGNsb2NrLg0KKw0KKyAgY2xvY2stbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAg
IC0gY29uc3Q6IHVuaXBybw0KKyAgICAgIC0gY29uc3Q6IG1wDQorDQorICAiI3BoeS1jZWxscyI6
DQorICAgIGNvbnN0OiAwDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVn
DQorICAtICIjcGh5LWNlbGxzIg0KKyAgLSBjbG9ja3MNCisgIC0gY2xvY2stbmFtZXMNCisNCith
ZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTgzLWNsay5oPg0KKyAgICB1ZnNwaHk6IHVm
cy1waHlAMTFmYTAwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
dWZzcGh5IjsNCisgICAgICAgIHJlZyA9IDwwIDB4MTFmYTAwMDAgMCAweGMwMDA+Ow0KKyAgICAg
ICAgY2xvY2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFfVU5JUFJPX1NDSz4sDQorICAgICAgICAg
ICAgICAgICA8JmluZnJhY2ZnIENMS19JTkZSQV9VRlNfTVBfU0FQX0JDTEs+Ow0KKyAgICAgICAg
Y2xvY2stbmFtZXMgPSAidW5pcHJvIiwgIm1wIjsNCisgICAgICAgICNwaHktY2VsbHMgPSA8MD47
DQorICAgIH07DQorDQorLi4uDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9waHktbXRrLXVmcy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGh5L3BoeS1tdGstdWZzLnR4dA0KZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQpp
bmRleCA1Nzg5MDI5YTFkNDIuLjAwMDAwMDAwMDAwMA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXVmcy50eHQNCisrKyAvZGV2L251bGwNCkBAIC0x
LDM4ICswLDAgQEANCi1NZWRpYVRlayBVbml2ZXJzYWwgRmxhc2ggU3RvcmFnZSAoVUZTKSBNLVBI
WSBiaW5kaW5nDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCi0NCi1VRlMgTS1QSFkgbm9kZXMgYXJlIGRlZmluZWQgdG8gZGVzY3JpYmUg
b24tY2hpcCBVRlMgTS1QSFkgaGFyZHdhcmUgbWFjcm8uDQotRWFjaCBVRlMgTS1QSFkgbm9kZSBz
aG91bGQgaGF2ZSBpdHMgb3duIG5vZGUuDQotDQotVG8gYmluZCBVRlMgTS1QSFkgd2l0aCBVRlMg
aG9zdCBjb250cm9sbGVyLCB0aGUgY29udHJvbGxlciBub2RlIHNob3VsZA0KLWNvbnRhaW4gYSBw
aGFuZGxlIHJlZmVyZW5jZSB0byBVRlMgTS1QSFkgbm9kZS4NCi0NCi1SZXF1aXJlZCBwcm9wZXJ0
aWVzIGZvciBVRlMgTS1QSFkgbm9kZXM6DQotLSBjb21wYXRpYmxlICAgICAgICAgOiBDb21wYXRp
YmxlIGxpc3QsIGNvbnRhaW5zIHRoZSBmb2xsb3dpbmcgY29udHJvbGxlcjoNCi0gICAgICAgICAg
ICAgICAgICAgICAgICJtZWRpYXRlayxtdDgxODMtdWZzcGh5IiBmb3IgdWZzIHBoeQ0KLSAgICAg
ICAgICAgICAgICAgICAgICAgcGVyc2VudCBvbiBNVDgxeHggY2hpcHNldHMuDQotLSByZWcgICAg
ICAgICAgICAgICAgOiBBZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIFVGUyBNLVBIWSByZWdpc3Rl
ciBzZXQuDQotLSAjcGh5LWNlbGxzICAgICAgICAgOiBUaGlzIHByb3BlcnR5IHNoYWxsIGJlIHNl
dCB0byAwLg0KLS0gY2xvY2tzICAgICAgICAgICAgIDogTGlzdCBvZiBwaGFuZGxlIGFuZCBjbG9j
ayBzcGVjaWZpZXIgcGFpcnMuDQotLSBjbG9jay1uYW1lcyAgICAgICAgOiBMaXN0IG9mIGNsb2Nr
IGlucHV0IG5hbWUgc3RyaW5ncyBzb3J0ZWQgaW4gdGhlIHNhbWUNCi0gICAgICAgICAgICAgICAg
ICAgICAgIG9yZGVyIGFzIHRoZSBjbG9ja3MgcHJvcGVydHkuIEZvbGxvd2luZyBjbG9ja3MgYXJl
DQotICAgICAgICAgICAgICAgICAgICAgICBtYW5kYXRvcnkuDQotICAgICAgICAgICAgICAgICAg
ICAgICAidW5pcHJvIjogVW5pcHJvIGNvcmUgY29udHJvbCBjbG9jay4NCi0gICAgICAgICAgICAg
ICAgICAgICAgICJtcCI6IE0tUEhZIGNvcmUgY29udHJvbCBjbG9jay4NCi0NCi1FeGFtcGxlOg0K
LQ0KLQl1ZnNwaHk6IHBoeUAxMWZhMDAwMCB7DQotCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE4My11ZnNwaHkiOw0KLQkJcmVnID0gPDAgMHgxMWZhMDAwMCAwIDB4YzAwMD47DQotCQkjcGh5
LWNlbGxzID0gPDA+Ow0KLQ0KLQkJY2xvY2tzID0gPCZpbmZyYWNmZ19hbyBJTkZSQUNGR19BT19V
TklQUk9fU0NLX0NHPiwNCi0JCQkgPCZpbmZyYWNmZ19hbyBJTkZSQUNGR19BT19VRlNfTVBfU0FQ
X0JDTEtfQ0c+Ow0KLQkJY2xvY2stbmFtZXMgPSAidW5pcHJvIiwgIm1wIjsNCi0JfTsNCi0NCi0J
dWZzaGNpQDExMjcwMDAwIHsNCi0JCS4uLg0KLQkJcGh5cyA9IDwmdWZzcGh5PjsNCi0JfTsNCi0t
IA0KMi4xOC4wDQo=

