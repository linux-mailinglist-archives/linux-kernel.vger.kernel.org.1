Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E63295EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506895AbgJVMrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:47:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46600 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2505276AbgJVMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:47:44 -0400
X-UUID: 4b2192348c7b494db12819991ebd1eb5-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tnNBLT8QS4sxWquOIKDNtO9WwSSmSHSH00fYNlT7kkA=;
        b=IlGA9wh90RLLy4/ZpoAUxcKaRxQISfi9s+KHtOV9/JFcbcQ8gwKEJ89HnSQJ+GYSu2BzC4a9VMOPmmSMXTX7KQKjWPQcfRLgdj72lfqYLtfF+2txqMz79/qcxI8sNjMDrNxK8YY8lYy6XJz6bSZFGj6ABtinkbA4mjI7/PSTLI0=;
X-UUID: 4b2192348c7b494db12819991ebd1eb5-20201022
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2002053069; Thu, 22 Oct 2020 20:47:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:47:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:47:39 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: power: Add MT8192 power domains
Date:   Thu, 22 Oct 2020 20:47:34 +0800
Message-ID: <1603370857-30646-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603370857-30646-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603370857-30646-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHBvd2VyIGRvbWFpbnMgZHQtYmluZGluZ3MgZm9yIE1UODE5Mi4NCg0KU2lnbmVkLW9mZi1i
eTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9w
b3dlci9tZWRpYXRlayxwb3dlci1jb250cm9sbGVyLnlhbWwgIHwgIDEgKw0KIGluY2x1ZGUvZHQt
YmluZGluZ3MvcG93ZXIvbXQ4MTkyLXBvd2VyLmggICAgICAgICAgIHwgMzIgKysrKysrKysrKysr
KysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1wb3dlci5oDQoNCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvbWVkaWF0
ZWsscG93ZXItY29udHJvbGxlci55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3Bvd2VyL21lZGlhdGVrLHBvd2VyLWNvbnRyb2xsZXIueWFtbA0KaW5kZXggNjdhMTVmMi4u
MWViZWQ3OSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
b3dlci9tZWRpYXRlayxwb3dlci1jb250cm9sbGVyLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9tZWRpYXRlayxwb3dlci1jb250cm9sbGVyLnlhbWwN
CkBAIC0yNSw2ICsyNSw3IEBAIHByb3BlcnRpZXM6DQogICAgIGVudW06DQogICAgICAgLSBtZWRp
YXRlayxtdDgxNzMtcG93ZXItY29udHJvbGxlcg0KICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLXBv
d2VyLWNvbnRyb2xsZXINCisgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1wb3dlci1jb250cm9sbGVy
DQogDQogICAnI3Bvd2VyLWRvbWFpbi1jZWxscyc6DQogICAgIGNvbnN0OiAxDQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxOTItcG93ZXIuaCBiL2luY2x1ZGUvZHQt
YmluZGluZ3MvcG93ZXIvbXQ4MTkyLXBvd2VyLmgNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRl
eCAwMDAwMDAwLi40ZWFhNTNkDQotLS0gL2Rldi9udWxsDQorKysgYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL3Bvd2VyL210ODE5Mi1wb3dlci5oDQpAQCAtMCwwICsxLDMyIEBADQorLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCisgKg0KKyAqIENvcHlyaWdodCAoYykgMjAyMCBNZWRp
YVRlayBJbmMuDQorICogQXV0aG9yOiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0K
KyAqLw0KKw0KKyNpZm5kZWYgX0RUX0JJTkRJTkdTX1BPV0VSX01UODE5Ml9QT1dFUl9IDQorI2Rl
ZmluZSBfRFRfQklORElOR1NfUE9XRVJfTVQ4MTkyX1BPV0VSX0gNCisNCisjZGVmaW5lIE1UODE5
Ml9QT1dFUl9ET01BSU5fQVVESU8JMA0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9DT05O
CTENCisjZGVmaW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fTUZHMAkyDQorI2RlZmluZSBNVDgxOTJf
UE9XRVJfRE9NQUlOX01GRzEJMw0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9NRkcyCTQN
CisjZGVmaW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fTUZHMwk1DQorI2RlZmluZSBNVDgxOTJfUE9X
RVJfRE9NQUlOX01GRzQJNg0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9NRkc1CTcNCisj
ZGVmaW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fTUZHNgk4DQorI2RlZmluZSBNVDgxOTJfUE9XRVJf
RE9NQUlOX0RJU1AJOQ0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9JUEUJCTEwDQorI2Rl
ZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX0lTUAkJMTENCisjZGVmaW5lIE1UODE5Ml9QT1dFUl9E
T01BSU5fSVNQMgkxMg0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9NRFAJCTEzDQorI2Rl
ZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX1ZFTkMJMTQNCisjZGVmaW5lIE1UODE5Ml9QT1dFUl9E
T01BSU5fVkRFQwkxNQ0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9WREVDMgkxNg0KKyNk
ZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9DQU0JCTE3DQorI2RlZmluZSBNVDgxOTJfUE9XRVJf
RE9NQUlOX0NBTV9SQVdBCTE4DQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX0NBTV9SQVdC
CTE5DQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX0NBTV9SQVdDCTIwDQorDQorI2VuZGlm
IC8qIF9EVF9CSU5ESU5HU19QT1dFUl9NVDgxOTJfUE9XRVJfSCAqLw0KLS0gDQoxLjguMS4xLmRp
cnR5DQo=

