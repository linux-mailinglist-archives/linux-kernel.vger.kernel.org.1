Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816D82C564B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbgKZNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390667AbgKZNne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2FC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:34 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so2469458wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuZf51/6rbT4Y+F0DKDI1W5yRp5gMKolAl3JbWxMH/Y=;
        b=pisVm/rn1U4ASlnA+K2ad3MOviG7WcK7m0ytip6AZ5V+ZahEqcC/N+qhBRNXTuHkZp
         ko49wyV7Vf6eJlfyXLiC5aAbzmVW6rAzSbPTgRiKdjsoT5IpZ8dygbiNxsHF1XuXWfwf
         9vv1Y26Cbn+buNvO7Cv8ebSz4oVmgNILfAinKRefB7PT2t++oPiclWQGOt4nWn3LzjJs
         m9X+RiPK7ANui7vbnIYJ/9uVxveDWjnHNu419aZNGdpS1UAMejAu3C5samgmGP7nShMQ
         djH4l5wasV5qzjKRhoEUsnPEtwerC2XlPgh2hDNjOo/RSmGu1jNsvKfVfwNBk0qeXyL4
         kgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuZf51/6rbT4Y+F0DKDI1W5yRp5gMKolAl3JbWxMH/Y=;
        b=K0YgKz/FMswQoEOOm0cgoJyyxKIhXJT9ooZdGLUj7RN3rz2ojcUNsbw9pdw2tADsKm
         FKzIlb5aUH7oX9lC/abtcdz0xUIHPRDBxcin+gjxLhrILjm6vRXstL1Qk1iGzIfO0h9C
         jdyYEknuzmGiiwj1XcF49db1sRbAZAtTp1VNKw/tizCOKm6Kxf6oHzcfn/qKnCLXAnms
         WTTwrhpnqZft5C8Du9thgvw0Wq6wtjVOym/XgNdkx3xQr3I0rddO2KZxnYUKSUJEMicz
         WLWkVrU0et2ZYovIeqyatW2pshSYmNDdei+C+DEIQCpk/EHyJfgqVV0CPRwomivnz3Vk
         p9OQ==
X-Gm-Message-State: AOAM533md7jWCqjHS8V7rFKg0HKzYnv6bbpFX9oLe36DfpDnzxdUCAVc
        cu3w2y59oc3JjidkJtVmI3EeaA==
X-Google-Smtp-Source: ABdhPJyXwqSGhbR6oE7tW8GUsM+939v/thUOmdrgNzAsSIaz6WTEsqDFmj+ShQapDgKeLqtLrLF+cg==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr3443933wmk.125.1606398213104;
        Thu, 26 Nov 2020 05:43:33 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:32 -0800 (PST)
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
Subject: [PATCH 32/40] drm/amd/display/amdgpu_dm/amdgpu_dm: Mark 'link_bandwidth_kbps' as __maybe_unused
Date:   Thu, 26 Nov 2020 13:42:32 +0000
Message-Id: <20201126134240.3214176-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'link_bandwidth_kbps' is always obtained, but only used if
CONFIG_DRM_AMD_DC_DCN is defined.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function ‘create_stream_for_sink’:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5080:11: warning: variable ‘link_bandwidth_kbps’ set but not used [-Wunused-but-set-variable]

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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08539f4315864..ac7643d73bc68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5077,7 +5077,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_dec_dpcd_caps dsc_caps;
 #endif
-	uint32_t link_bandwidth_kbps;
+	uint32_t __maybe_unused link_bandwidth_kbps;
 
 	struct dc_sink *sink = NULL;
 	if (aconnector == NULL) {
-- 
2.25.1

