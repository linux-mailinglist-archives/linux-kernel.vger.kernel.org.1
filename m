Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC022F83E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbhAOSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388563AbhAOSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A92C0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a12so10186503wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5b57SoAxHtBE8fuD7PasHO1SZ3n/WAQuB51kpZs09g=;
        b=rriSdpC5fDLxemjS3Am2r2KffU43TkGCeJu9m8OdsMcm8y/ebVSkzBUDFHfnkwR4uB
         aSwnLRROSDfnEeTaY2WBCoa7R1qbBcx5INFxovhPXjtBX5DnbVU1v+mupaoFEIt0m+sy
         DJZ3y71XrUAQoaZSNILkrHfh/zcD1yUmuyRku1oNv8+BpPJgMtik8tWYS1sf28+mQxoL
         K0gzlkodsZGeISrc+POlP3bp9lhge6TCYbk7XyCAKCqpxd1uhkUSuvrpduXACfSPE5Xs
         7Wp7mczt8u7BWMZYdq05c11wjz4a7cF4k2vFYRa5/EPSZ6cnb2CwCXkcenb8rtowZ5nZ
         NC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5b57SoAxHtBE8fuD7PasHO1SZ3n/WAQuB51kpZs09g=;
        b=XPSPhy5j0dqFQTnFvs4A5DHT/kg543R4cQFu/mjmzYcM0nTJCw6hM5PSJC0N0WIVkh
         K+XlJrbLbp2DS3V+SpCMNv3K+2t0M8Cpev3bTpH8bkkHFxZPpXR48xSDKfPT3xiX93/0
         b8IEhJDd5HyQc6pLkH9FqnDkFgX6C37rxYvC5CfwXDfpIv7w4PkzR5VW0rZbP3a9WGJ1
         OcV1tsUbELxcN5SxrVe8fMyPageFjV8pC72Htx5tSS9zv08cIYiYZbI+NPHwfVcTVNd+
         Wvr6odtZT+TPKD/CJpSzlBmzfjVcsQGdhFhfQYS+L9YpYxHXm5OFUI7CpILoC/sQcqrC
         KgDw==
X-Gm-Message-State: AOAM53099nuV5uOM98QBY3W6xrjxRunokqIZAXFxoQJPso4WVPPVb1wf
        A8h3FcVdkPmUtS07vXKsg/kHrg==
X-Google-Smtp-Source: ABdhPJyvzvw/m3xAKhEScihwt0ijVEjC0hHVLK7eHUfHVxiZ87NT0kkWWVNCXymnBq6TGY1atX1JMw==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr14243233wrn.347.1610734595212;
        Fri, 15 Jan 2021 10:16:35 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, jim liu <jim.liu@intel.com>,
        Jackie Li <yaodong.li@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 21/29] drm/gma500/mdfld_dsi_output: Demote a couple of kernel-doc formatting abuses
Date:   Fri, 15 Jan 2021 18:15:53 +0000
Message-Id: <20210115181601.3432599-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/mdfld_dsi_output.c:71: warning: Function parameter or member 'dev' not described in 'mdfld_dsi_gen_fifo_ready'
 drivers/gpu/drm/gma500/mdfld_dsi_output.c:71: warning: Function parameter or member 'gen_fifo_stat_reg' not described in 'mdfld_dsi_gen_fifo_ready'
 drivers/gpu/drm/gma500/mdfld_dsi_output.c:71: warning: Function parameter or member 'fifo_stat' not described in 'mdfld_dsi_gen_fifo_ready'
 drivers/gpu/drm/gma500/mdfld_dsi_output.c:95: warning: Function parameter or member 'dsi_config' not described in 'mdfld_dsi_brightness_init'
 drivers/gpu/drm/gma500/mdfld_dsi_output.c:95: warning: Function parameter or member 'pipe' not described in 'mdfld_dsi_brightness_init'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: jim liu <jim.liu@intel.com>
Cc: Jackie Li <yaodong.li@intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/mdfld_dsi_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
index 4aab76613bd9e..24105f45c1c4b 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -63,7 +63,7 @@ static int __init parse_LABC_control(char *arg)
 early_param("LABC", parse_LABC_control);
 #endif
 
-/**
+/*
  * Check and see if the generic control or data buffer is empty and ready.
  */
 void mdfld_dsi_gen_fifo_ready(struct drm_device *dev, u32 gen_fifo_stat_reg,
@@ -85,7 +85,7 @@ void mdfld_dsi_gen_fifo_ready(struct drm_device *dev, u32 gen_fifo_stat_reg,
 					gen_fifo_stat_reg);
 }
 
-/**
+/*
  * Manage the DSI MIPI keyboard and display brightness.
  * FIXME: this is exported to OSPM code. should work out an specific
  * display interface to OSPM.
-- 
2.25.1

