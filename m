Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7512F83DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbhAOSRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbhAOSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C5C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v184so4178578wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ist2qaMcFyPJ0b0T5b259LCtzdvkGcAXrLj6GtIUIKA=;
        b=VQCHrIKm7/CTiVE6GNmynsfACZnXKCYS24SYjRRSWQ+0E7tkdGKZR2D8B5JfDmP19u
         Sp7x6uR0JcsH+gX+hBMcorqNaWjt5kkEZWiq1KQ9sX80mKilNN2fcQdYDB0sj0gQdIDM
         xOTymz8SN/aWa8nc0cbTl1fEvoUQazZGZwRF+pIykVYFRwLr4ceFAj0jc00u2CNhRSCa
         nMpG+Pbs+uD4PaxoIBC+uFiuituSY2qRQkU6wEblTpNd45QpRZS5M75KS2r/21r8df35
         p/BYCeY15O9TymDlEFBXeFShpazqpjehgB+1SSBuFRFbRNffl/gyA/2QXw3pZchw9M0n
         Tl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ist2qaMcFyPJ0b0T5b259LCtzdvkGcAXrLj6GtIUIKA=;
        b=GtFzAaLLH0bBICywN5Hg6yTezZ+0M3UtRmjZ6sYwDTWEf8DqgeO7/irVwQBD+V9i0Y
         8S3vzg+VOOb7HWvOC/DJFBfdSdgEb6//yvNfPPlOYReh0XbiFe5RkvWPMld6avC2RWpR
         WQ6nNQLoaymLCqIh0jbxdbIker3+lsOCk3Ujf5/Vre3IIGE5XiJNFELDUQEzF9hUwbDg
         Jmr/F4N9Q9RFIQhf4ND0kMUK3wit4JioVWIuKCJ/ZDDL5OdD8UBm49PU6ykWlsYl+wSi
         +8coS8dTRrSyCaQ4NtYUgDsoiNxZgk1+LJxqT7kjlEkFRq3mEZU02zqJLTQmzhocwvcr
         7Nxw==
X-Gm-Message-State: AOAM531vpyloiGb+e3GhU7pP0QUVSdtLRR84MgABBWHekmBvHjiASLsB
        eXQ18vlOQP+IorWnNde9II0IjQ==
X-Google-Smtp-Source: ABdhPJwsR4sddknZLa7jcLTBaIuE7RjisKawBK3M+o+x1MC/HL2jnakWZ3qsJqRtEF6Kzb7QNJ2M+Q==
X-Received: by 2002:a1c:3206:: with SMTP id y6mr9699299wmy.127.1610734587226;
        Fri, 15 Jan 2021 10:16:27 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 15/29] drm/gma500/cdv_intel_display: Demote kernel-doc abuse in 'cdv_intel_panel_fitter_pipe()'s header
Date:   Fri, 15 Jan 2021 18:15:47 +0000
Message-Id: <20210115181601.3432599-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/cdv_intel_display.c:559: warning: Function parameter or member 'dev' not described in 'cdv_intel_panel_fitter_pipe'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/cdv_intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
index 686385a66167b..5d33022497793 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_display.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
@@ -551,7 +551,7 @@ void cdv_update_wm(struct drm_device *dev, struct drm_crtc *crtc)
 	}
 }
 
-/**
+/*
  * Return the pipe currently connected to the panel fitter,
  * or -1 if the panel fitter is not present or not in use
  */
-- 
2.25.1

