Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD94B2AFE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgKLFev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:34:51 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:65478 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727932AbgKLClv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 21:41:51 -0500
X-UUID: 3e322c4d6c014b81adca0a5a36afc2e5-20201112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Se+dg4+AYHxaxLtO87h0o7d56UKD1EUz3XmAcnOw+/s=;
        b=oA+Dbf0qPb92/DZF3kFkxWYazzkKvsKg0/1OM5wOp9sggU1MDJbxATKYd0bHSif+NtHFeCDweuX4Xx505Zv1xeRj7V3hvcXe+mEqufaYZVEcfJvez7qhPfj56D9i4g12WU8yAbEq+Bpmpt1UfPVhRSSMTHDBrBUr75eoDoGa2HM=;
X-UUID: 3e322c4d6c014b81adca0a5a36afc2e5-20201112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1635741934; Thu, 12 Nov 2020 10:41:44 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Nov
 2020 10:41:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 10:41:42 +0800
Message-ID: <1605148902.26323.126.camel@mhfsdcap03>
Subject: Re: [PATCH v4 05/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Thu, 12 Nov 2020 10:41:42 +0800
In-Reply-To: <20201111213338.GD287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
         <20201111123838.15682-6-yong.wu@mediatek.com>
         <20201111213338.GD287176@kozik-lap>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1C18FA5020027ADAA5CD122CFFAF794DF7B24B6C49C7403F677C225959A3CB292000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBXZWQsIDIwMjAtMTEtMTEgYXQgMjI6MzMgKzAxMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFdlZCwgTm92IDExLCAyMDIwIGF0IDA4OjM4OjE5
UE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGRlY3JpcHRpb25z
IGZvciBtdDgxOTIgSU9NTVUgYW5kIFNNSS4NCj4gPiANCj4gPiBtdDgxOTIgYWxzbyBpcyBNVEsg
SU9NTVUgZ2VuMiB3aGljaCB1c2VzIEFSTSBTaG9ydC1EZXNjcmlwdG9yIHRyYW5zbGF0aW9uDQo+
ID4gdGFibGUgZm9ybWF0LiBUaGUgTTRVLVNNSSBIVyBkaWFncmFtIGlzIGFzIGJlbG93Og0KPiA+
IA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgRU1JDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgTTRVDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLS0t
LS0tLS0tLS0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIFNNSSBDb21tb24NCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KPiA+ICAgKy0tLS0tLS0rLS0tLS0tKy0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0rDQo+ID4gICB8ICAgICAgIHwgICAgICB8ICAgICAgfCAgICAgICAuLi4uLi4g
ICAgICAgICB8ICAgICAgIHwNCj4gPiAgIHwgICAgICAgfCAgICAgIHwgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgfA0KPiA+IGxhcmIwICAgbGFyYjEgIGxhcmIyICBsYXJiNCAg
ICAgLi4uLi4uICAgICAgbGFyYjE5ICAgbGFyYjIwDQo+ID4gZGlzcDAgICBkaXNwMSAgIG1kcCAg
ICB2ZGVjICAgICAgICAgICAgICAgICAgIElQRSAgICAgIElQRQ0KPiA+IA0KPiA+IEFsbCB0aGUg
Y29ubmVjdGlvbnMgYXJlIEhXIGZpeGVkLCBTVyBjYW4gTk9UIGFkanVzdCBpdC4NCj4gPiANCj4g
PiBtdDgxOTIgTTRVIHN1cHBvcnQgMH4xNkdCIGlvdmEgcmFuZ2UuIHdlIHByZWFzc2lnbiBkaWZm
ZXJlbnQgZW5naW5lcw0KPiA+IGludG8gZGlmZmVyZW50IGlvdmEgcmFuZ2VzOg0KPiA+IA0KPiA+
IGRvbWFpbi1pZCAgbW9kdWxlICAgICBpb3ZhLXJhbmdlICAgICAgICAgICAgICAgICAgbGFyYnMN
Cj4gPiAgICAwICAgICAgIGRpc3AgICAgICAgIDAgfiA0RyAgICAgICAgICAgICAgICAgICAgICBs
YXJiMC8xDQo+ID4gICAgMSAgICAgICB2Y29kZWMgICAgICA0RyB+IDhHICAgICAgICAgICAgICAg
ICAgICAgbGFyYjQvNS83DQo+ID4gICAgMiAgICAgICBjYW0vbWRwICAgICA4RyB+IDEyRyAgICAg
ICAgICAgICBsYXJiMi85LzExLzEzLzE0LzE2LzE3LzE4LzE5LzIwDQo+ID4gICAgMyAgICAgICBD
Q1UwICAgIDB4NDAwMF8wMDAwIH4gMHg0M2ZmX2ZmZmYgICAgIGxhcmIxMzogcG9ydCA5LzEwDQo+
ID4gICAgNCAgICAgICBDQ1UxICAgIDB4NDQwMF8wMDAwIH4gMHg0N2ZmX2ZmZmYgICAgIGxhcmIx
NDogcG9ydCA0LzUNCj4gPiANCj4gPiBUaGUgaW92YSByYW5nZSBmb3IgQ0NVMC8xKGNhbWVyYSBj
b250cm9sIHVuaXQpIGlzIEhXIHJlcXVpcmVtZW50Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KDQpbLi4uXQ0KDQo+ID4gKyNpZm5kZWYg
X0RUU19JT01NVV9QT1JUX01UODE5Ml9IXw0KPiA+ICsjZGVmaW5lIF9EVFNfSU9NTVVfUE9SVF9N
VDgxOTJfSF8NCj4gDQo+IE5vdCBhY2N1cmF0ZSBoZWFkZXIgZ3VhcmQuIFNob3VkIGJlOg0KPiBf
RFRfQklORElOR1NfTUVNT1JZX01UODE5Ml9MQVJCX1BPUlRfSF8NCj4gDQo+IFByb2JhYmx5IHlv
dSBjb3BpZWQgaXQgZnJvbSBzb21lIG90aGVyIE1lZGlhdGVrIGhlYWRlcnMgLSBhbGwgb2YgdGhl
bQ0KPiBoYXZlIGhlYWRlciBndWFyZCBwb2ludGluZyB0byBkaWZmZXJlbnQgZGlyZWN0b3J5Lg0K
DQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIHJldmlld2luZyBzbyBtYW55IHBhdGNoZXMuDQoN
ClRoaXMgbmFtZSBsaWtlIHRoaXMgd2hlbiBpdCB3YXMgaW4gdGhlIGZpcnN0IHZlcnNpb24uIFNp
bmNlIGl0IGlzIG9ubHkNCnVzZWQgd2hlbiB0aGUgY29uc3VtZXIgZGV2aWNlcyBlbmFibGUgSU9N
TVUsIHRodXMgY2FsbGVkIGl0DQpfSU9NTVVfUE9SVC4uLg0KDQpJIHdpbGwgdXNlIGEgbmV3IHBh
dGNoIHRvIHJlbmFtZSBhbGwgb2YgdGhlbS4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg0K

