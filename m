Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F042EA3A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbhAEDH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:07:29 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60805 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726124AbhAEDH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:07:29 -0500
X-UUID: 1c003dd616d646fbb09f1ded75daf66b-20210105
X-UUID: 1c003dd616d646fbb09f1ded75daf66b-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 314839861; Tue, 05 Jan 2021 11:06:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 11:06:41 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 11:06:38 +0800
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
Subject: [PATCH v4, 00/10] soc: mediatek: mmsys: Use function call for setting the routing registers
Date:   Tue, 5 Jan 2021 11:06:23 +0800
Message-ID: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series are intended to prepare the mtk-mmsys driver to
allow different DDP (Data Display Path) function call per SoC.

base 5.11-rc1

change since v3:
- move register operation into mmsys path select function

Yongqiang Niu (10):
  soc: mediatek: mmsys: create mmsys folder
  soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
  soc: mediatek: mmsys: move register operation into mmsys path select
    function
  soc: mediatek: mmsys: Use function call for setting the routing
    registers
  soc: mediatek: mmsys: add mt8183 function call for setting the routing
    registers
  soc: mediatek: mmsys: add component OVL_2L2
  soc: mediatek: mmsys: add component POSTMASK
  soc: mediatek: mmsys: add component RDMA4
  soc: mediatek: mmsys: Use function call for setting mmsys ovl mout
    register
  soc: mediatek: mmsys: add mt8192 mmsys support

 drivers/soc/mediatek/Makefile             |   2 +-
 drivers/soc/mediatek/mmsys/Makefile       |   5 +
 drivers/soc/mediatek/mmsys/mt2701-mmsys.c | 254 ++++++++++++++++++++
 drivers/soc/mediatek/mmsys/mt8183-mmsys.c | 110 +++++++++
 drivers/soc/mediatek/mmsys/mt8192-mmsys.c | 149 ++++++++++++
 drivers/soc/mediatek/mmsys/mtk-mmsys.c    | 180 ++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c          | 373 ------------------------------
 include/linux/soc/mediatek/mtk-mmsys.h    |  25 ++
 8 files changed, 724 insertions(+), 374 deletions(-)
 create mode 100644 drivers/soc/mediatek/mmsys/Makefile
 create mode 100644 drivers/soc/mediatek/mmsys/mt2701-mmsys.c
 create mode 100644 drivers/soc/mediatek/mmsys/mt8183-mmsys.c
 create mode 100644 drivers/soc/mediatek/mmsys/mt8192-mmsys.c
 create mode 100644 drivers/soc/mediatek/mmsys/mtk-mmsys.c
 delete mode 100644 drivers/soc/mediatek/mtk-mmsys.c

-- 
1.8.1.1.dirty

