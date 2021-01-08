Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172022EF8CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbhAHUQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbhAHUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9950C06129F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y23so9442120wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1ACHhoDM3J5dELVH57xIAQUcf34vzdyN5ALWF0ycEQ=;
        b=RobXHiCalmxUMxBiwWjqlom0EWAsiBTcsj1Ei8+x90LUZCySBXgpU8xTX9j2i46Rr3
         KSEcIB2YfsMjrstXrKYwkRG9S1If6LX4l2XOFGd7hNeAZrjH6sXILEd0IAS6XiFAQOgP
         oPfRfGEI174ndsVXFXEAz/OemllVs6/5jWzo3rBlLT0dR2vnoBtSk5InuOzokUvtH8RJ
         MbVPJkJv5LWD4s19zLMoylEtumeVPqUuJaIuxcUHvNwlTm6fgh+SlhRWIRYdDDGerMJF
         vmL8H/PY2X2kTd3fyJBMupz9k0C8eoN5qBx+vAeLkglLl/mqFwST4u7pA+1GkBiup3HT
         zhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1ACHhoDM3J5dELVH57xIAQUcf34vzdyN5ALWF0ycEQ=;
        b=UVNF68Y3A97DvoPEPNwBc60j1qu4gnKqYWcVl/cj0yfjArHgAwRX49BLGJZeb1KeCL
         4nwBuDfNjbwvNbbhwibq5zQ7bDuwOQOnYkip/IKa0csYUoCEBr3SC9NDyR9EP7Axkd+k
         TgpBQFxtRaLEuFjcKF0J40zVNZLuvrJBg1ETa6Ghq/iWQokoWM/u76gIaMq43YpeEVv9
         4TMWkxR/WXZfzJzhttHerqZMKsVqBZzA3htYVYz6a6Aqw4yRgqnxWzEC9o1qxNVsNVwu
         nFPDg4FviVfSn/J17XkfRSI5vmqsnZwFnv6AYZzOox+i/qV/h4OgAQQctok0mGl2aMvu
         d7ig==
X-Gm-Message-State: AOAM532NTHgiofnRz94HAybc43Q25aipprol9oz77mRWb9y+hcq9iyjI
        nmrWuvVlBfkJgJkCDL/KSm/qzg==
X-Google-Smtp-Source: ABdhPJwIiHZnNFkLdYTqXNaGhsCT91nMtjQP7O3ZYXC9abXxyA0R72iKa5HOrjtFAsz6QNJH+FjOTA==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr4578911wmc.39.1610136912570;
        Fri, 08 Jan 2021 12:15:12 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0: Provide description of 'call_back_func'
Date:   Fri,  8 Jan 2021 20:14:23 +0000
Message-Id: <20210108201457.3078600-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1371: warning: Function parameter or member 'call_back_func' not described in 'get_powerplay_table_entry_v1_0'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 741e03ad5311f..f2a55c1413f59 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -1362,6 +1362,7 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
  * @hwmgr: Pointer to the hardware manager.
  * @entry_index: The index of the entry to be extracted from the table.
  * @power_state: The address of the PowerState instance being created.
+ * @call_back_func: The function to call into to fill power state
  * Return: -1 if the entry cannot be retrieved.
  */
 int get_powerplay_table_entry_v1_0(struct pp_hwmgr *hwmgr,
-- 
2.25.1

