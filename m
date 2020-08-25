Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CEF2517FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgHYLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 07:44:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728993AbgHYLon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:44:43 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B84D5FB60241C63DE3E;
        Tue, 25 Aug 2020 19:44:32 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 19:44:21 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <mripard@kernel.org>, <wens@csie.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <jernej.skrabec@siol.net>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] drm/sun4i: add missing put_device() call in sun8i_r40_tcon_tv_set_mux()
Date:   Tue, 25 Aug 2020 19:44:03 +0800
Message-ID: <20200825114403.1392369-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If sun8i_r40_tcon_tv_set_mux() succeed, at_dma_xlate() doesn't have a
corresponding put_device(). Thus add put_device() to fix the exception
handling for this function implementation.

Fixes: 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index ced9a8287dd8..e40c542254f6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1433,14 +1433,18 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
 	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
 	    encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
 		ret = sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
-		if (ret)
+		if (ret) {
+			put_device(&pdev->dev);
 			return ret;
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP)) {
 		ret = sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
-		if (ret)
+		if (ret) {
+			put_device(&pdev->dev);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.25.4

