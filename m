Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA22ADF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgKJTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbgKJTbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3ACC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:51 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so10093889wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvESdKcgA/L+8nfzHIhJWgogEA2sv/augj021aQ6Bjc=;
        b=ZJw8ND/9bYHNBVXDmU7GEhDFPjuFQlU5+Kc7N6oNwR9ygFDK9h6108LYish92o3sF/
         9g/r9hgfo91h9+hm6363YzrOl6p7qDErHiA41H2m/SyEkFBIK1eKvQpRgYJ+PMOa3sc4
         cdV6C3R1MYOBMBoVWp5kuuVLyYMJAJaY7SZZPHrfzPPIWkia89ujnAdqCTK4SsUUqAgu
         ZEbs4WX1DiUH5nLcYf15NZRwanNF/NQCDt5HTmkWETCiTwwlnRWVRlhHZsJnb+vDopha
         jJJ8xIGlSLXcCgmuSRPC9e+9DvRgY4Y9vy1xLqk/bA4KjtMtC3+nHdawMzpnAPhx1QdJ
         C/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvESdKcgA/L+8nfzHIhJWgogEA2sv/augj021aQ6Bjc=;
        b=ScsA0KKfUQZ52bCttsXb020+Q1JGcAtotuhgi8ltWpcA8rkIf/bLG3B1nMtiwahY1f
         dTvDyPbNmknKS5z0i+6yTERcJfc/PkgNqz2LZV+V4sap6lzK/MFZ+n0zawbSug8RpxZ3
         BMZMsiiTriAsr5hiSxbiTKMEmXqbRRFv0EKWj+0BuXy8h+2G4eU3YHyI7xxf7dqwpCQJ
         d1tRPL1Tz3gPBtbA6NZfin3R1bZ3PzMxiTls+d+NpSmkXJWhWAcTyS591xkC3M7yqMCt
         JWEeEx/tr93y3CP/35dkx7rfS/3bmSZVXCwar6xNm/TgJLEEmQBH1T6O+Mnimdh9t0bt
         iJWw==
X-Gm-Message-State: AOAM533hFuNyuCidM31PcOFN8kNLNSbH7nGxdByffWptr5DeCCwb9tz3
        2X2NF+9Zjg2dHVziMw4TZ3seJw==
X-Google-Smtp-Source: ABdhPJyvnNToifCwCcItVV2Yat9wLKHzh5OkA8Rn5RJraDJliZGDbS0ptMaJMV9PQvGxFZjcejgTTw==
X-Received: by 2002:adf:c3c8:: with SMTP id d8mr14030198wrg.366.1605036709871;
        Tue, 10 Nov 2020 11:31:49 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/30] drm/radeon/ni: Remove set but unused variable 'mc_shared_chmap'
Date:   Tue, 10 Nov 2020 19:31:09 +0000
Message-Id: <20201110193112.988999-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/ni.c: In function ‘cayman_gpu_init’:
 drivers/gpu/drm/radeon/ni.c:880:6: warning: variable ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/ni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 12dd082069649..1c9030a4631b8 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -877,7 +877,7 @@ int tn_get_temp(struct radeon_device *rdev)
 static void cayman_gpu_init(struct radeon_device *rdev)
 {
 	u32 gb_addr_config = 0;
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 cgts_tcc_disable;
 	u32 sx_debug_1;
 	u32 smx_dc_ctl0;
@@ -1002,7 +1002,7 @@ static void cayman_gpu_init(struct radeon_device *rdev)
 
 	evergreen_fix_pci_max_read_req_size(rdev);
 
-	mc_shared_chmap = RREG32(MC_SHARED_CHMAP);
+	RREG32(MC_SHARED_CHMAP);
 	mc_arb_ramcfg = RREG32(MC_ARB_RAMCFG);
 
 	tmp = (mc_arb_ramcfg & NOOFCOLS_MASK) >> NOOFCOLS_SHIFT;
-- 
2.25.1

