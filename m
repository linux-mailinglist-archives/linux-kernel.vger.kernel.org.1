Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6852ADF91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbgKJTcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbgKJTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:45 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA46C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so13991867wrf.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1oV/yz5N1u2UPD8o5d2gv6s+B1t/DAHhi2RWlvWz744=;
        b=T2jBka9sse1tlWAYyyPE0QhmK8In9KttLjXZkzSHP9HTQh59UL/40LMvsaOD8atmkQ
         /TWk7zYAzAYQbisCj8BpF5ksv9i3B3BAXUWERHj21dPwub2Q7tGUgwLrjp+JfQo19C/D
         Bp1jE0K8gdn1LOpxjSXJQEyXczZv6Ec/nY+xktwe7ZVo8GlXpVLJQo6CTT9sNNG5q3Ou
         ia0p140uu4rC10i6nWaETjRb05b5JpONzJmbjMRlEA2UuhS7HzIxDW3SnL9hsE3z9dHC
         bh7MHMAS6I7Mj6xULAFQpElPU6/t3cB12HJ4Xt018r6BzPBjeIIigiRopDEGBzir8ssq
         Twzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1oV/yz5N1u2UPD8o5d2gv6s+B1t/DAHhi2RWlvWz744=;
        b=LPMvFoXQGeMkzMDiZBnQIqG4Uopajt05AX23HXucq7T+6pv3n2DIy48kGQcyjuzOVY
         4WKEj79Rgs22jF3M7SsCZkwE/+kkSuQFyhEOYMhSWpmo/dCsSTM7V+YOG5gVQaTF5pHu
         yp9pCk46q3wbyrYEvVOz55PM7W+bfS6e1+nwyQocoWD1wLoq0Zqyq05m20HU40KsMELC
         RSWjSZKrEQsJIrUumukVgsSFUStueDu4npT9KG1gLj5dcP4PzKh3SQS1CVOIW9H91KfU
         U9rsBx2u1ih7hgaxAU/Kow/RemptZp3WZYZEhgC+wnYiWVCLb6J5ZlAN62yOsKBQ8L4y
         Dc6A==
X-Gm-Message-State: AOAM532EVrcTF6DeY9Rf3FNFnyho2F71ZCld6kHncFBj+Gu3kV4KBgDb
        86nab2Flh2brU1hoSrqw/lqXaQ==
X-Google-Smtp-Source: ABdhPJza9cNXQDZ5z1aM5oaSqmTMzXWomRhvZd26Y5a0XS2bh4Rl+GpTXDTVDzeWHgzF+ygUTPg1Rw==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr11340915wrp.290.1605036702401;
        Tue, 10 Nov 2020 11:31:42 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 21/30] drm/radeon/atom: Move 'radeon_atom_hw_i2c_*()'s prototypes into shared header
Date:   Tue, 10 Nov 2020 19:31:03 +0000
Message-Id: <20201110193112.988999-22-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/atombios_i2c.c:100:5: warning: no previous prototype for ‘radeon_atom_hw_i2c_xfer’ [-Wmissing-prototypes]
 100 | int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
 | ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/atombios_i2c.c:150:5: warning: no previous prototype for ‘radeon_atom_hw_i2c_func’ [-Wmissing-prototypes]
 150 | u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap)
 | ^~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/atom.h       | 6 ++++++
 drivers/gpu/drm/radeon/radeon_i2c.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.h b/drivers/gpu/drm/radeon/atom.h
index cb93b83114dbe..efc05e33b220c 100644
--- a/drivers/gpu/drm/radeon/atom.h
+++ b/drivers/gpu/drm/radeon/atom.h
@@ -160,6 +160,12 @@ struct radeon_device;
 bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
 				struct drm_display_mode *mode);
 
+struct i2c_msg;
+struct i2c_adapter;
+int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
+			    struct i2c_msg *msgs, int num);
+u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
+
 #include "atom-types.h"
 #include "atombios.h"
 #include "ObjectID.h"
diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index aa61b3cb4049c..e543d993f73ee 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -34,10 +34,6 @@
 #include "radeon.h"
 #include "atom.h"
 
-extern int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
-				   struct i2c_msg *msgs, int num);
-extern u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
-
 bool radeon_ddc_probe(struct radeon_connector *radeon_connector, bool use_aux)
 {
 	u8 out = 0x0;
-- 
2.25.1

