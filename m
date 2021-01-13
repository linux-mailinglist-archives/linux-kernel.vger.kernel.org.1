Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120C92F45E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhAMIIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbhAMIIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:08:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35EAC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:07:59 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so696286wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktFTv6l4Mkv6rjYtIWuu+I32vPP5PwPZZX1XhOAIePM=;
        b=duF2RanHvTZtsFkj9JgIpTcO7sj4u+KL/w+iBKJHU/Jy7Ckx1RaphwzUDE5jMsMwW1
         27Vu+V6wWLo70FLVwF6yaUnm6CGARm9TGfpCPseqgVLB81AJoIqmjg78Dd7H338ktFkL
         2C5ESgv0CGHxiCpgR8ZmDB6z2Ih7+LFTLwOqII2XleZa4h7gHjjoLA5GAth7fi5bVOjT
         ojVglKHj9Ur+xL7hBUUbkCeSi05acptXTjue7hh/8reUx40w42Hso10hElHJG7YyD5VH
         LhlgKsgmn8G9miWgTseJ54BB+KrzWHcTwOO8NGVgd3RzHzqf2QI/lRHEgdnRPQ/rkHrc
         DrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktFTv6l4Mkv6rjYtIWuu+I32vPP5PwPZZX1XhOAIePM=;
        b=FTa2nuCvQ2tsA+dOmddRSoAqBy/Auo8bWyRlGET3hBzXx6yOODT2EcBloh1qZc4frv
         mtgqoZbzLtyRn3oGgHSLwE0FhA5KBwaHmHaZsh8T4gwfrF3TaaFd9cXD1Xg+daYulFYm
         RRBTN2+GYDBTvOEilpaqIBFLyTktATDTByl6feiuOmu9ApOVhAvd4keHRpK5LNuliqj5
         vAp3Hg1bkcqRUddqx3d7vVR98alfkuWaTbPI2qIIi+C0gwV7m67JloyinyJCoeraGOVe
         rWBvVlGQZ4EoyqQMwI3XPHQyXerW3NCjXLEk5qOxGnxZQE/AaiLA4vYVfMsimolw/GqM
         jTpA==
X-Gm-Message-State: AOAM532/csbmUbZkA9tM7t0kyd/Ns68Q6Md9eEUGoyBbODJC3JscLeIT
        7mYCCP+MCunApvuFYFbgaZgym72AN5nunUit
X-Google-Smtp-Source: ABdhPJwg8FOSULW8uLx7TEj4K5AlIpbh2doqN2RtMSEgpMfenXvmHXzS99WoridiI20UxLDUGFFa0A==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr62474wms.36.1610525278481;
        Wed, 13 Jan 2021 00:07:58 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:07:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/30] drm/amd/include/renoir_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Wed, 13 Jan 2021 08:07:24 +0000
Message-Id: <20210113080752.1003793-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:226:29: warning: ‘UVD0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:219:29: warning: ‘USB0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:212:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:205:29: warning: ‘THM_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:198:29: warning: ‘SMUIO_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:191:29: warning: ‘SDMA0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:184:29: warning: ‘PCIE0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:177:29: warning: ‘OSSSYS_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:172:29: warning: ‘DCN_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:165:29: warning: ‘NBIF0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:158:29: warning: ‘MP1_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:151:29: warning: ‘MP0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:144:29: warning: ‘MMHUB_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:137:29: warning: ‘L2IMU0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:130:29: warning: ‘ISP_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:123:29: warning: ‘IOHC0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:116:29: warning: ‘HDP_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:109:29: warning: ‘HDA_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:102:29: warning: ‘GC_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:95:29: warning: ‘FUSE_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:88:29: warning: ‘DPCS_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:81:29: warning: ‘DMU_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:74:29: warning: ‘DIO_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:67:29: warning: ‘DF_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:60:29: warning: ‘DBGU_IO0_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:53:29: warning: ‘CLK_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:46:29: warning: ‘ATHUB_BASE’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:39:29: warning: ‘ACP_BASE’ defined but not used [-Wunused-const-variable=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/renoir_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/renoir_ip_offset.h b/drivers/gpu/drm/amd/include/renoir_ip_offset.h
index 07633e22e99a1..7dff85c81e5a7 100644
--- a/drivers/gpu/drm/amd/include/renoir_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/renoir_ip_offset.h
@@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ACP_BASE ={ { { { 0x02403800, 0x00480000, 0, 0, 0 } },
-- 
2.25.1

