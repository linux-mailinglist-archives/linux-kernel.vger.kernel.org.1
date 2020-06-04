Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04AE1EDF63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgFDINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgFDIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:12:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61840C08C5C4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:12:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so5051992wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSDqH5ij1BPhN02yjRk7X7Ch94EKjTTeY1hANr+YPIg=;
        b=MQtZQlsVT4D6M/TZ/TTIidOW50d1o6Q0AiFZHAR30zUPft45srmFqn7Q/chHCQgEwb
         QuUQyDP7PvsPZgFWkvGTZI4QJxfIwFPjWqa5WQ26vsMQBqacHIfA9jXi1YXDD4rvkBs/
         wmbeqc0eo5WnTY22+0zRQvessA2Qhc3AShHpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSDqH5ij1BPhN02yjRk7X7Ch94EKjTTeY1hANr+YPIg=;
        b=sJTAcyjMIsY8eHuB9bH8u6H9Fd3rz1G6bkPZEAU0FTuQQSZ/GRoKjlUYTxqHC2NDup
         X0tN8bSUSdKCnCdTsFroAVOM/oMfCEp4ymYYAO7xPGUZlEuwlXZATs9Oz2Gqj9kfw8eS
         F9BEhBH4FCE32Is+2/OkEnYXTllI5vCerWAXeai8ZV96tnXd4eWJStDYzQfwRfmmhAOE
         byr/fyIn2U0nrmMk0yTH+HbW4f0acRj23AqU8lhiOGXvBf/UbORIDgY72W+Vs/9nZ7s5
         WCHSUFtILD6zPF2rSSCqtZqMBNCwRZlVE3IXw/Tyiuxkhb1mI4BkgkkJvxczji0NsdKh
         SCeQ==
X-Gm-Message-State: AOAM5304j94a9ue4FyuWhlDn/T4R0x7F59CxfOlGJNRcbxvJSMU1NqAU
        /nNOvQffi5KNQlzKLwwH5ihIFA==
X-Google-Smtp-Source: ABdhPJwTJtq4ZMbXkz9yUomRGTcjfw0qYxpotGG6g0Tb3unDYU1epqhHkACAq8ejGSpX2fZsvYsoJQ==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr3471787wrx.55.1591258370059;
        Thu, 04 Jun 2020 01:12:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:49 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 14/18] drm/scheduler: use dma-fence annotations in tdr work
Date:   Thu,  4 Jun 2020 10:12:20 +0200
Message-Id: <20200604081224.863494-15-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the face of unpriviledged userspace being able to submit bogus gpu
workloads the kernel needs gpu timeout and reset (tdr) to guarantee
that dma_fences actually complete. Annotate this worker to make sure
we don't have any accidental locking inversions or other problems
lurking.

Originally this was part of the overall scheduler annotation patch.
But amdgpu has some glorious inversions here:

- grabs console_lock
- does a full modeset, which grabs all kinds of locks
  (drm_modeset_lock, dma_resv_lock) which can deadlock with
  dma_fence_wait held inside them.
- almost minor at that point, but the modeset code also allocates
  memory

These all look like they'll be very hard to fix properly, the hardware
seems to require a full display reset with any gpu recovery.

Hence split out as a seperate patch.

Since amdgpu isn't the only hardware driver that needs to reset the
display (at least gen2/3 on intel have the same problem) we need a
generic solution for this. There's two tricks we could still from
drm/i915 and lift to dma-fence:

- The big whack, aka force-complete all fences. i915 does this for all
  pending jobs if the reset is somehow stuck. Trouble is we'd need to
  do this for all fences in the entire system, and just the
  book-keeping for that will be fun. Plus lots of drivers use fences
  for all kinds of internal stuff like memory management, so
  unconditionally resetting all of them doesn't work.

  I'm also hoping that with these fence annotations we could enlist
  lockdep in finding the last offenders causing deadlocks, and we
  could remove this get-out-of-jail trick.

- The more feasible approach (across drivers at least as part of the
  dma_fence contract) is what drm/i915 does for gen2/3: When we need
  to reset the display we wake up all dma_fence_wait_interruptible
  calls, or well at least the equivalent of those in i915 internally.

  Relying on ioctl restart we force all other threads to release their
  locks, which means the tdr thread is guaranteed to be able to get
  them. I think we could implement this at the dma_fence level,
  including proper lockdep annotations.

  dma_fence_begin_tdr():
  - must be nested within a dma_fence_begin/end_signalling section
  - will wake up all interruptible (but not the non-interruptible)
    dma_fence_wait() calls and force them to complete with a
    -ERESTARTSYS errno code. All new interrupitble calls to
    dma_fence_wait() will immeidately fail with the same error code.

  dma_fence_end_trdr():
  - this will convert dma_fence_wait() calls back to normal.

  Of course interrupting dma_fence_wait is only ok if the caller
  specified that, which means we need to split the annotations into
  interruptible and non-interruptible version. If we then make sure
  that we only use interruptible dma_fence_wait() calls while holding
  drm_modeset_lock we can grab them in tdr code, and allow display
  resets. Doing the same for dma_resv_lock might be a lot harder, so
  buffer updates must be avoided.

  What's worse, we're not going to be able to make the dma_fence_wait
  calls in mmu-notifiers interruptible, that doesn't work. So
  allocating memory still wont' be allowed, even in tdr sections. Plus
  obviously we can use this trick only in tdr, it is rather intrusive.

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
 drivers/gpu/drm/scheduler/sched_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 06a736e506ad..e34a44376e87 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -279,9 +279,12 @@ static void drm_sched_job_timedout(struct work_struct *work)
 {
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_job *job;
+	bool fence_cookie;
 
 	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	/* Protects against concurrent deletion in drm_sched_get_cleanup_job */
 	spin_lock(&sched->job_list_lock);
 	job = list_first_entry_or_null(&sched->ring_mirror_list,
@@ -313,6 +316,8 @@ static void drm_sched_job_timedout(struct work_struct *work)
 	spin_lock(&sched->job_list_lock);
 	drm_sched_start_timeout(sched);
 	spin_unlock(&sched->job_list_lock);
+
+	dma_fence_end_signalling(fence_cookie);
 }
 
  /**
-- 
2.26.2

