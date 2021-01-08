Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821F92EF8F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbhAHUT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbhAHUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA52C061240
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e25so9469639wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1cIGcueVpiwKXCsXAGeLOrVeaRuSdzc2IFkwmNetFo=;
        b=l0LVv8Yv2qqohE+nDbzioDjwD7IumU3x0mYo0uB5VLZL4cfV3nC1+PdifOuff89qz3
         WBcqrZJc0UxjoiglM15XpESfKjFG9UtPvNDMIoflEAsBeMJibYgpd4gebN/tASO3ncme
         9zY3Wwt3gC6Lss/3zX/gE1z6x3mvKqC/W5ebaBBbSiRJ0LahhPvFcxkb1gj2xAfeQ5xa
         lon5sbPe+45qR9l6juUzf/JmQ/aOJyAidvclSUOZtTTxnZi5Wu3locXDnSeq+R4XWUbP
         Mru96URrGOFc3ri9j7RrGYKAvUcGQAvyWv9m9ciIxq+jCERzMETtgm5KddxjOnIb6WGb
         QEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1cIGcueVpiwKXCsXAGeLOrVeaRuSdzc2IFkwmNetFo=;
        b=TYxSzWLOsPvu6UEFd/J/ZdqenSeNLCJtXzRRVd8J7B4VbsB0h32lv+VtyzLQddE+IR
         Rkd/lVS14VP2jD14yfx6Wz6ohhZgJ9UD+ZqdnEdm0wbgsy9NFR4/RFajzqdRCKaBWmES
         E/IfjMMKHfGWCYt9Sm2pspSMSu8RyP2KHlxCVa0/4i4XFt6ofJakcFUpv/A5Hu65iqjT
         MRWEwwlOGd1qc0T181kSoNmQSYHKbxaSPKqcVwRO6blVpm5/aTRxY5QV5Pp6iB90whUS
         V9RD4bjcOxnLk/RQLbHQG79j62kfke4e68D+ubv8sBVAsXZ5dSF8Y1j1sFr2NewOSWhg
         kX3w==
X-Gm-Message-State: AOAM532Ne4AhILv2NHXUstr9QLvE7FyEe9EJuUtmtQR24G2767j8CGIi
        NtmlwbDGq8N8VRLGhuM4LzXX+on9d/BTI6FG
X-Google-Smtp-Source: ABdhPJwhybeKl0LYglGwkXx8NfCZ7mEYtL7SSGIFExzb1Ne+RU+Jge2WH9CSadOH5VqEQ698MQ2nsw==
X-Received: by 2002:a1c:c308:: with SMTP id t8mr4595425wmf.22.1610136936655;
        Fri, 08 Jan 2021 12:15:36 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:36 -0800 (PST)
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
Subject: [PATCH 22/40] drm/amd/display/dc/bios/bios_parser2: Fix some formatting issues and missing parameter docs
Date:   Fri,  8 Jan 2021 20:14:39 +0000
Message-Id: <20210108201457.3078600-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:501: warning: Function parameter or member 'dcb' not described in 'bios_parser_get_gpio_pin_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:501: warning: Function parameter or member 'gpio_id' not described in 'bios_parser_get_gpio_pin_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:501: warning: Function parameter or member 'info' not described in 'bios_parser_get_gpio_pin_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warning: Function parameter or member 'dcb' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warning: Function parameter or member 'signal' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warning: Function parameter or member 'index' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:815: warning: Function parameter or member 'ss_info' not described in 'bios_parser_get_spread_spectrum_info'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1210: warning: Function parameter or member 'dcb' not described in 'bios_parser_set_scratch_critical_state'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1210: warning: Function parameter or member 'state' not described in 'bios_parser_set_scratch_critical_state'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 670c265838178..9f9fda3118d1f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -485,10 +485,11 @@ static struct atom_hpd_int_record *get_hpd_record(
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
+ * return: Bios parser result code
+ * note:
  *  to get the GPIO PIN INFO, we need:
  *  1. get the GPIO_ID from other object table, see GetHPDInfo()
  *  2. in DATA_TABLE.GPIO_Pin_LUT, search all records,
@@ -801,11 +802,11 @@ static enum bp_result get_ss_info_v4_2(
  * ver 3.1,
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
+ * return: Bios parser result code
  */
 static enum bp_result bios_parser_get_spread_spectrum_info(
 	struct dc_bios *dcb,
@@ -1196,13 +1197,11 @@ static bool bios_parser_is_accelerated_mode(
 }
 
 /**
- * bios_parser_set_scratch_critical_state
+ * bios_parser_set_scratch_critical_state - update critical state bit
+ *                                          in VBIOS scratch register
  *
- * @brief
- *  update critical state bit in VBIOS scratch register
- *
- * @param
- *  bool - to set or reset state
+ * @dcb:   pointer to the DC BIO
+ * @state: set or reset state
  */
 static void bios_parser_set_scratch_critical_state(
 	struct dc_bios *dcb,
-- 
2.25.1

