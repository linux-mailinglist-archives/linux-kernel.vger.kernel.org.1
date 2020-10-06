Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D5A28527E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgJFTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:33:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38180 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgJFTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:33:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6FABC28A7A9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        yongqiang.niu@mediatek.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        chunkuang.hu@kernel.org, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/4] soc: mediatek: Prepare MMSYS for DDP routing using tables
Date:   Tue,  6 Oct 2020 21:33:16 +0200
Message-Id: <20201006193320.405529-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

The following series are intended to prepare the mtk-mmsys driver to
allow different DDP (Data Display Path) routing tables per SoC. Note
that the series has been tested only on MT8173 platform and could break
the display on MT2701 and MT2712 based devices. I kindly ask for someone
having these devices to provide a tested routing table (unfortunately I
didn't have enough documentation to figure out this myself).

For the other devices (MT8183, MT6779 and MT6797) DRM support is not in
mainline yet so nothing will break.

Thanks,
  Enric


CK Hu (2):
  soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
  soc: mediatek: mmsys: Use an array for setting the routing registers

Enric Balletbo i Serra (1):
  soc: mediatek: mmsys: Use devm_platform_ioremap_resource()

Yongqiang Niu (1):
  soc / drm: mediatek: Move DDP component defines into mtk-mmsys.h

 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  34 +-
 drivers/soc/mediatek/mtk-mmsys.c            | 429 +++++++++++---------
 include/linux/soc/mediatek/mtk-mmsys.h      |  33 ++
 3 files changed, 263 insertions(+), 233 deletions(-)

-- 
2.28.0

