Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60591228DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 03:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgGVBtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 21:49:50 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:38539 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgGVBtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:49:49 -0400
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 751ED4823E7;
        Wed, 22 Jul 2020 09:49:47 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/panel: remove meaningless if(ret) check code.
Date:   Wed, 22 Jul 2020 09:49:39 +0800
Message-Id: <20200722014939.4047-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQk8dQklDTBhKTk8dVkpOQk5IQ0lOQ0xNTUtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxA6TCo5OT8tFxUWUTw0OU9D
        AQlPCwNVSlVKTkJOSENJTkNDS01IVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSkJDSzcG
X-HM-Tid: 0a73743660da93bakuws751ed4823e7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function drm_panel_add always returns true.
So if(ret) check code will never run into error branch.
Remove these check will make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index 95b789ab9d29..2c168a405928 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -225,9 +225,7 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	ret = drm_panel_add(&ctx->panel);
-	if (ret < 0)
-		return ret;
+	drm_panel_add(&ctx->panel);
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-- 
2.17.1

