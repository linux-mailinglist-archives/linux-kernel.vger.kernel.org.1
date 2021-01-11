Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D972F1F35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403832AbhAKTU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403812AbhAKTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5FC0617B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a6so246942wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXFKZa9JjVse7+5giwTOAXSXYikkRKBfRN4TR1AbnV8=;
        b=Q9535ah1toYRZ7VlqwLDBDjQYfMfUYLA55rRtLkTMCTwmD5CzFWXNAVjehFjlap/TL
         MXSD01bPe7YrIvBgydU8YLuFUEqZ0AUoo9ikS76apFToPKRioQgaXnbjyXRMB6nmGgKc
         NPwBpeK8MR1KnLKTEwtKy+UfcL+uJZNqwVSZ4xfIVKlrLD7FPEYfSVjb4lVfdGbNE1wE
         1XmsAJ+oNGYUbrm0kZTvO54T9yVqRnP8byP30PPfSuDZAiBewofkUpEO3ALMw4QF5SJa
         IYHVmBt/aHbAefEsRw7Ge8rYYH+nSYIfdVy3gs+idI7Ae/0qvaiW45i+HoUqcEzaFlKb
         w+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXFKZa9JjVse7+5giwTOAXSXYikkRKBfRN4TR1AbnV8=;
        b=jGuRkU6HwpJ3i7Gunj6PBXNvlB2Hg3okwFyplLkMeJqQBjJ5y1R1yNntOotmbS78xY
         WQrfiLq/rFUHu5C1cmj1CvEpC0UZxZxhjfBoQiQ39Gt7vPMlzVYx8tA6h7KeWoiCEAxK
         80IEko4WkO8dF0lAIS1e6JOpiJnALnitE+ocuHem1VCIxzmLEg/yXyW7bUt4gxrp3Ovn
         kxIuKtPSrt75UY8DoD1eTF2QN+92j0DFFsNCu72b6/LAtA6zyD9DJzH/n5fLGlpKI2yv
         gYy/xD/82gMIx+jwwnA3Ik+6LGQWSe7DvFBXSYze3tqYp+qEGZuSDjp5C1tEqjNXjTQD
         PWWg==
X-Gm-Message-State: AOAM531t6oDuh4f2ZzfbXSUD4X2P6/verEkVifThWclmxOkextd7LkA9
        Omzc9dwLde1UPY41p7nJ2CFb/w==
X-Google-Smtp-Source: ABdhPJztYQkuCVcTKJHKAb8YIg6UUqhAqQg50fyXnz/xR2qnfE6mLbt8/fD3cfvLlHesR1meF5lx5w==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr260298wme.101.1610392787408;
        Mon, 11 Jan 2021 11:19:47 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/40] drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap
Date:   Mon, 11 Jan 2021 19:18:59 +0000
Message-Id: <20210111191926.3688443-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘calculate_bandwidth’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: warning: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 158d927c03e55..a0c69fae40ced 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -98,16 +98,16 @@ static void calculate_bandwidth(
 	int32_t num_cursor_lines;
 
 	int32_t i, j, k;
-	struct bw_fixed yclk[3];
-	struct bw_fixed sclk[8];
+	struct bw_fixed *yclk;
+	struct bw_fixed *sclk;
 	bool d0_underlay_enable;
 	bool d1_underlay_enable;
 	bool fbc_enabled;
 	bool lpt_enabled;
 	enum bw_defines sclk_message;
 	enum bw_defines yclk_message;
-	enum bw_defines tiling_mode[maximum_number_of_surfaces];
-	enum bw_defines surface_type[maximum_number_of_surfaces];
+	enum bw_defines *tiling_mode;
+	enum bw_defines *surface_type;
 	enum bw_defines voltage;
 	enum bw_defines pipe_check;
 	enum bw_defines hsr_check;
@@ -122,6 +122,14 @@ static void calculate_bandwidth(
 	int32_t number_of_displays_enabled_with_margin = 0;
 	int32_t number_of_aligned_displays_with_no_margin = 0;
 
+	yclk = kzalloc(sizeof(*yclk) * 3, GFP_KERNEL);
+	sclk = kzalloc(sizeof(*sclk) * 8, GFP_KERNEL);
+
+	tiling_mode = kzalloc(sizeof(*tiling_mode) *
+			      maximum_number_of_surfaces, GFP_KERNEL);
+	surface_type = kzalloc(sizeof(*surface_type) *
+			       maximum_number_of_surfaces, GFP_KERNEL);
+
 	yclk[low] = vbios->low_yclk;
 	yclk[mid] = vbios->mid_yclk;
 	yclk[high] = vbios->high_yclk;
@@ -2013,6 +2021,11 @@ static void calculate_bandwidth(
 			}
 		}
 	}
+
+	kfree(tiling_mode);
+	kfree(surface_type);
+	kfree(yclk);
+	kfree(sclk);
 }
 
 /*******************************************************************************
-- 
2.25.1

