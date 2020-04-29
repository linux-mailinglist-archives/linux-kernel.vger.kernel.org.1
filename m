Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ABB1BD721
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD2IWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 04:22:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22975 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgD2IWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:22:17 -0400
X-UUID: c6ebefc680a14b57a7f35b9f31a4e04b-20200429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qZd8H0gncDmhuaeDkZsmSf0T1GMDzQAuCZtsEyJ276w=;
        b=mKPWCglztYMEStd4+iCTYe36bRetTr+pMzfSnN84EnNkJepDaM/1v5MUeYDwSHc/lSpdl/Op2cIcbyx30YrUTICYrEcjm5cRVr+nVuZQ36+c9Es+QtTu5PywK72F2nP9qEwoOBDkmJiWIOAttTSrVnWKfgYsgz1uqUHWghCYYBQ=;
X-UUID: c6ebefc680a14b57a7f35b9f31a4e04b-20200429
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <xing.zhang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1863855336; Wed, 29 Apr 2020 16:22:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Apr 2020 16:22:05 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Apr 2020 16:22:04 +0800
From:   Xing Zhang <Xing.Zhang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
Subject: [PATCH v1] Add support for MediaTek regulator vibrator driver 
Date:   Wed, 29 Apr 2020 16:17:57 +0800
Message-ID: <20200429081759.26964-1-Xing.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 64AA0F256004CF6D126984937F4E5C800F560F898907513DE723D94946FD79F72000:8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGFkZCByZWd1bGF0b3IgdmlicmF0b3IgZHJpdmVyIGZvciBNVEsgU29j
LiBUaGUgZHJpdmVyIA0KY29udHJvbHMgdmlicmF0b3IgdGhyb3VnaCByZWd1bGF0b3IncyBlbmFi
bGUgYW5kIGRpc2FibGUuDQoNClhpbmcgWmhhbmcgKDMpOg0KICBkdC1iaW5kaW5nczogYWRkIHJl
Z3VsYXRvciB2aWJyYXRvciBkb2N1bWVudGF0aW9uDQogIGFybTY0OiBtZWRpYXRlazogQWRkIHJl
Z3VsYXRvciB2aWJyYXRvciBzdXBwb3J0DQogIFZpYnJhdG9yOiBBZGQgcmVndWxhdG9yIHZpYnJh
dG9yIGRyaXZlcg0KDQogLi4uL2JpbmRpbmdzL2xlZHMvcmVndWxhdG9yLXZpYnJhdG9yLnR4dCAg
ICAgIHwgIDM5ICsrDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAg
ICAgIHwgICAxICsNCiBkcml2ZXJzL2xlZHMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMTAgKw0KIGRyaXZlcnMvbGVkcy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMSArDQogZHJpdmVycy9sZWRzL3JlZ3VsYXRvci12aWJyYXRvci5jICAgICAgICAgICAg
IHwgNDUwICsrKysrKysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgNTAxIGluc2VydGlv
bnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2xlZHMvcmVndWxhdG9yLXZpYnJhdG9yLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2xlZHMvcmVndWxhdG9yLXZpYnJhdG9yLmMNCg0K

