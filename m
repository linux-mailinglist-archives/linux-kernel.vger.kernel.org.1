Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C054D2C5650
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390958AbgKZNn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390702AbgKZNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00002C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:41 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so2216290wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VB1b8+HX0cMDaWmJBmE+LGhIQvSkQPR66e8ggHq+N+Q=;
        b=XxZ37GB0KpmVxrU9vwF7H6yWe5kLeflzs8gZYUkJvmzO75EMKFpjikfiFkRATr+PYk
         xVJsFJ8MlCX7JEFQF5EH+wxZjeAR6AAKMAUe6A4slFX4FgCiHh2yM5zwqB353KB4oqIw
         X+P/pOW+yAy8nskR5vatXd4YkKtooeYl/csb9hoaemLg2DfJWcDczneVuo4zN74yPihy
         YHY5rS7Y3S7UxJ3B0lUy5sQuezOiOmNeiqulnV8BrL0UbUNcXRnXgAOPNUM02JooqAMz
         /LCvBZB7hD1p2fkaY3JKLbaUoBbRbDEC124el020n/q/0Ochw15abcX9sdoU+nZTOqos
         6Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VB1b8+HX0cMDaWmJBmE+LGhIQvSkQPR66e8ggHq+N+Q=;
        b=ekop75x457j+zFdoikfr6LjbZWYIHxnWmblw5OkuHCRl0vGpimeRM3sqn8aHZzFUNO
         Tz6xqMVHXuoaG+6KZkLs31Y3Lt/sGUs/bnkbVLs6UaUDJqNCqiFIbFNDPLtjoVGfLqjv
         qxUFfvU2YGILrTsZx/f1+QDIiVX06WVzSla4CrLXMd80rsD/SJZLm7ZJSL4PigejDfD6
         Hkz9TiNZSgx9xQ3AnvdBriiv6lajSWhGrhqwRrSPBUtikbcZ/k1IPVjD7xA8Haf919cw
         ScXl9aLS3iKv9yBAxsxDtVuNBzsGZKlGg+BJEROGA54zkrJ9BzkigTj3P3E4RmApL8pr
         +C6w==
X-Gm-Message-State: AOAM532YGVCn70ENg5DdZoo8xk7Mts2TQ/twx014c6RIGDpCIJmYJ+21
        G0NiICyLWjvOE3RQ67OOD4202A==
X-Google-Smtp-Source: ABdhPJwVfHcERYxVhmR4rmdwSIAsofDYdoAklfqWn1euwhxJfD6gxAJllgiYzUpJtVkfnBP6hYWcyQ==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4115578wrq.204.1606398220768;
        Thu, 26 Nov 2020 05:43:40 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:40 -0800 (PST)
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
Subject: [PATCH 38/40] drm/amd/display/dc/basics/conversion: Include header containing our prototypes
Date:   Thu, 26 Nov 2020 13:42:38 +0000
Message-Id: <20201126134240.3214176-39-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:34:10: warning: no previous prototype for ‘fixed_point_to_int_frac’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:81:6: warning: no previous prototype for ‘convert_float_matrix’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/basics/conversion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
index 50b47f11875c9..24ed03d8cda74 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
@@ -24,6 +24,7 @@
  */
 
 #include "dm_services.h"
+#include "conversion.h"
 
 #define DIVIDER 10000
 
-- 
2.25.1

