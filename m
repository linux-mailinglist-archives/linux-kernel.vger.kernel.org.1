Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C92C564E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbgKZNny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390707AbgKZNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:44 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4928EC061A47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:43 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so2197138wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLqbaHF4oQ5Kpx8U3OblV0PJbsOkOQQuGTnjvNzXmds=;
        b=zEVwjuFPYeI2CWymPGhLbmOeKMvU5W3/wdholUcUe5f/F7/8WIFuy6M4mCe2yTvJnf
         pBRES8hLWfSY4jRjS/Md271YTIjdVoLHGh+8kdCF9wNzy3YXwC+HOAfM3nibIIdNfowt
         i1TVSkH6uoteGEpwYjcBNUzX+ypeYJFKJsoLmaHNK9p5XgVq9YNMUv/1sxtKLLNokI4N
         WT4nfVAmbqBpmgp5DoptVNYdwvr3XqjgwDXKR8Vr0Y7zTdZBDzO8E4eL9iCyIsXjkQ/+
         AacXFu31oboKBxp6l7xi9WFI+noLXhM6aoe0OJrYzxVqCbccmnQ28laoCs8P71Ehozuk
         xvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLqbaHF4oQ5Kpx8U3OblV0PJbsOkOQQuGTnjvNzXmds=;
        b=ZTs6a8EEj+hziH0NzvM1CreooD6vSwQbPHYxHNp0vOT5dzp53v5mUO/Es+hvl89sFS
         fYVh7RuMiCT2IaJlvpp4MH7OBkIkAlQneBBEL/I2SBlO6dZ80fYwZ5ZYy6+dpPxG+Gf8
         uX+O3RtJXf69JlccHFhsgKerr0WcGzQ9dEpRuknJ6uUgitIcttKCved6YkSqi2psXV7e
         5qDxqXsTtY1wG3J3dRsXkXCk1tL5EZnhSNYk8bP4kS0lAY8RpTpgPVCEs0sn0d4Cnw6Z
         cGIX0cfJy7OmF19Er9CEvDTVQxD6KSA4DIlKe89MJECGjPPe3klUhVViBtacUJ/YCNBF
         SeAA==
X-Gm-Message-State: AOAM531bp2FKDhHQ7GL/1gnbXpn6NCUeTLvPwwHeOkA/l3obg8f/Gjz+
        r+ySDSK+UsrjIBX4ad/dcgXnfw==
X-Google-Smtp-Source: ABdhPJxmBjpBm7+d3exEEq0cH0WG4UWwwz1Febmm2eAsCGEAZgFo/aK9XZK0D10TkghDYILLIkq8XA==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr3423753wmd.45.1606398221973;
        Thu, 26 Nov 2020 05:43:41 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amd/display/dc/basics/fixpt31_32: Remove unused variable 'dc_fixpt_pi'
Date:   Thu, 26 Nov 2020 13:42:39 +0000
Message-Id: <20201126134240.3214176-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt31_32.c:29:32: warning: ‘dc_fixpt_pi’ defined but not used [-Wunused-const-variable=]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 59f37563704ad..1726bdf89bae8 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -26,7 +26,6 @@
 #include "dm_services.h"
 #include "include/fixed31_32.h"
 
-static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
 static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
 static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
 static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
-- 
2.25.1

