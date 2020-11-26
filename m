Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059C52C563F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbgKZNnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390878AbgKZNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E1C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:13 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so2468392wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldaBPFUn0rO8pzl0GTJMRaUTSpPfHm0TP7NYAeN6NJM=;
        b=GcPofYX9Qv1V/2JRRf6eBMcmKMvq/1Y31zzXUpFv5WiZOV9yJh+i6XHPOojgh//o24
         KG7wZ049wcgMys0vZlZPxdX+UUR+E7ss+DRmBqf4q8VM0UmyhYYehvLzU79YMDMvLfh4
         beMPEE0h/cHkQRbNEH+m4dUgZ+FiqFn8GubSAKi1eSTWQtQTfJxpSQXt14tg5Sx92KxE
         oewKv4hUveIzavl5EUkEqL2xkXlqMmFvlo8xkY9ps7OQrqk2IhlcI+6mYMWNRcAYqo2w
         1lvd3wlv9+U1TYKUBGDlKd+SVhhuTxlUdeWrZxDiI5sno5LOEGLXlYrmRi1Lo/VZcd48
         zD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldaBPFUn0rO8pzl0GTJMRaUTSpPfHm0TP7NYAeN6NJM=;
        b=T0AX/CSuyCJsisgxZHa00lMfX9hh732kNvL6KZW6u4WlunxnETnpdGcdqVjIl2uFAO
         ly5wvK9q9qp6qH/qg8pRw0IjdyvVbMIdrj81dAFvrr4PjFc7sYlDtONRPu5EJbeqPRpg
         HPw4TMOeEzo7EM9/NY1BTdAvThrx+m6H+DiD8DkNk8TBJEBHc9ggnDezNl3HmIz5H+h5
         v4Q0qEUurWhqOo5dr7PW1VREjdOII62DP/vr0DBnyf0yR7n35ZMHnjbx1VjkGJFnelLr
         ssjY9eZUl/uaRTaKsmL790Z6bkUGtvqYBJ+4IywAosBEESNa+46pXwQgvXnyrHPTqBK+
         ypJQ==
X-Gm-Message-State: AOAM533VPSuI9V485OZVH49z2m5U2tQWIzX+VbHJCxeJpNJHolpADdQy
        fLS4wfU6GiGSIdpV+xZBL052gA==
X-Google-Smtp-Source: ABdhPJyWKnV2DhTA2r066q2RHLN02VvLUP5QFDe1g7IHNygODIp9z4dzgpApqqaGBMVlgJ29TUexGA==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr3459206wmb.101.1606398190290;
        Thu, 26 Nov 2020 05:43:10 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Fix function header related formatting issues
Date:   Thu, 26 Nov 2020 13:42:17 +0000
Message-Id: <20201126134240.3214176-18-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:232: warning: Function parameter or member 'hwmgr' not described in 'phm_start_thermal_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: warning: Function parameter or member 'hwmgr' not described in 'phm_get_clock_info'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: warning: Function parameter or member 'state' not described in 'phm_get_clock_info'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: warning: Function parameter or member 'pclock_info' not described in 'phm_get_clock_info'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: warning: Function parameter or member 'designation' not described in 'phm_get_clock_info'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 45dde3e74b578..25b5831a15cd2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -223,11 +223,11 @@ int phm_register_irq_handlers(struct pp_hwmgr *hwmgr)
 }
 
 /**
-* Initializes the thermal controller subsystem.
-*
-* @param    pHwMgr  the address of the powerplay hardware manager.
-* @exception PP_Result_Failed if any of the paramters is NULL, otherwise the return value from the dispatcher.
-*/
+ * phm_start_thermal_controller - Initializes the thermal controller subsystem.
+ *
+ * @hwmgr:   the address of the powerplay hardware manager.
+ * Exception PP_Result_Failed if any of the paramters is NULL, otherwise the return value from the dispatcher.
+ */
 int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
@@ -371,13 +371,14 @@ int phm_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw_power_s
 
 
 /**
-* Gets Clock Info.
-*
-* @param    pHwMgr  the address of the powerplay hardware manager.
-* @param    pPowerState the address of the Power State structure.
-* @param    pClockInfo the address of PP_ClockInfo structure where the result will be returned.
-* @exception PP_Result_Failed if any of the paramters is NULL, otherwise the return value from the back-end.
-*/
+ * phm_get_clock_info
+ *
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * @state: the address of the Power State structure.
+ * @pclock_info: the address of PP_ClockInfo structure where the result will be returned.
+ * @designation: PHM performance level designation
+ * Exception PP_Result_Failed if any of the paramters is NULL, otherwise the return value from the back-end.
+ */
 int phm_get_clock_info(struct pp_hwmgr *hwmgr, const struct pp_hw_power_state *state, struct pp_clock_info *pclock_info,
 			PHM_PerformanceLevelDesignation designation)
 {
-- 
2.25.1

