Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2442C5640
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390304AbgKZNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390539AbgKZNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:18 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B009C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:18 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so2185207wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHkmifUCbIBOfDozUuzbPpd9+rHglUI4NupilVtjZ78=;
        b=Yh1V280HmCQD+zBZqYDnmH9yyoevWopyCFULzHuZD5/ZTWq709dW3oI0V9GAxPPtxx
         eCCoDGOJN3YGnrkr2OlcUMwNrUyR3rKwJqXY/kFjveAAbuwhWdpsoX1w9HhPOZmFlz4N
         FjyNr8orPeKdAGxHh03q1gCxOZj1+geaaEiSpjVgz+PsuuEO1s4bfjcUnGh4uD69FJvv
         VZUMgql3lzbVBB/R/UtLcCrRKSWE3VYvkc1WSgVrg3WcaRBkKEE5qcgbj6wUP/e6miwU
         AyLDxXe2IH2PA/FXEE/Iju3twBIEVmQxXfuU1JzIfWp7no8nmQXxhD5LlZH/1FRnfyx5
         OwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHkmifUCbIBOfDozUuzbPpd9+rHglUI4NupilVtjZ78=;
        b=lGEKw5ko2E3fRNYUsCSQmL2ae4edToct90D+2oJ0yqCq8JFtN0OKA5VL5EA4QjChKy
         HRTzgaJ+Nx/NLld6YBcWqblfHJPTqrUwP3AaN4zRLPQb3BsO7S8dmW0P5esR67w59IWw
         q4w2Zd5bPgT/Tisn5tKDD/KKrYT9FMLBs+ANpvmNAd7weRJnA65y4JWGYBZx0F4DuXlp
         oCfKP8z6cfoUzjnDlol4dlnC+SeJtlIhn9JqW7+UfO2vO4oWQR6dAeP5/Fp9AZtwqUhB
         HyiUeNMI6QQmKWZl8CCkRUc2qT9o68S6sc3ecmtugBcLnkWzGQqvLxlEYIA+gWM35oW3
         S57g==
X-Gm-Message-State: AOAM532TrDLKLOoZG9GlSs2D6294zpHYLiQUfYDYcJDWvEGtJN21qNMm
        MIAcXWg9QuYn1uRO+We1Y/QNiQ==
X-Google-Smtp-Source: ABdhPJzytCtM7ybHBpw4V46jpDyxdvhAX2PglRXJkA+rrqEdtCapDYC0bdc9bCaPqyhcqBjQUVHvMQ==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr3872623wrp.142.1606398194838;
        Thu, 26 Nov 2020 05:43:14 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Fix a myriad of kernel-doc issues
Date:   Thu, 26 Nov 2020 13:42:19 +0000
Message-Id: <20201126134240.3214176-20-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:104: warning: Function parameter or member 'reg_block' not described in 'atomctrl_set_mc_reg_address_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:104: warning: Function parameter or member 'table' not described in 'atomctrl_set_mc_reg_address_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:213: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_set_engine_dram_timings_rv770'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:213: warning: Function parameter or member 'engine_clock' not described in 'atomctrl_set_engine_dram_timings_rv770'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:213: warning: Function parameter or member 'memory_clock' not described in 'atomctrl_set_engine_dram_timings_rv770'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:239: warning: Function parameter or member 'device' not described in 'get_voltage_info_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:519: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_get_reference_clock'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:548: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_is_voltage_controlled_by_gpio_v3'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:548: warning: Function parameter or member 'voltage_type' not described in 'atomctrl_is_voltage_controlled_by_gpio_v3'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:548: warning: Function parameter or member 'voltage_mode' not described in 'atomctrl_is_voltage_controlled_by_gpio_v3'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:640: warning: Function parameter or member 'device' not described in 'get_gpio_lookup_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:663: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_get_pp_assign_pin'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:663: warning: Function parameter or member 'pinId' not described in 'atomctrl_get_pp_assign_pin'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:663: warning: Function parameter or member 'gpio_pin_assignment' not described in 'atomctrl_get_pp_assign_pin'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1152: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_get_voltage_evv'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1152: warning: Function parameter or member 'virtual_voltage_id' not described in 'atomctrl_get_voltage_evv'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1152: warning: Function parameter or member 'voltage' not described in 'atomctrl_get_voltage_evv'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1194: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_get_mpll_reference_clock'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1227: warning: Function parameter or member 'device' not described in 'asic_internal_ss_get_ss_table'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warning: Function parameter or member 'hwmgr' not described in 'asic_internal_ss_get_ss_asignment'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warning: Function parameter or member 'clockSource' not described in 'asic_internal_ss_get_ss_asignment'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warning: Function parameter or member 'clockSpeed' not described in 'asic_internal_ss_get_ss_asignment'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1258: warning: Function parameter or member 'ssEntry' not described in 'asic_internal_ss_get_ss_asignment'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1321: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_get_memory_clock_spread_spectrum'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1321: warning: Function parameter or member 'memory_clock' not described in 'atomctrl_get_memory_clock_spread_spectrum'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1321: warning: Function parameter or member 'ssInfo' not described in 'atomctrl_get_memory_clock_spread_spectrum'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1332: warning: Function parameter or member 'hwmgr' not described in 'atomctrl_get_engine_clock_spread_spectrum'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1332: warning: Function parameter or member 'engine_clock' not described in 'atomctrl_get_engine_clock_spread_spectrum'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:1332: warning: Function parameter or member 'ssInfo' not described in 'atomctrl_get_engine_clock_spread_spectrum'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 74 ++++++++++---------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 2cb913ab77f26..83a6504e093cb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -92,11 +92,11 @@ static int atomctrl_retrieve_ac_timing(
 }
 
 /**
- * Get memory clock AC timing registers index from VBIOS table
+ * atomctrl_set_mc_reg_address_table - Get memory clock AC timing registers index from VBIOS table
  * VBIOS set end of memory clock AC timing registers by ucPreRegDataLength bit6 = 1
- * @param    reg_block the address ATOM_INIT_REG_BLOCK
- * @param    table the address of MCRegTable
- * @return   0
+ * @reg_block: the address ATOM_INIT_REG_BLOCK
+ * @table: the address of MCRegTable
+ * Return:   0
  */
 static int atomctrl_set_mc_reg_address_table(
 		ATOM_INIT_REG_BLOCK *reg_block,
@@ -203,7 +203,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
 	return result;
 }
 
