Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB228CB63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgJMKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:06:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:61247 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727894AbgJMKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:06:34 -0400
X-UUID: aed1f1d00a444cdcbfff67dac4779764-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gr35+E9wzqD1OxifIpp0yw5HOLR0PL48ny+X5AWGPOA=;
        b=odfnDU0iKJ67vy8izRz2evieWK3gDBUcvZzQ5pHhwbOdEN+rtezSJ6/mq10yYFHpfALTaLp+SeYxh2Y7Nkzqa0OfdWzaI5ZZxbSMCavtCGqlTc9O9KYHyq1DpYFOVl53nWU6sw0vV40bX9XENm7wPC4+aES1id/gnXfD311E5IU=;
X-UUID: aed1f1d00a444cdcbfff67dac4779764-20201013
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1192160898; Tue, 13 Oct 2020 18:06:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Oct
 2020 18:06:28 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 13 Oct 2020 18:06:27 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v5 0/1] fix scrolling of panel with small hfp or hbp
Date:   Tue, 13 Oct 2020 18:06:24 +0800
Message-ID: <20201013100625.13056-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C951D73D807948089F1EF863B8ABC438D1D86F1001F1BAEB1F78D927A0FBAFD92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NDoNCiAtIE1lcmdlIHJldmVydCBwYXRoIGFuZCBmaXh1cCBwYXRjaCB0
byBvbiBwYXRjaA0KDQpDaGFuZ2VzIHNpbmNlIHYzOg0KIC0gUmV2ZXJ0IHYyLCBmb3IgdjIgd2ls
bCBjYXVzZSBzb21lIGJyaWRnZSBpYyBubyBvdXRwdXQuIHRoZSBjYXVzZQ0KICAgdGhlIHZpZGVv
IGxpbmV0aW1lIGRvZXNuJ3QgbWF0Y2ggZGlzcGxheSBtb2RlIGZyb20gZ2V0IG1vZGUuDQogLSBN
YWtlIHN1cmUgdGhlIGhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlIGFuZCBob3Jpem9udGFsX2Jh
Y2twb3JjaF9ieXRlDQogICBhcmUgPiAwLg0KDQpKaXRhbyBTaGkgKDEpOg0KICBkcm0vbWVkaWF0
ZWs6IGRzaTogZml4IHNjcm9sbGluZyBvZiBwYW5lbCB3aXRoIHNtYWxsIGhmcCBvciBoYnANCg0K
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCA2NSArKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
LCA0MCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjEyLjUNCg==

