Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD62E2311
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 01:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLXAs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 19:48:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55040 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727815AbgLXAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 19:48:58 -0500
X-UUID: 3a661a0f1a0448e29b1c794abd721b94-20201224
X-UUID: 3a661a0f1a0448e29b1c794abd721b94-20201224
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1341837866; Thu, 24 Dec 2020 08:48:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Dec 2020 08:48:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 08:48:07 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2, 0/3] support gce on mt8192 platform
Date:   Thu, 24 Dec 2020 08:48:06 +0800
Message-ID: <1608770889-9403-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v1:
- move out shit jump patch
- rmove usless patch

Yongqiang Niu (3):
  dt-binding: gce: add gce header file for mt8192
  arm64: dts: mt8192: add gce node
  mailbox: cmdq: add mt8192 support

 .../devicetree/bindings/mailbox/mtk-gce.txt        |   7 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  10 +
 drivers/mailbox/mtk-cmdq-mailbox.c                 |   1 +
 include/dt-bindings/gce/mt8192-gce.h               | 419 +++++++++++++++++++++
 4 files changed, 434 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8192-gce.h

-- 
1.8.1.1.dirty

