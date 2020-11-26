Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801A2C5649
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390677AbgKZNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390906AbgKZNnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:35 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C506C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:35 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so2169261wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzRVFp8AO2A9mZrX3brzbvLyGgDmiC5m751T9imyCRc=;
        b=WruioXcrjaQXU228DJaADLs63/PeaAfgh5GoVhtS5sxDT1aaFya2f4AYcNpDv9u7bu
         GE1IyxUSraaGMfjae2iGxbtoeGDlaW+aiGQz0vg8TbLIY3ULpfiO0MK4dgdeEqpWqVx1
         yjcfF20TWnnH0cv4oDwvCg85uHtK2SGSmK1YF38tJjmq8Q3LkjcNMsQhTX/53aLKtFf5
         m/kX+iYDcOMeyHPxWub6ueiDU0b4zprEOJhekf0gK6T4eHQe+/Vq2GekDvnMHh8QrFzI
         xCL2JKIJXk2Yr/1uD0ZBcmLFk/2Tp0pKgKnkhHZPm825anEGjFCEYELdOff1mSgXjeKf
         GGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzRVFp8AO2A9mZrX3brzbvLyGgDmiC5m751T9imyCRc=;
        b=jvxcUGs2RQiNhGnGwCszNoMxfs5LMNoolQaFBf1Kimez8UOaZykmIirIQeHasGIgZh
         emiYpth9PaytqLoEMFgl372vdWnkzFRhc8xEEFB2e55F3kDTnfYRrLb5M1Tz7LRItRM7
         u7whC4x5SkMzVVQZCxcejX6LvjC7MTE45boHvlGjEFnSYmYJuwb+9L1TPG0K0ZxWOKeW
         AHzpFCqDsysry1ECgZfEPGSbMkcC114tiQlzHrPOb3qrYZ5pUxeRKfqbh0vgsRiwUNEc
         b8HRevubyepAorYzUvg+ErSpyWGZ6qlkzT4CWAkUAV2XykUBDW0RhDqH0+9k2DmUImoX
         cgBg==
X-Gm-Message-State: AOAM530eppM7odkuS1OFeioALoi8hFL5v/meuWBSr7rFtfjOfQV5qhlu
        Gtd3O4ekXiUr1M6URA9eGrDORA==
X-Google-Smtp-Source: ABdhPJzgo+nf2gxrwPa2phadC7hbPLT0T+NFYc2Mw3GiAqa/kWC5egDN9CWdbIV+A6DvPgiUPY+pMg==
X-Received: by 2002:adf:f651:: with SMTP id x17mr3881849wrp.185.1606398214358;
        Thu, 26 Nov 2020 05:43:34 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:33 -0800 (PST)
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
Subject: [PATCH 33/40] drm/amd/display/dc/inc/hw/dpp: Mark 'dpp_input_csc_matrix' as __maybe_unused
Date:   Thu, 26 Nov 2020 13:42:33 +0000
Message-Id: <20201126134240.3214176-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dpp_input_csc_matrix' is used by some, but not all source files which
include dpp.h.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dpp.h:50:42: warning: ‘dpp_input_csc_matrix’ defined but not used [-Wunused-const-variable=]

NB: Snipped lots of these for brevity

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
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 6751186f6f904..ddbe4bb52724a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -47,7 +47,7 @@ struct dpp_input_csc_matrix {
 	uint16_t regval[12];
 };
 
-static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
+static const struct dpp_input_csc_matrix __maybe_unused dpp_input_csc_matrix[] = {
 	{COLOR_SPACE_SRGB,
 		{0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
 	{COLOR_SPACE_SRGB_LIMITED,
-- 
2.25.1

