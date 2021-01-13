Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66CD2F45EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhAMIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAMIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47017C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 3so710982wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upsPNw/tEbA/WXl0QtiBmIh69kJTZiyD6g31r7koW20=;
        b=chUfkrycKg5MIRF9H9qdA6JCg9Bpnh3Nf3wLevITHavXTmsdYBUZOPs9bfiTizkdSk
         0OLxGVTT9FC7RBTXPBcpyYdqbU2HNc/VPT1v/JlNog0IH55G/nTtfwfUTsF5zar+QFZm
         npR0p2Nednhpi6YDfOU66d9OcWpL4dJ+bHT3UVW2U8gIKUsHTP/Qp7BzfbqTcVRiOewI
         b3gcVybTv6EjUSSvq7vzIg2249S0avETtwtS9oVo326vf5EgzXaqrTc0H0s8uT+JDzia
         MQK50s1UwwYe4CBFNuu7jHfjwtiihoKelCWVvTBy3NRrghJmvgZYgrPpbx5oPBJ+5lT0
         a0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upsPNw/tEbA/WXl0QtiBmIh69kJTZiyD6g31r7koW20=;
        b=SVM4puH/80aKXAucs3yMtIvrivJ16LjkUI5kktmIdiUIEIQd39bAQcRWIibgWGOdlT
         yE50FTm9chYQuuz7WRkqD7JMz8p7jbCLSVnF8HH4bffnsuoSsQe97L+BQMNxZRGow0Di
         EZ2gXwuqeup3RJ6Ahi5VwHm2958n/NzJ9YU2nqKt9RN3qWUrEvC/PZySyZUbs9iYIxSr
         lZ3MRfLAQGzX8bt/XbJBTbvl8RD6jkOGgS1NlzBXDhBUjJO6oiL4zIDqMbygAJEq8Ron
         BugitloLcH/dmNItDXQ5gysxiOiXhibgLnXLEJLZG8CAp+FIVvf8ARafqZ3/Jy56CSXd
         +Ulw==
X-Gm-Message-State: AOAM53247urIJGRApoM5YZI0SYLVzZgrraKS94NhQCrJ5/IQR4Lw3TRN
        sF5LXafk10O7LA9bL0uLLob5GQ==
X-Google-Smtp-Source: ABdhPJzlIQ1bUxW4me+IU3JTzaO6MgEgBB9EKMUF6e/kVElBQj0xqPCpDrNdvq8TVktKdTqPghHJuw==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr932035wmi.20.1610525290060;
        Wed, 13 Jan 2021 00:08:10 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:09 -0800 (PST)
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
Subject: [PATCH 11/30] drm/amd/display/dc/dce100/Makefile: Ignore -Woverride-init warning
Date:   Wed, 13 Jan 2021 08:07:33 +0000
Message-Id: <20210113080752.1003793-12-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:54:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:5084:45: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note: in expansion of macro ‘MI_GFX8_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:5084:45: note: (near initialization for ‘mi_shifts.GRPH_NUM_BANKS’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note: in expansion of macro ‘MI_GFX8_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:5083:43: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note: in expansion of macro ‘MI_GFX8_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_10_0_sh_mask.h:5083:43: note: (near initialization for ‘mi_masks.GRPH_NUM_BANKS’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:155:28: note: in expansion of macro ‘GRPH_CONTROL__GRPH_NUM_BANKS_MASK’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:170:2: note: in expansion of macro ‘SFB’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_mem_input.h:291:2: note: in expansion of macro ‘MI_GFX8_TILE_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’

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
 drivers/gpu/drm/amd/display/dc/dce100/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/Makefile b/drivers/gpu/drm/amd/display/dc/dce100/Makefile
index a822d4e2a1693..ff20c47f559e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce100/Makefile
@@ -23,6 +23,8 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
+CFLAGS_$(AMDDALPATH)/dc/dce100/dce100_resource.o = $(call cc-disable-warning, override-init)
+
 DCE100 = dce100_resource.o dce100_hw_sequencer.o
 
 AMD_DAL_DCE100 = $(addprefix $(AMDDALPATH)/dc/dce100/,$(DCE100))
-- 
2.25.1

