Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE471D76C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgERLXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgERLXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:23:17 -0400
Received: from ziggy.de (unknown [213.195.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34C7206D4;
        Mon, 18 May 2020 11:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589800997;
        bh=UX5hVzE4RlHU3iDBRST21Nt0Qg+SmpVsaSQorMHrC0s=;
        h=From:To:Cc:Subject:Date:From;
        b=l3a2r826A4ELNWXZVsYarsVjGOrBdK2avwXVLH5up1ebMFSSDndfmDI6oGGUjXct5
         DoGsL3Smh437oCwNPBt09u56feV9t6UK/Nx+r+MlMDnPPZG6r9C/eSupiHhLyZnctK
         RirMJT1/iWD+liNMDCkscrRG5h6d6zE+FK+UMZHs=
From:   matthias.bgg@kernel.org
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     matthias.bgg@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] drm/mediatek: Delete not used of_device_get_match_data
Date:   Mon, 18 May 2020 13:22:54 +0200
Message-Id: <20200518112254.23692-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The driver will be loaded by via a platform device. So we
will need to get the device_node from the parent device.
Depending on this we will set the driver data.
As all this is done later already, just delete the call to
of_device_get_match_data.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index e2bb0d19ef99..63ec92ba0e92 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -447,7 +447,6 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	if (!private)
 		return -ENOMEM;
 
-	private->data = of_device_get_match_data(dev);
 	private->mmsys_dev = dev->parent;
 	if (!private->mmsys_dev) {
 		dev_err(dev, "Failed to get MMSYS device\n");
-- 
2.26.2

