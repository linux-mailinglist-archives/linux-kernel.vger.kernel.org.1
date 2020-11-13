Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3012B1CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKMNxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgKMNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so8200252wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/8viFdCzNWHnSXDW2EunFyaI/d41Skp7gtV6qeYb0o=;
        b=y+C8gxmn2CgNAthyNMnIAqnLUwLH4naZTgbJSpTdoD73gKQFGYgWDnZ8/pu87+N3My
         3Z5QYUXjogsA6are0/qHHGs4Pm0ky8IDgD4q2wVolPvVk9/7del+06HVnzXbYLOsHnUa
         y0utOgFt23KAzeKXkP+hksNHB1PME8rQ5hy5mBy5L9BcrtbzhrfoNl5TFsuG+eSAP9Bk
         Y5grD862KHbiX5jvyYjwoXCt6Ebdc45fMNWMs9Cv+wBzoQ/OmOEU+mdYUzLj8waneUZk
         8IyfzinwFH/5AyA44qCDXcQd9ew9kVyAGMfWkII3O5JuO9AJhBbU+lB/6BZ2oXTa2IfF
         ohFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/8viFdCzNWHnSXDW2EunFyaI/d41Skp7gtV6qeYb0o=;
        b=bdbqxvtfOL7Ge25MjmR1lhiFddm178T7zeiqVmYcZZ1wA6SZdJPyDtIhqlpPWKOjsD
         5bURG6/Y5kfyo9XOfsbw8bh4rt//veNMwpOO1SMUoM318rHbUpSk4E7IeKL2wG2andkz
         RzxRhNH0Y6+3Cvc/EfIvgQciKtYC0t8tZ1X4IZiAzamXtktIBbfs1IrV7gwdpFJl/Ja+
         K4DNurv9qBtLiN72STJhnqUDg/QoO8SmNUvB4RWRw81TSsj6hyEiB/ueC5mR6M416FHK
         XOiFwtLhovTYUIT+6fBWI52SR0i0NKJLu/9U3du4+uXtq4m5iR/qKf/9fjQcfQnbo+3H
         H9KQ==
X-Gm-Message-State: AOAM531uc6lDgPqv85VKaC1wKfvaFC4yakzW5IJHTrubJViI2/PKgO+1
        +o8fsyFm8tsUMhQroBhlc9HKOQ==
X-Google-Smtp-Source: ABdhPJwrqmZ4GNbkeACVm1/vQC7L1XX7aXP5n5VW3GuHBkUyDAqenITmqVUTAfPhLM0Fyok02x3AOw==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr2652810wmo.59.1605275386536;
        Fri, 13 Nov 2020 05:49:46 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:45 -0800 (PST)
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
Subject: [PATCH 03/40] drm/amd/display/dc/core/dc_link_ddc: Move DP_DVI_CONVERTER_ID_{4,5} to where they're used
Date:   Fri, 13 Nov 2020 13:49:01 +0000
Message-Id: <20201113134938.4004947-4-lee.jones@linaro.org>
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

 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:31:
 drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: ‘DP_DVI_CONVERTER_ID_5’ defined but not used [-Wunused-const-variable=]
 126 | static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
 | ^~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: ‘DP_DVI_CONVERTER_ID_4’ defined but not used [-Wunused-const-variable=]
 125 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
 | ^~~~~~~~~~~~~~~~~~~~~

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
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c       | 4 ++++
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 54beda4d4e85d..c5936e0643606 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -37,6 +37,10 @@
 #include "dc_link_ddc.h"
 #include "dce/dce_aux.h"
 
+/*DP to Dual link DVI converter*/
+static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
+static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
+
 #define AUX_POWER_UP_WA_DELAY 500
 #define I2C_OVER_AUX_DEFER_WA_DELAY 70
 #define I2C_OVER_AUX_DEFER_WA_DELAY_1MS 1
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index b453ce5a9bfdb..4de59b66bb1a3 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -117,8 +117,4 @@ struct av_sync_data {
 	uint8_t aud_del_ins3;/* DPCD 0002Dh */
 };
 
-/*DP to Dual link DVI converter*/
-static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
-static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
-
 #endif /* __DAL_DDC_SERVICE_TYPES_H__ */
-- 
2.25.1

