Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA02F1F30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbhAKTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390928AbhAKTUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482CC0617BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c124so233195wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miXNZ6gGmj2M59EydnLO6lgExaxQkAaXuUbDezw9Q9E=;
        b=Hb3cuQsSFZ1jEyNVTfncIcsgdUxm0tHxyqEwFT7taKF22e0/Eu5lKQ989Ilii7idMz
         9CLW1Ev8wTHz8TuK3jl9HqNsH9o3eGntX4yVKCpvoQ3n9LPcbe1xiT/14UqnXMBOMuN5
         0OQrnAi/+JeA7rnWwV8kDquF4ONohcKo4jzO9bB7iYp+GbjyNMSHpGHF/UxoeeLOUqJI
         8AR80hZmwpl0/Dr1XlRzY5yx/8mnxg0Xk5cvmx1w6Zx9q+WDCtXNMOYU6DZ+ZuvaSMj/
         0ahzK0ny8XZPoq/0Eee907+PzNcxplWujury3VdSUuW1mCvTI08UveHREaYpbFl7hHbo
         2KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miXNZ6gGmj2M59EydnLO6lgExaxQkAaXuUbDezw9Q9E=;
        b=BsreLAyEw2BZQ0/SPpuFJ4lo1TRcZBmQNHZ0KUOUyBJUZc9ST1UxE7/7BZ8T6h4NWZ
         gvyZ/92iJWIgXJ3jlAdoZdi+ux2GzjOcvK2vUTXr7ynhomXCHr/ozdNu0CeEEi3m4FNu
         AWM4K1OYDDEVAt7GIuN19nUK1c0uah+ZGTR+HdlPBTSKYm+frwxfMCOt0BXyx6Yw2grS
         lhEehaOpJtEO1gSe13DdyTElIQl6KPuTmtsT3x+6+KZfZDMkOldTxzIO3vLYOPcrc9cJ
         eyKAu07B7rIpX3ekJA2R5LRKcnLxgKtJyAr+Upp0oDvMgA6IzUlmJwJrdYW5boBlvLjL
         7hmg==
X-Gm-Message-State: AOAM532fklStrQzFKF2tyQOyVZdbD9J2eGoahv8LrIcowImHhiGks4EH
        qpt8MBhc+XvYONunnPwMRIdhAA==
X-Google-Smtp-Source: ABdhPJyXPhJp6VPC0E/onuoITyQMrszVAt4I6xbCfI774wMzYcU7N9xpalSM1Xb2p7q/+ZcgVGNOgw==
X-Received: by 2002:a1c:356:: with SMTP id 83mr284142wmd.31.1610392792743;
        Mon, 11 Jan 2021 11:19:52 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:52 -0800 (PST)
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
Subject: [PATCH 17/40] drm/amd/display/dc/dce/dce_aux: Remove duplicate line causing 'field overwritten' issue
Date:   Mon, 11 Jan 2021 19:19:03 +0000
Message-Id: <20210111191926.3688443-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:59:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10014:58: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2: note: in expansion of macro ‘DCE_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10014:58: note: (near initialization for ‘aux_shift.AUX_SW_AUTOINCREMENT_DISABLE’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:177:2: note: in expansion of macro ‘DCE_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10013:56: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:181:2: note: in expansion of macro ‘DCE_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10013:56: note: (near initialization for ‘aux_mask.AUX_SW_AUTOINCREMENT_DISABLE’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:214:16: note: in expansion of macro ‘AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:127:2: note: in expansion of macro ‘AUX_SF’

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
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
index 382465862f297..277484cf853e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
@@ -124,7 +124,6 @@ struct dce110_aux_registers {
 	AUX_SF(AUX_SW_CONTROL, AUX_SW_GO, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_DATA_RW, mask_sh),\
-	AUX_SF(AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_INDEX, mask_sh),\
 	AUX_SF(AUX_SW_DATA, AUX_SW_DATA, mask_sh),\
 	AUX_SF(AUX_SW_STATUS, AUX_SW_REPLY_BYTE_COUNT, mask_sh),\
-- 
2.25.1

