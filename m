Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414E22F1F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390948AbhAKTYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403772AbhAKTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC08C0617AA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t30so972639wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qokjD6k+LHHF78mVRlZu4OQtVVLhVZTnUnkH0SWg7U4=;
        b=Y7hRLpaw1tA7qK1gE0XMTHNgfJoJa25sR2HTvgV5c7RjonfBp0XE2iRIsnCFMtGO39
         S+NEpJl2eaEmALDQRKx8ppkwsCoVWE3be6ZZJFzOuP67Xvztt95hteobDRDSxOb/95MM
         lKRVIyo4wj/LQnNfBuNrjra9ty8cH1ugArBlzNWr6EHFKCOUdEWycKG234cNehdzJ+wP
         0QDVGyYLbpKAFH1a21yyszuVT9kl0cgGtmbtDEQiL1HpMRc+hvrgqhNAQ37t/CyQBE/L
         UwaAKv90//Snerjrws6nYy8YrKhwdfpClNDZ0IvSLAcuPPQJeDDzpFV92/gqloYExeN0
         eYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qokjD6k+LHHF78mVRlZu4OQtVVLhVZTnUnkH0SWg7U4=;
        b=eBMQgYGaWg+eQfiuPV7FY8Ait5HYpJbts3PMM1/M1ybORUXdUcW8JJJFnXMIeYqaVA
         /78tyo1brCMgH/6s+RCGFQc+t+4l+IWACqATwLVn64drmysuld5RNb0rmD9Lwi2aFabP
         LRBu4zDfl/JpeKlx8WcvYrqZvhuNpfOcwT14yvSJ+5nY/bZNB5daHTTexgaiMLY/GU+i
         EVq0fCRljm/PstXlebSsc1YiAg5epNdBcFsw1M/DT6N5QwNOLvOB+lsJPY25Lon0Y1K/
         vrkmAUSDAW3cYw5/O6OQ23pGXR2BLQ5tcF7Fl1vPd0G7c4odqqyzcoyyJ/v2R1PUPrHA
         gknQ==
X-Gm-Message-State: AOAM533RhZE5WTEf60OCKnx5Y6iaiep0LcMV/cB4AXQOL3WqjzQyaNbD
        I1C6PkbftwgnhQYOgrDN9YQXHI5JVbSeh+8Z
X-Google-Smtp-Source: ABdhPJzjSnGz3m69nDkME1UYSAct3l1QQN+GkRACjqqKTZWxnotX0x9Ssham7MB2ZUEAb0ssDpTGyg==
X-Received: by 2002:adf:c449:: with SMTP id a9mr570620wrg.281.1610392780828;
        Mon, 11 Jan 2021 11:19:40 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:40 -0800 (PST)
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
Subject: [PATCH 08/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag: Fix struct declared inside parameter list error
Date:   Mon, 11 Jan 2021 19:18:54 +0000
Message-Id: <20210111191926.3688443-9-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.h:30:43: warning: ‘struct hw_factory’ declared inside parameter list will not be visible outside of this definition or declaration
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.h:30:6: note: previous declaration of ‘dal_hw_factory_diag_fpga_init’ was here
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.h:30:43: warning: ‘struct hw_factory’ declared inside parameter list will not be visible outside of this definition or declaration
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.h:30:6: note: previous declaration of ‘dal_hw_factory_diag_fpga_init’ was here
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.h:30:43: warning: ‘struct hw_factory’ declared inside parameter list will not be visible outside of this definition or declaration
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.h:30:6: note: previous declaration of ‘dal_hw_factory_diag_fpga_init’ was here

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
 .../gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
index 8a74f6adb8eee..bf68eb1d9a1d2 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
@@ -26,6 +26,8 @@
 #ifndef __DAL_HW_FACTORY_DIAG_FPGA_H__
 #define __DAL_HW_FACTORY_DIAG_FPGA_H__
 
+struct hw_factory;
+
 /* Initialize HW factory function pointers and pin info */
 void dal_hw_factory_diag_fpga_init(struct hw_factory *factory);
 
-- 
2.25.1

