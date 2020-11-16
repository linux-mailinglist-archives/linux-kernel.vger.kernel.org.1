Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070312B4E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgKPRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbgKPRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:14 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A3C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:12 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so46987wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XjzABzYijzfUYSQAFjSWGgtY8O6T4iGtJT/GdPVe/g=;
        b=f7neOg4p2FtX/vppSn6QN4LztxxWXPO5PsEPG4P1pfWm9ayx4ZaCXP7Qy5MqXIyTJc
         szXloESY6VRWVHOrJFA0WDsNDfNySfQbMAttyoqqqrPShI2NHvwtsWMnnVe90jgsu6/k
         RfOFgRTAgrB9QnazseVDq0C31vlwqKRYp/3Iv9uR/1K+XMNC2FUSHUFAbjWZFBxEqLMJ
         5yM7hZMKGVWVIANE4KarSM+svzza1WdFLdf+b51OHuQcgM4RzIu0shsgULOJyqo5wxmx
         EpGBaE7lPbGEd1xXXmTdM9La82KremeZzH6buoeGQECFzv4wW0EUHa3LjPQsOWRIRaD3
         rhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XjzABzYijzfUYSQAFjSWGgtY8O6T4iGtJT/GdPVe/g=;
        b=mjRRxghhl38M+DrAioYWGSmXci3WRfoqhc4DltGT16GUbsevVucUiI8nTQ9yB/j1W9
         36HNKM2GHb4AYkJP/8RsNQxme8BKZtgeygd8oqGYNxCm0wBMvY3xCPIscW8RXRyGD2e8
         8eDq5A5Dzx3V3aEAACUTnPlzM69eGFcDpsPGHgauNGLZuZllyuWH84Q+1JalTTJrN8yD
         nb9GJlAq6K50aFMvr7ZDzcRGP0go3Oi8upk7DCrP3GjmY8OPx0WNpeOFEPmaspi5Clz8
         IE1Hkac/ge5NztvbMjPUWQmoBIihZr2/TWSRUiJ4fkaxHuTmK2sTxgBLNODIZIXa0nCB
         /tQQ==
X-Gm-Message-State: AOAM530zHsVVL7ZUUwHzi/RCvX9YZO0fiT7U4WxS5PJLsmuRPM2nFBG2
        4pkExGqvcTPznE4k8kG2WW9KRw==
X-Google-Smtp-Source: ABdhPJxD3PsXkkAcAPwL+o29CIkE9xzELIl6mVYJ526IXOd8g4jWPgod5PLCtsJAgJzqn/4rRNKQ/Q==
X-Received: by 2002:a1c:c20a:: with SMTP id s10mr8267wmf.23.1605548531381;
        Mon, 16 Nov 2020 09:42:11 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 36/42] drm/v3d/v3d_sched: Demote non-conformant kernel-doc header
Date:   Mon, 16 Nov 2020 17:41:06 +0000
Message-Id: <20201116174112.1833368-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/v3d/v3d_sched.c:75: warning: Function parameter or member 'sched_job' not described in 'v3d_job_dependency'
 drivers/gpu/drm/v3d/v3d_sched.c:75: warning: Function parameter or member 's_entity' not described in 'v3d_job_dependency'

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 0747614a78f0b..452682e2209f4 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -63,7 +63,7 @@ v3d_job_free(struct drm_sched_job *sched_job)
 	v3d_job_put(job);
 }
 
-/**
+/*
  * Returns the fences that the job depends on, one by one.
  *
  * If placed in the scheduler's .dependency method, the corresponding
-- 
2.25.1

