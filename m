Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ECC2AE934
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgKKGqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:46:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7170 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgKKGqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:46:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWFc33z4Lz15T63;
        Wed, 11 Nov 2020 14:45:39 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 14:45:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <sam@ravnborg.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH] drm/panel: add missing platform_driver_unregister() on error path
Date:   Wed, 11 Nov 2020 14:44:25 +0800
Message-ID: <20201111064425.3395558-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mipi_dsi_driver_register() failed, platform_driver_unregister()
need be called.

Fixes: 210fcd9d9cf1 ("drm/panel: Add support for Panasonic VVX10F004B0")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2be358fb46f7..2966ac13c538 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4644,8 +4644,10 @@ static int __init panel_simple_init(void)
 
 	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI)) {
 		err = mipi_dsi_driver_register(&panel_simple_dsi_driver);
-		if (err < 0)
+		if (err < 0) {
+			platform_driver_unregister(&panel_simple_platform_driver);
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.25.1

