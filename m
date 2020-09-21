Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F522722FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIULsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:48:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39015 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726549AbgIULsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:48:47 -0400
X-UUID: 723fbc4903a74c87bcf57c891fc1d997-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oVqp1IbqsGyD8zO5V6oIXZxuaDhcTyutjbmNVU9T2SE=;
        b=nTU0wHyOX3+tqX0j50D3+CdvmypUBqxxX7Hh+FRD5n2+uzzn0rFyPIikOXoXNFAV0g1oyeRvw32yB2IViRMxp5oFiLVRevko/faEc7fB4sFr9ovtba152SFIGl5ZXwhd9JjOJY1bfC2dFiMcO5EYvJCBZG8I5jBk134Yn8jAsS8=;
X-UUID: 723fbc4903a74c87bcf57c891fc1d997-20200921
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1891579060; Mon, 21 Sep 2020 19:48:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 19:48:37 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 19:48:39 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2 2/8] dt-bindings: mfd: Add compatible for the MediaTek MT6359 PMIC
Date:   Mon, 21 Sep 2020 19:48:09 +0800
Message-ID: <1600688895-9238-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1600688895-9238-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1600688895-9238-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIGNvbXBhdGlibGUgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTkgUE1JQy4NCg0KU2ln
bmVkLW9mZi1ieTogSHNpbi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5j
b20+DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCkFja2VkLWZv
ci1NRkQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL210NjM5Ny50eHQgfCA4ICsrKysrKystDQog
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0DQppbmRleCAy
NjYxNzc1Li4zZDE3M2I1IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21mZC9tdDYzOTcudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL210NjM5Ny50eHQNCkBAIC0yMSw2ICsyMSw3IEBAIFJlcXVpcmVkIHByb3BlcnRp
ZXM6DQogY29tcGF0aWJsZToNCiAJIm1lZGlhdGVrLG10NjMyMyIgZm9yIFBNSUMgTVQ2MzIzDQog
CSJtZWRpYXRlayxtdDYzNTgiIGZvciBQTUlDIE1UNjM1OA0KKwkibWVkaWF0ZWssbXQ2MzU5IiBm
b3IgUE1JQyBNVDYzNTkNCiAJIm1lZGlhdGVrLG10NjM5NyIgZm9yIFBNSUMgTVQ2Mzk3DQogDQog
T3B0aW9uYWwgc3Vibm9kZXM6DQpAQCAtMjksNiArMzAsNyBAQCBPcHRpb25hbCBzdWJub2RlczoN
CiAJUmVxdWlyZWQgcHJvcGVydGllczogU2hvdWxkIGJlIG9uZSBvZiBmb2xsb3dzDQogCQktIGNv
bXBhdGlibGU6ICJtZWRpYXRlayxtdDYzMjMtcnRjIg0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0
ZWssbXQ2MzU4LXJ0YyINCisJCS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM1OS1ydGMiDQog
CQktIGNvbXBhdGlibGU6ICJtZWRpYXRlayxtdDYzOTctcnRjIg0KIAlGb3IgZGV0YWlscywgc2Vl
IC4uL3J0Yy9ydGMtbXQ2Mzk3LnR4dA0KIC0gcmVndWxhdG9ycw0KQEAgLTM3LDExICszOSwxNSBA
QCBPcHRpb25hbCBzdWJub2RlczoNCiAJc2VlIC4uL3JlZ3VsYXRvci9tdDYzMjMtcmVndWxhdG9y
LnR4dA0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2MzU4LXJlZ3VsYXRvciINCiAJc2Vl
IC4uL3JlZ3VsYXRvci9tdDYzNTgtcmVndWxhdG9yLnR4dA0KKwkJLSBjb21wYXRpYmxlOiAibWVk
aWF0ZWssbXQ2MzU5LXJlZ3VsYXRvciINCisJc2VlIC4uL3JlZ3VsYXRvci9tdDYzNTktcmVndWxh
dG9yLnR4dA0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2Mzk3LXJlZ3VsYXRvciINCiAJ
c2VlIC4uL3JlZ3VsYXRvci9tdDYzOTctcmVndWxhdG9yLnR4dA0KIC0gY29kZWMNCiAJUmVxdWly
ZWQgcHJvcGVydGllczoNCi0JCS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM5Ny1jb2RlYyIg
b3IgIm1lZGlhdGVrLG10NjM1OC1zb3VuZCINCisJCS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10
NjM5Ny1jb2RlYyINCisJCS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM1OC1zb3VuZCINCisJ
CS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM1OS1zb3VuZCINCiAtIGNsaw0KIAlSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2Mzk3LWNsayINCi0t
IA0KMi42LjQNCg==

