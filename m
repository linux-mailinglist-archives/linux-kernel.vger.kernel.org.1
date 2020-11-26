Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01F62C5647
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390669AbgKZNnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390630AbgKZNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC0C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:33 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 1so2457454wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aby0rkFSc8Z8n2GfbnJMGwcXmsbKBW3Qw486TCADV5Q=;
        b=KS9rezDPHF4lJPHeXTEzQv//j6gJAj01Y9abTsVhXJGUNfMvvq61u2fvx8NkTyvSvz
         5PNXYeVNUVn/eLVZLLaGtU2hWozWLb2zxKeozOenCwJcRMfeqPsx6RsCqIStffOPrn8w
         UjJ/fbBDLbG5uyFaoyIx/uuero3LTMuoZbifOmkIcYB78DPAogQWaLFs9/+UyaXlpJFk
         Ywd72NT2ORdTOevBH1ID3BhUV2FDC6zfpZM4fqGkwaGyZUqGZ+62+vzUOqS6IcxppsWG
         JNFRR34u0WMmm40gsVuNbO6hOjagpyiV0yCSi1OPu4gmH9jbFk2JMSuv2mBCD9zK0Cc5
         qaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aby0rkFSc8Z8n2GfbnJMGwcXmsbKBW3Qw486TCADV5Q=;
        b=bLRg5xMEw04SMxf+t1BBm/X88ABWi0TcgodFdufUdKkmqNhTR7ptnldwiKHta1UO7p
         92MZUsLs6f7bVb3bnEkpQcAPcmuqOON8xypVtBLKC237ju9FUuw3O7wl1NP8RP7AWiWX
         RRyfssZhm994r/oj+UPcNaYxSe7s1het6xZKUO2cKc5bsW6ZHdFcc01fzhzA+YwNZ2QM
         YvRb0MERe2F6mBvs4I8r+OHWJ6PEccvI2/EHeCFbmb8Fq/1b6mqenDDLSMv6Sgq3/MFZ
         pqmk/MwuDH8/R72+wCAGUTENm3H87pzP5tz6s+5Cn7Omd3UdHFPrlYz4eClOn1bB1oRD
         dnsg==
X-Gm-Message-State: AOAM532qS9MB5SSV8PaXm0y9hcr6rO+jdpKA8mOCCVIopL1e1GkHCczE
        Q5hdVvIkv8xq0WIp3heHrZeJTA==
X-Google-Smtp-Source: ABdhPJx+oPPXlVayNH6FEyJTBRJMaO5+XGDQRElESgaYHqSQjOan4W1ec4YWsQ/Th5MN6MLEsC28Nw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr3411531wme.85.1606398211846;
        Thu, 26 Nov 2020 05:43:31 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 31/40] drm/amd/pm/powerplay/kv_dpm: Remove unused variable 'ret'
Date:   Thu, 26 Nov 2020 13:42:31 +0000
Message-Id: <20201126134240.3214176-32-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c: In function ‘kv_dpm_powergate_uvd’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c:1678:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c: In function ‘kv_dpm_powergate_vce’:
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/kv_dpm.c:1706:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index 4b3faaccecb94..66daabebee358 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -1675,14 +1675,13 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct kv_power_info *pi = kv_get_pi(adev);
-	int ret;
 
 	pi->uvd_power_gated = gate;
 
 	if (gate) {
 		/* stop the UVD block */
-		ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							     AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
 		kv_update_uvd_dpm(adev, gate);
 		if (pi->caps_uvd_pg)
 			/* power off the UVD block */
@@ -1694,8 +1693,8 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 			/* re-init the UVD block */
 		kv_update_uvd_dpm(adev, gate);
 
-		ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							     AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_UNGATE);
 	}
 }
 
@@ -1703,14 +1702,13 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct kv_power_info *pi = kv_get_pi(adev);
-	int ret;
 
 	pi->vce_power_gated = gate;
 
 	if (gate) {
 		/* stop the VCE block */
-		ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							     AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
 		kv_enable_vce_dpm(adev, false);
 		if (pi->caps_vce_pg) /* power off the VCE block */
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
@@ -1719,8 +1717,8 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerON);
 		kv_enable_vce_dpm(adev, true);
 		/* re-init the VCE block */
-		ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							     AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_UNGATE);
 	}
 }
 
-- 
2.25.1

