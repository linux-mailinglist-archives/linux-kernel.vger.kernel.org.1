Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064562EF8DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbhAHURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbhAHURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:08 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FD5C061245
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r7so10142401wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzX6stkngwwfosiTDTeki05QJAI1C4v60xYRYKZFrg4=;
        b=oLEvSIqHjbOXHRWvR10iZ3YSOuwgLDV8XxlXiKg1BZBYPqZduYOnq1anLUPunI6Ktf
         8Y456l+zeFwcCMIwYjpAKkYSlADDKtJEPyXd0HUhJl/GnFo7vqHUWPLWrGg5Mx0Kwrcu
         9AldNwx2QRb11OuI3fmQqIHimTBFlO7UzKXOgRt+fxrs7nTDJrRqbseDUvUTsC40x23x
         cDVegAomw3UfPKPK+Wh+wb5/mXquJVNJiygcPGvnJHub9Scfw789l4JGRSxjMSfzcNhC
         ozB+WIuMQziRzb7tiOfsBxeH8bZmY+sSgM/axuqXucL2NK/VJ2CI1KbFxMFsYyDwhDyx
         1oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzX6stkngwwfosiTDTeki05QJAI1C4v60xYRYKZFrg4=;
        b=hMcenAwpuGKDNK9BRh6RosW0i+UiVu9lEC891Yo8kYpuEaxV25GSaImC9BrVbexjK9
         24tf2kJYvrrV4W6mfPeSEKhaendSPCh5QVosMHTnR2XsjW1bvjW/0pHQn2XEarXyjKuT
         6BzhTenXLem2EMmWT1vc2A2bl1xHWbtoPblpHabEp+Dk0AjPYPRLl+kL4MqhTWfpFpnf
         IZCvTJK5Qv3xn+a7QbRU2JmGCdg/HtGZrcikrsFvY8n2sHKtTRAP1eXzncFF8eXHORiL
         O6M4t2T9yld69ufHMC7AFIUJhnkDzza5NFUogiNdWtZScDXnge9fH9tEiYQatwnx4/ih
         J1bA==
X-Gm-Message-State: AOAM533BKHvf4RMIvRfymWEnLozf1iXgLl0866ul74LRWz2eD/o5bTj4
        MHEybwd2B+FCGqDOuse1QOeoZw==
X-Google-Smtp-Source: ABdhPJxXVArT6z97egL7a+obZa961NxvdZTsF1b4s4ESkdhmF6EZ4146HfiJAVGjrUnxetUv7zq0Iw==
X-Received: by 2002:adf:d843:: with SMTP id k3mr5259529wrl.346.1610136943773;
        Fri, 08 Jan 2021 12:15:43 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/40] drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Fix worthy function headers, demote barely documented one
Date:   Fri,  8 Jan 2021 20:14:44 +0000
Message-Id: <20210108201457.3078600-28-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1556: warning: Function parameter or member 'acg_freq' not described in 'vega10_populate_single_gfx_level'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1621: warning: Function parameter or member 'current_soc_did' not described in 'vega10_populate_single_soc_level'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1621: warning: Function parameter or member 'current_vol_index' not described in 'vega10_populate_single_soc_level'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1621: warning: Excess function parameter 'current_socclk_level' description in 'vega10_populate_single_soc_level'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1757: warning: Function parameter or member 'current_mem_vid' not described in 'vega10_populate_single_memory_level'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1757: warning: Function parameter or member 'current_memclk_level' not described in 'vega10_populate_single_memory_level'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1757: warning: Function parameter or member 'current_mem_soc_vind' not described in 'vega10_populate_single_memory_level'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:2871: warning: Function parameter or member 'bitmap' not described in 'vega10_start_dpm'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index da470462d6e2c..29c99642d22d4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -1549,6 +1549,7 @@ static int vega10_populate_smc_link_levels(struct pp_hwmgr *hwmgr)
  * @hwmgr:      the address of the hardware manager
  * @gfx_clock:  the GFX clock to use to populate the structure.
  * @current_gfxclk_level:  location in PPTable for the SMC GFXCLK structure.
+ * @acg_freq:   ACG frequenty to return (MHz)
  */
 static int vega10_populate_single_gfx_level(struct pp_hwmgr *hwmgr,
 		uint32_t gfx_clock, PllSetting_t *current_gfxclk_level,
@@ -1612,7 +1613,8 @@ static int vega10_populate_single_gfx_level(struct pp_hwmgr *hwmgr,
  *
  * @hwmgr:     the address of the hardware manager.
  * @soc_clock: the SOC clock to use to populate the structure.
- * @current_socclk_level: location in PPTable for the SMC SOCCLK structure.
+ * @current_soc_did:   DFS divider to pass back to caller
+ * @current_vol_index: index of current VDD to pass back to caller
  * return:      0 on success
  */
 static int vega10_populate_single_soc_level(struct pp_hwmgr *hwmgr,
@@ -1744,7 +1746,7 @@ static void vega10_populate_vddc_soc_levels(struct pp_hwmgr *hwmgr)
 	}
 }
 
-/**
+/*
  * Populates single SMC GFXCLK structure using the provided clock.
  *
  * @hwmgr:     the address of the hardware manager.
@@ -2863,8 +2865,8 @@ static int vega10_stop_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
 /**
  * Tell SMC to enabled the supported DPMs.
  *
- * @hwmgr:  the address of the powerplay hardware manager.
- * @bitmap  bitmap for the features to enabled.
+ * @hwmgr:   the address of the powerplay hardware manager.
+ * @bitmap:  bitmap for the features to enabled.
  * return:  0 on at least one DPM is successfully enabled.
  */
 static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
-- 
2.25.1

