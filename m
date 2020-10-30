Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1062A0113
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgJ3JSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:18:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45555 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725808AbgJ3JSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:18:49 -0400
X-UUID: b597d0df4fc64cada8ec769e3d5c15e1-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9EF5fmWDJQpSzok5QIIOcImlkZOclAV35NMvCm2KEY0=;
        b=EnLlynaxcDuCJgEC+Png9C7jf6cVa6jxKtczodcpv0ZucFoKlJqkV9rLWhlQaeu/ddmnj8sObnw7RIAM1sqIpI7ZrlTFKuJKH0GlNkVVHLfJRIEX8BxAljgw2aw/HrcAzA1jraZ7E5oy0KsTcC8CHoTC1gSzYRkAEBlEnGzOJag=;
X-UUID: b597d0df4fc64cada8ec769e3d5c15e1-20201030
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 818178549; Fri, 30 Oct 2020 17:13:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 17:13:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 17:13:33 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH v4 2/3] dt-bindings: memory: mediatek: Add mt8192 support
Date:   Fri, 30 Oct 2020 17:12:53 +0800
Message-ID: <20201030091254.26382-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201030091254.26382-1-yong.wu@mediatek.com>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG10ODE5MiBzbWkgc3VwcG9ydCBpbiB0aGUgYmluZGluZ3MuDQoNClNpZ25lZC1vZmYtYnk6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiAuLi4vYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJz
L21lZGlhdGVrLHNtaS1jb21tb24ueWFtbCAgICAgIHwgNCArKystDQogLi4uL2JpbmRpbmdzL21l
bW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sICAgICAgICB8IDIgKysNCiAy
IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVy
cy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbA0KaW5kZXgg
ZTA1MGEwYzJhZWQ2Li5hNWI1YWRjZTAzMTAgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24u
eWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250
cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCkBAIC0xNiw3ICsxNiw3IEBAIGRlc2Ny
aXB0aW9uOiB8Kw0KICAgTWVkaWFUZWsgU01JIGhhdmUgdHdvIGdlbmVyYXRpb25zIG9mIEhXIGFy
Y2hpdGVjdHVyZSwgaGVyZSBpcyB0aGUgbGlzdA0KICAgd2hpY2ggZ2VuZXJhdGlvbiB0aGUgU29D
cyB1c2U6DQogICBnZW5lcmF0aW9uIDE6IG10MjcwMSBhbmQgbXQ3NjIzLg0KLSAgZ2VuZXJhdGlv
biAyOiBtdDI3MTIsIG10Njc3OSwgbXQ4MTY3LCBtdDgxNzMgYW5kIG10ODE4My4NCisgIGdlbmVy
YXRpb24gMjogbXQyNzEyLCBtdDY3NzksIG10ODE2NywgbXQ4MTczLCBtdDgxODMgYW5kIG10ODE5
Mi4NCiANCiAgIFRoZXJlJ3Mgc2xpZ2h0IGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIHR3byBTTUks
IGZvciBnZW5lcmF0aW9uIDIsIHRoZQ0KICAgcmVnaXN0ZXIgd2hpY2ggY29udHJvbCB0aGUgaW9t
bXUgcG9ydCBpcyBhdCBlYWNoIGxhcmIncyByZWdpc3RlciBiYXNlLiBCdXQNCkBAIC0zNSw2ICsz
NSw3IEBAIHByb3BlcnRpZXM6DQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTY3LXNtaS1jb21t
b24NCiAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxNzMtc21pLWNvbW1vbg0KICAgICAgICAgICAt
IG1lZGlhdGVrLG10ODE4My1zbWktY29tbW9uDQorICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTky
LXNtaS1jb21tb24NCiANCiAgICAgICAtIGRlc2NyaXB0aW9uOiBmb3IgbXQ3NjIzDQogICAgICAg
ICBpdGVtczoNCkBAIC05OCw2ICs5OSw3IEBAIGFsbE9mOg0KICAgICAgICAgICAgIGVudW06DQog
ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc3OS1zbWktY29tbW9uDQogICAgICAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE4My1zbWktY29tbW9uDQorICAgICAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE5Mi1zbWktY29tbW9uDQogDQogICAgIHRoZW46DQogICAgICAgcHJvcGVydGllczoNCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRy
b2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCmluZGV4
IGExMWExMDVlODcyZi4uMDM3NjcwMGUyY2QyIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55
YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRy
b2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCkBAIC0yMyw2ICsyMyw3IEBAIHByb3BlcnRp
ZXM6DQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTY3LXNtaS1sYXJiDQogICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTczLXNtaS1sYXJiDQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLXNt
aS1sYXJiDQorICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXNtaS1sYXJiDQogDQogICAgICAg
LSBkZXNjcmlwdGlvbjogZm9yIG10NzYyMw0KICAgICAgICAgaXRlbXM6DQpAQCAtMTA2LDYgKzEw
Nyw3IEBAIGFsbE9mOg0KICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDI3MTItc21pLWxhcmIN
CiAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ2Nzc5LXNtaS1sYXJiDQogICAgICAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE2Ny1zbWktbGFyYg0KKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxt
dDgxOTItc21pLWxhcmINCiANCiAgICAgdGhlbjoNCiAgICAgICByZXF1aXJlZDoNCi0tIA0KMi4x
OC4wDQo=

