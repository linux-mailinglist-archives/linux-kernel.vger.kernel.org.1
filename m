Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7555B2A3AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgKCDB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:01:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55180 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbgKCDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:01:25 -0500
X-UUID: 581aa52763b349b5bf4d0609cc4cda79-20201103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kA10xqguhONUPZrUmipFwStozwcyihpqFitOURXTXYs=;
        b=ZjjHKAJmsjSRD31djYgnwRx8Z2/8qJ2wJk5n4HnOk/ViUD4bw4ZzyObjQ5pnpUuOWdAatvfCN8gSJdi2MM9cBKyVSChqUjYH+u/66/vAcYjYP56BCSOwxThKV6L+2HrNXNKNxiXTM/bypTR1zQpDfC4BH0X7dNplX+XJ/A2MNv8=;
X-UUID: 581aa52763b349b5bf4d0609cc4cda79-20201103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 745087011; Tue, 03 Nov 2020 11:01:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Nov
 2020 11:01:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Nov 2020 11:01:11 +0800
Message-ID: <1604372472.31607.18.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mediatek,mtk-xhci: add
 keep-clock-on
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Ainge Hsu" <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Mediatek WSD Upstream" <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
Date:   Tue, 3 Nov 2020 11:01:12 +0800
In-Reply-To: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
References: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFjcGF1bCwNCg0KT24gTW9uLCAyMDIwLTExLTAyIGF0IDE1OjE4ICswODAwLCBNYWNwYXVs
IExpbiB3cm90ZToNCj4gT3B0aW9uICJtZWRpYXRlayxrZWVwLWNsb2NrLW9uIiBtZWFucyB0byBr
ZWVwIGNsb2NrIG9uIGR1cmluZyBzeXN0ZW0NCj4gc3VzcGVuZCBhbmQgcmVzdW1lLiBTb21lIHBs
YXRmb3JtIHdpbGwgZmx1c2ggcmVnaXN0ZXIgc2V0dGluZ3MgaWYgY2xvY2sgaGFzDQo+IGJlZW4g
ZGlzYWJsZWQgd2hlbiBzeXN0ZW0gaXMgc3VzcGVuZGVkLiBTZXQgdGhpcyBvcHRpb24gdG8gYXZv
aWQgY2xvY2sgb2ZmLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwu
bGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
bWVkaWF0ZWssbXRrLXhoY2kueWFtbCB8ICAgIDcgKysrKysrKw0KDQpUaGlzIGRlcGVuZHMgb24g
cmV2aWV3aW5nIHBhdGNoOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xp
bnV4LW1lZGlhdGVrL3BhdGNoLzIwMjAxMDE0MDE0NDM0LjYyMjM5LTYtY2h1bmZlbmcueXVuQG1l
ZGlhdGVrLmNvbS8NClt2Miw2LzhdIGR0LWJpbmRpbmdzOiB1c2I6IGNvbnZlcnQgbWVkaWF0ZWss
IG10ay14aGNpLnR4dCB0byBZQU1MIHNjaGVtYQ0KDQpQbGVhc2UgYWRkIGl0IGFmdGVyICItLS0i
LCB0aGFua3MNCg0KDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRl
ayxtdGsteGhjaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9t
ZWRpYXRlayxtdGsteGhjaS55YW1sDQo+IGluZGV4IGVhNjk2YzguLmE5NTZkZGUgMTAwNjQ0DQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRr
LXhoY2kueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L21lZGlhdGVrLG10ay14aGNpLnlhbWwNCj4gQEAgLTEwNCw2ICsxMDQsMTIgQEAgcHJvcGVydGll
czoNCj4gICAgICBkZXNjcmlwdGlvbjogZW5hYmxlIFVTQiByZW1vdGUgd2FrZXVwLCBzZWUgcG93
ZXIvd2FrZXVwLXNvdXJjZS50eHQNCj4gICAgICB0eXBlOiBib29sZWFuDQo+ICANCj4gKyAgbWVk
aWF0ZWssa2VlcC1jbG9jay1vbjoNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgS2Vl
cCBjbG9jayBvbiBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgYW5kIHJlc3VtZS4gU29tZSBwbGF0Zm9y
bSB3aWxsIGZsdXNoDQo+ICsgICAgICByZWdpc3RlciBzZXR0aW5ncyBpZiBjbG9jayBoYXMgYmVl
biBkaXNhYmxlZCB3aGVuIHN5c3RlbSBpcyBzdXNwZW5kZWQuDQo+ICsgICAgdHlwZTogYm9vbGVh
bg0KPiArDQo+ICAgIG1lZGlhdGVrLHN5c2Nvbi13YWtldXA6DQo+ICAgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiAgICAgIG1heEl0ZW1z
OiAxDQo+IEBAIC0xNzUsNiArMTgxLDcgQEAgZXhhbXBsZXM6DQo+ICAgICAgICAgIGltb2QtaW50
ZXJ2YWwtbnMgPSA8MTAwMDA+Ow0KPiAgICAgICAgICBtZWRpYXRlayxzeXNjb24td2FrZXVwID0g
PCZwZXJpY2ZnIDB4NDAwIDE+Ow0KPiAgICAgICAgICB3YWtldXAtc291cmNlOw0KPiArICAgICAg
ICBtZWRpYXRlayxrZWVwLWNsb2NrLW9uOw0KPiAgICAgICAgICB1c2IzLWxwbS1jYXBhYmxlOw0K
PiAgICAgIH07DQo+ICAuLi4NCg0K

