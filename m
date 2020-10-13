Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F0A28CA90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404077AbgJMIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:52:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55200 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404037AbgJMIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:52:17 -0400
X-UUID: 947481e64ec9424588f1b9139a07c78d-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M0jfuzjqV7E455NTJr6fQC3EWDs6oJ4TvyZIG6UrQ+o=;
        b=ni78l6cEsJsJuifv3oNJ4nS0+CTVBL6deaw/lM6NUscm2RoNXyKnaHVDb8Zl0aizGwoH8NO75/UbqH5EtZorRbZHlpxSs/n+BFaHe7UebH0Q0zsJos1lU/pZ46WyIgqH1NBSowrk99Co6UKqC1BYYwDvVLni7GikBisc3OxmjQ4=;
X-UUID: 947481e64ec9424588f1b9139a07c78d-20201013
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 917399905; Tue, 13 Oct 2020 16:52:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Oct 2020 16:52:12 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 16:52:13 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        CK Hu <ck.hu@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Min Guo <min.guo@mediatek.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v2 8/8] MAINTAINERS: update MediaTek PHY/USB entry
Date:   Tue, 13 Oct 2020 16:52:07 +0800
Message-ID: <20201013085207.17749-8-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHVlIHRvIHRoZSBwaHkvdXNiIGJpbmRpbmdzIGFyZSBjb252ZXJ0ZWQgaW50byBZQU1MIHNjaGVt
YSBhbmQNCmFsc28gcmVuYW1lZCwgdXBkYXRlIGVudHJpZXMuDQpNZWFud2hpbGUgYWRkIGRyaXZl
cnMvdXNiL2hvc3QvbXRrLXhoY2kqIGZpbGVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBuZXcgcGF0Y2gNCi0tLQ0K
IE1BSU5UQUlORVJTIHwgNCArKystDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0K
aW5kZXggZGVhYWZiNjE3MzYxLi5kNjg3MjVkODdlNDQgMTAwNjQ0DQotLS0gYS9NQUlOVEFJTkVS
Uw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0yMTA1LDcgKzIxMDUsNyBAQCBNOglDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQogTDoJbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykNCiBMOglsaW51
eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3Jp
YmVycykNCiBTOglNYWludGFpbmVkDQotRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9waHktbXRrLSoNCitGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGh5L21lZGlhdGVrLCoNCiBGOglkcml2ZXJzL3BoeS9tZWRpYXRlay8NCiANCiBBUk0vTWljcm9j
aGlwIChBVDkxKSBTb0Mgc3VwcG9ydA0KQEAgLTExMDI4LDYgKzExMDI4LDggQEAgTDoJbGludXgt
dXNiQHZnZXIua2VybmVsLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpDQogTDoJ
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1z
dWJzY3JpYmVycykNCiBMOglsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnIChtb2Rl
cmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykNCiBTOglNYWludGFpbmVkDQorRjoJRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlaywqDQorRjoJZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ayoNCiBGOglkcml2ZXJzL3VzYi9tdHUzLw0KIA0KIE1FR0FDSElQUyBTVERQ
WFhYWC1HRS1CODUwVjMtRlcgTFZEUy9EUCsrIEJSSURHRVMNCi0tIA0KMi4xOC4wDQo=

