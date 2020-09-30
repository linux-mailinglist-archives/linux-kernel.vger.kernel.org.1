Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC62B27DE89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgI3CbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:31:04 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31684 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729446AbgI3CbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:31:04 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 22:31:02 EDT
X-UUID: fe31606e6cc3441f99ebff7d0d465015-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FPhHR58XeaLRoJ4yRG0FFx7jDt7EJ3VRl8a75Zvvs3o=;
        b=GwV4YRWnVvSNUyEh/57CZrSCJPacuk3fzz4B+Ui152nZIeWlxxvm9XT4E0aVN1g3MOXMcCF926gcVeYU3jGNKmIm5qPOSopTa9ngsoYkZin/Wx3P1NVrwpUAMb/0+dZXzj5/4Wjh0xBv6SKksp0NYJoOHvlblM7NNhjjkZBnzV4=;
X-UUID: fe31606e6cc3441f99ebff7d0d465015-20200930
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 795390689; Wed, 30 Sep 2020 10:25:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Sep
 2020 10:25:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 10:25:48 +0800
Message-ID: <1601432748.14806.39.camel@mhfsdcap03>
Subject: Re: [v5,1/3] dt-binding: reset-controller: mediatek: add YAML
 schemas
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?=" 
        <Yingjoe.Chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?= 
        <Yong.Liang@mediatek.com>
Date:   Wed, 30 Sep 2020 10:25:48 +0800
In-Reply-To: <20200929154845.GA662033@bogus>
References: <20200929134642.26561-1-crystal.guo@mediatek.com>
         <20200929134642.26561-2-crystal.guo@mediatek.com>
         <20200929154845.GA662033@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7E20F32A211AA1F1D02E05A08D0CC71DFBC3DC598235B15E6056F5EF68E72CC72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTI5IGF0IDIzOjQ4ICswODAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCAyOSBTZXAgMjAyMCAyMTo0Njo0MCArMDgwMCwgQ3J5c3RhbCBHdW8gd3JvdGU6DQo+
ID4gQWRkIGEgWUFNTCBkb2N1bWVudGF0aW9uIGZvciBNZWRpYXRlaywgd2hpY2ggdXNlcyB0aSBy
ZXNldC1jb250cm9sbGVyDQo+ID4gZHJpdmVyIGRpcmVjdGx5LiBUaGUgVEkgcmVzZXQgY29udHJv
bGxlciBwcm92aWRlcyBhIGNvbW1vbiByZXNldCBtYW5hZ2VtZW50LA0KPiA+IGFuZCBpcyBzdWl0
YWJsZSBmb3IgTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDcnlzdGFs
IEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGlu
Z3MvcmVzZXQvbWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwgfCA1MSArKysrKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVkaWF0
ZWstc3lzY29uLXJlc2V0LnlhbWwNCj4gPiANCj4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3Jz
IHJ1bm5pbmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IC9i
dWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1yZXNldC5leGFtcGxlLmR0LnlhbWw6IGV4
YW1wbGUtMDogaW5mcmFjZmdAMTAwMDEwMDA6cmVnOjA6IFswLCAyNjg0Mzk1NTIsIDAsIDQwOTZd
IGlzIHRvbyBsb25nDQo+IAlGcm9tIHNjaGVtYTogL3Vzci9sb2NhbC9saWIvcHl0aG9uMy44L2Rp
c3QtcGFja2FnZXMvZHRzY2hlbWEvc2NoZW1hcy9yZWcueWFtbA0KPiANCj4gDQo+IFNlZSBodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEzNzM0MjgNCj4gDQo+IElmIHlvdSBhbHJl
YWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUN
Cj4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJlIGR0LXNjaGVtYSBpcyB1cCB0byBkYXRlOg0KPiAN
Cj4gcGlwMyBpbnN0YWxsIGdpdCtodHRwczovL2dpdGh1Yi5jb20vZGV2aWNldHJlZS1vcmcvZHQt
c2NoZW1hLmdpdEBtYXN0ZXIgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1
Ym1pdC4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciByZW1pbmQsIHJlLXN1Ym1pdCBhdDoNCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE4MDc3MjEvDQoNCg0K

