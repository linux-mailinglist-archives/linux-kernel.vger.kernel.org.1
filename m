Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F592EF8CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbhAHUQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbhAHUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C28FC0612AF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y17so10129579wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBgi+TtCPp/XvYlN4nRx8jEUcrOm4gQPVN4cT7HQvug=;
        b=SEVv9CDRWxF1yk6kuCe/HD3vJIxGpMD5w0Vv6WQP6QnoNpvbnDmFxHNoV7DVwKwUoI
         zrVcBYwmh5ViXB18xebafqCsCQK13HtyXASqB/b/Lb/685iNgw2aNDEuv5gra6AGyFXy
         pyrmDd/YQHo5zi3kvzalBwcvNtDioPD4A20rdkfNGTc7bubibVkwEKH/Mzr/sTJs56g1
         MDw+Yfn4oWlOZKer5V0x+XXSLOv8HBSjgSW2ThVqmgFYF3nUg860jPq3G+ouJbpfWneE
         30XvyS64+XIOn5VcQKU032KwJvYgsw6pKUemL4NsmV5XRQLV4kuQpcK0NKbUPU8uvwAq
         6hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBgi+TtCPp/XvYlN4nRx8jEUcrOm4gQPVN4cT7HQvug=;
        b=da6OARgu/FdStItHNkbKldNPsk85zrraD5yKO4ypFW9xEcPxveXwQGD5G2zQke93Ey
         3dWAB5xNxyhRk2oORiVOAzIz2ZSQxyCVTk7WMbwHHIJQaZ/9UPFN4pd3lKMd/frb9Iwr
         Iu+jAn0DqzjsqKQAWOkGPZIEP1wCrkQkpgQlsxrKYTOYRN4X2bkVczZfOLIBZkDtJMxu
         5lGYCah+VHKi4M5S5RgBx+f7Pip+sXvVPAdH1tcm5hAVDnLUQ9DM1gkFNdGs8QbOR93Z
         ZURnzria3j7049BJuXBEOj2AXWrFoE6fpm+Z+JP334eKk6VYh9/OExVJ9DxOs4C3QIbu
         4AvQ==
X-Gm-Message-State: AOAM533vuwm5PMrg/HAVzzMsNljBi1hxKxgiMt1vc29MsC6Qk3KzmciR
        rpfrRlB4qSr9dRGQxvazUltryw==
