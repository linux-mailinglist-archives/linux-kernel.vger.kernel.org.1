Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7272F1F08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403844AbhAKTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403774AbhAKTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315DEC0617B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t30so972856wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+UK/qW8zyZ1jZCT/24Q1f8i1ILtoK1GZqqcObzyOGM=;
        b=DvGExxxyn3oqRzhlGqr5YgtbW3eoDFbk0Jpz4hbgESXe2lcLEUBnV/gcVyOdnnhXIp
         sHQNrPWUAeKdLr0SFUEbsOFKvo/uyhoerxmF7P/x4CnE3oi0YXuvIKRMHCrktk7Vq3YK
         QDke9hcU7aC+/WtoDoeFNRHs22v8Ox2+epuhQvcsq7EoM4gnBKAiCd6pOv6TFnPDGieR
         kc9aJrqGrWjchXJpi153LVXiq7ZcqRHuzRrVwMKfQ5T4G5SIRHOGe6iEjWVMSzioI6Na
         YeB6CydYIUAZ6w/pFgOEY/VfN2uYdrU5o6x3eKwzhT2XSJnNnBXaA7K3CFdu8FMYxqxq
         BhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+UK/qW8zyZ1jZCT/24Q1f8i1ILtoK1GZqqcObzyOGM=;
        b=Y+wYT0F2V1YbpmqXglLe0guLox9qBTNQ7GH3WArXAgvi8ZlfDHHX8A3djJRGbK7ALZ
         K9+G4btOkL8VYgHCo5FBw31FL5fJlYNyfTdW847yNPjsgppHMbCnzoiafHONCB7YiqfK
         BsaXcWGLyRuENL4ECDedII+KFbMUy4QckHdwWwEtRE6AM02dOJMLiOnFc+ayRvmK/f0h
         4bvHtHfiyIHDKYIZ2n1bhvw8qS+7A8ornELVbie5+FJo2GCV5kmWP7Lz1H/Egopei0qm
         Q8gCg0r9jdd6dTwcUJ7cpqnyzzW4vVcB8olHQMd4DIOY9iFJN80CMSTRDtcgh6VDnG0j
         4ejw==
X-Gm-Message-State: AOAM533udhwvIGPniTlTkIL+WBrOh+84En5weNDswkcebGGAcsi4fU0s
        w2CUAvv+yDJbVah7FcVMSY2Gnw==
X-Google-Smtp-Source: ABdhPJwDJ0LuUahJhXPa/BTZ+z7Ot3PI+CIZgcG7Qk4z+wGylDnTKxp8STe+AdFo8eFnvhSPMQwYUQ==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr597601wrw.372.1610392785890;
        Mon, 11 Jan 2021 11:19:45 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:45 -0800 (PST)
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
Subject: [PATCH 12/40] drm/amd/display/dc/dce120/Makefile: Ignore -Woverride-init warning
Date:   Mon, 11 Jan 2021 19:18:58 +0000
Message-Id: <20210111191926.3688443-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file uses a complex abstracted set of hierarchical macros to
setup its applicable register lists within constant structures.
However in the case of TMDS_CNTL we wish to mark it as not applicable
for this use-case.

One method would be to de-const all of the definitions and users, then
manually zero out TMDS_CNTL from the list.  Another would be to create
a new set of hierarchical macros to omit TMDS_CNTL entirely.  Both
would entail a great deal of unnecessary changes and maintenance
burden.

Instead, let's just silence the warning.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:281:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: note: (near initialization for ‘stream_enc_regs[0].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:281:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:282:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: note: (near initialization for ‘stream_enc_regs[1].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:282:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:283:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: note: (near initialization for ‘stream_enc_regs[2].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:283:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:284:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: note: (near initialization for ‘stream_enc_regs[3].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:284:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:285:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: note: (near initialization for ‘stream_enc_regs[4].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:285:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:286:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15: note: (near initialization for ‘stream_enc_regs[5].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:286:2: note: in expansion of macro ‘stream_enc_regs’

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
 drivers/gpu/drm/amd/display/dc/dce120/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/Makefile b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
index 37db1f8d45ea5..a9cc4b73270bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
@@ -24,6 +24,8 @@
 # It provides the control and status of HW CRTC block.
 
 
+CFLAGS_$(AMDDALPATH)/dc/dce120/dce120_resource.o = $(call cc-disable-warning, override-init)
+
 DCE120 = dce120_resource.o dce120_timing_generator.o \
 dce120_hw_sequencer.o
 
-- 
2.25.1

