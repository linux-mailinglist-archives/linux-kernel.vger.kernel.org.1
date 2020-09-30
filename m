Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABC27DE70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgI3CWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:22:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40260 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729322AbgI3CWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:22:08 -0400
X-UUID: 83388a317135423b95e01a9346cbf59f-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PTUVFD+apyy6mQmY58fFDkNYQDyfBeyrLgmoDEvIU44=;
        b=R1Mi678oPirLVImcuDo/QvjfU1NG/H5UrP0H2kOLJs4xGpWCsrTI/nCdY/W2lsbnQFf9Sgn5HqyLWVJa5hLGrLWFN4X808DdaHr5Kouhx8h/zrtiG+5SXVqfoMCY8QKiXfcxBdK3NfUbNshGNA1HJhPSiwLAHWr/brchm5iaiVo=;
X-UUID: 83388a317135423b95e01a9346cbf59f-20200930
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 569259711; Wed, 30 Sep 2020 10:22:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 10:21:59 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 10:22:02 +0800
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
Subject: [v6,1/3] dt-binding: reset-controller: mediatek: add YAML schemas
Date:   Wed, 30 Sep 2020 10:21:57 +0800
Message-ID: <20200930022159.5559-2-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930022159.5559-1-crystal.guo@mediatek.com>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgWUFNTCBkb2N1bWVudGF0aW9uIGZvciBNZWRpYXRlaywgd2hpY2ggdXNlcyB0aSByZXNl
dC1jb250cm9sbGVyDQpkcml2ZXIgZGlyZWN0bHkuIFRoZSBUSSByZXNldCBjb250cm9sbGVyIHBy
b3ZpZGVzIGEgY29tbW9uIHJlc2V0DQptYW5hZ2VtZW50LCBhbmQgaXMgc3VpdGFibGUgZm9yIE1l
ZGlhdGVrIFNvQ3MuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0Bt
ZWRpYXRlay5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29uLXJl
c2V0LnlhbWwgfCA1MSArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUxIGlu
c2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1yZXNldC55YW1sDQoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29u
LXJlc2V0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvbWVk
aWF0ZWstc3lzY29uLXJlc2V0LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAw
MDAwMDAwMDAuLjc4NzE1NTBjM2M2OQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1yZXNldC55YW1sDQpA
QCAtMCwwICsxLDUxIEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25s
eSBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbCMNCiskc2No
ZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0
aXRsZTogTWVkaWF0ZWsgUmVzZXQgQ29udHJvbGxlcg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBD
cnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOg0K
KyAgVGhlIGJpbmRpbmdzIGRlc2NyaWJlIHRoZSByZXNldC1jb250cm9sbGVyIGZvciBNZWRpYXRl
ayBTb0NzLA0KKyAgd2hpY2ggaXMgYmFzZWQgb24gVEkgcmVzZXQgY29udHJvbGxlci4gRm9yIG1v
cmUgZGV0YWlsLCBwbGVhc2UNCisgIHZpc2l0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0Lg0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21w
YXRpYmxlOg0KKyAgICBjb25zdDogbWVkaWF0ZWssc3lzY29uLXJlc2V0DQorDQorICAnI3Jlc2V0
LWNlbGxzJzoNCisgICAgY29uc3Q6IDENCisNCisgIG1lZGlhdGVrLHJlc2V0LWJpdHM6DQorICAg
IGRlc2NyaXB0aW9uOiA+DQorICAgICAgQ29udGFpbnMgdGhlIHJlc2V0IGNvbnRyb2wgcmVnaXN0
ZXIgaW5mb3JtYXRpb24sIHBsZWFzZSByZWZlciB0bw0KKyAgICAgIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0Lg0KKw0KK3JlcXVpcmVk
Og0KKyAgLSBjb21wYXRpYmxlDQorICAtICcjcmVzZXQtY2VsbHMnDQorICAtIG1lZGlhdGVrLHJl
c2V0LWJpdHMNCisNCithZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoN
CisgIC0gfA0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLmg+DQor
ICAgIGluZnJhY2ZnOiBpbmZyYWNmZ0AxMDAwMTAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5Mi1pbmZyYWNmZyIsICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQorICAg
ICAgICByZWcgPSA8MCAweDEwMDAxMDAwPjsNCisgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsN
CisNCisgICAgICAgIGluZnJhY2ZnX3JzdDogcmVzZXQtY29udHJvbGxlciB7DQorICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxzeXNjb24tcmVzZXQiOw0KKyAgICAgICAgICAgICNy
ZXNldC1jZWxscyA9IDwxPjsNCisgICAgICAgICAgICBtZWRpYXRlayxyZXNldC1iaXRzID0gPA0K
KyAgICAgICAgICAgICAgIDB4MTQwIDE1IDB4MTQ0IDE1IDAgMCAoQVNTRVJUX1NFVCB8IERFQVNT
RVJUX1NFVCB8IFNUQVRVU19OT05FKQ0KKyAgICAgICAgICAgID47DQorICAgICAgICB9Ow0KKyAg
ICB9Ow0KLS0gDQoyLjE4LjANCg==

