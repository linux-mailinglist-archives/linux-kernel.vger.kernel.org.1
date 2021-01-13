Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7B2F4609
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbhAMILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbhAMIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:18 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38DC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y17so1048688wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCRcVC8RkZNOsTZmH5MrfFMxeQad14MXuEtj32uCB2s=;
        b=SpmtloZ/cSZhuSXJ9UQ5EJpwFNOKanG/Bh7X1ETpsmkC49Bq+w103SFSlgUo4pLIMH
         2zKhjWxoUnAtjIDu+O6SHLaEgUkdKy4qCZEP7+tBNDWSP9CUt+1Z8x2nm0wSiq8uyq2M
         Ma/YOj18A45z0ky396eCJnoyUf0zmIrZyeR1V4/RYkslXirRP378ubPBXG5RuEKedpSe
         cFbrG8IQ3GYECv1TK7vuuUf8Jl9WAJCn7m9EbmGKl7ng+wYlDrsDlZkUx4y3zv9RdyA9
         B4wot+hsMGmQQqtj9AgLGGvNVnO0BtwuAwu1ZvRizlL9o/HbLAFaiG7V+mY6GCF+NRQj
         YU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCRcVC8RkZNOsTZmH5MrfFMxeQad14MXuEtj32uCB2s=;
        b=s9O3+ZhzKdKFu/dIsF0C9A1BgRIQd1qSMaiXonaNVPJjC7dRN5xJtwlDS0L/Tixo2j
         s0y7a+MME9y4rfZxGZRTFyhqXu1Li51RdYDXfZ687y9EJWDk25Nc4Blh8yzxc6ZHvORm
         KS3/WmrxyTjAediodeQYSeIa+B92fGaM0Dj4tYBCCOtmqLR9QXEd0N9zxZJWng+29EaB
         s1DpZB6DvkwYs/RxNrKDaHVsdAGWOMoaDrha+Mikn+65aQ5WZikiEjuraqk/patJJAJm
         O1xem/AcfTn2Vjp1ZGgnAPP1IzV7IdE3CdSUoZP7algElU23xBhqzAzg+iLvJ0fBPQkd
         3HMA==
X-Gm-Message-State: AOAM533A333AG3iDBG1i1HF/Ca7YojwJin+nmcVPuGwBhbIsdEZP0S35
        zpnhDqHjlXjfvFKoMIYrnxNKlQ==
X-Google-Smtp-Source: ABdhPJzn69sZitxlxCughkD08VyFfr7F+gsx//bI3xmhw/alZxDQ3q/KiVOwA0KLVvEE1NsA8yaYew==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr1191325wrv.363.1610525286253;
        Wed, 13 Jan 2021 00:08:06 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:05 -0800 (PST)
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
Subject: [PATCH 08/30] drm/amd/display/dc/core/dc_link_dp: Staticify local function 'linkRateInKHzToLinkRateMultiplier'
Date:   Wed, 13 Jan 2021 08:07:30 +0000
Message-Id: <20210113080752.1003793-9-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3710:19: warning: no previous prototype for ‘linkRateInKHzToLinkRateMultiplier’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function ‘dpcd_set_source_specific_data’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4403:18: warning: variable ‘result_write_min_hblank’ set but not used [-Wunused-but-set-variable]

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
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2fc12239b22cb..3c33b8fe218e5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3707,7 +3707,7 @@ bool detect_dp_sink_caps(struct dc_link *link)
 	/* TODO save sink caps in link->sink */
 }
 
-enum dc_link_rate linkRateInKHzToLinkRateMultiplier(uint32_t link_rate_in_khz)
+static enum dc_link_rate linkRateInKHzToLinkRateMultiplier(uint32_t link_rate_in_khz)
 {
 	enum dc_link_rate link_rate;
 	// LinkRate is normally stored as a multiplier of 0.27 Gbps per lane. Do the translation.
-- 
2.25.1

