Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6D29F277
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgJ2RBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:01:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgJ2RBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:01:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97634139F;
        Thu, 29 Oct 2020 10:01:08 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 499E63F66E;
        Thu, 29 Oct 2020 10:01:07 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH] drm/panfrost: Don't corrupt the queue mutex on open/close
Date:   Thu, 29 Oct 2020 17:00:47 +0000
Message-Id: <20201029170047.30564-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex within the panfrost_queue_state should have the lifetime of
the queue, however it was erroneously initialised/destroyed during
panfrost_job_{open,close} which is called every time a client
opens/closes the drm node.

Move the initialisation/destruction to panfrost_job_{init,fini} where it
belongs.

Fixes: 1a11a88cfd9a ("drm/panfrost: Fix job timeout handling")
Signed-off-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index cfb431624eea..145ad37eda6a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -595,6 +595,8 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 	}
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
+		mutex_init(&js->queue[j].lock);
+
 		js->queue[j].fence_context = dma_fence_context_alloc(1);
 
 		ret = drm_sched_init(&js->queue[j].sched,
@@ -625,8 +627,10 @@ void panfrost_job_fini(struct panfrost_device *pfdev)
 
 	job_write(pfdev, JOB_INT_MASK, 0);
 
-	for (j = 0; j < NUM_JOB_SLOTS; j++)
+	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		drm_sched_fini(&js->queue[j].sched);
+		mutex_destroy(&js->queue[j].lock);
+	}
 
 }
 
@@ -638,7 +642,6 @@ int panfrost_job_open(struct panfrost_file_priv *panfrost_priv)
 	int ret, i;
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
-		mutex_init(&js->queue[i].lock);
 		sched = &js->queue[i].sched;
 		ret = drm_sched_entity_init(&panfrost_priv->sched_entity[i],
 					    DRM_SCHED_PRIORITY_NORMAL, &sched,
@@ -657,7 +660,6 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		drm_sched_entity_destroy(&panfrost_priv->sched_entity[i]);
-		mutex_destroy(&js->queue[i].lock);
 		/* Ensure any timeouts relating to this client have completed */
 		flush_delayed_work(&js->queue[i].sched.work_tdr);
 	}
-- 
2.20.1

