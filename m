Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5829FC46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJ3DrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:47:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725780AbgJ3DrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:47:09 -0400
X-UUID: 32279de61a844f29b82985ddfae5acb4-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KLiLvyxExc2xjvd/BMtMmzQJRvshLItb8K0fl1F3uQs=;
        b=ElJn/IeLp5ybke3a2FrjLI0VoHQKdYQnxH+I/gR/1ZPnCFLf6SuwGT//Sychi3fYaUv8FsCHai/h2Sas9O4emCkGke7iuaWkRMTdGHJtp4wC3N65qrihHAA0MxNc4vg2BUI4GKlJpDdCzkiWXx0roYIAQjUZ8CD7/tafN5Thg34=;
X-UUID: 32279de61a844f29b82985ddfae5acb4-20201030
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1301954459; Fri, 30 Oct 2020 11:46:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 30 Oct
 2020 11:46:54 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 11:46:47 +0800
Message-ID: <1604029608.31607.10.camel@mhfsdcap03>
Subject: Re: [PATCH 02/17] phy: amlogic: convert to
 devm_platform_ioremap_resource
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Remi Pommarel <repk@triplefau.lt>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        "Rikard Falkeborn" <rikard.falkeborn@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Joe Perches <joe@perches.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Anil Varughese <aniljoy@cadence.com>, Li Jun <jun.li@nxp.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 30 Oct 2020 11:46:48 +0800
In-Reply-To: <20201029082415.GB15700@pilgrim>
References: <1603940079-8131-1-git-send-email-chunfeng.yun@mediatek.com>
         <1603940079-8131-2-git-send-email-chunfeng.yun@mediatek.com>
         <20201029082415.GB15700@pilgrim>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3185889AB76AB04BA80EAB8AEBF54879DC4FCB5D585B072F7DBE2BD0F0F608DE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTI5IGF0IDA5OjI0ICswMTAwLCBSZW1pIFBvbW1hcmVsIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIFRodSwgT2N0IDI5LCAyMDIwIGF0IDEwOjU0OjI0QU0gKzA4MDAsIENo
