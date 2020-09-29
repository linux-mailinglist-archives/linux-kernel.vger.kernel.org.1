Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACFB27CFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgI2Nq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:46:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58262 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728844AbgI2Nq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:46:59 -0400
X-UUID: 81e6a7b9132f4f48a38f97897c513b27-20200929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WmWSE7IzhJl4QSCNXojtBre/0v5HhT1SrIhjLveOb40=;
        b=DwLJyhUovKVB9chSFmABya5T24wW9pOntpI3rIuqRSBYuDnds0Msn3mVO+ESZG1L0KowBZxdkeFDuMm/q20qZD/Q+PT8+RgKyTtUDkMmVVYypscu7vf9IyrfNwpg+c9SrSgjTXGoLOw6sIyi4CyDkshyfp71RCTjOsb/AeF+fRU=;
X-UUID: 81e6a7b9132f4f48a38f97897c513b27-20200929
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1416023101; Tue, 29 Sep 2020 21:46:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 21:46:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Sep 2020 21:46:49 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v5,1/3] dt-binding: reset-controller: mediatek: add YAML schemas
Date:   Tue, 29 Sep 2020 21:46:40 +0800
Message-ID: <20200929134642.26561-2-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200929134642.26561-1-crystal.guo@mediatek.com>
References: <20200929134642.26561-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgWUFNTCBkb2N1bWVudGF0aW9uIGZvciBNZWRpYXRlaywgd2hpY2ggdXNlcyB0aSByZXNl
dC1jb250cm9sbGVyDQpkcml2ZXIgZGlyZWN0bHkuIFRoZSBUSSByZXNldCBjb250cm9sbGVyIHBy
b3ZpZGVzIGEgY29tbW9uIHJlc2V0IG1hbmFnZW1lbnQsDQphbmQgaXMgc3VpdGFibGUgZm9yIE1l
ZGlhdGVrIFNvQ3MuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0Bt
ZWRpYXRlay5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29uLXJl
c2V0LnlhbWwgfCA1MSArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUxIGlu
c2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1yZXNldC55YW1sDQoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29u
LXJlc2V0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVk
aWF0ZWstc3lzY29uLXJlc2V0LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAw
MDAwMDAwMDAuLmRhYjYzMGU5NWEwZA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1yZXNldC55YW1sDQpA
QCAtMCwwICsxLDUxIEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKyVZ
QU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcmVzZXQv
bWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlhdGVrIFJlc2V0IENv
bnRyb2xsZXINCisNCittYWludGFpbmVyczoNCisgIC0gQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3Vv
QG1lZGlhdGVrLmNvbT4NCisNCitkZXNjcmlwdGlvbjoNCisgIFRoZSBiaW5kaW5ncyBkZXNjcmli
ZSB0aGUgcmVzZXQtY29udHJvbGxlciBmb3IgTWVkaWF0ZWsgU29DcywNCisgIHdoaWNoIGlzIGJh
c2VkIG9uIFRJIHJlc2V0IGNvbnRyb2xsZXIuIEZvciBtb3JlIGRldGFpbCwgcGxlYXNlDQorICB2
aXNpdCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJl
c2V0LnR4dC4NCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgY29uc3Q6IG1l
ZGlhdGVrLHN5c2Nvbi1yZXNldA0KKw0KKyAgJyNyZXNldC1jZWxscyc6DQorICAgIGNvbnN0OiAx
DQorDQorICBtZWRpYXRlayxyZXNldC1iaXRzOg0KKyAgICBkZXNjcmlwdGlvbjogPg0KKyAgICAg
IENvbnRhaW5zIHRoZSByZXNldCBjb250cm9sIHJlZ2lzdGVyIGluZm9ybWF0aW9uLCBwbGVhc2Ug
cmVmZXIgdG8NCisgICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQv
dGktc3lzY29uLXJlc2V0LnR4dC4NCisNCityZXF1aXJlZDoNCisgIC0gY29tcGF0aWJsZQ0KKyAg
LSAnI3Jlc2V0LWNlbGxzJw0KKyAgLSBtZWRpYXRlayxyZXNldC1iaXRzDQorDQorYWRkaXRpb25h
bFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi5oPg0KKyAgICBpbmZyYWNmZzogaW5mcmFjZmdA
MTAwMDEwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaW5mcmFj
ZmciLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KKyAgICAgICAgcmVnID0gPDAgMHgxMDAwMTAw
MCAwIDB4MTAwMD47DQorICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQorDQorICAgICAgICBp
bmZyYWNmZ19yc3Q6IHJlc2V0LWNvbnRyb2xsZXIgew0KKyAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAibWVkaWF0ZWssc3lzY29uLXJlc2V0IjsNCisgICAgICAgICAgICAjcmVzZXQtY2VsbHMgPSA8
MT47DQorICAgICAgICAgICAgbWVkaWF0ZWsscmVzZXQtYml0cyA9IDwNCisgICAgICAgICAgICAg
ICAweDE0MCAxNSAweDE0NCAxNSAwIDAgKEFTU0VSVF9TRVQgfCBERUFTU0VSVF9TRVQgfCBTVEFU
VVNfTk9ORSkNCisgICAgICAgICAgICA+Ow0KKyAgICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi4x
OC4wDQo=

