Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D542F45EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbhAMIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbhAMIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:22 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF708C0617B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w5so1043336wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TuIgFykBDNAyCTS3nlQLhUgyjjMaofDJMrakOYVbGJ4=;
        b=OPbeiTnztfD+0HsOGRAz/algFIdjza0Mha4+zjTi+go+mtYX28fmkqErpS7SPSYwOY
         0BlCN8/kvWgv/s7Oza70HVI8XBi8b/gbWFuWbUanSz5AtgNsgcH8k6vQJ779zWLtcoOd
         xouoN/uj/J5mWVVynsDWHxvX+k+He0q0DCvdU8LSGF3ubQE20BV+piQw19OFFgAE1IW8
         6ayHGDpbV9BT1Zfs/n8NYbVeVCSDOjiVB0bHnSH9nMio0PQMKv1yNhlR2re0fHyvvKy4
         mqOThv9t2wscoM+aKNDPvmAB1QY0hSgUH/aVX7OK+br/m/D9WjooGUjAbEnNPv4lJnx5
         uDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TuIgFykBDNAyCTS3nlQLhUgyjjMaofDJMrakOYVbGJ4=;
        b=iisTd/MHLH+eHJUsaRpBN1aqz/vTUWgM854p5bBt16Ds6FGaB9O7S8T+fVaGp7bW7A
         qEMTAhW5Ks+CscCNA+TJK16k4Q9+feMdTLXLPx/7owKiB1t/pOH5J3bzZ7RfTClxwD27
         lo3sSU/lByT6V8Hpn2kca4rdaHxYDx7pIaQDogROCvhOsBmRQQ6eGecel+R9yoMetkef
         u2J/u/8tO5GGCkd8iCLDGs+bNVZgnb4CFvmLa/Mm9oQfCOWmhSDB/Ad0UPy39CD2/x6I
         rdH6GpgnsaSEcBcMSKTxLhMq6cSz4V0EJscSrgWDE33splyw/VYc/E09zlw4HzBzFqHu
         jv6w==
X-Gm-Message-State: AOAM531N70pGvvOLEQ81HTg6BL1lCXW0HKiAiN+6QLwH9SjsIo5hOzZ2
        fj7H7xcXO5CP4BHmWfo4NU62xw==
X-Google-Smtp-Source: ABdhPJxGS+miZsOX4pjXXNJB2F7W2rx+9Yk6/u0aWVW93nTCONywWM1HcBZORVasZfBrn3QtvOKAyQ==
X-Received: by 2002:adf:8184:: with SMTP id 4mr1226871wra.63.1610525292458;
        Wed, 13 Jan 2021 00:08:12 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/30] drm/amd/display/dc/dce60/Makefile: Ignore -Woverride-init warning
Date:   Wed, 13 Jan 2021 08:07:35 +0000
Message-Id: <20210113080752.1003793-14-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:28:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:155:14: note: in expansion of macro ‘mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note: in expansion of macro ‘SRI’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:181:3: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:185:3: note: in expansion of macro ‘transform_regs’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: note: (near initialization for ‘xfm_regs[0].DCFE_MEM_LIGHT_SLEEP_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:155:14: note: in expansion of macro ‘mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note: in expansion of macro ‘SRI’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:181:3: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:185:3: note: in expansion of macro ‘transform_regs’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:645:43: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:155:14: note: in expansion of macro ‘mmCRTC1_DCFE_MEM_LIGHT_SLEEP_CNTL’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note: in expansion of macro ‘SRI’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:181:3: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’

 NB: Snipped lots for the sake of brevity

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/Makefile b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
index 7036c3bd0f871..dda596fa1cd76 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
@@ -23,6 +23,8 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
+CFLAGS_AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
+
 DCE60 = dce60_timing_generator.o dce60_hw_sequencer.o \
 	dce60_resource.o
 
-- 
2.25.1