dW5mZW5nIFl1biB3cm90ZToNCj4gPiBVc2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNl
IHRvIHNpbXBsaWZ5IGNvZGUNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4g
PGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGh5L2Ft
bG9naWMvcGh5LW1lc29uLWF4Zy1taXBpLXBjaWUtYW5hbG9nLmMgfCA0ICstLS0NCj4gPiAgZHJp
dmVycy9waHkvYW1sb2dpYy9waHktbWVzb24tYXhnLXBjaWUuYyAgICAgICAgICAgICB8IDQgKy0t
LQ0KPiA+ICBkcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJhLXVzYjIuYyAgICAgICAg
ICAgIHwgNCArLS0tDQo+ID4gIGRyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWcxMmEtdXNi
My1wY2llLmMgICAgICAgfCA0ICstLS0NCj4gPiAgZHJpdmVycy9waHkvYW1sb2dpYy9waHktbWVz
b24tZ3hsLXVzYjIuYyAgICAgICAgICAgICB8IDQgKy0tLQ0KPiA+ICA1IGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWF4Zy1taXBpLXBjaWUtYW5hbG9nLmMgYi9k
cml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1heGctbWlwaS1wY2llLWFuYWxvZy5jDQo+ID4g
aW5kZXggMTQzMWNiZjg4NWUxLi43ZDA2Y2RhMzI5ZmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9waHkvYW1sb2dpYy9waHktbWVzb24tYXhnLW1pcGktcGNpZS1hbmFsb2cuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWF4Zy1taXBpLXBjaWUtYW5hbG9nLmMNCj4g
PiBAQCAtMTI2LDcgKzEyNiw2IEBAIHN0YXRpYyBpbnQgcGh5X2F4Z19taXBpX3BjaWVfYW5hbG9n
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAlzdHJ1Y3QgcGh5X2F4
Z19taXBpX3BjaWVfYW5hbG9nX3ByaXYgKnByaXY7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wID0gZGV2LT5vZl9ub2RlOw0KPiA+ICAJc3RydWN0IHJlZ21hcCAqbWFwOw0KPiA+IC0Jc3Ry
dWN0IHJlc291cmNlICpyZXM7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gIAlpbnQg
cmV0Ow0KPiA+ICANCj4gPiBAQCAtMTM0LDggKzEzMyw3IEBAIHN0YXRpYyBpbnQgcGh5X2F4Z19t
aXBpX3BjaWVfYW5hbG9nX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
IAlpZiAoIXByaXYpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gIA0KPiA+IC0JcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiAtCWJh
c2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICsJYmFzZSA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiAgCWlmIChJU19FUlIoYmFz
ZSkpIHsNCj4gPiAgCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBnZXQgcmVnbWFwIGJhc2VcbiIp
Ow0KPiA+ICAJCXJldHVybiBQVFJfRVJSKGJhc2UpOw0KPiANCj4gVGhpcyBwYXRjaCB3aWxsIGNv
bmZsaWN0IHdpdGggWzBdIHRoYXQgdXNlcyBzeXNjb24gdG8gbWFwIHRob3NlIHNoYXJlZA0KPiBy
ZXNvdXJjZXMgaW5zdGVhZCBhbmQgdGhhdCBpcyBob3BlZnVsbHkgZ29pbmcgdG8gYmUgbWVyZ2Vk
IHNvb24uDQo+IA0KPiBTbyBJIHRoaW5rIHlvdSBjYW4gc2tpcCB0aGlzIGZpbGUuDQpPaywgd2ls
bCBkcm9wIGl0LCB0aGFua3MNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L2FtbG9n
aWMvcGh5LW1lc29uLWF4Zy1wY2llLmMgYi9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1h
eGctcGNpZS5jDQo+ID4gaW5kZXggMzc3ZWQwZGNkMGQ5Li41OGE3NTA3YTg0MjIgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9waHkvYW1sb2dpYy9waHktbWVzb24tYXhnLXBjaWUuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWF4Zy1wY2llLmMNCj4gPiBAQCAtMTI5
LDcgKzEyOSw2IEBAIHN0YXRpYyBpbnQgcGh5X2F4Z19wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0K
PiA+ICAJc3RydWN0IHBoeV9heGdfcGNpZV9wcml2ICpwcml2Ow0KPiA+ICAJc3RydWN0IGRldmlj
ZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsNCj4gPiAtCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0K
PiA+ICAJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gQEAg
LTE0NSw4ICsxNDQsNyBAQCBzdGF0aWMgaW50IHBoeV9heGdfcGNpZV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4gIA0K
PiA+IC0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAw
KTsNCj4gPiAtCWJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICsJ
YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiAgCWlm
IChJU19FUlIoYmFzZSkpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoYmFzZSk7DQo+ID4gIA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJhLXVzYjIuYyBi
L2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWcxMmEtdXNiMi5jDQo+ID4gaW5kZXggYjI2
ZTMwZTFhZmFmLi45ZDFlZmEwZDkzOTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvYW1s
b2dpYy9waHktbWVzb24tZzEyYS11c2IyLmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9hbWxvZ2lj
L3BoeS1tZXNvbi1nMTJhLXVzYjIuYw0KPiA+IEBAIC0yOTIsNyArMjkyLDYgQEAgc3RhdGljIGlu
dCBwaHlfbWVzb25fZzEyYV91c2IyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gIAlz
dHJ1Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQo+ID4gLQlzdHJ1Y3QgcmVzb3VyY2Ug
KnJlczsNCj4gPiAgCXN0cnVjdCBwaHlfbWVzb25fZzEyYV91c2IyX3ByaXYgKnByaXY7DQo+ID4g
IAlzdHJ1Y3QgcGh5ICpwaHk7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gQEAgLTMw
NSw4ICszMDQsNyBAQCBzdGF0aWMgaW50IHBoeV9tZXNvbl9nMTJhX3VzYjJfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXByaXYtPmRldiA9IGRldjsNCj4gPiAgCXBs
YXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHByaXYpOw0KPiA+ICANCj4gPiAtCXJlcyA9IHBsYXRm
b3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gLQliYXNlID0g
ZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiArCWJhc2UgPSBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ID4gIAlpZiAoSVNfRVJSKGJhc2UpKQ0K
PiA+ICAJCXJldHVybiBQVFJfRVJSKGJhc2UpOw0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9waHkvYW1sb2dpYy9waHktbWVzb24tZzEyYS11c2IzLXBjaWUuYyBiL2RyaXZlcnMvcGh5
L2FtbG9naWMvcGh5LW1lc29uLWcxMmEtdXNiMy1wY2llLmMNCj4gPiBpbmRleCAwOGUzMjI3ODll
NTkuLmViZTNkMGRkZDMwNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BoeS9hbWxvZ2ljL3Bo
eS1tZXNvbi1nMTJhLXVzYjMtcGNpZS5jDQo+ID4gKysrIGIvZHJpdmVycy9waHkvYW1sb2dpYy9w
aHktbWVzb24tZzEyYS11c2IzLXBjaWUuYw0KPiA+IEBAIC0zODYsNyArMzg2LDYgQEAgc3RhdGlj
IGludCBwaHlfZzEyYV91c2IzX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gIAlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiA+ICAJc3RydWN0IHBoeV9nMTJhX3Vz
YjNfcGNpZV9wcml2ICpwcml2Ow0KPiA+IC0Jc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gIAlz
dHJ1Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJh
c2U7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+IEBAIC0zOTUsOCArMzk0LDcgQEAgc3RhdGljIGludCBw
aHlfZzEyYV91c2IzX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
PiAgCWlmICghcHJpdikNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgDQo+ID4gLQlyZXMg
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiA+IC0J
YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQo+ID4gKwliYXNlID0gZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+ICAJaWYgKElTX0VSUihi
YXNlKSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUihiYXNlKTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWd4bC11c2IyLmMgYi9kcml2ZXJzL3Bo
eS9hbWxvZ2ljL3BoeS1tZXNvbi1neGwtdXNiMi5jDQo+ID4gaW5kZXggNDNlYzliZjI0YWJmLi44
NzVhZmIyNjcyYzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvYW1sb2dpYy9waHktbWVz
b24tZ3hsLXVzYjIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWd4
bC11c2IyLmMNCj4gPiBAQCAtMjMwLDcgKzIzMCw2IEBAIHN0YXRpYyBpbnQgcGh5X21lc29uX2d4
bF91c2IyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAg
CXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gIAlzdHJ1Y3QgcGh5X3Byb3Zp
ZGVyICpwaHlfcHJvdmlkZXI7DQo+ID4gLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiAgCXN0
cnVjdCBwaHlfbWVzb25fZ3hsX3VzYjJfcHJpdiAqcHJpdjsNCj4gPiAgCXN0cnVjdCBwaHkgKnBo
eTsNCj4gPiAgCXZvaWQgX19pb21lbSAqYmFzZTsNCj4gPiBAQCAtMjQyLDggKzI0MSw3IEBAIHN0
YXRpYyBpbnQgcGh5X21lc29uX2d4bF91c2IyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gIA0KPiA+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQo+
ID4gIA0KPiA+IC0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0Vf
TUVNLCAwKTsNCj4gPiAtCWJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0K
PiA+ICsJYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4g
PiAgCWlmIChJU19FUlIoYmFzZSkpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoYmFzZSk7DQo+ID4g
IA0KPiANCj4gU28gd2l0aG91dCB0aGUgbW9kaWZpY2F0aW9uIG9uIHBoeS1tZXNvbi1heGctbWlw
aS1wY2llLWFuYWxvZy5jIGFuZA0KPiBGV0lXLA0KPiANCj4gUmV2aWV3ZWQtYnk6IFJlbWkgUG9t
bWFyZWwgPHJlcGtAdHJpcGxlZmF1Lmx0Pg0KPiANCj4gVGhhbmtzLA0KPiANCj4gWzBdIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1hbWxvZ2ljL3BhdGNoLzIwMjAw
OTE1MTMwMzM5LjExMDc5LTQtbmFybXN0cm9uZ0BiYXlsaWJyZS5jb20vDQo+IA0KDQo=

