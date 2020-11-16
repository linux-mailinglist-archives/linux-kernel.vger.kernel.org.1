Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB752B4E40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgKPRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387864AbgKPRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA13C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so19636987wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dpuU5BsT173A/3X/IKJ/RVPURrpJEnyWKPfCisq40U=;
        b=R0c1VYZ4uhe952lSIq65QcDIkw0VaRxMNF3r12FkqKkCKP3mYeJAIhiOq132YdsaZ8
         ZH1GB3ItUBwsx/qcAf9v2JrJgYX2Gx3ammOyg9wlPC9zFR8X6irCtvs/vZl47wPv0AyT
         YRC9sdRNT3EwxeYAFc0qhB+Ef5RwwBinY99ti9yIsaYI822N9aAqQooU3JHaEL+9n+HP
         Q6+FwmvbhSlkAM41JSELFusyxho3UvHUPX33fxH9hTxkXEMo04wDtOYDTQNWDl0I4ZK0
         i0rj0ygI3EsYcYDEq+VF1Jy8Zd5CUxH6BCXECjSvOmwafl3PI6R0BTpY9mocgCRHPt49
         49mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dpuU5BsT173A/3X/IKJ/RVPURrpJEnyWKPfCisq40U=;
        b=P+3rQ0Ruv3k3sr8sTakAN+DYymiELeRM9pun6VBi01ZcX1LpGgQMGbEFK990mH7oX/
         TX4oNuDxyx8QDYOC2/1tlD7Juy5nOS/zT71rKhQyqp5JtTAFBGmZCsCf6saiER46DGrH
         NeAgKriil+9iDKyCv6hZAjfwM9AumGRDpu66OEpRgtxDrbQ/muCYJEaslOic5HJBD1f+
         3G8iRr3fFhFk67UyCExT3QTkpT9ciVCWoIfp1gSCNMocru5Y9SVXkvnexgVnI5oMd/lF
         mywPl+dKF1VKfwvklmxCD3mvaOyaL94nC05mZ7mt3awmuq/KCb6HlX38bY6S67uZY6hG
         rq4w==
X-Gm-Message-State: AOAM532nEUbWkQZ4rCTveWI4vrHHOf4XSQpr/5nTKmsOkQnlzhKHYh1k
        aaKe9JasIPDK024ioo5AFkjKTA==
X-Google-Smtp-Source: ABdhPJxtmaWM3VKZa7T15xSrO7rUuQXUBkW8QqK89gWx3Yq36M767nEaAOZciDjUhOSQTWtTeD/Fcw==
X-Received: by 2002:adf:c847:: with SMTP id e7mr20667633wrh.346.1605548535413;
        Mon, 16 Nov 2020 09:42:15 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 39/42] drm/vc4/vc4_v3d: Demote non-conformant kernel-doc headers
Date:   Mon, 16 Nov 2020 17:41:09 +0000
Message-Id: <20201116174112.1833368-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

