Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574B527CFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgI2NrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:47:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58262 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730187AbgI2NrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:47:02 -0400
X-UUID: d5fe11d4d1054b26befe9927dbeb93d2-20200929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/ODE+lHaGlrQfgAiLYh/aPpeTyv6wYIwW1Yqa7xY6kI=;
        b=CCcxVWbSGme13mJe109HvpEl00NzvFe/pShnMvdoyp7K3EAGP6vuVlsXwhOlvkVODpM+mz1+YGs7orXvK0/PFcqZB61oI5RUUWHotiy63ax152WzJ4gzrUB8hMzwgYB38keWADqKngBii6mKqGGL3qOQD0+KUTIJ9rGuri01hRw=;
X-UUID: d5fe11d4d1054b26befe9927dbeb93d2-20200929
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 481364299; Tue, 29 Sep 2020 21:46:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 21:46:51 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Sep 2020 21:46:51 +0800
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
Subject: [v5,3/3] reset-controller: ti: force the write operation when assert or deassert
Date:   Tue, 29 Sep 2020 21:46:42 +0800
Message-ID: <20200929134642.26561-4-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200929134642.26561-1-crystal.guo@mediatek.com>
References: <20200929134642.26561-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yY2UgdGhlIHdyaXRlIG9wZXJhdGlvbiBpbiBjYXNlIHRoZSByZWFkIGFscmVhZHkgaGFwcGVu
cw0KdG8gcmV0dXJuIHRoZSBjb3JyZWN0IHZhbHVlLg0KDQpTaWduZWQtb2ZmLWJ5OiBDcnlzdGFs
IEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9yZXNldC9yZXNl
dC10aS1zeXNjb24uYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5
c2Nvbi5jIGIvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KaW5kZXggNWQxZjgzMDZj
ZDRmLi5jMzQzOTRmMWU5ZTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5
c2Nvbi5jDQorKysgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQpAQCAtOTcsNyAr
OTcsNyBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQoc3RydWN0IHJlc2V0X2Nv
bnRyb2xsZXJfZGV2ICpyY2RldiwNCiAJbWFzayA9IEJJVChjb250cm9sLT5hc3NlcnRfYml0KTsN
CiAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBBU1NFUlRfU0VUKSA/IG1hc2sgOiAweDA7DQog
DQotCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5hc3Nl
cnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQorCXJldHVybiByZWdtYXBfd3JpdGVfYml0cyhkYXRh
LT5yZWdtYXAsIGNvbnRyb2wtPmFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCiB9DQogDQog
LyoqDQpAQCAtMTI4LDcgKzEyOCw3IEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0X2RlYXNz
ZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQogCW1hc2sgPSBCSVQoY29u
dHJvbC0+ZGVhc3NlcnRfYml0KTsNCiAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBERUFTU0VS
VF9TRVQpID8gbWFzayA6IDB4MDsNCiANCi0JcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhkYXRh
LT5yZWdtYXAsIGNvbnRyb2wtPmRlYXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KKwlyZXR1
cm4gcmVnbWFwX3dyaXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5kZWFzc2VydF9vZmZz
ZXQsIG1hc2ssIHZhbHVlKTsNCiB9DQogDQogLyoqDQotLSANCjIuMTguMA0K