-/**
+/*
  * Set DRAM timings based on engine clock and memory clock.
  */
 int atomctrl_set_engine_dram_timings_rv770(
@@ -229,7 +229,7 @@ int atomctrl_set_engine_dram_timings_rv770(
 			(uint32_t *)&engine_clock_parameters);
 }
 
-/**
+/*
  * Private Function to get the PowerPlay Table Address.
  * WARNING: The tabled returned by this function is in
  * dynamically allocated memory.
@@ -274,12 +274,13 @@ static const ATOM_VOLTAGE_OBJECT_V3 *atomctrl_lookup_voltage_type_v3(
 	return NULL;
 }
 
-/** atomctrl_get_memory_pll_dividers_si().
+/**
+ * atomctrl_get_memory_pll_dividers_si().
  *
- * @param hwmgr                 input parameter: pointer to HwMgr
- * @param clock_value             input parameter: memory clock
- * @param dividers                 output parameter: memory PLL dividers
- * @param strobe_mode            input parameter: 1 for strobe mode,  0 for performance mode
+ * @hwmgr:           input parameter: pointer to HwMgr
+ * @clock_value:     input parameter: memory clock
+ * @dividers:        output parameter: memory PLL dividers
+ * @strobe_mode:     input parameter: 1 for strobe mode,  0 for performance mode
  */
 int atomctrl_get_memory_pll_dividers_si(
 		struct pp_hwmgr *hwmgr,
@@ -326,11 +327,12 @@ int atomctrl_get_memory_pll_dividers_si(
 	return result;
 }
 
-/** atomctrl_get_memory_pll_dividers_vi().
+/**
+ * atomctrl_get_memory_pll_dividers_vi().
  *
- * @param hwmgr                 input parameter: pointer to HwMgr
- * @param clock_value             input parameter: memory clock
- * @param dividers               output parameter: memory PLL dividers
+ * @hwmgr:                 input parameter: pointer to HwMgr
+ * @clock_value:           input parameter: memory clock
+ * @dividers:              output parameter: memory PLL dividers
  */
 int atomctrl_get_memory_pll_dividers_vi(struct pp_hwmgr *hwmgr,
 		uint32_t clock_value, pp_atomctrl_memory_clock_param *mpll_param)
@@ -512,7 +514,7 @@ int atomctrl_get_dfs_pll_dividers_vi(
 	return result;
 }
 
-/**
+/*
  * Get the reference clock in 10KHz
  */
 uint32_t atomctrl_get_reference_clock(struct pp_hwmgr *hwmgr)
@@ -535,7 +537,7 @@ uint32_t atomctrl_get_reference_clock(struct pp_hwmgr *hwmgr)
 	return clock;
 }
 
