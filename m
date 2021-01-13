Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328D2F45E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAMIIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbhAMIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:08:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF9AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:07:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r4so707608wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3c09B7R1bDDRXGkxc3zYuL5FdMguU7F3ASarhgkkjYk=;
        b=Ke29S0ckRABZRt5qaiIctSaJXdhgxyEOAbb+lrGjHH1heF05KLBmidxzRCinjxGbsl
         yn+acgZowbs+SW5i8xy0YiLb6/vzQHz1FI/FFNsPWlSA8mciP787U5U+rWyGhaPAPTE6
         W3Juay2xlCPWy4fQJdzS9QlgYba9pB5pLOJlc8Gc1cCokpty0a4RMuYjbAxzd97hpPbb
         w5UjdWee4uUdmxsy3ICv8xQFCrN9/9mVfpW8pqq38Lp6VYnmvx/eTyL6kdNRPiOad4mO
         NvbBx80+MSILnDc84d7iW0X1Shhj1GDMhSA5R11IISAKv2baeSscTtfgGU+6123gR2OX
         m56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3c09B7R1bDDRXGkxc3zYuL5FdMguU7F3ASarhgkkjYk=;
        b=ehddoRvXJpwPSzHByyBlwRf61Op0MwSbYjOHMY29bwYGDGMkrNCydAJF0pAPsmlRR/
         VO6m6PN0S4KWk/KD0Ak9xq4H9/ni+P6l3rmebYCHZbWzvqZw/NHf4o3Sc5yoiWXz6inp
         lm90AnRLrM0k0ZzTSIWwQy9ulCeBifd9s/V+usxrM562MK0guIyo4UFezGB4Zg8xx0uB
         sJF2bfilAH3j+gQzT0RPbw0jxJZ8xBwrqsFJt6SafeUq6KQM460O+HOhwuKU1lNS7Ccm
         fspyPTzAZMxh1kMLGha4eCRaPISEMITGY2HarupjoLpIfOUgq6kSAAV3rChGpAcfnCE2
         wN1g==
X-Gm-Message-State: AOAM532giYupiylJVJixovzNcUWHATq+a6vYJ+j8ogfbOjPFDBI1H9ON
        w2erBX3lUuqlp9In8VlMFpEqNw==
X-Google-Smtp-Source: ABdhPJzFZznC3mc+syBSkyi9EiTbDy+X0VVbtJPk+qXMX1WPaf2niMuM9Omp5aPWXqpVk0/5XmSQMA==
X-Received: by 2002:a05:600c:224b:: with SMTP id a11mr931054wmm.97.1610525276970;
        Wed, 13 Jan 2021 00:07:56 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:07:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noah Abradjian <noah.abradjian@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/30] drm/amd/display/dc/dc_helper: Include our own header, containing prototypes
Date:   Wed, 13 Jan 2021 08:07:23 +0000
Message-Id: <20210113080752.1003793-2-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:299:10: warning: no previous prototype for ‘generic_reg_get’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:307:10: warning: no previous prototype for ‘generic_reg_get2’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:317:10: warning: no previous prototype for ‘generic_reg_get3’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:329:10: warning: no previous prototype for ‘generic_reg_get4’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:343:10: warning: no previous prototype for ‘generic_reg_get5’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:359:10: warning: no previous prototype for ‘generic_reg_get6’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:377:10: warning: no previous prototype for ‘generic_reg_get7’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:397:10: warning: no previous prototype for ‘generic_reg_get8’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:503:6: warning: no previous prototype for ‘generic_write_indirect_reg’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:511:10: warning: no previous prototype for ‘generic_read_indirect_reg’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:529:10: warning: no previous prototype for ‘generic_indirect_reg_get’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:560:10: warning: no previous prototype for ‘generic_indirect_reg_update_ex’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Noah Abradjian <noah.abradjian@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 57edb25fc3812..a612ba6dc3898 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -34,6 +34,7 @@
 
 #include "dc.h"
 #include "dc_dmub_srv.h"
+#include "reg_helper.h"
 
 static inline void submit_dmub_read_modify_write(
 	struct dc_reg_helper_state *offload,
-- 
2.25.1

