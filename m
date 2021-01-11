Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65B42F1F20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403902AbhAKTVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403864AbhAKTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE967C06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k10so244473wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WUI8zMKN7GlYJMYgpQ8BoEDGt3wAB5ccQaGwQCdPONQ=;
        b=ODjNCowqY28FhbIanlnU07cUII0VkYfzg2ra7UmLI3aacqHbD0K1Vk44vSU95Z5fLH
         zfFdShsLLUd1zQFNt3YzOT4rcMUqceJRBLMgLZgpl04IUDNnVGck9gjzC7jXD0hY6qPt
         AVvjTKdeqhe0bWb/DLgbx3VV5uoBUIuyy9nKCPZm2Fge9i3KyMidHNVSEidEhNju5z8N
         +50A5OsmIj5kQlDAP/Rh91qV/3GwvzTA8LzQYQLMFFVB54fN2CfvjZP32CN3T0ayWJ88
         q79zE1ws9LyaQLYqcao8F3sX3SbMZzwB2nBH3AOYy6hLcsy6BC4A/Vf/9mOk2vNPXy7W
         +liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUI8zMKN7GlYJMYgpQ8BoEDGt3wAB5ccQaGwQCdPONQ=;
        b=DtAw7JMcEvIk6/Vw+6xXFYbjtdi1U3/i309f7DU0AP1hzdL8tO3/nnEtJxZ5SVlgur
         JRVYlvGh46a3i8Sedcty94fOYzBEaWweamkxOggHwreGedQd0O1rFK/0rQhc/Lp0QEPP
         Ye10l5zBO5KUxkPzWdLbEcxb9hNB6d/ZvTNOdEyBPF3k6hWSvXlBy3OXxNP5g+xKBJFJ
         ToxLp0YR+0OcbgjVWMWfCKPiXbddkQrwxAOcHeUN0ANPL9Bh2E00MkQZOUivCwQFCuyz
         5E+nMlL+aDHluMWaUahHgnV51gEhn/Xib+SxPX5wSRj+nC/O7bU+jzVAcpPDKZRqZQIN
         vMAA==
X-Gm-Message-State: AOAM530AKi1f1TQRnMpFDuXBrPwxhgs2O9QuO4TwHP3xo9rV9HZfMZ6r
        wYHjCtpoY/OAOty8H3uExxiXRQ==
X-Google-Smtp-Source: ABdhPJz8tM5Xs/MNa8ZtK7I5QhoB0S+VaI3xXWPEjjhTmvqmg32J+h5D8Sve6UMd0TzFj9pGiOHvOw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr290685wmj.148.1610392814445;
        Mon, 11 Jan 2021 11:20:14 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/40] drm/amd/display/dc/dce110/dce110_transform_v: Demote kernel-doc abuse
Date:   Mon, 11 Jan 2021 19:19:20 +0000
Message-Id: <20210111191926.3688443-35-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.c:228: warning: bad line:    void
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.c:233: warning: Function parameter or member 'xfm_dce' not described in 'program_overscan'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.c:233: warning: Function parameter or member 'data' not described in 'program_overscan'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../display/dc/dce110/dce110_transform_v.c    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
index b1aaab5590cc6..29438c6050dbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
@@ -217,16 +217,15 @@ static bool setup_scaling_configuration(
 	return is_scaling_needed;
 }
 
-/**
-* Function:
-* void program_overscan
-*
-* Purpose: Programs overscan border
-* Input:   overscan
-*
-* Output:
-   void
-*/
+/*
+ * Function:
+ * void program_overscan
+ *
+ * Purpose: Programs overscan border
+ * Input:   overscan
+ *
+ * Output: void
+ */
 static void program_overscan(
 		struct dce_transform *xfm_dce,
 		const struct scaler_data *data)
-- 
2.25.1

