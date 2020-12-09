Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA82D3EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgLIJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:33:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35099 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729348AbgLIJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:33:50 -0500
X-UUID: 4e3b990a58da426da76354978a0be1ae-20201209
X-UUID: 4e3b990a58da426da76354978a0be1ae-20201209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1973133973; Wed, 09 Dec 2020 17:33:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 17:33:02 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 17:33:02 +0800
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
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2, 0/2] soc: mediatek: Prepare MMSYS for DDP routing using function call
Date:   Wed, 9 Dec 2020 17:32:57 +0800
Message-ID: <1607506379-10998-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series are intended to prepare the mtk-mmsys driver to
allow different DDP (Data Display Path) function call per SoC.

base change:
https://patchwork.kernel.org/project/linux-mediatek/patch/20201006193320.405529-4-enric.balletbo@collabora.com/


Yongqiang Niu (2):
  soc: mediatek: mmsys: create mmsys folder
  soc: mediatek: mmsys: Use function call for setting the routing
    registers

 drivers/soc/mediatek/Makefile             |   2 +-
 drivers/soc/mediatek/mmsys/Makefile       |   3 +
 drivers/soc/mediatek/mmsys/mt2701-mmsys.c | 233 ++++++++++++++++++
 drivers/soc/mediatek/mmsys/mtk-mmsys.c    | 177 ++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c          | 380 ------------------------------
 include/linux/soc/mediatek/mtk-mmsys.h    |  14 ++
 6 files changed, 428 insertions(+), 381 deletions(-)
 create mode 100644 drivers/soc/mediatek/mmsys/Makefile
 create mode 100644 drivers/soc/mediatek/mmsys/mt2701-mmsys.c
 create mode 100644 drivers/soc/mediatek/mmsys/mtk-mmsys.c
 delete mode 100644 drivers/soc/mediatek/mtk-mmsys.c

-- 
1.8.1.1.dirty

