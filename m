Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73522AFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 14:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgGWM7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 08:59:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47527 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbgGWM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:59:10 -0400
X-UUID: 36479443c44e480c8794681d4e9426ab-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2Is1ucYR1KtV1gnXVnRLEL8b3ceL3UIHja7wdO9zHDE=;
        b=jM3kal+0FrfxK3BIh0gx9XnRp1bqUDB9B66bcQWK359Ap1CIEJ2RDVB0umamDbpE/JiuHeZPRIUUn66Aim3IjniLvU+vcWYk/HWZzQFDxcySfI6dmd8EmOq5LUPQe5EmVqZPUeXYfhjHazURhh6I9h1AJL/eC8mf3j9tyXHg0/Q=;
X-UUID: 36479443c44e480c8794681d4e9426ab-20200723
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 604457892; Thu, 23 Jul 2020 20:59:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 20:59:04 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 20:59:06 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: [PATCH 2/8] dt-bindings: mfd: Add compatible for the MediaTek MT6359 PMIC
Date:   Thu, 23 Jul 2020 20:58:47 +0800
Message-ID: <1595509133-5358-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIGNvbXBhdGlibGUgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTkgUE1JQy4NCg0KU2ln
bmVkLW9mZi1ieTogSHNpbi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5j
b20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL210NjM5Ny50
eHQgfCA4ICsrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9tdDYzOTcudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9t
dDYzOTcudHh0DQppbmRleCAyNjYxNzc1Li4zZDE3M2I1IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0DQorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL210NjM5Ny50eHQNCkBAIC0yMSw2ICsyMSw3IEBA
IFJlcXVpcmVkIHByb3BlcnRpZXM6DQogY29tcGF0aWJsZToNCiAJIm1lZGlhdGVrLG10NjMyMyIg
Zm9yIFBNSUMgTVQ2MzIzDQogCSJtZWRpYXRlayxtdDYzNTgiIGZvciBQTUlDIE1UNjM1OA0KKwki
bWVkaWF0ZWssbXQ2MzU5IiBmb3IgUE1JQyBNVDYzNTkNCiAJIm1lZGlhdGVrLG10NjM5NyIgZm9y
IFBNSUMgTVQ2Mzk3DQogDQogT3B0aW9uYWwgc3Vibm9kZXM6DQpAQCAtMjksNiArMzAsNyBAQCBP
cHRpb25hbCBzdWJub2RlczoNCiAJUmVxdWlyZWQgcHJvcGVydGllczogU2hvdWxkIGJlIG9uZSBv
ZiBmb2xsb3dzDQogCQktIGNvbXBhdGlibGU6ICJtZWRpYXRlayxtdDYzMjMtcnRjIg0KIAkJLSBj
b21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2MzU4LXJ0YyINCisJCS0gY29tcGF0aWJsZTogIm1lZGlh
dGVrLG10NjM1OS1ydGMiDQogCQktIGNvbXBhdGlibGU6ICJtZWRpYXRlayxtdDYzOTctcnRjIg0K
IAlGb3IgZGV0YWlscywgc2VlIC4uL3J0Yy9ydGMtbXQ2Mzk3LnR4dA0KIC0gcmVndWxhdG9ycw0K
QEAgLTM3LDExICszOSwxNSBAQCBPcHRpb25hbCBzdWJub2RlczoNCiAJc2VlIC4uL3JlZ3VsYXRv
ci9tdDYzMjMtcmVndWxhdG9yLnR4dA0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2MzU4
LXJlZ3VsYXRvciINCiAJc2VlIC4uL3JlZ3VsYXRvci9tdDYzNTgtcmVndWxhdG9yLnR4dA0KKwkJ
LSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2MzU5LXJlZ3VsYXRvciINCisJc2VlIC4uL3JlZ3Vs
YXRvci9tdDYzNTktcmVndWxhdG9yLnR4dA0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2
Mzk3LXJlZ3VsYXRvciINCiAJc2VlIC4uL3JlZ3VsYXRvci9tdDYzOTctcmVndWxhdG9yLnR4dA0K
IC0gY29kZWMNCiAJUmVxdWlyZWQgcHJvcGVydGllczoNCi0JCS0gY29tcGF0aWJsZTogIm1lZGlh
dGVrLG10NjM5Ny1jb2RlYyIgb3IgIm1lZGlhdGVrLG10NjM1OC1zb3VuZCINCisJCS0gY29tcGF0
aWJsZTogIm1lZGlhdGVrLG10NjM5Ny1jb2RlYyINCisJCS0gY29tcGF0aWJsZTogIm1lZGlhdGVr
LG10NjM1OC1zb3VuZCINCisJCS0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM1OS1zb3VuZCIN
CiAtIGNsaw0KIAlSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAkJLSBjb21wYXRpYmxlOiAibWVkaWF0
ZWssbXQ2Mzk3LWNsayINCi0tIA0KMi42LjQNCg==

