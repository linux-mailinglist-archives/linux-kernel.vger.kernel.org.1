Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5F2B4E43
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgKPRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbgKPRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:12 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38301C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:11 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so36672wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWKMq1DqVP98QcoNoXmklvrAILj+KoFN9Nw2d/Tqn0c=;
        b=AZkL0vTTyxk+qn+knrS8JsKh1uX3JBdQV4cxD+BFOWtzaAEZHcJTPFTQTvPiJ+r9MB
         R9rVcYw0cx5xl+uHxcqnLOALxHvDCZOa8wqgvrF1rI7L1Z8dpVX4tYYGBmieDCxg6oV0
         UphxExobgaBvDGn7ZVAN3hpfhT42SJ6wGLomRfx+Wt03bfTFHyOKa79p645Th2ypthB1
         Mbw3pUBRrTA3DGLEu54EWLo6MlZP0u0HkSHy59FpWyhpNuciXw6YOZ+RULCIaHLnrFMJ
         vOwKxOCJWsEiUgbxu0qVsSV48yHmuGEll17GvLRFEncNv3ztpazHJRjLAEg/kRzW/h4O
         k6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWKMq1DqVP98QcoNoXmklvrAILj+KoFN9Nw2d/Tqn0c=;
        b=e4PEcClGnW5U5c28PcmWN3XvdpdTgkSR8rOLpuMhzxPQMsUNrwsrxiuTn7s7eJ9LrN
         /i9iwdibg1vjC8RoUh5SNOJHYCIFRoRlesJBXzqLWPWJENPs1k6peRadF9pwVQPJKSKG
         XS4a+KEj56r/ZLJ0vgpqVp2unAHw0NP+2mj2XcEu678ThhdCnD2SjX9O9poAkPpTWV+C
         7ibSn85/VJ0NDkRFxc6kHt2DT6Vzv1S+S1qpcGIDXGdhJfseJF56ysPI1ElyTb8lwHnv
         VLFy1gswKPHN3Pj0olRESf3gIzGw14PKaxCku5RUm8ZGgAzVVH66fAFjQDqh17Xyt1tI
         8cAw==
X-Gm-Message-State: AOAM53315H31X7eKOvicNF8+yC2Vnth1Qri3QSZ08sQtFcadGFFUWD1R
        6YvQtTf8qBTgjO9F89eJc2RDdQ==
X-Google-Smtp-Source: ABdhPJxa2OYyT+kPM38xMqaqvVdak1kEsguesAO3rvzYZo5Fy8xTslicZ8z9OmMrZSCfUnFEO9Jcdw==
X-Received: by 2002:a7b:c18e:: with SMTP id y14mr7522137wmi.123.1605548529946;
        Mon, 16 Nov 2020 09:42:09 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 35/42] drm/v3d/v3d_gem: Provide descriptions for 'v3d_lookup_bos's params
Date:   Mon, 16 Nov 2020 17:41:05 +0000
Message-Id: <20201116174112.1833368-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/v3d/v3d_gem.c:292: warning: Function parameter or member 'bo_handles' not described in 'v3d_lookup_bos'
 drivers/gpu/drm/v3d/v3d_gem.c:292: warning: Function parameter or member 'bo_count' not described in 'v3d_lookup_bos'

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 182c586525eb8..4eb3542269725 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -275,6 +275,8 @@ v3d_lock_bo_reservations(struct v3d_job *job,
  * @dev: DRM device
  * @file_priv: DRM file for this fd
  * @job: V3D job being set up
+ * @bo_handles: GEM handles
+ * @bo_count: Number of GEM handles passed in
  *
  * The command validator needs to reference BOs by their index within
  * the submitted job's BO list.  This does the validation of the job's
-- 
2.25.1

