Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006252F45E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhAMIJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbhAMIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC49C0617A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m4so1055239wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uijBif3LDCp6uSB/PBdTvGwhpkhL7Mx60YRAsO0AYy8=;
        b=fWyttGY5YOrU5xtJtANQdhj0LNwlYyw16LtKgiVGW+KEARU+XsvOkAHJg/PmCEwWVC
         1XHvUW+k7rB2zYNgC88Up8ZfZzpelyN25otNAF9TXn2iYIyclDpgWNtO90qfzJ/3NhK5
         uaafJQFVy/vaqjiU0j9y9ebW8oJlif4JBGxyuRvgJx6UFoNFnvbExzKka9eR0uobCKsJ
         kO6L+t5ue1oa9eTTbmKplUpBaAE/xLNq4yZjdjLXtMZ8DO1cupBORTIM9d3yVLf0nNk8
         2pUE0Ac/j1MftsxdUyo0oTe9rqFDRgER8g6u6V7EW5Xdx7iMmHS90cBbM5YK/raStG39
         /v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uijBif3LDCp6uSB/PBdTvGwhpkhL7Mx60YRAsO0AYy8=;
        b=CAsVtPCSmf/XA45GYZXXqIjtHJZSw8AqpykurGGMzUCRlv2ah74TRM3gJkdsiO0hyx
         +jmeVVlFXVv0CFdWLysOUc7+oRGdAXxpAsol0L56XhmqZlSuOyusesdDSUWcHdJFnsNN
         fYw2dV+BV3uOyWbUhOzruhtwHoLM580pAcsw50/Vayc2tOJfUvofxg5dI8EB3cZdW/x2
         7FgLusXoathOh3SNxgjES9YmY8YDOJgLZ7CmKXuaatc8v1xrfYRh5EO/udHuT/pDOfT1
         QgPA/eH1YgHFo7+89dNUNmXmPE2HgGwPt4Pa0KVo108Jm+3mFt07P40L5DegtkkYGB5c
         0ryQ==
X-Gm-Message-State: AOAM532hiQ7KWhwJrycqe8bERbBRNGlkPItrWrjh9xOlFVzlpELyHU16
        fgyoLRgX3TEjjiVFUsC9+RI9mA==
X-Google-Smtp-Source: ABdhPJyOQUs/awLYYca6/4bn7RF3frSY5UBrKKCm/uO/5uxt7oQu7dpIBVHi4TVCij2NMs44m6v1mA==
X-Received: by 2002:a5d:4112:: with SMTP id l18mr1190946wrp.116.1610525282432;
        Wed, 13 Jan 2021 00:08:02 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:01 -0800 (PST)
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
Subject: [PATCH 05/30] drm/amd/display/modules/info_packet/info_packet: Correct kernel-doc formatting
Date:   Wed, 13 Jan 2021 08:07:27 +0000
Message-Id: <20210113080752.1003793-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/modules/info_packet/info_packet.c:412: warning: Cannot understand  *****************************************************************************

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
 .../amd/display/modules/info_packet/info_packet.c   | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 0fdf7a3e96dea..57f198de5e2cb 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -409,16 +409,11 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 }
 
 /**
- *****************************************************************************
- *  Function: mod_build_hf_vsif_infopacket
+ *  mod_build_hf_vsif_infopacket - Prepare HDMI Vendor Specific info frame.
+ *                                 Follows HDMI Spec to build up Vendor Specific info frame
  *
- *  @brief
- *     Prepare HDMI Vendor Specific info frame.
- *     Follows HDMI Spec to build up Vendor Specific info frame
- *
- *  @param [in] stream: contains data we may need to construct VSIF (i.e. timing_3d_format, etc.)
- *  @param [out] info_packet:   output structure where to store VSIF
- *****************************************************************************
+ *  @stream:      contains data we may need to construct VSIF (i.e. timing_3d_format, etc.)
+ *  @info_packet: output structure where to store VSIF
  */
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet)
-- 
2.25.1

