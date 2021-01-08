Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95832EF8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbhAHUTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbhAHUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A950EC0612A5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c133so8745054wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4m+UfJ8aX5WLjKwBG1Xu8sQ5BNsQhd/cnOc6646uVLM=;
        b=xLshuzqR1S5leuYqYt+i5O0pzH6SK7237sKx76ydZAZ12/sCmWGMaKpZAn5ORm5VxA
         b7AM62dLqUYFa3QkxepEi2Glma4JBkROyGwMzVvdYsXkkMaw3Sgda6nSa6R/FaF31Dpm
         ZiX7Q7jWTDA32xLpGC0RqCfHNihxlDNszP5NaU/LTHZ0sULnT8MXDlKC4miJYJIs4C3X
         7UFv+/hFIZWuQxni+OkJp+bCWx2MOgrkuvoeByqrNPXePBhFcRcz6Mix2yTuGTBFwC9f
         jIbx6kAGiVERht+t17b65sHTRyNoCN2dT3DF3NTdbtSk17MqvxIcY2afNbxf8gFeFwwY
         YJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4m+UfJ8aX5WLjKwBG1Xu8sQ5BNsQhd/cnOc6646uVLM=;
        b=f9Q07JHsWUgNQZv+AfuH3dOXas4Oh4Oiw/cxvL8t4zVrHnjNCxZIWxrRCvOq1h+a61
         u13MP/fb4Yy2TO7rfxsJX4bGApUbLVtASj2NGBubx9RtqGtZaIw1w3+I7l+dnkUUPuXZ
         6v7xLOqsN9GbpueT/sk5bsMiv8AjUr+Z+s4sjTHSQdsr7WKRJMHLHJ6oE8ATO3gt1m1U
         YNWJtTO4ThxPalswpZkvb3FCrqZWvJIXhXH/Ue9UfGGUJ0PM/rrJnLqwmnRY6MbgAG5S
         plD/S4lzW7EDs+JQiLovWHhIGUrMurGfb9Kv2HWl93Rm0hVgsA2GgfdAqcyWANjVzPUj
         e2vA==
X-Gm-Message-State: AOAM530FMTZAzpOMMNn1EJ3Ly+N/88FlQbTwnzjB+dVoH4NmIFeDMjcV
        vx7O3HB/jY9X9i0+liiqOjNiO73R6LCUtDRm
X-Google-Smtp-Source: ABdhPJzzFAJVmK21o2vqWktdG8/jT/HrmCYeMykde37kQ//uOudXLb2wVW4KTK+B7j9Unkk/ciS3Lg==
X-Received: by 2002:a05:600c:313:: with SMTP id q19mr4477223wmd.126.1610136916383;
        Fri, 08 Jan 2021 12:15:16 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/40] drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Fix legacy function header formatting
Date:   Fri,  8 Jan 2021 20:14:26 +0000
Message-Id: <20210108201457.3078600-10-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c:781: warning: Function parameter or member 'hwmgr' not described in 'vega20_init_smc_table'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index da84012b7fd51..87811b005b85f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -771,12 +771,11 @@ static int vega20_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Initializes the SMC table and uploads it
-*
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    pInput  the pointer to input data (PowerState)
-* @return   always 0
-*/
+ * Initializes the SMC table and uploads it
+ *
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * return:  always 0
+ */
 static int vega20_init_smc_table(struct pp_hwmgr *hwmgr)
 {
 	int result;
-- 
2.25.1

