Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E562C5635
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbgKZNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390785AbgKZNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:59 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E87C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so2218730wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVaLmyvacPrY1rDoSMt/9G1ek5c/J/kPXEt2r1H/RjI=;
        b=F2cBuUeywubkOSdIZeQQGSOkWu7bs2lvYsnoh/sMGgtoODB+x3nOzrprIw4bW+NOhC
         1HArIKXo5vW+OQ827Tml7/kmK9Q5iXrEOhIU1LTaiwJJgCo2D2VV6u/5cI3BzmzPKo8L
         dxzGm1Z5ZWfFHWMwWyIZauQV1ZDzwm6vHRVMkrXmPtyCxcsTwuBj0cUsbf9iUNkTvcbE
         xTMgeqcxaGa3H4pLwbHbD4QvzZnNl4LhAj/2rOFjLjhmxKaRTZQnBKPd7uMFlzbHuoHi
         Q2lzTkJiYhrcjM9WpL6pUdQAEwXmYDU90a5gi9HzoDIZ34X3+FTwbxugBc9iTWbywbPj
         d37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVaLmyvacPrY1rDoSMt/9G1ek5c/J/kPXEt2r1H/RjI=;
        b=htx1o2mhYPLPltPuictQSyRKrgyjt9QcIihXsSHsSPTGEYwIzPo5B7ML2ffohxaJ2q
         IaFXhznEuAjeAxD5V7UKNCDlmXpSIJDaQc2bENMmH4UZeYhvhiiPChwOHS2ZOpu207P8
         MGOQkPb/xS+kX7C6W9WzbixLVDzlxQBQaSViM46yiYF/dHSQwRJ60mIBEvj4dItFkqWL
         w6p0ytzzW9zcTcfxcIfclxlp0JWd0Fd39x05YtjISF2yxb7dQQHOJ6wfsUG3V/ThDtk2
         VKawfsE8sTOTtEY6ycr07LqCjLWct4vFA+6K6RGkxmLhcTfR+aNUmLh+O+r4s/6yuQKF
         en0Q==
X-Gm-Message-State: AOAM530H5U6RldsqosX+wx8wq3B+h1+hkRebOQiFhBqug31WZSlOti/9
        eAjMiZeD8s1acG9LH8rWk8jTjg==
X-Google-Smtp-Source: ABdhPJxfI0LU2ckWg4e0UGMMQXSTJKeWbI4Br1gKXvc+4RK9MNkeL8wdqdRuMbFSyo6qKpVFgmsJsQ==
X-Received: by 2002:adf:dd04:: with SMTP id a4mr3979594wrm.77.1606398175472;
        Thu, 26 Nov 2020 05:42:55 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Demote kernel-doc format abuse
Date:   Thu, 26 Nov 2020 13:42:07 +0000
Message-Id: <20201126134240.3214176-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c:1107: warning: Function parameter or member 'mem_clock' not described in 'fiji_get_mclk_frequency_ratio'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
index fea008cc1f254..02c094a06605d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
@@ -1090,7 +1090,7 @@ static int fiji_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 }
 
 
-/**
+/*
  * MCLK Frequency Ratio
  * SEQ_CG_RESP  Bit[31:24] - 0x0
  * Bit[27:24] \96 DDR3 Frequency ratio
-- 
2.25.1

