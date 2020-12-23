Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446012E1A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgLWIfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:35:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48008 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727821AbgLWIfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:35:48 -0500
X-UUID: 621b4621e92945b7bb398e6614d3b80c-20201223
X-UUID: 621b4621e92945b7bb398e6614d3b80c-20201223
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 448551965; Wed, 23 Dec 2020 16:35:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 16:35:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 16:35:01 +0800
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
Subject: soc: mediatek: cmdq: add address shift in jump
Date:   Wed, 23 Dec 2020 16:34:58 +0800
Message-ID: <1608712499-24956-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v1:
-move out from mt8192 seri series

Yongqiang Niu (1):
  soc: mediatek: cmdq: add address shift in jump

 drivers/mailbox/mtk-cmdq-mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.1.1.dirty

