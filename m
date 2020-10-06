Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E234C2844CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgJFE1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:27:19 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:9011 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbgJFE1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:27:18 -0400
X-UUID: 657d3555277e4a10a234b2323b8e721e-20201006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WnWWZYGTcT78KXIBsHhsNiz4yOOrVWJfS9BpjfICDfU=;
        b=QJQJa2D0jmGMReLrgvHiPoPkdBPEcEBEATpZ0iMhRqKBCeVTvX6IyfXv8wIuzCvC4LoGZyGctB8pPsCa+F/t5a3qgNz77wRWkKMHi8rlk9PeDetPwwgQ9lMda8beYsK7snSqhGy1LzwqoNn9UDcfJtMBJE8G867AdoAkVtL/HZY=;
X-UUID: 657d3555277e4a10a234b2323b8e721e-20201006
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1586165562; Tue, 06 Oct 2020 12:27:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Oct
 2020 12:27:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Oct 2020 12:27:07 +0800
Message-ID: <1601958428.26323.26.camel@mhfsdcap03>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
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
Date:   Tue, 6 Oct 2020 12:27:08 +0800
In-Reply-To: <20201002110831.GD6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-3-yong.wu@mediatek.com> <20201002110831.GD6888@pi3>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 07CA81F1F3F14B41F4FC092F2B44C4679867F49762ADB54295A5B01FD53386612000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTAyIGF0IDEzOjA4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBXZWQsIFNlcCAzMCwgMjAyMCBhdCAwMzowNjoyNVBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+IENvbnZlcnQgTWVkaWFUZWsgU01JIHRvIERUIHNjaGVtYS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL21lZGlhdGVrLHNtaS1jb21tb24udHh0ICAgICAgICAgICAgICAgICAgIHwgIDQ5
IC0tLS0tLS0tLQ0KPiA+ICAuLi4vbWVkaWF0ZWssc21pLWNvbW1vbi55YW1sICAgICAgICAgICAg
ICAgICAgfCAxMDAgKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9tZW1vcnktY29udHJvbGxl
cnMvbWVkaWF0ZWssc21pLWxhcmIudHh0ICB8ICA0OSAtLS0tLS0tLS0NCj4gPiAgLi4uL21lbW9y
eS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sIHwgIDkxICsrKysrKysrKysrKysr
KysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxOTEgaW5zZXJ0aW9ucygrKSwgOTggZGVsZXRpb25z
KC0pDQo+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0DQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5
LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbA0KPiA+ICBkZWxldGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVy
cy9tZWRpYXRlayxzbWktbGFyYi50eHQNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21p
LWxhcmIueWFtbA0KLi4uDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4g
PiArICAgIG9uZU9mOg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAtIG1lZGlh
dGVrLG10MjcwMS1zbWktY29tbW9uDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10MjcxMi1z
bWktY29tbW9uDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10Njc3OS1zbWktY29tbW9uDQo+
ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3My1zbWktY29tbW9uDQo+ID4gKyAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE4My1zbWktY29tbW9uDQo+ID4gKw0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBmb3IgbXQ3NjIzDQo+ID4gKyAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAt
IGNvbnN0OiBtZWRpYXRlayxtdDc2MjMtc21pLWNvbW1vbg0KPiA+ICsgICAgICAgICAgLSBjb25z
dDogbWVkaWF0ZWssbXQyNzAxLXNtaS1jb21tb24NCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgZGVzY3JpcHRp
b246IHwNCj4gPiArICAgICAgYXBiIGFuZCBzbWkgYXJlIG1hbmRhdG9yeS4gdGhlIGFzeW5jIGlz
IG9ubHkgZm9yIGdlbmVyYXRpb24gMSBzbWkgSFcuDQo+ID4gKyAgICAgIGdhbHMoZ2xvYmFsIGFz
eW5jIGxvY2FsIHN5bmMpIGFsc28gaXMgb3B0aW9uYWwsIGhlcmUgaXMgdGhlIGxpc3Qgd2hpY2gN
Cj4gPiArICAgICAgcmVxdWlyZSBnYWxzOiBtdDY3NzkgYW5kIG10ODE4My4NCj4gPiArICAgIG1p
bkl0ZW1zOiAyDQo+ID4gKyAgICBtYXhJdGVtczogNA0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAg
ICAgIC0gZGVzY3JpcHRpb246IGFwYiBpcyBBZHZhbmNlZCBQZXJpcGhlcmFsIEJ1cyBjbG9jaywg
SXQncyB0aGUgY2xvY2sgZm9yDQo+ID4gKyAgICAgICAgICBzZXR0aW5nIHRoZSByZWdpc3Rlci4N
Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogc21pIGlzIHRoZSBjbG9jayBmb3IgdHJhbnNmZXIg
ZGF0YSBhbmQgY29tbWFuZC4NCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXN5bmMgaXMgYXN5
bmNocm9ub3VzIGNsb2NrLCBpdCBoZWxwIHRyYW5zZm9ybSB0aGUgc21pIGNsb2NrDQo+ID4gKyAg
ICAgICAgICBpbnRvIHRoZSBlbWkgY2xvY2sgZG9tYWluLg0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBnYWxzMCBpcyB0aGUgcGF0aDAgY2xvY2sgb2YgZ2Fscy4NCj4gPiArICAgICAgLSBkZXNj
cmlwdGlvbjogZ2FsczEgaXMgdGhlIHBhdGgxIGNsb2NrIG9mIGdhbHMuDQo+ID4gKw0KPiA+ICsg
IGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4g
KyAgICAgICAgICAtIGNvbnN0OiBhcGINCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHNtaQ0KPiA+
ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogYXBiDQo+ID4gKyAgICAg
ICAgICAtIGNvbnN0OiBzbWkNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IGFzeW5jDQo+ID4gKyAg
ICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBhcGINCj4gPiArICAgICAgICAg
IC0gY29uc3Q6IHNtaQ0KPiA+ICsgICAgICAgICAgLSBjb25zdDogZ2FsczANCj4gPiArICAgICAg
ICAgIC0gY29uc3Q6IGdhbHMxDQo+IA0KPiBTaW1pbGFybHkgdG8gbXkgY29tbWVudCB0byBvdGhl
ciBwcm9wZXJ0aWVzLCB0aGlzIHJlcXVpcmVtZW50IHBlcg0KPiBjb21wYXRpYmxlIHNob3VsZCBi
ZSBwYXJ0IG9mIHRoZSBzY2hlbWEgd2l0aGluICdpZi10aGVuJy4NCg0KSSdtIG5vdCBzbyBmYW1p
bGlhciB3aXRoIHRoaXMgZm9ybWF0LiBEbyB0aGlzIGhhcyAiaWYtdGhlbi0nZWxzZQ0KaWYnLXRo
ZW4tZWxzZSI/DQoNCkkgdHJpZWQgYmVsb3cgaW5zdGVhZCBvZiB0aGUgY2xvY2tzIHNlZ21lbnQg
YWJvdmU6DQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQppZjoNCiAgcHJv
cGVydGllczoNCiAgICBjb21wYXRpYmxlOg0KICAgICAgZW51bToNCiAgICAgICAgLSBtZWRpYXRl
ayxtdDY3Nzktc21pLWNvbW1vbg0KICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1zbWktY29tbW9u
DQoNCnRoZW46DQogIHByb3BlcnRpZXM6DQogICAgY2xvY2s6DQogICAgICBpdGVtczoNCiAgICAg
ICAgLSBkZXNjcmlwdGlvbjogYXBiIGlzIHRoZSBjbG9jayBmb3Igc2V0dGluZyB0aGUgcmVnaXN0
ZXIuLg0KICAgICAgICAtIGRlc2NyaXB0aW9uOiBzbWkgaXMgdGhlIGNsb2NrIGZvciB0cmFuc2Zl
ciBkYXRhIGFuZCBjb21tYW5kLg0KICAgICAgICAtIGRlc2NyaXB0aW9uOiBnYWxzMCBpcyB0aGUg
cGF0aDAgY2xvY2sgb2YgZ2FscyhnbG9iYWwgYXN5bmMNCmxvY2FsIHN5bmMpLg0KICAgICAgICAt
IGRlc2NyaXB0aW9uOiBnYWxzMSBpcyB0aGUgcGF0aDEgY2xvY2sgb2YgZ2Fscy4NCiAgICBjbG9j
ay1uYW1lczoNCiAgICAgIGl0ZW1zOg0KICAgICAgICAtIGNvbnN0OiBhcGINCiAgICAgICAgLSBj
b25zdDogc21pDQogICAgICAgIC0gY29uc3Q6IGdhbHMwDQogICAgICAgIC0gY29uc3Q6IGdhbHMx
DQplbHNlOg0KICBpZjoNCiAgICBwcm9wZXJ0aWVzOg0KICAgICAgY29tcGF0aWJsZToNCiAgICAg
ICAgY29udGFpbnM6DQogICAgICAgICAgZW51bToNCiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQy
NzAxLXNtaS1jb21tb24NCg0KICB0aGVuOg0KICAgIHByb3BlcnRpZXM6DQogICAgICBjbG9ja3M6
DQogICAgICAgIGl0ZW1zOg0KICAgICAgICAgIC0gZGVzY3JpcHRpb246IGFwYiBpcyB0aGUgY2xv
Y2sgZm9yIHNldHRpbmcgdGhlIHJlZ2lzdGVyLg0KICAgICAgICAgIC0gZGVzY3JpcHRpb246IHNt
aSBpcyB0aGUgY2xvY2sgZm9yIHRyYW5zZmVyIGRhdGEgYW5kIGNvbW1hbmQuDQogICAgICAgICAg
LSBkZXNjcmlwdGlvbjogYXN5bmMgaXMgYXN5bmNocm9ub3VzIGNsb2NrLCBpdCBoZWxwIHRyYW5z
Zm9ybQ0KdGhlIHNtaSBjbG9jaw0KICAgICAgICAgICAgICBpbnRvIHRoZSBlbWkgY2xvY2sgZG9t
YWluLg0KICAgICAgY2xvY2stbmFtZXM6DQogICAgICAgIGl0ZW1zOg0KICAgICAgICAgIC0gY29u
c3Q6IGFwYg0KICAgICAgICAgIC0gY29uc3Q6IHNtaQ0KICAgICAgICAgIC0gY29uc3Q6IGFzeW5j
DQogIGVsc2U6DQogICAgcHJvcGVydGllczoNCiAgICAgIGNsb2NrczoNCiAgICAgICAgaXRlbXM6
DQogICAgICAgICAgLSBkZXNjcmlwdGlvbjogYXBiIGlzIHRoZSBjbG9jayBmb3Igc2V0dGluZyB0
aGUgcmVnaXN0ZXIuDQogICAgICAgICAgLSBkZXNjcmlwdGlvbjogc21pIGlzIHRoZSBjbG9jayBm
b3IgdHJhbnNmZXIgZGF0YSBhbmQNCmNvbW1hbmQuICAgIA0KICAgICAgY2xvY2stbmFtZXM6DQog
ICAgICAgIGl0ZW1zOg0KICAgICAgICAgIC0gY29uc3Q6IGFwYg0KICAgICAgICAgIC0gY29uc3Q6
IHNtaQ0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KQnV0IEkgZ290IGEgd2Fy
bmluZyB3aGVuIGR0X2JpbmRpbmdfY2hlY2s6DQoNCkNIS0RUDQpEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFt
bA0KICBTQ0hFTUENCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wcm9jZXNzZWQt
c2NoZW1hLWV4YW1wbGVzLnlhbWwNCiAgRFRDDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24uZXhhbXBsZS5kdC55
YW1sDQogIENIRUNLDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNv
bnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24uZXhhbXBsZS5kdC55YW1sDQouLi4vRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxz
bWktY29tbW9uLmV4YW1wbGUuZHQueWFtbDogc21pQDE0MDIyMDAwOiAnY2xvY2stbmFtZXMnLCAn
Y2xvY2tzJyBkbyBub3QgbWF0Y2ggYW55IG9mIHRoZSByZWdleGVzOiAncGluY3RybC1bMC05XSsn
DQogICAgRnJvbQ0Kc2NoZW1hOiAuLi4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCg0KQW55IHN1Z2dl
c3Rpb24gYWJvdXQgdGhpcz8NClRoYW5rcy4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg0K

