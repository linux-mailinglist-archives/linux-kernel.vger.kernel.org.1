Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C64D2A818B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgKEOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgKEOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E83C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:36 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so2104688wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlbFjA1pCKxkPmsP5EtFe6iKvE9D/xy8RlK3r75nIgE=;
        b=KBwJ7sSzoNNlJeM2LSJvEoNx0u2IjzwVfbxJtvfnkAyQneAXifgDuipGbxyIPmXaZc
         IUQ0H64STjSyAboATFDUOeOxFj6TCu5DASRAQ4SdaGzYak9HoVRmtzxjvDqzj+MZH0Bk
         t8RKh93xOdbfXIhI1vpPW60dy5WYFwmtX4VTRqj6MCUtk3A+65lrPPRg+8i/bwjhotQM
         nyn5BKBKMuXnrL0WNM5fhvAEsRhXCL0GyeTriYJFQgcUcmscWLQAavQIIUOUwxk06tp1
         hZw6MU7gG88Rf8Zm3+TWjMjYr42iNeNjeSJxmD0ZHV+jNEaG4k4r5e1Qt6BZEe+fmsHz
         0r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlbFjA1pCKxkPmsP5EtFe6iKvE9D/xy8RlK3r75nIgE=;
        b=BZJADHU2ae5mN+pB6hq0Z3nu33H3+FBXUeiMLsayLKUnxz9ll3xtm3fDtHczdw/Jmy
         pc3AvNYu6asO8Y3CunnooZKq2keAcltcBUiE7gPzC5wL6zRH6nkSdkxJ/8xe9pqLGO1E
         qP0mRIQEwsj8WRliE7OBKH3SgL2ttXi/RaXLI1QaRevSieXECjwr1eG8tnePRrs6XlmX
         kderBYZEFn4M+Qu4c2DjqS0kjFb48T8ryqworlRKlkuC3P7zmlWyWNAObJtuYJJyXTPw
         wYYtV7c0+idoNyoEhaXFGuZxkEVE0nAixsP6dHLzeSj4xmwlZf3cFLmeFRcT25SpTZsd
         Aftg==
X-Gm-Message-State: AOAM530es9XDDCm8VXgH791ol7Tr496lBLi4RWeFR5XZPxJHSHCNwNia
        dS26x3M1KAv8zfQMuvDtOlZrOw==
X-Google-Smtp-Source: ABdhPJzG5CGbpR/TwJSrNO2WIuVUgfK/JaOAwXwNTRUH+y0L82UrvdrxUj9hc+98hlc1aSXdNIfIyg==
X-Received: by 2002:adf:e443:: with SMTP id t3mr3470794wrm.14.1604587955662;
        Thu, 05 Nov 2020 06:52:35 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/19] gpu: drm: radeon: radeon_device: Fix a bunch of kernel-doc misdemeanours
Date:   Thu,  5 Nov 2020 14:45:15 +0000
Message-Id: <20201105144517.1826692-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Demote non-conformant headers
 - Fix misnaming issues
 - Rename labels with identical names
 - Remove incorrect descriptions

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_device.c:637:6: warning: no previous prototype for ‘radeon_device_is_virtual’ [-Wmissing-prototypes]
 drivers/gpu/drm/radeon/radeon_device.c:552: warning: duplicate section name 'Note'
 drivers/gpu/drm/radeon/radeon_device.c:556: warning: duplicate section name 'Note'
 drivers/gpu/drm/radeon/radeon_device.c:561: warning: duplicate section name 'Note'
 drivers/gpu/drm/radeon/radeon_device.c:564: warning: duplicate section name 'Note'
 drivers/gpu/drm/radeon/radeon_device.c:1106: warning: Function parameter or member 'family' not described in 'radeon_gart_size_auto'
 drivers/gpu/drm/radeon/radeon_device.c:1291: warning: Function parameter or member 'ddev' not described in 'radeon_device_init'
 drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter or member 'dev' not described in 'radeon_suspend_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter or member 'suspend' not described in 'radeon_suspend_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter or member 'fbcon' not described in 'radeon_suspend_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter or member 'freeze' not described in 'radeon_suspend_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Excess function parameter 'pdev' description in 'radeon_suspend_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Excess function parameter 'state' description in 'radeon_suspend_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Function parameter or member 'dev' not described in 'radeon_resume_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Function parameter or member 'resume' not described in 'radeon_resume_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Function parameter or member 'fbcon' not described in 'radeon_resume_kms'
 drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Excess function parameter 'pdev' description in 'radeon_resume_kms'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_device.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 266e3cbbd09bd..7f384ffe848a7 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -544,21 +544,21 @@ int radeon_wb_init(struct radeon_device *rdev)
  * Note: GTT start, end, size should be initialized before calling this
  * function on AGP platform.
  *
