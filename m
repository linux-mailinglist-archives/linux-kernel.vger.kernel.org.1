Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A3E2B0D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKLTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgKLTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:09 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE91C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:08 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so6227926wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XjzABzYijzfUYSQAFjSWGgtY8O6T4iGtJT/GdPVe/g=;
        b=hFoFvSk0RVCLvoyXY3E9rvJ4S8VZS53n4P8SsQDSaOHeYEomcgcNjMTGKoW7VcqpK2
         0WYl7lst1BAj3aTzSzHW4lhA+Q6GdndC4zkSKbWo/kaQpmNM/n95UChxDCI9RGurqGgl
         L0h9o6SqtmnfSg+gc6D6ZiEWjI2Iin+Dln8erFX3NK0/rQ9GCV2/yhvItYub6NcVv6Xs
         nhynMv5eprTb6uop9fTqlY35t+0ssviqUqPtTNYZ2ILg6PfEDq7JQtm/gxmVwCYQx/qi
         82VcT0/H97YqKtTnCWSCEkiC0tdRvPh64qPQWDsplzKZGidW3nj/8lSNZfWThCZfSCPN
         MTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XjzABzYijzfUYSQAFjSWGgtY8O6T4iGtJT/GdPVe/g=;
        b=CYcCvNjzkDlbK2XSN064QBlTy2rVWBh8wYK4dYVOQTrvO/Zt62xK8dsykeCKr0KWle
         yaoSZWRQIu1Avxp9mQDG7OgAgP2BjUEqJkMu2lFmmEI0hWHdKfUo+1M0U/HUDCdzZgPW
         poodpSi+52Lw/b70g5p86OCF7aIgrZmctGuz6491XVjc4Zu/YI9a3y/fGLc5MoOl07tr
         akqqRYdF25qByYBYywGoW5wGN3QIKp1yUftZGcvyRZnroEWwjEDO5m689lfQ4CKQsRc7
         ufGpKBCq1Bpa8ry+IzJ2AHx/WM5t1bLt8hbNdyisTAkANICkRWSfSxVQ9sMHLIc2skNY
         xMpg==
X-Gm-Message-State: AOAM5322XFuH0wew7EV+UoE6XmCK8HQA+glwUszPoVQehzTVqL/ggdg5
        aMbrdyCNNTaAbgMQvKa6WnA4xw==
X-Google-Smtp-Source: ABdhPJzxdvquo2Hv6TZn6veanz+U/LtwnBla/tlAUzx0OQpDj3B04ZO7JfC+MON2gKA11pzmZ++P4g==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr974063wmo.97.1605207650573;
        Thu, 12 Nov 2020 11:00:50 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:00:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 05/30] drm/v3d/v3d_sched: Demote non-conformant kernel-doc header
Date:   Thu, 12 Nov 2020 19:00:14 +0000
Message-Id: <20201112190039.2785914-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
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

