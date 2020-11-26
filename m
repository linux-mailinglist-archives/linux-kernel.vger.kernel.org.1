Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667612C5658
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbgKZNom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390880AbgKZNnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D34C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so2174575wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJ48BnAFuIYXRbLOjlTsHmoQNdzeeMH8+iEVcNp9LRw=;
        b=irhFLR+D7PHiZmn27CayKxpHC+pspRcPPxBdS39NIWI1a1AtvgPFGv1+GKKx7263iY
         OF6nv8G3JtBO5NxqtncSSzSt0O5Kxp54ywhxmA/qVsGyeNSpdfYQyURlg8Dll8XkVSuh
         0GTu5Ok7Oll9qvpzpd+tL20UWO0nKxHiBJv9lGLVykcWC73tOgo4PbxN0U5XVazzA6KD
         2TzPexCvYD2WiKh84ClrArAA8ixmghure9qvs8p6u/f+XIEVoBZwhRrl0PZnwO/RcbmE
         vO4xFDL7xwqjciD/I8NYHJ+PcUhxtnQbH3HtpfRiLn595SDbPYOnYvBQYqgx/b7nZh5w
         hHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJ48BnAFuIYXRbLOjlTsHmoQNdzeeMH8+iEVcNp9LRw=;
        b=EpGnsTv4P9CbJ2xLERQV4bq2CmpmQwqzU9+/kskRFS5XKE+Jn+Pg3Sg3VwwoJsYmDj
         fRBoFnMr1dGzvtrURzHPLtawZYB2tgHgoKxoLBA0xJ4N5MlQRSjxWELoi6UetRk5/+cT
         Q0nHJlXYcJihlUUH15M8c7KJR1JJDjd2JdRqp21WgvRsNLQAd7/xydCQqx6f00mOcPLg
         T0esoW/5pR6poBvKKymovpT17MUwOIVtkDWlU9vsXYnupPzcpGoonbseRHvBaD85Uf2b
         Pzn3ikHZL5JOc0zs4l2TGaZ0PXVNU9r0CLDlSHXh/S4khDnHqf3hQYqB9+OiAeX4nlGv
         lmVg==
X-Gm-Message-State: AOAM5319/j3vbaxhujE/ndMYEKDejBZfY7++xiSCfX6i9cHROpuhIDBa
        Ok531ODsAnFPpxRUmIhrRfZa4Q==
X-Google-Smtp-Source: ABdhPJyBWPP7GLsGLVwS/IL9jApgh75kjijq4JKQlg1qMhleCsPjU6MQ3Ci3aAZZpO3cFw+MWjErbA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr4051594wrp.72.1606398193594;
        Thu, 26 Nov 2020 05:43:13 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/40] drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0: Convert to proper kernel-doc format
