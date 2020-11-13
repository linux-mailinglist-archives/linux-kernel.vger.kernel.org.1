Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0701D2B1C73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgKMNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKMNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:19 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02634C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:19 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so8559990wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nBtcs67BpWpOtsS+lroYBZ8Diqx4j2HTgrmz/2vMqY=;
        b=MZqbEth6gfS7gsdu8IDgb7OmV3SEY4rst4Sy2mkC6oksoLOtw6fd22wjt+QT2/Yw2H
         62bL1YqeHmtIX6VodEiiU+N74OMmHF2P3tuz/aHXhCn+9HMoG7z9b4NJBuXg6ytgHid6
         HE2Sk7dx4QRuNx7vDJ1UG6liqfUrpDPgTGAY0pP+XzXaQQ1lqH4kw2gTA3NUxQtTrLtl
         wi0i/JshReJaWzdC+Wqguzyj/iwJZIDR2991HnAHfb2QxqoEFRV9LfJH38BHW6tTzqBW
         JZNCBDhKFa8U64wvxMiCTkhmUgv+ojpTS4RSvfMh6LDeBb9EPee4VhoqIC0Uh5N+lw+7
         leMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nBtcs67BpWpOtsS+lroYBZ8Diqx4j2HTgrmz/2vMqY=;
        b=S8G0u8XoCcAaT5LN20wjhhf1826b5Cf9oM1Kj5pE5SwVxZ7jwViRPn/Mr81I4xa7Kh
         j/q5/+iyqeLtzJhaFt9Azlli9gEpinmeByP7D5Ykf0sLb5TfdOfj27VS9SLLtwQoyMTQ
         NemVipXYnRW/+DB6QCqsqMteq47G2c/7sGcn4kViAgd3pT7L1Cytn4+8YxPkur5X6q5b
         urE67pB849kI78Ko4gXmhlciTahqnLIbwIxzkRXfUzGJGxfiXHYMshxZHtrblErf8O38
         cJswlW2gzpN3ndPQwuJi9Irf+h44IJGaMd0pJI09zWEfaamyegpax1CLWj6DDcMHRdkU
         yWvQ==
X-Gm-Message-State: AOAM530z32VPkFXjWtR0KihqmEQ1iEdF4kNi2VVoK+Jdy/n4nKcIAMoI
        VwEA+xFTGfuf89adDsCgfSw/gw==
X-Google-Smtp-Source: ABdhPJxu5mybMd3oZAipyOuLv/NoqB/Sknp+7MJ4jdBGXBUKsP93PylVtz4Lu+Xsi+XwvfjExrOung==
X-Received: by 2002:a7b:c089:: with SMTP id r9mr2532584wmh.45.1605275417717;
        Fri, 13 Nov 2020 05:50:17 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Monk.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/amdgpu/amdgpu_csa: Remove set but unused variable 'r'
Date:   Fri, 13 Nov 2020 13:49:27 +0000
Message-Id: <20201113134938.4004947-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c: In function ‘amdgpu_allocate_static_csa’:
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c:40:6: warning: variable ‘r’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Monk.liu@amd.com
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 08047bc4d5886..da21e60bb8272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -37,10 +37,9 @@ uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
 int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo,
 				u32 domain, uint32_t size)
 {
-	int r;
 	void *ptr;
 
-	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+	amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
 				domain, bo,
 				NULL, &ptr);
 	if (!*bo)
-- 
2.25.1

