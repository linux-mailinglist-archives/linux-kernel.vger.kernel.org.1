Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB12B1C90
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKMNwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgKMNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F4C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:15 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so10020334wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzoA0/p90w69kCv3e5Q2d2JhA6KtEucuiNdT/rFnC4I=;
        b=ox7jf1lZwfwZsOGGRxrgIuDFmMt/t3EA9CY44da6nxv97y3o6P6e3V3SK8STEuDHTx
         uieKR6jD3bQvVud1bFo69dW/kuNx60kde6emW4UAetcflcKaRTsuDtMcDWUlmxyaJwT9
         wOuJ42ZmsGwUk5Cd9hwHMfR2knehgRRvTAfmqo2DDU33pgXSrhJGPEx40GUvbRPorBxG
         jAt3PWNRMXwOxUkY6KekxOtr8lyHSCT3eTVnL+MlKsbvcZDU4Zmn9ZRUCW01FI1S8fNc
         pFScRBfMNP9nq7H3qm4Zz/b7hlbWIg336mGnECdKl9XfzjDeWdTBlXyjqjYCZftHhCP/
         ReoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzoA0/p90w69kCv3e5Q2d2JhA6KtEucuiNdT/rFnC4I=;
        b=T/fZ/Eh073q2BOVurvB2kyNDjE0krP/vBp1ObpDbRJhe1KaXeCF8vMWiyEQEFP42Tl
         FnWWwZLe4SQGvAgGOfC+EvDJAlPOj+mhu7eQrkzeswYoFsoaIg582s/Ae3XyxEpFVf7F
         feEA0SPqB1y8ME19jUWudCrM1ysES7L8c3hzcbyyZZBYkpvP0AxUhbWzxPgEWvXVnKD+
         NMoCLn6aSLbBmKBMnA8HLjUuaXf5az44tLqREWKxGN9SwRdfiqa0YIh9LCVY+f5MZl9f
         xnCMqaIuQD4lGtMsFw9DqUYCu12lu7/oHLj6CRcD2IP2Q6E4sWhVNB7JgYRqd1EdnIhg
         lpAw==
X-Gm-Message-State: AOAM532mJRkg0YLwp82vUMZCkomW3CfO0IqlnaXfeJgIOsqRvv9mbmLb
        dH+FKEqg3TZ1Pfhdqvk3Iq8NkQ==
X-Google-Smtp-Source: ABdhPJyM0RmlKSiadoyRmHxlgxkTDo9JK/uvB3fY0ok0WHJM9+gvf3MjB4rxoAncUj/U16DHjVwYaQ==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr3531340wrw.176.1605275413797;
        Fri, 13 Nov 2020 05:50:13 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amd/amdgpu/amdgpu_gmc: Demote one and fix another function header
Date:   Fri, 13 Nov 2020 13:49:24 +0000
Message-Id: <20201113134938.4004947-27-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:69: warning: Function parameter or member 'bo' not described in 'amdgpu_gmc_pd_addr'
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:121: warning: Function parameter or member 'bo' not described in 'amdgpu_gmc_agp_addr'
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:121: warning: Excess function parameter 'tbo' description in 'amdgpu_gmc_agp_addr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 056cb87d09ea3..fede84509dbca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -61,9 +61,8 @@ void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
 	amdgpu_gmc_get_vm_pde(adev, level, addr, flags);
 }
 
-/**
+/*
  * amdgpu_gmc_pd_addr - return the address of the root directory
- *
  */
 uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo)
 {
@@ -112,7 +111,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 /**
  * amdgpu_gmc_agp_addr - return the address in the AGP address space
  *
- * @tbo: TTM BO which needs the address, must be in GTT domain
+ * @bo: TTM BO which needs the address, must be in GTT domain
  *
  * Tries to figure out how to access the BO through the AGP aperture. Returns
  * AMDGPU_BO_INVALID_OFFSET if that is not possible.
-- 
2.25.1

