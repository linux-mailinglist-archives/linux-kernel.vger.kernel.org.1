Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70372C560A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbgKZNmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390234AbgKZNmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1FC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so2213494wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyYJASeUbOt9Oc/Vofw1C6Y2+olsU2h1O7WPPXgsjDg=;
        b=xos3Z235V+VsqrBuBxOR03HMkZts5GlDVhKuNYxI9eBaJOP4w0ktVn+uMzH1tBWjfk
         byRyaOCDL1JFpJGS8bPQ3Gi6wNGWUzMFVyKehbMjLq4XZbqs0e6Vm283fuy449VUhHzq
         uabcAfhlVvxLBGKuT0/noqU+UrE4hDCD5pYzsf2zGRAsSLuMznc4lmRy/MobItxFEMZ+
         c1yY6TvwQIkDcdCBuzNLnwbBm8Jafkhc2/BZcHMSVM+q8ReotyLF/vK9d2kPxvHNr41B
         N1ShZuoFxfdbMqOlyNx1t5DBsHrpLTTri54fYcWjr8GYnNnmxXQKBiip9id1VtEJySel
         XTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyYJASeUbOt9Oc/Vofw1C6Y2+olsU2h1O7WPPXgsjDg=;
        b=bhhSyb0LFZWYyiHjY9tPvG3UKJVFHpuGUGAwfxFvaKYL6mBNT3mMUt3xqQZah0ADeW
         2MtbOZD0grp+o8Ts0c4oRDdnW4eX44szAB+TpwYSb/N+YeCYCS8+5aus/5u0GfRwUm2H
         1XZCOZLhttuaKdWkbz2yd6oEM7V3YzuPUZp4b1k7x2PKMju3eHLNez+ZuNAASq4bQOpD
         tL6QP+qKJXaUaSjpFk8SAsF14Co7hfFAx9+gV+L1dF62Y+ZzgIWAL7zNWtRk21+43ywM
         CganPEBvDLVX+CeHla0YjWXBAUCDom0Ufj8c2CfMB/YEEiUlmVVMBNx3WacVj+2/oZZz
         Myhg==
X-Gm-Message-State: AOAM533eoQL50YradCAcFevAO+IZyoUAK2nTlLrVxT8jh6vvJu2SQf+s
        mGkHDvSVsPndbc+/qD91MXcwL1zX3G5PrVxe
X-Google-Smtp-Source: ABdhPJwy6UGg9LWLcuVO0V63+GZDcQf59k1mdkCRNCVnWDHjZvtq7Sh+KlwnjDdTmVs25uuCwWBEUA==
X-Received: by 2002:adf:902d:: with SMTP id h42mr3878260wrh.175.1606398169992;
        Thu, 26 Nov 2020 05:42:49 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amd/pm/powerplay/smumgr/iceland_smumgr: Make function called by reference static
Date:   Thu, 26 Nov 2020 13:42:04 +0000
Message-Id: <20201126134240.3214176-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c:2085:5: warning: no previous prototype for ‘iceland_thermal_setup_fan_table’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c: In function ‘iceland_thermal_setup_fan_table’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c:2093:6: warning: variable ‘res’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Huang Rui <ray.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 431ad2fd38df1..6a0f581de999b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2082,7 +2082,7 @@ static int iceland_init_smc_table(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-int iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
+static int iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_smumgr *smu7_data = (struct smu7_smumgr *)(hwmgr->smu_backend);
 	SMU71_Discrete_FanTable fan_table = { FDO_MODE_HARDWARE };
-- 
2.25.1

