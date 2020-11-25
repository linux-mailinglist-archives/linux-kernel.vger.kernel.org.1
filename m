Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086EE2C3919
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKYG1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:27:14 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:42479 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbgKYG1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:27:14 -0500
X-UUID: 312509b55e38466197825c0f67b8aea0-20201125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4wT0sL2p4bYjUtORLYx8X9YW4UaRtS4zF13rlFd4m3U=;
        b=npVbsbVBTp/WKl7ZKsAq2Vb5DWaKBbf3ey98EcKsQMJzpZOo37pKOp2YyF6gQWMog0yXnnK3ajbOEFYbbwSlGP16kYRhkAdqBVjVGjUbYIwEXNhnbpoaN6ryko/kTmwZKhGpkvovfx13IkECLAqzg1U01ZXHEvADGVqF+6fDLNA=;
X-UUID: 312509b55e38466197825c0f67b8aea0-20201125
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1930205681; Wed, 25 Nov 2020 14:27:04 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Nov
 2020 14:27:02 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Nov 2020 14:27:01 +0800
Message-ID: <1606285623.7284.8.camel@mhfsdcap03>
Subject: Re: [PATCH] phy/mediatek: Make PHY_MTK_XSPHY depend on HAS_IOMEM
 and OF_ADDRESS to fix build errors
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Date:   Wed, 25 Nov 2020 14:27:03 +0800
In-Reply-To: <d3cee8b0-b699-a51a-ff33-568e10cb2df7@infradead.org>
References: <1606211233-7425-1-git-send-email-yangtiezhu@loongson.cn>
         <1606271044.32484.20.camel@mhfsdcap03>
         <d3cee8b0-b699-a51a-ff33-568e10cb2df7@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0B25F89E42C9C88A9D286BF25D5F4853EA184271D894796D64149F03AEBE79732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTI0IGF0IDE5OjMxIC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IE9uIDExLzI0LzIwIDY6MjQgUE0sIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBIaSBUaWV6aHUs
DQo+ID4gDQo+ID4gT24gVHVlLCAyMDIwLTExLTI0IGF0IDE3OjQ3ICswODAwLCBUaWV6aHUgWWFu
ZyB3cm90ZToNCj4gPj4gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgd2lsbCBiZSBub3QgYnVpbHQg
aW4gbGliL2RldnJlcy5jIGlmDQo+ID4+IENPTkZJR19IQVNfSU9NRU0gaXMgbm90IHNldCwgb2Zf
YWRkcmVzc190b19yZXNvdXJjZSgpIHdpbGwgYmUNCj4gPj4gbm90IGJ1aWx0IGluIGRyaXZlcnMv
b2YvYWRkcmVzcy5jIGlmIENPTkZJR19PRl9BRERSRVNTIGlzIG5vdA0KPiA+PiBzZXQsIGFuZCB0
aGVuIHRoZXJlIGV4aXN0cyB0d28gYnVpbGQgZXJyb3JzIGFib3V0IHVuZGVmaW5lZA0KPiA+PiBy
ZWZlcmVuY2UgdG8gImRldm1faW9yZW1hcF9yZXNvdXJjZSIgYW5kICJvZl9hZGRyZXNzX3RvX3Jl
c291cmNlIg0KPiA+PiBpbiBwaHktbXRrLXhzcGh5LmMgdW5kZXIgQ09NUElMRV9URVNUIGFuZCBD
T05GSUdfUEhZX01US19YU1BIWSwNCj4gPj4gbWFrZSBQSFlfTVRLX1hTUEhZIGRlcGVuZCBvbiBI
QVNfSU9NRU0gYW5kIE9GX0FERFJFU1MgdG8gZml4IGl0Lg0KPiA+Pg0KPiA+PiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IFRpZXpodSBZYW5nIDx5YW5ndGllemh1QGxvb25nc29uLmNuPg0KPiA+PiAtLS0NCj4gPj4gIGRy
aXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcgfCAyICsrDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tZWRp
YXRlay9LY29uZmlnIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvS2NvbmZpZw0KPiA+PiBpbmRleCA1
MGM1ZTkzLi42NmRmMDQ1IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9L
Y29uZmlnDQo+ID4+ICsrKyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcNCj4gPj4gQEAg
LTMwLDYgKzMwLDggQEAgY29uZmlnIFBIWV9NVEtfWFNQSFkNCj4gPj4gIAl0cmlzdGF0ZSAiTWVk
aWFUZWsgWFMtUEhZIERyaXZlciINCj4gPj4gIAlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwg
Q09NUElMRV9URVNUDQo+ID4+ICAJZGVwZW5kcyBvbiBPRg0KSGkgVGllemh1LA0KDQpXb3VsZCB5
b3UgcGxlYXNlIGhlbHAgdG8gcHV0IE9GIGFuZCBPRl9BRERSRVNTIGludG8gb25lIGxpbmUgYXMN
CmZvbGxvd2luZzoNCmRlcGVuZHMgb24gT0YgJiYgT0ZfQUREUkVTUy4NCg0KQWxzbyBwbGVhc2Ug
aGVscCB0byBhZGQgdGhlbSBmb3IgUEhZX01US19UUEhZLg0KQW5kIGNoYW5nZSB0aGUgdGlsZSAn
cGh5L21lZGlhdGVrOiAuLi4nIGFzICdwaHk6IG1lZGlhdGVrOiAuLi4nDQoNClRoYW5rIHlvdQ0K
DQoNCj4gPj4gKwlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiA+PiArCWRlcGVuZHMgb24gT0ZfQURE
UkVTUw0KPiA+IFdoeSBub3QgYWRkIHRoZW0gaW50byBkZWNvbmZpZyBidXQgaGVyZT8gSW4gZmFj
dCBJIGRvbid0IGtub3cgd2hpY2ggd2F5DQo+ID4gaXMgYmV0dGVyIGFuZCBmb2xsb3cgdGhlIGtl
cm5lbCBydWxlLg0KPiA+IA0KPiA+IFZpbm9kIGFuZCBLaXNob24sIGRvIHlvdSBoYXZlIGFueSBz
dWdnZXN0aW9uIGFib3V0IHRoaXM/DQo+IA0KPiBQdXR0aW5nIHRoZW0gaW50byBhIGRlZmNvbmZp
ZyB3b24ndCBwcmV2ZW50IHJhbmRvbSBidWlsZCBlcnJvcnMNCj4gd2hpbGUgcHV0dGluZyB0aGVt
IGhlcmUgd2lsbCAob3IgYXQgbGVhc3Qgc2hvdWxkKS4NCmhpIFJhbmR5LA0KDQpHb3QgaXQsIHRo
YW5rIHlvdQ0KDQo+IA0KPiA+PiAgCXNlbGVjdCBHRU5FUklDX1BIWQ0KPiA+PiAgCWhlbHANCj4g
Pj4gIAkgIEVuYWJsZSB0aGlzIHRvIHN1cHBvcnQgdGhlIFN1cGVyU3BlZWRQbHVzIFhTLVBIWSB0
cmFuc2NlaXZlciBmb3INCj4gPiANCj4gDQo+IFRoZSBwYXRjaCBMR1RNLg0KPiANCj4gQWNrZWQt
Ynk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gdGhhbmtzLg0K
DQo=

