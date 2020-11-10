Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86FD2ADF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgKJTbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731407AbgKJTbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385DC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:21 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so4353227wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ToBBreDHzaPMHuGxgWs2PDlm690Qx/WYYnHDqhADX+E=;
        b=scT86LXlhwD/DGSbfeKqxrvBZQbUfExTEwqwwRUosV9TeiTlMaBH/+fiuQk7cwD1HG
         NQhIz85g6rfkkDEVxoHAm0VjR/WaNbxZi3M2QSb9BAjqckjkOR3fgvY/dSvULx6sTGOs
         8Y3EVQg2T1B1gYfsHlhsiyxoVsaEqZm57YEldw87P7kssVR6nNYY6jw5zxZ3MsrnHpN4
         rXRXNn6hEOWRrg5OOWPspraA76rLCQXC19a/bVYTFw+cKXqSE9k1Do3I9rcO7sUVTrkR
         /DinK+Qgi0KZfaVkPhLkKWtGVDswYtdOp6bK0cDnrpYgOXmfbY0UrzMdkxOEbI7tTFLP
         jUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ToBBreDHzaPMHuGxgWs2PDlm690Qx/WYYnHDqhADX+E=;
        b=KPIcqmk3jrve4nTrPLvmvrm3v4TUnTgZTBZLcvobNcO7I/+MvvbQG0CCfirIcgK0/9
         ETfBfhQ1fg9iZIoxTm8SGBEZMq3X0fWN/vTmb9GKkSxrgXxvnnr1SLDjCUf/MPglkpia
         5otpGlXmqCiAcpkTdHaFmCdO1ryQB2MEZR25yetGMf/On1XVmJFw0axx6L+NfMwSQOhD
         1s/QTBm4OFBoexmfFh/6o2DboeLHPjJTjdnTxMosdoiXXm6StRQMaCKiyyRMK8trbyiv
         vpwVIP/8xy6AQEqbDUg1zzIKRFBugRXdD6G8z596VEluMs4FXGJ6OGMWhtlXyEYagb0C
         8fvQ==
X-Gm-Message-State: AOAM533LxsYzNEYj6ryBCD/+SBB12kIQZ0Hvl+7uSffuEvt+tqwD/lPE
        HpTR6xyhk3CSaeek6w3FozdH0g==
X-Google-Smtp-Source: ABdhPJz2igbyZB5EVCWg9R4fz+S8+6prWa4uSVqzlzHX9F+8xc7URJs5tf1K9kCZx4X1EVBqd+tcuA==
X-Received: by 2002:a1c:3103:: with SMTP id x3mr705693wmx.107.1605036680213;
        Tue, 10 Nov 2020 11:31:20 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/30] drm/radeon/ni: Demote vague attempt at function header doc
Date:   Tue, 10 Nov 2020 19:30:45 +0000
Message-Id: <20201110193112.988999-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/ni.c: In function ‘cayman_gpu_init’:
 drivers/gpu/drm/radeon/ni.c:2679: warning: Function parameter or member 'ring' not described in 'cayman_vm_flush'
 drivers/gpu/drm/radeon/ni.c:2679: warning: Function parameter or member 'vm_id' not described in 'cayman_vm_flush'
 drivers/gpu/drm/radeon/ni.c:2679: warning: Function parameter or member 'pd_addr' not described in 'cayman_vm_flush'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/ni.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 53a4d5c109794..12dd082069649 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -2668,11 +2668,9 @@ void cayman_vm_decode_fault(struct radeon_device *rdev,
 	       block, mc_id);
 }
 
-/**
+/*
  * cayman_vm_flush - vm flush using the CP
  *
- * @rdev: radeon_device pointer
- *
  * Update the page table base and flush the VM TLB
  * using the CP (cayman-si).
  */
-- 
2.25.1

