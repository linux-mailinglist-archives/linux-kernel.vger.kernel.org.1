Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC8289ED7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgJJHJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:09:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61423 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728722AbgJJHJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:09:28 -0400
X-UUID: 0c38d61dbfca452281c952de6b586ca2-20201010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ANpEljZrqglc8EMQg/MmRI2i6NTOfGYjN7epVx7bN3M=;
        b=mLc7pWV+4oru6y5/2DxA/aG8uOKd/fTYXdSIvvFC0a1mP9g71/Y2wkjqgOM8X2uF2j7YqrAxiq80iQBxp2TvH7Uj0UUh1BavjvkE2QDOOY7ycL5UTC686VWeY8KobFvyqfDur7wTiWdW6PVQIgenWR3O4Rm1U9PUoyc1FsfZw9I=;
X-UUID: 0c38d61dbfca452281c952de6b586ca2-20201010
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 122230117; Sat, 10 Oct 2020 15:09:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 10 Oct
 2020 15:09:18 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 10 Oct 2020 15:09:17 +0800
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
Subject: [v4 PATCH 0/2] fix scrolling of panel with small hfp or hbp
Date:   Sat, 10 Oct 2020 15:09:08 +0800
Message-ID: <20201010070910.11294-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E976FB5C5D4C68B5ED5FF64A5487CFDC6271ABC0676969679FADBA60D22808B22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MzoNCiAtIFJldmVydCB2MiwgZm9yIHYyIHdpbGwgY2F1c2Ugc29tZSBi
cmlkZ2UgaWMgbm8gb3V0cHV0LiB0aGUgY2F1c2UNCiAgIHRoZSB2aWRlbyBsaW5ldGltZSBkb2Vz
bid0IG1hdGNoIGRpc3BsYXkgbW9kZSBmcm9tIGdldCBtb2RlLg0KIC0gTWFrZSBzdXJlIHRoZSBo
b3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSBhbmQgaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZQ0K
ICAgYXJlID4gMC4NCg0KSml0YW8gU2hpICgyKToNCiAgUmV2ZXJ0ICJkcm0vbWVkaWF0ZWs6IGRz
aTogRml4IHNjcm9sbGluZyBvZiBwYW5lbCB3aXRoIHNtYWxsIGhmcCBvcg0KICAgIGhicCINCiAg
ZHJtL21lZGlhdGVrOiBkc2k6IGZpeCBzY3JvbGxpbmcgb2YgcGFuZWwgd2l0aCBzbWFsbCBoZnAg
b3IgaGJwDQoNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgNjUgKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5z
ZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xMi41DQo=

