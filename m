Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE43D1C3828
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEDLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 07:33:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbgEDLdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:33:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 387597363C817F9ED181;
        Mon,  4 May 2020 19:33:16 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 4 May 2020
 19:33:07 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <shawnguo@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/zte: remove unneeded semicolon
Date:   Mon, 4 May 2020 19:32:30 +0800
Message-ID: <20200504113230.40588-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/gpu/drm/zte/zx_vga.c:158:2-3: Unneeded semicolon
drivers/gpu/drm/zte/zx_vga.c:171:2-3: Unneeded semicolon
drivers/gpu/drm/zte/zx_vga.c:179:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/zte/zx_vga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_vga.c b/drivers/gpu/drm/zte/zx_vga.c
index a7ed7f5ca837..0f9bbb7e3b8d 100644
--- a/drivers/gpu/drm/zte/zx_vga.c
+++ b/drivers/gpu/drm/zte/zx_vga.c
@@ -155,7 +155,7 @@ static int zx_vga_register(struct drm_device *drm, struct zx_vga *vga)
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to init encoder: %d\n", ret);
 		return ret;
-	};
+	}
 
 	drm_encoder_helper_add(encoder, &zx_vga_encoder_helper_funcs);
 
@@ -168,7 +168,7 @@ static int zx_vga_register(struct drm_device *drm, struct zx_vga *vga)
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to init connector: %d\n", ret);
 		goto clean_encoder;
-	};
+	}
 
 	drm_connector_helper_add(connector, &zx_vga_connector_helper_funcs);
 
@@ -176,7 +176,7 @@ static int zx_vga_register(struct drm_device *drm, struct zx_vga *vga)
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to attach encoder: %d\n", ret);
 		goto clean_connector;
-	};
+	}
 
 	return 0;
 
-- 
2.21.1

