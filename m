Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206A32A9F68
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgKFVuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgKFVuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:02 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B88C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:02 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so2658057wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E44zAySPmawq+qLbsH9q5xt7WGcYQXLEVwBfYO570wQ=;
        b=cVJbpGO0mn9PFOK6wV3RI1ztFhosLDnGLAYO4ev3T9QpIRZ2SSqsEx8FWEUkN+upm/
         HS8YHS57ONCD2IVwBKqTIIoyLLrbNFPelDe5IxCJ8PGsFiXgXqe7cLhkoTUrAoHixgZo
         KDP2patea7yG8pSvObvQ56FR4KjPr651sE8b30YFsZQO1CI2rUBjP+Jg9kQsXCsrIiYl
         kvdHKnkUFuKAF51usqRPb3FB+WAkJ3NKop0XNHNG/HonC/IukIGGjt2gWOzW3Yk3+aB6
         L0qwyZria23XEQBZ4ZV4Z9dI8tXdlsT47zwq42PF50XnSulcKL9WAjNKbSUvqekGHt4W
         z3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E44zAySPmawq+qLbsH9q5xt7WGcYQXLEVwBfYO570wQ=;
        b=lND6xL7g71PdcsK3mMbE0uzkfwLdkpVoREIfZCr8ZkEbUjApHpgrt4kUp+zEBW9HWf
         fEySt2nogyRjBGEdt0/lcnVcoJLhgLEjUHVv7qv3Eqp0IuIF1n4LYmySnXzmUwAGHwLZ
         Pqw6+Y07W79DkUlPeKJLwoAWlgNEdaI5LzkjHNCybD68LM9Qa9V1xUXZksvdCBnkQtP0
         31BLkrmDtJCeRwdmgbrCxdAoSee/rJmKkcGxugtLg1ufl+EDRRXedrLuxqaZIqZ3RZ6D
         q0ayt2deFd95acIRbs04UoMV7DBxeKi4WEoyO2h1iET5YY75U/afZMMaOcFA5tF5/lK4
         U2SA==
X-Gm-Message-State: AOAM531aq0FHYuwwOmAMTTcvKLrHdfpooiQOVCH+laPgT1sUzlEhbHbA
        LeHiONN5YhilT8UjUhq+tZNcxw==
X-Google-Smtp-Source: ABdhPJxfRN1i2cfpOCiFfFc/Pvr9V9HGsIKuzuadSde/yfja7cXq3h8iYKz20Us7PK8EV5XXi1JVGA==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr1557572wmf.37.1604699401085;
        Fri, 06 Nov 2020 13:50:01 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/19] drm/radeon/atom: Move prototype into shared location
Date:   Fri,  6 Nov 2020 21:49:36 +0000
Message-Id: <20201106214949.2042120-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both source files include atom.h, which seems like a reasonable
location to place an atom based function into.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_atombios.c:1791:6: warning: no previous prototype for ‘radeon_atom_get_tv_timings’ [-Wmissing-prototypes]
 1791 | bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/atom.h              | 6 ++++++
 drivers/gpu/drm/radeon/atombios_encoders.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.h b/drivers/gpu/drm/radeon/atom.h
index 1bf06c91cd959..cb93b83114dbe 100644
--- a/drivers/gpu/drm/radeon/atom.h
+++ b/drivers/gpu/drm/radeon/atom.h
@@ -154,6 +154,12 @@ bool atom_parse_data_header(struct atom_context *ctx, int index, uint16_t *size,
 bool atom_parse_cmd_header(struct atom_context *ctx, int index,
 			   uint8_t *frev, uint8_t *crev);
 int atom_allocate_fb_scratch(struct atom_context *ctx);
+
+struct drm_display_mode;
+struct radeon_device;
+bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
+				struct drm_display_mode *mode);
+
 #include "atom-types.h"
 #include "atombios.h"
 #include "ObjectID.h"
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index cc5ee1b3af84f..85f903caf12e1 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -296,10 +296,6 @@ static void radeon_atom_backlight_exit(struct radeon_encoder *encoder)
 
 #endif
 
-/* evil but including atombios.h is much worse */
-bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
-				struct drm_display_mode *mode);
-
 static bool radeon_atom_mode_fixup(struct drm_encoder *encoder,
 				   const struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
-- 
2.25.1

