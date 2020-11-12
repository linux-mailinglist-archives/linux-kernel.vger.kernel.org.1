Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B802B0D45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKLTBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgKLTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:24 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E1C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:24 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h62so6442003wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dpuU5BsT173A/3X/IKJ/RVPURrpJEnyWKPfCisq40U=;
        b=P90TJGWFxXWKZTP2scYCOfsqY/wKKa1+4kmWdDdolBtQxz0OR7Cfzjww0kbTQK2sc0
         i/KmQ4x3Jjf7hxdCJ3q13Y20iRA6ny8Q7mDh56qfaOxSaJFUWgbO9uJAj+S0XyphglZy
         DdBOPZhizxJ8aLSKYE3zJRVnQd0q5UsQOsgDhBkLImip3LKE+ulUHyhF1doGJLW+fmh9
         4vf8a14EaZ+W7Z4+Ja0XXbTq+ZEz/kqs3jO/mDp1S8LdLLfmUsCh64+05tmYXC8HtGZZ
         6MRCTA/pKLDAP9iWxdL03koe+A1DgD9h1sogY76kYlQkXW6oh1ZXKG0kHiw75wamAA0f
         xpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dpuU5BsT173A/3X/IKJ/RVPURrpJEnyWKPfCisq40U=;
        b=dL/hkcg+vc840CYvhr1WjJe244rfaWHGCD3zaOWW/67rh+6uu1uvOvfwXPMu8vz+OC
         VUYQMIWILRsFVBtFiuw3bi33gIY/iwjpgEf9Ga3NWoWbLityPVpk9WeAAeE1ZcQlqkJH
         AFdyLSBxzwPqXplZNw3Nn0dAvUOH9l3T9brisLTkxqpo9ibKkVCq7b+tQDUavHNjUujU
         HibxulM+9f0Jk3tBPL8Yr3Rtk4F3kvAj2EVXuFNI/OQGa29JErcPi3Yq/65RwkIoTVci
         pd7OQbrSnMcikTQpdSdc22enBwBQ30SH+UMt8JkdOQm1VtJHn4ECtTgkUi/67HD37rPR
         qTnQ==
X-Gm-Message-State: AOAM532O111mO54u1h8r/eZ1VoDJEs/vusQAemSA5cMF9/0UxaIlbauq
        9k3qRpgY9vFmaueFYjAHPwcmrA==
X-Google-Smtp-Source: ABdhPJxyTyXOcBnokU+FKrwvxeEWpZyZ9iz/opvwSBv4Gzg0U520Kpk6FVNjh+PeLg1jlpD6FHvNxg==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr1108394wma.86.1605207681995;
        Thu, 12 Nov 2020 11:01:21 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/30] drm/vc4/vc4_v3d: Demote non-conformant kernel-doc headers
Date:   Thu, 12 Nov 2020 19:00:27 +0000
Message-Id: <20201112190039.2785914-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vc4/vc4_v3d.c:131: warning: Function parameter or member 'vc4' not described in 'vc4_v3d_pm_get'
 drivers/gpu/drm/vc4/vc4_v3d.c:231: warning: Function parameter or member 'vc4' not described in 'bin_bo_alloc'

Cc: Eric Anholt <eric@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 65d0dac69b0bc..73d63d72575b0 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -122,7 +122,7 @@ static int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
 	return 0;
 }
 
-/**
+/*
  * Wraps pm_runtime_get_sync() in a refcount, so that we can reliably
  * get the pm_runtime refcount to 0 in vc4_reset().
  */
@@ -205,7 +205,7 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 	return -ENOMEM;
 }
 
-/**
+/*
  * bin_bo_alloc() - allocates the memory that will be used for
  * tile binning.
  *
-- 
2.25.1

