Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23F22AAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGWIco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 04:32:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2499 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725846AbgGWIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:32:43 -0400
X-UUID: 731fe79281064ae58e68f0ffbd6a330b-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FvbPiqMUKPIekt5igyb/5p25Qo6j9u44sXtE5an3ghM=;
        b=WaaUETI7QDYF4sk8AOHMwoOhqN6ZCckoe+O4KCftjkVJOlobOVTkQzrEKphTGrnNuXYnert/Cldqne6lwjPRROi2/KPFmFKqmD1THtiO+bieU8kXUALWpiruz8cUgh72n0CCviwlmOXgY2SJ03mrUgO/xHEJsVMSm47uKjjPbg8=;
X-UUID: 731fe79281064ae58e68f0ffbd6a330b-20200723
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1225544950; Thu, 23 Jul 2020 16:32:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 16:32:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 16:32:37 +0800
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Subject: [PATCH 1/1] clk: Export clk_register_composite
Date:   Thu, 23 Jul 2020 16:32:06 +0800
Message-ID: <1595493126-21611-1-git-send-email-wendell.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y2xrX3JlZ2lzdGVyX2NvbXBvc2l0ZSgpIHdpbGwgYmUgdXNlZCBpbiBtZWRpYXRlaydzDQpjbG9j
ayBrZXJuZWwgbW9kdWxlLCBzbyBleHBvcnQgaXQgdG8gR1BMIG1vZHVsZXMuDQoNClNpZ25lZC1v
ZmYtYnk6IFdlbmRlbGwgTGluIDx3ZW5kZWxsLmxpbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMgfCAgICAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYyBiL2Ry
aXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYw0KaW5kZXggNzM3NmY1Ny4uN2M2MDljMiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYw0KKysrIGIvZHJpdmVycy9jbGsvY2xr
LWNvbXBvc2l0ZS5jDQpAQCAtMzYwLDYgKzM2MCw3IEBAIHN0cnVjdCBjbGsgKmNsa19yZWdpc3Rl
cl9jb21wb3NpdGUoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KIAkJcmV0
dXJuIEVSUl9DQVNUKGh3KTsNCiAJcmV0dXJuIGh3LT5jbGs7DQogfQ0KK0VYUE9SVF9TWU1CT0xf
R1BMKGNsa19yZWdpc3Rlcl9jb21wb3NpdGUpOw0KIA0KIHN0cnVjdCBjbGsgKmNsa19yZWdpc3Rl
cl9jb21wb3NpdGVfcGRhdGEoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0K
IAkJCWNvbnN0IHN0cnVjdCBjbGtfcGFyZW50X2RhdGEgKnBhcmVudF9kYXRhLA0KLS0gDQoxLjcu
OS41DQo=

