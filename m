Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663FB2B1CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgKMNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKMNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:46 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B5C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so9946107wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkvWdURTsPkEdVDzyHJ8FYZlYEKq+y0hj/4CtFCIFp4=;
        b=it1slg7eKp4pW5KEZ7vtYMFSfeU183JFhubZH/qEBglZ8gc2voRRHBhujz3X936q5b
         +GVVysYWqybRxo9yD89WDkhMwxfHo+LuchKiHgoHcQ2gJXPV/7HRRVeubA2tSXQLAMfG
         mC6diUMtNPUA5UQGKuOoJO6KrBaduJmWWbiEgMT+hiqY2Kw+zDp5BYifY7RIm46ASjr0
         SWkmDqmf5q9w1Tto3DKwzzdWjTRTdYhNAqyfztmrvvWgN7II9jiaKHa4vOBjygqNu3PK
         EILFa43AKAy6VL+b1aQ7cXSAeiKoyOthV07rLPzm+JcX2NASAGhGdm8fWoR7AP6OFQk+
         rkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkvWdURTsPkEdVDzyHJ8FYZlYEKq+y0hj/4CtFCIFp4=;
        b=awkNdjhIArGwdYkpRDv12D9kbxKAjuWI1Nu3ubiFXA7MMhIKiN44lht5u8xNGPv/JH
         Qf6bV6VrbeUdi4XyaJcPIwAXKBg3jjynp9C3lHb9az22Wbx6r8O1mcJ0ZER9ymFGeFXd
         zNZQFjyFSZVeQ9UzC2sLSRZ1oCZe4tlWXlfABHyZLBhN+YwKZbzrwYV6yHVFNeJHe7HZ
         dS7TRK2ORXcMMQec92gOd3Aah13/CjE+m2016h+JdXydbjLHkQZjTZ4kXTNEE7NEYAOb
         +vqgPvbry+C3d5kYL8dQB3dMuwvQPM4JuhIqjQ9E88i2J0VAgWbkpgbBp/3icR63l9nF
         7FVA==
X-Gm-Message-State: AOAM530aurLB4VzfcykrYEdOabroJPsfZe9UFlyXjrv+6JG0CqQsfWRK
        11FSa8QOLH4wtO32KaiexFV7jg==
X-Google-Smtp-Source: ABdhPJxnNPMHkiRv4CvlSdVHRyP+EPDWdkVMC26JII0l+dTlSjh9rvGeHvEsOFiDMueCPHdGDTu2Bg==
X-Received: by 2002:adf:f852:: with SMTP id d18mr3463400wrq.232.1605275385374;
        Fri, 13 Nov 2020 05:49:45 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:44 -0800 (PST)
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
Subject: [PATCH 02/40] drm/amd/display/dc/core/dc_link_dp: Move DP_VGA_LVDS_CONVERTER_ID_{2,3} to where they're used
Date:   Fri, 13 Nov 2020 13:49:00 +0000
Message-Id: <20201113134938.4004947-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes >200 warnings.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: ‘DP_VGA_LVDS_CONVERTER_ID_3’ defined but not used [-Wunused-const-variable=]
 123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: ‘DP_VGA_LVDS_CONVERTER_ID_2’ defined but not used [-Wunused-const-variable=]
 121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";

NB: Repeated ~100 times - snipped for brevity

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
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c        | 5 +++++
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6c60c1fdebdc1..f2023d2b53234 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -15,6 +15,11 @@
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
 
+/*Travis*/
+static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
+/*Nutmeg*/
+static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
+
 #define DC_LOGGER \
 	link->ctx->logger
 #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index c9be899cd25cd..b453ce5a9bfdb 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -117,10 +117,6 @@ struct av_sync_data {
 	uint8_t aud_del_ins3;/* DPCD 0002Dh */
 };
 
-/*Travis*/
-static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
-/*Nutmeg*/
-static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 /*DP to Dual link DVI converter*/
 static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
 static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
-- 
2.25.1

