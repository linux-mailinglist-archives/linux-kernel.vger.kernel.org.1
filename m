Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF8295E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898304AbgJVMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:37:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33534 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898282AbgJVMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:37:50 -0400
X-UUID: b937429a00bf4012b55c58c03c66f5a2-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NQbUYxMC/vO5/Luf2lSxEM/kUwLNngIueAFD5TmO+Kc=;
        b=h/su9oVkAcTy+byFd/oQUmDCWHQwn9blvaagcrE3/W3wfzfxf/nPXxD/DHAJmuBqM028sTiq9in60VgfWFmOeSOZzuedOaiBqU1wY/Xhih4wjEXcbem00JSGxp8pvAoW35FC3MS1cRvlLnWP1JG8VhGE/cc851cd1OBsa0piKKQ=;
X-UUID: b937429a00bf4012b55c58c03c66f5a2-20201022
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 78721532; Thu, 22 Oct 2020 20:37:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:45 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 04/34] dt-bindings: ARM: Mediatek: Add new document bindings of msdc controller
Date:   Thu, 22 Oct 2020 20:36:57 +0800
Message-ID: <1603370247-30437-5-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIG1zZGMgY29u
dHJvbGxlcg0KZm9yIE1lZGlhdGVrIE1UODE5Mi4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUg
PHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsv
bWVkaWF0ZWssbXNkYy55YW1sICAgICAgIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXNkYy55
YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L21lZGlhdGVrL21lZGlhdGVrLG1zZGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXNkYy55YW1sDQpuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KaW5kZXggMDAwMDAwMC4uNWFhOTUzNg0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtc2RjLnlh
bWwNCkBAIC0wLDAgKzEsNDYgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MCBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXNkYy55YW1sIw0KKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3Rp
dGxlOiBNZWRpYVRlayBNU0RDIENvbnRyb2xsZXINCisNCittYWludGFpbmVyczoNCisgIC0gV2Vp
eWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCisNCitkZXNjcmlwdGlvbjoNCisgIFRoZSBN
ZWRpYXRlayBtc2RjIGNvbnRyb2xsZXIgcHJvdmlkZXMgZnVuY3Rpb25hbCBjb25maWd1cmF0aW9u
cyBhbmQgY2xvY2tzIHRvIHRoZSBzeXN0ZW0uDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGli
bGU6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gZW51bToNCisgICAgICAgICAgLSBtZWRpYXRlayxt
dDgxOTItbXNkYw0KKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1tc2RjX3RvcA0KKyAgICAg
IC0gY29uc3Q6IHN5c2Nvbg0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgJyNj
bG9jay1jZWxscyc6DQorICAgIGNvbnN0OiAxDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGli
bGUNCisgIC0gcmVnDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgbXNkYzogc3lzY29uQDEx
ZjYwMDAwIHsNCisgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLW1zZGMiLCAi
c3lzY29uIjsNCisgICAgICAgIHJlZyA9IDwwIDB4MTFmNjAwMDAgMCAweDEwMDA+Ow0KKyAgICAg
ICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KKyAgICB9Ow0KKw0KKyAgLSB8DQorICAgIG1zZGNfdG9w
OiBzeXNjb25AMTFmMTAwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
OTItbXNkY190b3AiLCAic3lzY29uIjsNCisgICAgICAgIHJlZyA9IDwwIDB4MTFmMTAwMDAgMCAw
eDEwMDA+Ow0KKyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KKyAgICB9Ow0KLS0gDQoxLjgu
MS4xLmRpcnR5DQo=

