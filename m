Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F894298796
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770992AbgJZHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:49:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28466 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1420449AbgJZHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:49:26 -0400
X-UUID: 731fa5de79564a608bbad1f3dc118972-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SfAVNttk78qRQKKemA7Ud33MHHCmqu34nhu5o0stHqY=;
        b=GK3lXmtLj3iv9AASn1C2y5H111pxhpl4J4M72mq7Xmt2HX4honnrtf3zbZ6kYjswx8Y3FOzyLuAsyn+x/4SU9iEiG4R2SLI+p9qT0cRPMNPOSwQHuMDJT3Jr2QU1PCZ4F6DichSbrHg0LJ/lgTa84la/iifiJpas+muKM3Gd+ls=;
X-UUID: 731fa5de79564a608bbad1f3dc118972-20201026
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1870587162; Mon, 26 Oct 2020 15:49:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Oct
 2020 15:49:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 15:49:06 +0800
Message-ID: <1603698546.26323.89.camel@mhfsdcap03>
Subject: Re: [PATCH v3 08/24] iommu/io-pgtable-arm-v7s: Use ias to check the
 valid iova in unmap
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
Date:   Mon, 26 Oct 2020 15:49:06 +0800
In-Reply-To: <20201023111740.GA20933@willie-the-truck>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-9-yong.wu@mediatek.com>
         <20201023111740.GA20933@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8750D7412EF4047F0F7D427B7CA7C541119F84D3827A3506E3419C88D3EFEC702000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDEyOjE3ICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDM6MDY6MzFQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBVc2UgdGhlIGlhcyBmb3IgdGhlIHZhbGlkIGlvdmEgY2hlY2tpbmcgaW4gYXJtX3Y3c191
bm1hcC4gVGhpcyBpcyBhDQo+ID4gcHJlcGFyaW5nIHBhdGNoIGZvciBzdXBwb3J0aW5nIGlvdmEg
MzRiaXQgZm9yIE1lZGlhVGVrLg0KPiA+IEJUVywgY2hhbmdlIHRoZSBpYXMvb2FzIGNoZWNraW5n
IGZvcm1hdCBpbiBhcm1fdjdzX21hcC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9pby1w
Z3RhYmxlLWFybS12N3MuYyB8IDUgKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0t
djdzLmMNCj4gPiBpbmRleCBhNjg4ZjIyY2JlM2IuLjRjOWQ4ZGNjZmM1YSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQo+ID4gKysrIGIvZHJpdmVy
cy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KPiA+IEBAIC01MjYsOCArNTI2LDcgQEAgc3Rh
dGljIGludCBhcm1fdjdzX21hcChzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMgKm9wcywgdW5zaWduZWQg
bG9uZyBpb3ZhLA0KPiA+ICAJaWYgKCEocHJvdCAmIChJT01NVV9SRUFEIHwgSU9NTVVfV1JJVEUp
KSkNCj4gPiAgCQlyZXR1cm4gMDsNCj4gPiAgDQo+ID4gLQlpZiAoV0FSTl9PTihpb3ZhID49ICgx
VUxMIDw8IGRhdGEtPmlvcC5jZmcuaWFzKSB8fA0KPiA+IC0JCSAgICBwYWRkciA+PSAoMVVMTCA8
PCBkYXRhLT5pb3AuY2ZnLm9hcykpKQ0KPiA+ICsJaWYgKFdBUk5fT04oaW92YSA+PiBkYXRhLT5p
b3AuY2ZnLmlhcyB8fCBwYWRkciA+PiBkYXRhLT5pb3AuY2ZnLm9hcykpDQo+ID4gIAkJcmV0dXJu
IC1FUkFOR0U7DQo+IA0KPiBBcyBkaXNjdXNzZWQgd2hlbiByZXZpZXdpbmcgdGhlc2UgZm9yIEFu
ZHJvaWQsIHBsZWFzZSBsZWF2ZSB0aGlzIGNvZGUgYXMtaXMuDQo+IA0KPiA+ICANCj4gPiAgCXJl
dCA9IF9fYXJtX3Y3c19tYXAoZGF0YSwgaW92YSwgcGFkZHIsIHNpemUsIHByb3QsIDEsIGRhdGEt
PnBnZCwgZ2ZwKTsNCj4gPiBAQCAtNzE3LDcgKzcxNiw3IEBAIHN0YXRpYyBzaXplX3QgYXJtX3Y3
c191bm1hcChzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMgKm9wcywgdW5zaWduZWQgbG9uZyBpb3ZhLA0K
PiA+ICB7DQo+ID4gIAlzdHJ1Y3QgYXJtX3Y3c19pb19wZ3RhYmxlICpkYXRhID0gaW9fcGd0YWJs
ZV9vcHNfdG9fZGF0YShvcHMpOw0KPiA+ICANCj4gPiAtCWlmIChXQVJOX09OKHVwcGVyXzMyX2Jp
dHMoaW92YSkpKQ0KPiA+ICsJaWYgKFdBUk5fT04oaW92YSA+PiBkYXRhLT5pb3AuY2ZnLmlhcykp
DQo+ID4gIAkJcmV0dXJuIDA7DQo+IA0KPiBBbmQgYXZvaWQgdGhlIFVCIGhlcmUgZm9yIDMyLWJp
dCBtYWNoaW5lcyBieSBjb21wYXJpbmcgd2l0aCAxVUxMIDw8DQo+IGlvcC5jZmcuaWFzIGluc3Rl
YWQuDQoNClRoYW5rcy4gSSB3aWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+IFRo
YW5rcywNCj4gDQo+IFdpbGwNCg0K

