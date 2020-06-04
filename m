Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D671EDF84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgFDINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgFDIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:12:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3FEC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:12:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r9so4295567wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RU/4ty0eEugeyrPrVEiQiwkrKqeJ+uZPrr4qGpCy8Ns=;
        b=WQ76x/1RuTy1JkP9aezKfVnljVf6mBF2k34u6CEzkCHMD5rjzO23Ol0qswF1Uqnn3r
         NZfMgpfPaWZjBnzc3b4R0o6daICNWxE3wsC5YBUn7XLwXhFfZLN5ZIKJ1vC7UEvOJvnQ
         jpY5agvtrUOJPNYvXTokA+XG56fPkvmyjcTDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RU/4ty0eEugeyrPrVEiQiwkrKqeJ+uZPrr4qGpCy8Ns=;
        b=YVQQxiDcoznnoZ4IwCGhPsPIAmfWxraMqr7SBQWrUVNZMHCO+4m1HXLoCnz4ZGdnsZ
         bmaIkCY7WntaWHgmcEodUVHXv46T51tPvmYjmlb7hJyyn77iGyuUyM5fYW8NwUxZ14BP
         Zv9vEEoKDCHIhzDWsZQEtF4p0iXNNM+lRKF6Qvm2O5rAWMTC/u51EYiYHGf76YWLoQQM
         D8Ph1qkp+w+sQFx8JG/jXHUxev8mRLUmDu4XAWQHcbJoB0cXFVjeMP6Us3on20llBSJ6
         zF9oFytfuTIj+8Dem28fWW2UaCrmjn4QlWiUmZ+X1OdKioRAgJ8Jy8Kuty0jxLdrrktP
         hyNw==
X-Gm-Message-State: AOAM533rIMOuOfB6RV0eh8H83Ls9+BrqcN0aTwoJauOSy+m/CXKxgGVJ
        MhVwBUUmFTDznkjpb8jc47HfJmYuE98=
X-Google-Smtp-Source: ABdhPJzyEEdLMFWp1SPIqCkQHe7o3lL3hDIhqzkna+QlwTAI0JRQsL2kauEYBN5PgJQKziIXdiNizg==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr3030923wma.118.1591258362288;
        Thu, 04 Jun 2020 01:12:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:41 -0700 (PDT)
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
Subject: [PATCH 08/18] drm/amdgpu: add dma-fence annotations to atomic commit path
Date:   Thu,  4 Jun 2020 10:12:14 +0200
Message-Id: <20200604081224.863494-9-daniel.vetter@ffwll.ch>
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

I need a canary in a ttm-based atomic driver to make sure the
dma_fence_begin/end_signalling annotations actually work.

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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdba0bfd6df1..adabfa929f42 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -57,6 +57,7 @@
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
+#include <linux/module.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/version.h>
@@ -7320,6 +7321,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
+	bool fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
@@ -7600,6 +7604,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* Signal HW programming completion */
 	drm_atomic_helper_commit_hw_done(state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	if (wait_for_vblank)
 		drm_atomic_helper_wait_for_flip_done(dev, state);
 
-- 
2.26.2

