Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE20298793
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770985AbgJZHpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:45:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46948 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1770976AbgJZHpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:45:50 -0400
X-UUID: 5141fc99c02e4a1f8b70cbc146099df1-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lojLUg9fFbo8jOsfPb9idJA9/aY654a36SbR0fCGZpQ=;
        b=GwALrNlGsToOK6VLEuay3oe/1JeCGR0cAj8odDzxZ6h8HxTls2Aq3qhYo9I7gW6WAdnPDfVQ6bXV/aANgUFhI6FT7GuZc6ya6nVMsUpjQDOXwn26pkmF34CMZDCr1pt8liSPjfBT8Y1JvxC5a6OCvAPO+TEzfE9Tb1XbZ/sDBbQ=;
X-UUID: 5141fc99c02e4a1f8b70cbc146099df1-20201026
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 375836218; Mon, 26 Oct 2020 15:45:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Oct
 2020 15:45:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 15:45:34 +0800
Message-ID: <1603698334.26323.88.camel@mhfsdcap03>
Subject: Re: [PATCH v3 11/24] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable
 for MediaTek
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Mon, 26 Oct 2020 15:45:34 +0800
In-Reply-To: <20201023112148.GB20933@willie-the-truck>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-12-yong.wu@mediatek.com>
         <20201023112148.GB20933@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7D5007B554F3125CBCD9B8D492C92003C020E35494172D92BAFD6D3255A98BE82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDEyOjIxICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDM6MDY6MzRQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBUaGUgc3RhbmRhcmQgaW5wdXQgaW92YSBiaXRzIGlzIDMyLiBNZWRpYVRlayBxdWFkIHRo
ZSBsdmwxIHBhZ2V0YWJsZQ0KPiA+ICg0ICogbHZsMSkuIE5vIGNoYW5nZSBmb3IgbHZsMiBwYWdl
dGFibGUuIFRoZW4gdGhlIGlvdmEgYml0cyBjYW4gcmVhY2gNCj4gPiAzNGJpdC4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyB8IDEzICsrKysrKysrKyst
LS0NCj4gPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICAgICAgICB8ICAyICstDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyBiL2Ry
aXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCj4gPiBpbmRleCA4MzYyZmRmNzY2NTcu
LjMwNmJhZTI3NTVlZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUt
YXJtLXY3cy5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0K
PiA+IEBAIC01MCwxMCArNTAsMTcgQEANCj4gPiAgICovDQo+ID4gICNkZWZpbmUgQVJNX1Y3U19B
RERSX0JJVFMJCTMyDQo+IA0KPiBJZiB3ZSByZW5hbWUgdGhpcyB0byBfQVJNX1Y3U19BRERSX0JJ
VFMgY2FuIHdlIHRoZW4gaGF2ZSBBUk1fVjdTX0FERFJfQklUUw0KPiB0YWtlIGEgY2ZnIHBhcmFt
ZXRlciBhbmQgbW92ZSB0aGUgYXJtX3Y3c19pc19tdGtfZW5hYmxlZCgpIGNoZWNrIGluIHRoZXJl
Pw0KPiBTYW1lIGZvciBfQVJNX1Y3U19MVkxfQklUUy4NCj4gDQo+IFRoYXQgd291bGQgYXZvaWQg
c2NhdHRlcmluZyBhcm1fdjdzX2lzX210a19lbmFibGVkKCkgaW50byBhbGwgdGhlIHVzZXJzLg0K
DQpJIGFkZGVkICJjZmciIGZvciBfQVJNX1Y3U19MVkxfQklUUyBpbiBSb2JpbidzIG1haWwuIGlz
IHRoYXQgb2s/DQoNClJlZ2FyZGluZyBBUk1fVjdTX0FERFJfQklUUywgSSdkIGxpa2UgdG8ga2Vl
cCBpdCBhcyBpcyhEb24ndCBhZGQgY2ZnKSwNCnRoaXMgbWFjcm8gb25seSBpcyB1c2VkIGluIEFS
TV9WN1NfTFZMX1NISUZUIGFuZCBjaGVja2luZyB0aGUgdmFsdWUgb2YNCmlhcy9vYXMuDQoNCmEp
IEFSTV9WN1NfTFZMX1NISUZUIGFsd2F5cyBleHBlY3QgQVJNX1Y3U19BRERSX0JJVFMgaXMgMzIu
DQoNCmIpIG91ciBpYXMvb2FzIGlzIGRpZmZlcmVudChpYXMgaXMgMzQgd2hpbGUgb2FzIGlzIDM1
KS4gSWYgd2UgZGVmaW5lIGENCm5ldyBtYWNybywgd2UgbmVlZCB0d28gYWJvdXQgdGhpcywgbGlr
ZToNCiNkZWZpbmUgQVJNX1Y3U19JQUREUl9CSVRTKGNmZykJKCFhcm1fdjdzX2lzX210a19lbmFi
bGVkKGNmZykgPyAzMiA6IDM0KQ0KI2RlZmluZSBBUk1fVjdTX09BRERSX0JJVFMoY2ZnKQkoIWFy
bV92N3NfaXNfbXRrX2VuYWJsZWQoY2ZnKSA/IDMyIDogMzUpDQphbmQgdGhlIHR3byB3aWxsIG9u
bHkgYXJlIHVzZWQgaW4gdGhlIGNoZWNraW5nIG9mIGlhcy9vYXMuDQoNCnRodXMgaXQgbG9va3Mg
dW5uZWNlc3Nhcnk/DQoNCj4gDQo+IFdpbGwNCg0K

