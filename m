Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C51E2EF8F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbhAHUQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbhAHUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A03C0612B1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d26so10109808wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gaclGYPTxeR7WBpYSGtVJvFJoT+8qY5x3DkdzDetH8=;
        b=SqJbv6z/H/h280tKiGBaUND1On2N5BCO4srcqVAHaTgcNtV7jTozwCRnj4CHVMkOUa
         hwMmdG80+qYFg7oT+DYhrpWzZ2CifvdrKfhMenuiFXpC0TyuJfb2jTby9FLrOF7E6E9d
         r4OIe6PSFoLIJvJKD14l8vN2kr3wcW6855SxatxD7IgJmsrcUPMCL3pA/qshHfneN1b2
         gqJK74bskfTblQATgZFm7+u6+PvytMZNaEh6y5TrI1If+L63a3PCQeByFRzEunJz/lud
         DjKVXydiJxhmQDCkT8dz8+SUfLB66A2MrIrPEVIMwREIctYSfOqDT445cHOLpewGSEML
         7zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gaclGYPTxeR7WBpYSGtVJvFJoT+8qY5x3DkdzDetH8=;
        b=Gpe6u32pCFK8ciEAQ8TqZERslpEXZKWPILv67NKef2Yoa2UndUbcF7WNpMTOfBCHSa
         DiuJ85co+5y9UinPU5X9f2nvdMS3K8JY6XdrLl5OjufqRfNMyVHN7CE5C8rfr4xq7VdK
         6OBtukvFtfwqI8n0PRGJQMZ1DsrN+P0I20APB6ZNWe9kx9AW2DP0Mnc0wuLBxxlVQmle
         llH5g1TrWELPGw9QHQIDWDOnpbO6fC9aA4KtWzJCfXkoqUAsTUSC69qafYvimd1aao7F
         r2oHnvsLqxZkVf/WNN2d1xIMnkSyLnHoOxtcQbsX8r6VVKU7ngHbz8V4qR6PixTRPR18
         6y8w==
X-Gm-Message-State: AOAM532ZN+eNu8Jl+/atN6/J4M80s6J+sR+N+xGkWmC4F/39gxYq+hey
        bzl/LvFS6gzbXgwGJO6Q7y5dwA==
X-Google-Smtp-Source: ABdhPJzEqhllmXRVkRE8iaa+TVUusuA+KYsBX48+tvXKZIyZNOrHPERzAqkiKUo+xHHNAxEb+ajuVA==
X-Received: by 2002:adf:e512:: with SMTP id j18mr5227504wrm.52.1610136933894;
        Fri, 08 Jan 2021 12:15:33 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/40] include: drm: drm_atomic: Make use of 'new_plane_state'
Date:   Fri,  8 Jan 2021 20:14:37 +0000
Message-Id: <20210108201457.3078600-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the macro for_each_oldnew_plane_in_state() 'new_plane_state' is provided
as a container for state->planes[i].new_state, but is not utilised in
some use-cases, so we fake-use it instead.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function ‘amdgpu_dm_commit_cursors’:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7649:44: warning: variable ‘new_plane_state’ set but not used [-Wunused-but-set-variable]

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/drm/drm_atomic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 54e051a957dfc..866daba4c4a55 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -847,7 +847,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 			     ((plane) = (__state)->planes[__i].ptr,	\
 			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
 			      (old_plane_state) = (__state)->planes[__i].old_state,\
-			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+			      (new_plane_state) = (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_plane_in_state_reverse - iterate over all planes in an atomic
-- 
2.25.1

