Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5528CA94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404119AbgJMIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:52:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55200 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404062AbgJMIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:52:19 -0400
X-UUID: 2eca91f15b4648e78c5e2468ff22dda3-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yU/qMyuYQN6+jcF7wWybgjSPMFFe8LTU7oNijK5E7Ac=;
        b=mdE5OkwS7XoF1a4imm1CsUV4/G8+WSHVxgdfw8rdWQpzpHCnrkgx9RT61h/4Bv7uiaiMh3j9ZM3yedCk1kCirp7aq/P9fYhDqe7flLGvTrns5Xx1nHF6pDNH9OthQONwqNZa4FKUa7pcW+lzL2gEqrRXbr6Nm4tuDDDCRCQi/B0=;
X-UUID: 2eca91f15b4648e78c5e2468ff22dda3-20201013
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1789263465; Tue, 13 Oct 2020 16:52:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v2 3/8] dt-bindings: phy: convert phy-mtk-ufs.txt to YAML schema
Date:   Tue, 13 Oct 2020 16:52:02 +0800
Message-ID: <20201013085207.17749-3-chunfeng.yun@mediatek.com>
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

Q29udmVydCBwaHktbXRrLXVmcy50eHQgdG8gWUFNTCBzY2hlbWEgbWVkaWF0ZWssdWZzLXBoeS55
YW1sDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KdjI6IGZpeCBiaW5kaW5nIGNoZWNrIHdhcm5pbmcgb2YgcmVnIGluIGV4YW1w
bGUNCi0tLQ0KIC4uLi9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55YW1sICAgICAgICB8
IDY0ICsrKysrKysrKysrKysrKysrKysNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5
LW10ay11ZnMudHh0ICAgfCAzOCAtLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNjQgaW5z
ZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55YW1sDQogZGVs
ZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5
LW10ay11ZnMudHh0DQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGh5L21lZGlhdGVrLHVmcy1waHkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KaW5kZXggMDAwMDAwMDAwMDAwLi4zYTliZTgyZTdmMTMNCi0tLSAvZGV2L251bGwNCisrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdWZzLXBoeS55
YW1sDQpAQCAtMCwwICsxLDY0IEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0y
LjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQorIyBDb3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsN
CislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Bo
eS9tZWRpYXRlayx1ZnMtcGh5LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlhVGVrIFVuaXZlcnNhbCBG
bGFzaCBTdG9yYWdlIChVRlMpIE0tUEhZIGJpbmRpbmcNCisNCittYWludGFpbmVyczoNCisgIC0g
U3RhbmxleSBDaHUgPHN0YW5sZXkuY2h1QG1lZGlhdGVrLmNvbT4NCisgIC0gQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBVRlMg
TS1QSFkgbm9kZXMgYXJlIGRlZmluZWQgdG8gZGVzY3JpYmUgb24tY2hpcCBVRlMgTS1QSFkgaGFy
ZHdhcmUgbWFjcm8uDQorICBFYWNoIFVGUyBNLVBIWSBub2RlIHNob3VsZCBoYXZlIGl0cyBvd24g
bm9kZS4NCisgIFRvIGJpbmQgVUZTIE0tUEhZIHdpdGggVUZTIGhvc3QgY29udHJvbGxlciwgdGhl
IGNvbnRyb2xsZXIgbm9kZSBzaG91bGQNCisgIGNvbnRhaW4gYSBwaGFuZGxlIHJlZmVyZW5jZSB0
byBVRlMgTS1QSFkgbm9kZS4NCisNCitwcm9wZXJ0aWVzOg0KKyAgJG5vZGVuYW1lOg0KKyAgICBw
YXR0ZXJuOiAiXnVmcy1waHlAWzAtOWEtZl0rJCINCisNCisgIGNvbXBhdGlibGU6DQorICAgIGNv
bnN0OiBtZWRpYXRlayxtdDgxODMtdWZzcGh5DQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAx
DQorDQorICBjbG9ja3M6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gZGVzY3JpcHRpb246IFVuaXBy
byBjb3JlIGNvbnRyb2wgY2xvY2suDQorICAgICAgLSBkZXNjcmlwdGlvbjogTS1QSFkgY29yZSBj
b250cm9sIGNsb2NrLg0KKw0KKyAgY2xvY2stbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0g
Y29uc3Q6IHVuaXBybw0KKyAgICAgIC0gY29uc3Q6IG1wDQorDQorICAiI3BoeS1jZWxscyI6DQor
ICAgIGNvbnN0OiAwDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQor
ICAtICIjcGh5LWNlbGxzIg0KKyAgLSBjbG9ja3MNCisgIC0gY2xvY2stbmFtZXMNCisNCithZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTgzLWNsay5oPg0KKyAgICB1ZnNwaHk6IHVmcy1w
aHlAMTFmYTAwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtdWZz
cGh5IjsNCisgICAgICAgIHJlZyA9IDwweDExZmEwMDAwIDB4YzAwMD47DQorICAgICAgICBjbG9j
a3MgPSA8JmluZnJhY2ZnIENMS19JTkZSQV9VTklQUk9fU0NLPiwNCisgICAgICAgICAgICAgICAg
IDwmaW5mcmFjZmcgQ0xLX0lORlJBX1VGU19NUF9TQVBfQkNMSz47DQorICAgICAgICBjbG9jay1u
YW1lcyA9ICJ1bmlwcm8iLCAibXAiOw0KKyAgICAgICAgI3BoeS1jZWxscyA9IDwwPjsNCisgICAg
fTsNCisNCisuLi4NCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L3BoeS1tdGstdWZzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9waHkvcGh5LW10ay11ZnMudHh0DQpkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDU3
ODkwMjlhMWQ0Mi4uMDAwMDAwMDAwMDAwDQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGh5L3BoeS1tdGstdWZzLnR4dA0KKysrIC9kZXYvbnVsbA0KQEAgLTEsMzggKzAs
MCBAQA0KLU1lZGlhVGVrIFVuaXZlcnNhbCBGbGFzaCBTdG9yYWdlIChVRlMpIE0tUEhZIGJpbmRp
bmcNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KLQ0KLVVGUyBNLVBIWSBub2RlcyBhcmUgZGVmaW5lZCB0byBkZXNjcmliZSBvbi1jaGlw
IFVGUyBNLVBIWSBoYXJkd2FyZSBtYWNyby4NCi1FYWNoIFVGUyBNLVBIWSBub2RlIHNob3VsZCBo
YXZlIGl0cyBvd24gbm9kZS4NCi0NCi1UbyBiaW5kIFVGUyBNLVBIWSB3aXRoIFVGUyBob3N0IGNv
bnRyb2xsZXIsIHRoZSBjb250cm9sbGVyIG5vZGUgc2hvdWxkDQotY29udGFpbiBhIHBoYW5kbGUg
cmVmZXJlbmNlIHRvIFVGUyBNLVBIWSBub2RlLg0KLQ0KLVJlcXVpcmVkIHByb3BlcnRpZXMgZm9y
IFVGUyBNLVBIWSBub2RlczoNCi0tIGNvbXBhdGlibGUgICAgICAgICA6IENvbXBhdGlibGUgbGlz
dCwgY29udGFpbnMgdGhlIGZvbGxvd2luZyBjb250cm9sbGVyOg0KLSAgICAgICAgICAgICAgICAg
ICAgICAgIm1lZGlhdGVrLG10ODE4My11ZnNwaHkiIGZvciB1ZnMgcGh5DQotICAgICAgICAgICAg
ICAgICAgICAgICBwZXJzZW50IG9uIE1UODF4eCBjaGlwc2V0cy4NCi0tIHJlZyAgICAgICAgICAg
ICAgICA6IEFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgVUZTIE0tUEhZIHJlZ2lzdGVyIHNldC4N
Ci0tICNwaHktY2VsbHMgICAgICAgICA6IFRoaXMgcHJvcGVydHkgc2hhbGwgYmUgc2V0IHRvIDAu
DQotLSBjbG9ja3MgICAgICAgICAgICAgOiBMaXN0IG9mIHBoYW5kbGUgYW5kIGNsb2NrIHNwZWNp
ZmllciBwYWlycy4NCi0tIGNsb2NrLW5hbWVzICAgICAgICA6IExpc3Qgb2YgY2xvY2sgaW5wdXQg
bmFtZSBzdHJpbmdzIHNvcnRlZCBpbiB0aGUgc2FtZQ0KLSAgICAgICAgICAgICAgICAgICAgICAg
b3JkZXIgYXMgdGhlIGNsb2NrcyBwcm9wZXJ0eS4gRm9sbG93aW5nIGNsb2NrcyBhcmUNCi0gICAg
ICAgICAgICAgICAgICAgICAgIG1hbmRhdG9yeS4NCi0gICAgICAgICAgICAgICAgICAgICAgICJ1
bmlwcm8iOiBVbmlwcm8gY29yZSBjb250cm9sIGNsb2NrLg0KLSAgICAgICAgICAgICAgICAgICAg
ICAgIm1wIjogTS1QSFkgY29yZSBjb250cm9sIGNsb2NrLg0KLQ0KLUV4YW1wbGU6DQotDQotCXVm
c3BoeTogcGh5QDExZmEwMDAwIHsNCi0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXVm
c3BoeSI7DQotCQlyZWcgPSA8MCAweDExZmEwMDAwIDAgMHhjMDAwPjsNCi0JCSNwaHktY2VsbHMg
PSA8MD47DQotDQotCQljbG9ja3MgPSA8JmluZnJhY2ZnX2FvIElORlJBQ0ZHX0FPX1VOSVBST19T
Q0tfQ0c+LA0KLQkJCSA8JmluZnJhY2ZnX2FvIElORlJBQ0ZHX0FPX1VGU19NUF9TQVBfQkNMS19D
Rz47DQotCQljbG9jay1uYW1lcyA9ICJ1bmlwcm8iLCAibXAiOw0KLQl9Ow0KLQ0KLQl1ZnNoY2lA
MTEyNzAwMDAgew0KLQkJLi4uDQotCQlwaHlzID0gPCZ1ZnNwaHk+Ow0KLQl9Ow0KLS0gDQoyLjE4
LjANCg==