X-Google-Smtp-Source: ABdhPJyff8m/+SB9B6wCbETmiHdFIwFxYP8u2+RXhvHoZZqTpdjO0sdEtnANZZNYEDs7DV8JCRl0hw==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr5161402wrr.130.1610136930880;
        Fri, 08 Jan 2021 12:15:30 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:30 -0800 (PST)
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
Subject: [PATCH 18/40] drm/amd/display/dc/bios/bios_parser: Fix a whole bunch of legacy doc formatting
Date:   Fri,  8 Jan 2021 20:14:35 +0000
Message-Id: <20210108201457.3078600-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2588:16: warning: no previous prototype for ‘update_slot_layout_info’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2692:16: warning: no previous prototype for ‘get_bracket_layout_record’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning: Function parameter or member 'dcb' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning: Function parameter or member 'signal' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning: Function parameter or member 'index' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:925: warning: Function parameter or member 'ss_info' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning: Function parameter or member 'bp' not described in 'get_ss_info_from_tbl'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning: Function parameter or member 'id' not described in 'get_ss_info_from_tbl'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning: Function parameter or member 'ss_info' not described in 'get_ss_info_from_tbl'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1022: warning: Function parameter or member 'bp' not described in 'get_ss_info_from_internal_ss_info_tbl_V2_1'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1022: warning: Function parameter or member 'id' not described in 'get_ss_info_from_internal_ss_info_tbl_V2_1'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1022: warning: Function parameter or member 'info' not described in 'get_ss_info_from_internal_ss_info_tbl_V2_1'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1087: warning: Function parameter or member 'bp' not described in 'get_ss_info_from_ss_info_table'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1087: warning: Function parameter or member 'id' not described in 'get_ss_info_from_ss_info_table'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1087: warning: Function parameter or member 'ss_info' not described in 'get_ss_info_from_ss_info_table'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1469: warning: Function parameter or member 'dcb' not described in 'bios_parser_get_encoder_cap_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1469: warning: Function parameter or member 'object_id' not described in 'bios_parser_get_encoder_cap_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1469: warning: Function parameter or member 'info' not described in 'bios_parser_get_encoder_cap_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1508: warning: Function parameter or member 'bp' not described in 'get_encoder_cap_record'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1508: warning: Function parameter or member 'object' not described in 'get_encoder_cap_record'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1566: warning: Function parameter or member 'dcb' not described in 'bios_parser_get_ss_entry_number'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1566: warning: Function parameter or member 'signal' not described in 'bios_parser_get_ss_entry_number'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1619: warning: Function parameter or member 'bp' not described in 'get_ss_entry_number_from_ss_info_tbl'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1619: warning: Function parameter or member 'id' not described in 'get_ss_entry_number_from_ss_info_tbl'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1686: warning: Function parameter or member 'bp' not described in 'get_ss_entry_number'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1686: warning: Function parameter or member 'id' not described in 'get_ss_entry_number'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1705: warning: Function parameter or member 'bp' not described in 'get_ss_entry_number_from_internal_ss_info_tbl_v2_1'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1705: warning: Function parameter or member 'id' not described in 'get_ss_entry_number_from_internal_ss_info_tbl_v2_1'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1740: warning: Function parameter or member 'bp' not described in 'get_ss_entry_number_from_internal_ss_info_tbl_V3_1'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1740: warning: Function parameter or member 'id' not described in 'get_ss_entry_number_from_internal_ss_info_tbl_V3_1'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1783: warning: Function parameter or member 'dcb' not described in 'bios_parser_get_gpio_pin_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1783: warning: Function parameter or member 'gpio_id' not described in 'bios_parser_get_gpio_pin_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1783: warning: Function parameter or member 'info' not described in 'bios_parser_get_gpio_pin_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2211: warning: Function parameter or member 'dcb' not described in 'bios_parser_set_scratch_critical_state'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2211: warning: Function parameter or member 'state' not described in 'bios_parser_set_scratch_critical_state'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 115 +++++++++---------
 1 file changed, 56 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index f054c5872c619..d2654c50b0b20 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -911,11 +911,11 @@ static enum bp_result get_ss_info_from_tbl(
  * ver 2.1 can co-exist with SS_Info table. Expect ASIC_InternalSS_Info ver 3.1,
  * there is only one entry for each signal /ss id.  However, there is
  * no planning of supporting multiple spread Sprectum entry for EverGreen
- * @param [in] this
- * @param [in] signal, ASSignalType to be converted to info index
- * @param [in] index, number of entries that match the converted info index
- * @param [out] ss_info, sprectrum information structure,
- * @return Bios parser result code
+ * @dcb:     pointer to the DC BIOS
+ * @signal:  ASSignalType to be converted to info index
+ * @index:   number of entries that match the converted info index
+ * @ss_info: sprectrum information structure,
+ * return:   Bios parser result code
  */
 static enum bp_result bios_parser_get_spread_spectrum_info(
 	struct dc_bios *dcb,
@@ -985,10 +985,10 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
  * There can not be more than 1 entry for  ASIC_InternalSS_Info Ver 2.1 or
  * SS_Info.
  *
- * @param this
- * @param id, spread sprectrum info index
- * @param pSSinfo, sprectrum information structure,
- * @return Bios parser result code
+ * @bp:      pointer to the BIOS parser
+ * @id:      spread sprectrum info index
+ * @ssinfo:  sprectrum information structure,
+ * return::  BIOS parser result code
  */
 static enum bp_result get_ss_info_from_tbl(
 	struct bios_parser *bp,
@@ -1011,9 +1011,10 @@ static enum bp_result get_ss_info_from_tbl(
  * from the VBIOS
  * There will not be multiple entry for Ver 2.1
  *
- * @param id, spread sprectrum info index
- * @param pSSinfo, sprectrum information structure,
- * @return Bios parser result code
+ * @bp:    pointer to the Bios parser
+ * @id:    spread sprectrum info index
+ * @info:  sprectrum information structure,
+ * return: Bios parser result code
  */
 static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 	struct bios_parser *bp,
@@ -1076,9 +1077,10 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
  * of entries that matches the id
  * for, the SS_Info table, there should not be more than 1 entry match.
  *
- * @param [in] id, spread sprectrum id
- * @param [out] pSSinfo, sprectrum information structure,
- * @return Bios parser result code
+ * @bp:      pointer to the Bios parser
+ * @id:      spread sprectrum id
+ * @ss_info: sprectrum information structure,
+ * return:   Bios parser result code
  */
 static enum bp_result get_ss_info_from_ss_info_table(
 	struct bios_parser *bp,
@@ -1451,16 +1453,14 @@ static enum bp_result get_embedded_panel_info_v1_3(
 }
 
 /**
- * bios_parser_get_encoder_cap_info
+ * bios_parser_get_encoder_cap_info - get encoder capability
+ *                                    information of input object id
  *
- * @brief
- *  Get encoder capability information of input object id
- *
- * @param object_id, Object id
- * @param object_id, encoder cap information structure
- *
- * @return Bios parser result code
+ * @dcb:       pointer to the DC BIOS
+ * @object_id: object id
+ * @info:      encoder cap information structure
  *
+ * return: Bios parser result code
  */
 static enum bp_result bios_parser_get_encoder_cap_info(
 	struct dc_bios *dcb,
@@ -1490,17 +1490,12 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 }
 
 /**
- * get_encoder_cap_record
- *
- * @brief
- *  Get encoder cap record for the object
- *
- * @param object, ATOM object
+ * get_encoder_cap_record - Get encoder cap record for the object
  *
- * @return atom encoder cap record
- *
- * @note
- *  search all records to find the ATOM_ENCODER_CAP_RECORD_V2 record
+ * @bp:      pointer to the BIOS parser
+ * @object:  ATOM object
+ * return:   atom encoder cap record
+ * note:     search all records to find the ATOM_ENCODER_CAP_RECORD_V2 record
  */
 static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 	struct bios_parser *bp,
@@ -1557,8 +1552,9 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
  * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info table from
  * the VBIOS that match the SSid (to be converted from signal)
  *
- * @param[in] signal, ASSignalType to be converted to SSid
- * @return number of SS Entry that match the signal
+ * @dcb:    pointer to the DC BIOS
+ * @signal: ASSignalType to be converted to SSid
+ * return: number of SS Entry that match the signal
  */
 static uint32_t bios_parser_get_ss_entry_number(
 	struct dc_bios *dcb,
@@ -1608,10 +1604,10 @@ static uint32_t bios_parser_get_ss_entry_number(
  * get_ss_entry_number_from_ss_info_tbl
  * Get Number of spread spectrum entry from the SS_Info table from the VBIOS.
  *
- * @note There can only be one entry for each id for SS_Info Table
- *
- * @param [in] id, spread spectrum id
- * @return number of SS Entry that match the id
+ * @bp:  pointer to the BIOS parser
+ * @id:  spread spectrum id
+ * return: number of SS Entry that match the id
+ * note: There can only be one entry for each id for SS_Info Table
  */
 static uint32_t get_ss_entry_number_from_ss_info_tbl(
 	struct bios_parser *bp,
@@ -1679,8 +1675,9 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
  * There can not be more than 1 entry for  ASIC_InternalSS_Info Ver 2.1 or
  * SS_Info.
  *
- * @param id, spread sprectrum info index
- * @return Bios parser result code
+ * @bp:    pointer to the BIOS parser
+ * @id:    spread sprectrum info index
+ * return: Bios parser result code
  */
 static uint32_t get_ss_entry_number(struct bios_parser *bp, uint32_t id)
 {
@@ -1696,8 +1693,9 @@ static uint32_t get_ss_entry_number(struct bios_parser *bp, uint32_t id)
  * Ver 2.1 from the VBIOS
  * There will not be multiple entry for Ver 2.1
  *
- * @param id, spread sprectrum info index
- * @return number of SS Entry that match the id
+ * @bp:    pointer to the BIOS parser
+ * @id:    spread sprectrum info index
+ * return: number of SS Entry that match the id
  */
 static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 	struct bios_parser *bp,
@@ -1731,8 +1729,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
  * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info table of
  * the VBIOS that matches id
  *
- * @param[in]  id, spread sprectrum id
- * @return number of SS Entry that match the id
+ * @bp:    pointer to the BIOS parser
+ * @id:    spread sprectrum id
+ * return: number of SS Entry that match the id
  */
 static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 	struct bios_parser *bp,
@@ -1767,10 +1766,11 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
  * bios_parser_get_gpio_pin_info
  * Get GpioPin information of input gpio id
  *
- * @param gpio_id, GPIO ID
- * @param info, GpioPin information structure
- * @return Bios parser result code
- * @note
+ * @dcb:     pointer to the DC BIOS
+ * @gpio_id: GPIO ID
+ * @info:    GpioPin information structure
+ * return:   Bios parser result code
+ * note:
  *  to get the GPIO PIN INFO, we need:
  *  1. get the GPIO_ID from other object table, see GetHPDInfo()
  *  2. in DATA_TABLE.GPIO_Pin_LUT, search all records, to get the registerA
@@ -2197,13 +2197,10 @@ static uint32_t get_support_mask_for_device_id(struct device_id device_id)
 }
 
 /**
- * bios_parser_set_scratch_critical_state
- *
- * @brief
- *  update critical state bit in VBIOS scratch register
- *
- * @param
- *  bool - to set or reset state
+ * bios_parser_set_scratch_critical_state - update critical state
+ *                                          bit in VBIOS scratch register
+ * @dcb:    pointer to the DC BIOS
+ * @state:  set or reset state
  */
 static void bios_parser_set_scratch_critical_state(
 	struct dc_bios *dcb,
@@ -2222,7 +2219,7 @@ static void bios_parser_set_scratch_critical_state(
  * bios_parser *bp - [in]BIOS parser handler to get master data table
  * integrated_info *info - [out] store and output integrated info
  *
- * @return
+ * return:
  * enum bp_result - BP_RESULT_OK if information is available,
  *                  BP_RESULT_BADBIOSTABLE otherwise.
  */
@@ -2372,7 +2369,7 @@ static enum bp_result get_integrated_info_v8(
  * bios_parser *bp - [in]BIOS parser handler to get master data table
  * integrated_info *info - [out] store and output integrated info
  *
- * @return
+ * return:
  * enum bp_result - BP_RESULT_OK if information is available,
  *                  BP_RESULT_BADBIOSTABLE otherwise.
  */
@@ -2509,7 +2506,7 @@ static enum bp_result get_integrated_info_v9(
  * bios_parser *bp - [in]BIOS parser handler to get master data table
  * integrated_info *info - [out] store and output integrated info
  *
- * @return
+ * return:
  * enum bp_result - BP_RESULT_OK if information is available,
  *                  BP_RESULT_BADBIOSTABLE otherwise.
  */
-- 
2.25.1

