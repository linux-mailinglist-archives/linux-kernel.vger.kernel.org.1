Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2DB2C563D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbgKZNnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390852AbgKZNnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:09 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6229C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:07 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so2188820wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5HKCJC8iv4gibbIS6cltBxMH+DAVlqg/H12nTJ1XPY=;
        b=BdELhwgg2aXDCVPZiMApozkS+dDFnAj41prA+beMmkmtq5w/7jzoUYaN79lGhPg+b5
         Ao1NeiAYusWBvAPnbIbFxw256w0sjzeS37NG3I/ArloBXx9UsQGzPCHaZ7eq5GMUa9Hq
         xblCmIPAb04gorBKak04DKwX5Ouw95gD99jYEeYF5/t8k6AlIurKssHp9FLsnG/gfuKR
         3bHvkYd8LpUPEBgWAJLoljaerBRARKDD7Z6hdxEPL1xUgeKW/drJy7CKcIkZgzlF8b5V
         1clDkzXxjZPiHr0yHQ1cy4uKZyP94uOV98wuUeATSfrG5vyfKtu3Xud6idIgT8PSTifK
         F7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5HKCJC8iv4gibbIS6cltBxMH+DAVlqg/H12nTJ1XPY=;
        b=QZGlSx+1ggwhgCrEtK6lu77C6aDS1K9fysRfmjCHqtUCeEgVhWA7+l+49n6XdEP+dm
         0NZ3D2LCWRtu/NUq9bkvEwLBoLo6sv4MmKR6qMTBEGzU6u1useJYq4twwV//KvwmBtLu
         etsuuYhd8V1a0o/b4pdHvpCEhXn8zklaRdBd+ZskHhb259myPd+bG/grCjN0/V1TzJNg
         yMXnIDRgUy7VZb5bRXndof+b3bLlXU9Rr8a2FIjVajAOawnKBWvw0FISmrGYDb6XjkCb
         0321AztcwC964U8LKsEr7+6CWgEoHXv1f/XVXIpByk2OMGO6ePPjopIdrwhZHYqGL2//
         qF8Q==
X-Gm-Message-State: AOAM5300PZ3fkxIKANdrhKAn3XNO4OH970oVh3isy0l/0A6vtO2U5zz0
        xPQFZ4UsEXPCwFe4qo1QRyF4cA==
X-Google-Smtp-Source: ABdhPJwPA7XUfQ9Hktvglh4mawyljyRIWgMBX4yMO89KviHWcVv/KdRekllKFpPilB/5KPywm3QnNw==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr4046751wrm.159.1606398186510;
        Thu, 26 Nov 2020 05:43:06 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/40] drm/amd/pm/powerplay/hwmgr/ppatomfwctrl: Demote kernel-doc formatting abuses
Date:   Thu, 26 Nov 2020 13:42:14 +0000
Message-Id: <20201126134240.3214176-15-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:78: warning: Function parameter or member 'hwmgr' not described in 'pp_atomfwctrl_is_voltage_controlled_by_gpio_v4'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:78: warning: Function parameter or member 'voltage_type' not described in 'pp_atomfwctrl_is_voltage_controlled_by_gpio_v4'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:78: warning: Function parameter or member 'voltage_mode' not described in 'pp_atomfwctrl_is_voltage_controlled_by_gpio_v4'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:211: warning: Function parameter or member 'hwmgr' not described in 'pp_atomfwctrl_get_pp_assign_pin'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:211: warning: Function parameter or member 'pin_id' not described in 'pp_atomfwctrl_get_pp_assign_pin'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:211: warning: Function parameter or member 'gpio_pin_assignment' not described in 'pp_atomfwctrl_get_pp_assign_pin'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:232: warning: Function parameter or member 'hwmgr' not described in 'pp_atomfwctrl_enter_self_refresh'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
index 615cf2c09e54e..a47a47238e2b9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
@@ -68,11 +68,11 @@ static struct atom_voltage_objects_info_v4_1 *pp_atomfwctrl_get_voltage_info_tab
 	return (struct atom_voltage_objects_info_v4_1 *)table_address;
 }
 
-/**
-* Returns TRUE if the given voltage type is controlled by GPIO pins.
-* voltage_type is one of SET_VOLTAGE_TYPE_ASIC_VDDC, SET_VOLTAGE_TYPE_ASIC_MVDDC, SET_VOLTAGE_TYPE_ASIC_MVDDQ.
-* voltage_mode is one of ATOM_SET_VOLTAGE, ATOM_SET_VOLTAGE_PHASE
-*/
+/*
+ * Returns TRUE if the given voltage type is controlled by GPIO pins.
+ * voltage_type is one of SET_VOLTAGE_TYPE_ASIC_VDDC, SET_VOLTAGE_TYPE_ASIC_MVDDC, SET_VOLTAGE_TYPE_ASIC_MVDDQ.
+ * voltage_mode is one of ATOM_SET_VOLTAGE, ATOM_SET_VOLTAGE_PHASE
+ */
 bool pp_atomfwctrl_is_voltage_controlled_by_gpio_v4(struct pp_hwmgr *hwmgr,
 		uint8_t voltage_type, uint8_t voltage_mode)
 {
@@ -202,9 +202,9 @@ static bool pp_atomfwctrl_lookup_gpio_pin(
 	return false;
 }
 
-/**
-* Returns TRUE if the given pin id find in lookup table.
-*/
+/*
+ * Returns TRUE if the given pin id find in lookup table.
+ */
 bool pp_atomfwctrl_get_pp_assign_pin(struct pp_hwmgr *hwmgr,
 		const uint32_t pin_id,
 		struct pp_atomfwctrl_gpio_pin_assignment *gpio_pin_assignment)
@@ -224,10 +224,10 @@ bool pp_atomfwctrl_get_pp_assign_pin(struct pp_hwmgr *hwmgr,
 	return ret;
 }
 
-/**
-* Enter to SelfRefresh mode.
-* @param hwmgr
-*/
+/*
+ * Enter to SelfRefresh mode.
+ * @param hwmgr
+ */
 int pp_atomfwctrl_enter_self_refresh(struct pp_hwmgr *hwmgr)
 {
 	/* 0 - no action
-- 
2.25.1

