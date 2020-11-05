Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69B52A8199
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgKEOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbgKEOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:22 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:22 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so2104592wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbt6Bt9xb+nEOL+sC88FIyMMDCRwxeU6Sb1wX9bISpg=;
        b=Fam3S7jhyYU7Z3NVpeOT6nsSRFnhdHgQmCdaWhPs/Yr784DIvf4lSZhyZHm2kJR56B
         xFeYjjLXHYSZXkqWhyT2ShuGYnKzxLHPnefwdaOp8hMNZV2apCFXYCYmtM2cgs1iwSfU
         /9VZfe69vuzcpbQb11b7TYnFXBRK9Ha/1DN1lG5nS5Tg/bckPfi2G8c4ImLNv6WThk4y
         kiAwvcINQwP5e8wsl/NVsQ1wfRvGCXS77nJZpnFrQuQvrJvGByjSikVklVVtzAl/Pa0a
         jXTSoylLp28E6q1VPfcZ60zbGwaQ4FEK5FQQu2wjmDXStRYgwELevsk7O/w7zazaDndl
         GIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbt6Bt9xb+nEOL+sC88FIyMMDCRwxeU6Sb1wX9bISpg=;
        b=a0pLDdhLBte2qW1KuCP+gJK/bah3stHcgV6mJICnvqwVxNKsYGwPu6EREcZPixv663
         GbcHvZNWE8Huqy5l1vJWU47Ln3I6r3GsWL9FoN1ICIu/7T8Eo/2+AsvJh+Yi2PfAjq+q
         BIdv1EtrXgCeXouu+cVkCk/uR1MWnpgeyNelBKo6Rzo90cNfLYZa2xF5pHoW/BRgxzl1
         RQXW/QqnE+kkPplHT0K6YXSiL3wO8yyQBbnvoiq9MjOTZEgvt2VGzR9zfFT/60LYbkVr
         Yc2BX9VEIOIH3+lWgvlVXdEapGdzvU7fhPEEWH0CEUi2EyRc89Nw8rtL5cHGOzc6AaUw
         Msuw==
X-Gm-Message-State: AOAM533DghVYFb+IyP2Cgc/xCSGDmvkg06ii+56PfVxue3nQqEOLi1n5
        irp0LLwzajvauV/JOX8bQ7RIhQ==
X-Google-Smtp-Source: ABdhPJyUVy8zvMojF9OfX8R20eVTkRIbuvjv/KNiuhzS4OiNxtWZb4zKr0KnzrRzULj0tbNM0uBdEA==
X-Received: by 2002:a05:6000:8d:: with SMTP id m13mr3373575wrx.216.1604587940699;
        Thu, 05 Nov 2020 06:52:20 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/19] gpu: drm: selftests: test-drm_mm: Mark 'hole_end' as always_unused
Date:   Thu,  5 Nov 2020 14:45:03 +0000
Message-Id: <20201105144517.1826692-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the macro drm_mm_for_each_hole() 'hole_end' is provided as a
container for 'hole_start + pos->hole_size', but is not utilised in
this use-case.  We cannot simply delete the variable, so here we tell
the compiler that we're intentionally discarding the read value.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/selftests/test-drm_mm.c: In function ‘assert_no_holes’:
 drivers/gpu/drm/selftests/test-drm_mm.c:57:18: warning: variable ‘hole_end’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 95e212a9a74d2..b768b53c4aee3 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -54,7 +54,7 @@ static int igt_sanitycheck(void *ignored)
 static bool assert_no_holes(const struct drm_mm *mm)
 {
 	struct drm_mm_node *hole;
-	u64 hole_start, hole_end;
+	u64 hole_start, __always_unused hole_end;
 	unsigned long count;
 
 	count = 0;
-- 
2.25.1

