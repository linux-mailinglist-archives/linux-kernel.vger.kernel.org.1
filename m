Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A272A2C0452
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgKWLT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgKWLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:51 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so17530569wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4FjG6f9bymrh4PjmAcFpuoCus4SJcn+AyFqjEZrv1I=;
        b=vVtLw5uT6obzsw8cMoY4xbKNUucmADpVYib8Njfe0EEVJAIs0FfMXC1oaf4fr2ouBA
         uBpCJ+IgKilFI5lPWPI2Rtmasmj1eHvBiS02GeGassoW1xZq+fzzvhgvM2jOlBtIm8QD
         hNxNVPUBFiqe7UXOzN34Knlk7OeyVnKRxJqpMbKIUF79T0Gg9rEedupu/GGa8mPcVcUH
         LJ5jfGxGyY/jaoqgQ1F31B48lWeWBek6XwBzueCp4Meg/RjV8gmLcgO5ZD5GlG+Uw4sp
         d5PlZxY/WVYFRUk8ZT2RP8PfIwaO1mv/OxhEqG51oexe0MCWWB65fGWFWPRkVJP7aiNS
         VFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4FjG6f9bymrh4PjmAcFpuoCus4SJcn+AyFqjEZrv1I=;
        b=mmt9oWlYG65Dqqtfu2Q6aZ6qdTTZ2957bFpx5+Bj/rWnlSY+OcmSmJz79ytYwA3T89
         yWIUWeh0MpfAiVO+YwQ+O9GpG5qIBD2j9x32bayhRnUTlFvYK1QBhQzjxPN4j+cBiSaG
         XOTDMtE41aZajAjv1Sb/TbIA1nw54sTspBxG+ZZBErdDuwu5VPT3RIokjsEgqygZRm54
         ohqV7LpZe80HSlrvCjjSYgu0n0S0Ek9Wqf10V3xHO0877Pn5bGftR9UJtqnGT7arRQfK
         AZxAjpCm7mkrUuKNsc3r/PbuLsOIq57KZvCQwQOdDIGahwGTEoGG4/smkMbIbkktisUy
         5hsA==
X-Gm-Message-State: AOAM533aabFW51rIPGhRLfJzBGkplnaT1LXUqvQdD105TApzLqxL0THJ
        YU5SomJcqO2eOnyXG3ux9c7yEQ==
X-Google-Smtp-Source: ABdhPJyUOXqPshe2OXY/yWW4HWBycTHOYqj9YJnlDG9mNMgCMAKhHT1jzXAB7KFzPcBCMyeSQyPeYg==
X-Received: by 2002:a05:600c:22d5:: with SMTP id 21mr22035408wmg.33.1606130390647;
        Mon, 23 Nov 2020 03:19:50 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 22/40] drm/amd/amdgpu/dce_v6_0: Fix formatting and missing parameter description issues
Date:   Mon, 23 Nov 2020 11:19:01 +0000
Message-Id: <20201123111919.233376-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:192: warning: Function parameter or member 'async' not described in 'dce_v6_0_page_flip'
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:1050: warning: Cannot understand  *

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 9439763493464..83a88385b7620 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -180,6 +180,7 @@ static void dce_v6_0_pageflip_interrupt_fini(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @crtc_id: crtc to cleanup pageflip on
  * @crtc_base: new address of the crtc (GPU MC address)
+ * @async: asynchronous flip
  *
  * Does the actual pageflip (evergreen+).
  * During vblank we take the crtc lock and wait for the update_pending
@@ -1047,7 +1048,6 @@ static u32 dce_v6_0_line_buffer_adjust(struct amdgpu_device *adev,
 
 
 /**
- *
  * dce_v6_0_bandwidth_update - program display watermarks
  *
  * @adev: amdgpu_device pointer
-- 
2.25.1

