Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17832C5FED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 07:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgK0F6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:58:25 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:3825 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731985AbgK0F6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:58:25 -0500
X-UUID: b4e933b0133147a1af2d03c003ee2205-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VV/UVxBer8cz/LL3HT1bG3fkm0bU1MCnYZbcXRXqx5g=;
        b=abqYXwa5oSUmv/YH5Q2xOcqoc3nIqP4N73SJp60+hvJhiLJFzU3uGAhTIVVlc/c+T2RMd+nyZXPpzSPoZlp2ZRtNLb8iWg8HwEkDTmHieJY2F3U39oo6AjY+beCBFWd5jhvuSNRbWk+TZ4T3bfZwYj9FNI9JIneyaAEYdo2LdGI=;
X-UUID: b4e933b0133147a1af2d03c003ee2205-20201127
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1039532657; Fri, 27 Nov 2020 13:58:16 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Nov
 2020 13:58:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 13:58:14 +0800
Message-ID: <1606456694.7284.13.camel@mhfsdcap03>
Subject: Re: [PATCH v2] phy: mediatek: Make PHY_MTK_{XSPHY,TPHY} depend on
 HAS_IOMEM and OF_ADDRESS to fix build errors
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Date:   Fri, 27 Nov 2020 13:58:14 +0800
In-Reply-To: <1606289865-692-1-git-send-email-yangtiezhu@loongson.cn>
References: <1606289865-692-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A1348FE1C622C32EE3BBD342ACC8DE129ED9659DFB7E737BC92FAEBB073FDC842000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTI1IGF0IDE1OjM3ICswODAwLCBUaWV6aHUgWWFuZyB3cm90ZToNCj4g
ZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgd2lsbCBiZSBub3QgYnVpbHQgaW4gbGliL2RldnJlcy5j
IGlmDQo+IENPTkZJR19IQVNfSU9NRU0gaXMgbm90IHNldCwgb2ZfYWRkcmVzc190b19yZXNvdXJj
ZSgpIHdpbGwgYmUNCj4gbm90IGJ1aWx0IGluIGRyaXZlcnMvb2YvYWRkcmVzcy5jIGlmIENPTkZJ
R19PRl9BRERSRVNTIGlzIG5vdA0KPiBzZXQsIGFuZCB0aGVuIHRoZXJlIGV4aXN0cyB0d28gYnVp
bGQgZXJyb3JzIGFib3V0IHVuZGVmaW5lZA0KPiByZWZlcmVuY2UgdG8gImRldm1faW9yZW1hcF9y
ZXNvdXJjZSIgYW5kICJvZl9hZGRyZXNzX3RvX3Jlc291cmNlIg0KPiBpbiBwaHktbXRrLXhzcGh5
LmMgdW5kZXIgQ09NUElMRV9URVNUIGFuZCBDT05GSUdfUEhZX01US19YU1BIWSwNCj4gbWFrZSBQ
SFlfTVRLX1hTUEhZIGRlcGVuZCBvbiBIQVNfSU9NRU0gYW5kIE9GX0FERFJFU1MgdG8gZml4IGl0
Lg0KPiANCj4gVGhlIGFib3ZlIGlzc3VlIGlzIHJlcG9ydGVkIGJ5IGtlcm5lbCB0ZXN0IHJvYm90
IDxsa3BAaW50ZWwuY29tPiwNCj4gdGhyb3VnaCB0aGUgZGlzY3Vzc2lvbiBpbiB0aGUgdjEgcGF0
Y2gsIGFzIENodW5mZW5nIHNhaWQgd2UgbmVlZA0KPiBhbHNvIGRvIHRoaXMgZm9yIGNvbmZpZyBQ
SFlfTVRLX1RQSFk6DQo+IA0KPiBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYzox
MTU3OgkJcmV0dmFsID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShjaGlsZF9ucCwgMCwgJnJlcyk7
DQo+IGRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jOjExMjM6CQl0cGh5LT5zaWZf
YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHNpZl9yZXMpOw0KPiBkcml2ZXJzL3Bo
eS9tZWRpYXRlay9waHktbXRrLXRwaHkuYzoxMTY0OgkJaW5zdGFuY2UtPnBvcnRfYmFzZSA9IGRl
dm1faW9yZW1hcF9yZXNvdXJjZSgmcGh5LT5kZXYsICZyZXMpOw0KPiANCj4gUmVwb3J0ZWQtYnk6
IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaWV6
aHUgWWFuZyA8eWFuZ3RpZXpodUBsb29uZ3Nvbi5jbj4NCj4gQWNrZWQtYnk6IFJhbmR5IER1bmxh
cCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiAtLS0NClRoZSBjaGFuZ2VzIGluIHYyIHNob3Vs
ZCBiZSBkZXNjcmliZWQgYWZ0ZXIgJy0tLScNCg0KRXhjZXB0IHRoYXQsIGl0IGxvb2tzIGdvb2Qg
dG8gbWUsDQpBY2tlZC1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29t
Pg0KDQpUaGFua3MgYSBsb3QNCg0KPiAgZHJpdmVycy9waHkvbWVkaWF0ZWsvS2NvbmZpZyB8IDYg
KysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcgYi9kcml2
ZXJzL3BoeS9tZWRpYXRlay9LY29uZmlnDQo+IGluZGV4IDUwYzVlOTMuLmY0NDgwMGIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9w
aHkvbWVkaWF0ZWsvS2NvbmZpZw0KPiBAQCAtNSw3ICs1LDggQEANCj4gIGNvbmZpZyBQSFlfTVRL
X1RQSFkNCj4gIAl0cmlzdGF0ZSAiTWVkaWFUZWsgVC1QSFkgRHJpdmVyIg0KPiAgCWRlcGVuZHMg
b24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCj4gLQlkZXBlbmRzIG9uIE9GDQo+ICsJ
ZGVwZW5kcyBvbiBPRiAmJiBPRl9BRERSRVNTDQo+ICsJZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4g
IAlzZWxlY3QgR0VORVJJQ19QSFkNCj4gIAloZWxwDQo+ICAJICBTYXkgJ1knIGhlcmUgdG8gYWRk
IHN1cHBvcnQgZm9yIE1lZGlhVGVrIFQtUEhZIGRyaXZlciwNCj4gQEAgLTI5LDcgKzMwLDggQEAg
Y29uZmlnIFBIWV9NVEtfVUZTDQo+ICBjb25maWcgUEhZX01US19YU1BIWQ0KPiAgCXRyaXN0YXRl
ICJNZWRpYVRlayBYUy1QSFkgRHJpdmVyIg0KPiAgCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8
fCBDT01QSUxFX1RFU1QNCj4gLQlkZXBlbmRzIG9uIE9GDQo+ICsJZGVwZW5kcyBvbiBPRiAmJiBP
Rl9BRERSRVNTDQo+ICsJZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4gIAlzZWxlY3QgR0VORVJJQ19Q
SFkNCj4gIAloZWxwDQo+ICAJICBFbmFibGUgdGhpcyB0byBzdXBwb3J0IHRoZSBTdXBlclNwZWVk
UGx1cyBYUy1QSFkgdHJhbnNjZWl2ZXIgZm9yDQoNCg==

