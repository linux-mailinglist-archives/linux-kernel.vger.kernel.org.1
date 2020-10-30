Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E102A0937
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgJ3PHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:07:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgJ3PHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:07:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E96B6139F;
        Fri, 30 Oct 2020 07:58:56 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E63B3F68F;
        Fri, 30 Oct 2020 07:58:55 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH] drm/panfrost: Fix module unload
Date:   Fri, 30 Oct 2020 14:58:33 +0000
Message-Id: <20201030145833.29006-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unloading the call to pm_runtime_put_sync_suspend() will attempt to
turn the GPU cores off, however panfrost_device_fini() will have turned
the clocks off. This leads to the hardware locking up.

Instead don't call pm_runtime_put_sync_suspend() and instead simply mark
the device as suspended using pm_runtime_set_suspended(). And also
include this on the error path in panfrost_probe().

Fixes: aebe8c22a912 ("drm/panfrost: Fix possible suspend in panfrost_remove")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 23513869500c..0ac8ad18fdc6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -627,6 +627,7 @@ static int panfrost_probe(struct platform_device *pdev)
 err_out1:
 	pm_runtime_disable(pfdev->dev);
 	panfrost_device_fini(pfdev);
+	pm_runtime_set_suspended(pfdev->dev);
 err_out0:
 	drm_dev_put(ddev);
 	return err;
@@ -641,9 +642,9 @@ static int panfrost_remove(struct platform_device *pdev)
 	panfrost_gem_shrinker_cleanup(ddev);
 
 	pm_runtime_get_sync(pfdev->dev);
-	panfrost_device_fini(pfdev);
-	pm_runtime_put_sync_suspend(pfdev->dev);
 	pm_runtime_disable(pfdev->dev);
+	panfrost_device_fini(pfdev);
+	pm_runtime_set_suspended(pfdev->dev);
 
 	drm_dev_put(ddev);
 	return 0;
-- 
2.20.1

