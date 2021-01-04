Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB72EA092
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbhADXPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:15:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbhADXPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609802058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qcr+V+ZzWmuyUiEv86hTgVkm+OX5/DeK7Xm8ydOFOHo=;
        b=NuLHGLs73PBlAB4oBaiA++PRrWdPEFykA5BWa3QCOKt8Lx3uBfMAAuUoLiMEOlS5aJoajU
        e5IG+nOj6DQZY3+lsjytNjSUGRcaUtnYeOl6LaBubadWVsFJFfo6YrXLQQ7YJrOlDOiKt8
        JORUkRgVSZKiDsy3v7B6cYUwNnEWhXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-kQ7xorzTMUOHBYFG6q1E_Q-1; Mon, 04 Jan 2021 18:14:15 -0500
X-MC-Unique: kQ7xorzTMUOHBYFG6q1E_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E644F59;
        Mon,  4 Jan 2021 23:14:13 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A4825C8AA;
        Mon,  4 Jan 2021 23:14:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/ttm: Remove pinned bos from LRU in ttm_bo_move_to_lru_tail()
Date:   Mon,  4 Jan 2021 18:13:58 -0500
Message-Id: <20210104231358.154521-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a regression was introduced which caused TTM's buffer eviction to
attempt to evict already-pinned BOs, causing issues with buffer eviction
under memory pressure along with suspend/resume:

  nouveau 0000:1f:00.0: DRM: evicting buffers...
  nouveau 0000:1f:00.0: DRM: Moving pinned object 00000000c428c3ff!
  nouveau 0000:1f:00.0: fifo: fault 00 [READ] at 0000000000200000 engine 04
  [BAR1] client 07 [HUB/HOST_CPU] reason 02 [PTE] on channel -1 [00ffeaa000
  unknown]
  nouveau 0000:1f:00.0: fifo: DROPPED_MMU_FAULT 00001000
  nouveau 0000:1f:00.0: fifo: fault 01 [WRITE] at 0000000000020000 engine
  0c [HOST6] client 07 [HUB/HOST_CPU] reason 02 [PTE] on channel 1
  [00ffb28000 DRM]
  nouveau 0000:1f:00.0: fifo: channel 1: killed
  nouveau 0000:1f:00.0: fifo: runlist 0: scheduled for recovery
  [TTM] Buffer eviction failed
  nouveau 0000:1f:00.0: DRM: waiting for kernel channels to go idle...
  nouveau 0000:1f:00.0: DRM: failed to idle channel 1 [DRM]
  nouveau 0000:1f:00.0: DRM: resuming display...

After some bisection and investigation, it appears this resulted from the
recent changes to ttm_bo_move_to_lru_tail(). Previously when a buffer was
pinned, the buffer would be removed from the LRU once ttm_bo_unreserve
to maintain the LRU list when pinning or unpinning BOs. However, since:

commit 3d1a88e1051f ("drm/ttm: cleanup LRU handling further")

We've been exiting from ttm_bo_move_to_lru_tail() at the very beginning of
the function if the bo we're looking at is pinned, resulting in the pinned
BO never getting removed from the lru and as a result - causing issues when
it eventually becomes time for eviction.

So, let's fix this by calling ttm_bo_del_from_lru() from
ttm_bo_move_to_lru_tail() in the event that we're dealing with a pinned
buffer. As well, add back the hunks in ttm_bo_del_from_lru() that were
removed which checked whether we want to call
bdev->driver->del_from_lru_notify() or not. We do this last part to avoid
calling the hook when the bo in question was already removed from the LRU.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 3d1a88e1051f ("drm/ttm: cleanup LRU handling further")
Cc: Christian König <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 31e8b3da5563..0f373b78e7fa 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -113,11 +113,18 @@ static struct kobj_type ttm_bo_glob_kobj_type  = {
 static void ttm_bo_del_from_lru(struct ttm_buffer_object *bo)
 {
 	struct ttm_bo_device *bdev = bo->bdev;
+	bool notify = false;
 
-	list_del_init(&bo->swap);
-	list_del_init(&bo->lru);
+	if (!list_empty(&bo->swap)) {
+		notify = true;
+		list_del_init(&bo->swap);
+	}
+	if (!list_empty(&bo->lru)) {
+		notify = true;
+		list_del_init(&bo->lru);
+	}
 
-	if (bdev->driver->del_from_lru_notify)
+	if (notify && bdev->driver->del_from_lru_notify)
 		bdev->driver->del_from_lru_notify(bo);
 }
 
@@ -138,8 +145,13 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
 
 	dma_resv_assert_held(bo->base.resv);
 
-	if (bo->pin_count)
+	/* Pinned bos will have been added to the LRU before they were pinned, so make sure we
+	 * always remove them here
+	 */
+	if (bo->pin_count) {
+		ttm_bo_del_from_lru(bo);
 		return;
+	}
 
 	man = ttm_manager_type(bdev, mem->mem_type);
 	list_move_tail(&bo->lru, &man->lru[bo->priority]);
-- 
2.29.2