- * Note: We don't explicitly enforce VRAM start to be aligned on VRAM size,
+ * Note 1: We don't explicitly enforce VRAM start to be aligned on VRAM size,
  * this shouldn't be a problem as we are using the PCI aperture as a reference.
  * Otherwise this would be needed for rv280, all r3xx, and all r4xx, but
  * not IGP.
  *
- * Note: we use mc_vram_size as on some board we need to program the mc to
+ * Note 2: we use mc_vram_size as on some board we need to program the mc to
  * cover the whole aperture even if VRAM size is inferior to aperture size
  * Novell bug 204882 + along with lots of ubuntu ones
  *
- * Note: when limiting vram it's safe to overwritte real_vram_size because
+ * Note 3: when limiting vram it's safe to overwritte real_vram_size because
  * we are not in case where real_vram_size is inferior to mc_vram_size (ie
  * note afected by bogus hw of Novell bug 204882 + along with lots of ubuntu
  * ones)
  *
- * Note: IGP TOM addr should be the same as the aperture addr, we don't
+ * Note 4: IGP TOM addr should be the same as the aperture addr, we don't
  * explicitly check for that thought.
  *
  * FIXME: when reducing VRAM size align new size on power of 2.
@@ -627,7 +627,7 @@ void radeon_gtt_location(struct radeon_device *rdev, struct radeon_mc *mc)
  * GPU helpers function.
  */
 
-/**
+/*
  * radeon_device_is_virtual - check if we are running is a virtual environment
  *
  * Check if the asic has been passed through to a VM (all asics).
@@ -1100,7 +1100,7 @@ static bool radeon_check_pot_argument(int arg)
 /**
  * Determine a sensible default GART size according to ASIC family.
  *
- * @family ASIC family name
+ * @family: ASIC family name
  */
 static int radeon_gart_size_auto(enum radeon_family family)
 {
@@ -1276,7 +1276,7 @@ static const struct vga_switcheroo_client_ops radeon_switcheroo_ops = {
  * radeon_device_init - initialize the driver
  *
  * @rdev: radeon_device pointer
- * @pdev: drm dev pointer
+ * @ddev: drm dev pointer
  * @pdev: pci dev pointer
  * @flags: driver flags
  *
@@ -1550,12 +1550,9 @@ void radeon_device_fini(struct radeon_device *rdev)
 /*
  * Suspend & resume.
  */
-/**
+/*
  * radeon_suspend_kms - initiate device suspend
  *
- * @pdev: drm dev pointer
- * @state: suspend state
- *
  * Puts the hw in the suspend state (all asics).
  * Returns 0 for success or an error on failure.
  * Called at driver suspend.
@@ -1656,11 +1653,9 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 	return 0;
 }
 
-/**
+/*
  * radeon_resume_kms - initiate device resume
  *
- * @pdev: drm dev pointer
- *
  * Bring the hw back to operating state (all asics).
  * Returns 0 for success or an error on failure.
  * Called at driver resume.
-- 
2.25.1