-/**
+/*
  * Returns true if the given voltage type is controlled by GPIO pins.
  * voltage_type is one of SET_VOLTAGE_TYPE_ASIC_VDDC,
  * SET_VOLTAGE_TYPE_ASIC_MVDDC, SET_VOLTAGE_TYPE_ASIC_MVDDQ.
@@ -630,7 +632,7 @@ static bool atomctrl_lookup_gpio_pin(
 	return false;
 }
 
-/**
+/*
  * Private Function to get the PowerPlay Table Address.
  * WARNING: The tabled returned by this function is in
  * dynamically allocated memory.
@@ -653,7 +655,7 @@ static ATOM_GPIO_PIN_LUT *get_gpio_lookup_table(void *device)
 	return (ATOM_GPIO_PIN_LUT *)table_address;
 }
 
-/**
+/*
  * Returns 1 if the given pin id find in lookup table.
  */
 bool atomctrl_get_pp_assign_pin(
@@ -1101,14 +1103,15 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 	return result;
 }
 
-/** atomctrl_get_voltage_evv_on_sclk gets voltage via call to ATOM COMMAND table.
- * @param hwmgr	input: pointer to hwManager
- * @param voltage_type            input: type of EVV voltage VDDC or VDDGFX
- * @param sclk                        input: in 10Khz unit. DPM state SCLK frequency
- *		which is define in PPTable SCLK/VDDC dependence
- *				table associated with this virtual_voltage_Id
- * @param virtual_voltage_Id      input: voltage id which match per voltage DPM state: 0xff01, 0xff02.. 0xff08
- * @param voltage		       output: real voltage level in unit of mv
+/**
+ * atomctrl_get_voltage_evv_on_sclk gets voltage via call to ATOM COMMAND table.
+ * @hwmgr:              input: pointer to hwManager
+ * @voltage_type:       input: type of EVV voltage VDDC or VDDGFX
+ * @sclk:               input: in 10Khz unit. DPM state SCLK frequency
+ *		         which is define in PPTable SCLK/VDDC dependence
+ *			 table associated with this virtual_voltage_Id
+ * @virtual_voltage_Id: input: voltage id which match per voltage DPM state: 0xff01, 0xff02.. 0xff08
+ * @voltage: 	        output: real voltage level in unit of mv
  */
 int atomctrl_get_voltage_evv_on_sclk(
 		struct pp_hwmgr *hwmgr,
@@ -1142,9 +1145,9 @@ int atomctrl_get_voltage_evv_on_sclk(
 
 /**
  * atomctrl_get_voltage_evv gets voltage via call to ATOM COMMAND table.
- * @param hwmgr	input: pointer to hwManager
- * @param virtual_voltage_id      input: voltage id which match per voltage DPM state: 0xff01, 0xff02.. 0xff08
- * @param voltage		       output: real voltage level in unit of mv
+ * @hwmgr:              input: pointer to hwManager
+ * @virtual_voltage_id: input: voltage id which match per voltage DPM state: 0xff01, 0xff02.. 0xff08
+ * @voltage: 	       output: real voltage level in unit of mv
  */
 int atomctrl_get_voltage_evv(struct pp_hwmgr *hwmgr,
 			     uint16_t virtual_voltage_id,
@@ -1187,7 +1190,7 @@ int atomctrl_get_voltage_evv(struct pp_hwmgr *hwmgr,
 	return result;
 }
 
-/**
+/*
  * Get the mpll reference clock in 10KHz
  */
 uint32_t atomctrl_get_mpll_reference_clock(struct pp_hwmgr *hwmgr)
@@ -1220,7 +1223,7 @@ uint32_t atomctrl_get_mpll_reference_clock(struct pp_hwmgr *hwmgr)
 	return clock;
 }
 
-/**
+/*
  * Get the asic internal spread spectrum table
  */
 static ATOM_ASIC_INTERNAL_SS_INFO *asic_internal_ss_get_ss_table(void *device)
@@ -1248,7 +1251,7 @@ bool atomctrl_is_asic_internal_ss_supported(struct pp_hwmgr *hwmgr)
 		return false;
 }
 
-/**
+/*
  * Get the asic internal spread spectrum assignment
  */
 static int asic_internal_ss_get_ss_asignment(struct pp_hwmgr *hwmgr,
@@ -1311,7 +1314,7 @@ static int asic_internal_ss_get_ss_asignment(struct pp_hwmgr *hwmgr,
 	return entry_found ? 0 : 1;
 }
 
-/**
+/*
  * Get the memory clock spread spectrum info
  */
 int atomctrl_get_memory_clock_spread_spectrum(
@@ -1322,7 +1325,8 @@ int atomctrl_get_memory_clock_spread_spectrum(
 	return asic_internal_ss_get_ss_asignment(hwmgr,
 			ASIC_INTERNAL_MEMORY_SS, memory_clock, ssInfo);
 }
-/**
+
+/*
  * Get the engine clock spread spectrum info
  */
 int atomctrl_get_engine_clock_spread_spectrum(
-- 
2.25.1

