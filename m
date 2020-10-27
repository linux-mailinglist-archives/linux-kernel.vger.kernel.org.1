Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2629A5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507950AbgJ0HmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:42:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50361 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2507941AbgJ0HmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:42:20 -0400
X-UUID: a06ff9226f3647e59552907cc2fd0131-20201027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PTtnXYd9arSTe9cH1RmMwHvzY9bdu3XbEoZA6CWYDas=;
        b=GljPc8HZYSGiYwNrMjzunJqXyQZYZrngr1ycBHwG6sipq0S/UuKGIF5uTixyT6lUOL+4yfKrdUROLRQCSo7wvNHnj673vrqYs74ARLeDeaHFO9aTmoMRGM1uymwQZPhwUVGgJtZw5FZPffQOCJZw0I/G1hxihcFdRi/8EKwZhXE=;
X-UUID: a06ff9226f3647e59552907cc2fd0131-20201027
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 424926047; Tue, 27 Oct 2020 15:42:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Oct 2020 15:41:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Oct 2020 15:41:56 +0800
Message-ID: <1603784517.12492.2.camel@mtkswgap22>
Subject: Re: [PATCH v2 4/4] arm: replace vector mem type with read-only type
From:   Miles Chen <miles.chen@mediatek.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Oct 2020 15:41:57 +0800
In-Reply-To: <20201023101257.GZ1551@shell.armlinux.org.uk>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
         <20201023091437.8225-5-miles.chen@mediatek.com>
         <20201023101257.GZ1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDExOjEyICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0IDA1OjE0OjM3UE0gKzA4
MDAsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gU2luY2Uga2VybmVsIG5vIGxvbmdlciB3cml0ZXMg
dG8gdGhlIHZlY3RvciwgdHJ5IHRvIHJlcGxhY2UNCj4gPiB0aGUgdmVjdG9yIG1lbSB0eXBlIHdp
dGggcmVhZC1vbmx5IHR5cGUgYW5kIHJlbW92ZSBMX1BURV9NVF9WRUNUT1JTLg0KPiA+IA0KPiA+
IGZyb20gQ2F0YWxpbiBpbiBbMV06DQo+ID4gIg0KPiA+ID4gSSBkb24ndCB0aGluayB0aGlzIG1h
dHRlcnMgc2luY2UgdGhlIGtlcm5lbCBubyBsb25nZXIgd3JpdGVzIHRvIHRoZQ0KPiA+ID4gdmVj
dG9ycyBwYWdlIGF0IHJ1bi10aW1lIGJ1dCBpdCBuZWVkcyBjbGVhbmluZyB1cCBhIGJpdCAoYW5k
IHRlc3RpbmcgaW4NCj4gPiA+IGNhc2UgSSBtaXNzZWQgc29tZXRoaW5nKS4gSU9XLCBkbyB3ZSBz
dGlsbCBuZWVkIGEgZGVkaWNhdGVkIG1hcHBpbmcgdHlwZQ0KPiA+ID4gZm9yIHRoZSB2ZWN0b3Jz
IG9yIHdlIGNhbiBzaW1wbHkgdXNlIHRoZSByZWFkLW9ubHkgdXNlciBwYWdlIGF0dHJpYnV0ZXM/
DQo+ID4gIg0KPiANCj4gQ2F0YWxpbiBpcyBpbmNvcnJlY3QuIElmIENPTkZJR19LVVNFUl9IRUxQ
RVJTIGlzIGVuYWJsZWQsIHRoZW4gdGhlDQo+IHZlY3RvcnMgcGFnZSBpcyBkZWZpbml0ZWx5IHdy
aXR0ZW4gdG8gLSBpdCdzIGEgdXNlciBpbnRlcmZhY2UsIHNvDQo+IGl0J3Mgbm90IGdvaW5nIHRv
IGNoYW5nZToNCj4gDQo+ICNpZmRlZiBDT05GSUdfS1VTRVJfSEVMUEVSUw0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKiBVc2VyIHNwYWNl
IG11c3QgbmV2ZXIgdHJ5IHRvIGFjY2VzcyB0aGlzDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAqIGRpcmVjdGx5LiAgRXhwZWN0IHlvdXIgYXBwIHRvIGJyZWFrDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAqIGV2ZW50dWFsbHkgaWYgeW91IGRvIHNvLiAgVGhlIHVzZXIgaGVscGVyDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAqIGF0IDB4ZmZmZjBmZTAgbXVzdCBiZSB1c2VkIGlu
c3RlYWQuICAoc2VlDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAqIGVudHJ5LWFybXYuUyBm
b3IgZGV0YWlscykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICooKHVuc2lnbmVkIGludCAqKTB4ZmZmZjBmZjApID0gdmFsOw0KPiAjZW5k
aWYNCj4gDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuIA0KV2UgaGF2ZSB0byBrZWVwIExfUFRF
X01UX1ZFQ1RPUlMgZm9yIEtVU0VSX0hFTFBFUlMuDQoNCg0KTWlsZXMNCg==

