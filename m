Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2D2C5638
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390826AbgKZNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390803AbgKZNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:01 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D3C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:01 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so2210661wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gri5Q1ZsHo+JoBxGfrJZZW9SZIInF5/xkJvef28TzCQ=;
        b=fqPPgyNW5YpmOSE71xHIKuvM+xg9IUILLUjRvO1hWX8/333x8W4QT67NPv+C8bozIy
         tFMqF9icDS0zvyTYZgWA/m1fP0mCA7OTmHoUE2MDnIiXC9C3s2c+eDGlVzXLXwjGsVe+
         IDFwppI5i0UFrRo0NZjZ70MKdLrBCl7IB8cqFEMoqacGdKqEUpy4PeNmvBdiVrp/5mXA
         AyPY1L3++JBVT/rTM+8v2z9lupnMBLt5Y+1T1592dGIa4JCSyREVc8Nf1t1JHL7NPbfL
         8xYftyKeq7YlGfWS2xkpEPVttx7SNLBqIcMnMACyPyTAB1kpH27piWLOWJ+DylNcrA9Q
         K0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gri5Q1ZsHo+JoBxGfrJZZW9SZIInF5/xkJvef28TzCQ=;
        b=Jm1L1Y+QArADfDXdZwhykuI4o6dxFwBUy5p7S5C0k8sauF3FlStjNfi9Gilgn9hIUO
         cZcHbPTTbvJQCxH2jlSb+owa4f9UeDCCTAu4gc4zfQwgs/pQmNOX8kqFy0HVKcw0jCyy
         GxwETW3CWxj6p/P/hkgE/D8NKOfkOC9AXcxxN+s3KazSVQ3G+lSUKSKkyeXwlkzAnfGI
         bd+WRJA/nCaveD73lQfbcCwNkLaLNA0KTGl4CbdcMPAXNPzG+f/rxhQL2nSNyY+ZPFn6
         gxqznaXfouOQmpLJldh+zV8TmeY3MtB+2A/QeFlTStT0YwU2X26jCFiyBNr5L3eUUGUi
         +LZw==
X-Gm-Message-State: AOAM531TYXdvPbQstPAYEJT0dEGGfv73Ylp6P4brl+aJgWGcAP4MkfPX
        POKUAmkBAV5tQ0Z8UJ4DYkfFIQ==
X-Google-Smtp-Source: ABdhPJxpsMWiO7wJ6aWp2ZBnURciNFJyzaYsTRXTQCiK/i14aN+DP5ZoGSNsIGmzdHfSZtoU5ZxP3g==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr3493478wmj.169.1606398177946;
        Thu, 26 Nov 2020 05:42:57 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move 'smu8_init_function_pointers()' prototype to shared header
Date:   Thu, 26 Nov 2020 13:42:09 +0000
Message-Id: <20201126134240.3214176-10-lee.jones@linaro.org>
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
index 1bb379498a121..0e22cba3ce3a6 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -828,5 +828,6 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
 
 #define PHM_ENTIRE_REGISTER_MASK 0xFFFFFFFFU
 
+int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
 
 #endif /* _HWMGR_H_ */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 739e215ec8b7f..ec17a3e63ea02 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -47,7 +47,6 @@ extern const struct pp_smumgr_func smu10_smu_funcs;
 extern const struct pp_smumgr_func vega20_smu_funcs;
 
 extern int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
-extern int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
 extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
-- 
2.25.1

