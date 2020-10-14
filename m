Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7C28D95C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 06:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgJNEoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 00:44:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49647 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726037AbgJNEoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 00:44:38 -0400
X-UUID: 18ebda2e8bf74f3095a7a10152753375-20201014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=x91QPLRNfibON85F9Jml+ohJ1lXenPHGO335BQtB9sE=;
        b=TkmPB3Asx3A3tAuOhtUvOJ/an4GLImdom4xnu2GyuqJibgVxpjk67Gz4xUfdNZ4XWl/1k7Mtql8Xg4u4jnB30Oc8gwKwpl9Q4BoIHYAFCClDVEmxupIAgAF2zYh1HYiTGr5AuSs9VpDFP+b9GrTplju/Apckqqvix0gNfnrVi4U=;
X-UUID: 18ebda2e8bf74f3095a7a10152753375-20201014
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 262329850; Wed, 14 Oct 2020 12:44:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Oct 2020 12:44:30 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Oct 2020 12:44:30 +0800
Message-ID: <1602650671.27998.2.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/8] dt-bindings: phy: convert HDMI PHY binding to
 YAML schema
From:   CK Hu <ck.hu@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Min Guo <min.guo@mediatek.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Date:   Wed, 14 Oct 2020 12:44:31 +0800
In-Reply-To: <20201013085207.17749-4-chunfeng.yun@mediatek.com>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
         <20201013085207.17749-4-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENodW5mZW5nOg0KDQpPbiBUdWUsIDIwMjAtMTAtMTMgYXQgMTY6NTIgKzA4MDAsIENodW5m
