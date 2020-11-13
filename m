Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570102B1C97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKMNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgKMNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:06 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58405C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so8200431wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46jV9p3NGfHHD7RmZzAF9wCbEXnPQwL3oGoQw/6SZqY=;
        b=jcRc33FqvvXfYZDq2w/hkAOKcF2M6UsYfjQCTBQFmt48Mc/W99snUkSH56/FCyd/sR
         2Icd+6Ibx5xO76vEda91ScW6Obx+2JGyG53DC8PMv/rJQHZCkXaJ2jV3ZsFYzX47Gr/Y
         Ydzw+SuXuP0MYCj+U+iC/209+05xF7z+uajdM4hrF7mw9iWqkycWyjqK/OnZ4XgHuNbT
         s7bFMXSTomsPs8pw3U3BmBp+X+CX8onf+3Wt+M/rszLw4RmUWR4fLEeMphKfw0MltKh4
         nzOAPpOhj5Vnrsr6KrPvwgDOntRpLtFNJy73zF+W6qs6FQ4HgUtNRQqTrb0LcGOnx9Aw
         Lazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46jV9p3NGfHHD7RmZzAF9wCbEXnPQwL3oGoQw/6SZqY=;
        b=MKvC4MK7FpvgHbPrnTLyv14I8OyJl+P/gkfQRjFjG8C3v5lZLdB9dczFHh5OeRO9yZ
         Md9mR0Ato/xPfNo8SKIA/tF6u7oRPWCH7sveIEF9qDCq3gQB9/gybpnBhdOKc90+Y2hV
         qV49TO3nng2r2+6JlDWcSnGTA1LywtafMlKqemKfiqCLIjIIa3j4qvW4JdNwVgtG5qvz
         o43HZxcNloe1uFrxKvV0Z0NqUA2pSr5HF8/FHPNKwGg9nlhFLGmUbL9PlxMSmxfW8FVJ
         43MHmZOG0sgHTL0dLouktM6afoDgFVv+tmEFtX6vfdFygjgsrZYaRGG9JnUpCYZoPQ9+
         5TaQ==
X-Gm-Message-State: AOAM533y5r/Dar5/AY4LIBn584XClEGCuA4b8MDpdEK9QePqypgzI3LQ
        UDOHC/ODYPNIkssE9kOsO2dI/A==
X-Google-Smtp-Source: ABdhPJzM5M9flHKJZbmEjS7wmST4v4wEJvRBKQxhpv+CufNQVMmQ8o5VuNY71S/H5cFSMz0jXMkYxg==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr2635450wmq.178.1605275405100;
        Fri, 13 Nov 2020 05:50:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/40] drm/amd/amdgpu/amdgpu_vram_mgr: Add missing descriptions for 'dev' and 'dir'
Date:   Fri, 13 Nov 2020 13:49:17 +0000
Message-Id: <20201113134938.4004947-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:648: warning: Function parameter or member 'dev' not described in 'amdgpu_vram_mgr_free_sgt'
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:648: warning: Function parameter or member 'dir' not described in 'amdgpu_vram_mgr_free_sgt'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index c99c2180785fe..d2de2a720a3d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -637,6 +637,8 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
  * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
  *
  * @adev: amdgpu device pointer
+ * @dev: device pointer
+ * @dir: data direction of resource to unmap
  * @sgt: sg table to free
  *
  * Free a previously allocate sg table.
-- 
2.25.1

