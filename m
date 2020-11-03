Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E992A3C18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 06:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKCFmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 00:42:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50614 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725980AbgKCFmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 00:42:53 -0500
X-UUID: e959041ce9554034b40e9137c964acc5-20201103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rEjQ4bqynG+SjHTTklIlZc1A0jXTujtvKzHp2SrqG90=;
        b=JA6s8qwYdbH3woXqTSQ58ynM1AI23TXjraWyd9/LXf0zTeu15Z7Mqu8mh06ytaGcD0NaqixyeKhh/6xANlkObWqHwct/xW3NsO82PnZ2dc9NUrJR/S9b32q+lkKhTNh6e+Y751wKfTcuo0I5A2bGqZiubdwGFm0JLhc1dFN+918=;
X-UUID: e959041ce9554034b40e9137c964acc5-20201103
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 368426254; Tue, 03 Nov 2020 13:42:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Nov 2020 13:42:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Nov 2020 13:42:46 +0800
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
Subject: [PATCH v5 2/3] dt-bindings: memory: mediatek: Add mt8192 support
Date:   Tue, 3 Nov 2020 13:41:59 +0800
Message-ID: <20201103054200.21386-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201103054200.21386-1-yong.wu@mediatek.com>
References: <20201103054200.21386-1-yong.wu@mediatek.com>
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
NTZjNzgzMTdmOWI3Li5hMDhhMzIzNDA5ODcgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24u
eWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250
cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCkBAIC0xNiw3ICsxNiw3IEBAIGRlc2Ny
aXB0aW9uOiB8DQogICBNZWRpYVRlayBTTUkgaGF2ZSB0d28gZ2VuZXJhdGlvbnMgb2YgSFcgYXJj
aGl0ZWN0dXJlLCBoZXJlIGlzIHRoZSBsaXN0DQogICB3aGljaCBnZW5lcmF0aW9uIHRoZSBTb0Nz
IHVzZToNCiAgIGdlbmVyYXRpb24gMTogbXQyNzAxIGFuZCBtdDc2MjMuDQotICBnZW5lcmF0aW9u
IDI6IG10MjcxMiwgbXQ2Nzc5LCBtdDgxNjcsIG10ODE3MyBhbmQgbXQ4MTgzLg0KKyAgZ2VuZXJh
dGlvbiAyOiBtdDI3MTIsIG10Njc3OSwgbXQ4MTY3LCBtdDgxNzMsIG10ODE4MyBhbmQgbXQ4MTky
Lg0KIA0KICAgVGhlcmUncyBzbGlnaHQgZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGUgdHdvIFNNSSwg
Zm9yIGdlbmVyYXRpb24gMiwgdGhlDQogICByZWdpc3RlciB3aGljaCBjb250cm9sIHRoZSBpb21t
dSBwb3J0IGlzIGF0IGVhY2ggbGFyYidzIHJlZ2lzdGVyIGJhc2UuIEJ1dA0KQEAgLTM1LDYgKzM1
LDcgQEAgcHJvcGVydGllczoNCiAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxNjctc21pLWNvbW1v
bg0KICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3My1zbWktY29tbW9uDQogICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTgzLXNtaS1jb21tb24NCisgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTIt
c21pLWNvbW1vbg0KIA0KICAgICAgIC0gZGVzY3JpcHRpb246IGZvciBtdDc2MjMNCiAgICAgICAg
IGl0ZW1zOg0KQEAgLTk4LDYgKzk5LDcgQEAgYWxsT2Y6DQogICAgICAgICAgIGVudW06DQogICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDY3Nzktc21pLWNvbW1vbg0KICAgICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4MTgzLXNtaS1jb21tb24NCisgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1z
bWktY29tbW9uDQogDQogICAgIHRoZW46DQogICAgICAgcHJvcGVydGllczoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21l
ZGlhdGVrLHNtaS1sYXJiLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCmluZGV4IDA2YjYyM2Iz
NGY0OC4uN2VkNzgzOWZmMGE3IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sDQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21l
ZGlhdGVrLHNtaS1sYXJiLnlhbWwNCkBAIC0yMyw2ICsyMyw3IEBAIHByb3BlcnRpZXM6DQogICAg
ICAgICAgIC0gbWVkaWF0ZWssbXQ4MTY3LXNtaS1sYXJiDQogICAgICAgICAgIC0gbWVkaWF0ZWss
bXQ4MTczLXNtaS1sYXJiDQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLXNtaS1sYXJiDQor
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXNtaS1sYXJiDQogDQogICAgICAgLSBkZXNjcmlw
dGlvbjogZm9yIG10NzYyMw0KICAgICAgICAgaXRlbXM6DQpAQCAtMTA3LDYgKzEwOCw3IEBAIGFs
bE9mOg0KICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDI3MTItc21pLWxhcmINCiAgICAgICAg
ICAgICAgIC0gbWVkaWF0ZWssbXQ2Nzc5LXNtaS1sYXJiDQogICAgICAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE2Ny1zbWktbGFyYg0KKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItc21p
LWxhcmINCiANCiAgICAgdGhlbjoNCiAgICAgICByZXF1aXJlZDoNCi0tIA0KMi4xOC4wDQo=

