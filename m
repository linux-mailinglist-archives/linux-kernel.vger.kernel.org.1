Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724622EF8F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbhAHUTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbhAHUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B18C0612A7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q75so9453625wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4SPpSIEaIrZDfJcedbk8KPV+52H3SX44Cb4d3Gm68s=;
        b=k7hMmuN9Mb+20/4OO7wQuc1oKHtEPsh/19e+lUDbPYvmWJu/srmWM995pmehzaT1Nt
         ng+E2Mkj79EDdVAn6pxmRY36XYlU15z00rRXqJsXSGOgkEI2km/GkIE1xJUqPHf2TF2n
         mX90IH/olI2G7GcXXszjf7zSuhid43l7s0KKKFO92GGL4LmtgDn8yS3tn5xNAcqG9BQU
         B08ApRr5fNmTgp8gxDyf3n8qWDXBIp1pmHBUv7s6ICuqnPOSsSxxJb0yGvYmA84qXuGP
         JQuKUN4IrFvyrkCI8n0O90r2WgluMSsVuRVWSyMmle7TrSzhSUdGEhT+URBE3mZyj7r+
         YM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4SPpSIEaIrZDfJcedbk8KPV+52H3SX44Cb4d3Gm68s=;
        b=pcsanGj4iysknLVtnTDGQK/dZFhOyuro13zjDnA7TPqGaWqLeoK1e/j+NoDyWhq0BL
         2g10VOkCyMVevEFKyMXC9owj5kYX6sVpQ/X/h8C5WaehdSGu1RprET1HNtxq1w7Zp5Wu
         gRNMgawSNkxDHGpg8imWotdWn+CvlBf8f88UWKumj+0cXWLcG9u9nZz5WAaiTENDP+6Z
         CqeSQ3st/suw0pJ4rir5x4ezOxjh0G4NnCxAxV2IXsZ7ySF7y7LyXD+zY8qEIs6huroy
         G8BIef46CyTduiQPUs0vQbt3sIpBbSCde2X2A2Xp/OHW9cizsYLfe/OLRFMyNUtm0f33
         U09w==
X-Gm-Message-State: AOAM531W2E9IycjC4413hNKn7Cmv9NoL4E1/WgmVshJT+ewEFL8j5kuG
        MM5LVb+6KxOxQPjkMW2tOpULrQ==
X-Google-Smtp-Source: ABdhPJzV759FP44vxnGcXlBzVi2i/a5jpPiEkWCUxJ6icXlO23FXxSjFXcyMHwGRNCEllrCD5gooQQ==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr4501753wmi.91.1610136919275;
        Fri, 08 Jan 2021 12:15:19 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move prototype into shared header
Date:   Fri,  8 Jan 2021 20:14:28 +0000
Message-Id: <20210108201457.3078600-12-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:5474:5: warning: no previous prototype for ‘vega10_hwmgr_init’ [-Wmissing-prototypes]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c        | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 6a7de8b898faf..f2cef0930aa96 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -33,6 +33,7 @@
 #include "ppsmc.h"
 #include "amd_acpi.h"
 #include "pp_psm.h"
+#include "vega10_hwmgr.h"
 
 extern const struct pp_smumgr_func ci_smu_funcs;
 extern const struct pp_smumgr_func smu8_smu_funcs;
@@ -46,7 +47,6 @@ extern const struct pp_smumgr_func vega12_smu_funcs;
 extern const struct pp_smumgr_func smu10_smu_funcs;
 extern const struct pp_smumgr_func vega20_smu_funcs;
 
-extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
 extern int smu10_init_function_pointers(struct pp_hwmgr *hwmgr);
 
 static int polaris_set_asic_special_caps(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
index f752b4ad0c8ae..07c06f8c90b09 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
@@ -442,5 +442,6 @@ int vega10_update_uvd_dpm(struct pp_hwmgr *hwmgr, bool bgate);
 int vega10_update_samu_dpm(struct pp_hwmgr *hwmgr, bool bgate);
 int vega10_update_acp_dpm(struct pp_hwmgr *hwmgr, bool bgate);
 int vega10_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable);
+int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
 
 #endif /* _VEGA10_HWMGR_H_ */
-- 
2.25.1