ZW5nIFl1biB3cm90ZToNCj4gQ29udmVydCBIRE1JIFBIWSBiaW5kaW5nIHRvIFlBTUwgc2NoZW1h
IG1lZGlhdGVrLHVmcy1waHkueWFtbA0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gdjI6IGZpeCBiaW5kaW5nIGNo
ZWNrIHdhcm5pbmcgb2YgcmVnIGluIGV4YW1wbGUNCj4gLS0tDQo+ICAuLi4vZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxoZG1pLnR4dCAgICAgICAgfCAxNyArLS0tDQo+ICAuLi4vYmluZGluZ3Mv
cGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwgICAgICAgfCA5MCArKysrKysrKysrKysrKysrKysr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGhkbWkudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssaGRtaS50eHQNCj4gaW5kZXggN2IxMjQyNDJiMGM1Li5lZGFjMTg5NTFhNzUgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGhkbWkudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGhkbWkudHh0DQo+IEBAIC01MCwyMiAr
NTAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgDQo+ICBIRE1JIFBIWQ0KPiAgPT09PT09
PT0NCj4gLQ0KPiAtVGhlIEhETUkgUEhZIHNlcmlhbGl6ZXMgdGhlIEhETUkgZW5jb2RlcidzIHRo
cmVlIGNoYW5uZWwgMTAtYml0IHBhcmFsbGVsDQo+IC1vdXRwdXQgYW5kIGRyaXZlcyB0aGUgSERN
SSBwYWRzLg0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBjb21wYXRpYmxlOiAi
bWVkaWF0ZWssPGNoaXA+LWhkbWktcGh5Ig0KPiAtLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVz
cyBhbmQgbGVuZ3RoIG9mIHRoZSBtb2R1bGUncyByZWdpc3RlcnMNCj4gLS0gY2xvY2tzOiBQTEwg
cmVmZXJlbmNlIGNsb2NrDQo+IC0tIGNsb2NrLW5hbWVzOiBtdXN0IGNvbnRhaW4gInBsbF9yZWYi
DQo+IC0tIGNsb2NrLW91dHB1dC1uYW1lczogbXVzdCBiZSAiaGRtaXR4X2RpZ19jdHMiIG9uIG10
ODE3Mw0KPiAtLSAjcGh5LWNlbGxzOiBtdXN0IGJlIDwwPg0KPiAtLSAjY2xvY2stY2VsbHM6IG11
c3QgYmUgPDA+DQo+IC0NCj4gLU9wdGlvbmFsIHByb3BlcnRpZXM6DQo+IC0tIG1lZGlhdGVrLGli
aWFzOiBUWCBEUlYgYmlhcyBjdXJyZW50IGZvciA8MS42NUdicHMsIGRlZmF1bHRzIHRvIDB4YQ0K
PiAtLSBtZWRpYXRlayxpYmlhc191cDogVFggRFJWIGJpYXMgY3VycmVudCBmb3IgPjEuNjVHYnBz
LCBkZWZhdWx0cyB0byAweDFjDQo+ICtTZWUgcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwNCj4g
IA0KPiAgRXhhbXBsZToNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sDQo+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNzdkZjUwMjA0NjA2DQo+IC0tLSAv
ZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9t
ZWRpYXRlayxoZG1pLXBoeS55YW1sDQo+IEBAIC0wLDAgKzEsOTAgQEANCj4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArIyBDb3B5
cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sIw0K
PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
DQo+ICsNCj4gK3RpdGxlOiBNZWRpYVRlayBIaWdoIERlZmluaXRpb24gTXVsdGltZWRpYSBJbnRl
cmZhY2UgKEhETUkpIFBIWSBiaW5kaW5nDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCkkgdGhpbmsgeW91IHNob3VsZCByZW1vdmUgIkNL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+IiBhbmQgYWRkIGxhdGVzdA0KbWVkaWF0ZWsgZHJtIG1h
aW50YWluZXI6DQoNCkRSTSBEUklWRVJTIEZPUiBNRURJQVRFSw0KTToJQ2h1bi1LdWFuZyBIdSA8
Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQpNOglQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1
dHJvbml4LmRlPg0KTDoJZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KUzoJU3VwcG9y
dGVkDQpGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRl
ay8NCkY6CWRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay8NCg0KUmVnYXJkcywNCkNLDQoNCj4gKyAg
LSBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ICsNCj4gK2Rlc2Ny
aXB0aW9uOiB8DQo+ICsgIFRoZSBIRE1JIFBIWSBzZXJpYWxpemVzIHRoZSBIRE1JIGVuY29kZXIn
cyB0aHJlZSBjaGFubmVsIDEwLWJpdCBwYXJhbGxlbA0KPiArICBvdXRwdXQgYW5kIGRyaXZlcyB0
aGUgSERNSSBwYWRzLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICAkbm9kZW5hbWU6DQo+ICsg
ICAgcGF0dGVybjogIl5oZG1pLXBoeUBbMC05YS1mXSskIg0KPiArDQo+ICsgIGNvbXBhdGlibGU6
DQo+ICsgICAgZW51bToNCj4gKyAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5DQo+ICsg
ICAgICAtIG1lZGlhdGVrLG10ODE3My1oZG1pLXBoeQ0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBt
YXhJdGVtczogMQ0KPiArDQo+ICsgIGNsb2NrczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IFBMTCByZWZlcmVuY2UgY2xvY2sNCj4gKw0KPiArICBjbG9jay1uYW1lczoN
Cj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6IHBsbF9yZWYNCj4gKw0KPiArICBjbG9j
ay1vdXRwdXQtbmFtZXM6DQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBoZG1pdHhf
ZGlnX2N0cw0KPiArDQo+ICsgICIjcGh5LWNlbGxzIjoNCj4gKyAgICBjb25zdDogMA0KPiArDQo+
ICsgICIjY2xvY2stY2VsbHMiOg0KPiArICAgIGNvbnN0OiAwDQo+ICsNCj4gKyAgbWVkaWF0ZWss
aWJpYXM6DQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICBUWCBEUlYgYmlhcyBjdXJyZW50
IGZvciA8IDEuNjVHYnBzDQo+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5p
dGlvbnMvdWludDMyDQo+ICsgICAgbWluaW11bTogMA0KPiArICAgIG1heGltdW06IDYzDQo+ICsg
ICAgZGVmYXVsdDogMHhhDQo+ICsNCj4gKyAgbWVkaWF0ZWssaWJpYXNfdXA6DQo+ICsgICAgZGVz
Y3JpcHRpb246DQo+ICsgICAgICBUWCBEUlYgYmlhcyBjdXJyZW50IGZvciA+PSAxLjY1R2Jwcw0K
PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiAr
ICAgIG1pbmltdW06IDANCj4gKyAgICBtYXhpbXVtOiA2Mw0KPiArICAgIGRlZmF1bHQ6IDB4MWMN
Cj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAt
IGNsb2Nrcw0KPiArICAtIGNsb2NrLW5hbWVzDQo+ICsgIC0gY2xvY2stb3V0cHV0LW5hbWVzDQo+
ICsgIC0gIiNwaHktY2VsbHMiDQo+ICsgIC0gIiNjbG9jay1jZWxscyINCj4gKw0KPiArYWRkaXRp
b25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAg
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTczLWNsay5oPg0KPiArICAgIGhkbWlf
cGh5OiBoZG1pLXBoeUAxMDIwOTEwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTczLWhkbWktcGh5IjsNCj4gKyAgICAgICAgcmVnID0gPDB4MTAyMDkxMDAgMHgyND47
DQo+ICsgICAgICAgIGNsb2NrcyA9IDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9IRE1JX1JFRj47
DQo+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gInBsbF9yZWYiOw0KPiArICAgICAgICBjbG9jay1v
dXRwdXQtbmFtZXMgPSAiaGRtaXR4X2RpZ19jdHMiOw0KPiArICAgICAgICBtZWRpYXRlayxpYmlh
cyA9IDwweGE+Ow0KPiArICAgICAgICBtZWRpYXRlayxpYmlhc191cCA9IDwweDFjPjsNCj4gKyAg
ICAgICAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiArICAgICAgICAjcGh5LWNlbGxzID0gPDA+Ow0K
PiArICAgIH07DQo+ICsNCj4gKy4uLg0KDQo=

