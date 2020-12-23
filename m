Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073362E10D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 01:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgLWAhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 19:37:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34504 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgLWAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 19:37:04 -0500
X-UUID: 5a69bc2198a14feb9245d83e98cb8603-20201223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=xqA5Ou9eTp2m/ylc+cO93423/qpI0vhuXJVv63vcPeA=;
        b=C8RjATbaiDJhubZO6ML7gzKhkCI9GNsqB5GSdTK0HNoFMA4fGDpgSgO4VId9yDVudL4ZgYTCghv/3FB4HB+K0UlzWgEMVQR1uZVCCdoH7HHTzbaBrEaTcoz/EbkuXP/9/8U7S/UwjPFSNoE5ITPMBpAzW7UOblbvsr60rSpOkVk=;
X-UUID: 5a69bc2198a14feb9245d83e98cb8603-20201223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 147329735; Wed, 23 Dec 2020 08:36:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 08:36:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 08:36:14 +0800
Message-ID: <1608683777.18252.1.camel@mhfsdcap03>
Subject: Re: [PATCH v1, 4/5] soc: mediatek: cmdq: add address shift in jump
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Dennis YC Hsieh" <dennis-yc.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, "Rob Herring" <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 23 Dec 2020 08:36:17 +0800
In-Reply-To: <CAAOTY__2CQ5mo6f0mXNHqcOg_xUCAd7LjkXS2OCf341Dm6rNCg@mail.gmail.com>
References: <1607141728-17307-1-git-send-email-yongqiang.niu@mediatek.com>
         <1607141728-17307-5-git-send-email-yongqiang.niu@mediatek.com>
         <CANMq1KCX+iPXVg-xqVKBGNTfJty=cu+MQYaujjv4NgTd1C740A@mail.gmail.com>
         <CAAOTY__2CQ5mo6f0mXNHqcOg_xUCAd7LjkXS2OCf341Dm6rNCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTA5IGF0IDIzOjE2ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgWW9uZ3FpYW5nOg0KPiANCj4gTmljb2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJvbWl1
bS5vcmc+IOaWvCAyMDIw5bm0MTLmnIg15pelIOmAseWFrSDkuIvljYgzOjMw5a+r6YGT77yaDQo+
ID4NCj4gPiBPbiBTYXQsIERlYyA1LCAyMDIwIGF0IDEyOjE2IFBNIFlvbmdxaWFuZyBOaXUNCj4g
PiA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEFkZCBh
ZGRyZXNzIHNoaWZ0IHdoZW4gY29tcG9zZSBqdW1wIGluc3RydWN0aW9uDQo+ID4gPiB0byBjb21w
YXRpYmxlIHdpdGggMzViaXQgZm9ybWF0Lg0KPiA+DQo+ID4gVGhpcyBsb29rcyByZWFzb25hYmxl
LCBidXQgdGFzay0+Y21kcS0+c2hpZnRfcGEgaXMgbm90IG5ldyBhbmQgd2FzDQo+ID4gaW50cm9k
dWNlZCBhcyBwYXJ0IG9mIG10Njc3OSBHQ0Ugc3VwcG9ydC4NCj4gPg0KPiA+IERvIHlvdSB3YW50
IHRvIGFkZCBhIEZpeGVzIHRhZz8NCj4gPiBGaXhlczogMDg1OGZkZTQ5NmY4ICgibWFpbGJveDog
Y21kcTogdmFyaWFibGl6ZSBhZGRyZXNzIHNoaWZ0IGluIHBsYXRmb3JtIikNCj4gDQo+IEFkZCB0
aGlzIGZpeGVzIHRhZywgYW5kIG1vdmUgdGhpcyBwYXRjaCBvdXQgb2YgdGhpcyBzZXJpZXMgYmVj
YXVzZQ0KPiB0aGlzIHBhdGNoIGlzIHJlbGF0ZWQgdG8gYWxsIFNvQyB3aG9zZSBzaGlmdF9wYSBp
cyBub3QgemVyby4NCj4gDQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KDQoNCnRoZSBu
ZXh0IHZlcnNpb24gd2lsbCBtb3ZlIHRoaXMgb3V0IG9mIDgxOTIgc2VyaWVzIGFuZCBhZGQgZml4
ZWQgdGFncw0KDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogTmljb2xhcyBCb2ljaGF0IDxkcmlua2Nh
dEBjaHJvbWl1bS5vcmc+DQo+ID4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlh
bmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRy
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAzICsrLQ0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+IGluZGV4IDFjMDFmZTAuLjVlZDM5ZjggMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4g
PiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiBAQCAtMTc0
LDcgKzE3NCw4IEBAIHN0YXRpYyB2b2lkIGNtZHFfdGFza19pbnNlcnRfaW50b190aHJlYWQoc3Ry
dWN0IGNtZHFfdGFzayAqdGFzaykNCj4gPiA+ICAgICAgICAgZG1hX3N5bmNfc2luZ2xlX2Zvcl9j
cHUoZGV2LCBwcmV2X3Rhc2stPnBhX2Jhc2UsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHByZXZfdGFzay0+cGt0LT5jbWRfYnVmX3NpemUsIERNQV9UT19ERVZJQ0UpOw0K
PiA+ID4gICAgICAgICBwcmV2X3Rhc2tfYmFzZVtDTURRX05VTV9DTUQocHJldl90YXNrLT5wa3Qp
IC0gMV0gPQ0KPiA+ID4gLSAgICAgICAgICAgICAgICh1NjQpQ01EUV9KVU1QX0JZX1BBIDw8IDMy
IHwgdGFzay0+cGFfYmFzZTsNCj4gPiA+ICsgICAgICAgICAgICAgICAodTY0KUNNRFFfSlVNUF9C
WV9QQSA8PCAzMiB8DQo+ID4gPiArICAgICAgICAgICAgICAgKHRhc2stPnBhX2Jhc2UgPj4gdGFz
ay0+Y21kcS0+c2hpZnRfcGEpOw0KPiA+ID4gICAgICAgICBkbWFfc3luY19zaW5nbGVfZm9yX2Rl
dmljZShkZXYsIHByZXZfdGFzay0+cGFfYmFzZSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcHJldl90YXNrLT5wa3QtPmNtZF9idWZfc2l6ZSwgRE1BX1RPX0RFVklD
RSk7DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDEuOC4xLjEuZGlydHkNCj4gPiA+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gPiBMaW51eC1tZWRp
YXRlayBtYWlsaW5nIGxpc3QNCj4gPiA+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbWVkaWF0ZWsNCj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gTGludXgt
bWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0K

