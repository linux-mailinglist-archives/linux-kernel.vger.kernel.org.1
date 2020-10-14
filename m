Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DBC28E152
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgJNNaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:30:16 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:35847 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728394AbgJNNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:30:16 -0400
X-UUID: 5762cb86c8f74d258992e45f5ce60326-20201014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tckxlqhn5eQcZMpW9b8021KQ2cNKwzjDNMrYHA4GmME=;
        b=ao36OYAFXVl/HV/IcSTrHQl0y1DgN6NJpQqEg8cV+YuThIhdHL3hwGDQCLu8cC8yNtKBzQe2uF/c/xNwRojELr4aeawfqXW62tX6RaEIZm7/0JpeeoBh8UqSUyKL6kE8Zy5/ojaFlnhU0YgfrYUNhKx0tG5bZnZL9ZokH+XQECI=;
X-UUID: 5762cb86c8f74d258992e45f5ce60326-20201014
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1257907783; Wed, 14 Oct 2020 21:30:06 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Oct
 2020 21:30:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Oct 2020 21:30:03 +0800
Message-ID: <1602682204.14806.53.camel@mhfsdcap03>
Subject: Re: [v6,1/3] dt-binding: reset-controller: mediatek: add YAML
 schemas
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     srv_heupstream <srv_heupstream@mediatek.com>,
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
Date:   Wed, 14 Oct 2020 21:30:04 +0800
In-Reply-To: <20200930022159.5559-2-crystal.guo@mediatek.com>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
         <20200930022159.5559-2-crystal.guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 41791D005C9335D5F39C2B4293C82C0E7193625AFD810F4D058E601C57B8D2622000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFpbnRhaW5lcnMsDQoNCkdlbnRsZSBwaW5nIGZvciB0aGlzIHBhdGNoIHNldC4NCg0KTWFu
eSB0aGFua3MNCkNyeXN0YWwNCg0KT24gV2VkLCAyMDIwLTA5LTMwIGF0IDEwOjIxICswODAwLCBD
cnlzdGFsIEd1byB3cm90ZToNCj4gQWRkIGEgWUFNTCBkb2N1bWVudGF0aW9uIGZvciBNZWRpYXRl
aywgd2hpY2ggdXNlcyB0aSByZXNldC1jb250cm9sbGVyDQo+IGRyaXZlciBkaXJlY3RseS4gVGhl
IFRJIHJlc2V0IGNvbnRyb2xsZXIgcHJvdmlkZXMgYSBjb21tb24gcmVzZXQNCj4gbWFuYWdlbWVu
dCwgYW5kIGlzIHN1aXRhYmxlIGZvciBNZWRpYXRlayBTb0NzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICAuLi4v
YmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwgfCA1MSArKysrKysrKysr
KysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tZWRp
YXRlay1zeXNjb24tcmVzZXQueWFtbA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVz
ZXQueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjc4
NzE1NTBjM2M2OQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbA0KPiBAQCAtMCww
ICsxLDUxIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1yZXNldC55YW1sIw0KPiAr
JHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+
ICsNCj4gK3RpdGxlOiBNZWRpYXRlayBSZXNldCBDb250cm9sbGVyDQo+ICsNCj4gK21haW50YWlu
ZXJzOg0KPiArICAtIENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRpYXRlay5jb20+DQo+ICsN
Cj4gK2Rlc2NyaXB0aW9uOg0KPiArICBUaGUgYmluZGluZ3MgZGVzY3JpYmUgdGhlIHJlc2V0LWNv
bnRyb2xsZXIgZm9yIE1lZGlhdGVrIFNvQ3MsDQo+ICsgIHdoaWNoIGlzIGJhc2VkIG9uIFRJIHJl
c2V0IGNvbnRyb2xsZXIuIEZvciBtb3JlIGRldGFpbCwgcGxlYXNlDQo+ICsgIHZpc2l0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0Lg0K
PiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGNvbnN0OiBtZWRp
YXRlayxzeXNjb24tcmVzZXQNCj4gKw0KPiArICAnI3Jlc2V0LWNlbGxzJzoNCj4gKyAgICBjb25z
dDogMQ0KPiArDQo+ICsgIG1lZGlhdGVrLHJlc2V0LWJpdHM6DQo+ICsgICAgZGVzY3JpcHRpb246
ID4NCj4gKyAgICAgIENvbnRhaW5zIHRoZSByZXNldCBjb250cm9sIHJlZ2lzdGVyIGluZm9ybWF0
aW9uLCBwbGVhc2UgcmVmZXIgdG8NCj4gKyAgICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0Lg0KPiArDQo+ICtyZXF1aXJlZDoNCj4g
KyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gJyNyZXNldC1jZWxscycNCj4gKyAgLSBtZWRpYXRlayxy
ZXNldC1iaXRzDQo+ICsNCj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+ICtl
eGFtcGxlczoNCj4gKyAgLSB8DQo+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Jlc2V0L3Rp
LXN5c2Nvbi5oPg0KPiArICAgIGluZnJhY2ZnOiBpbmZyYWNmZ0AxMDAwMTAwMCB7DQo+ICsgICAg
ICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWluZnJhY2ZnIiwgInN5c2NvbiIsICJz
aW1wbGUtbWZkIjsNCj4gKyAgICAgICAgcmVnID0gPDAgMHgxMDAwMTAwMD47DQo+ICsgICAgICAg
ICNjbG9jay1jZWxscyA9IDwxPjsNCj4gKw0KPiArICAgICAgICBpbmZyYWNmZ19yc3Q6IHJlc2V0
LWNvbnRyb2xsZXIgew0KPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxzeXNj
b24tcmVzZXQiOw0KPiArICAgICAgICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiArICAgICAg
ICAgICAgbWVkaWF0ZWsscmVzZXQtYml0cyA9IDwNCj4gKyAgICAgICAgICAgICAgIDB4MTQwIDE1
IDB4MTQ0IDE1IDAgMCAoQVNTRVJUX1NFVCB8IERFQVNTRVJUX1NFVCB8IFNUQVRVU19OT05FKQ0K
PiArICAgICAgICAgICAgPjsNCj4gKyAgICAgICAgfTsNCj4gKyAgICB9Ow0KDQo=

