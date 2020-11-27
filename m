Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D865E2C6003
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 07:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392542AbgK0GV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 01:21:27 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:53514 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728043AbgK0GV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:21:27 -0500
X-UUID: 27e402dd87404cdbb91b46778d9d1d51-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Pl6CYWtmmWtvWb3jpHddFmtYia5wUK/VPTpcYY0nQVw=;
        b=CR78ywp974QqBjd2oroSLxbDdlDXOTnTEFVRGk3UIfnFJBdh7JcQpSoKZexqa3plwMZ/F7HchO/C5EOaC3EtCMKgacRp+dgp5ztwL/EHme0ES3OH2NPfCykSlKcfSu0xbFFzlMZ+DVXOM9F/BLXX9Gv+cFONv3sis3UAgQxt4Gg=;
X-UUID: 27e402dd87404cdbb91b46778d9d1d51-20201127
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1085674921; Fri, 27 Nov 2020 14:21:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Nov
 2020 14:21:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 14:21:18 +0800
Message-ID: <1606458079.26323.191.camel@mhfsdcap03>
Subject: Re: [PATCH v4 09/24] iommu/io-pgtable-arm-v7s: Clear LVL_SHIFT/BITS
 macro instead of the formula
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <anan.sun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 27 Nov 2020 14:21:19 +0800
In-Reply-To: <13599074-25d5-721f-ea7b-1ea6badfd14f@arm.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
         <20201111123838.15682-10-yong.wu@mediatek.com>
         <13599074-25d5-721f-ea7b-1ea6badfd14f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9F8790CD8E57278BED548B9B20C81FEFDD4AF8C22E7A81094363F0EEEAC8B4D62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDE2OjAzICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMTEtMTEgMTI6MzgsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQgX0FS
TV9WN1NfTFZMX0JJVFMvQVJNX1Y3U19MVkxfU0hJRlQgdXNlIGEgZm9ybXVsYSB0byBjYWxjdWxh
dGUNCj4gPiB0aGUgY29ycmVzcG9uZGluZyB2YWx1ZSBmb3IgbGV2ZWwxIGFuZCBsZXZlbDIgdG8g
cHJldGVuZCB0aGUgY29kZSBzYW5lLg0KPiA+IEFjdHVhbGx5IHRoZWlyIGxldmVsMSBhbmQgbGV2
ZWwyIHZhbHVlcyBhcmUgZGlmZmVyZW50IGZyb20gZWFjaCBvdGhlci4NCj4gPiBUaGlzIHBhdGNo
IG9ubHkgY2xlYXIgdGhlIHR3byBtYWNyby4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQo+IA0KPiBH
cmFtbWFyIG5pdDogdG8gImNsZWFyIiB0aGUgbWFjcm8gc291bmRzIGxpa2UgeW91J3JlIG1ha2lu
ZyBpdCBlbXB0eSBvciANCj4gcmVtb3ZpbmcgaXQgZW50aXJlbHk7IEkgdGhpbmsgeW91IG1lYW4g
dG8gc2F5ICJjbGFyaWZ5IiBoZXJlLiBFbmdsaXNoIGlzIA0KPiB0aGUgd29yc3QgbGFuZ3VhZ2Ug
c29tZXRpbWVzLi4uIDopDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gRmVlbCBmcmVlIHRvIHRl
bGwgbWUgaWYgc29tZSB3b3JkcyBpcyBub3QgZml0OikNCg0KSSB3aWxsIHVzZSAiY2xhcmlmeSIg
aW4gdGhlIHRpdGxlLg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5t
dXJwaHlAYXJtLmNvbT4NCj4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmlu
Lm11cnBoeUBhcm0uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12
N3MuYyB8IDggKysrLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW8t
cGd0YWJsZS1hcm0tdjdzLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQo+
ID4gaW5kZXggNGQwYWEwNzk0NzBmLi41OGNjMjAxYzEwYTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW8tcGd0YWJsZS1hcm0tdjdzLmMNCj4gPiBAQCAtNDQsMTMgKzQ0LDExIEBADQo+ID4gICANCj4g
PiAgIC8qDQo+ID4gICAgKiBXZSBoYXZlIDMyIGJpdHMgdG90YWw7IDEyIGJpdHMgcmVzb2x2ZWQg
YXQgbGV2ZWwgMSwgOCBiaXRzIGF0IGxldmVsIDIsDQo+ID4gLSAqIGFuZCAxMiBiaXRzIGluIGEg
cGFnZS4gV2l0aCBzb21lIGNhcmVmdWxseS1jaG9zZW4gY29lZmZpY2llbnRzIHdlIGNhbg0KPiA+
IC0gKiBoaWRlIHRoZSB1Z2x5IGluY29uc2lzdGVuY2llcyBiZWhpbmQgdGhlc2UgbWFjcm9zIGFu
ZCBhdCBsZWFzdCBsZXQgdGhlDQo+ID4gLSAqIHJlc3Qgb2YgdGhlIGNvZGUgcHJldGVuZCB0byBi
ZSBzb21ld2hhdCBzYW5lLg0KPiA+ICsgKiBhbmQgMTIgYml0cyBpbiBhIHBhZ2UuDQo+ID4gICAg
Ki8NCj4gPiAgICNkZWZpbmUgQVJNX1Y3U19BRERSX0JJVFMJCTMyDQo+ID4gLSNkZWZpbmUgX0FS
TV9WN1NfTFZMX0JJVFMobHZsKQkJKDE2IC0gKGx2bCkgKiA0KQ0KPiA+IC0jZGVmaW5lIEFSTV9W
N1NfTFZMX1NISUZUKGx2bCkJCShBUk1fVjdTX0FERFJfQklUUyAtICg0ICsgOCAqIChsdmwpKSkN
Cj4gPiArI2RlZmluZSBfQVJNX1Y3U19MVkxfQklUUyhsdmwpCQkoKGx2bCkgPT0gMSA/IDEyIDog
OCkNCj4gPiArI2RlZmluZSBBUk1fVjdTX0xWTF9TSElGVChsdmwpCQkoKGx2bCkgPT0gMSA/IDIw
IDogMTIpDQo+ID4gICAjZGVmaW5lIEFSTV9WN1NfVEFCTEVfU0hJRlQJCTEwDQo+ID4gICANCj4g
PiAgICNkZWZpbmUgQVJNX1Y3U19QVEVTX1BFUl9MVkwobHZsKQkoMSA8PCBfQVJNX1Y3U19MVkxf
QklUUyhsdmwpKQ0KPiA+IA0KDQo=

