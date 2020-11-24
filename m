Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5B2C3111
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgKXTo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgKXTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:45 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7AC061A51
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so23510359wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyGlFqixaiqzHeNjep6qOwxxLQG3LHz2EsMbdYbo/ho=;
        b=QK9K5fe96I7qEbtSo01TjZGeTEFHCALFSW9gDK734tMa58wkL9VHsxuCvdEj884V0g
         gr7nA7du2QcSx4jOuXXCOWtHAWqZxsxxWsGyo+J/3stsNw5sk7DLhs72Iu8ePe23R5nP
         WRVXWrRtyhwsmkxvhmAd+2n1rAmriJ00bHAhvU1PoLoCnWobAGx7R30VNBpkCV2SDJnX
         aauIFEnwpTJGIqj2G09SxsETcOM8nmQXD6LRYp7AgzuZPzdO7FN1kUknbTZIp0e3o6V/
         ZKh4oAvb4vKZvkRAgMcmM7EBwi06kVzTy3IR1gu3mA3UjyGY7pmqvI+PoHrUf5ZOz1s0
         xh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyGlFqixaiqzHeNjep6qOwxxLQG3LHz2EsMbdYbo/ho=;
        b=cG0PRrrRZ57LY6LJI38e/9u4ilk+UC2SIpDH6ntjA5zuUtxELr9WvCGY2Lr982Eo3r
         eF8Y8P1+Mf/1+MQSGX0gan/p/En23FihGMZmsXXDkxC9tm5dc6IRjKJp1yjG6m+NFSC+
         vBOQyAPwJQ/t+e/73K3fvGPj4nqEwp+zj7fj6MwlBRqfXOeu8KS39MekVjAZl1aVA9mc
         kiljTdvMpTLM3Jj0jpoXTmwz0kaTrR7g3nMipbfrSneJIXw3IK1VzOlzhR0Sa0u02MRx
         njFCeCmiCAVR3YssI3ZCiHuY0wGs0L1ikjsbEJEFUsJDkfM5OSsLyftzhAwDUC7BxCAW
         jtzA==
X-Gm-Message-State: AOAM533q7Ftz4qd+84BkE2YQ4i4sd4iUGl7w4UUWTJWtVLn1qfmaPGBq
        ZEeq8OV0UH4WILp2xSshc/iHqA==
X-Google-Smtp-Source: ABdhPJwV7ExgIYDuoR+4W+qYYmwP65bSFwjiRy6ys8NECT5d9bmDI42mNreeAXC2LgTUyJR75gObLw==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr59620wrn.231.1606247084047;
        Tue, 24 Nov 2020 11:44:44 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 36/40] drm/amd/pm/inc/smu_v11_0: Mark 'smu11_thermal_policy' as __maybe_unused
Date:   Tue, 24 Nov 2020 19:38:20 +0000
Message-Id: <20201124193824.1118741-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used in some, but not all source files which include 'smu_v11_0.h'.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:36:
 drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v11_0.h:61:43: warning: ‘smu11_thermal_policy’ defined but not used [-Wunused-const-variable=]
 61 | static const struct smu_temperature_range smu11_thermal_policy[] =
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index eff396c7a281f..9742a02e7b16b 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -58,7 +58,8 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_MEM			5
 
-static const struct smu_temperature_range smu11_thermal_policy[] =
+static const
+struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
-- 
2.25.1

