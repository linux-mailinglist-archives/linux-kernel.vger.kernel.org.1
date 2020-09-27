Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBC27A46C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 01:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgI0XEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 19:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgI0XEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 19:04:32 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E892389F;
        Sun, 27 Sep 2020 23:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601247872;
        bh=aAPIXd4HbZWLcB/t5MLwJx0aHlftXlSoI/b18x4wXmY=;
        h=From:To:Cc:Subject:Date:From;
        b=ndZDYTW7uwm+b5VEZJM+eawxXa4y5QYAYo4wGjmjvSnnJmqtt2cl3WVPszlTiTB01
         NTrH6x8vf3Lcts9M42wh6RqIjYrNgi/Y2F9/8V4nbWFgiYClREbcgIZ2JjJjsoDgCS
         nvgwTirbKm/ILr+rIUIWMgIzCC0uTuQdbW+pNzuU=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 0/4] Mediatek DRM driver detect CMDQ execution timeout by vblank IRQ
Date:   Mon, 28 Sep 2020 07:04:18 +0800
Message-Id: <20200927230422.11610-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMDQ helper provide timer to detect execution timeout, but DRM driver
could have a better way to detect execution timeout by vblank IRQ.
For DRM, CMDQ command should execute in vblank, so if it fail to
execute in next 2 vblank, timeout happen. Even though we could
calculate time between 2 vblank and use timer to delect, this would
make things more complicated.

This introduce a series refinement for CMDQ mailbox controller and CMDQ
helper. Remove timer handler in helper function because different
client have different way to detect timeout. Use standard mailbox
callback instead of proprietary one to get the necessary data
in callback function. Remove struct cmdq_client to access client
instance data by struct mbox_client.

Chun-Kuang Hu (4):
  soc / drm: mediatek: cmdq: Remove timeout handler in helper function
  mailbox / soc / drm: mediatek: Use mailbox rx_callback instead of
    cmdq_task_cb
  mailbox / soc / drm: mediatek: Remove struct cmdq_client
  drm/mediatek: Detect CMDQ execution timeout

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |  54 ++++++---
 drivers/mailbox/mtk-cmdq-mailbox.c       |  24 ++--
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 146 ++---------------------
 include/linux/mailbox/mtk-cmdq-mailbox.h |  25 +---
 include/linux/soc/mediatek/mtk-cmdq.h    |  54 +--------
 5 files changed, 66 insertions(+), 237 deletions(-)

-- 
2.17.1

