Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807BC2C7CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 03:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgK3CE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 21:04:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8883 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgK3CE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 21:04:57 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CkpS63TmDz75sm;
        Mon, 30 Nov 2020 10:03:50 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 10:04:08 +0800
From:   Jialin Zhang <zhangjialin11@huawei.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alan Cox <alan@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>
Subject: [PATCH] drm/gma500: Fix error return code in psb_driver_load()
Date:   Mon, 30 Nov 2020 10:02:16 +0800
Message-ID: <20201130020216.1906141-1-zhangjialin11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 5c49fd3aa0ab ("gma500: Add the core DRM files and headers")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 34b4aae9a15e..074f403d7ca0 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -313,6 +313,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto out_err;
 
+	ret = -ENOMEM;
+
 	dev_priv->mmu = psb_mmu_driver_init(dev, 1, 0, 0);
 	if (!dev_priv->mmu)
 		goto out_err;
-- 
2.25.1

