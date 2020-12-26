Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49162E2DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgLZJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 04:07:55 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17010 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725865AbgLZJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 04:07:54 -0500
X-UUID: 1ed381be758846dca170dd3452a5d319-20201226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SlEDBqr6pqTI7qWfhu/ALj97BCMwtKpquEMZ16ReOls=;
        b=k76dwY/LHyP9BagZ4RTbOVoLM8aX/37q5B+gZz4PeaTwf4ku+YUyQ9M0gxDWlNV1+IFXYFcQP2qO/niQMgXD4Xu21iG+SOdFF5Yr6HGEtXyacnCYR3dy6IfBuqItWrZJxTgb0SDakQQoWK9Nd4TnxyeynFBcEkXPlISH616Sccs=;
X-UUID: 1ed381be758846dca170dd3452a5d319-20201226
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1557492347; Sat, 26 Dec 2020 17:08:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 26 Dec
 2020 17:06:52 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Dec 2020 17:06:53 +0800
Message-ID: <1608973616.14806.79.camel@mhfsdcap03>
Subject: Re: [v6,1/3] dt-binding: reset-controller: mediatek: add YAML
 schemas
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s-anna@ti.com" <s-anna@ti.com>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?=" 
        <Yong.Liang@mediatek.com>
Date:   Sat, 26 Dec 2020 17:06:56 +0800
In-Reply-To: <230c34e8a973140ebb7f155f5527050408f0c438.camel@pengutronix.de>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
         <20200930022159.5559-2-crystal.guo@mediatek.com>
         <230c34e8a973140ebb7f155f5527050408f0c438.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CC6C40D32C38A3E17A270A2E49EE5F45BF57B0C9132D9BE69FA5F9432ABFB6882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE1OjQxICswODAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIFdlZCwgMjAyMC0wOS0zMCBhdCAxMDoyMSArMDgwMCwgQ3J5c3RhbCBH
dW8gd3JvdGU6DQo+ID4gQWRkIGEgWUFNTCBkb2N1bWVudGF0aW9uIGZvciBNZWRpYXRlaywgd2hp
Y2ggdXNlcyB0aSByZXNldC1jb250cm9sbGVyDQo+ID4gZHJpdmVyIGRpcmVjdGx5LiBUaGUgVEkg
cmVzZXQgY29udHJvbGxlciBwcm92aWRlcyBhIGNvbW1vbiByZXNldA0KPiA+IG1hbmFnZW1lbnQs
IGFuZCBpcyBzdWl0YWJsZSBmb3IgTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICAuLi4vYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwgfCA1MSArKysr
KysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVzZXQvbWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1y
ZXNldC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L21lZGlh
dGVrLXN5c2Nvbi1yZXNldC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjc4NzE1NTBjM2M2OQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29u
LXJlc2V0LnlhbWwNCj4gPiBAQCAtMCwwICsxLDUxIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFNTCAxLjIN
Cj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcmVzZXQv
bWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlh
dGVrIFJlc2V0IENvbnRyb2xsZXINCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0g
Q3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2Ny
aXB0aW9uOg0KPiA+ICsgIFRoZSBiaW5kaW5ncyBkZXNjcmliZSB0aGUgcmVzZXQtY29udHJvbGxl
ciBmb3IgTWVkaWF0ZWsgU29DcywNCj4gPiArICB3aGljaCBpcyBiYXNlZCBvbiBUSSByZXNldCBj
b250cm9sbGVyLiBGb3IgbW9yZSBkZXRhaWwsIHBsZWFzZQ0KPiA+ICsgIHZpc2l0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0Lg0KPiA+
ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6
IG1lZGlhdGVrLHN5c2Nvbi1yZXNldA0KPiA+ICsNCj4gPiArICAnI3Jlc2V0LWNlbGxzJzoNCj4g
PiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLHJlc2V0LWJpdHM6DQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogPg0KPiA+ICsgICAgICBDb250YWlucyB0aGUgcmVzZXQgY29udHJv
bCByZWdpc3RlciBpbmZvcm1hdGlvbiwgcGxlYXNlIHJlZmVyIHRvDQo+ID4gKyAgICAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0Lg0K
PiANCj4gSSB3b3VsZCByZWFsbHkgbGlrZSBzb21lIGlucHV0IGZyb20gUm9iIG9uIHRoaXMsIGlu
IHY0IGhlIGFza2VkIG5vdCB0bw0KPiByZXBlYXQgJ3RpLHJlc2V0LWJpdHMnLg0KPiANCj4gcmVn
YXJkcw0KPiBQaGlsaXBwDQoNCg0KSGkgUm9iLA0KDQpDYW4geW91IGdpdmUgc29tZSBzdWdnZXN0
aW9ucyBvbiB0aGlzIGRvY3VtZW50DQoibWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwiLCBtYW55
IHRoYW5rc34NCg0KcmVnYXJkcw0KQ3J5c3RhbCBHdW8NCg0K

