Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF42AC6F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgKIVTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731246AbgKIVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:25 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E2C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:25 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so8861258wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1FKv2blGXbscAB7wKDEc1cac5g15gUeFIAgqfSJF6w=;
        b=FioJyxPLeJAUtobkLDaKIkmME9xBKEy47Q9FG/W/6yyZv2S0N5LgGTxjipqJH0Ic7z
         7O7aoSIH0b6KWnTCeiLyOlX4PzanvzFhWVpR5qoa0amSEfrtzUxepB6fY5WLRJ5Jfnzm
         c2dNShFGlyjTrh/hS4rsX1zH+8qYiS6WOQ67brpZ7qzIgUOHVvSwuWENmC9jIFj645MA
         Xb33uxmCmy6o2SGrzeyUwHROne1dbDp9fNKNXUfk9+yFZ1dsf8gX3f4tLB/9FuW590/1
         VLciwVZw8Kh8nvtdTJ2ejXFLbWRrQ68+EyhhQ4bPpezIErzIqIbGGJ9GOki4QtKA/G8m
         tiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1FKv2blGXbscAB7wKDEc1cac5g15gUeFIAgqfSJF6w=;
        b=cS9dK/YlhW1lZnF8rqXNMcH1Dl9TgN25ZUu+TUQ0SjXQZwab7rIsoWCpchwH4slHBg
         YhVSIbtwG5zOA2ymNjX/ra7M148jMhPy13hGGtILuct0w2iz+VWlyL0eDetqgNI6dlUc
         T78xsev4B8eczKG7SA05CJ+gf/myHt+ehTye5gQk+tpXNjHJAJTL+CcGlTESAU2VdBIh
         HvGEdBNnBrnmYbcybERxRguWzNj2Ek6K0jXBjCliokboJH7TI9IW/X7MxB/RRAvr44f3
         NxkuS4kRImY29FqGFJsZcIkQ4k+C7gsm0XI6ZnNmRKSWcrfKhUwEiEZFABvJZ+gCu7qH
         zYMQ==
X-Gm-Message-State: AOAM532kLv09GOA65AoWdPJsxvPwDIU1gNagNsRB+smUDswXd6rGUbFy
        /+bviOvyatUe9GXAKpNQqSJOsg==
X-Google-Smtp-Source: ABdhPJzNnYeInLP+RtXqqmtawFUWK07GI7u6mpPZ0kizGCkgqhol2+QTYdIKxwXXMGpk9hHbdCma7w==
X-Received: by 2002:adf:f546:: with SMTP id j6mr6858247wrp.219.1604956763980;
        Mon, 09 Nov 2020 13:19:23 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/20] drm/radeon/radeon_i2c: Remove pointless function header
Date:   Mon,  9 Nov 2020 21:18:43 +0000
Message-Id: <20201109211855.3340030-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_i2c.c:46: warning: Function parameter or member 'radeon_connector' not described in 'radeon_ddc_probe'
 drivers/gpu/drm/radeon/radeon_i2c.c:46: warning: Function parameter or member 'use_aux' not described in 'radeon_ddc_probe'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index 545e31e6cc3a9..aa61b3cb4049c 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -38,10 +38,6 @@ extern int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
 				   struct i2c_msg *msgs, int num);
 extern u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
 
-/**
- * radeon_ddc_probe
- *
- */
 bool radeon_ddc_probe(struct radeon_connector *radeon_connector, bool use_aux)
 {
 	u8 out = 0x0;
-- 
2.25.1