Date:   Thu, 26 Nov 2020 13:42:18 +0000
Message-Id: <20201126134240.3214176-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:41: warning: Function parameter or member 'hwmgr' not described in 'set_hw_cap'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:41: warning: Function parameter or member 'setIt' not described in 'set_hw_cap'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:41: warning: Function parameter or member 'cap' not described in 'set_hw_cap'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:56: warning: Function parameter or member 'hwmgr' not described in 'set_platform_caps'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:56: warning: Function parameter or member 'powerplay_caps' not described in 'set_platform_caps'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:135: warning: Function parameter or member 'hwmgr' not described in 'get_powerplay_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:202: warning: Function parameter or member 'hwmgr' not described in 'get_platform_power_management_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:202: warning: Function parameter or member 'atom_ppm_table' not described in 'get_platform_power_management_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:246: warning: Function parameter or member 'hwmgr' not described in 'init_dpm_2_parameters'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:246: warning: Function parameter or member 'powerplay_table' not described in 'init_dpm_2_parameters'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:791: warning: Function parameter or member 'hwmgr' not described in 'init_clock_voltage_dependency'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:791: warning: Function parameter or member 'powerplay_table' not described in 'init_clock_voltage_dependency'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:911: warning: Function parameter or member 'hwmgr' not described in 'init_thermal_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:911: warning: Function parameter or member 'powerplay_table' not described in 'init_thermal_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1121: warning: Function parameter or member 'hwmgr' not described in 'check_powerplay_tables'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1121: warning: Function parameter or member 'powerplay_table' not described in 'check_powerplay_tables'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1263: warning: Function parameter or member 'hwmgr' not described in 'make_classification_flags'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1263: warning: Function parameter or member 'classification' not described in 'make_classification_flags'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1263: warning: Function parameter or member 'classification2' not described in 'make_classification_flags'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1370: warning: Function parameter or member 'hwmgr' not described in 'get_powerplay_table_entry_v1_0'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1370: warning: Function parameter or member 'entry_index' not described in 'get_powerplay_table_entry_v1_0'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1370: warning: Function parameter or member 'power_state' not described in 'get_powerplay_table_entry_v1_0'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:1370: warning: Function parameter or member 'call_back_func' not described in 'get_powerplay_table_entry_v1_0'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 81 ++++++++++---------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 801a565026703..741e03ad5311f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -32,10 +32,10 @@
 #include "pptable_v1_0.h"
 
 /**
- * Private Function used during initialization.
- * @param hwmgr Pointer to the hardware manager.
- * @param setIt A flag indication if the capability should be set (TRUE) or reset (FALSE).
- * @param cap Which capability to set/reset.
+ * set_hw_cap - Private Function used during initialization.
+ * @hwmgr: Pointer to the hardware manager.
+ * @setIt: A flag indication if the capability should be set (TRUE) or reset (FALSE).
+ * @cap: Which capability to set/reset.
  */
 static void set_hw_cap(struct pp_hwmgr *hwmgr, bool setIt, enum phm_platform_caps cap)
 {
@@ -47,10 +47,10 @@ static void set_hw_cap(struct pp_hwmgr *hwmgr, bool setIt, enum phm_platform_cap
 
 
 /**
- * Private Function used during initialization.
- * @param hwmgr Pointer to the hardware manager.
- * @param powerplay_caps the bit array (from BIOS) of capability bits.
- * @exception the current implementation always returns 1.
+ * set_platform_caps - Private Function used during initialization.
+ * @hwmgr: Pointer to the hardware manager.
+ * @powerplay_caps: the bit array (from BIOS) of capability bits.
+ * Exception:  the current implementation always returns 1.
  */
 static int set_platform_caps(struct pp_hwmgr *hwmgr, uint32_t powerplay_caps)
 {
@@ -128,7 +128,7 @@ static int set_platform_caps(struct pp_hwmgr *hwmgr, uint32_t powerplay_caps)
 	return 0;
 }
 
-/**
+/*
  * Private Function to get the PowerPlay Table Address.
  */
 static const void *get_powerplay_table(struct pp_hwmgr *hwmgr)
@@ -191,10 +191,10 @@ static int get_vddc_lookup_table(
 }
 
 /**
- * Private Function used during initialization.
+ * get_platform_power_management_table - Private Function used during initialization.
  * Initialize Platform Power Management Parameter table
- * @param hwmgr Pointer to the hardware manager.
- * @param atom_ppm_table Pointer to PPM table in VBIOS
+ * @hwmgr: Pointer to the hardware manager.
+ * @atom_ppm_table: Pointer to PPM table in VBIOS
  */
 static int get_platform_power_management_table(
 		struct pp_hwmgr *hwmgr,
@@ -234,10 +234,10 @@ static int get_platform_power_management_table(
 }
 
 /**
- * Private Function used during initialization.
+ * init_dpm_2_parameters - Private Function used during initialization.
  * Initialize TDP limits for DPM2
- * @param hwmgr Pointer to the hardware manager.
- * @param powerplay_table Pointer to the PowerPlay Table.
+ * @hwmgr: Pointer to the hardware manager.
+ * @powerplay_table: Pointer to the PowerPlay Table.
  */
 static int init_dpm_2_parameters(
 		struct pp_hwmgr *hwmgr,
@@ -779,10 +779,10 @@ static int get_gpio_table(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 /**
- * Private Function used during initialization.
+ * init_clock_voltage_dependency - Private Function used during initialization.
  * Initialize clock voltage dependency
- * @param hwmgr Pointer to the hardware manager.
- * @param powerplay_table Pointer to the PowerPlay Table.
+ * @hwmgr: Pointer to the hardware manager.
+ * @powerplay_table: Pointer to the PowerPlay Table.
  */
 static int init_clock_voltage_dependency(
 		struct pp_hwmgr *hwmgr,
@@ -871,15 +871,16 @@ static int init_clock_voltage_dependency(
 	return result;
 }
 
-/** Retrieves the (signed) Overdrive limits from VBIOS.
+/**
+ * init_over_drive_limits - Retrieves the (signed) Overdrive limits from VBIOS.
  * The max engine clock, memory clock and max temperature come from the firmware info table.
  *
  * The information is placed into the platform descriptor.
  *
- * @param hwmgr source of the VBIOS table and owner of the platform descriptor to be updated.
- * @param powerplay_table the address of the PowerPlay table.
+ * @hwmgr: source of the VBIOS table and owner of the platform descriptor to be updated.
+ * @powerplay_table: the address of the PowerPlay table.
  *
- * @return 1 as long as the firmware info table was present and of a supported version.
+ * Return: 1 as long as the firmware info table was present and of a supported version.
  */
 static int init_over_drive_limits(
 		struct pp_hwmgr *hwmgr,
@@ -898,11 +899,11 @@ static int init_over_drive_limits(
 }
 
 /**
- * Private Function used during initialization.
+ * init_thermal_controller - Private Function used during initialization.
  * Inspect the PowerPlay table for obvious signs of corruption.
- * @param hwmgr Pointer to the hardware manager.
- * @param powerplay_table Pointer to the PowerPlay Table.
- * @exception This implementation always returns 1.
+ * @hwmgr: Pointer to the hardware manager.
+ * @powerplay_table: Pointer to the PowerPlay Table.
+ * Exception:  This implementation always returns 1.
  */
 static int init_thermal_controller(
 		struct pp_hwmgr *hwmgr,
@@ -1108,11 +1109,11 @@ static int init_thermal_controller(
 }
 
 /**
- * Private Function used during initialization.
+ * check_powerplay_tables - Private Function used during initialization.
  * Inspect the PowerPlay table for obvious signs of corruption.
- * @param hwmgr Pointer to the hardware manager.
- * @param powerplay_table Pointer to the PowerPlay Table.
- * @exception 2 if the powerplay table is incorrect.
+ * @hwmgr: Pointer to the hardware manager.
+ * @powerplay_table: Pointer to the PowerPlay Table.
+ * Exception:  2 if the powerplay table is incorrect.
  */
 static int check_powerplay_tables(
 		struct pp_hwmgr *hwmgr,
@@ -1255,9 +1256,9 @@ int get_number_of_powerplay_table_entries_v1_0(struct pp_hwmgr *hwmgr)
 	return (uint32_t)(state_arrays->ucNumEntries);
 }
 
-/**
-* Private function to convert flags stored in the BIOS to software flags in PowerPlay.
-*/
+/*
+ * Private function to convert flags stored in the BIOS to software flags in PowerPlay.
+ */
 static uint32_t make_classification_flags(struct pp_hwmgr *hwmgr,
 		uint16_t classification, uint16_t classification2)
 {
@@ -1356,13 +1357,13 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
 }
 
 /**
-* Create a Power State out of an entry in the PowerPlay table.
-* This function is called by the hardware back-end.
-* @param hwmgr Pointer to the hardware manager.
-* @param entry_index The index of the entry to be extracted from the table.
-* @param power_state The address of the PowerState instance being created.
-* @return -1 if the entry cannot be retrieved.
-*/
+ * get_powerplay_table_entry_v1_0 - Create a Power State out of an entry in the PowerPlay table.
+ * This function is called by the hardware back-end.
+ * @hwmgr: Pointer to the hardware manager.
+ * @entry_index: The index of the entry to be extracted from the table.
+ * @power_state: The address of the PowerState instance being created.
+ * Return: -1 if the entry cannot be retrieved.
+ */
 int get_powerplay_table_entry_v1_0(struct pp_hwmgr *hwmgr,
 		uint32_t entry_index, struct pp_power_state *power_state,
 		int (*call_back_func)(struct pp_hwmgr *, void *,
-- 
2.25.1

