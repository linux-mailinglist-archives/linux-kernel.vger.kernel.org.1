Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535D22E265F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgLXL1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:27:46 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:60331 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728292AbgLXL1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:27:45 -0500
X-UUID: 6534fe546ee846e8b3136e2f8c9ec414-20201224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=x+vmTzBVFEHCrm2Yqn8M1lXv0V4BMO6yO0ekQRSMMRw=;
        b=RTqhyRuN/AFFDnpBD4IK49T4eCUUo4z6DJ7US2CGcEuMLnTla9A6u/wZMobH6b8ZRGWc6ru/JTMNTxt9qe/acwIBjVfeOIGHV7lGTNMR2tKT/FAmw/wgtFp7Y6v+8wi8hO964L+Bs5unBWauQY3cYk84s28v/vrCjKtLMRoNgME=;
X-UUID: 6534fe546ee846e8b3136e2f8c9ec414-20201224
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 172344441; Thu, 24 Dec 2020 19:26:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Dec
 2020 19:26:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 19:26:51 +0800
Message-ID: <1608809212.26323.258.camel@mhfsdcap03>
Subject: Re: [PATCH v5 04/27] dt-bindings: memory: mediatek: Add domain
 definition
From:   Yong Wu <yong.wu@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <anan.sun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 24 Dec 2020 19:26:52 +0800
In-Reply-To: <X+L8qpO+T7+U2s5r@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <20201209080102.26626-5-yong.wu@mediatek.com>
         <X+L8qpO+T7+U2s5r@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8C474D3B2374B83E77D4A8D2415ADFF8FAC79803632363B2F7FCFDD373A9DCFD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE3OjE1ICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
SGkgWW9uZywNCj4gDQo+IE9uIFdlZCwgRGVjIDA5LCAyMDIwIGF0IDA0OjAwOjM5UE0gKzA4MDAs
IFlvbmcgV3Ugd3JvdGU6DQo+ID4gSW4gdGhlIGxhdGVzdCBTb0MsIHRoZXJlIGFyZSBzZXZlcmFs
IEhXIElQIHJlcXVpcmUgYSBzZXBlY2lhbCBpb3ZhDQo+ID4gcmFuZ2UsIG1haW5seSBDQ1UgYW5k
IFZQVSBoYXMgdGhpcyByZXF1aXJlbWVudC4gVGFrZSBDQ1UgYXMgYSBleGFtcGxlLA0KPiA+IEND
VSByZXF1aXJlIGl0cyBpb3ZhIGxvY2F0ZSBpbiB0aGUgcmFuZ2UoMHg0MDAwXzAwMDAgfiAweDQz
ZmZfZmZmZikuDQo+IA0KPiBJcyB0aGlzIHJlYWxseSBhIGRvbWFpbj8gRG9lcyB0aGUgYWRkcmVz
cyByYW5nZSBjb21lIGZyb20gdGhlIGRlc2lnbiBvZg0KPiB0aGUgSU9NTVU/DQoNCkl0IGlzIG5v
dCBhIHJlYWxseSBhIGRvbWFpbi4gVGhlIGFkZHJlc3MgcmFuZ2UgY29tZXMgZnJvbSBDQ1UgSFcN
CnJlcXVpcmVtZW50LiBUaGF0IEhXIGNhbiBvbmx5IGFjY2VzcyB0aGlzIGlvdmEgcmFuZ2UuIHRo
dXMgSSBjcmVhdGUgYQ0Kc3BlY2lhbCBpb21tdSBkb21haW4gZm9yIGl0Lg0KDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IFRvbWFzeg0KPiANCj4gPiANCj4gPiBJbiB0aGlzIHBhdGNoIHdlIGFkZCBh
IGRvbWFpbiBkZWZpbml0aW9uIGZvciB0aGUgc3BlY2lhbCBwb3J0LiBJbiB0aGUNCj4gPiBleGFt
cGxlIG9mIENDVSwgSWYgd2UgcHJlYXNzaWduIENDVSBwb3J0IGluIGRvbWFpbjEsIHRoZW4gaW9t
bXUgZHJpdmVyDQo+ID4gd2lsbCBwcmVwYXJlIGEgaW5kZXBlbmRlbnQgaW9tbXUgZG9tYWluIG9m
IHRoZSBzcGVjaWFsIGlvdmEgcmFuZ2UgZm9yIGl0LA0KPiA+IHRoZW4gdGhlIGlvdmEgZ290IGZy
b20gZG1hX2FsbG9jX2F0dHJzKGNjdS1kZXYpIHdpbGwgbG9jYXRlIGluIGl0cyBzcGVjaWFsDQo+
ID4gcmFuZ2UuDQo+ID4gDQo+ID4gVGhpcyBpcyBhIHByZXBhcmluZyBwYXRjaCBmb3IgbXVsdGkt
ZG9tYWluIHN1cHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQo+ID4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtA
a2VybmVsLm9yZz4NCj4gPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4N
Cj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBv
cnQuaCB8IDkgKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5n
cy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5
L210ay1zbWktbGFyYi1wb3J0LmgNCj4gPiBpbmRleCA3ZDY0MTAzMjA5YWYuLjJkNGM5NzNjMTc0
ZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxh
cmItcG9ydC5oDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1s
YXJiLXBvcnQuaA0KPiA+IEBAIC03LDkgKzcsMTYgQEANCj4gPiAgI2RlZmluZSBfX0RUX0JJTkRJ
TkdTX01FTU9SWV9NVEtfTUVNT1JZX1BPUlRfSF8NCj4gPiAgDQo+ID4gICNkZWZpbmUgTVRLX0xB
UkJfTlJfTUFYCQkJMzINCj4gPiArI2RlZmluZSBNVEtfTTRVX0RPTV9OUl9NQVgJCTgNCj4gPiAr
DQo+ID4gKyNkZWZpbmUgTVRLX000VV9ET01fSUQoZG9taWQsIGxhcmIsIHBvcnQpCVwNCj4gPiAr
CSgoKGRvbWlkKSAmIDB4NykgPDwgMTYgfCAoKChsYXJiKSAmIDB4MWYpIDw8IDUpIHwgKChwb3J0
KSAmIDB4MWYpKQ0KPiA+ICsNCj4gPiArLyogVGhlIGRlZmF1bHQgZG9tIGlkIGlzIDAuICovDQo+
ID4gKyNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJTVRLX000VV9ET01fSUQoMCwgbGFy
YiwgcG9ydCkNCj4gPiAgDQo+ID4gLSNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJKCgo
bGFyYikgPDwgNSkgfCAocG9ydCkpDQo+ID4gICNkZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJ
KCgoaWQpID4+IDUpICYgMHgxZikNCj4gPiAgI2RlZmluZSBNVEtfTTRVX1RPX1BPUlQoaWQpCQko
KGlkKSAmIDB4MWYpDQo+ID4gKyNkZWZpbmUgTVRLX000VV9UT19ET00oaWQpCQkoKChpZCkgPj4g
MTYpICYgMHg3KQ0KPiA+ICANCj4gPiAgI2VuZGlmDQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4g
DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
PiBpb21tdSBtYWlsaW5nIGxpc3QNCj4gPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zw0KPiA+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11DQoNCg==

