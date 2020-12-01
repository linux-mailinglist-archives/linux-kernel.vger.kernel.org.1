Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897B92CA31B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbgLAMrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:47:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9082 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390334AbgLAMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:47:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ClhgM2RwyzLwyk;
        Tue,  1 Dec 2020 20:46:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 20:47:02 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH 2/3] drm/rockchip: vop: fix reference leak when pm_runtime_get_sync fails
Date:   Tue, 1 Dec 2020 20:54:58 +0800
Message-ID: <20201201125459.142178-3-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201201125459.142178-1-miaoqinglang@huawei.com>
References: <20201201125459.142178-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM reference count is not expected to be incremented on
return in functions vop_enable and vop_enable.

However, pm_runtime_get_sync will increment the PM reference
count even failed. Forgetting to putting operation will result
in a reference leak here.

Replace it with pm_runtime_resume_and_get to keep usage
counter balanced.

Fixes: 5e570373c015 ("drm/rockchip: vop: Enable pm domain before vop_initial")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c80f7d9fd..006988a6e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -587,7 +587,7 @@ static int vop_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state)
 	struct vop *vop = to_vop(crtc);
 	int ret, i;
 
-	ret = pm_runtime_get_sync(vop->dev);
+	ret = pm_runtime_resume_and_get(vop->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(vop->dev, "failed to get pm runtime: %d\n", ret);
 		return ret;
@@ -1908,7 +1908,7 @@ static int vop_initial(struct vop *vop)
 		return PTR_ERR(vop->dclk);
 	}
 
-	ret = pm_runtime_get_sync(vop->dev);
+	ret = pm_runtime_resume_and_get(vop->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(vop->dev, "failed to get pm runtime: %d\n", ret);
 		return ret;
-- 
2.23.0

