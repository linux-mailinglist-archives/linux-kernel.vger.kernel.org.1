Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A12242640
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHLHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 03:45:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbgHLHpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:45:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 003E762D34138F462E6A;
        Wed, 12 Aug 2020 15:45:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 12 Aug 2020 15:45:01 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v3 1/2] drm/hisilicon: Remove the unused include statements
Date:   Wed, 12 Aug 2020 15:42:58 +0800
Message-ID: <1597218179-3938-2-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597218179-3938-1-git-send-email-tiantao6@hisilicon.com>
References: <1597218179-3938-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused include statements.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 3 ---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 5 -----
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 2 --
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index cc70e83..66132eb 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -17,9 +17,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_vram_helper.h>
-#include <drm/drm_plane_helper.h>
-#include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "hibmc_drm_drv.h"
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index b8d839a..54f6144 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -11,18 +11,13 @@
  *	Jianhua Li <lijianhua@huawei.com>
  */
 
-#include <linux/console.h>
-#include <linux/module.h>
 #include <linux/pci.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_irq.h>
 #include <drm/drm_managed.h>
-#include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "hibmc_drm_drv.h"
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 2ca69c3..ed12f61 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -11,10 +11,8 @@
  *	Jianhua Li <lijianhua@huawei.com>
  */
 
-#include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_print.h>
 
 #include "hibmc_drm_drv.h"
-- 
2.7.4

