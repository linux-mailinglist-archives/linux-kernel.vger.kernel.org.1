Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD182C5645
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbgKZNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390692AbgKZNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:27 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EEFC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so2447659wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHee2zrW6mojQNSNJ9XRSA5F6LyijJ6hVMNlAaUjhbE=;
        b=GEo2EsStv13X9m/Tsj4m2jpkSmdMGO2t7vaRwB28WuHahv54Zru6Pq30ubqib2P4Wo
         ACkQZ7JrvpNLHUTv7oTvmgoVXkEwYckfsZQspiFUVlp0XajeT9CoQQt5Pbjf5EwuEN6D
         RlYoNlJrzOwYqErn8RfUXGMijS+BwjtOgRMnpYRx++o5YM0H4367xMtK7gzs82IAyos5
         iQrBA233rIoyolzxOWOhFFUdnZ47L8NZq895xrRKd/hnWU6S8SAmr3Z2aFFCOAD2/Q/A
         iIGzRYPc2j1MBqeQwJD72uHh7Zlv5BPbVr/AwjD8oNGEh+cgL9os1KYP2ICPL66LEMrc
         4jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHee2zrW6mojQNSNJ9XRSA5F6LyijJ6hVMNlAaUjhbE=;
        b=OkKsqA/OKJFZGnLFFQMYX8E35Q8sDcIv924fTfNVR7CKeOTifBHlPAOnRysv8raduf
         7AARHjw9aPEbh5YD2dJNjJ2/8SBK82MSEEnfdaEyvp7PFbC41TxXzELl3jw12pr2vLkm
         4DGLtKB3l0lwXyvhLqV/KyDAta9g9mMEVNLszQoQkPjbPFkBLZlHY0/flNPUq3ZCf9vq
         2HkJKYvuqHVo4+3G3pqqlFhhfALJbVKJHgHzznVnoawoEngxOe1sXpQToEaGtAaSfkvt
         2JOsinPYHdtqeF5TIzvlnOQwcykmp42Pdnxxi62kHGbYTswFvIDnAX+EwZcptA/Z8bPV
         XaNA==
X-Gm-Message-State: AOAM53075+P0Kt+Yb7SoKzkNFjw23v9XhKmLb+vCeheIs3e1823zODvI
        xdHMxH1P6HtnQPcytzSsaKTgGA==
X-Google-Smtp-Source: ABdhPJwOzBBTRMO7WP0ysMWvIabKZC+xxjI7fVXfadOJXA6vj4A5CKQkykoxeUt0RuUbHttopPbOHw==
X-Received: by 2002:a1c:2001:: with SMTP id g1mr3488686wmg.179.1606398205360;
        Thu, 26 Nov 2020 05:43:25 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move 'vega20_hwmgr_init()'s prototype to shared header
Date:   Thu, 26 Nov 2020 13:42:27 +0000
Message-Id: <20201126134240.3214176-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c:4403:5: warning: no previous prototype for ‘vega20_hwmgr_init’ [-Wmissing-prototypes]
 4403 | int vega20_hwmgr_init(struct pp_hwmgr *hwmgr)
 | ^~~~~~~~~~~~~~~~~

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h             | 1 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 499f2520b1aa3..490371bd25201 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -831,5 +831,6 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
 int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
 int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
 int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
+int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
 
 #endif /* _HWMGR_H_ */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 49f8a331eb02e..6a7de8b898faf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -47,7 +47,6 @@ extern const struct pp_smumgr_func smu10_smu_funcs;
 extern const struct pp_smumgr_func vega20_smu_funcs;
 
 extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
-extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int smu10_init_function_pointers(struct pp_hwmgr *hwmgr);
 
 static int polaris_set_asic_special_caps(struct pp_hwmgr *hwmgr);
-- 
2.25.1

