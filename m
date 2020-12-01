Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3512CA328
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391009AbgLAMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:49:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8483 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390896AbgLAMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:49:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ClhjP0vyDzhdBJ;
        Tue,  1 Dec 2020 20:48:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 20:48:34 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] drm/v3d: fix reference leak when pm_runtime_get_sync fails
Date:   Tue, 1 Dec 2020 20:56:32 +0800
Message-ID: <20201201125632.142636-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM reference count is not expected to be incremented on
return in functions v3d_get_param_ioctl and v3d_job_init.

However, pm_runtime_get_sync will increment the PM reference
count even failed. Forgetting to putting operation will result
in a reference leak here.

Replace it with pm_runtime_resume_and_get to keep usage
counter balanced.

Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Fixes: 935f3d88434b ("drm/v3d: Make sure the GPU is on when measuring clocks.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 4 ++--
 drivers/gpu/drm/v3d/v3d_gem.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index e76b24bb8..91ceed774 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -132,7 +132,7 @@ static int v3d_v3d_debugfs_ident(struct seq_file *m, void *unused)
 	u32 ident0, ident1, ident2, ident3, cores;
 	int ret, core;
 
-	ret = pm_runtime_get_sync(v3d->drm.dev);
+	ret = pm_runtime_resume_and_get(v3d->drm.dev);
 	if (ret < 0)
 		return ret;
 
@@ -219,7 +219,7 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	int measure_ms = 1000;
 	int ret;
 
-	ret = pm_runtime_get_sync(v3d->drm.dev);
+	ret = pm_runtime_resume_and_get(v3d->drm.dev);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 182c58652..765683569 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -439,7 +439,7 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
 	job->v3d = v3d;
 	job->free = free;
 
-	ret = pm_runtime_get_sync(v3d->drm.dev);
+	ret = pm_runtime_resume_and_get(v3d->drm.dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.23.0

