Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE02A9F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgKFVu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgKFVuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4125CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so2779432wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nopEvpxJII5W2X0oKSxO5qTCMfgTR4xaU1b6yHoTHoc=;
        b=Q/dYjguv8S6NsqfuKHgA061fmsexpTGcj3625pXi+PgAAgyL2muaEoshXwa+Kvnc8M
         59TG+TyhDa9fhxU8kIXiT3LXDmM8E9cUAyQ7qO59NrYbQDdRF+hOw9843TRurp2N1BXe
         Ai8xtWFs0fS315EoPuu8iPpZCzNdgLs2ST/VfWYd4RdGXIlr+q7rTJ/aFjdxIEqIbH7z
         hP83MnWVORZUN1gv5M7ZnOV+MDikTRoRWtIUNZdw6XIMqWWeiuQDjJ/ZnLMS3CEpivUb
         LxqLrkuSh1nL7vsvi5aSkA8MPdprs4DsYk5wo3vhBTOD+9cNuMocqJbzAgsCAtPi2h1X
         wi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nopEvpxJII5W2X0oKSxO5qTCMfgTR4xaU1b6yHoTHoc=;
        b=HvjIHcypI6vAWTkFIywtf97EIQnfSdpQzLMB0xCGkVkz0ZiLiWhNu4JucEiUDVkQ3A
         /9yyamm6Q/rsJsy/4izCtBy4vt9/2R5aKAgcnINIxKWpI0RDxRRQQPA+uj0uocpmLrfq
         aUigHQuk6cNSo+BaUlIHtaqwcr91sig6uKIx4kKEmA10NDd6zSmyOiEu3zCwN8QPCq3V
         vl3sFXUGfXyapQ1Gn/lVbZ12iACos73vJBr7UgKEXRP/V4w9JoGsJ3BvTu/1BcHxSQBV
         ZxqThP6aKhlKdi66OcQlrrwv4O3Ff21a1HvTzM5F+SfghG5bTnhnPo0TEx8GKjpLPs+J
         lZyg==
X-Gm-Message-State: AOAM532QS/geO08+Qmn3AcFXyX3z18IwFNMv04mnJLC9f1fid4TKNPY1
        hGCEiRGphZUy8lcJKjKNNeP1dA==
X-Google-Smtp-Source: ABdhPJwhjl524rbpYWNO1C3Rgl/wInBAegWkXlKb202St9OQIldxQWVbP3BbXf2lvC5EiamcJEuT0A==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr5108985wrg.150.1604699415033;
        Fri, 06 Nov 2020 13:50:15 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of 'radeon_info_ioctl's dev param
Date:   Fri,  6 Nov 2020 21:49:47 +0000
Message-Id: <20201106214949.2042120-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter or member 'dev' not described in 'radeon_info_ioctl'
 drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function parameter 'rdev' description in 'radeon_info_ioctl'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 0d8fbabffcead..21c206795c364 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -213,7 +213,7 @@ static void radeon_set_filp_rights(struct drm_device *dev,
 /**
  * radeon_info_ioctl - answer a device specific request.
  *
- * @rdev: radeon device pointer
+ * @dev: radeon device pointer
  * @data: request object
  * @filp: drm filp
  *
-- 
2.25.1

