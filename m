Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DC2D7F76
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393396AbgLKTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393808AbgLKTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:33:38 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB1C061794
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:32:58 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so7626616pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yscUIRHphl57WTyf7pGrRDrrRirSs+LIMlStQDJD4h4=;
        b=kib8ptgiRi9Rpdv6SG90FgWZNGMv+QBwMSyvNZEOI+E3xw4yMRam/Hkhl7jak8VM72
         lb1F9B1ldb8e7tWPyBs12wNTH0gBXWoFF/yigXwSKKZ/AKcfSjcn5zjh/9/rZHn9H+Zy
         AY4x4Gq6kAP1fW1GVteqh7TPmL44K2LUkTwIhGOXkxKqi2tytAJaquScpcjqbcZ9d6cA
         +hX0zfxK5QWFfeiqaHZ7IDXNF4N0TGPBBWp82y9AtqO3OZek9Y9LzqfO3dZLhOLWo6cL
         fvwXPjSTGhr7f9KQhBPCljyMCuxs1IeXYDrP6ZcAKRFvmyBLUDgMl+/MOpcVR6EnLKF5
         st0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yscUIRHphl57WTyf7pGrRDrrRirSs+LIMlStQDJD4h4=;
        b=FRcR6ANkqkhqgRHuwydjxNx8LB/+IvLHHWzUi0bCMUiIO7ZuTjzDrNpnwry8m729XO
         VI63AOawuy8H4fzrbsQBVwWUl/fFSkvO/ebMY8hN0ampiHFaVizNlSZoladXVUpyU9xF
         GgPz6ZV1ZGtTaYQRVQtMukC18WZWrdRorQE/p2tt5Rt13u7BWb7eKI9znO1Y27g+chAM
         R2Ng9IfZL7p0IDfM7QSBZAbPVx83NufJgiXYKcfWILqqyF5HtPdI4ZQooRHb2OiX8u9D
         K6tPAN/RHYU+usyvmyAPeyXbC73XpZw+vrIa7GlDJeepgIPAmiNHoq0T9VjZ7KDjJMqU
         ifZA==
X-Gm-Message-State: AOAM532duHBsxJ7KteA1ECGPvbFf7JqfgFe8/IvRdaXO2K2QMl4iU9qx
        C3HYfed5UI0z+qAWon7DuCY=
X-Google-Smtp-Source: ABdhPJwNoprX3DSMJJo2m05JcKw/NAnRSHHEbiQfyblS4U00fTfoqZ+1MngiJ6ryWSsX0IcYHDITLA==
X-Received: by 2002:a63:e849:: with SMTP id a9mr13179684pgk.300.1607715178001;
        Fri, 11 Dec 2020 11:32:58 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.87.107])
        by smtp.gmail.com with ESMTPSA id z126sm10934993pfz.120.2020.12.11.11.32.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 11:32:57 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        Rodrigo.Siqueira@amd.com, aurabindo.pillai@amd.com,
        stylon.wang@amd.com, eryk.brol@amd.com, hersenxs.wu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm/amd/display: Fixed kernel test robot warning
Date:   Sat, 12 Dec 2020 01:02:36 +0530
Message-Id: <1607715156-4258-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5349:5:
warning: no previous prototype for 'amdgpu_dm_crtc_atomic_set_property'
[-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5349:5:
warning: no previous prototype for function
'amdgpu_dm_crtc_atomic_set_property' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5373:5:
warning: no previous prototype for 'amdgpu_dm_crtc_atomic_get_property'
[-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5373:5:
warning: no previous prototype for function
'amdgpu_dm_crtc_atomic_get_property' [-Wmissing-prototypes]

As these functions are only used inside amdgpu_dm.c, these can be
made static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 313501c..e6d069d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5328,7 +5328,7 @@ static void dm_crtc_reset_state(struct drm_crtc *crtc)
 }
 
 #ifdef CONFIG_DEBUG_FS
-int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
+static int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
 					    struct drm_crtc_state *crtc_state,
 					    struct drm_property *property,
 					    uint64_t val)
@@ -5352,7 +5352,7 @@ int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
 	return 0;
 }
 
-int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
+static int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
 					    const struct drm_crtc_state *state,
 					    struct drm_property *property,
 					    uint64_t *val)
-- 
1.9.1

