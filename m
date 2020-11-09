Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398622AC6E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgKIVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgKIVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936A0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:07 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o15so2541939wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zaj9PQ1+4jRxFdQPS9IoWMCG22fw+6XqKxYZ9+Me3Xg=;
        b=G98UJ0t6Uf8XyAe1ROYsF/XIMBcEriB62SabFOr3x7XylyO8f9EbS45rVGhEBLXDKc
         hsQWYFs4zJrYc8FmqhCl4m5tFEmUxtb/xdNjP38hGmTM+qJYlf6lSeEtXHgBY1Lxc1SA
         woIBgG5kTOcPnd9oN2qSk/gOYKj/NVFn+xnPT8PufPJK9ISuPMYdystjas8QpGyhxCK+
         WtcpnuN2ItVwsIy5aLglVDP5NcL4TDQ+65zCqarczO7dPo3xQQ7A1fqgdOtMQ8sFQoBt
         TSwqrf1ReLTffFk2GBD4UR3j4VhzU9yKA8Fb0Q9ctsBiVMwkr9lJ2Lss+sSdO0Qjq+Zn
         hz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaj9PQ1+4jRxFdQPS9IoWMCG22fw+6XqKxYZ9+Me3Xg=;
        b=eg2vnD5/lUaMwYJdbtxS+kNoQk6g8P/ukUJfMopULKC/SDXMwBDmJ/gTLgPdrPoUqH
         uoxeY0XuPKgE1nMM/o3Vao+NESx5+fl+fcLZHLwM97d+2qLmITAoEEf8E3BuCdp9XmRN
         XuGzGNAGyi3BaQlhjzoKTyfwrMcOQxhDu43PQidlmVllN/QsGJITcpAbiVnn0M+kwkkG
         c80/vqVOob57gFS6ecTXtp7zFgMXmcbpcKQIL42Yr8zLIgjXhopNED9D+gx3uQKIauEd
         oVsENHk8emHfEssHcqhGm6TxnJJjS6LHfMJ5P3NNCa+TQxWJ31mZDTC6y9jMZJclDgQG
         hG3A==
X-Gm-Message-State: AOAM530ZDvuEIOz0j51yiIDm/emAtZP63NWKaLA4KTKWyptiOfDcGscv
        9/osUkji+9wOaWuVpJ2HOvgROA==
X-Google-Smtp-Source: ABdhPJwBysRZoAQuR+8rQwerSjF7CGhlBAXduxk3l2+at9VV/7M8Sv74lR+5Ws5WSF+dHOXHmcBybQ==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr7212779wrt.105.1604956746318;
        Mon, 09 Nov 2020 13:19:06 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 02/20] drm/radeon: Move radeon_ttm{init,fini} to shared location
Date:   Mon,  9 Nov 2020 21:18:37 +0000
Message-Id: <20201109211855.3340030-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_ttm.c: At top level:
 drivers/gpu/drm/radeon/radeon_ttm.c:817:5: warning: no previous prototype for ‘radeon_ttm_init’ [-Wmissing-prototypes]
 817 | int radeon_ttm_init(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/radeon_ttm.c:878:6: warning: no previous prototype for ‘radeon_ttm_fini’ [-Wmissing-prototypes]
 878 | void radeon_ttm_fini(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon.h        | 4 ++++
 drivers/gpu/drm/radeon/radeon_object.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 53d9898e9871e..a0c2497cd4cf4 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -451,6 +451,10 @@ struct radeon_surface_reg {
 /*
  * TTM.
  */
+
+int radeon_ttm_init(struct radeon_device *rdev);
+void radeon_ttm_fini(struct radeon_device *rdev);
+
 struct radeon_mman {
 	struct ttm_bo_device		bdev;
 	bool				initialized;
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index ab81e35cb0606..048d83d0ca996 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -41,8 +41,6 @@
 #include "radeon.h"
 #include "radeon_trace.h"
 
-int radeon_ttm_init(struct radeon_device *rdev);
-void radeon_ttm_fini(struct radeon_device *rdev);
 static void radeon_bo_clear_surface_reg(struct radeon_bo *bo);
 
 /*
-- 
2.25.1

