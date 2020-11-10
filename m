Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520E62ADF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgKJTcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbgKJTbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DAC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:48 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so13992083wrf.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Sm/diM1ysLxo1VzfvufUrkgqFPpDL8/DuxdgOjGpqk=;
        b=CZrD24nhvG2iKoj4noUsAlrwucBSgxTDbkGLYlEEUgSDr2Zy+HeJpNOHnLGyxd2YyB
         ZJQ6UXdgUfIMAhCAJ024R0H2Way6kwLlIHcQePC+l7iMTF0CV6X8kZDDmPGuaemhUSp8
         800pFOG3yycgu2nI36yUiLjHgtWG5tpiOGBqQpcARNijHSmCokrGz9nmDIu6zJ6tg/z5
         FCRP6rRBQCoRr3UUGixrgmzUVA8rkV0jAqYjmFjNigFQNMg0VIghzCyxk1PB5/rtlmmL
         wo5Jr7Q/LM8kPqSrNKHMXufrbqKBkDSEpL7HRj0P0JoHjIVks/WOc6vhahHnS895KRw/
         wI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Sm/diM1ysLxo1VzfvufUrkgqFPpDL8/DuxdgOjGpqk=;
        b=XfxZOOhIcHeENNdjLFA8/dq5tcdP4nYlTDtsRiZNaydJNmFRLymSc9ob3UOerIjeg3
         uoauID2nt+zmGaqEIrnqXYrxdR4//roiB4NAWmsuTBK4BzktmlX1fVVa5pV1zKLg+xZl
         tSSifyssqY3KEEhqV7GwQk/+NVT6UNQr+CN0QcA6a3wXzeanLCkfJ0gQx5nuyNiyGPK7
         CAyDQGO3JnEFfaftkUvsKRhVzBPBl2urlBpq03Rv8V4yojFYgXZk60IsCczHFGj4+TzK
         USt47q5KjeCgS8wVuLp87QOVurRZm09DS2XmoeNP4dxmq69ERGqjGVIUGxL3johabb0f
         YyRg==
X-Gm-Message-State: AOAM530T0BIAGBp1H7bc+wLOm0DiBEiZmutLxOfWZQGYqfl0jMxIIDxv
        5CqGx+rhOHv+TkwuhTcP32+D8A==
X-Google-Smtp-Source: ABdhPJydisdr0J37dZbJ7k4ipfoX1H7RQuZ8b5877kgvFGHpkWN/RL5fEew9s8dnutPJ9wQPzCIbdQ==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr8139860wrs.170.1605036707394;
        Tue, 10 Nov 2020 11:31:47 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 25/30] drm/radeon/sumo_dpm: Move 'sumo_get_pi()'s prototype into shared header
Date:   Tue, 10 Nov 2020 19:31:07 +0000
Message-Id: <20201110193112.988999-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/sumo_dpm.c:81:25: warning: no previous prototype for ‘sumo_get_pi’ [-Wmissing-prototypes]
 81 | struct sumo_power_info *sumo_get_pi(struct radeon_device *rdev)
 | ^~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/sumo_dpm.h | 1 +
 drivers/gpu/drm/radeon/sumo_smc.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/sumo_dpm.h b/drivers/gpu/drm/radeon/sumo_dpm.h
index f1651135a47ab..db29d37ae2703 100644
--- a/drivers/gpu/drm/radeon/sumo_dpm.h
+++ b/drivers/gpu/drm/radeon/sumo_dpm.h
@@ -207,6 +207,7 @@ u32 sumo_get_sleep_divider_from_id(u32 id);
 u32 sumo_get_sleep_divider_id_from_clock(struct radeon_device *rdev,
 					 u32 sclk,
 					 u32 min_sclk_in_sr);
+struct sumo_power_info *sumo_get_pi(struct radeon_device *rdev);
 
 /* sumo_smc.c */
 void sumo_initialize_m3_arb(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/sumo_smc.c b/drivers/gpu/drm/radeon/sumo_smc.c
index d781407057366..78d8716067318 100644
--- a/drivers/gpu/drm/radeon/sumo_smc.c
+++ b/drivers/gpu/drm/radeon/sumo_smc.c
@@ -30,8 +30,6 @@
 #define SUMO_SMU_SERVICE_ROUTINE_ALTVDDNB_NOTIFY  27
 #define SUMO_SMU_SERVICE_ROUTINE_GFX_SRV_ID_20  20
 
-struct sumo_power_info *sumo_get_pi(struct radeon_device *rdev);
-
 static void sumo_send_msg_to_smu(struct radeon_device *rdev, u32 id)
 {
 	u32 gfx_int_req;
-- 
2.25.1

