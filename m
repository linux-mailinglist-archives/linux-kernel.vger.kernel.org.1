Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11991245C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHQGIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 02:08:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6250 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgHQGIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:08:49 -0400
X-UUID: 3cb821007de94198ad367d5e91840d0f-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OMz37gOAxaQvFwxexPGW4hcF8dck1+hS2ciqWaMRiLc=;
        b=X+46Cv5tayRIT733QuTQ+oKbthRXNa7oNkrvmwJQgbcjJt4zAlwMFj/ubwp3te3xCTnPSDzy+5cg91biX4Qijhrvs1vqUAOUb/Q2fCQZZTXjTXxPQTeRG5FGhVVSZGs6ApWUg95cy1DikYs8yORNfZ3sEjCssk/MN9fXt9yLE5o=;
X-UUID: 3cb821007de94198ad367d5e91840d0f-20200817
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 137716927; Mon, 17 Aug 2020 14:08:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 14:08:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 14:08:43 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, <eason.yen@mediatek.com>,
        <shane.chien@mediatek.com>, <bicycle.tsai@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v5 2/2] dt-bindings: mediatek: mt6359: add codec document
Date:   Mon, 17 Aug 2020 14:07:35 +0800
Message-ID: <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIE1lZGlhVGVrIE1UNjM1OSBjb2RlYyBkb2N1bWVudC4NCg0KU2lnbmVk
LW9mZi1ieTogSmlheGluIFl1IDxqaWF4aW4ueXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgICAgICAgfCA2OCArKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210
NjM1OS55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc291bmQvbXQ2MzU5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbXQ2MzU5LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5h
NjY5YjQ5DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwNCkBAIC0wLDAgKzEsNjggQEANCisjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tdDYzNTkueWFtbCMNCiskc2NoZW1hOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogTWVkaWF0
ZWsgTVQ2MzU5IENvZGVjIERldmljZSBUcmVlIEJpbmRpbmdzDQorDQorbWFpbnRhaW5lcnM6DQor
ICAtIEVhc29uIFllbiA8ZWFzb24ueWVuQG1lZGlhdGVrLmNvbT4NCisgIC0gSmlheGluIFl1IDxq
aWF4aW4ueXVAbWVkaWF0ZWsuY29tPg0KKyAgLSBTaGFuZSBDaGllbiA8c2hhbmUuY2hpZW5AbWVk
aWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBUaGUgY29tbXVuaWNhdGlvbiBiZXR3
ZWVuIE1UNjM1OSBhbmQgU29DIGlzIHRocm91Z2ggTWVkaWF0ZWsgUE1JQyB3cmFwcGVyLg0KKyAg
Rm9yIG1vcmUgZGV0YWlsLCBwbGVhc2UgdmlzaXQgTWVkaWF0ZWsgUE1JQyB3cmFwcGVyIGRvY3Vt
ZW50YXRpb24uDQorICBNdXN0IGJlIGEgY2hpbGQgbm9kZSBvZiBQTUlDIHdyYXBwZXIuDQorDQor
cHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGNvbnN0OiBtZWRpYXRlayxtdDYzNTkt
c291bmQNCisNCisgIG1lZGlhdGVrLGRtaWMtbW9kZToNCisgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAg
SW5kaWNhdGVzIGhvdyBtYW55IGRhdGEgcGlucyBhcmUgdXNlZCB0byB0cmFuc21pdCB0d28gY2hh
bm5lbHMgb2YgUERNDQorICAgICAgc2lnbmFsLiAwIG1lYW5zIHR3byB3aXJlcywgMSBtZWFucyBv
bmUgd2lyZS4gRGVmYXVsdCB2YWx1ZSBpcyAwLg0KKyAgICBlbnVtOg0KKyAgICAgIC0gMCAjIG9u
ZSB3aXJlDQorICAgICAgLSAxICMgdHdvIHdpcmVzDQorDQorICBtZWRpYXRlayxtaWMtdHlwZS0w
Og0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCisg
ICAgZGVzY3JpcHRpb246IHwNCisgICAgICBTcGVjaWZpZXMgdGhlIHR5cGUgb2YgbWljIHR5cGUg
Y29ubmVjdGVkIHRvIGFkYzANCisNCisgICAgZW51bToNCisgICAgICAtIDAgIyBJRExFIC0gbWlj
IGluIHR1cm4tb2ZmIHN0YXR1cw0KKyAgICAgIC0gMSAjIEFDQyAtIGFuYWxvZyBtaWMgd2l0aCBh
bHRlcm5hdGluZyBjb3VwbGluZw0KKyAgICAgIC0gMiAjIERNSUMgLSBkaWdpdGFsIG1pYw0KKyAg
ICAgIC0gMyAjIERDQyAtIGFuYWxvZyBtaWMgd2l0aCBkaXJlY3QgY291cGluZw0KKyAgICAgIC0g
NCAjIERDQ19FQ01fRElGRiAtIGFuYWxvZyBlbGVjdHJldCBjb25kZW5zZXIgbWljIHdpdGggZGlm
ZmVyZW50aWFsIG1vZGUNCisgICAgICAtIDUgIyBEQ0NfRUNNX1NJTkdMRSAtIGFuYWxvZyBlbGVj
dHJldCBjb25kZW5zZXIgbWljIHdpdGggc2luZ2xlIG1vZGUNCisNCisgIG1lZGlhdGVrLG1pYy10
eXBlLTE6DQorICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQz
Mg0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIFNwZWNpZmllcyB0aGUgdHlwZSBvZiBtaWMg
dHlwZSBjb25uZWN0ZWQgdG8gYWRjMQ0KKw0KKyAgbWVkaWF0ZWssbWljLXR5cGUtMjoNCisgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQorICAgIGRlc2Ny
aXB0aW9uOiB8DQorICAgICAgU3BlY2lmaWVzIHRoZSB0eXBlIG9mIG1pYyB0eXBlIGNvbm5lY3Rl
ZCB0byBhZGMyDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisNCithZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICBtdDYzNTljb2Rl
YzogbXQ2MzU5Y29kZWMgew0KKyAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2MzU5LXNv
dW5kIjsNCisgICAgICBtZWRpYXRlayxkbWljLW1vZGUgPSA8MD47DQorICAgICAgbWVkaWF0ZWss
bWljLXR5cGUtMCA9IDwyPjsNCisgICAgfTsNCisNCisuLi4NCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

