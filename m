Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445AA2A9F79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgKFVu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgKFVuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:17 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so1987883wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H95rA0QKKaL3+FIhv21U45aIyhbFkd+FiaPq5zaa4zk=;
        b=ccFvN7q5RxD4CM0NZ+0NxOOG6O0PgSIXE+amCe86rCTSBZLuWX37GhNGsshfXsaMgJ
         iJ+m8coKTU8tmP8qge3HwIuTlw6dRtNHcwYQoDi0f2+qc7AJiR+nGeV09VYcqv3176Ps
         Z4rIW0Ek+Ibod01RSdTTLjdionhBuOzof//ifUqw8gtS7OVpCBHufYnY7iISAOwDON89
         8xox35G1GiJLy2sNXn3sNnHV8RbvddMWz/MEVUR8Lekn7rI/ELHoZ3UWfBQdxqeSpqyX
         4Z0EBLkLyasPaxfUW9RF1jPxDJT4MtCVhxwJV7ziZHtyfaZlgC6YN1pEUtBZ0X+ZzIJj
         +nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H95rA0QKKaL3+FIhv21U45aIyhbFkd+FiaPq5zaa4zk=;
        b=J70lxkLdGl4nuS9NLaMrC3V0tmqBTd3EuNkdcuabl1AO2N1TvXGqf4yB9759bQgyf7
         25D1rbftTKeGnxBkkAaTTtxuFsCuZjfHkGgiK3Rf8Ly/bOtY2o0YEgwjhpEgEIDGxPQK
         v/VATacvIZD8KaFoxFB91bkyGULT4wfEiSCwmJYR8aFFEQtVHaQoPJ1VrgLIMeyozhWs
         Hb67RfEoOPS8GwxSaXNbfAieSBJvC08u1Ud7RxXo/1hBvtMdfEIovbiD2Uh8E3jniiRw
         cdHpIcYf8xHnONfInvIUKWhonrFzYOWoBOldu7asvU15MEdoedkGz+z3WGiqW3lLBGC+
         q4Ag==
X-Gm-Message-State: AOAM533zvkPQ6wgS4zMgyK5nToxMKWx0uAV+y+Jfm5CTCpaLDKYqh0Un
        OBdStguKcfGs4y6DkLVTEOZ+lQ==
X-Google-Smtp-Source: ABdhPJz9AWUMB39aA8Da4lz3LdJLIZWfCG0guHXHUnmy1PklBu/Fnl293iGu8GFZZ/mVR1JdkoPY7g==
X-Received: by 2002:adf:cd0d:: with SMTP id w13mr2494726wrm.382.1604699416188;
        Fri, 06 Nov 2020 13:50:16 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/19] drm/radeon/atombios_crtc: Remove description of non-existent function param 'encoder'
Date:   Fri,  6 Nov 2020 21:49:48 +0000
Message-Id: <20201106214949.2042120-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/atombios_crtc.c:1796: warning: Excess function parameter 'encoder' description in 'radeon_get_shared_nondp_ppll'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/atombios_crtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 91811757104c0..1979ed3d65472 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -1787,7 +1787,6 @@ static int radeon_get_shared_dp_ppll(struct drm_crtc *crtc)
  * radeon_get_shared_nondp_ppll - return the PPLL used by another non-DP crtc
  *
  * @crtc: drm crtc
- * @encoder: drm encoder
  *
  * Returns the PPLL (Pixel PLL) used by another non-DP crtc/encoder which can
  * be shared (i.e., same clock).
-- 
2.25.1

