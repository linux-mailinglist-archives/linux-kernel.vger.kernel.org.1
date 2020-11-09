Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44D2AC6EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgKIVTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbgKIVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:11 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF14C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:10 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so2542100wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QRM042GtogSyG7+rZpj/l/1G+WGXOLxnrrF/vvxVJY=;
        b=sYB8KKFz2Jqz6gYGNdkuwzwig/UrIQLC4jkCLB/qG9c32GQmE4Wy7/z/7UC1U4CeSQ
         NEY4vmIHF+LE5hK2gP1lO/VnKsVAJ3KPOH1xTVygdnTEjoMQtAS5asJdudEZYQlKonBX
         aZIvDgG3rHrWOd56KO+sOGIwnUpoxEvbrIcnCdfK8VZ5QgWCcyzY6XveCPguPjHOXu2z
         0vkc4atHMwUh62yCPRuO8EJXEGI5dwbF+p8xCPuf0obxUJqwvT8eTvFkMqjWITYwvX5W
         BoBbgWbPvlVD0L8Usa9WIcrRGNt/AY9Hi8zm0b5nPLL3+eAI2paSOfsc4E1dYVapf85+
         tfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QRM042GtogSyG7+rZpj/l/1G+WGXOLxnrrF/vvxVJY=;
        b=B6TDzK8ZONGceW6N8tLECfwDpPY22k70KV9qYiz7V7g2DKoebC0YolHULWWQgGiIvT
         yqaOWLgNxv4U/X1VYvJ8PK9YRTsuNxXBGO+5z+Qj4bG5GQ8ill3+UqcSSltU603JgrjT
         O06gjtZUs5F/Hr+vr6MS4vg8FSBDXCrYLn7xF52l7SGvvevG25l0V9ELvH/ea3af4Xqa
         A1bqa1wBp/NJgKBW+QUGqfgvgUqJwSxUCdfohOXlgRHhUlr7Oq80a8qjgFdiK26AkpMi
         UTw/bHGEiucM5VXZAC1njvHYNE9EUJEmlFZ4nYfQck10WFgoLC7gM3cekNs0uoFg1lMD
         Uzsg==
X-Gm-Message-State: AOAM531F3tYjrEArLzDJLx0J0hc3L6b10M/zhjkTyoIgRw+qYrLkhNBL
        jA7VKPbEmBxw6iW1Zpjl0A9tpA==
X-Google-Smtp-Source: ABdhPJx+8D91GN4vBrp6RpD70yxFoPTEG4/f/iF2ytiqTOOf0RR6fQffoDlm+OFr+Y16Dp6eKwfNdA==
X-Received: by 2002:adf:f5c8:: with SMTP id k8mr13463869wrp.2.1604956749484;
        Mon, 09 Nov 2020 13:19:09 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jerome Glisse <glisse@freedesktop.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 03/20] drm/radeon/radeon_fence: Demote some non-conformant kernel-doc headers and fix another
Date:   Mon,  9 Nov 2020 21:18:38 +0000
Message-Id: <20201109211855.3340030-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_fence.c:168: warning: Function parameter or member 'wait' not described in 'radeon_fence_check_signaled'
 drivers/gpu/drm/radeon/radeon_fence.c:168: warning: Function parameter or member 'mode' not described in 'radeon_fence_check_signaled'
 drivers/gpu/drm/radeon/radeon_fence.c:168: warning: Function parameter or member 'flags' not described in 'radeon_fence_check_signaled'
 drivers/gpu/drm/radeon/radeon_fence.c:168: warning: Function parameter or member 'key' not described in 'radeon_fence_check_signaled'
 drivers/gpu/drm/radeon/radeon_fence.c:393: warning: Function parameter or member 'f' not described in 'radeon_fence_enable_signaling'
 drivers/gpu/drm/radeon/radeon_fence.c:393: warning: Excess function parameter 'fence' description in 'radeon_fence_enable_signaling'
 drivers/gpu/drm/radeon/radeon_fence.c:1010: warning: Function parameter or member 'm' not described in 'radeon_debugfs_gpu_reset'
 drivers/gpu/drm/radeon/radeon_fence.c:1010: warning: Function parameter or member 'data' not described in 'radeon_debugfs_gpu_reset'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jerome Glisse <glisse@freedesktop.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 8735bf2bb8b5c..9ee6e599ef83b 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -157,7 +157,7 @@ int radeon_fence_emit(struct radeon_device *rdev,
 	return 0;
 }
 
-/**
+/*
  * radeon_fence_check_signaled - callback from fence_queue
  *
  * this function is called with fence_queue lock held, which is also used
@@ -383,7 +383,7 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 
 /**
  * radeon_fence_enable_signaling - enable signalling on fence
- * @fence: fence
+ * @f: fence
  *
  * This function is called with fence_queue lock held, and adds a callback
  * to fence_queue that checks if this fence is signaled, and if so it
@@ -1001,7 +1001,7 @@ static int radeon_debugfs_fence_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-/**
+/*
  * radeon_debugfs_gpu_reset - manually trigger a gpu reset
  *
  * Manually trigger a gpu reset at the next fence wait.
-- 
2.25.1

