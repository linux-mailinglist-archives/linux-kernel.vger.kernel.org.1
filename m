Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDED28C995
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgJMHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:53:22 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40762 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390384AbgJMHxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:53:22 -0400
X-UUID: 1bc43fa47d6d4977b55a3f99a1ded0d3-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DqRT1QzR0Az1H7G9M7+DPOyyJAXgFclekkLZ6dVnoXo=;
        b=SrxHuU98NW7Ucopy/DZ6FpAQgFmdT/j283ahD0i5iG89EdkjAShRpEb/8qBMwdJZ68ECNxXo/tP4vfGNk2x8chc86qjh0NUWKqE0O3C95hRj2s3sINlfdqPhFhT95ll8wjG6dtspOyOdTkvgOxmLtgJDkIiDeO9aFs+g8dno3fE=;
X-UUID: 1bc43fa47d6d4977b55a3f99a1ded0d3-20201013
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 491742245; Tue, 13 Oct 2020 15:53:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Oct
 2020 15:53:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 15:53:07 +0800
Message-ID: <1602575587.26323.57.camel@mhfsdcap03>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Tue, 13 Oct 2020 15:53:07 +0800
In-Reply-To: <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-3-yong.wu@mediatek.com> <20201002110831.GD6888@pi3>
         <1601958428.26323.26.camel@mhfsdcap03>
         <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
         <1602310691.26323.39.camel@mhfsdcap03> <20201012071843.GA1889@pi3>
         <1602504119.26323.54.camel@mhfsdcap03>
         <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A35EB6041BCAB07ACFCEAFF35E492E76178322A7338BA766BED6CFFA117BDB422000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTEwLTEyIGF0IDE1OjI2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBNb24sIDEyIE9jdCAyMDIwIGF0IDE0OjAyLCBZb25nIFd1IDx5b25nLnd1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIDIwMjAtMTAtMTIgYXQgMDk6MTgg
KzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gPiBPbiBTYXQsIE9jdCAxMCwg
MjAyMCBhdCAwMjoxODoxMVBNICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUs
IDIwMjAtMTAtMDYgYXQgMDk6MTUgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
ID4gPiA+ID4gT24gVHVlLCA2IE9jdCAyMDIwIGF0IDA2OjI3LCBZb25nIFd1IDx5b25nLnd1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gRnJpLCAyMDIw
LTEwLTAyIGF0IDEzOjA4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4g
PiA+ID4gPiBPbiBXZWQsIFNlcCAzMCwgMjAyMCBhdCAwMzowNjoyNVBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IENvbnZlcnQgTWVkaWFUZWsgU01JIHRvIERUIHNjaGVt
YS4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcg
V3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ID4gPiA+ICAuLi4vbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAgICAgICAgICAgICAgICAgfCAg
NDkgLS0tLS0tLS0tDQo+ID4gPiA+ID4gPiA+ID4gIC4uLi9tZWRpYXRlayxzbWktY29tbW9uLnlh
bWwgICAgICAgICAgICAgICAgICB8IDEwMCArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiA+
ID4gPiAgLi4uL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQgIHwgIDQ5
IC0tLS0tLS0tLQ0KPiA+ID4gPiA+ID4gPiA+ICAuLi4vbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlh
dGVrLHNtaS1sYXJiLnlhbWwgfCAgOTEgKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gPiA+
ICA0IGZpbGVzIGNoYW5nZWQsIDE5MSBpbnNlcnRpb25zKCspLCA5OCBkZWxldGlvbnMoLSkNCj4g
PiA+ID4gPiA+ID4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQNCj4g
PiA+ID4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi55YW1sDQo+
ID4gPiA+ID4gPiA+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnR4dA0KPiA+
ID4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sDQo+ID4g
PiA+ID4gPiAuLi4NCj4gPiA+ID4gPiA+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ID4gPiA+ID4g
PiArICBjb21wYXRpYmxlOg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgb25lT2Y6DQo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgIC0gZW51bToNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0
ZWssbXQyNzAxLXNtaS1jb21tb24NCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0
ZWssbXQyNzEyLXNtaS1jb21tb24NCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ2Nzc5LXNtaS1jb21tb24NCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ4MTczLXNtaS1jb21tb24NCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ4MTgzLXNtaS1jb21tb24NCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IGZvciBtdDc2MjMNCj4gPiA+ID4gPiA+ID4gPiArICAgICAg
ICBpdGVtczoNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10
NzYyMy1zbWktY29tbW9uDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiBtZWRp
YXRlayxtdDI3MDEtc21pLWNvbW1vbg0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4g
PiArICByZWc6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICBjbG9ja3M6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBk
ZXNjcmlwdGlvbjogfA0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICBhcGIgYW5kIHNtaSBhcmUgbWFu
ZGF0b3J5LiB0aGUgYXN5bmMgaXMgb25seSBmb3IgZ2VuZXJhdGlvbiAxIHNtaSBIVy4NCj4gPiA+
ID4gPiA+ID4gPiArICAgICAgZ2FscyhnbG9iYWwgYXN5bmMgbG9jYWwgc3luYykgYWxzbyBpcyBv
cHRpb25hbCwgaGVyZSBpcyB0aGUgbGlzdCB3aGljaA0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICBy
ZXF1aXJlIGdhbHM6IG10Njc3OSBhbmQgbXQ4MTgzLg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgbWlu
SXRlbXM6IDINCj4gPiA+ID4gPiA+ID4gPiArICAgIG1heEl0ZW1zOiA0DQo+ID4gPiA+ID4gPiA+
ID4gKyAgICBpdGVtczoNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXBi
IGlzIEFkdmFuY2VkIFBlcmlwaGVyYWwgQnVzIGNsb2NrLCBJdCdzIHRoZSBjbG9jayBmb3INCj4g
PiA+ID4gPiA+ID4gPiArICAgICAgICAgIHNldHRpbmcgdGhlIHJlZ2lzdGVyLg0KPiA+ID4gPiA+
ID4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBzbWkgaXMgdGhlIGNsb2NrIGZvciB0cmFuc2Zl
ciBkYXRhIGFuZCBjb21tYW5kLg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBhc3luYyBpcyBhc3luY2hyb25vdXMgY2xvY2ssIGl0IGhlbHAgdHJhbnNmb3JtIHRoZSBzbWkg
Y2xvY2sNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIGludG8gdGhlIGVtaSBjbG9jayBkb21h
aW4uDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGdhbHMwIGlzIHRoZSBw
YXRoMCBjbG9jayBvZiBnYWxzLg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBnYWxzMSBpcyB0aGUgcGF0aDEgY2xvY2sgb2YgZ2Fscy4NCj4gPiA+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiA+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBvbmVP
ZjoNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgLSBpdGVtczoNCj4gPiA+ID4gPiA+ID4gPiArICAg
ICAgICAgIC0gY29uc3Q6IGFwYg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBjb25zdDog
c21pDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gPiA+ID4gPiA+ID4gKyAg
ICAgICAgICAtIGNvbnN0OiBhcGINCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gY29uc3Q6
IHNtaQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBjb25zdDogYXN5bmMNCj4gPiA+ID4g
PiA+ID4gPiArICAgICAgLSBpdGVtczoNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gY29u
c3Q6IGFwYg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBjb25zdDogc21pDQo+ID4gPiA+
ID4gPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiBnYWxzMA0KPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgICAgLSBjb25zdDogZ2FsczENCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gU2ltaWxh
cmx5IHRvIG15IGNvbW1lbnQgdG8gb3RoZXIgcHJvcGVydGllcywgdGhpcyByZXF1aXJlbWVudCBw
ZXINCj4gPiA+ID4gPiA+ID4gY29tcGF0aWJsZSBzaG91bGQgYmUgcGFydCBvZiB0aGUgc2NoZW1h
IHdpdGhpbiAnaWYtdGhlbicuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSSdtIG5vdCBzbyBm
YW1pbGlhciB3aXRoIHRoaXMgZm9ybWF0LiBEbyB0aGlzIGhhcyAiaWYtdGhlbi0nZWxzZQ0KPiA+
ID4gPiA+ID4gaWYnLXRoZW4tZWxzZSI/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVzZSBhcmUg
bXV0dWFsbHkgZXhjbHVzaXZlIGNvbmRpdGlvbnMsIHNvIHlvdSBjYW4gc2tpcCBlbHNlOg0KPiA+
ID4gPiA+ICAtIGlmLXRoZW4NCj4gPiA+ID4gPiAgLSBpZi10aGVuDQo+ID4gPiA+ID4gIC0gaWYt
dGhlbg0KPiA+ID4gPiA+IEl0IHdpbGwgYmUgbW9yZSByZWFkYWJsZSB0aGVuIHN0YWNraW5nICdp
ZicgdW5kZXIgJ2Vsc2UnDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcy4gSSB3aWxsIHVzZSBzb21l
dGhpbmcgbGlrZSB0aGlzOg0KPiA+ID4gPg0KPiA+ID4gPiAgYW55T2Y6DQo+ID4gPg0KPiA+ID4g
VGhlbiBpdCBzaG91bGQgYmUgb25lT2YgYXMgb25seSBvbmUgY29uZGl0aW9uIGNhbiBiZSB2YWxp
ZC4NCj4gPg0KPiA+IEkgZGlkIGRvIHRoaXMgYXQgdGhlIGJlZ2lubmluZy4gQnV0IEkgZ2V0IGEg
d2FybmluZyBsb2cgd2hlbg0KPiA+IGR0X2JpbmRpbmdfY2hlY2suDQo+IA0KPiBNaG1tLCByaWdo
dCwgc2luY2UgImlmLWVsc2UiIG1hdGNoZXMgaW4gZWl0aGVyIG9mIGFybXMsIHRoZW4gb25lT2YN
Cj4gd2lsbCBjb21wbGFpbiBhcyBpdCBleHBlY3RzIG9ubHkgb25lIG9mIGl0ZW1zIHRvIG1hdGNo
LiAgVGhlbiBqdXN0IGdvDQo+IHdpdGggYWxsT2YuIGFueU9mIG1pZ2h0IG1hdGNoIHplcm8gb2Yg
aXRlbXMsIHNvIGl0IHdvdWxkIG5vdCBjYXRjaA0KPiBhY3R1YWwgZXJyb3JzLCBJIHRoaW5rLg0K
DQpUaGFua3MgZm9yIHRoZSBjb25maXJtLiBJIHdpbGwgdXNlICJhbGxPZiIgaW4gbmV4dCB2ZXJz
aW9uLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

