Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8551CF08A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgELJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729418AbgELJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:00:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670AC05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:00:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so14354254wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/9uzJ3fevUELKKtrW0wppzXu6P75uy22NGdQSlmDz8=;
        b=SDwGwQpJaRBMJHLwj1aebHZrNlfPB3lM8R5Nxnw2iursO6/Tq0w7BeIxMzSmD391GY
         iPFvU8Hqv0qaq3/SShkh7frLZZM3Zpz71K/gsOA/w0EdvszMgINIghxumAUMRmpCHVZ6
         PNjddJYrJBWaP/HRgZfmAEs0NKLQNEFW8NDqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/9uzJ3fevUELKKtrW0wppzXu6P75uy22NGdQSlmDz8=;
        b=p1X/k5SPhBDPNXormhuE9w3wjbxMgjN2rCAYGHxRN+zuXOd9/di/QVmw/8gq2UsN7J
         JY50Dns2x0odceob2FZIy9IAsn2MQXf6pm96KeVdiKJj/HLtqPD/8rO1x1AJwvHaJHZK
         Ks4D08gDMC/JFsTHyQ6pcO7FMpcJ5eOoyKPF6444S7pdZhdxVX3ZHlX7ar5aLAzS/7X8
         6gjUhYB/r5WdKjzwZ0aj4Ff5WNKHEo0sNdwVUNPbUz0ZvrtssHTzeeYak607r6+bW1LX
         N4mAY+pVgLGl6fmw36uiUZm5mhRwZ2bMn9sBWFDeTkeh27mX0u6/fYyTJlmCn1btUmvo
         Jg/g==
X-Gm-Message-State: AGi0PuZBwiR0S2NP8WFqI3D+oUTh0+kkZmCB1oB52rtXaotvXxCF0nxm
        Fi233yt4PSueqgdIKcjpcpaB7Q==
X-Google-Smtp-Source: APiQypJNdraV8h80zz8iXZE8tE3/9vYAqexMkf4hJDDcWF5MN2cVkPdcNZnVM3rSm/bq3B4xJ2e1wQ==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr17490653wru.231.1589274006358;
        Tue, 12 May 2020 02:00:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:05 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC 09/17] drm/amdgpu: use dma-fence annotations in cs_submit()
Date:   Tue, 12 May 2020 10:59:36 +0200
Message-Id: <20200512085944.222637-10-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit tricky, since ->notifier_lock is held while calling
dma_fence_wait we must ensure that also the read side (i.e.
dma_fence_begin_signalling) is on the same side. If we mix this up
lockdep complaints, and that's again why we want to have these
annotations.

A nice side effect of this is that because of the fs_reclaim priming
for dma_fence_enable lockdep now automatically checks for us that
nothing in here allocates memory, without even running any userptr
workloads.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 7653f62b1b2d..6db3f3c629b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1213,6 +1213,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_job *job;
 	uint64_t seq;
 	int r;
+	bool fence_cookie;
 
 	job = p->job;
 	p->job = NULL;
@@ -1227,6 +1228,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	 */
 	mutex_lock(&p->adev->notifier_lock);
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
 	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
 	 */
@@ -1264,12 +1267,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 	return 0;
 
 error_abort:
 	drm_sched_job_cleanup(&job->base);
+	dma_fence_end_signalling(fence_cookie);
 	mutex_unlock(&p->adev->notifier_lock);
 
 error_unlock:
-- 
2.26.2

